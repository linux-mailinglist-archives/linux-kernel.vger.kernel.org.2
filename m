Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA833D59B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbhCPOT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhCPOTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:19:24 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EF2C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:19:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so1558667wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UzHeXhl6aPfjne1/Cu97InzVggy6/RlJuwCCAZP97Cc=;
        b=Dqn6HyQKqt9la9hobIdd9lIc/dg4OmUfGeexQbSdKLMGTt/qo1xodendIyzi0ThfmZ
         kTAmxAqcY68yC/XsZM//8pMqtxhUC6N70U+ODBlCETBQmoFrnE8/vbOVfKUTOPqKngbx
         X89/vNRx/njTHK1xSOWmkqgjlnPmXWnsUUgdbCcBmfoOt6ifWLbyo6cjO+1nLQyMkKK7
         RGGdFPnMpMuYo203sINS6W3TucYzQFD52+hqTCrd3BLmNebIcVjTcBpmgo9cIxCL7lp6
         P8BNqYSzxu3JhK0biEtzbUXjlFz0T3+B2u2E6yybWkS0hV2SoYhH4is7Lmp0OtXPVni5
         I/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UzHeXhl6aPfjne1/Cu97InzVggy6/RlJuwCCAZP97Cc=;
        b=mMfUl3yY+pmtvv6Mc5gpqwZebXydlgWHCzvGRc4KoiBURBFsc2FvWgTtjNDb2ERaNT
         oc2wW+6rc7Wb+S14M+ucbOJu2RoNgXbamUrJKY8jEK4ATlrViY/4Oa0k6iSIjficD5TF
         AfGPBX7QOVqkzWHQyonhl4zX7+KE8FcqHhSne8yLeQ5WVLFrjFxRR3U0mXVxemowF5SE
         wmZAOp3oDpr/NPcnx0HisE5eKJcuPB2qKNcc5FrL/8cL1sjxOzMeTZDzKmhMZ/O9mHB8
         hjwXAmZNlsFXHEaKDur82sKJykF+Mjnr4XsgZOPDfzkQAMsdE/olUtM2U5phCfDYPQn9
         obFw==
X-Gm-Message-State: AOAM532db0stPzVJUppLju2qoUUdNvc2+kvBvL6yu7l87Amt19uYTOD6
        zWnTrQ3Bs+ZJX/a1BAUbYA==
X-Google-Smtp-Source: ABdhPJyFmvKcIn80Q1edIyO6QYxSW0BcGi0dI59xWyWhEcYIm9WCZd+2/YfeDmia7rpjGiHcoo/YSg==
X-Received: by 2002:a7b:c0d1:: with SMTP id s17mr4364421wmh.153.1615904362713;
        Tue, 16 Mar 2021 07:19:22 -0700 (PDT)
Received: from presler.lan (a95-94-147-174.cpe.netcabo.pt. [95.94.147.174])
        by smtp.gmail.com with ESMTPSA id i8sm24956856wry.90.2021.03.16.07.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 07:19:22 -0700 (PDT)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     lizhe67@huawei.com, christian.brauner@ubuntu.com,
        gustavoars@kernel.org, trix@redhat.com, keescook@chromium.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [RFC PATCH v2] jffs2: add support for zstd compression
Date:   Tue, 16 Mar 2021 14:19:16 +0000
Message-Id: <20210316141916.447493-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for zstd compression in jffs2 at the default compression
level (3).

Lightly tested in OpenWrt, on a single CPU embedded MIPS32 system (AirGrid M2).

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
v2: fix blunder in compression context allocation

 fs/jffs2/Kconfig           |   9 +++
 fs/jffs2/Makefile          |   1 +
 fs/jffs2/compr.c           |  10 +++
 fs/jffs2/compr.h           |   6 ++
 fs/jffs2/compr_zstd.c      | 131 +++++++++++++++++++++++++++++++++++++
 fs/jffs2/super.c           |   7 ++
 include/uapi/linux/jffs2.h |   1 +
 7 files changed, 165 insertions(+)
 create mode 100644 fs/jffs2/compr_zstd.c

diff --git a/fs/jffs2/Kconfig b/fs/jffs2/Kconfig
index 7c96bc107218..31308eb7267b 100644
--- a/fs/jffs2/Kconfig
+++ b/fs/jffs2/Kconfig
@@ -136,6 +136,15 @@ config JFFS2_LZO
 	  This feature was added in July, 2007. Say 'N' if you need
 	  compatibility with older bootloaders or kernels.
 
+config JFFS2_ZSTD
+	bool "JFFS2 zstd compression support" if JFFS2_COMPRESSION_OPTIONS
+	select ZSTD_COMPRESS
+	select ZSTD_DECOMPRESS
+	depends on JFFS2_FS
+	default n
+	help
+	  Zstd compression.
+
 config JFFS2_RTIME
 	bool "JFFS2 RTIME compression support" if JFFS2_COMPRESSION_OPTIONS
 	depends on JFFS2_FS
