Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6721F35D036
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 20:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244827AbhDLSW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 14:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhDLSW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 14:22:27 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2D1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 11:22:09 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r5so3687632ilb.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnS66VMnQJOfrQyl2K7TCo3s3dpgaNmmTPqQ0SzKz4s=;
        b=TqcrGz6KegN4pgqHPFivO3yGcoeZ9JJB6yZiEM5mAH0qxvLsR4SaGHWo0U+elcVTyI
         TSSKliuOOFqi3UJxhDqG7QSKqqO/9Vvx1mue/2PCnaDTlLpGSemF80v0dI143RexXv1j
         ady1yIvG8Zizv9go+vd2t3SqJ92h6aaa1kxViJfcAfqiAEyMtWO35CgIFHGfUqypuSgM
         LLYaLHfLyGEFQu/xArIC8HCiX4eCJnWv2LWr6FQcgDHl0ExNXTwCLJk9L+/GcXuLEeWu
         JJX+qm7lowNyE1UF6Sf229fqH1kvV8QIxPiwJy9vRjN//S/A0Do6mlTzid3FhRpUUW/d
         6YgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnS66VMnQJOfrQyl2K7TCo3s3dpgaNmmTPqQ0SzKz4s=;
        b=WegaV2g+Ct3jpzf/reS1IFNCSLiXDxYe2M3TgsmsEpIkea9kZZalnQ3HlkzbPwj8w2
         a8d/JA8Q27MNpZk9E1tdh7ymrQaiIkPT3qkfko2XbwiR73L9RtNaoSlpOtmx+gB8++8F
         2Tr+TWwCVE+jb3wHA438MNxbvj6BP7kWjKD8aCh20Kv/+bLLX0P3Ihdd9MsXfqMbOTI6
         LAW3BNkmEkyQEj1QHWwPTMMqCXh0rLVPWc/UF1Wjef/iMPyIWPc3eIAoylXlmYFUoyBR
         qNLTliuiXFnuk3E0GXSgr+X3mtnwodvg99U25QX/K4UdE9TuH15T32V0gMCAsJU7Li4F
         n4cQ==
X-Gm-Message-State: AOAM530GyivFC2fO2oXjfRDAki354CDHjGWlG+pSs7GQe+RmCvS6o2W6
        h0k3TDNsK279EdW/aennKQBY1juIszwbYPLNsBS/LjNujc8=
X-Google-Smtp-Source: ABdhPJwm+p1wkbZpFs/xEL+3HaD8HlLDy1XD8ohjBf6jJHtLg6V4pd8T8YN5xkFghqM9wK3gH/5Tb+0+prv0uWNCQzw=
X-Received: by 2002:a05:6e02:1a49:: with SMTP id u9mr2895809ilv.306.1618251728283;
 Mon, 12 Apr 2021 11:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210401233736.638171-1-bgardon@google.com> <20210401233736.638171-10-bgardon@google.com>
 <4fc5960f-0b64-1cf5-d2c1-080d82d226a0@redhat.com>
In-Reply-To: <4fc5960f-0b64-1cf5-d2c1-080d82d226a0@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 12 Apr 2021 11:21:57 -0700
Message-ID: <CANgfPd-kYQgwdtm5uamYrPhq_V6DkocZXTq9iKzbfJaWcLy3Lw@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] KVM: x86/mmu: Allow zap gfn range to operate
 under the mmu read lock
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 12:53 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/04/21 01:37, Ben Gardon wrote:
> > +void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
> > +                       bool shared)
> >   {
> >       gfn_t max_gfn = 1ULL << (shadow_phys_bits - PAGE_SHIFT);
> >
> > -     lockdep_assert_held_write(&kvm->mmu_lock);
> > +     kvm_lockdep_assert_mmu_lock_held(kvm, shared);
> >
> >       if (!refcount_dec_and_test(&root->tdp_mmu_root_count))
> >               return;
> > @@ -81,7 +92,7 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
> >       list_del_rcu(&root->link);
> >       spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
> >
> > -     zap_gfn_range(kvm, root, 0, max_gfn, false, false);
> > +     zap_gfn_range(kvm, root, 0, max_gfn, false, false, shared);
> >
> >       call_rcu(&root->rcu_head, tdp_mmu_free_sp_rcu_callback);
>
> Instead of patch 13, would it make sense to delay the zap_gfn_range and
> call_rcu to a work item (either unconditionally, or only if
> shared==false)?  Then the zap_gfn_range would be able to yield and take
> the mmu_lock for read, similar to kvm_tdp_mmu_zap_invalidated_roots.
>
> If done unconditionally, this would also allow removing the "shared"
> argument to kvm_tdp_mmu_put_root, tdp_mmu_next_root and
> for_each_tdp_mmu_root_yield_safe, so I would place that change before
> this patch.
>
> Paolo
>

I tried that and it created problems. I believe the issue was that on
VM teardown memslots would be freed and the memory reallocated before
the root was torn down, resulting in a use-after free from
mark_pfn_dirty. Perhaps this could be resolved by forcing memslot
changes to wait until that work item was processed before returning. I
can look into it but I suspect there will be a lot of "gotchas"
involved.
