Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27C731EFC4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhBRTXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhBRSZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:25:15 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81B1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:24:34 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id j12so1851463pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nmYatdd9Kvf8g3bNRTakGJ8JnaKdh6hW5vuFhAf8L1w=;
        b=Q+LFMDuMt+asXUyu4RIxtSVL/rO0zZkcfVys/19i83XSrTlLf0JoHpryNuQUpjsQGV
         WzN2YjYzVAkxD6GGhW4FnDJrEIyU7suLhi0GKiVgrqhfaw13HuKd5+xZwBc0/4RKy8F7
         4hJEULvZfezon9W3GHupqWIb89eSVNM0btvavj+VKXFx+lCgom4uF0GGnbj8oH2W7HRq
         XfBSxYE5wrlunha4JA6Fv7wBL7/DXqv0ndNIUH+p++kyUdCbtVxPr0gDdfJfZv43nSsc
         OmYO7PVR/mK7b/6/rDbSWQNqR6FRSndEpz7kIGla1eIK3dtpajuW6iJ/TE+YOrChy/Iu
         uK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nmYatdd9Kvf8g3bNRTakGJ8JnaKdh6hW5vuFhAf8L1w=;
        b=m4D+QLmSOfffGl/ZooV5/AT6MpeyoZfVELkl8r3aPdJAwnXO1d192j/Yx0t0EF/xas
         9SdhP+x5jX6DEtHLW7Be1FCERRDNcMUlLQt8vEKfsqJXBnBsSSTsJfmoqlP/5+906CRu
         hNnjwcbLYYQnAJfIRcK4o0A4H0spn0JWR6RdHg1t1i0b+tfbX4q9G5q522ygQk77FHlH
         wXPWp37px27ixbHhbw/byEJMS04VrvPtGRIDrkAnzF4xDWFWlQI8Vzw/e/D/CGkYipFR
         Mam2PEL1zFto14pU6ZZvLntmv9kieQUYOp2byYGR3AIiKJGiWSZ7FMP31OE8RBT+AgG/
         jypA==
X-Gm-Message-State: AOAM533ni96iBNONpxcjD1z1vgptYcTl732Sw/0m/3dXbHAHa0414sKG
        0V7XLcjK2olfX89NKp20jFw=
X-Google-Smtp-Source: ABdhPJxkCcgci/1ZZN4IINUm8J3Sz606oKW6ZItoR8ELQUIZr7S/s865+Dh8wNz4KB9wLBQwMZV4+Q==
X-Received: by 2002:a62:e808:0:b029:1e5:f10a:e6d8 with SMTP id c8-20020a62e8080000b02901e5f10ae6d8mr5521210pfi.23.1613672674180;
        Thu, 18 Feb 2021 10:24:34 -0800 (PST)
Received: from localhost ([115.96.167.252])
        by smtp.gmail.com with ESMTPSA id c26sm7988281pfj.183.2021.02.18.10.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 10:24:33 -0800 (PST)
From:   Suryashankar Das <suryashankardas.2002@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net
Cc:     Suryashankar Das <suryashankardas.2002@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: rtl8188eu: Format comments
Date:   Thu, 18 Feb 2021 23:54:15 +0530
Message-Id: <20210218182414.49107-1-suryashankardas.2002@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <YC6oONjckmrSP2ip@kroah.com>
References: <YC6oONjckmrSP2ip@kroah.com>
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
 drivers/staging/rtl8188eu/core/rtw_security.c | 72 ++++++++-----------
 1 file changed, 29 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 46ba55a8952a..da26a3c705f8 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -126,9 +126,7 @@ static __le32 getcrc32(u8 *buf, int len)
 	return cpu_to_le32(~crc);    /* transmit complement, per CRC-32 spec */
 }
 
-/*
-	Need to consider the fragment  situation
-*/
+/* Need to consider the fragment  situation */
 void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
 	int	curfragnum, length;
@@ -465,23 +463,17 @@ static const unsigned short Sbox1[2][256] = {  /* Sbox for hash (can be in ROM)
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
+/**
+ * phase1() - generate P1K, given TA, TK, IV32
+ * @tk[]: temporal key [128 bits]
+ * @ta[]: transmitter's MAC address [ 48 bits]
+ * @iv32: upper 32 bits of IV [ 32 bits]
+ *
+ * This function only needs to be called every 2**16 packets,
+ * although in theory it could be called every packet.
+ *
+ * Return: p1k[] - Phase 1 key [ 80 bits]
+ */
 static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
 {
 	int  i;
@@ -504,29 +496,23 @@ static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
 	}
 }
 
-/*
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
+/**
+ * phase2() - generate RC4KEY, given TK, P1K, IV16
+ * @tk[]: Temporal key [128 bits]
+ * @p1k[]: Phase 1 output key [ 80 bits]
+ * @iv16: low 16 bits of IV counter [ 16 bits]
+ *
+ * The value {TA, IV32, IV16} for Phase1/Phase2 must be unique
+ * across all packets using the same key TK value. Then, for a
+ * given value of TK[], this TKIP48 construction guarantees that
+ * the final RC4KEY value is unique across all packets.
+ *
+ * Suggested implementation optimization: if PPK[] is "overlaid"
+ * appropriately on RC4KEY[], there is no need for the final
+ * for loop below that copies the PPK[] result into RC4KEY[].
+ *
+ * Return: rc4key[] - the key used to encrypt the packet [128 bits]
+ */
 static void phase2(u8 *rc4key, const u8 *tk, const u16 *p1k, u16 iv16)
 {
 	int  i;
-- 
2.30.1

