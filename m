Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE13DB45F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 09:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbhG3HSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 03:18:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43446 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbhG3HSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:18:14 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 48B1B1FDB8;
        Fri, 30 Jul 2021 07:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627629487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jiGuhZ6peP0OyKJAWTTjdxww+zrMIYBBDWdPs4yyawo=;
        b=gNlUD5gMM0mE/D5nD9CzenbbL5/H0UE/NgIAm/XUY858kcCf+GMFVnQBd5kS+JFNWF9YSV
        bdFmmwQYVnVydNdb8UHm5qJgkxqtpOKqem8jj7kF/gUtSOXbsFS/JoxDlSu2teBMdPE+BQ
        1jrymsXmezVEAPqIsKDItGMIGbmiS58=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F1E8613748;
        Fri, 30 Jul 2021 07:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id gEHcOa6nA2FufQAAGKfGzw
        (envelope-from <jgross@suse.com>); Fri, 30 Jul 2021 07:18:06 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 2/3] xen: assume XENFEAT_mmu_pt_update_preserve_ad being set for pv guests
Date:   Fri, 30 Jul 2021 09:18:03 +0200
Message-Id: <20210730071804.4302-3-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210730071804.4302-1-jgross@suse.com>
References: <20210730071804.4302-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XENFEAT_mmu_pt_update_preserve_ad is always set in Xen 4.0 and newer.
Remove coding assuming it might be zero.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/xen/enlighten_pv.c | 12 ++----------
 arch/x86/xen/mmu_pv.c       |  4 ++--
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 03149422dce2..753f63734c13 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -116,9 +116,8 @@ static void __init xen_banner(void)
 	HYPERVISOR_xen_version(XENVER_extraversion, &extra);
 
 	pr_info("Booting paravirtualized kernel on %s\n", pv_info.name);
-	printk(KERN_INFO "Xen version: %d.%d%s%s\n",
-	       version >> 16, version & 0xffff, extra.extraversion,
-	       xen_feature(XENFEAT_mmu_pt_update_preserve_ad) ? " (preserve-AD)" : "");
+	pr_info("Xen version: %d.%d%s (preserve-AD)\n",
+		version >> 16, version & 0xffff, extra.extraversion);
 }
 
 static void __init xen_pv_init_platform(void)
@@ -1302,13 +1301,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	xen_init_apic();
 #endif
 
-	if (xen_feature(XENFEAT_mmu_pt_update_preserve_ad)) {
-		pv_ops.mmu.ptep_modify_prot_start =
-			xen_ptep_modify_prot_start;
-		pv_ops.mmu.ptep_modify_prot_commit =
-			xen_ptep_modify_prot_commit;
-	}
-
 	machine_ops = xen_machine_ops;
 
 	/*
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index ade789e73ee4..1df5f01529e5 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2099,8 +2099,8 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 	.set_pte = xen_set_pte_init,
 	.set_pmd = xen_set_pmd_hyper,
 
-	.ptep_modify_prot_start = __ptep_modify_prot_start,
-	.ptep_modify_prot_commit = __ptep_modify_prot_commit,
+	.ptep_modify_prot_start = xen_ptep_modify_prot_start,
+	.ptep_modify_prot_commit = xen_ptep_modify_prot_commit,
 
 	.pte_val = PV_CALLEE_SAVE(xen_pte_val),
 	.pgd_val = PV_CALLEE_SAVE(xen_pgd_val),
-- 
2.26.2

