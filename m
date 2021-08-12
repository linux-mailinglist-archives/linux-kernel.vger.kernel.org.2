Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6467C3EA831
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhHLQEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 12:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhHLQEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:04:20 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B212C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 09:03:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so15917304pji.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jw52nCDfk6PbivT8d6VPc3xIqyMa3zncf4PBia2oVKk=;
        b=H3r5cy3MrBDVsJkrOElcPo70wt8xUDs5X0BTUnWysXEwlEvnpJxkVryTsRurOPYv+w
         mySje2f6KuJNnn8xOzBdHgARzapWpjR6bs7eXon8xS+6VL62LN7s7RiyP1pv8NEpp1Xp
         VLuMeklT1W+7W9RvsnaIS1jbV+9JxFAnGlQX3yvIkIoTgJcyx7XxDdf5QyxKMwdhgEKb
         DpLlDZFtbKTZzBMDvM/ryFmfVJRlxg6aId6MLYg+5fWuosOuiBEONhlFhT8mXqu0QUDt
         zNAJ4E5O/UFFjWPUdX+Km8g+Z/xEUW68D6kM1v8vIp62iJbGeEvDqq0PElvCb+/GNrW+
         MuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jw52nCDfk6PbivT8d6VPc3xIqyMa3zncf4PBia2oVKk=;
        b=oGdKwuSZYt0HYcDNNPgZZpuL75R5SDRhSB/FoGGsMvTYoSosGb3z9eFbw5BcjEUgnB
         +U2JCroI50aacLBjjC/wQL1u/9jgQ9H/ii22nB2+66TiA7EYSY62KR/8W9tPqXfg1LMV
         yw0emSdJ/JxT+CmB0tmmauYstL+hb3LYGwIo9OYYiE5810Y9MzRZKNhMPFw8JyeSZJZl
         IC97JX0eq0fFc7LOAO17v/62W2Q0oW6/OqhQVC8XoBDMgR7/Z1uIPTkw9oTxSzqQYGU6
         BVUHNqOdS9Ndofi2xn/U/CsBfzS2QCXM02GkMDtdV7yjEgxqbzxNxUPUG352bOAFTdxe
         SWFA==
X-Gm-Message-State: AOAM533KtXc0t3f9gPlCUF2MFFeKGIUPcKZXuQ7PCmDAE8vUjEW1ianS
        ddr+qXIJ11EjRYtzl5t4QW5ACA==
X-Google-Smtp-Source: ABdhPJxYF6mPLK+4Te1+ZmNX4UolYHFV4rCufnVsXxC+MasZcm3W9m1P/Zy8jgBHrxgTpVrbOKZ5Xw==
X-Received: by 2002:a17:90b:1b47:: with SMTP id nv7mr5073951pjb.70.1628784234345;
        Thu, 12 Aug 2021 09:03:54 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b18sm3942394pft.201.2021.08.12.09.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 09:03:53 -0700 (PDT)
Date:   Thu, 12 Aug 2021 16:03:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: X86: Check pte present first in
 __shadow_walk_next()
Message-ID: <YRVGY1ZK8wl9ybBH@google.com>
References: <20210812043630.2686-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812043630.2686-1-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> So far, the loop bodies already ensure the pte is present before calling
> __shadow_walk_next().  But checking pte present in __shadow_walk_next()
> is a more prudent way of programing and loop bodies will not need
> to always check it.  It allows us removing is_shadow_present_pte()
> in the loop bodies.

There needs to be more analysis in the changelog, as there are many more callers
to __shadow_walk_next() than the three that are modified in the next patch.  It
might even make sense to squash the two patches together, i.e. make it a "move"
instead of an "add + remove", and then explicitly explain why it's ok to add the
check for paths that do _not_ currently have a !is_shadow_present_pte() in the
loop body.

Specifically, FNAME(fetch) via shadow_walk_next() and __direct_map() via
for_each_shadow_entry() do not currently terminate their walks with a !PRESENT,
but they get away with it because they install present non-leaf SPTEs in the loop
itself.

The other argument for the audit (changelog+patch) of all users is that the next
patch misses FNAME(invlpg), e.g. 

@@ -977,7 +980,7 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa)
                        FNAME(update_pte)(vcpu, sp, sptep, &gpte);
                }

-               if (!is_shadow_present_pte(*sptep) || !sp->unsync_children)
+               if (!sp->unsync_children)
                        break;
        }
        write_unlock(&vcpu->kvm->mmu_lock);

It would also be worthwhile to document via the changelog that terminating on
!is_shadow_present_pte() is 100% the correct behavior, as walking past a !PRESENT
SPTE would lead to attempting to read a the next level SPTE from a garbage
iter->shadow_addr.

And for clarity and safety, I think it would be worth adding the patch below as
a prep patch to document and enforce that walking the non-leaf SPTEs when faulting
in a page should never terminate early.


From 1c202a7e82b1931e4eb37b23aa9d7108340a6cd2 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 12 Aug 2021 08:38:35 -0700
Subject: [PATCH] KVM: x86/mmu: Verify shadow walk doesn't terminate early in
 page faults

WARN and bail if the shadow walk for faulting in a SPTE terminates early,
i.e. doesn't reach the expected level because the walk encountered a
terminal SPTE.  The shadow walks for page faults are subtle in that they
install non-leaf SPTEs (zapping leaf SPTEs if necessary!) in the loop
body, and consume the newly created non-leaf SPTE in the loop control,
e.g. __shadow_walk_next().  In other words, the walks guarantee that the
walk will stop if and only if the target level is reached by installing
non-leaf SPTEs to guarantee the walk remains valid.

Opportunistically use fault->goal-level instead of it.level in
FNAME(fetch) to further clarify that KVM always installs the leaf SPTE at
the target level.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c         | 3 +++
 arch/x86/kvm/mmu/paging_tmpl.h | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a272ccbddfa1..2a243ae1d64c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2992,6 +2992,9 @@ static int __direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 			account_huge_nx_page(vcpu->kvm, sp);
 	}

+	if (WARN_ON_ONCE(it.level != fault->goal_level))
+		return -EFAULT;
+
 	ret = mmu_set_spte(vcpu, it.sptep, ACC_ALL,
 			   fault->write, fault->goal_level, base_gfn, fault->pfn,
 			   fault->prefault, fault->map_writable);
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index f70afecbf3a2..3a8a7b2f9979 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -749,9 +749,12 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 		}
 	}

+	if (WARN_ON_ONCE(it.level != fault->goal_level))
+		return -EFAULT;
+
 	ret = mmu_set_spte(vcpu, it.sptep, gw->pte_access, fault->write,
-			   it.level, base_gfn, fault->pfn, fault->prefault,
-			   fault->map_writable);
+			   fault->goal_level, base_gfn, fault->pfn,
+			   fault->prefault, fault->map_writable);
 	if (ret == RET_PF_SPURIOUS)
 		return ret;

--
2.33.0.rc1.237.g0d66db33f3-goog
