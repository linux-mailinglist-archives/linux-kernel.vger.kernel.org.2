Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF4944617B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 10:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhKEJpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 05:45:07 -0400
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:37834 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhKEJpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 05:45:04 -0400
X-Greylist: delayed 2172 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Nov 2021 05:45:04 EDT
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1mivAm-0003It-SP; Fri, 05 Nov 2021 09:06:08 +0000
Received: from ben by rainbowdash with local (Exim 4.94.2)
        (envelope-from <ben@rainbowdash>)
        id 1mivAm-0011Kr-CB; Fri, 05 Nov 2021 09:06:08 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] irqdomain: check irq mapping against domain size
Date:   Fri,  5 Nov 2021 09:06:01 +0000
Message-Id: <20211105090601.243416-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq translate code does not check the irq number against
the maximum a domain can handle. This can cause an OOPS if
the firmware data has been damaged in any way. Check the intspec
or fwdata against the irqdomain and return -EINVAL if over.

This is the result of bug somewhere in the boot of a SiFive Unmatched
board where the 5th argument of the pcie node is being damaged which
causes an OOPS in the startup code.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 kernel/irq/irqdomain.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 6284443b87ec..e61397420723 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -906,6 +906,8 @@ int irq_domain_xlate_onecell(struct irq_domain *d, struct device_node *ctrlr,
 {
 	if (WARN_ON(intsize < 1))
 		return -EINVAL;
+	if (WARN_ON(intspec[0] > d->hwirq_max))
+		return -EINVAL;
 	*out_hwirq = intspec[0];
 	*out_type = IRQ_TYPE_NONE;
 	return 0;
@@ -948,6 +950,8 @@ int irq_domain_xlate_onetwocell(struct irq_domain *d,
 {
 	if (WARN_ON(intsize < 1))
 		return -EINVAL;
+	if (WARN_ON(intspec[0] > d->hwirq_max))
+		return -EINVAL;
 	*out_hwirq = intspec[0];
 	if (intsize > 1)
 		*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
@@ -973,6 +977,8 @@ int irq_domain_translate_onecell(struct irq_domain *d,
 {
 	if (WARN_ON(fwspec->param_count < 1))
 		return -EINVAL;
+	if (WARN_ON(fwspec->param[0] > d->hwirq_max))
+		return -EINVAL;
 	*out_hwirq = fwspec->param[0];
 	*out_type = IRQ_TYPE_NONE;
 	return 0;
@@ -994,6 +1000,8 @@ int irq_domain_translate_twocell(struct irq_domain *d,
 {
 	if (WARN_ON(fwspec->param_count < 2))
 		return -EINVAL;
+	if (WARN_ON(fwspec->param[0] > d->hwirq_max))
+		return -EINVAL;
 	*out_hwirq = fwspec->param[0];
 	*out_type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 	return 0;
-- 
2.30.2

