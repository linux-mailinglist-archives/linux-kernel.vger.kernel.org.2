Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B32A3FF0F9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346209AbhIBQQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346190AbhIBQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:16:41 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924EFC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:15:42 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m4so4554976ljq.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjzmQo1N7d1P1cyzIEi8qkH6o8WLXVag9lNOKET+p2c=;
        b=QXnEL8wUBZ5IdkU13PdI7ypnoy6W4VPTqeqnkOXW6FfJRhYaDm0Jzzmtbq6Si2JQSQ
         69QHO43owdL60VNdB33s5dRErlPWV3PvXL/RtwRcDscmXdZD0TwwIgGFjyiYltKBwKDN
         tyL8ZDMF2kHzldgDRajFcpfGqAqNZXSO3yR+dpWVwZXLO7B/nlr/uNutpuTRM7FpmOet
         YDuTae0SPZZMzNiuezHB0njjBAstCwjgMSj9DRLn5AG6O1V7PK1gvjRLhQZVVOk5cuE2
         Ej/sGOjuA+Oa3qN78MWM6pIOddg3RiibPrGKSOar4ouSQQJViqM2RD6ZuUjNDWaob14o
         Nt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjzmQo1N7d1P1cyzIEi8qkH6o8WLXVag9lNOKET+p2c=;
        b=MTf8kr+vej30rj8BX8PSBef1QvMMY9LNW06NeCQfqyd6zDiR2+1ZOZFtAv5H8gL/tz
         t/lOP662ZkSk0sgfkUnsVZW86QYyZ2l/JMEfIz85CGHJBg7RTkPpS++Ili6HD64iV2rh
         YLGCYiviQ9nae9odUMfsBg51c0M2vgsml8NtOpVsHPIlBTyFwSzjCkfbV6sbgDTKEL2a
         MhkgaSHVk65x3N6YF3sGV3+8kZpb2cU4u4iWa/ZKu88o+Df/vOtvD6DERd9vDenyZaw4
         jU5KiLFY4CL2sChV4htJJYiu2K9mvjb0f/UQK98TAi3MLJNbeig2ZRO+dASE+qSrRauF
         ThBw==
X-Gm-Message-State: AOAM533qAQIVu8P/w7d9Gou1yj+dL3fxG0IOuwHdsCdHqNRM9I7Bauve
        KkDpIVpUhziHiEHp2TL+q74=
X-Google-Smtp-Source: ABdhPJzn38UO6/Tx9z3krFJBpz+i6XLMy6kjCdpnZ6d5ICoOhqIkWrMGhKAN5N6oTk+AjBxn8UkwDw==
X-Received: by 2002:a2e:5708:: with SMTP id l8mr3273905ljb.481.1630599340934;
        Thu, 02 Sep 2021 09:15:40 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id m7sm267811ljj.58.2021.09.02.09.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:15:40 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] fs/ntfs3: Add missing header and guards to lib/ headers
Date:   Thu,  2 Sep 2021 19:15:24 +0300
Message-Id: <20210902161528.6262-5-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902161528.6262-1-kari.argillander@gmail.com>
References: <20210902161528.6262-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

size_t needs header. Add missing header guards so that compiler will
only include these ones.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/lib/decompress_common.h | 5 +++++
 fs/ntfs3/lib/lib.h               | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/ntfs3/lib/decompress_common.h b/fs/ntfs3/lib/decompress_common.h
index 66297f398403..a2a858d4bf35 100644
--- a/fs/ntfs3/lib/decompress_common.h
+++ b/fs/ntfs3/lib/decompress_common.h
@@ -19,6 +19,9 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#ifndef _LINUX_NTFS3_LIB_DECOMPRESS_COMMON_H
+#define _LINUX_NTFS3_LIB_DECOMPRESS_COMMON_H
+
 #include <linux/string.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
@@ -350,3 +353,5 @@ static forceinline u8 *lz_copy(u8 *dst, u32 length, u32 offset, const u8 *bufend
 
 	return dst;
 }
+
+#endif /* _LINUX_NTFS3_LIB_DECOMPRESS_COMMON_H */
diff --git a/fs/ntfs3/lib/lib.h b/fs/ntfs3/lib/lib.h
index f508fbad2e71..90309a5ae59c 100644
--- a/fs/ntfs3/lib/lib.h
+++ b/fs/ntfs3/lib/lib.h
@@ -7,6 +7,10 @@
  * - linux kernel code style
  */
 
+#ifndef _LINUX_NTFS3_LIB_LIB_H
+#define _LINUX_NTFS3_LIB_LIB_H
+
+#include <linux/types.h>
 
 /* globals from xpress_decompress.c */
 struct xpress_decompressor *xpress_allocate_decompressor(void);
@@ -24,3 +28,5 @@ int lzx_decompress(struct lzx_decompressor *__restrict d,
 		   const void *__restrict compressed_data,
 		   size_t compressed_size, void *__restrict uncompressed_data,
 		   size_t uncompressed_size);
+
+#endif /* _LINUX_NTFS3_LIB_LIB_H */
-- 
2.25.1

