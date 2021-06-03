Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0989839986D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 05:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFCDNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 23:13:36 -0400
Received: from smtprelay0084.hostedemail.com ([216.40.44.84]:60152 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229611AbhFCDNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 23:13:34 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 26261DE1A;
        Thu,  3 Jun 2021 03:11:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 515A42351F7;
        Thu,  3 Jun 2021 03:11:49 +0000 (UTC)
Message-ID: <8e60e269d4fe74af767baee1b3048dda6ac17e05.camel@perches.com>
Subject: [PATCH] workqueue: Add back __printf format validation
From:   Joe Perches <joe@perches.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 02 Jun 2021 20:11:48 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.05
X-Stat-Signature: o71mai91s4p6c7ujidh48zg4aj4mapp3
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 515A42351F7
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+YC2jEEJj+0YTTF3yPHpjCSiJzL5oq/OE=
X-HE-Tag: 1622689909-951680
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for
workqueues") indirectly removed the printf validation for alloc_workqueue.

Add it back.

Signed-off-by: Joe Perches <joe@perches.com>
---

compiled x86-64 defconfig only, but there _might_ be some new
warning for a fmt/arg mismatch somewhere.  Hope not...

 include/linux/workqueue.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index d15a7730ee18b..7c177267a81f3 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -404,6 +404,7 @@ extern struct workqueue_struct *system_freezable_power_efficient_wq;
  * RETURNS:
  * Pointer to the allocated workqueue on success, %NULL on failure.
  */
+__printf(1, 4)
 struct workqueue_struct *alloc_workqueue(const char *fmt,
 					 unsigned int flags,
 					 int max_active, ...);


