Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A33BE1E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 06:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhGGEYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 00:24:39 -0400
Received: from ozlabs.ru ([107.174.27.60]:50696 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhGGEYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 00:24:38 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Jul 2021 00:24:38 EDT
Received: from fstn1-p1.ozlabs.ibm.com. (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 8F9D3AE80026;
        Wed,  7 Jul 2021 00:13:47 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH kernel] KVM: PPC: Book3S HV: Make unique debugfs nodename
Date:   Wed,  7 Jul 2021 14:13:44 +1000
Message-Id: <20210707041344.3803554-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it is vm-$currentpid which works as long as there is just one
VM per the userspace (99.99% cases) but produces a bunch
of "debugfs: Directory 'vm16679' with parent 'kvm' already present!"
when syzkaller (syscall fuzzer) is running so only one VM is present in
the debugfs for a given process.

This changes the debugfs node to include the LPID which alone should be
system wide unique. This leaves the existing pid for the convenience of
matching the VM's debugfs with the running userspace process (QEMU).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 1d1fcc290fca..0223ddc0eed0 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5227,7 +5227,7 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 	/*
 	 * Create a debugfs directory for the VM
 	 */
-	snprintf(buf, sizeof(buf), "vm%d", current->pid);
+	snprintf(buf, sizeof(buf), "vm%d-lp%ld", current->pid, lpid);
 	kvm->arch.debugfs_dir = debugfs_create_dir(buf, kvm_debugfs_dir);
 	kvmppc_mmu_debugfs_init(kvm);
 	if (radix_enabled())
-- 
2.30.2

