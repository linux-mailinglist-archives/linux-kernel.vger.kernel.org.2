Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE23304FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhA0Dg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbhAZVsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:48:33 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C485DC061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:47:48 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e22so36817177iog.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSSrXGvO8Z5hv7xtQeYdUiuVK+ZbsiIIMn3oXAULpI4=;
        b=vwcxZkQYFgpHES10yvP73GnKhcwtFR+wZHdjDBADyCrRSu+XPzZ2hXQ5Bb/exEYlWR
         MIOoJbX8ezhURWPB3j2ROFiyvufhanogg6Ypc+5udiiIdaJjNPCDX7/QfiQVELWSUXoQ
         MiKeez34nkY+8w5kJzfNv0ndQZx4z97LqBPJKmw9jpR1CwNwlIncvmYCDrXb6c4rYP5h
         m2Yxxeq/rozHeOAw8Mvg/KAWsCr81e7kCmhgLsoSfHAV2zEIvS4CRjuywWdJz61aVMY1
         m+4JiZDzErOeCtUzlgWksuWSDz9Q13FB+T3ywpIrsXcbsKajgCRyda1FRXZ6c8ONHQ51
         6V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSSrXGvO8Z5hv7xtQeYdUiuVK+ZbsiIIMn3oXAULpI4=;
        b=H7cd06cDzpGDjWhdPCkc2OfDvz+xa8c7orHn5LrAUjzsJeRHTVfpfcvASH8g4geqiy
         X7H+z64bqFMEr/XiJ0Ljc5g7dDdEQVTqoh3GIm/ky8o8wGU7cL4LRfsZRfZIXNO4+xJI
         xsIJnQwSRm1f29mw0UDNx90/zg1APQswaca3z3glMkcpTfs7wdhtYLd8QnmTHiJDsdwU
         zzOK8g7IhSgyzOcHDdwqR1MQCKDyigr03xJDiRZAHWabBOZYJfI4Vnc6LAaBwK1WNTyT
         /BRZYYMz8bpDKoIF21/HQ4FNKq9Vcqn6c7flkF7R4mZ+/scdZxJFAi57niSNvmrgiDap
         qFNQ==
X-Gm-Message-State: AOAM533HKQSfYb8aMo0wMJ9UiuSGXqBiyPoxegeBsjtjU0Osnb0U9ebn
        uC7h0wIkM40R8PSgtwLsZAlWx66Pj4/GN4cyryiU9w==
X-Google-Smtp-Source: ABdhPJym1IbTbCJL80K6b5KLebAuPvM9zalpis45wQ2maBqJ/OyDGaiq1pi5bBF6WekfQBxjPg68vjrxAw5MMWK1cag=
X-Received: by 2002:a92:60f:: with SMTP id x15mr3804039ilg.203.1611697667926;
 Tue, 26 Jan 2021 13:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com> <20210112181041.356734-20-bgardon@google.com>
 <YAnUhCocizx97FWL@google.com> <YAnzB3Uwn3AVTXGN@google.com> <335d27f7-0849-de37-f380-a5018c5c5535@redhat.com>
In-Reply-To: <335d27f7-0849-de37-f380-a5018c5c5535@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 26 Jan 2021 13:47:36 -0800
Message-ID: <CANgfPd_Lh-aLJ5fXP_GfqD0bB=0dvqxjKrCLmB5=VVFMT70NZw@mail.gmail.com>
Subject: Re: [PATCH 19/24] kvm: x86/mmu: Protect tdp_mmu_pages with a lock
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
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

On Tue, Jan 26, 2021 at 6:28 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 21/01/21 22:32, Sean Christopherson wrote:
> > Coming back to this series, I wonder if the RCU approach is truly necessary to
> > get the desired scalability.  If both zap_collapsible_sptes() and NX huge page
> > recovery zap_only_  leaf SPTEs, then the only path that can actually unlink a
> > shadow page while holding the lock for read is the page fault path that installs
> > a huge page over an existing shadow page.
> >
> > Assuming the above analysis is correct, I think it's worth exploring alternatives
> > to using RCU to defer freeing the SP memory, e.g. promoting to a write lock in
> > the specific case of overwriting a SP (though that may not exist for rwlocks),
> > or maybe something entirely different?
>
> You can do the deferred freeing with a short write-side critical section
> to ensure all readers have terminated.
>
> If the bool argument to handle_disconnected_tdp_mmu_page is true(*), the
> pages would be added to an llist, instead of being freed immediately.
> At the end of a shared critical section you would do
>
>         if (!llist_empty(&kvm->arch.tdp_mmu_disconnected_pages)) {
>                 struct llist_node *first;
>                 kvm_mmu_lock(kvm);
>                 first = __list_del_all(&kvm->arch.tdp_mmu_disconnected_pages);
>                 kvm_mmu_unlock(kvm);
>
>                 /*
>                  * All vCPUs have already stopped using the pages when
>                  * their TLBs were flushed.  The exclusive critical
>                  * section above means that there can be no readers
>                  * either.
>                  */
>                 tdp_mmu_free_disconnected_pages(first);
>         }
>
> So this is still deferred reclamation, but it's done by one of the vCPUs
> rather than a worker RCU thread.  This would replace patches 11/12/13
> and probably would be implemented after patch 18.

While I agree that this would work, it could be a major performance
bottleneck as it could result in the MMU lock being acquired in read
mode by a VCPU thread handling a page fault. Even though the critical
section is very short it still has to serialize with the potentially
many overlapping page fault handlers which want the MMU read lock. In
order to perform well with hundreds of vCPUs, the vCPU threads really
cannot be acquiring the MMU lock in write mode. The MMU lock above
could be replaced with the TDP MMU pages lock, but that still adds
serialization where it's not really necessary.
The use of RCU also provides a nice separation of concerns, freeing
the various functions which need to remove pages from the paging
structure from having to follow up on freeing them later.

>
> Paolo
>
> (*) this idea is what prompted the comment about s/atomic/shared/
>
