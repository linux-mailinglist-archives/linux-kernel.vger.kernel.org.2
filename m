Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7A445C06
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 23:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhKDWMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 18:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhKDWMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 18:12:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E5AC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 15:09:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so14842448lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 15:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ODhjY+JjkYpUpFv09zJB9aBghMhLyhOS/H4FgA78QU8=;
        b=JHVS8Ow1HVeUipVMLT11yHlvnxUVD2nceGQ5AKOw+p77/NeUjmgxc/oFiHSOxrbrpy
         Is/GwTZWZuoxrsC80rpbv/2Y8AaAq/cFI3MhtzhNbqZ2SeltjziPfSnhXJUAjXXzuneh
         06pZbRk62NEQyFwifnDmYhpdXaj5WIbqygNh018AToErjr1rpOAMHzMlLBgBnFYYWmsM
         n3epCtFUKoO951mcxkIQfDT2Ez/LVEgPNqs68kV3L8jvbEOgor4J5JFG089J8+xV4Vwu
         lLYjqTpUdsD5O3nUSnHNlw2U5elxiK5a1njy2kFnY+pVVBcnd9VbIH0GJWibXuXHxCHT
         qOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ODhjY+JjkYpUpFv09zJB9aBghMhLyhOS/H4FgA78QU8=;
        b=5e1Z8+NurxWkgBl3g6dKs7tpn7g5tIfhxuQsZfx74oZF/gERNwiYTHL37v457Z3kiV
         I1jvtWwUTTHJccO6D6IFfCg2HvQZjccm7NOzz3+sHGpz7fw1T6kF7xyg7a+HAefv7BrD
         ZI0zhWDHOxu2I9DXWwQQFPLx03Pb7Xdmhv/QaGAPhufTE46RPC+OgmDVDhOB6hUHl4n5
         5PXmx9KUIvXk7boBOG5+EmW1vKUuOBEinwqj0XMtvdb147nY4esc+gM/X+CuSy07DQgI
         z1E5h5mIXSsN03eUGyzo5PJnRDeSuh86Q/7UyTc+012KRgz7Vq3HCoLrOQUpnO7SoFO6
         vKGQ==
X-Gm-Message-State: AOAM531lOR4OffewscL8RJvc28N1b1lErQqfGIbOoVLZ44ZHwEivmV/o
        L+U8Zlg7j7r+xkkADg6BaJTBe63YzNpHFM7gKeQsZA==
X-Google-Smtp-Source: ABdhPJyCySNfwv75WoGWFSPYJQ9LqbdrCPdqJpHKt8D7zE+l3mpEMxyt3SFexC6VWMES75d4HEuprj4x5ybvSm5jjD4=
X-Received: by 2002:a19:740f:: with SMTP id v15mr29475880lfe.184.1636063770123;
 Thu, 04 Nov 2021 15:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211013180130.GB22036@blackbody.suse.cz> <20211014163146.2177266-1-shakeelb@google.com>
 <20211104142751.5ab290d5cf4be1749c9c87ed@linux-foundation.org>
In-Reply-To: <20211104142751.5ab290d5cf4be1749c9c87ed@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 4 Nov 2021 15:09:18 -0700
Message-ID: <CALvZod5xT2Mi2wktD-OTS0xkChNzArnMCLBNy7cg0dVupSOhXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] memcg: flush stats only if updated
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mkoutny@suse.com, cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 2:27 PM Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>
> On Thu, 14 Oct 2021 09:31:46 -0700 Shakeel Butt <shakeelb@google.com> wro=
te:
>
> > Hi Michal,
> >
> > On Wed, Oct 13, 2021 at 11:01 AM Michal Koutn=C3=BD <mkoutny@suse.com> =
wrote:
> > >
> > > On Fri, Oct 01, 2021 at 12:00:39PM -0700, Shakeel Butt <shakeelb@goog=
le.com> wrote:
> > > > In this patch we kept the stats update codepath very minimal and le=
t the
> > > > stats reader side to flush the stats only when the updates are over=
 a
> > > > specific threshold.  For now the threshold is (nr_cpus * CHARGE_BAT=
CH).
> > >
> > > BTW, a noob question -- are the updates always single page sized?
> > >
> > > This is motivated by apples vs oranges comparison since the
> > >         nr_cpus * MEMCG_CHARGE_BATCH
> > > suggests what could the expected error be in pages (bytes). But it's =
mostly
> > > wrong since: a) uncertain single-page updates, b) various counter
> > > updates summed together. I wonder whether the formula can serve to
> > > provide at least some (upper) estimate.
> > >
> >
> > Thanks for your review. This forces me to think more on this because ea=
ch
> > update does not necessarily be a single page sized update e.g. adding a=
 hugepage
> > to an LRU.
> >
> > Though I think the error is time bounded by 2 seconds but in those 2 se=
conds
> > mathematically the error can be large.
>
> Sounds significant?

Yes it can be.

>
> > What do you think of the following
> > change? It will bound the error better within the 2 seconds window.
>
> This didn't seem to go anywhere.  I'll send "memcg: flush stats only if
> updated" Linuswards, but please remember to resurrect this idea soonish
> (this month?) if you think such a change is desirable.
>

Yes, I will follow up on this soon.
