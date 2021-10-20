Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F9434BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJTN0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTN0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:26:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92375C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:23:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b189-20020a1c1bc6000000b0030da052dd4fso10234856wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xK9DNZI2WxuIz+Ctgl2vXcWcIENDorkB7WicrZ5sMlw=;
        b=D2jt52BW4x4UxWlPWIeJILigF+dk35bbQBWylH2BYt9nYqPexh7mFTEru41QxZwN+O
         UHut3BOS91CHPbXg07iVYWFqs4M6XrrjFpzFzxaA63EkYAIR8VM4vwdns8mZVepmfonc
         Joshy7f06L3vP1zPh1ybGSHok0GjxN+1KHpeOnqs6fEDuDAJQW2MusejKeaEZgK0KKk/
         RjlcisnP4yilFg5Nq5xZlYkmHCguyJQDikhfTTtXCUrNGUPPrRkOhUCyImEf8xmHYEpA
         qDHcnnEgZCFfvYYpj/ZwGY6JVWcMhpte1zpejzNRmuTDcjIrwt2j797AS7szY+pCNQAM
         Qbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xK9DNZI2WxuIz+Ctgl2vXcWcIENDorkB7WicrZ5sMlw=;
        b=cBeRbI0AVTsobnzD7Ad5iSu9iid/zvdl3bjzxkSlz9S4S9ptegDBy+M7fAuKi6sY4z
         NPoUie0O1CAQf8kIsIFDu3qNqlTx85W1pNO02irbmAMgDRIdj/Nu0iH1slFLIpkA8Qkq
         yYr8IA8TI59MSOj5z0ujpPS1rcr4EuzFDPX6J5EPdQBFW/lgCMUZ9GziTIKNIj7eigHN
         tXFKPx+DqOpW/MW2+VSsLsUU99RUI6lZg9y7mdnSbEKFAkg8zp0klQ09Srz7Fo4AbjkC
         ppTJKjh1dAgr8yXFPkcVuG33WznlU+eQCp9AU/ozg7sNrW9C/FON7PQD6o8r8cVwWTwU
         r1Mg==
X-Gm-Message-State: AOAM532KX9kPRwFXxfabSVX4D14rEQR2B1aNG+axtxBxA4I+6liHbzzi
        SVJS22waJB4lUf1XjFg6DnQ=
X-Google-Smtp-Source: ABdhPJzA1mhv83/9w7/Y0vUlp7/KoKz3Whha9WKlXxhTN+u0wOhzDSF+ciF2aRR4xM8TA5VKHzYNzA==
X-Received: by 2002:adf:bc42:: with SMTP id a2mr52925368wrh.4.1634736231141;
        Wed, 20 Oct 2021 06:23:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id l5sm2064106wru.24.2021.10.20.06.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:23:50 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2] staging: vt6655: Rename `by_preamble_type` parameter
Date:   Wed, 20 Oct 2021 14:23:26 +0100
Message-Id: <20211020132326.417059-1-karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop Hungarian notation prefix in the first parameter of
`bb_get_frame_time` function. Update the comment to
reflect that change.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
v2:
* Update the change log: delete description of why `byPreambleType`
  rename influenced that change and reference to an already merged commit

 drivers/staging/vt6655/baseband.c | 6 +++---
 drivers/staging/vt6655/baseband.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 5efca92f1f18..8f9177db6663 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1691,7 +1691,7 @@ static const unsigned short awc_frame_time[MAX_RATE] = {
  *
  * Parameters:
  *  In:
- *      by_preamble_type  - Preamble Type
+ *      preamble_type     - Preamble Type
  *      by_pkt_type        - PK_TYPE_11A, PK_TYPE_11B, PK_TYPE_11GB, PK_TYPE_11GA
  *      cb_frame_length   - Baseband Type
  *      tx_rate           - Tx Rate
@@ -1700,7 +1700,7 @@ static const unsigned short awc_frame_time[MAX_RATE] = {
  * Return Value: FrameTime
  *
  */
-unsigned int bb_get_frame_time(unsigned char by_preamble_type,
+unsigned int bb_get_frame_time(unsigned char preamble_type,
 			       unsigned char by_pkt_type,
 			       unsigned int cb_frame_length,
 			       unsigned short tx_rate)
@@ -1717,7 +1717,7 @@ unsigned int bb_get_frame_time(unsigned char by_preamble_type,
 	rate = (unsigned int)awc_frame_time[rate_idx];
 
 	if (rate_idx <= 3) {		    /* CCK mode */
-		if (by_preamble_type == 1) /* Short */
+		if (preamble_type == 1) /* Short */
 			preamble = 96;
 		else
 			preamble = 192;
diff --git a/drivers/staging/vt6655/baseband.h b/drivers/staging/vt6655/baseband.h
index 0a30afaa7cc3..15b2802ed727 100644
--- a/drivers/staging/vt6655/baseband.h
+++ b/drivers/staging/vt6655/baseband.h
@@ -44,7 +44,7 @@
 #define TOP_RATE_2M         0x00200000
 #define TOP_RATE_1M         0x00100000
 
-unsigned int bb_get_frame_time(unsigned char by_preamble_type,
+unsigned int bb_get_frame_time(unsigned char preamble_type,
 			       unsigned char by_pkt_type,
 			       unsigned int cb_frame_length,
 			       unsigned short w_rate);
-- 
2.30.2

