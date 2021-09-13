Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379524088B9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbhIMKGP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Sep 2021 06:06:15 -0400
Received: from mx1.emlix.com ([136.243.223.33]:51888 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238939AbhIMKE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:04:26 -0400
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id EC0E25FA7A;
        Mon, 13 Sep 2021 12:02:58 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: annotate alloc_workqueue() as printf
Date:   Mon, 13 Sep 2021 12:02:56 +0200
Message-ID: <2947630.YJcLE3A3dI@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This also enables checking of allows alloc_ordered_workqueue().

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 include/linux/workqueue.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 2ebef6b1a3d6..49e93f5b46ad 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -399,9 +399,9 @@ extern struct workqueue_struct *system_freezable_power_efficient_wq;
  * RETURNS:
  * Pointer to the allocated workqueue on success, %NULL on failure.
  */
-struct workqueue_struct *alloc_workqueue(const char *fmt,
-					 unsigned int flags,
-					 int max_active, ...);
+__printf(1, 4) struct workqueue_struct *alloc_workqueue(const char *fmt,
+							unsigned int flags,
+							int max_active, ...);
 
 /**
  * alloc_ordered_workqueue - allocate an ordered workqueue
-- 
2.33.0


-- 
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


