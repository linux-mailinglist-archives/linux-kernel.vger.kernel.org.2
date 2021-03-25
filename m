Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C9A3486B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 02:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhCYB4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 21:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCYB4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 21:56:03 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E7C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 18:56:02 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y5so354334qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 18:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y12RqPVb5onZRkqmcNXS/4VG3RBAeiyXVnjI/3Uhls8=;
        b=ZgnYR8R0rs3YeBUDDccQCJ19kQS2EPyPE/NYONcfDI0XZw5R1+jZxYREdEw9hREs8U
         ea/EN8FzaZE8LAweYEbXz8zJOBwQ7nkKc+aaHmk4NduYBGOmKuxKDZeZnIYjSdTwB2UO
         Qw1oGz0oAPGZ3N67aQ9m5f+F+Nl4LNKJyJXpgeq9/T3j3TyYDN4tvh/dqrWZ2CNJN6ag
         D9iCYhB+E9xW893qIhmwZguhkiF7RSjbsfcyocl8fBjYr+bKqP/FcGqtKxIctteM/MUH
         +mw2dE93Xwh+SWZMohfK4aUsjO7OfFyCmJp42I3vYO8n8ouZGA5rLhSllDN4TzYnHGAP
         3eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y12RqPVb5onZRkqmcNXS/4VG3RBAeiyXVnjI/3Uhls8=;
        b=VF5MHY0pkBNEJAhtdx9acbzKQjPKaMESJULdlNRsu0QJaXe9Av4q9103OwLEbxCSjs
         /pCLvB3KjhgDHIIOmg3GDjzrNt7+GlBEyrr15BxwXmZCHvzwaHXvmLTpb4IFPvN0hdw0
         FSMGCW3zwyU1CFEhzogQdIV8F1SzCMy308IRYIkw29bdmZ5BuyvJsGqaMo0maOhsyGtV
         cOk39hNZbyoAI2Jd3muwxTN1a/Bmkz9OXnm/TW8aczy2gP1qTuLxfeLFT1ZUUsJhgg7b
         LtOB1mZ/NNB39TR6WVjEOjyk2ZiBB+RB6s+IYiQtQIijPh4pPSV8i05Ys7Naemg+URSX
         GWIw==
X-Gm-Message-State: AOAM531/7wIXRhAWSSiXdD0Spwn4Kjx7/DLfb7MWy1lusiYpy1G/tH8+
        ebKPVcY56HbWOlqt7sLluVI=
X-Google-Smtp-Source: ABdhPJw95i6Gz517xj0DGjtll6pHM0cTlZNeLuoxedxyJCt9BrYYe9B3MB8VDhZczbsQJTLz9ogmrQ==
X-Received: by 2002:a37:9b82:: with SMTP id d124mr6014031qke.489.1616637361819;
        Wed, 24 Mar 2021 18:56:01 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.55.193])
        by smtp.gmail.com with ESMTPSA id f20sm2704752qtp.67.2021.03.24.18.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 18:56:01 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     haver@linux.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V2] misc: genwqe: Rudimentary typo fixes
Date:   Thu, 25 Mar 2021 07:25:13 +0530
Message-Id: <20210325015513.9373-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/requsted/requested/
s/equests/requests/
s/occured/occurred/
s/conditon/condition/
s/emtpy/empty/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
  One change incorporated and one elimilated , as Randy found

 drivers/misc/genwqe/card_ddcb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
index 0db4000dedf2..500b1feaf1f6 100644
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
@@ -498,7 +498,7 @@ int __genwqe_wait_ddcb(struct genwqe_dev *cd, struct ddcb_requ *req)

 	/*
 	 * We need to distinguish 3 cases here:
-	 *   1. rc == 0              timeout occured
+	 *   1. rc == 0              timeout occurred
 	 *   2. rc == -ERESTARTSYS   signal received
 	 *   3. rc > 0               remaining jiffies condition is true
 	 */
@@ -982,7 +982,7 @@ static int genwqe_next_ddcb_ready(struct genwqe_dev *cd)

 	spin_lock_irqsave(&queue->ddcb_lock, flags);

-	if (queue_empty(queue)) { /* emtpy queue */
+	if (queue_empty(queue)) { /* empty queue */
 		spin_unlock_irqrestore(&queue->ddcb_lock, flags);
 		return 0;
 	}
@@ -1002,7 +1002,7 @@ static int genwqe_next_ddcb_ready(struct genwqe_dev *cd)
  * @cd:         pointer to genwqe device descriptor
  *
  * Keep track on the number of DDCBs which ware currently in the
- * queue. This is needed for statistics as well as conditon if we want
+ * queue. This is needed for statistics as well as condition if we want
  * to wait or better do polling in case of no interrupts available.
  */
 int genwqe_ddcbs_in_flight(struct genwqe_dev *cd)
--
2.30.1

