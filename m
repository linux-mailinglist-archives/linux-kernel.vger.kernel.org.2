Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E66934719B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 07:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhCXG0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 02:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhCXG0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 02:26:46 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DC1C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 23:26:46 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id t5so11774767qvs.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zx5C6uMzxw4Vl/QH2wrrkx5fCD68akObEgrDpyyxlCk=;
        b=b/s6ea++OmzKaHyjlF4jVKmnk1lm7saJJobR/xeUEudDq+TzvYMh7wTnJ1tKscrSYv
         SzCPxZ2Rc12zA9CHXAaAe7n2kNbK/EL7TaT3scmiiXyxaw6CltOT1OMcrNU6fOVvrnIJ
         aFjh5rF+RtkDymmSboVqhhnBCgUtNH+apxn0dUN8ufTpEa7ksSii9TMRx3r0mZCigBJn
         eqAflwQJ8E5Dsezw6k7PN0fZPTkGLsOTepTrzDtnFEcIqq0ZqgScxf3RzyrR+Z4pZGdt
         9TX5MSKoHuXEApCYhhQsZmY2IPWsYtcNYoqzJpVimUaPog+SwfmA89EZiUi22tLPgTvf
         GApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zx5C6uMzxw4Vl/QH2wrrkx5fCD68akObEgrDpyyxlCk=;
        b=BCmwr9f64LGDR244wv9UHBMEPzDlAbhDLV8TCi2K+iR+BzoN61IVIJYuDGrgma2pWZ
         CiHHdx90kvhxgdQWLTqj2aCk8s+E3Usou3EKTXYUlBvTZB/LDm+4xSQRXkguyLsMngPe
         NGUltF7o5ssEQnCnnEMzavls+s1FGyypGVHZd4B1JbHVGOMjAukW7a+lupMiDLCWHefI
         1zjIyZJK6UXr8mlbOSZPfIHJTVraAjQ3cRoUr7L6KUZgROLP/W13LW3Jx+DLiDAIvBfK
         TnGdv0Gm7+s6/LeS5epqiVnO+ieWs48JHl9PZpkzUxAbfdACLCjPwDm24AEhh8zhoXx9
         G0PQ==
X-Gm-Message-State: AOAM533JfuCfTqfgChdXTJ77QiNZ1pEf5q15M2CAfR+UmWGTATokR1ys
        vnZRyQVtoPbPMwYb23oyjgI=
X-Google-Smtp-Source: ABdhPJzXOlIsTO3ZJ60v4ubmCQ6pCT4W29rAfS8UsS7gOqmTnxeNDvElR+7W/aigEHC7OSxxhZ3QAw==
X-Received: by 2002:a0c:b410:: with SMTP id u16mr1717214qve.8.1616567205719;
        Tue, 23 Mar 2021 23:26:45 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.37.194])
        by smtp.gmail.com with ESMTPSA id f12sm851826qti.63.2021.03.23.23.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 23:26:44 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     haver@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] misc: genwqe: Rudimentary typo fixes
Date:   Wed, 24 Mar 2021 11:58:28 +0530
Message-Id: <20210324062828.14807-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/requsted/requested/  .....two different places.
s/equests/requests/
s/occured/occurred/    ......two different places.
s/conditon/condition/
s/requestors/requesters/


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/misc/genwqe/card_ddcb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
index 0db4000dedf2..98f6cd3fc66a 100644
--- a/drivers/misc/genwqe/card_ddcb.c
+++ b/drivers/misc/genwqe/card_ddcb.c
@@ -316,7 +316,7 @@ static int enqueue_ddcb(struct genwqe_dev *cd, struct ddcb_queue *queue,

 /**
  * copy_ddcb_results() - Copy output state from real DDCB to request
- * @req:        pointer to requsted DDCB parameters
+ * @req:        pointer to requested DDCB parameters
  * @ddcb_no:    pointer to ddcb number being tapped
  *
  * Copy DDCB ASV to request struct. There is no endian
@@ -356,7 +356,7 @@ static void copy_ddcb_results(struct ddcb_requ *req, int ddcb_no)
 }

 /**
- * genwqe_check_ddcb_queue() - Checks DDCB queue for completed work equests.
+ * genwqe_check_ddcb_queue() - Checks DDCB queue for completed work requests.
  * @cd:         pointer to genwqe device descriptor
  * @queue:	queue to be checked
  *
@@ -460,7 +460,7 @@ static int genwqe_check_ddcb_queue(struct genwqe_dev *cd,
 /**
  * __genwqe_wait_ddcb(): Waits until DDCB is completed
  * @cd:         pointer to genwqe device descriptor
- * @req:        pointer to requsted DDCB parameters
+ * @req:        pointer to requested DDCB parameters
  *
  * The Service Layer will update the RETC in DDCB when processing is
  * pending or done.
@@ -498,7 +498,7 @@ int __genwqe_wait_ddcb(struct genwqe_dev *cd, struct ddcb_requ *req)

 	/*
 	 * We need to distinguish 3 cases here:
-	 *   1. rc == 0              timeout occured
+	 *   1. rc == 0              timeout occurred
 	 *   2. rc == -ERESTARTSYS   signal received
 	 *   3. rc > 0               remaining jiffies condition is true
 	 */
@@ -543,7 +543,7 @@ int __genwqe_wait_ddcb(struct genwqe_dev *cd, struct ddcb_requ *req)
 		return -EINVAL;
 	}

-	/* Severe error occured. Driver is forced to stop operation */
+	/* Severe error occurred. Driver is forced to stop operation */
 	if (cd->card_state != GENWQE_CARD_USED) {
 		dev_err(&pci_dev->dev,
 			"[%s] err: DDCB#%d forced to stop (rc=%d)\n",
@@ -1002,7 +1002,7 @@ static int genwqe_next_ddcb_ready(struct genwqe_dev *cd)
  * @cd:         pointer to genwqe device descriptor
  *
  * Keep track on the number of DDCBs which ware currently in the
- * queue. This is needed for statistics as well as conditon if we want
+ * queue. This is needed for statistics as well as condition if we want
  * to wait or better do polling in case of no interrupts available.
  */
 int genwqe_ddcbs_in_flight(struct genwqe_dev *cd)
@@ -1182,7 +1182,7 @@ static irqreturn_t genwqe_vf_isr(int irq, void *dev_id)
  *
  * The idea is to check if there are DDCBs in processing. If there are
  * some finished DDCBs, we process them and wakeup the
- * requestors. Otherwise we give other processes time using
+ * requesters. Otherwise we give other processes time using
  * cond_resched().
  */
 static int genwqe_card_thread(void *data)
--
2.30.1

