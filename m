Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DBE3FCBB3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbhHaQnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbhHaQnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:43:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B9C0612E7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:42:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k187-20020a2556c4000000b00598b2a660e2so6252731ybb.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=SwK4KMPU/9P2wLFjun4ZRaTVvv9zhjATQGOHh/CTEIk=;
        b=DPzD5KJ5IS8/KpX4M24l0iPbtmTToiCjk8saqB8GA45RVMTZ4zn+GkqAgsvieGSosl
         /zrufAR/mIUqAKMJWitHF4W9OCBkHW6hIksH3yK0WrJFWUJBpbPrkojnSC7flm37wwTF
         5FXTX0EpMVhFhrEwHSyqy7f8K0jdKZaueS0Yg3uOSKKbyTJr1Ke9TFXjSnpI2TujIKOW
         MgDTMzUOtU1v22gA4jK49idp1YomezKNSt44h3KfjZe/j3sPRpKqGPLl9+R86g+inRbF
         WY4Yn1sfEkeM37U6HeQKAmIk2venZr82qBkXC78apA9K/Q1en2JgYSAkrPhtPFmijlO+
         W7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=SwK4KMPU/9P2wLFjun4ZRaTVvv9zhjATQGOHh/CTEIk=;
        b=C4kxPNlzekDaNzePOYlVDIsxb/bvbSu6Bn7+DKBsUbGwV04TiVUYtstK+R7IcKLNf1
         FIhe51AuG8fAXVX7H+qH22R6fQ2HJjRP4Tumrqepwm3x8cP9Hb3C2nHC5kqWnkeHZipp
         MyxU6I1FURGnnpbGE7t8VKpZu9aarWTAN/UbJ3jctvUW2EsOxpV8y+L9navexElHETh0
         Z7p6LaiCuqJc9sJay4m0Yvqo6JV2DosHnvg7kFVrFuyDPfIjZumbJA42Jy33d1TD344a
         F8omxo1fM6FTmrcFC7xeEBPiEaytfJ3kQ3hQszzvTeGXH5wIwj3yo1oAbzBVXwwhDUGS
         gC9Q==
X-Gm-Message-State: AOAM533BFZTz2mvlJJUS0CK1uc8e7MOXaJtXt8C3eV7/4xwwGPhAFQqP
        83vr05nNCy08NBsBPEcPPXlOZHWp0Ig=
X-Google-Smtp-Source: ABdhPJxxIu8jKn+yeQkVdDNzwkM+OFi0tbw2Av3v+yvsf6uybshFKNKbfr7wjqWe+xzkIKhu+ElBb1gR058=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ddbd:588d:571:702a])
 (user=seanjc job=sendgmr) by 2002:a25:5554:: with SMTP id j81mr31047422ybb.133.1630428154774;
 Tue, 31 Aug 2021 09:42:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 31 Aug 2021 09:42:24 -0700
In-Reply-To: <20210831164224.1119728-1-seanjc@google.com>
Message-Id: <20210831164224.1119728-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210831164224.1119728-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH 3/3] KVM: x86: Simplify retrieving the page offset when
 loading PDTPRs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+200c08e88ae818f849ce@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace impressively complex "logic" for computing the page offset from
CR3 when loading PDPTRs.  Unlike other paging modes, the address held in
CR3 for PAE paging is 32-byte aligned, i.e. occupies bits 31:5, thus bits
11:5 need to be used as the offset from the gfn when reading PDPTRs.

The existing calculation originated in commit 1342d3536d6a ("[PATCH] KVM:
MMU: Load the pae pdptrs on cr3 change like the processor does"), which
read the PDPTRs from guest memory as individual 8-byte loads.  At the
time, the so called "offset" was the base index of PDPTR0 as a _u64_, not
a byte offset.  Naming aside, the computation was useful and arguably
simplified the overall flow.

Unfortunately, when commit 195aefde9cc2 ("KVM: Add general accessors to
read and write guest memory") added accessors with offsets at byte
granularity, the cleverness of the original code was lost and KVM was
left with convoluted code for a simple operation.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8bd76698be52..aa41ed693b0a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -801,7 +801,6 @@ static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
 int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3)
 {
 	gfn_t pdpt_gfn = cr3 >> PAGE_SHIFT;
-	unsigned offset = (((cr3 & (PAGE_SIZE-1)) >> 5) << 2) * sizeof(u64);
 	gpa_t real_gpa;
 	int i;
 	int ret;
@@ -816,8 +815,9 @@ int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3)
 	if (real_gpa == UNMAPPED_GVA)
 		return 0;
 
+	/* Note the offset, PDPTRs are 32 byte aligned when using PAE paging. */
 	ret = kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(real_gpa), pdpte,
-				       offset, sizeof(pdpte));
+				       cr3 & GENMASK(11, 5), sizeof(pdpte));
 	if (ret < 0)
 		return 0;
 
-- 
2.33.0.259.gc128427fd7-goog

