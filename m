Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321993B1F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 19:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhFWRCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWRCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 13:02:42 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23F0C061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 10:00:23 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id d19so4049998oic.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WgVdflmLiQbmSRa2NGzT9vSxXEvVu9RNzwe6zI5I6fE=;
        b=m3oQuHHSRjS0TXVHGfuYv3XrYXhJovWrvfrXiQa8R0Pb1eGPhUsrlN+AEpJ1orCtlO
         OxVjHtFDuT4LN87ZjMDH/ilXYpvM28gMoOtbDWGD7CpnOncMgaSjCGlpJZdb8uU+um18
         sZa2Dkva+w7Irafoyy7Ehu0ctdZzQXu7BYmRAjNbcDiK00xZFukU04DGIhecEb2mAjaN
         mXwvGCm76s9I/ekMbiY2mY7eQ+hsRRdoWdF+deePzn3rSSGmzZTbI5PlCb72AbImujjq
         54iW6bupZSeM0Y0elunRaqc++BWsZ1L+nSTHPvx0qMiEpjM1PhOInLgXa8HGdfx5fBL0
         6pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgVdflmLiQbmSRa2NGzT9vSxXEvVu9RNzwe6zI5I6fE=;
        b=LNFgsJJTcghoXkFQZQ0m8qULhoLiN44dXJqnRHKtB/pA8R988WILG9w7X1f37ka3wZ
         vPdhUaG+YHucv9KB2Gkd2pcBS2k4ebOvR7iMMp8PtmR/IGH8dArhjvFPVb9Wv6zJs3Xj
         rypGon2jNt/lXJZgv5G78o04Ukw3M7JyYKSoAOBQe/4nQ9QUG2ot371gbwlcRKRa59oy
         ZkrD+mGX4WWvURV8wqh36cAc1hlxvqLpJlz9KoeG9nNhCme+4FsTjdArEzowuZkTyb/n
         YDNGi5156wcr1PaegjjeYFKWZsrP7AnNojhvX6UsKgE2Im69eKx/id8ABeG3imp3SjlC
         PORw==
X-Gm-Message-State: AOAM533QUABFxI4q+JCDLxhdJiMZ6ugjworSqBuArfI7kdlK9grcfBZD
        YM2gG1jFs8O9wfExxkG0oopMhH8ZkBbFn35aKDmI9g==
X-Google-Smtp-Source: ABdhPJxC7oTapTJAsJN5gFmQS0ezivj81ED7Om9TQr6D2biKVpv/5P84UPRFnVktIf9edrSYiM0toy9rPeFYe/9mA1U=
X-Received: by 2002:a05:6808:14cb:: with SMTP id f11mr4095166oiw.13.1624467622742;
 Wed, 23 Jun 2021 10:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210622175739.3610207-1-seanjc@google.com> <20210622175739.3610207-8-seanjc@google.com>
 <f031b6bc-c98d-8e46-34ac-79e540674a55@redhat.com>
In-Reply-To: <f031b6bc-c98d-8e46-34ac-79e540674a55@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 23 Jun 2021 10:00:11 -0700
Message-ID: <CALMp9eSpEJrr6mNoLcGgV8Pa2abQUkPA1uwNBMJZWexBArB3gg@mail.gmail.com>
Subject: Re: [PATCH 07/54] KVM: x86: Alert userspace that KVM_SET_CPUID{,2}
 after KVM_RUN is broken
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 7:16 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 22/06/21 19:56, Sean Christopherson wrote:
> > +     /*
> > +      * KVM does not correctly handle changing guest CPUID after KVM_RUN, as
> > +      * MAXPHYADDR, GBPAGES support, AMD reserved bit behavior, etc.. aren't
> > +      * tracked in kvm_mmu_page_role.  As a result, KVM may miss guest page
> > +      * faults due to reusing SPs/SPTEs.  Alert userspace, but otherwise
> > +      * sweep the problem under the rug.
> > +      *
> > +      * KVM's horrific CPUID ABI makes the problem all but impossible to
> > +      * solve, as correctly handling multiple vCPU models (with respect to
> > +      * paging and physical address properties) in a single VM would require
> > +      * tracking all relevant CPUID information in kvm_mmu_page_role.  That
> > +      * is very undesirable as it would double the memory requirements for
> > +      * gfn_track (see struct kvm_mmu_page_role comments), and in practice
> > +      * no sane VMM mucks with the core vCPU model on the fly.
> > +      */
> > +     if (vcpu->arch.last_vmentry_cpu != -1)
> > +             pr_warn_ratelimited("KVM: KVM_SET_CPUID{,2} after KVM_RUN may cause guest instability\n");
>
> Let's make this even stronger and promise to break it in 5.16.
>
> Paolo

Doesn't this fall squarely into kvm's philosophy of "we should let
userspace shoot itself in the foot wherever possible"? I thought we
only stepped in when host stability was an issue.

I'm actually delighted if this is a sign that we're rethinking that
philosophy. I'd just like to hear someone say it.
