Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F6A351D9C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbhDASaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbhDASHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:07:39 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEE3C031161
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 09:50:26 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id w2so2542349ilj.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNyoHwuym24nTuPrnQKuQ/Oqu9wKCJXlO62gU2pjezE=;
        b=FZNsX6zebAEZzO4/6zn1fcIV63Mb/+ZPwOFloDK61hRZ5nRxr8ZIYrOz2goc4pfHAX
         3/pbwiDYzuktM7s7Oj59A07pecdglioiQPwpeJPNdf1Li3WakyC/LfszF4M+dqjACm8V
         Z4pXa+3wSN2sv0FcbOqvquTm2nt2sjHDInlL4xKxWLzyF90F3U7+nnii1geqDJ3vzjpe
         VQbXV3GqGqvBRhoZv5zRXMrfj3qXo1UD550T55JfNXpHM1GktgY3cjIZ22Orj6CD4X/9
         QlzF8gdhO7LWutYOoCtlO6rY6R0dEelay1xw/hVDYZCN/Wz8omISafz27rVg83Zvy7aO
         FuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNyoHwuym24nTuPrnQKuQ/Oqu9wKCJXlO62gU2pjezE=;
        b=aEXL6oikSfGYuaumovaHWAJTsDQCIgwzb3n21DpA09PIxtbx1e3FWCwTL5IJzRoevL
         62yawjGCwUCnssk3hb680absBxOYL9QJZsx79MMxzsdjTdRoTXisCUw0sOM0s9dAmSqp
         s2kfeOnIXj+ckBG/VDxcshiccj8J4e9BPg7y7rvefInd8sqmpofl0W2648T/Ya9ICfSK
         TX0yhUpAy9X1f/ngHm2m6M5vTcgLlU4qp2crvG2okPjRtskvO/gCHYolp7KChtX0fwSB
         JZsLo6N2qjlsDq+k8D66RYAF5DEMGXMY727FJjYDcbFxoDYWzDdF/T8o0OIMKpHR+qdC
         kX0A==
X-Gm-Message-State: AOAM533LSDK21hElTbLgFJ18Lg5qr1h4voqjvFZMJTqzhMqnG9eybJlD
        /ZwX6OptbMQuPrqL9hWJ9LjszO7dhpEPdXYiQoK/C3l8Th0=
X-Google-Smtp-Source: ABdhPJygPb7A4iOxNR41PmhBKBEl9w7DrjbRJJF1EcyZP5QRv/HixWIVeU3ngp0yyusasDDFdXRR6W9X7IpcyPiYfEg=
X-Received: by 2002:a92:340e:: with SMTP id b14mr927980ila.285.1617295825986;
 Thu, 01 Apr 2021 09:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com> <20210202185734.1680553-21-bgardon@google.com>
 <f4fca4d7-8795-533e-d2d9-89a73e1a9004@redhat.com>
In-Reply-To: <f4fca4d7-8795-533e-d2d9-89a73e1a9004@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 1 Apr 2021 09:50:15 -0700
Message-ID: <CANgfPd85U_YwDdXc1Dkn-UzKpae5FRzYshLFABAU_xHTs0i3Hg@mail.gmail.com>
Subject: Re: [PATCH v2 20/28] KVM: x86/mmu: Use atomic ops to set SPTEs in TDP
 MMU map
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

On Thu, Apr 1, 2021 at 3:32 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/02/21 19:57, Ben Gardon wrote:
> > @@ -720,7 +790,8 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
> >                */
> >               if (is_shadow_present_pte(iter.old_spte) &&
> >                   is_large_pte(iter.old_spte)) {
> > -                     tdp_mmu_set_spte(vcpu->kvm, &iter, 0);
> > +                     if (!tdp_mmu_set_spte_atomic(vcpu->kvm, &iter, 0))
> > +                             break;
> >
> >                       kvm_flush_remote_tlbs_with_address(vcpu->kvm, iter.gfn,
> >                                       KVM_PAGES_PER_HPAGE(iter.level));
> >
> >                       /*
> >                        * The iter must explicitly re-read the spte here
> >                        * because the new value informs the !present
> >                          * path below.
> >                          */
> >                         iter.old_spte = READ_ONCE(*rcu_dereference(iter.sptep));
> >                 }
> >
> >                 if (!is_shadow_present_pte(iter.old_spte)) {
>
> Would it be easier to reason about this code by making it retry, like:
>
> retry:
>                  if (is_shadow_present_pte(iter.old_spte)) {
>                         if (is_large_pte(iter.old_spte)) {
>                                 if (!tdp_mmu_zap_spte_atomic(vcpu->kvm, &iter))
>                                         break;
>
>                                 /*
>                                  * The iter must explicitly re-read the SPTE because
>                                  * the atomic cmpxchg failed.
>                                  */
>                                 iter.old_spte = READ_ONCE(*rcu_dereference(iter.sptep));
>                                 goto retry;
>                         }
>                  } else {
>                         ...
>                 }
>
> ?

To be honest, that feels less readable to me. For me retry implies
that we failed to make progress and need to repeat an operation, but
the reality is that we did make progress and there are just multiple
steps to replace the large SPTE with a child PT.
Another option which could improve readability and performance would
be to use the retry to repeat failed cmpxchgs instead of breaking out
of the loop. Then we could avoid retrying the page fault each time a
cmpxchg failed, which may happen a lot as vCPUs allocate intermediate
page tables on boot. (Probably less common for leaf entries, but
possibly useful there too.)
Another-nother option would be to remove this two part process by
eagerly splitting large page mappings in a single step. This would
substantially reduce the number of page faults incurred for NX
splitting / dirty logging splitting. It's been on our list of features
to send upstream for a while and I hope we'll be able to get it into
shape and send it out reasonably soon.

>
> Paolo
>
