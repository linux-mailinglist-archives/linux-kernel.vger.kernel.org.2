Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25F231EF3C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhBRTIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbhBRRWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:22:25 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB49C061788
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:21:32 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z15so1752222pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W8h7ytYQ7/DYtclLyBd102BCY+Pw8YQBDQUfWvvJWOI=;
        b=gpuhqnmJijI9uuYxjrmv/RhSYDQDvVzKnZcjrzLmMvZwiCz3i+uoHv6qKqfwGwb9vI
         VFmPr/DV+Pc1il1wYak90ZsZzCh4qX3KUclrxmRX6eu8A+A0VBIDgQBckEyx59y1i3gK
         0botZeiPfE7Nndu+0YUq3lQuGVUaPUGvXDmjprWQu52XIMw1Am4+QCr4JIeJT2qWVyCi
         aH03TddGHkG/Hw91og1qw9QuP7cctHVPgS12bsteQeaxxSB/BmMPDHKCZYuY9hFomt6E
         gnvr7w+JKp5/qcSqOAi+3qlAjV0BBmdrRHkZXcAE5mqxJSMbbSUnCqc6WZlExOV6nyQQ
         2GHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W8h7ytYQ7/DYtclLyBd102BCY+Pw8YQBDQUfWvvJWOI=;
        b=eQ9RM9KX697iG6lC8Yc7g1e1+vJIfI2KOnpLUI9UkBJUrj3AR1A1vd70S2Mu0wh/Pz
         MZAVbKs50L5MIMmqeO4ap6+TPg1K4TeC90iMJsdANoCFq2PkJNUv1R+LGqztLKCUF0PY
         CRv50ewoE9vuNXJY4HWV4nIGsdKa2NAavrqRsDgYoo2KjIW8Euse6de9w2/yBk4xeFf+
         n/iplQwmEIo4BqA+Cz3x3Bkv/gLV05WbtpZPjNFyfbS3Be/s/iZOBtgQYmh+wQvjmeP9
         SoT+YoO0TzXcFYZQas6hmVbbdIhUIpZKZH0sCjs0gzp8kDGFtQ0elK4GmkaCTGLnl4v8
         7QBQ==
X-Gm-Message-State: AOAM530mGJ4GR8rNr0F415LU9f+jJHGBxdSyVAVq6t7UxvmyRBbnbiYn
        alG/mAR3rsIV6VkJ9i0mpLNzQEjMhpQvb+m6ouY=
X-Google-Smtp-Source: ABdhPJxfzS1MzulgxuYX08Oxl3CeG3ECUoowILKUEte4fRmphzC9WxCBywMdIIN8AJcyykEcBY2d3w==
X-Received: by 2002:a65:4c08:: with SMTP id u8mr4748497pgq.203.1613668891593;
        Thu, 18 Feb 2021 09:21:31 -0800 (PST)
Received: from localhost ([115.96.167.252])
        by smtp.gmail.com with ESMTPSA id v15sm2381683pgl.44.2021.02.18.09.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 09:21:31 -0800 (PST)
From:   Suryashankar Das <suryashankardas.2002@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net
Cc:     Suryashankar Das <suryashankardas.2002@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: rtl8188eu: Align block comments
Date:   Thu, 18 Feb 2021 22:50:43 +0530
Message-Id: <20210218172042.44597-1-suryashankardas.2002@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warnings:
WARNING: Block comments use * on subsequent lines
WARNING: Block comments should align the * on each line

Signed-off-by: Suryashankar Das <suryashankardas.2002@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_security.c | 82 +++++++++----------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 46ba55a8952a..73b78740093b 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -127,8 +127,8 @@ static __le32 getcrc32(u8 *buf, int len)
 }
 
 /*
-	Need to consider the fragment  situation
-*/
+ *	Need to consider the fragment  situation
+ */
 void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
 	int	curfragnum, length;
@@ -465,23 +465,23 @@ static const unsigned short Sbox1[2][256] = {  /* Sbox for hash (can be in ROM)
   }
 };
 
- /*
-**********************************************************************
-* Routine: Phase 1 -- generate P1K, given TA, TK, IV32
-*
-* Inputs:
-*     tk[]      = temporal key			 [128 bits]
-*     ta[]      = transmitter's MAC address	    [ 48 bits]
-*     iv32      = upper 32 bits of IV		  [ 32 bits]
-* Output:
-*     p1k[]     = Phase 1 key			  [ 80 bits]
-*
-* Note:
-*     This function only needs to be called every 2**16 packets,
-*     although in theory it could be called every packet.
-*
-**********************************************************************
-*/
+/*
+ **********************************************************************
+ * Routine: Phase 1 -- generate P1K, given TA, TK, IV32
+ *
+ * Inputs:
+ *     tk[]      = temporal key			 [128 bits]
+ *     ta[]      = transmitter's MAC address	    [ 48 bits]
+ *     iv32      = upper 32 bits of IV		  [ 32 bits]
+ * Output:
+ *     p1k[]     = Phase 1 key			  [ 80 bits]
+ *
+ * Note:
+ *     This function only needs to be called every 2**16 packets,
+ *     although in theory it could be called every packet.
+ *
+ **********************************************************************
+ */
 static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
 {
 	int  i;
@@ -505,28 +505,28 @@ static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
 }
 
 /*
-**********************************************************************
-* Routine: Phase 2 -- generate RC4KEY, given TK, P1K, IV16
-*
-* Inputs:
-*     tk[]      = Temporal key			 [128 bits]
-*     p1k[]     = Phase 1 output key		   [ 80 bits]
-*     iv16      = low 16 bits of IV counter	    [ 16 bits]
-* Output:
-*     rc4key[]  = the key used to encrypt the packet   [128 bits]
-*
-* Note:
-*     The value {TA, IV32, IV16} for Phase1/Phase2 must be unique
-*     across all packets using the same key TK value. Then, for a
-*     given value of TK[], this TKIP48 construction guarantees that
-*     the final RC4KEY value is unique across all packets.
-*
-* Suggested implementation optimization: if PPK[] is "overlaid"
-*     appropriately on RC4KEY[], there is no need for the final
-*     for loop below that copies the PPK[] result into RC4KEY[].
-*
-**********************************************************************
-*/
+ **********************************************************************
+ * Routine: Phase 2 -- generate RC4KEY, given TK, P1K, IV16
+ *
+ * Inputs:
+ *     tk[]      = Temporal key			 [128 bits]
+ *     p1k[]     = Phase 1 output key		   [ 80 bits]
+ *     iv16      = low 16 bits of IV counter	    [ 16 bits]
+ * Output:
+ *     rc4key[]  = the key used to encrypt the packet   [128 bits]
+ *
+ * Note:
+ *     The value {TA, IV32, IV16} for Phase1/Phase2 must be unique
+ *     across all packets using the same key TK value. Then, for a
+ *     given value of TK[], this TKIP48 construction guarantees that
+ *     the final RC4KEY value is unique across all packets.
+ *
+ * Suggested implementation optimization: if PPK[] is "overlaid"
+ *     appropriately on RC4KEY[], there is no need for the final
+ *     for loop below that copies the PPK[] result into RC4KEY[].
+ *
+ **********************************************************************
+ */
 static void phase2(u8 *rc4key, const u8 *tk, const u16 *p1k, u16 iv16)
 {
 	int  i;
-- 
2.30.1