diff --git a/fs/jffs2/Makefile b/fs/jffs2/Makefile
index 5294969d5bf9..75f84b1467c5 100644
--- a/fs/jffs2/Makefile
+++ b/fs/jffs2/Makefile
@@ -19,4 +19,5 @@ jffs2-$(CONFIG_JFFS2_RUBIN)	+= compr_rubin.o
 jffs2-$(CONFIG_JFFS2_RTIME)	+= compr_rtime.o
 jffs2-$(CONFIG_JFFS2_ZLIB)	+= compr_zlib.o
 jffs2-$(CONFIG_JFFS2_LZO)	+= compr_lzo.o
+jffs2-$(CONFIG_JFFS2_ZSTD)	+= compr_zstd.o
 jffs2-$(CONFIG_JFFS2_SUMMARY)   += summary.o
diff --git a/fs/jffs2/compr.c b/fs/jffs2/compr.c
index 4849a4c9a0e2..d65e0c39c9c5 100644
--- a/fs/jffs2/compr.c
+++ b/fs/jffs2/compr.c
@@ -237,6 +237,10 @@ uint16_t jffs2_compress(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 		ret = jffs2_selected_compress(JFFS2_COMPR_ZLIB, data_in,
 				cpage_out, datalen, cdatalen);
 		break;
+	case JFFS2_COMPR_MODE_FORCEZSTD:
+		ret = jffs2_selected_compress(JFFS2_COMPR_ZSTD, data_in,
+				cpage_out, datalen, cdatalen);
+		break;
 	default:
 		pr_err("unknown compression mode\n");
 	}
@@ -378,6 +382,9 @@ int __init jffs2_compressors_init(void)
 #ifdef CONFIG_JFFS2_LZO
 	jffs2_lzo_init();
 #endif
+#ifdef CONFIG_JFFS2_ZSTD
+	jffs2_zstd_init();
+#endif
 /* Setting default compression mode */
 #ifdef CONFIG_JFFS2_CMODE_NONE
 	jffs2_compression_mode = JFFS2_COMPR_MODE_NONE;
@@ -413,6 +420,9 @@ int jffs2_compressors_exit(void)
 #endif
 #ifdef CONFIG_JFFS2_ZLIB
 	jffs2_zlib_exit();
+#endif
+#ifdef CONFIG_JFFS2_ZSTD
+	jffs2_zstd_exit();
 #endif
 	return 0;
 }
diff --git a/fs/jffs2/compr.h b/fs/jffs2/compr.h
index 5e91d578f4ed..8f7032c5ecb2 100644
--- a/fs/jffs2/compr.h
+++ b/fs/jffs2/compr.h
@@ -31,6 +31,7 @@
 #define JFFS2_RTIME_PRIORITY     50
 #define JFFS2_ZLIB_PRIORITY      60
 #define JFFS2_LZO_PRIORITY       80
+#define JFFS2_ZSTD_PRIORITY      90
 
 
 #define JFFS2_RUBINMIPS_DISABLED /* RUBINs will be used only */
@@ -42,6 +43,7 @@
 #define JFFS2_COMPR_MODE_FAVOURLZO  3
 #define JFFS2_COMPR_MODE_FORCELZO   4
 #define JFFS2_COMPR_MODE_FORCEZLIB  5
+#define JFFS2_COMPR_MODE_FORCEZSTD  6
 
 #define FAVOUR_LZO_PERCENT 80
 
@@ -101,5 +103,9 @@ void jffs2_zlib_exit(void);
 int jffs2_lzo_init(void);
 void jffs2_lzo_exit(void);
 #endif
+#ifdef CONFIG_JFFS2_ZSTD
+int jffs2_zstd_init(void);
+void jffs2_zstd_exit(void);
+#endif
 
 #endif /* __JFFS2_COMPR_H__ */
