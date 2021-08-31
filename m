Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512383FC978
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbhHaOQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbhHaOQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:16:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80C1C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m18so24676792lfl.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjzmQo1N7d1P1cyzIEi8qkH6o8WLXVag9lNOKET+p2c=;
        b=nBsQ1UMQrWHJWCVlOmyWqaGEI3ZWxg5jWFSIiCpRXMa+99AnD2rhYiPisfrrobVAXZ
         21zYOxG9jay1p43sOz/PGA2M+t/d+qH8/1D2TcQ2TkH0qSV7qvKJzRZUp3ucZVlC3o5w
         6ZLTOjWiwqrqg4I1GGbWk2yo6Wr4S9DgvyHdWGvXaG0jxKu3WmMv/Imke+CM4oi2jMRi
         4nsGABkULhIdVS8ceBlk2SxcfWYcBCGHh9pjTHKhpqL2OtYs+E7dSTyLdyTrFBMStQjl
         b50xt6kvP2Hqf9iXTbEu2rbq6Krv0RiM8B7xjcVjLX6fo/9K6LIu35USWBlKZceLIOZV
         V9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjzmQo1N7d1P1cyzIEi8qkH6o8WLXVag9lNOKET+p2c=;
        b=kYrkiGOuwXYLfWrHQsMCytnZrrnyo87K5zKNoiCf4+pIQkzshfRPkMc3H/AR7qq7sx
         +gOi5BvL7jxia1xCRCtXqri2xfgNeE8r3Z/vlduEJBALO8ew7vomzyOXes5LNlfxIrBf
         AJjbmdcfOZfJ6pGFK/yyoQ0yQae0yf5Rj6kYvSsYVMXk1IfKFfQuVYq5lhnphHHOR1eM
         z0L2TpkiooHXfZVS2O3AE40RXF74/25mgFgx31foAZ6r36MQD16ADC3POZKklxNZBdw1
         2ITqN5CtKebpdXxUFVRe3mKMNwYJ+92/KmtbL+9r3kV+BvFVnLmPyUoUvRVMyUO7PtC1
         KzSg==
X-Gm-Message-State: AOAM532rIlD+wvGq8bMqW6ft3D7VnTG2tc+hOFCg+HU0OlkAxkHCRA7Z
        pM/exs4xSwpdbRn1IHZqb0U=
X-Google-Smtp-Source: ABdhPJzXPEinHOtHgNiedNMJpgG4DnomQ5x9de0q9GYvNAvWi5hDOnaZygJC6dEl2gsTaowvN5gAqA==
X-Received: by 2002:ac2:4c50:: with SMTP id o16mr11491952lfk.224.1630419304952;
        Tue, 31 Aug 2021 07:15:04 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id i30sm2202187ljb.48.2021.08.31.07.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:15:04 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] fs/ntfs3: Add missing header and guards to lib/ headers
Date:   Tue, 31 Aug 2021 17:14:30 +0300
Message-Id: <20210831141434.975175-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831141434.975175-1-kari.argillander@gmail.com>
References: <20210831141434.975175-1-kari.argillander@gmail.com>
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

