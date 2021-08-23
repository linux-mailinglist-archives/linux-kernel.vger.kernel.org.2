Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A7E3F502D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhHWSOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhHWSOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:14:01 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE70C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 11:13:18 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id t26so8351919uao.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fjnl2HoYdek4bDGF8q9Dry5mE5i47mO6qIdMvDvvKlM=;
        b=rkOROyK355oHhZhcMezcHUuraKV+r8dH72LpjR0rMOGKx/c8PmrsjE6aKKDRwc6Glo
         DwJv8HlO8xF1ZgHYaY6q7X0VAt7oGIO0iK7TkIHYAfu8BObbdaEnlcFGTtL1MGvk7lTZ
         d6kgwuAAk0+YPLJoO3ZoZIt6dCSdivZkS+6cZER8pbUCt/ZqPseQXCHe7vFccJ7Eih0F
         qMqsGhd1C0wBqTFmGeaLBsnkic1URH+w3RmP1GML7Atu9n+UB+VkZAdD7mqxD2ZBdgGQ
         bkSbFomnuORLEJhk9fcbSWnKGB83p5gqTCOaIp3lHAoLbccdmFXglyZ6DU9dIXizEQsL
         HtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fjnl2HoYdek4bDGF8q9Dry5mE5i47mO6qIdMvDvvKlM=;
        b=H+QHakKOvF1fftSj6YdnXUQIhqyZwIBnOuRmOLaIsYfVDlaP8oznD3K1JrcRRofz0+
         KVnjsj3wKzolXQtX/f/kFQeS8RXEYLL3jro8IVVbS8iua7OhA3vl8/sXGxmxJQ9jy8+a
         8JIHZHfEGYI4kRH6dWO3RQ6du8qz4EHAk8WjwoOuWbjbAzvdNSapRt3S9UQoHyetkVhr
         8RBUBmEgUiITzfGmHzLTOwbRqhLeJkAt9FABov1kCL3/tZ8seZc3XDc9kx8n7H4bKCrh
         FAdOSTpAQw7WcQuM0HHdSaUGgtErgCgNC01/DRSVA6ETXEYFM8pOtLN6dZpo8dP4P2oe
         2Kyw==
X-Gm-Message-State: AOAM532kEzuj45GAhxlFTcZoLBqDNrHnN2k7kxFI4AZD2fEG/hFt7qf8
        7AVQ9QHChqYJXGwO7kaLW/fnC/AoW8XOXtlea/wM2g==
X-Google-Smtp-Source: ABdhPJxC8AT7UO7l/MpTyXU+14h3/7m+NIlnb+CGw0dnDlzHEnbKEweXn1vG5LojIqChLuFG9w+lyDYahZqEgRIru5E=
X-Received: by 2002:ab0:344e:: with SMTP id a14mr7018853uaq.23.1629742397652;
 Mon, 23 Aug 2021 11:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210819223406.1132426-1-rananta@google.com> <87sfz4qx9r.wl-maz@kernel.org>
 <CAJHc60wn7PP1zQ5EKOGQDFbZsf=d9codWTuWbtMT5AHegfbVHw@mail.gmail.com> <875yvzqd5d.wl-maz@kernel.org>
In-Reply-To: <875yvzqd5d.wl-maz@kernel.org>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Mon, 23 Aug 2021 11:13:06 -0700
Message-ID: <CAJHc60wLPFZ5XFwWVyex5GXr=qm7QWc2yOmkECxLh=L2QnvgWg@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Ratelimit error log during guest debug exception
To:     Marc Zyngier <maz@kernel.org>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 3:56 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 21 Aug 2021 00:01:24 +0100,
> Raghavendra Rao Ananta <rananta@google.com> wrote:
> >
> > [1  <text/plain; UTF-8 (7bit)>]
> > On Fri, Aug 20, 2021 at 2:29 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Thu, 19 Aug 2021 23:34:06 +0100,
> > > Raghavendra Rao Ananta <rananta@google.com> wrote:
> > > >
> > > > Potentially, the guests could trigger a debug exception that's
> > > > outside the exception class range.
> > >
> > > How? All the exception classes that lead to this functions are already
> > > handled in the switch/case statement.
> > >
> > I guess I didn't think this through. Landing into kvm_handle_guest_debug()
> > itself is not possible :)
>
> Exactly.
>
> > > My take on this is that this code isn't reachable, and that it could
> > > be better rewritten as:
> > >
> > > diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> > > index 6f48336b1d86..ae7ec086827b 100644
> > > --- a/arch/arm64/kvm/handle_exit.c
> > > +++ b/arch/arm64/kvm/handle_exit.c
> > > @@ -119,28 +119,14 @@ static int kvm_handle_guest_debug(struct kvm_vcpu
> > *vcpu)
> > >  {
> > >         struct kvm_run *run = vcpu->run;
> > >         u32 esr = kvm_vcpu_get_esr(vcpu);
> > > -       int ret = 0;
> > >
> > >         run->exit_reason = KVM_EXIT_DEBUG;
> > >         run->debug.arch.hsr = esr;
> > >
> > > -       switch (ESR_ELx_EC(esr)) {
> > > -       case ESR_ELx_EC_WATCHPT_LOW:
> > > +       if (ESR_ELx_EC(esr) ==  ESR_ELx_EC_WATCHPT_LOW)
> > >                 run->debug.arch.far = vcpu->arch.fault.far_el2;
> > > -               fallthrough;
> > > -       case ESR_ELx_EC_SOFTSTP_LOW:
> > > -       case ESR_ELx_EC_BREAKPT_LOW:
> > > -       case ESR_ELx_EC_BKPT32:
> > > -       case ESR_ELx_EC_BRK64:
> > > -               break;
> > > -       default:
> > > -               kvm_err("%s: un-handled case esr: %#08x\n",
> > > -                       __func__, (unsigned int) esr);
> > > -               ret = -1;
> > > -               break;
> > > -       }
> > >
> > > -       return ret;
> > > +       return 0;
> > >  }
> > >
> > This looks better, but do you think we would be compromising on readability?
>
> I don't think so. The exit handler table is, on its own, pretty
> explicit about what we route to this handler, and the comment above
> the function clearly states that we exit to userspace for all the
> debug ECs.

Sounds great. I'm happy to send out a patch with you as 'Suggested-by' , if you
are okay with it.

Regards,
Raghavendra
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
