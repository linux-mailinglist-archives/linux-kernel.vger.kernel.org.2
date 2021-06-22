Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862E83B0C58
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhFVSGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbhFVSFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:05:47 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C480C0698FE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:47 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id y35-20020a0cb8a30000b0290270c2da88e8so9360784qvf.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=jqg/PyNu/CSyHTFVeBuuLGehL9/qaV195uMT3A4mr/g=;
        b=LquhTXqyz24eI9YGUsfTyD0LyYUd2xnbESLro4MVRoB1R1qzZVQRbsHsgI8idus0RJ
         oaeHeQDQ6+nlUhqiSvN0a7QdF08rBMsB/RqRcg/7qz3qwPXduVip3SjA2tPixm3frCMr
         WSgduMNonn7lu+bLk+OFlmv/KFMdZdiyiROXXfbOajucu44SQGyJ6W/5YCV2I0F4eRTW
         E5xbsjmlZ/ZtwZjkrhtPGRWIFFR/5KR+Onss7pgoj50p/I1spHrxJwlcO1xbE6YNpcZV
         OOrIw2kDpykA6EX9DNGza5oyUt8xAVaoq8TIjuXiWYnlqbsjU5FsxSelHsqXyzB3aSxR
         s5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=jqg/PyNu/CSyHTFVeBuuLGehL9/qaV195uMT3A4mr/g=;
        b=ZUJL8Ikt2a8Q8/2A645vHKIzByzUh/AgQuSki+37e6QszB5B8XFu8HXTvGXiRUNmRE
         HkuZv8qyqR39XiOpm3MYr65aO5c+8J6Dbj7jE75ImbZaqIJzzmkwdHL62DibwvGocf/I
         cKnVZZZkqXbcsPsFM8KjylbjRoTMZJhG8zPEgWKLPrpeKfUfdKPVNpnP6HYNDiQium6+
         RFVy5kUvYIyOjSikRVLafTBsVaqt2gNjHz36YgSWtD0QGKGKve6O9oKLrIxQfHMbhbUa
         c7cIAYYtoSAAxGUc2ED73Lmw9cZbGSiQsODoFv/G0RvuhDoDajtRO+eexLinTSGBwTbz
         Vm6w==
X-Gm-Message-State: AOAM5301VeGYGDqCMPsCR5jwr6DebVqG50v6KNmAEzyR9iuhhl2xkQug
        1UgZdd6OOej8/T962RN76+giDP+qtms=
X-Google-Smtp-Source: ABdhPJw3Z5nrv/deUhYu6Pr3e+J3O1cNVlD0syU/ZctFSOxjcNcZXd8br5tuMa9yzupldAnlITTeUCkDQuk=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:5722:92ce:361f:3832])
 (user=seanjc job=sendgmr) by 2002:a0c:fb12:: with SMTP id c18mr1244qvp.40.1624384786360;
 Tue, 22 Jun 2021 10:59:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 22 Jun 2021 10:57:33 -0700
In-Reply-To: <20210622175739.3610207-1-seanjc@google.com>
Message-Id: <20210622175739.3610207-49-seanjc@google.com>
Mime-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 48/54] KVM: x86/mmu: WARN on any reserved SPTE value when
 making a valid SPTE
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace make_spte()'s WARN on a collision with the magic MMIO value with
a generic WARN on reserved bits being set (including EPT's reserved WX
combination).  Warning on any reserved bits covers MMIO, A/D tracking
bits with PAE paging, and in theory any future goofs that are introduced.

Opportunistically convert to ONCE behavior to avoid spamming the kernel
log, odds are very good that if KVM screws up one SPTE, it will botch all
SPTEs for the same MMU.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/spte.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 246e61e0771e..3e97cdb13eb7 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -175,7 +175,10 @@ int make_spte(struct kvm_vcpu *vcpu, unsigned int pte_access, int level,
 		spte = mark_spte_for_access_track(spte);
 
 out:
-	WARN_ON(is_mmio_spte(spte));
+	WARN_ONCE(is_rsvd_spte(&vcpu->arch.mmu->shadow_zero_check, spte, level),
+		  "spte = 0x%llx, level = %d, rsvd bits = 0x%llx", spte, level,
+		  get_rsvd_bits(&vcpu->arch.mmu->shadow_zero_check, spte, level));
+
 	*new_spte = spte;
 	return ret;
 }
-- 
2.32.0.288.g62a8d224e6-goog

