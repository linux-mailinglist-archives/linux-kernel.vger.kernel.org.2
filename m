Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27667306038
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbhA0PvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:51:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:50346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235666AbhA0PuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:50:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0A4EAE05;
        Wed, 27 Jan 2021 15:49:40 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/4] firmware: Add the support for ZSTD-compressed firmware files
Date:   Wed, 27 Jan 2021 16:49:36 +0100
Message-Id: <20210127154939.13288-2-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127154939.13288-1-tiwai@suse.de>
References: <20210127154939.13288-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the popular demands on ZSTD, here is a patch to add a support
of ZSTD-compressed firmware files via the direct firmware loader.
It's just like XZ-compressed file support, providing a decompressor
with ZSTD.  Since ZSTD API can give the decompression size beforehand,
the code is even simpler than XZ.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/firmware_loader/Kconfig | 21 ++++++--
 drivers/base/firmware_loader/main.c  | 74 ++++++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 5b24f3959255..f5307978927c 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -157,17 +157,28 @@ config FW_LOADER_USER_HELPER_FALLBACK
 
 config FW_LOADER_COMPRESS
 	bool "Enable compressed firmware support"
-	select FW_LOADER_PAGED_BUF
-	select XZ_DEC
 	help
 	  This option enables the support for loading compressed firmware
 	  files. The caller of firmware API receives the decompressed file
 	  content. The compressed file is loaded as a fallback, only after
 	  loading the raw file failed at first.
 
-	  Currently only XZ-compressed files are supported, and they have to
-	  be compressed with either none or crc32 integrity check type (pass
-	  "-C crc32" option to xz command).
+if FW_LOADER_COMPRESS
+config FW_LOADER_COMPRESS_XZ
+	bool "Enable XZ-compressed firmware support"
+	select FW_LOADER_PAGED_BUF
+	select XZ_DEC
+	help
+	  This option adds the support for XZ-compressed files.
+	  The files have to be compressed with either none or crc32
+	  integrity check type (pass "-C crc32" option to xz command).
+
+config FW_LOADER_COMPRESS_ZSTD
+	bool "Enable ZSTD-compressed firmware support"
+	select ZSTD_DECOMPRESS
+	help
+	  This option adds the support for ZSTD-compressed files.
+endif # FW_LOADER_COMPRESS
 
 config FW_CACHE
 	bool "Enable firmware caching during suspend"
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 78355095e00d..71332ed4959d 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -34,6 +34,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/reboot.h>
 #include <linux/security.h>
+#include <linux/zstd.h>
 #include <linux/xz.h>
 
 #include <generated/utsrelease.h>
@@ -362,10 +363,72 @@ int fw_map_paged_buf(struct fw_priv *fw_priv)
 }
 #endif
 
+/*
+ * ZSTD-compressed firmware support
+ */
+#ifdef CONFIG_FW_LOADER_COMPRESS_ZSTD
+static int fw_decompress_zstd(struct device *dev, struct fw_priv *fw_priv,
+			      size_t in_size, const void *in_buffer)
+{
+	size_t len, out_size, workspace_size;
+	void *workspace, *out_buf;
+	ZSTD_DCtx *ctx;
+	int err;
+
+	if (fw_priv->data) {
+		out_size = fw_priv->allocated_size;
+		out_buf = fw_priv->data;
+	} else {
+		out_size = ZSTD_findDecompressedSize(in_buffer, in_size);
+		if (out_size == ZSTD_CONTENTSIZE_UNKNOWN ||
+		    out_size == ZSTD_CONTENTSIZE_ERROR) {
+			dev_dbg(dev, "%s: invalid decompression size\n", __func__);
+			return -EINVAL;
+		}
+		out_buf = vzalloc(out_size);
+		if (!out_buf)
+			return -ENOMEM;
+	}
+
+	workspace_size = ZSTD_DCtxWorkspaceBound();
+	workspace = kvzalloc(workspace_size, GFP_KERNEL);
+	if (!workspace) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	ctx = ZSTD_initDCtx(workspace, workspace_size);
+	if (!ctx) {
+		dev_dbg(dev, "%s: failed to initialize context\n", __func__);
+		err = -EINVAL;
+		goto error;
+	}
+
+	len = ZSTD_decompressDCtx(ctx, out_buf, out_size, in_buffer, in_size);
+	if (ZSTD_isError(len)) {
+		dev_dbg(dev, "%s: failed to decompress: %d\n", __func__,
+			ZSTD_getErrorCode(len));
+		err = -EINVAL;
+		goto error;
+	}
+
+	fw_priv->size = len;
+	if (!fw_priv->data)
+		fw_priv->data = out_buf;
+	err = 0;
+
+ error:
+	kvfree(workspace);
+	if (!fw_priv->data)
+		vfree(out_buf);
+	return err;
+}
+#endif /* CONFIG_FW_LOADER_COMPRESS_ZSTD */
+
 /*
  * XZ-compressed firmware support
  */
-#ifdef CONFIG_FW_LOADER_COMPRESS
+#ifdef CONFIG_FW_LOADER_COMPRESS_XZ
 /* show an error and return the standard error code */
 static int fw_decompress_xz_error(struct device *dev, enum xz_ret xz_ret)
 {
@@ -459,7 +522,7 @@ static int fw_decompress_xz(struct device *dev, struct fw_priv *fw_priv,
 	else
 		return fw_decompress_xz_pages(dev, fw_priv, in_size, in_buffer);
 }
-#endif /* CONFIG_FW_LOADER_COMPRESS */
+#endif /* CONFIG_FW_LOADER_COMPRESS_XZ */
 
 /* direct firmware loading support */
 static char fw_path_para[256];
@@ -814,7 +877,12 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	if (!(opt_flags & FW_OPT_PARTIAL))
 		nondirect = true;
 
-#ifdef CONFIG_FW_LOADER_COMPRESS
+#ifdef CONFIG_FW_LOADER_COMPRESS_ZSTD
+	if (ret == -ENOENT && nondirect)
+		ret = fw_get_filesystem_firmware(device, fw->priv, ".zst",
+						 fw_decompress_zstd);
+#endif
+#ifdef CONFIG_FW_LOADER_COMPRESS_XZ
 	if (ret == -ENOENT && nondirect)
 		ret = fw_get_filesystem_firmware(device, fw->priv, ".xz",
 						 fw_decompress_xz);
-- 
2.26.2

