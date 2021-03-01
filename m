Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A06329D41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 12:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443302AbhCBCUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 21:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:55144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242187AbhCATsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:48:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D6DC64EDD;
        Mon,  1 Mar 2021 17:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614621090;
        bh=9oUCP0n7MlxV68K9/F0sEWq+TeNgdQD93VaeCCaFbwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=luno9qslNer7dLehf7w+0XJZPUkkOm8YdC4eIhHOBYjAFuA5U6RAuFndWS8dFLByn
         yRMDETBhwWTivgJQw5CWwN/TIh6AcVi3Fls2dpmpPtV9MEK1q7b2uXe7w81CvjI9ns
         fioxp3ySIQSQh9PdNw+b6Rl9gwEyBSz9YhdIVliI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.11 389/775] KVM: PPC: Make the VMX instruction emulation routines static
Date:   Mon,  1 Mar 2021 17:09:17 +0100
Message-Id: <20210301161220.820774126@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161201.679371205@linuxfoundation.org>
References: <20210301161201.679371205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cédric Le Goater <clg@kaod.org>

[ Upstream commit 9236f57a9e51c72ce426ccd2e53e123de7196a0f ]

These are only used locally. It fixes these W=1 compile errors :

../arch/powerpc/kvm/powerpc.c:1521:5: error: no previous prototype for ‘kvmppc_get_vmx_dword’ [-Werror=missing-prototypes]
 1521 | int kvmppc_get_vmx_dword(struct kvm_vcpu *vcpu, int index, u64 *val)
      |     ^~~~~~~~~~~~~~~~~~~~
../arch/powerpc/kvm/powerpc.c:1539:5: error: no previous prototype for ‘kvmppc_get_vmx_word’ [-Werror=missing-prototypes]
 1539 | int kvmppc_get_vmx_word(struct kvm_vcpu *vcpu, int index, u64 *val)
      |     ^~~~~~~~~~~~~~~~~~~
../arch/powerpc/kvm/powerpc.c:1557:5: error: no previous prototype for ‘kvmppc_get_vmx_hword’ [-Werror=missing-prototypes]
 1557 | int kvmppc_get_vmx_hword(struct kvm_vcpu *vcpu, int index, u64 *val)
      |     ^~~~~~~~~~~~~~~~~~~~
../arch/powerpc/kvm/powerpc.c:1575:5: error: no previous prototype for ‘kvmppc_get_vmx_byte’ [-Werror=missing-prototypes]
 1575 | int kvmppc_get_vmx_byte(struct kvm_vcpu *vcpu, int index, u64 *val)
      |     ^~~~~~~~~~~~~~~~~~~

Fixes: acc9eb9305fe ("KVM: PPC: Reimplement LOAD_VMX/STORE_VMX instruction mmio emulation with analyse_instr() input")
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20210104143206.695198-19-clg@kaod.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/powerpc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index cf52d26f49cd7..25966ae3271ef 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1518,7 +1518,7 @@ int kvmppc_handle_vmx_load(struct kvm_vcpu *vcpu,
 	return emulated;
 }
 
-int kvmppc_get_vmx_dword(struct kvm_vcpu *vcpu, int index, u64 *val)
+static int kvmppc_get_vmx_dword(struct kvm_vcpu *vcpu, int index, u64 *val)
 {
 	union kvmppc_one_reg reg;
 	int vmx_offset = 0;
@@ -1536,7 +1536,7 @@ int kvmppc_get_vmx_dword(struct kvm_vcpu *vcpu, int index, u64 *val)
 	return result;
 }
 
-int kvmppc_get_vmx_word(struct kvm_vcpu *vcpu, int index, u64 *val)
+static int kvmppc_get_vmx_word(struct kvm_vcpu *vcpu, int index, u64 *val)
 {
 	union kvmppc_one_reg reg;
 	int vmx_offset = 0;
@@ -1554,7 +1554,7 @@ int kvmppc_get_vmx_word(struct kvm_vcpu *vcpu, int index, u64 *val)
 	return result;
 }
 
-int kvmppc_get_vmx_hword(struct kvm_vcpu *vcpu, int index, u64 *val)
+static int kvmppc_get_vmx_hword(struct kvm_vcpu *vcpu, int index, u64 *val)
 {
 	union kvmppc_one_reg reg;
 	int vmx_offset = 0;
@@ -1572,7 +1572,7 @@ int kvmppc_get_vmx_hword(struct kvm_vcpu *vcpu, int index, u64 *val)
 	return result;
 }
 
-int kvmppc_get_vmx_byte(struct kvm_vcpu *vcpu, int index, u64 *val)
+static int kvmppc_get_vmx_byte(struct kvm_vcpu *vcpu, int index, u64 *val)
 {
 	union kvmppc_one_reg reg;
 	int vmx_offset = 0;
-- 
2.27.0



