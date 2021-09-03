Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A8F3FF840
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 02:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347071AbhICAIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 20:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232339AbhICAIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 20:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630627634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GiE0Kz8hd97bsI4uOvNsYgRx7F57w/o68XEctyfGOoY=;
        b=XqSVWEOzytw18hEw+l+l1htTbNFeun1YHLJqIs/s2YEsOi3CkMhnKcrRcI+6Wg298Jk6ew
        tTVg3oEhSimcQcUWEJ26wTU2uj7MuO11pDsYHmxdu2zp5gidmctywEK45TGNH1cVpaN87M
        yS4Z5jR8meb34ZO2GdqCnwNrNt9GlJY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-U9ggwjMvNCaWKgcxGneMcg-1; Thu, 02 Sep 2021 20:07:10 -0400
X-MC-Unique: U9ggwjMvNCaWKgcxGneMcg-1
Received: by mail-qk1-f200.google.com with SMTP id 21-20020a370815000000b003d5a81a4d12so4703106qki.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 17:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GiE0Kz8hd97bsI4uOvNsYgRx7F57w/o68XEctyfGOoY=;
        b=JKU6aqCmzJRVoelesN9gmt5xiZue9IHY+7FH6zbBmQ1hF0m9bnzOXK/t/meVc1FaDh
         3Owg3nrLAamTn5T9qMVjPmvaCqZ0OtLRKWsXcm8D8xw7c6wcWaV1k6pXOEFuC4WuKVhm
         lKw8iNSamoliwyL/KjvThqDyvtleKM6a/n+PuWlHjs+1HB/sVkQKRTD3PM0F2Vy+b64l
         C4cDQK1gq8/iX8CmSa8CtvZ5lh71ZqNxH2htVpYp6PmRPrpY2kNUr4srPzOH+7xdlW8K
         AN1q31CO8E+4pb3+EXThUUERCkaeiKnMMxZl1XuUIIh0XpchGItnuAvKI1VefqofDT2v
         xh7A==
X-Gm-Message-State: AOAM533nc1Sa4VrL7il/hKBWrk/d8HVD+0XjMzTdWPjQw4ab30zYDej6
        o5iN6++XyVtTIKbZgSRttqHVdjgkGRoqT5KqzhEayNZ4VDTIPxrNqCxOucOGtz4eO24Ts4/T4h1
        sKYR1QYH5sgibZyAVSRqBQ7AH
X-Received: by 2002:a37:9f15:: with SMTP id i21mr781045qke.16.1630627629930;
        Thu, 02 Sep 2021 17:07:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIzJsi+jDauVfMiO/Sfeo7b8wmHVIB5ErT3tcjcqEj8KRLLTom0EzgN15/jsMCYalzq0uemA==
X-Received: by 2002:a37:9f15:: with SMTP id i21mr781018qke.16.1630627629679;
        Thu, 02 Sep 2021 17:07:09 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id t64sm2645065qkd.71.2021.09.02.17.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 17:07:09 -0700 (PDT)
Date:   Thu, 2 Sep 2021 17:07:06 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     bp@alien8.de, bsd@redhat.com, corbet@lwn.net, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
Message-ID: <20210903000706.fb43tzhjanyg64cx@treble>
References: <20210812234440.tcssf2iqs435bgdo@treble>
 <20210902181637.244879-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210902181637.244879-1-babu.moger@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 01:16:37PM -0500, Babu Moger wrote:
> I dont have this thread in my mailbox. Replying via git send-email.
> 
> Josh,
>    I took care of all your comments except this one below.
> 
> >I'd also recommend an "auto" option:
>    >
>    >	{ "auto",	PREDICTIVE_STORE_FORWARD_CMD_AUTO },    /* Platform decides */
> 
> >   which would be the default.  For now it would function the same as
> >"off", but would give room for tweaking defaults later.
> 
> There is no plan for tweaking this option in the near future.  I feel
> adding 'auto' option now is probably overkill and confusing.

But if the PSF disable interface is modeled after SSB disable (which I
believe it needs to be) then it's only logical to mirror SSB's default
"auto" option.

And, I actually think that calling it 'psf_disable=off' is *more*
confusing than 'psf_disable=auto'.  Because in this case, 'off' doesn't
actually mean "off".  It means

  "off, unless !ssb_disable=off, in which case implicitly mirror the SSB policy".

So maybe there shouldn't even be an 'psf_disable=off' option, because
it's not possible to ensure that PSF doesn't get disabled by SSB
disable.

BTW, is the list of PSF-affected CPUs the same as the list of
SSB-affected CPUs?  If there might be PSF CPUs which don't have SSB,
then more logic will need to be added to ensure a sensible default.

On a related note, is there a realistic, non-hypothetical need to have
separate policies and cmdline options for both SSB and PSF?  i.e. is
there a real-world scenario where a user needs to disable PSF while
leaving SSB enabled?

Because trying to give them separate interfaces, when PSF disable is
intertwined with SSB disable in hardware, is awkward and confusing.  And
the idea of adding another double-negative interface (disable=off!),
just because a vulnerability is considered to be a CPU "feature", isn't
very appetizing.

So instead of adding a new double-negative interface, which only *half*
works due to the ssb_disable dependency, and which is guaranteed to
further confuse users, and which not even be used in the real world
except possibly by confused users...

I'm wondering if we can just start out with the simplest possible
approach: don't change any code and instead just document the fact that
"spec_store_bypass_disable=" also affects PSF.

Then, later on, if a real-world need is demonstrated, actual code could
be added to support disabling PSF independently (but of course it would
never be fully independent since PSF disable is forced by SSB disable).

-- 
Josh

