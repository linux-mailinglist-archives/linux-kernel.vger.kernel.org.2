Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9D733895B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhCLJ4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhCLJ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:56:17 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CA0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:56:17 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id l4so23648569qkl.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEW1hEWBRM4fMNj0JZKfY5sioaWotGdrzXJcIsKNcQI=;
        b=mo7IUt3K7yGeT9ihyHZ7UxdDum+bcNLfYIll63ctj2rlCeTCYXvHLMEfEprLcs0ZG7
         PoqU0anbg9cpt9KwsRSTYCgNPBuA3n0EhmLxP/xgGcO31zzWEV9SqTa5P3Uh+93Vqale
         rfeSW9X6ZWuTmkd79iNzSBU24SqdvQjOLoQpo1ihYuPjwMtmE7HJ4qOGtFTLUHkdmszb
         cFjcnrgZmMBX11M2th6EE1m+qjfa/FNm1Fj/ewRl/h0mzO27dzugJP9ZYiaq6ouY+z18
         nJ3wCm1OHup9vtqbNiNn2ChNChpic1+RuTHwNHtbYHAK0AD4SwHtrmmawzQ7AGjaGJx3
         LkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEW1hEWBRM4fMNj0JZKfY5sioaWotGdrzXJcIsKNcQI=;
        b=S+oV32MQKqArZQqnfYC1zlRJwFHZ3GVo1VQVe3wM6Ww9u055ZkNmms4u+vkHLDS3oo
         Q9vHIvNcE4u26AJQZE6L5mQBWAUynL3iJJ4aJbKSeN+WK5YwRCQRtgTEqHe3VvILWTph
         ks2CP7GtQ5DD8a/rAwm40vAqQFCalb3eXNV+VCnaC2reDbCs7quC6Nj9BZ2HvB/iDH4v
         MysgsvNGVRzVhCzBWiNUvHqXrVo7Bv6k66ARPczD79hqdO1EOtzs+NKesXbKeSASJqei
         chZTmS0s3USgY2v5pgQmVk/zVdcO8D1UBlTOzcCFsFEcGlzDd05SdkK2x/FVunTSaZEx
         fPug==
X-Gm-Message-State: AOAM532UgukgSBqNUYT7Y7K7Wat6EQOoM13Ck/k/8iUV4CyB/V8uI+V/
        YbVnRxXnF8nPTZFadXaTBg==
X-Google-Smtp-Source: ABdhPJx/U3IEDQlKYugWuIsbNkulQob+2Bbm6u4lKguYc8xSZDxJceN7alo+9v5y70NCbaKDDrHhyA==
X-Received: by 2002:a37:a515:: with SMTP id o21mr11678708qke.307.1615542976615;
        Fri, 12 Mar 2021 01:56:16 -0800 (PST)
Received: from presler.lan (a95-93-120-206.cpe.netcabo.pt. [95.93.120.206])
        by smtp.gmail.com with ESMTPSA id n136sm3994980qke.123.2021.03.12.01.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:56:16 -0800 (PST)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     lizhe67@huawei.com, christian.brauner@ubuntu.com,
        gustavoars@kernel.org, trix@redhat.com, keescook@chromium.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [RFC PATCH] jffs2: add support for zstd compression
Date:   Fri, 12 Mar 2021 09:55:46 +0000
Message-Id: <20210312095545.53765-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.30.2
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
Sent as RFC, since I have no idea if locking is required (the crypto API
implementation doesn't do it, at least).

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
index 000000000000..86b3d28670d7
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
+	if (cctx) {
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
2.30.2

