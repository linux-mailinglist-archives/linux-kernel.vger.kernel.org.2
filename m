Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6742151D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhJDR0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhJDR0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:26:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0871C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:24:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x27so74136399lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEcLDwK9m1057jui6AApVi77iUKrt1BBHKk+cl8sBwg=;
        b=TnB++IRae/jo7gqmQjvRKcHMHKTEqCZDZphTfi5vqyHYACWjXUvpjyPRFMIh9KZN4I
         WnSWO3bAsjSUNczaIep4vUgkrW4Xkc2ZKwYP9nvihsSLiG2BAOx8GhVX9b6/+iiS0tFH
         k0r5k6pUly5KokxDk1+787vNZJfhPAsJHdfl2BFuxeaST/d+CUl2KLhb51OQxSLZYfD2
         pjjuWIBmQsmt3Ohu1veqNZMuquHHpjwDPqYrnVG9FfFe7XhCnvRQCLFCQI6HDiAOcJXc
         tf2e/QLDCOpEgcy6ghQvYIWqFc6qRvU5YXWA5oML13c00Wf4o9ga0BnaVrt40rNS7YOk
         OjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEcLDwK9m1057jui6AApVi77iUKrt1BBHKk+cl8sBwg=;
        b=4Vi45UJXMlzPztlQc0Of3QMut1AZ8rlKP2SFaVvDqn9VXMwvjPxOfNts3NIS965JVE
         nMY4ZqyM056LUQNbjpYgNmkRdsOk+EHZOicWMFaKaVYuI05dSK9oxj3nm/4ftJGGokug
         IHKxfTsG7cPbQww26fWUpIonNhiGdUrIJGuWamRHQnrHbGD+0DrRteRDSrMpVBcQIA5c
         ZDFBruiSEF0o1wGvL3vIvFpfqyQC6aFC4Sq1DQ+LUi0LG8+kQG7ghrWWUwdDTK01EZvi
         GjCwR2YAPvm4uaKcPMVAU2FttglKph/0WCnA4lKNKskDJ+OpgtFcyW27q5mDoeUKuwxj
         udRw==
X-Gm-Message-State: AOAM532RSWh9aTPr/muuzmgYrG3QH9bHMeKpsuFDDGT/UH/u8XXEPW5y
        zs9bHavzqIRXQf1IW2djcFBdRZX2exW4UbXXzaOzlw==
X-Google-Smtp-Source: ABdhPJzmD4UEBiXFKhf3rNaJHbKhr3KtSIrZIN1GdcE1+jJQvDvJM30Za3MQXvWxtLqb+LdeTrVIpEaC31hVR+x7lVM=
X-Received: by 2002:a05:6512:3193:: with SMTP id i19mr15780869lfe.485.1633368251172;
 Mon, 04 Oct 2021 10:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210617090941.340135-1-lee.jones@linaro.org> <YMs08Ij8PZ/gemLL@slm.duckdns.org>
 <YMs5ssb50B208Aad@dell> <CAJuCfpHvRuapSMa2KMdF4_-8fKdqtx_gYVKyw5dYT6XjfRrDfg@mail.gmail.com>
 <YVsuw+UBZDY6Rkzd@slm.duckdns.org> <CAJuCfpHprdJWpR_HPSVm6DFEOJj4RWmWC10=ZdGYF_JFAvV+_g@mail.gmail.com>
In-Reply-To: <CAJuCfpHprdJWpR_HPSVm6DFEOJj4RWmWC10=ZdGYF_JFAvV+_g@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 4 Oct 2021 10:23:59 -0700
Message-ID: <CALAqxLV-tOgBMAWd36sg+bh3s0XXqKWD+P-CYgVXf7Won4auAA@mail.gmail.com>
Subject: Re: [PATCH 1/1] cgroup-v1: Grant CAP_SYS_NICE holders permission to
 move tasks between cgroups
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Wei Wang <wvw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 9:57 AM Suren Baghdasaryan <surenb@google.com> wrote:
> On Mon, Oct 4, 2021 at 9:41 AM Tejun Heo <tj@kernel.org> wrote:
> > On Thu, Sep 30, 2021 at 02:20:53PM -0700, Suren Baghdasaryan wrote:
> > > Some of the controllers are moving to cgroup v2 but not all of them
> > > are there yet. For example, there are still some issues with moving
> > > the cpu controller to v2 which I believe were discussed during Android
> > > Microconference at LPC 2021.
> >
> > Care to provide a summary?
>
> Unfortunately I could not be present at LPC this year but Wei I
> believe was the presenter (CC'ing him).
> Wei, could you please summarize the issues with moving the cpu
> controller to cgroups v2?

Tejun: We were sorry you didn't join as we were hoping for your
attendance for the discussion!

For reference, here's the video of the session:
  https://www.youtube.com/watch?v=O_lCFGinFPM&t=2941s

And continued discussion from the BoF:
  https://youtu.be/i5BdYn6SNQc?t=703

But Wei can still chime in with a more focused summary, maybe?


> Also CC'ing John, who I believe tried to upstream this patch before.

We sort of went in a big circle of creating a config time option w/
CAP_SYS_NICE, then a new CAP_CGROUP_MIGRATE then switching to
CAP_SYS_RESOURCE and then back to CAP_CGROUP_MIGRATE, and when that
was panned I gave up and we kept the small patch in the Android tree
that uses CAP_SYS_NICE.

Links to previous attempts & discussion:
v1: https://lore.kernel.org/lkml/1475556090-6278-1-git-send-email-john.stultz@linaro.org/#t
v2: https://lore.kernel.org/lkml/1476743724-9104-1-git-send-email-john.stultz@linaro.org/
v4: https://lore.kernel.org/lkml/1478647728-30357-1-git-send-email-john.stultz@linaro.org/
v5: https://lore.kernel.org/lkml/1481593143-18756-1-git-send-email-john.stultz@linaro.org/

thanks
-john
