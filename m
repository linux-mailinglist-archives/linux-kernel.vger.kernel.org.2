Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CE03EA320
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbhHLKtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:49:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57716 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbhHLKra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:30 -0400
Date:   Thu, 12 Aug 2021 10:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4E9rWL37QichCWyZIdOp9jiOeLPsXtAMC0kZsRfXobo=;
        b=HMrGo3DnNw29oc0nQBgT/1DHt3ySJixpI75/9c0/haKYB/sRtBUb1EsijLcyQPl20+73yX
        sNH0iwyWtYEfJEY/C1EMG+J3U4ry/nCAklu94Heuqg6jIMNnqmn/p/ru/ZJSt+LxExfXpq
        sShH2F4gOayCtjeIOKzv7aHCLcHfKM6Oo4o0THQ+ctU6K6HP27b8XQzFbWJL1tuMstf9nE
        sv5MfqyYAaQocCHl80EUsUMt3lCBsZbVHfDYfW1bKoXV+PZF6mmGHUyYido/Ed8OEREbAs
        OaJVlsgVe5JNx3t4bfDYWNAsfyyl90GJ82pd+t2hr8YJUEA0Gin8o/KVa4jW9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4E9rWL37QichCWyZIdOp9jiOeLPsXtAMC0kZsRfXobo=;
        b=QyIPdqg9YSBDItKeyj6g8G0c4tXRUftC/RNer518vG7GFqkjuzYtBEISZLxG88KLgohNhF
        i31IBVx5/m0QmQDw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] Documentation: Update irq_domain.rst with
 new lookup APIs
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162876522413.395.1066055895290644679.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     991007ba6ccad588504cbd1eadf19fbf15c67ace
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/991007ba6ccad588504cbd1eadf19fbf15c67ace
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 24 Jul 2021 12:40:23 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 11:39:38 +01:00

Documentation: Update irq_domain.rst with new lookup APIs

Catch up with the recent irqdomain updates, and document
{generic_,}handle_domain_irq(), irq_resolve_mapping() as well
as the deprecation of some of the older APIs.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/core-api/irq/irq-domain.rst | 28 +++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 53283b3..6979b4a 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -55,8 +55,24 @@ exist then it will allocate a new Linux irq_desc, associate it with
 the hwirq, and call the .map() callback so the driver can perform any
 required hardware setup.
 
-When an interrupt is received, irq_find_mapping() function should
-be used to find the Linux IRQ number from the hwirq number.
+Once a mapping has been established, it can be retrieved or used via a
+variety of methods:
+
+- irq_resolve_mapping() returns a pointer to the irq_desc structure
+  for a given domain and hwirq number, and NULL if there was no
+  mapping.
+- irq_find_mapping() returns a Linux IRQ number for a given domain and
+  hwirq number, and 0 if there was no mapping
+- irq_linear_revmap() is now identical to irq_find_mapping(), and is
+  deprecated
+- generic_handle_domain_irq() handles an interrupt described by a
+  domain and a hwirq number
+- handle_domain_irq() does the same thing for root interrupt
+  controllers and deals with the set_irq_reg()/irq_enter() sequences
+  that most architecture requires
+
+Note that irq domain lookups must happen in contexts that are
+compatible with a RCU read-side critical section.
 
 The irq_create_mapping() function must be called *atleast once*
 before any call to irq_find_mapping(), lest the descriptor will not
@@ -137,7 +153,9 @@ required.  Calling irq_create_direct_mapping() will allocate a Linux
 IRQ number and call the .map() callback so that driver can program the
 Linux IRQ number into the hardware.
 
-Most drivers cannot use this mapping.
+Most drivers cannot use this mapping, and it is now gated on the
+CONFIG_IRQ_DOMAIN_NOMAP option. Please refrain from introducing new
+users of this API.
 
 Legacy
 ------
@@ -157,6 +175,10 @@ for IRQ numbers that are passed to struct device registrations.  In that
 case the Linux IRQ numbers cannot be dynamically assigned and the legacy
 mapping should be used.
 
+As the name implies, the *_legacy() functions are deprecated and only
+exist to ease the support of ancient platforms. No new users should be
+added.
+
 The legacy map assumes a contiguous range of IRQ numbers has already
 been allocated for the controller and that the IRQ number can be
 calculated by adding a fixed offset to the hwirq number, and
