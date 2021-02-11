Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3FC31858C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 08:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhBKHKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 02:10:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:52880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhBKHKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 02:10:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613027397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=C91ebXZNzoKbv/EE2K4v30/3rR8vNp/LicttouaukRw=;
        b=qNuAiZPpHtlua9QmiOIWYUpNAOS+9eEax533G/t7wi2RZdO+bmAHddRioIDtTF74jYoWxz
        eAeo/pTY9sH9o+4cM8Y8nkQbem/rEMC3ilUp1chL2lcl2e0EH6WFbPXg2OGCPs6a85woot
        WIlz07/w3uYyxb17mC2QN149iItiMC4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57B08B113;
        Thu, 11 Feb 2021 07:09:57 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] irq: simplify condition in irq_matrix_reserve()
Date:   Thu, 11 Feb 2021 08:09:53 +0100
Message-Id: <20210211070953.5914-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The if condition in irq_matrix_reserve() can be much simpler.

While at it fix a typo in the comment.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 kernel/irq/matrix.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 651a4ad6d711..1f02a5c801a3 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -337,15 +337,14 @@ void irq_matrix_assign(struct irq_matrix *m, unsigned int bit)
  * irq_matrix_reserve - Reserve interrupts
  * @m:		Matrix pointer
  *
- * This is merily a book keeping call. It increments the number of globally
+ * This is merely a book keeping call. It increments the number of globally
  * reserved interrupt bits w/o actually allocating them. This allows to
  * setup interrupt descriptors w/o assigning low level resources to it.
  * The actual allocation happens when the interrupt gets activated.
  */
 void irq_matrix_reserve(struct irq_matrix *m)
 {
-	if (m->global_reserved <= m->global_available &&
-	    m->global_reserved + 1 > m->global_available)
+	if (m->global_reserved == m->global_available)
 		pr_warn("Interrupt reservation exceeds available resources\n");
 
 	m->global_reserved++;
-- 
2.26.2

