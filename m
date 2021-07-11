Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595463C3E25
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 18:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhGKRBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhGKRBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 13:01:46 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1621AC0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 09:59:00 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id t19so15381529qkg.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBrOScKV3V16Gyn7bGSSQx+6TsqpJhHYRyGGGXA76Gw=;
        b=XDFA9W2l1rFNr7zIb0SxhYtrGZi0uF2umXU/lKQCUzrolek4SiNuvCz8QlhhppcOQA
         x9j0221CuPLl2I0O4BiflTtMbarRMobfBt+5l2bTLfAfG+Ywex5sQuHCJqTdIoXfnLoO
         CHpgwOGgkdaZqWTMoJfSA9JjfVYRw6Xv22o6kRJ/MjYm6deqSp6TRD0WgS9DuwyBtTCb
         fuigYcMH87jTxs5XBY56KByk8PnjJO/AhHvfcTRG1NM7cyWfFJL5XM1MjlHcD0q49cP6
         4w6Mj+4CiFZz1JEaBhJ35SSJ7LDplkfgDIoi2YzFvUEgxxmBz8NTIoLy+LrOLPnMlWhO
         IQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBrOScKV3V16Gyn7bGSSQx+6TsqpJhHYRyGGGXA76Gw=;
        b=r7D3U+vY7wq+pt0Fclo9t5p6mP4g9WuM8G3bmwTXFZBtOc71JeTyacJb6Es1xXZQVo
         EEqnxi1eI6m+d1E1/Bb4eO7NTbOFXrmRlzhvBGzGPemaitS26qMfXDt+2SCQ3A9dd/u/
         xd5BqS7nPQyHXQVGiPMEmvJ5RQu3u5iTP6v6yNYubWvgp6sR8teytfaNMhDMc4iWEZxw
         WAxgaU3qAeMBZ/nk/5yfCh35qQ/waW0NoN1BK3wxMtqyPrEv/KBB9IKGXLnvq6TNcgwl
         R0CPtCJsNLNQDCutvNAcDmlFQxvBLxs/rHK+slXRZ03+dt7rppCLmOiB42DInntx4hZT
         miIw==
X-Gm-Message-State: AOAM532jwXMhP+HZYLgPaFNwUNP/nPStbo/cUzqb5MZoGx4zpI9GWLVZ
        GYLSRRxBgrYlnY2hpzR5iHDimeca6/0nNvFX4TRa7g==
X-Google-Smtp-Source: ABdhPJxXCOIObgL8OrlRPXQtRuJlWZZ+YUWJD9kYGloo0i/JQjCzHExS9EJkLyVI5sIdVJoID4+63EbWKLVtdPFxhl8=
X-Received: by 2002:ae9:dd43:: with SMTP id r64mr47648567qkf.216.1626022738963;
 Sun, 11 Jul 2021 09:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210709043713.887098-1-senozhatsky@chromium.org>
 <20210709043713.887098-3-senozhatsky@chromium.org> <CAJWu+opFedsq6CdgUYErnxsv3-Pr7MHi0vz9=hhpMCujFPp8+A@mail.gmail.com>
 <YOjFWZzgQxjPWaXw@google.com>
In-Reply-To: <YOjFWZzgQxjPWaXw@google.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Sun, 11 Jul 2021 12:58:47 -0400
Message-ID: <CAJWu+op31kGH9BpHS5+8ARPuote4n_3XUB=W6YF8yS0ePS1dMA@mail.gmail.com>
Subject: Re: [PATCHv2 2/4] arm64: add guest pvstate support
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 5:53 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:

> > > +DECLARE_STATIC_CALL(pv_vcpu_is_preempted, dummy_vcpu_is_preempted);
> > > +
> > > +static inline bool paravirt_vcpu_is_preempted(unsigned int cpu)
> > > +{
> > > +       return static_call(pv_vcpu_is_preempted)(cpu);
> > > +}
> > > +
> > > +int __init pv_vcpu_state_init(void);
> > > +
> > >  #else
> > >
> > > +#define pv_vcpu_state_init() do {} while (0)
> > > +
> > >  #define pv_time_init() do {} while (0)
> > >
> > >  #endif // CONFIG_PARAVIRT
> > > diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
> > > index 75fed4460407..d8fc46795d94 100644
> > > --- a/arch/arm64/kernel/paravirt.c
> > > +++ b/arch/arm64/kernel/paravirt.c
> > > @@ -40,6 +40,11 @@ struct pv_time_stolen_time_region {
> > >
> > >  static DEFINE_PER_CPU(struct pv_time_stolen_time_region, stolen_time_region);
> > >
> > > +static DEFINE_PER_CPU(struct vcpu_state, vcpus_states);
> > > +struct static_key pv_vcpu_is_preempted_enabled;
> > > +
> > > +DEFINE_STATIC_CALL(pv_vcpu_is_preempted, dummy_vcpu_is_preempted);
> >
> > Could we use DEFINE_STATIC_CALL_NULL and get rid of the dummy
> > function? I believe that makes the function trampoline as return
> > instruction, till it is updated.
>
> Is DEFINE_STATIC_CALL_NULL for cases when function returns void?
>
> We need something that returns `false` to vcpu_is_preempted() or
> per_cpu(vcpus_states) once pv vcpu-state is initialised.

Ah, that might be problematic. In which case what you did is fine. Thanks,

- Joel



>
> [..]
> > > +static bool __vcpu_is_preempted(unsigned int cpu)
> > > +{
> > > +       struct vcpu_state *st;
> > > +
> > > +       st = &per_cpu(vcpus_states, cpu);
> > > +       return READ_ONCE(st->preempted);
> >
> > I guess you could just do:
> > {
> >   return READ_ONCE(per_cpu(vcpus_states, cpu).preempted);
> > }
>
> Ack.
