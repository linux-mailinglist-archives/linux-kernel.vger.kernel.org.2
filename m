Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF86D4207AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhJDJAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:00:42 -0400
Received: from ssh248.corpemail.net ([210.51.61.248]:42054 "EHLO
        ssh248.corpemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhJDJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:00:41 -0400
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((LNX1044)) with ASMTP (SSL) id YKL00145;
        Mon, 04 Oct 2021 16:58:45 +0800
Received: from localhost.localdomain (10.200.104.119) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2308.14; Mon, 4 Oct 2021 16:58:46 +0800
From:   Kai Song <songkai01@inspur.com>
To:     <linuxppc-dev@lists.ozlabs.org>
CC:     <oohall@gmail.com>, <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>, <dja@axtens.net>,
        Kai Song <songkai01@inspur.com>
Subject: [PATCH] powerpc/eeh:Fix docstrings in eeh
Date:   Mon, 4 Oct 2021 16:58:42 +0800
Message-ID: <20211004085842.255813-1-songkai01@inspur.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.119]
tUid:   202110041658463521b4e8b07959a647cec61b405cddca
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We fix the following warnings when building kernel with W=1:
arch/powerpc/kernel/eeh.c:598: warning: Function parameter or member 'function' not described in 'eeh_pci_enable'
arch/powerpc/kernel/eeh.c:774: warning: Function parameter or member 'edev' not described in 'eeh_set_dev_freset'
arch/powerpc/kernel/eeh.c:774: warning: expecting prototype for eeh_set_pe_freset(). Prototype was for eeh_set_dev_freset() instead
arch/powerpc/kernel/eeh.c:814: warning: Function parameter or member 'include_passed' not described in 'eeh_pe_reset_full'
arch/powerpc/kernel/eeh.c:944: warning: Function parameter or member 'ops' not described in 'eeh_init'
arch/powerpc/kernel/eeh.c:1451: warning: Function parameter or member 'include_passed' not described in 'eeh_pe_reset'
arch/powerpc/kernel/eeh.c:1526: warning: Function parameter or member 'func' not described in 'eeh_pe_inject_err'
arch/powerpc/kernel/eeh.c:1526: warning: Excess function parameter 'function' described in 'eeh_pe_inject_err'

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 arch/powerpc/kernel/eeh.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index e9b597ed423c..57a6868a41ab 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -589,6 +589,7 @@ EXPORT_SYMBOL(eeh_check_failure);
 /**
  * eeh_pci_enable - Enable MMIO or DMA transfers for this slot
  * @pe: EEH PE
+ * @function : EEH function
  *
  * This routine should be called to reenable frozen MMIO or DMA
  * so that it would work correctly again. It's useful while doing
@@ -761,8 +762,8 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 }
 
 /**
- * eeh_set_pe_freset - Check the required reset for the indicated device
- * @data: EEH device
+ * eeh_set_dev_freset - Check the required reset for the indicated device
+ * @edev: EEH device
  * @flag: return value
  *
  * Each device might have its preferred reset type: fundamental or
@@ -801,6 +802,7 @@ static void eeh_pe_refreeze_passed(struct eeh_pe *root)
 /**
  * eeh_pe_reset_full - Complete a full reset process on the indicated PE
  * @pe: EEH PE
+ * @include_passed: include passed-through devices?
  *
  * This function executes a full reset procedure on a PE, including setting
  * the appropriate flags, performing a fundamental or hot reset, and then
@@ -937,6 +939,7 @@ static struct notifier_block eeh_device_nb = {
 
 /**
  * eeh_init - System wide EEH initialization
+ * @ops: struct to trace EEH operation callback functions
  *
  * It's the platform's job to call this from an arch_initcall().
  */
@@ -1442,6 +1445,7 @@ static int eeh_pe_reenable_devices(struct eeh_pe *pe, bool include_passed)
  * eeh_pe_reset - Issue PE reset according to specified type
  * @pe: EEH PE
  * @option: reset type
+ * @include_passed: include passed-through devices?
  *
  * The routine is called to reset the specified PE with the
  * indicated type, either fundamental reset or hot reset.
@@ -1513,12 +1517,12 @@ EXPORT_SYMBOL_GPL(eeh_pe_configure);
  * eeh_pe_inject_err - Injecting the specified PCI error to the indicated PE
  * @pe: the indicated PE
  * @type: error type
- * @function: error function
+ * @func: error function
  * @addr: address
  * @mask: address mask
  *
  * The routine is called to inject the specified PCI error, which
- * is determined by @type and @function, to the indicated PE for
+ * is determined by @type and @func, to the indicated PE for
  * testing purpose.
  */
 int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
-- 
2.27.0