diff --git a/fs/jffs2/compr_zstd.c b/fs/jffs2/compr_zstd.c
new file mode 100644
index 000000000000..bfe4607575da
--- /dev/null
+++ b/fs/jffs2/compr_zstd.c
@@ -0,0 +1,131 @@
+
+#include <linux/zstd.h>
+#include "compr.h"
+
+#define ZSTD_DEF_LEVEL	3
+
+static ZSTD_CCtx *cctx;
+static ZSTD_DCtx *dctx;
+static void *cwksp;
+static void *dwksp;
+
+static ZSTD_parameters zstd_params(void)
+{
+	return ZSTD_getParams(ZSTD_DEF_LEVEL, 0, 0);
+}
+
+static int zstd_comp_init(void)
+{
+	int ret = 0;
+	const ZSTD_parameters params = zstd_params();
+	const size_t wksp_size = ZSTD_CCtxWorkspaceBound(params.cParams);
+
+	cwksp = vzalloc(wksp_size);
+	if (!cwksp) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cctx = ZSTD_initCCtx(cwksp, wksp_size);
+	if (!cctx) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+out:
+	return ret;
+out_free:
+	vfree(cwksp);
+	goto out;
+}
+
+static int zstd_decomp_init(void)
+{
+	int ret = 0;
+	const size_t wksp_size = ZSTD_DCtxWorkspaceBound();
+
+	dwksp = vzalloc(wksp_size);
+	if (!dwksp) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	dctx = ZSTD_initDCtx(dwksp, wksp_size);
+	if (!dctx) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+out:
+	return ret;
+out_free:
+	vfree(dwksp);
+	goto out;
+}
+
+static void zstd_comp_exit(void)
+{
+	vfree(cwksp);
+	cwksp = NULL;
+	cctx = NULL;
+}
+
+static void zstd_decomp_exit(void)
+{
+	vfree(dwksp);
+	dwksp = NULL;
+	dctx = NULL;
+}
+
+static int jffs2_zstd_compress(unsigned char *data_in, unsigned char *cpage_out,
+			      uint32_t *sourcelen, uint32_t *dstlen)
+{
+	size_t out_len;
+	const ZSTD_parameters params = zstd_params();
+
+	out_len = ZSTD_compressCCtx(cctx, cpage_out, *dstlen, data_in, *sourcelen, params);
+	if (ZSTD_isError(out_len) || out_len > *dstlen)
+		return -1;
+	*dstlen = out_len;
+	return 0;
+}
+
+static int jffs2_zstd_decompress(unsigned char *data_in, unsigned char *cpage_out,
+				 uint32_t srclen, uint32_t destlen)
+{
+	size_t out_len;
+
+	out_len = ZSTD_decompressDCtx(dctx, cpage_out, destlen, data_in, srclen);
+	if (ZSTD_isError(out_len) || out_len != destlen)
+		return -1;
+
+	return 0;
+}
+
+static struct jffs2_compressor jffs2_zstd_comp = {
+	.priority = JFFS2_ZSTD_PRIORITY,
+	.name = "zstd",
+	.compr = JFFS2_COMPR_ZSTD,
+	.compress = &jffs2_zstd_compress,
+	.decompress = &jffs2_zstd_decompress,
+	.disabled = 0,
+};
+
+int __init jffs2_zstd_init(void)
+{
+	int ret;
+
+	ret = zstd_comp_init();
+	if (ret)
+		return ret;
+	ret = zstd_decomp_init();
+	if (ret)
+		zstd_comp_exit();
+	ret = jffs2_register_compressor(&jffs2_zstd_comp);
+	return ret;
+}
+
+void jffs2_zstd_exit(void)
+{
+	jffs2_unregister_compressor(&jffs2_zstd_comp);
+	zstd_comp_exit();
+	zstd_decomp_exit();
+}
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 81ca58c10b72..ddce95c55dde 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -73,6 +73,10 @@ static const char *jffs2_compr_name(unsigned int compr)
 #ifdef CONFIG_JFFS2_ZLIB
 	case JFFS2_COMPR_MODE_FORCEZLIB:
 		return "zlib";
+#endif
+#ifdef CONFIG_JFFS2_ZSTD
+	case JFFS2_COMPR_MODE_FORCEZSTD:
+		return "zstd";
 #endif
 	default:
 		/* should never happen; programmer error */
@@ -174,6 +178,9 @@ static const struct constant_table jffs2_param_compr[] = {
 #endif
 #ifdef CONFIG_JFFS2_ZLIB
 	{"zlib",	JFFS2_COMPR_MODE_FORCEZLIB },
+#endif
+#ifdef CONFIG_JFFS2_ZSTD
+	{"zstd",	JFFS2_COMPR_MODE_FORCEZSTD },
 #endif
 	{}
 };
diff --git a/include/uapi/linux/jffs2.h b/include/uapi/linux/jffs2.h
index 784ba0b9690a..af4fb69c8d69 100644
--- a/include/uapi/linux/jffs2.h
+++ b/include/uapi/linux/jffs2.h
@@ -46,6 +46,7 @@
 #define JFFS2_COMPR_DYNRUBIN	0x05
 #define JFFS2_COMPR_ZLIB	0x06
 #define JFFS2_COMPR_LZO		0x07
+#define JFFS2_COMPR_ZSTD	0x08
 /* Compatibility flags. */
 #define JFFS2_COMPAT_MASK 0xc000      /* What do to if an unknown nodetype is found */
 #define JFFS2_NODE_ACCURATE 0x2000
-- 
2.31.0

