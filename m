Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BFA4554A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 07:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243296AbhKRGTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 01:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbhKRGTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 01:19:31 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A018C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 22:16:32 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q12so4445405pgh.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 22:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBpck1aGx8TqPXrKH8c2Dl1lu1ufAM7ETwQygrf3Zc8=;
        b=N90mRRf5IotDMCZ6cNPZ7ByOXadx0DrSOK0K9oombTs19m68yAIiDg/z4IeOon1Q6p
         MS8fRPJI02IFSCxaHAK/bhNXjPZm2e5a1z8qtgW5Nqorzk+f3YRlbqHzHHnej9/hywvg
         4IYDjqUjZsrp02miPEp/IxO7DRszSMimLnJj6UslUX2nNcomYIuVzSdkw/U3vXHK9qB7
         j5ao0PaLR4aVAo5haMueYIA0nQ0BGPPOY8tb2daeUv5C4MPlAX0irUu8UJR8umZUAbgF
         ME3MxvvbJ6mnTR0gijRfsF+8WPUbFcQaYmKejCtCbMWX85U+UJPOPZsHG4uuJza+4Hsz
         MsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBpck1aGx8TqPXrKH8c2Dl1lu1ufAM7ETwQygrf3Zc8=;
        b=MvFvlfb2ES+ePdZk1Emp/Sxjq5Lkn9f55pASM1dBO4GHixNTkQ7gM1THb3RI7hwbAQ
         oB2gySjk/azIwLoq5drtgq7kCqFwDJh4zBGEDywedAG/0oNECQlPwEdWFL6dgiE5j913
         B1kJbI2JEABZ9u1sueExcej6eZwPpNeBIzUEHS+YuAbh/5K1ZY930xEY94FYF8GuOfvH
         X16dw6UOdIQdt44mbffP660pk/RV++fZHw8QQNJnGZXD9qpKNOmcAGqTHwTWyUTq8I2I
         6gJW4SfAA6UN9Pj5aFzJnUGL05xF9NDIgwrHVDPxqtyS85/O3tEOeoVKwf21CWo5ynkl
         Vvow==
X-Gm-Message-State: AOAM531ySwYcGZgqqKLT9eLxGqM7fq86LjywuoUKfKR+9cVhP5HjSPLy
        DeKISvkicMPqu8S35kLpML6YBaV26bw=
X-Google-Smtp-Source: ABdhPJwChD6detTH/DDXDirtCdG9FDC3JLVtE92pMilKctfs/2wFrr0vBw5wO31jtOgPJ/Bp+D8/Hg==
X-Received: by 2002:a05:6a00:21c4:b0:475:e532:3d18 with SMTP id t4-20020a056a0021c400b00475e5323d18mr12751266pfj.40.1637216191187;
        Wed, 17 Nov 2021 22:16:31 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l11sm1639525pfu.129.2021.11.17.22.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 22:16:30 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     yao.jing2@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] lib/mpi: use swap() to make code cleaner
Date:   Thu, 18 Nov 2021 06:16:21 +0000
Message-Id: <20211118061621.164023-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yao Jing <yao.jing2@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yao Jing <yao.jing2@zte.com.cn>
---
 lib/mpi/ec.c      | 6 ++----
 lib/mpi/mpi-pow.c | 9 ++-------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/lib/mpi/ec.c b/lib/mpi/ec.c
index 40f5908e57a4..a2f5694425ee 100644
--- a/lib/mpi/ec.c
+++ b/lib/mpi/ec.c
@@ -1282,14 +1282,12 @@ void mpi_ec_mul_point(MPI_POINT result,
 		sum = &p2_;
 
 		for (j = nbits-1; j >= 0; j--) {
-			MPI_POINT t;
-
 			sw = mpi_test_bit(scalar, j);
 			point_swap_cond(q1, q2, sw, ctx);
 			montgomery_ladder(prd, sum, q1, q2, point->x, ctx);
 			point_swap_cond(prd, sum, sw, ctx);
-			t = q1;  q1 = prd;  prd = t;
-			t = q2;  q2 = sum;  sum = t;
+			swap(q1, prd);
+			swap(q2, sum);
 		}
 
 		mpi_clear(result->y);
diff --git a/lib/mpi/mpi-pow.c b/lib/mpi/mpi-pow.c
index 2fd7a46d55ec..67fbd4c2503d 100644
--- a/lib/mpi/mpi-pow.c
+++ b/lib/mpi/mpi-pow.c
@@ -176,7 +176,6 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 
 		for (;;) {
 			while (c) {
-				mpi_ptr_t tp;
 				mpi_size_t xsize;
 
 				/*if (mpihelp_mul_n(xp, rp, rp, rsize) < 0) goto enomem */
@@ -207,9 +206,7 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 					xsize = msize;
 				}
 
-				tp = rp;
-				rp = xp;
-				xp = tp;
+				swap(rp, xp);
 				rsize = xsize;
 
 				if ((mpi_limb_signed_t) e < 0) {
@@ -235,9 +232,7 @@ int mpi_powm(MPI res, MPI base, MPI exp, MPI mod)
 						xsize = msize;
 					}
 
-					tp = rp;
-					rp = xp;
-					xp = tp;
+					swap(rp, xp);
 					rsize = xsize;
 				}
 				e <<= 1;
-- 
2.25.1

