Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667EA3C2AFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 23:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhGIV4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 17:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIV4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 17:56:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5854C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 14:53:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so6818252pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MZOA2XtQ30UKVk79SAgvpwg07B6ibw25WfTMs1wX3wg=;
        b=IHpJ/O/YNCyIx4/laDpAon1vX+8b5IFxxvglK8qpKhTPOdXtzVfowf6Gn/lj3L8b8G
         ZLdmYlc2pmGf7R7ikoL3oohwJdn/OZb3wEznR+VIu738fICua1/lPUkE+onuLQ+f2+51
         ZfAVPWJwKXhqTB7+T4dvTXU1f1GV+C4573rQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZOA2XtQ30UKVk79SAgvpwg07B6ibw25WfTMs1wX3wg=;
        b=OI/Fj3deEEL1ExcGAloWhqmTT1EYD6l/nJZq35s+YLewx5ReJd9UN634GbzIfV0kUt
         MNBwShCwl2ta0+itGYog1/vuBTy2A3W1zEmvrYwVvamtB+BPBnA/nKtC+sIu95W0PP68
         M0m7lusCk+U71f3zAc1DTYU4LPMaUV0mz2i8L5lE5uWvLwOrMqXxR4Fs4QOyYxUnuJXC
         hOD+mQo/fyELvj3HkRoaS72qZQAa6QFwzNCgB08dJTZsF99JJaYI3/sBI0Lol28m22s9
         iSPPWCuLmAWeUs8/A5pd3SLHqolxBfbhMtwdt0SZewF11SOe/liunSbM3y3E/VI/nFda
         +66g==
X-Gm-Message-State: AOAM531yYZKhMI7w/q05gUZHJ/GkUzR0P5tmSoURoDYQ7Ied8OAaLuug
        yjsHUfJHPZyTz958shPms4ewjw==
X-Google-Smtp-Source: ABdhPJwIjvak1eY/U96Fw1Oiw9RnSDu8AcJfIY+8EEtq4BMJ3aC1wMo18+OQIYafwjiNiLBisKi3AQ==
X-Received: by 2002:a17:90a:9a1:: with SMTP id 30mr40550193pjo.53.1625867615194;
        Fri, 09 Jul 2021 14:53:35 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:2538:c0b6:d152:9164])
        by smtp.gmail.com with ESMTPSA id d129sm7222990pfd.218.2021.07.09.14.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 14:53:34 -0700 (PDT)
Date:   Sat, 10 Jul 2021 06:53:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCHv2 2/4] arm64: add guest pvstate support
Message-ID: <YOjFWZzgQxjPWaXw@google.com>
References: <20210709043713.887098-1-senozhatsky@chromium.org>
 <20210709043713.887098-3-senozhatsky@chromium.org>
 <CAJWu+opFedsq6CdgUYErnxsv3-Pr7MHi0vz9=hhpMCujFPp8+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+opFedsq6CdgUYErnxsv3-Pr7MHi0vz9=hhpMCujFPp8+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On (21/07/09 14:58), Joel Fernandes wrote:
[..]
> > +struct vcpu_state {
> > +       bool    preempted;
> > +       u8      reserved[63];
> > +};
> > +
> >  #ifdef CONFIG_PARAVIRT
> >  #include <linux/static_call_types.h>
> >
> > @@ -20,8 +25,22 @@ static inline u64 paravirt_steal_clock(int cpu)
> >
> >  int __init pv_time_init(void);
> >
> > +bool dummy_vcpu_is_preempted(unsigned int cpu);
> > +
> > +extern struct static_key pv_vcpu_is_preempted_enabled;.
> 
> pv_vcpu_is_preempted_enabled static_key is not used in any patch.
> Maybe it is stale?

Oh, it is, thanks.

> > +DECLARE_STATIC_CALL(pv_vcpu_is_preempted, dummy_vcpu_is_preempted);
> > +
> > +static inline bool paravirt_vcpu_is_preempted(unsigned int cpu)
> > +{
> > +       return static_call(pv_vcpu_is_preempted)(cpu);
> > +}
> > +
> > +int __init pv_vcpu_state_init(void);
> > +
> >  #else
> >
> > +#define pv_vcpu_state_init() do {} while (0)
> > +
> >  #define pv_time_init() do {} while (0)
> >
> >  #endif // CONFIG_PARAVIRT
> > diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
> > index 75fed4460407..d8fc46795d94 100644
> > --- a/arch/arm64/kernel/paravirt.c
> > +++ b/arch/arm64/kernel/paravirt.c
> > @@ -40,6 +40,11 @@ struct pv_time_stolen_time_region {
> >
> >  static DEFINE_PER_CPU(struct pv_time_stolen_time_region, stolen_time_region);
> >
> > +static DEFINE_PER_CPU(struct vcpu_state, vcpus_states);
> > +struct static_key pv_vcpu_is_preempted_enabled;
> > +
> > +DEFINE_STATIC_CALL(pv_vcpu_is_preempted, dummy_vcpu_is_preempted);
> 
> Could we use DEFINE_STATIC_CALL_NULL and get rid of the dummy
> function? I believe that makes the function trampoline as return
> instruction, till it is updated.

Is DEFINE_STATIC_CALL_NULL for cases when function returns void?

We need something that returns `false` to vcpu_is_preempted() or
per_cpu(vcpus_states) once pv vcpu-state is initialised.

[..]
> > +static bool __vcpu_is_preempted(unsigned int cpu)
> > +{
> > +       struct vcpu_state *st;
> > +
> > +       st = &per_cpu(vcpus_states, cpu);
> > +       return READ_ONCE(st->preempted);
> 
> I guess you could just do:
> {
>   return READ_ONCE(per_cpu(vcpus_states, cpu).preempted);
> }

Ack.
