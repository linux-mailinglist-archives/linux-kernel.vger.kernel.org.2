Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FFD402340
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 08:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhIGGIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 02:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhIGGIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 02:08:38 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF47AC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 23:07:32 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so11449179otg.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 23:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SpGYmwPY052YHFW8e+vfCdYlsHczRaqhmPVzq2pUYxU=;
        b=NGyI9GWvRWeih0y/9kywO3svc8BJOA9u0Uvk2xFIR4wIj2h0f4BAH+vcRW1b85SNtB
         mM/uQs/qV9fk2TO73n2yi+BRDVCH9xx+Pu7vXz6QTDz9OO+hBMKaNCuY4+iQmaJFCdgI
         BFQZ0St0A18dmLHR3FC0Yt0E0+/X5KDTxCtjKH8VSD+D95eySpUfzyWDibi5COMj4RhI
         SdQIXaRhRuCFm4V9AwWJ0mMER1GwD4rVI7zlhO2QhZJ0BF6Ohb7Yl4dOaPJdYz2fh39E
         GCs9jSjHfxhYDsXgPs1BXQeTg+JwcsEUglDMIurmVUEsCDT49k4APenVa2tUv++rQ68u
         tVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=SpGYmwPY052YHFW8e+vfCdYlsHczRaqhmPVzq2pUYxU=;
        b=fRir02R6bmSyP4aSh6e95jTr6hGCDH4n1tZBUjNvQ3UYVwVUZRe1DXDZzVF5d7kxi/
         pqfP0pg+Wf/XPMuJcA0d6YFefbN31WYNNvXjUWsrnM05BMsoL22Yu2J+zUKtrlRgzAV9
         azx2VgWE6Ohlo/aX88qKlDXS2Vh5Vg4BhO9v/PtFTju6y3GmUcRyBk/q4Inj7zx7BltL
         7goNKpkjN7FuASCJE4GdqM+Z0g92YfTQlsohhfKKNSUNUqgcTyvUxBy6mQS5BM0200ep
         T2VQjSxmaiOlBHuBlelUqtb0E1JG3p4jnJsc/ZZnoQDJ6GtJlEiGd6BoC/lGrwsj5fue
         LXVg==
X-Gm-Message-State: AOAM5305NlgCZMVllDzBpTxszIWSnojF8HPl3ORE8MX+N4SwxZXkg+zN
        /WK9rvz0JRI5yBIm1arsSDQ=
X-Google-Smtp-Source: ABdhPJzrmhQQ0MsHbsu+18Nfj/q3r1Vh5ZTDtW/iy4G5+uG7cBlTiiTdDHPvtiVtIxMJwF2ji/OPtg==
X-Received: by 2002:a9d:490f:: with SMTP id e15mr13870328otf.340.1630994852335;
        Mon, 06 Sep 2021 23:07:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v16sm2057342oou.45.2021.09.06.23.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 23:07:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] m68k: Double cast io functions to unsigned long
Date:   Mon,  6 Sep 2021 23:07:29 -0700
Message-Id: <20210907060729.2391992-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

m68k builds fail widely with errors such as

arch/m68k/include/asm/raw_io.h:20:19: error:
	cast to pointer from integer of different size
arch/m68k/include/asm/raw_io.h:30:32: error:
	cast to pointer from integer of different size [-Werror=int-to-p

On m68k, io functions are defined as macros. The problem is seen if the
macro parameter variable size differs from the size of a pointer. Cast
the parameter of all io macros to unsigned long before casting it to
a pointer to fix the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I didn't fix the checkpatch issues on purpose to limit the scope of the
changes. I'll be happy to resend if a clean patch is preferred.

 arch/m68k/include/asm/raw_io.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/include/asm/raw_io.h b/arch/m68k/include/asm/raw_io.h
index 911826ea83ce..80eb2396d01e 100644
--- a/arch/m68k/include/asm/raw_io.h
+++ b/arch/m68k/include/asm/raw_io.h
@@ -17,21 +17,21 @@
  * two accesses to memory, which may be undesirable for some devices.
  */
 #define in_8(addr) \
-    ({ u8 __v = (*(__force volatile u8 *) (addr)); __v; })
+    ({ u8 __v = (*(__force volatile u8 *) (unsigned long)(addr)); __v; })
 #define in_be16(addr) \
-    ({ u16 __v = (*(__force volatile u16 *) (addr)); __v; })
+    ({ u16 __v = (*(__force volatile u16 *) (unsigned long)(addr)); __v; })
 #define in_be32(addr) \
-    ({ u32 __v = (*(__force volatile u32 *) (addr)); __v; })
+    ({ u32 __v = (*(__force volatile u32 *) (unsigned long)(addr)); __v; })
 #define in_le16(addr) \
-    ({ u16 __v = le16_to_cpu(*(__force volatile __le16 *) (addr)); __v; })
+    ({ u16 __v = le16_to_cpu(*(__force volatile __le16 *) (unsigned long)(addr)); __v; })
 #define in_le32(addr) \
-    ({ u32 __v = le32_to_cpu(*(__force volatile __le32 *) (addr)); __v; })
+    ({ u32 __v = le32_to_cpu(*(__force volatile __le32 *) (unsigned long)(addr)); __v; })
 
-#define out_8(addr,b) (void)((*(__force volatile u8 *) (addr)) = (b))
-#define out_be16(addr,w) (void)((*(__force volatile u16 *) (addr)) = (w))
-#define out_be32(addr,l) (void)((*(__force volatile u32 *) (addr)) = (l))
-#define out_le16(addr,w) (void)((*(__force volatile __le16 *) (addr)) = cpu_to_le16(w))
-#define out_le32(addr,l) (void)((*(__force volatile __le32 *) (addr)) = cpu_to_le32(l))
+#define out_8(addr,b) (void)((*(__force volatile u8 *) (unsigned long)(addr)) = (b))
+#define out_be16(addr,w) (void)((*(__force volatile u16 *) (unsigned long)(addr)) = (w))
+#define out_be32(addr,l) (void)((*(__force volatile u32 *) (unsigned long)(addr)) = (l))
+#define out_le16(addr,w) (void)((*(__force volatile __le16 *) (unsigned long)(addr)) = cpu_to_le16(w))
+#define out_le32(addr,l) (void)((*(__force volatile __le32 *) (unsigned long)(addr)) = cpu_to_le32(l))
 
 #define raw_inb in_8
 #define raw_inw in_be16
-- 
2.33.0

