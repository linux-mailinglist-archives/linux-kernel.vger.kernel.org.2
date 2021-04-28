Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D9F36DD3A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbhD1Qle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbhD1Qlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:41:32 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A873EC061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:40:46 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso57032538otb.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DXTGibt6BlhF0qBWFzyUiYAgESiWFri8buCG1L9Tbo=;
        b=jye5oWYTW/qDTriJx0IyrX7bOD5CHTkWigLBq2eFbp0m9EjRp4xsww5w3h76mCBKL8
         DkmQl5xknWKRo548AAc6OMDIwUsuySmLYVZnIAT6Gg2vst4dpGZTYAyvP10bmrfvrOhk
         jhyyMrhtK+Gw2rj6m+uJsnDsoFDEOXZpQ4hFK9hey+fzYUBHZ0IX038t4heYA/Pc1OTt
         K0fRKK14MpLF26MnwmOUQ1D4qNVf/oUIR1YocK0xBG/PrgE31D2qnO1JlVCDpn+37w4v
         aNspS2gjirgyXd9HfzR2MTukdvMQhxJxFrXYBk80aq0OAFOvCpOpT+OUtdj+qVexz381
         L/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DXTGibt6BlhF0qBWFzyUiYAgESiWFri8buCG1L9Tbo=;
        b=NIVN0tJiiantmvzqSNuxxXzzaAiPN+R49zJTxQ6p1cUcRUtgwQcrFRqgM0Vvd9TZsq
         ZytvNlht8xlnb6GA6NBeafU1RVq0NcK3ceirxw+btTyp9IOJbiKX94eFPVb/m91Yih+n
         GiqTXUV+9ioxe4e6IMUZHr7TiLLoZi94URd2E7UdFP+FwIUMSMuWIvhdKv9JJpbuYY20
         jbhXfrWDOaNtt/93BvnNjlLO61xdrZv212ocMvk1kxLk0cXtr0GpvQ58mgldeFJapDH7
         pzym4I/ny6sv/MDv0/hnvNm4ixrh52jIEMDz2bi10Pjk4aKg2kny5AEXH5PYGCnoxDrF
         5qIw==
X-Gm-Message-State: AOAM532hCOFP4V5iOIqRhXhuY1g2RlxBsXSeK4aQsUWMDBTPX/BI7D8c
        UJMF3vvfGAWJF+MkdPTJqk6eRUCcVW64tN7s+NGYXg==
X-Google-Smtp-Source: ABdhPJzhb1H953QWKxPwEOaiQm6mkMe79fjM0vOc1Vqgax/CAVrGYHdtkw6kcdTIIz6Jkc2gLPE+N0WcJzWI1UgISYo=
X-Received: by 2002:a05:6830:1deb:: with SMTP id b11mr25653799otj.72.1619628045862;
 Wed, 28 Apr 2021 09:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210427223635.2711774-1-bgardon@google.com> <20210427223635.2711774-6-bgardon@google.com>
 <997f9fe3-847b-8216-c629-1ad5fdd2ffae@redhat.com>
In-Reply-To: <997f9fe3-847b-8216-c629-1ad5fdd2ffae@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 28 Apr 2021 09:40:34 -0700
Message-ID: <CANgfPd8RZXQ-BamwQPS66Q5hLRZaDFhi0WaA=ZvCP4BbofiUhg@mail.gmail.com>
Subject: Re: [PATCH 5/6] KVM: x86/mmu: Protect kvm->memslots with a mutex
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
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

On Tue, Apr 27, 2021 at 11:25 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 28/04/21 00:36, Ben Gardon wrote:
> > +void kvm_arch_assign_memslots(struct kvm *kvm, int as_id,
> > +                          struct kvm_memslots *slots)
> > +{
> > +     mutex_lock(&kvm->arch.memslot_assignment_lock);
> > +     rcu_assign_pointer(kvm->memslots[as_id], slots);
> > +     mutex_unlock(&kvm->arch.memslot_assignment_lock);
> > +}
>
> Does the assignment also needs the lock, or only the rmap allocation?  I
> would prefer the hook to be something like kvm_arch_setup_new_memslots.

The assignment does need to be under the lock to prevent the following race:
1. Thread 1 (installing a new memslot): Acquires memslot assignment
lock (or perhaps in this case rmap_allocation_lock would be more apt.)
2. Thread 1: Check alloc_memslot_rmaps (it is false)
3. Thread 1: doesn't allocate memslot rmaps for new slot
4. Thread 1: Releases memslot assignment lock
5. Thread 2 (allocating a shadow root): Acquires memslot assignment lock
6. Thread 2: Sets alloc_memslot_rmaps = true
7. Thread 2: Allocates rmaps for all existing slots
8. Thread 2: Releases memslot assignment lock
9. Thread 2: Sets shadow_mmu_active = true
10. Thread 1: Installs the new memslots
11. Thread 3: Null pointer dereference when trying to access rmaps on
the new slot.

Putting the assignment under the lock prevents 5-8 from happening
between 2 and 10.

I'm open to other ideas as far as how to prevent this race though. I
admit this solution is not the most elegant looking.

>
> (Also it is useful to have a comment somewhere explaining why the
> slots_lock does not work.  IIUC there would be a deadlock because you'd
> be taking the slots_lock inside an SRCU critical region, while usually
> the slots_lock critical section is the one that includes a
> synchronize_srcu; I should dig that up and document that ordering in
> Documentation/virt/kvm too).

Yeah, sorry about that. I should have added a comment to that effect.
As you suspected, it's because of the slots lock / SRCU deadlock.
Using the slots lock was my original implementation, until the
deadlock issue came up.

I can add comments about that in a v2.

>
> Paolo
>
