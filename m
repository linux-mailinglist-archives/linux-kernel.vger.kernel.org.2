Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA146316A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBJP33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:29:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60678 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhBJP20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:28:26 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612970862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=izmVBGwgZIHobxzE3AKB3/PFOL7XlGjrBYkkrejnxqA=;
        b=Gy3/NgyO2BGhmzAQwucpYtHiUBH7oMqdaFRQqH/jYBxQKmm4VNnbkGvgO0Lib1ZzA9NjqQ
        DLC+sMliBRHGg6FMsQDj1WK8fYojTmpPQeREB2B8SHNaeQUCNar8iMMboJ4IxHLAiddx3e
        IIsZ0G1jEeB421sUk+Dx65HubQwKerjGmyasvS9dhMCmxA0GvmEENCgcxucwl4h/aftjZu
        5IqTKadxjzXGLTkt98q4MjpdNCq/VSQfswCKxKfWMt7+xEsCqBVzB2S2mRtoEpQVp0a5EE
        dACDgGzQwZrTTsFDoUwoPt0XwZFUbbikB0tf3qLpnErivThJVFywXvT7Lh5xKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612970862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=izmVBGwgZIHobxzE3AKB3/PFOL7XlGjrBYkkrejnxqA=;
        b=KqL+aFrQeS6pNATjhzD2eKbnUMsIHoJJOtKWV6L2Nc60iRmAY+bk1Ab7Fs+wxbEsbJxpDo
        4HdZDGI4NpebaxBg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Juergen Gross <jgross@suse.com>, x86@kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH] x86/pci: Create PCI/MSI irqdomain after x86_init.pci.arch_init()
Date:   Wed, 10 Feb 2021 16:27:41 +0100
Message-ID: <87pn18djte.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Invoking x86_init.irqs.create_pci_msi_domain() before
x86_init.pci.arch_init() breaks XEN PV.

The XEN_PV specific pci.arch_init() function overrides the default
create_pci_msi_domain() which is obviously too late.

As a consequence the XEN PV PCI/MSI allocation goes through the native
path which runs out of vectors and causes malfunction.

Invoke it after x86_init.pci.arch_init().

Fixes: 6b15ffa07dc3 ("x86/irq: Initialize PCI/MSI domain at PCI init time")
Reported-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org
---
 arch/x86/pci/init.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/arch/x86/pci/init.c
+++ b/arch/x86/pci/init.c
@@ -9,16 +9,23 @@
    in the right sequence from here. */
 static __init int pci_arch_init(void)
 {
-	int type;
-
-	x86_create_pci_msi_domain();
+	int type, pcbios = 1;

	type = pci_direct_probe();

	if (!(pci_probe & PCI_PROBE_NOEARLY))
		pci_mmcfg_early_init();

-	if (x86_init.pci.arch_init && !x86_init.pci.arch_init())
+	if (x86_init.pci.arch_init)
+		pcbios = x86_init.pci.arch_init();
+
+	/*
+	 * Must happen after x86_init.pci.arch_init(). Xen sets up the
+	 * x86_init.irqs.create_pci_msi_domain there.
+	 */
+	x86_create_pci_msi_domain();
+
+	if (!pcbios)
		return 0;

	pci_pcbios_init();
