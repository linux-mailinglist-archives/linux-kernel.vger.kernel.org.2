Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AAA412EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhIUHEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:04:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49854 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhIUHD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:03:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C24531FD60;
        Tue, 21 Sep 2021 07:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632207747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7thuIDnGv5oZ6BTCP+zSuwIv02tmpVWBhc2C3gScL0A=;
        b=jAdmKx0bi/GxFtRD1x8hHCZEDyOQ/cvhk5YcWnckIWx43Mk91SCNdODfzpafnCcTY+64Og
        vWaYMT7ZXT1Bn1xhQ/qUlHk1gIqL1CrkEwp8TVH8oVO0BWYJ+hsBQRAjLikxcKNAX3wtvH
        O9djHthfpfICEmgIIifKGpYoHOBe8xQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7949113B97;
        Tue, 21 Sep 2021 07:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tMNXHIODSWHLegAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 21 Sep 2021 07:02:27 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/xen: remove unneeded preempt_disable() from xen_irq_enable()
Date:   Tue, 21 Sep 2021 09:02:26 +0200
Message-Id: <20210921070226.32021-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling preemption in xen_irq_enable() is not needed. There is no
risk of missing events due to preemption, as preemption can happen
only in case an event is being received, which is just the opposite
of missing an event.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/irq.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index dfa091d79c2e..ba9b14a97109 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -57,24 +57,20 @@ asmlinkage __visible void xen_irq_enable(void)
 {
 	struct vcpu_info *vcpu;
 
-	/*
-	 * We may be preempted as soon as vcpu->evtchn_upcall_mask is
-	 * cleared, so disable preemption to ensure we check for
-	 * events on the VCPU we are still running on.
-	 */
-	preempt_disable();
-
 	vcpu = this_cpu_read(xen_vcpu);
 	vcpu->evtchn_upcall_mask = 0;
 
-	/* Doesn't matter if we get preempted here, because any
-	   pending event will get dealt with anyway. */
+	/*
+	 * Now preemption could happen, but this is only possible if an event
+	 * was handled, so missing an event due to preemption is not
+	 * possible at all.
+	 * The worst possible case is to be preempted and then check events
+	 * pending on the old vcpu, but this is not problematic.
+	 */
 
 	barrier(); /* unmask then check (avoid races) */
 	if (unlikely(vcpu->evtchn_upcall_pending))
 		xen_force_evtchn_callback();
-
-	preempt_enable();
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_irq_enable);
 
-- 
2.26.2

