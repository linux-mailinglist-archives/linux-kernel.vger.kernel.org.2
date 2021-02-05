Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C283104D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 07:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhBEF7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 00:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhBEF7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:59:31 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3136C06178B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 21:58:50 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id k193so5879960qke.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 21:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZ0GQLJipF2hQIt0oYg/b3YND75QYohdSOPgCgGvmtI=;
        b=oPGsTQx7+FdG6LRGl1TD3o+RbriHfudMdPEUWdoVcGtiFVzJyADmDY4/qjjG1+UIcy
         wjKL99cqQfoIL+mWKhEojF7j3xy7b/FwNrgzFcnaC4VE2BI5tBDFbEYcfnximoQpd7Bo
         foetOy+pvkseCt44S1+fCOI+yg3iGoGzvmkUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZ0GQLJipF2hQIt0oYg/b3YND75QYohdSOPgCgGvmtI=;
        b=jiL+KGOOpfrGW1ltdFIbtHerFqvI4licC166/ZbkwWxecR5OEcpSc6wgpUc8p4d0Fn
         E8d2JFyJRJZe/viA+Mc2WYePWPtZK+0e5EZfVC2HPyLbH9ceTuu3KZe0aY9HCSIlUYNL
         I24Shi0qT1mtAHVvbbWPQYtgf443ISh1B+uylUQt1VKlxFEIclQuMRfaaJTrHIf70YTB
         Dxn5fmW6Y6FD1d+h/BfMgnjA1RFJOIYxpZe36D16BTLKRGCCXXwLftN0rwR6/IQ/RjtO
         9pn9Y5lRLKgamNCDS8CFFZTwVXbsRffTnntMKgdBhvEGT9Q8PzU3dCRN5vSSvWAwNZHk
         Ya+w==
X-Gm-Message-State: AOAM533Gy0bS4sBGcd6YAnKZWo9i2sP6vCm0qxXtECKyFtUuH00r+Uvg
        JOrMVe17Xwai1FWWKM0c1S4sAjsDEQSGGdUJQECPpQ==
X-Google-Smtp-Source: ABdhPJwYA73lftjBriOP+37YGUdH+MFOawlYakwpkyiHcFfBQsl9Chfbewfaer8b9y41czh2lCGjkNZ6cshLgPPsL0I=
X-Received: by 2002:a37:73c3:: with SMTP id o186mr2728785qkc.194.1612504730031;
 Thu, 04 Feb 2021 21:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20210128060515.1732758-1-stevensd@google.com> <c01b01dc-c636-1d1b-fb42-df718e23d20a@redhat.com>
In-Reply-To: <c01b01dc-c636-1d1b-fb42-df718e23d20a@redhat.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Fri, 5 Feb 2021 14:58:38 +0900
Message-ID: <CAD=HUj5sKKnckSqBjjR8paGegLfSujk03C5uDwzfh=PAaj5BZA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] KVM: x86/mmu: Skip mmu_notifier changes when possible
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        linux-mips@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches might be responsible for some instability in one of our
stress tests. I'll send an update once I figure out what's going on.

Thanks,
David

On Thu, Jan 28, 2021 at 9:48 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 28/01/21 07:05, David Stevens wrote:
> > These patches reduce how often mmu_notifier updates block guest page
> > faults. The primary benefit of this is the reduction in the likelihood
> > of extreme latency when handling a page fault due to another thread
> > having been preempted while modifying host virtual addresses.
> >
> > v2 -> v3:
> >   - Added patch to skip check for MMIO page faults
> >   - Style changes
> >
> > David Stevens (1):
> >    KVM: x86/mmu: Consider the hva in mmu_notifier retry
> >
> > Sean Christopherson (1):
> >    KVM: x86/mmu: Skip mmu_notifier check when handling MMIO page fault
> >
> >   arch/powerpc/kvm/book3s_64_mmu_hv.c    |  2 +-
> >   arch/powerpc/kvm/book3s_64_mmu_radix.c |  2 +-
> >   arch/x86/kvm/mmu/mmu.c                 | 16 ++++++++------
> >   arch/x86/kvm/mmu/paging_tmpl.h         |  7 ++++---
> >   include/linux/kvm_host.h               | 25 +++++++++++++++++++++-
> >   virt/kvm/kvm_main.c                    | 29 ++++++++++++++++++++++----
> >   6 files changed, 65 insertions(+), 16 deletions(-)
> >
>
> Queued, thanks.
>
> Paolo
>
