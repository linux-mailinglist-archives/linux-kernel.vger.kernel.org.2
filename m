Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF9F451A05
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 00:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350437AbhKOXcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 18:32:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245284AbhKOTT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:19:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08C1463528;
        Mon, 15 Nov 2021 18:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637001106;
        bh=mjBw1zfFQM3kAD+zxVUPxvansRBjSHNc8m0/yTf9GaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jyw6GZl6lKLn4Ii/0+WiZQ7N2xiAy8EM+xUxVBIGCtLtajzX5iJIygQMIDNRrNupM
         WP9BDRxqu779ekBMMLWqW17wYpZAdqg3eQ30GxDn1wMJos365+oNyWDv/utozexPx7
         XJ1sxGznXBrMcP7jprRrxGa4hcDlstdsxmhi6m+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.15 064/917] KVM: x86/mmu: Drop a redundant, broken remote TLB flush
Date:   Mon, 15 Nov 2021 17:52:39 +0100
Message-Id: <20211115165430.933704318@linuxfoundation.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115165428.722074685@linuxfoundation.org>
References: <20211115165428.722074685@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

commit bc3b3c1002ea684e618ff6d8c387b1b8b319f140 upstream.

A recent commit to fix the calls to kvm_flush_remote_tlbs_with_address()
in kvm_zap_gfn_range() inadvertantly added yet another flush instead of
fixing the existing flush.  Drop the redundant flush, and fix the params
for the existing flush.

Cc: stable@vger.kernel.org
Fixes: 2822da446640 ("KVM: x86/mmu: fix parameters to kvm_flush_remote_tlbs_with_address")
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20211022010005.1454978-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/mmu/mmu.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5758,13 +5758,11 @@ void kvm_zap_gfn_range(struct kvm *kvm,
 		for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
 			flush = kvm_tdp_mmu_zap_gfn_range(kvm, i, gfn_start,
 							  gfn_end, flush);
-		if (flush)
-			kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
-							   gfn_end - gfn_start);
 	}
 
 	if (flush)
-		kvm_flush_remote_tlbs_with_address(kvm, gfn_start, gfn_end);
+		kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
+						   gfn_end - gfn_start);
 
 	kvm_dec_notifier_count(kvm, gfn_start, gfn_end);
 


