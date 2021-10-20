Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317D743471D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhJTInT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhJTInR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:43:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB87CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 01:41:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m42so17146546wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 01:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0DxiQ6TI/H+Bup1Rn6Wt67LAOz/W7N5QmWO1MsPbNPg=;
        b=hk9EFm6Ew7/OwTOILie+GA5vHO1+XXROBxMTy0GYFycHK16AAuIKgfwOauIM9zhSoT
         iNyaXuY0zIlwORFLZ2Jn4WR4UdQ2HEUgjwoVudlGjMCkYLXVzsJh3xzXwLCOKQY0xHeE
         ION4kdrI9I/wwG+fHY2eN5Js8chUiGO56m2+OYdOojZrLn6Ipw/dw1Wxph5PsBB48aAI
         NgDUa9XVtwa1qAOOeO8LbZtahrUKm2BLEoHwAHF7NokfQzDFvYsIXOfYjKm5ixEDcaAL
         dHUGxQBsrIKchpo+QJ/yM2dv5zeWcmVM7UX1Jtrg9/09qlEqD5etSvOm6TdWrZawFu04
         L5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0DxiQ6TI/H+Bup1Rn6Wt67LAOz/W7N5QmWO1MsPbNPg=;
        b=CU/oR+OiCnN9v9mT/41ui3+DqDsHryvfYqRcFlFXPXG2u3OEIunu4EGVq1IsepbvUx
         E0ovmVRdeBLc941AzArC+oebws5VxzM2CLVK+GXU0DCugomiNydKsNgrckg7JsnRO8kK
         4vDUtvhc/H5r3aTu+59mRWtrN8FJcTFB5uDXTJuNTBoJx5/+o4BXPmPGfarNDJiwJKnc
         q53H60TLC4CrFgaiIRx1+oZ5W5nbut9esjOWfDvpnXZFXOhu4yl0p4osRP164FbXyQru
         etX/qS2Z+MuF3bGpFJB5zaNRvVss907mhMfju6E/QPO0cG3+RCHmXcBiulo8GImC17nq
         /GBg==
X-Gm-Message-State: AOAM532P8JKleNXU/rCkskBJJD9QGd1oGHpaRdzafIqdOYKRJK+sOvWc
        5XmuXPcHMsZ00vT4TSFPTwM=
X-Google-Smtp-Source: ABdhPJy2PDjuqRp+g9ERz9QKvam31pZxlBxQEt2dG+zVJYs9p8Euwqqiib7deD9G9KBmhre8peMfFA==
X-Received: by 2002:adf:ead0:: with SMTP id o16mr18972262wrn.106.1634719261399;
        Wed, 20 Oct 2021 01:41:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id l13sm1348612wrn.79.2021.10.20.01.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 01:41:00 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH] staging: vt6655: Rename `by_preamble_type` parameter
Date:   Wed, 20 Oct 2021 09:40:33 +0100
Message-Id: <20211020084033.414994-1-karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop `by` prefix in the first parameter of `bb_get_frame_time` function.
As the original argument, `byPreambleType`, was renamed to `preamble_type`,
the parameter referring to it is now renamed to match the new naming
convention.
Update `bb_get_frame_time` comment to reflect that change.

This patch is a follow-up work to this commit:
    Commit 548b6d7ebfa4 ("staging: vt6655: Rename byPreambleType field")

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
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

