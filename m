Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF883371EA7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhECRc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhECRcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:32:24 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2287CC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 10:31:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id di13so7242092edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I63jvYw0YNbi4LL7zlZz0OvOPS03MBsn8u87jlh6bAA=;
        b=R7ehcPOzmxV3tekro6KJO+ChI3KqJl835Tx4EFtQGPgZ8JNPh7ckZPvNhMutXQubg2
         9zks+QGlGg6P/v9OgkjD+fn+lhFJS9i8zcJnAIA3XN2tEu3lT0avVcrVhA1by0GGnMsl
         wdAz4AR69b5RsXOBH8dic41eDHPV6M/qxUrG+1/OXFG0hgwq/hv1npcCoQwTVxs4IBEi
         f9EGZL9Zc9zqTmYgwLGXR577XBGuYNw8pzk1xlVsIQL47w8JqsQsDFMCwFZLT5o+7dfH
         IPfyN9AbcIkckbfCYqiMMp7lnYANf6byR4HtkxhvnVk1I7AzmLAYPzU6eABPvVvhcYwR
         t3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I63jvYw0YNbi4LL7zlZz0OvOPS03MBsn8u87jlh6bAA=;
        b=V54TmWXULNL8NXQn88KjyUYiq/6jKsWAUs4o1EC0+UQX183WikQKz59dsE7Ct/4OF1
         0O+I0C1qnxz+++qey4YGFC7G7fnVHZFMHMVSSzXoKezXrE7SfWxL9NefLY4K4lSI0V1k
         eFG5Ty3vGnRTRwuMdH+ePZ1zNmBrX+ZW+DSkMDXxMsps63FoXFBDWwmfaqdKJW/vFnvP
         A1XL0jpzNfwzfN8RbpWY+ztjqyItLthuVN7Jngtjfe/CDF0NNTw0Tor5d1A9+miIky2w
         KOCccCRYdwimbDSigR6svm7KJqA1y1Ksv6ew9GvsEbL6cFDcRHfaqnhzzzYlXmMHV4z5
         Xlgg==
X-Gm-Message-State: AOAM530PkiuSm8cUM3AUe4xxSr8VFWnaz1vvqOSVXaAnFCkO5hknSlHl
        nR0Bk0NQl88C1rstwK125AwlvCbOjVV8qQu3v0PXBoRtUt/wjw==
X-Google-Smtp-Source: ABdhPJzAwLDauaGUAfsMuaHcxt++n/I9m2Gm/jCJO7aoCgyiqP7nhMm/7xvj+p/bqD0JDn5tdI3KBP2H06oo4LGXZvA=
X-Received: by 2002:aa7:dc54:: with SMTP id g20mr21179836edu.266.1620063089729;
 Mon, 03 May 2021 10:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210429211833.3361994-1-bgardon@google.com> <a3279647-fb30-4033-2a9d-75d473bd8f8e@redhat.com>
In-Reply-To: <a3279647-fb30-4033-2a9d-75d473bd8f8e@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 3 May 2021 10:31:18 -0700
Message-ID: <CANgfPd-fD33hJkQP_MVb2a4CadKQbkpwwtP9r5rMrC_Mripeqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Lazily allocate memslot rmaps
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

On Mon, May 3, 2021 at 6:45 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 29/04/21 23:18, Ben Gardon wrote:
> > This series enables KVM to save memory when using the TDP MMU by waiting
> > to allocate memslot rmaps until they are needed. To do this, KVM tracks
> > whether or not a shadow root has been allocated. In order to get away
> > with not allocating the rmaps, KVM must also be sure to skip operations
> > which iterate over the rmaps. If the TDP MMU is in use and we have not
> > allocated a shadow root, these operations would essentially be op-ops
> > anyway. Skipping the rmap operations has a secondary benefit of avoiding
> > acquiring the MMU lock in write mode in many cases, substantially
> > reducing MMU lock contention.
> >
> > This series was tested on an Intel Skylake machine. With the TDP MMU off
> > and on, this introduced no new failures on kvm-unit-tests or KVM selftests.
>
> Thanks, I only reported some technicalities in the ordering of loads
> (which matter since the loads happen with SRCU protection only).  Apart
> from this, this looks fine!

Awesome to hear, thank you for the reviews. Should I send a v3
addressing those comments, or did you already make those changes when
applying to your tree?

>
> Paolo
>
> > Changelog:
> > v2:
> >       Incorporated feedback from Paolo and Sean
> >       Replaced the memslot_assignment_lock with slots_arch_lock, which
> >       has a larger critical section.
> >
> > Ben Gardon (7):
> >    KVM: x86/mmu: Track if shadow MMU active
> >    KVM: x86/mmu: Skip rmap operations if shadow MMU inactive
> >    KVM: x86/mmu: Deduplicate rmap freeing
> >    KVM: x86/mmu: Factor out allocating memslot rmap
> >    KVM: mmu: Refactor memslot copy
> >    KVM: mmu: Add slots_arch_lock for memslot arch fields
> >    KVM: x86/mmu: Lazily allocate memslot rmaps
> >
> >   arch/x86/include/asm/kvm_host.h |  13 +++
> >   arch/x86/kvm/mmu/mmu.c          | 153 +++++++++++++++++++++-----------
> >   arch/x86/kvm/mmu/mmu_internal.h |   2 +
> >   arch/x86/kvm/mmu/tdp_mmu.c      |   6 +-
> >   arch/x86/kvm/mmu/tdp_mmu.h      |   4 +-
> >   arch/x86/kvm/x86.c              | 110 +++++++++++++++++++----
> >   include/linux/kvm_host.h        |   9 ++
> >   virt/kvm/kvm_main.c             |  54 ++++++++---
> >   8 files changed, 264 insertions(+), 87 deletions(-)
> >
>
