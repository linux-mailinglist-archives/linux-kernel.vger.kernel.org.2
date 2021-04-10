Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427BE35AD23
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 14:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhDJMA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 08:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234091AbhDJMA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 08:00:28 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9997161165;
        Sat, 10 Apr 2021 12:00:13 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lVCHb-006hZH-9K; Sat, 10 Apr 2021 13:00:11 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [PATCH] genirq/irqaction: Move dev_id and percpu_dev_id in a union
Date:   Sat, 10 Apr 2021 13:00:08 +0100
Message-Id: <20210410120008.3034091-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_id and percpu_dev_id are mutually exclusive in struct irqaction,
as they conceptually represent the same thing, only in a per-cpu
fashion.

Move them into an anonymous union, saving a few bytes on the way.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/interrupt.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 967e25767153..4383ee033acf 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -109,8 +109,10 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
  */
 struct irqaction {
 	irq_handler_t		handler;
-	void			*dev_id;
-	void __percpu		*percpu_dev_id;
+	union {
+		void		*dev_id;
+		void __percpu	*percpu_dev_id;
+	};
 	struct irqaction	*next;
 	irq_handler_t		thread_fn;
 	struct task_struct	*thread;
-- 
2.30.2

