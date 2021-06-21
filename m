Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FF63AF4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhFUSU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhFUSUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:20:21 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B571C0610FD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 11:01:51 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so18631203otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 11:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UobgsoS85WbWilqD+j03Ck0yLeFapzsQgkkT7VS2Rdc=;
        b=YPaQooXYhSoY7J2jKyGUCtzuq9ZJDp70SgZvpS0PDADnDfaXhdD6lR0K4CEqrLRUh5
         z71QZsDfa3pIQk4ICLiVuEK6tC6II3ALggNoz5HXI75aWHWUwbBNlhIe9e3pQ/ahiay5
         m9mJh16PNaazUo8Vv+eNgrqrkyLBgM5NQtjqz8pvx8S/FZAemy7C5kanvDGC3C7lilvm
         z4aoBGAC+syzybDCPQ7OOfC/HIeFPy/uACn2GSOUetnBQ6E32rxW/W7BucEu3lDSZxvk
         3teVGXEJbQwir7zZfLj/txB3kql6cFcAujLSkTFHIk0VGw8EAtN2MiRm9iwJMtU9zARA
         Np7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UobgsoS85WbWilqD+j03Ck0yLeFapzsQgkkT7VS2Rdc=;
        b=ew6DzGiDSwA9ypHkCSqbWmPjI2qRJFPf9BPwFbwZY2vCytmuyeKot+Xb18apztdsDd
         iUHAgMXcRG0TybkNiD8S87HuSo7co9JQL1vhYrZitAvvk1mQfkuFyjvPz1PyBkKvRtxm
         WMpOTMQciryiHAycH6vtq3a91sEDOdpWpvIwD7X4le7FAlHB/mnsWY+RRzFEOeGBdss8
         33B7UNk7iKfO08+/3/p+bFVTGZ5VUIqHudKUva09isQwni5L+n78K0ZeX+Nu4GCDGa2I
         L0/6kGQadh1WP32CZNismWBM8dY5peEjBipobu/zhjsBpUghxyZvgmv48jVPwB4xof2G
         sXtw==
X-Gm-Message-State: AOAM530v+TwVLRl73+u3GL7IoI95N2sCsGrKYQLOWRWmcfkIdR/3x7gA
        0PypS8vgcO6Gj2omcHfI5Rf8TJKMMw5Q9dMaIBZxDw==
X-Google-Smtp-Source: ABdhPJyBqkyXivJgH658wOOGmRfckRkH7V9cWxEQnnsYG6biR7E2uQYgwK4rBFTLHIsiYGRHTEMgiu37F0MPTp+xtAI=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr1679873oto.56.1624298510779;
 Mon, 21 Jun 2021 11:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200903141122.72908-1-mgamal@redhat.com> <CALMp9eT7yDGncP-G9v3fC=9PP3FD=uE1SBy1EPBbqkbrWSAXSg@mail.gmail.com>
 <11bb013a6beb7ccb3a5f5d5112fbccbf3eb64705.camel@redhat.com>
In-Reply-To: <11bb013a6beb7ccb3a5f5d5112fbccbf3eb64705.camel@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 21 Jun 2021 11:01:39 -0700
Message-ID: <CALMp9eTU8C4gXWfsLF-_=ymRC7Vqb0St=0BKvuvcNjBkqQBayA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: VMX: Make smaller physical guest address space
 support user-configurable
To:     Mohammed Gamal <mgamal@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 2:22 AM Mohammed Gamal <mgamal@redhat.com> wrote:
>
> On Fri, 2021-01-15 at 16:08 -0800, Jim Mattson wrote:
> > On Thu, Sep 3, 2020 at 7:12 AM Mohammed Gamal <mgamal@redhat.com>
> > wrote:
> > >
> > > This patch exposes allow_smaller_maxphyaddr to the user as a module
> > > parameter.
> > >
> > > Since smaller physical address spaces are only supported on VMX,
> > > the parameter
> > > is only exposed in the kvm_intel module.
> > > Modifications to VMX page fault and EPT violation handling will
> > > depend on whether
> > > that parameter is enabled.
> > >
> > > Also disable support by default, and let the user decide if they
> > > want to enable
> > > it.
> > >
> > > Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> > > ---
> > >  arch/x86/kvm/vmx/vmx.c | 15 ++++++---------
> > >  arch/x86/kvm/vmx/vmx.h |  3 +++
> > >  arch/x86/kvm/x86.c     |  2 +-
> > >  3 files changed, 10 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index 819c185adf09..dc778c7b5a06 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -129,6 +129,9 @@ static bool __read_mostly
> > > enable_preemption_timer = 1;
> > >  module_param_named(preemption_timer, enable_preemption_timer,
> > > bool, S_IRUGO);
> > >  #endif
> > >
> > > +extern bool __read_mostly allow_smaller_maxphyaddr;
> >
> > Since this variable is in the kvm module rather than the kvm_intel
> > module, its current setting is preserved across "rmmod kvm_intel;
> > modprobe kvm_intel." That is, if set to true, it doesn't revert to
> > false after "rmmod kvm_intel." Is that the intended behavior?
> >
>
> IIRC, this is because this setting was indeed not intended to be just
> VMX-specific, but since AMD has an issue with PTE accessed-bits being
> set by hardware and thus we can't yet enable this feature on it, it
> might make sense to move the variable to the kvm_intel module for now.

Um...

We do allow it for SVM, if NPT is not enabled. In fact, we set it
unconditionally in that case. See commit 3edd68399dc15 ("KVM: x86: Add
a capability for GUEST_MAXPHYADDR < HOST_MAXPHYADDR support").

Perhaps it should be a module parameter for SVM as well?

And, in any case, it would be nice if the parameter reverted to false
when the kvm_intel module is unloaded.

> Paolo, what do you think?
>
>
