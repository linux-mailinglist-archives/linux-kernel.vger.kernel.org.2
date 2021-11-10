Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BF244BD46
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhKJIu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhKJIuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:50:55 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528B0C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:48:08 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id az8so1837435qkb.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilWBpVaz7tim4BhtPmkdQdhYCNjSuFWWWOgzt2FZgCw=;
        b=p19pENSim9WAPoNekW+dUA+/dsWZqflDjQ50BWuZnoA3CYeBp/XRPPwvOR3pQ1bIUN
         JI7ZZNzDQlrtoEVpPuOaSIsFCcXDNhEFurwGbGw5VRKSmoBOhT+yC4oyDPVYTnqNMBYe
         lDAdHhhLwm5LudPb4JvIxvsZ0P9kN36zr21/+O79B6Wr9pFCMypPFIkriVA0NE8S23P9
         Vsm3oWcXP8HOXCf3+Q9jt/w6qA/t3w+iCvwQdzk2KxlHsqlWbdu3Ou6co1ZzCJtJl2G2
         tgs4xeh4EM7y009YlcIduEtNIiBKSzoCf+oswmALdTgmbZSi51d4FE564KQBY6he4sKP
         C7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilWBpVaz7tim4BhtPmkdQdhYCNjSuFWWWOgzt2FZgCw=;
        b=ywlGPYhUUT5TPGG9OYBhF63v2bpefZA7iuKNa3SVgfzc1+jFjt4QnK/RcRZxQ4eywU
         Abc4M+pI5HKViMUrCLyJFAG+VHe/rhzJ73rtJ7Searq7LxETC7Y2neQm+x/CCMUAtAa9
         cr0VB9Om5VTF1RUturNAshtnxaSJ/lVTDozBg7ssrCrFx2iKOEfQtg28ZJj1ZszAeV67
         ByW9UII1N6mwnx3xYRtnTDlvoJ3uQQesoh1hi0EuUIqBDaqqJ0S/r5snQEid+tAOEkGR
         hdEAcb6u5hhbxFV0YXkgpXiSpkDP3smZGjzc2ZWgNDn3G77GGwK+1ndM900FaUHQzCYZ
         pi0Q==
X-Gm-Message-State: AOAM531NJgQyTkPTHmWVezBeA4ggukpTg5u5dcMs2mgVUCq4gV5JjynZ
        RdAuS1DofgZMEHSQnIl1hrT63HJAf3AhxwWCI4lsOzOC
X-Google-Smtp-Source: ABdhPJzi1DpXVEX8Nlxe6yE//4t+uaInxzWKxX6RTjKSF/eOF6Rn9i3s45RxwtOWlovwZfaMxqiknpjO9NESNxwuSrc=
X-Received: by 2002:a05:620a:450a:: with SMTP id t10mr11607242qkp.412.1636534087567;
 Wed, 10 Nov 2021 00:48:07 -0800 (PST)
MIME-Version: 1.0
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org> <YYqMJLXcQ4a+Lh/4@hirez.programming.kicks-ass.net>
 <CAGWkznHGZeAeQzpuwi-ZH50R_fm4Nw5r8TSonk8AQatZaB_xSA@mail.gmail.com> <YYuEoftqXxOhStJ7@hirez.programming.kicks-ass.net>
In-Reply-To: <YYuEoftqXxOhStJ7@hirez.programming.kicks-ass.net>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 10 Nov 2021 16:47:46 +0800
Message-ID: <CAGWkznED8Zsy5jxcPWk7u70cmBFER1fY1WDYRo0zD6ptPbyWVw@mail.gmail.com>
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ke Wang <ke.wang@unisoc.com>, xuewen.yan@unisoc.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 4:36 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Nov 10, 2021 at 09:37:00AM +0800, Zhaoyang Huang wrote:
> > On Tue, Nov 9, 2021 at 10:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Nov 02, 2021 at 03:47:33PM -0400, Johannes Weiner wrote:
> > > > CC peterz as well for rt and timekeeping magic
> > > >
> > > > On Fri, Oct 15, 2021 at 02:16:52PM +0800, Huangzhaoyang wrote:
> > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > In an EAS enabled system, there are two scenarios discordant to current design,
> > > > >
> > > > > 1. workload used to be heavy uneven among cores for sake of scheduler policy.
> > > > > RT task usually preempts CFS task in little core.
> > > > > 2. CFS task's memstall time is counted as simple as exit - entry so far, which
> > > > > ignore the preempted time by RT, DL and Irqs.
> > >
> > > It ignores preemption full-stop. I don't see why RT/IRQ should be
> > > special cased here.
> > As Johannes comments, what we are trying to solve is mainly the
> > preempted time of the CFS task by RT/IRQ, NOT the RT/IRQ themselves.
> > Could you please catch up the recent reply of Dietmar, which maybe
> > provide more information.
>
> In that case NAK.
Would you please explaining if there is any constraint to prevent from
doing so? We do think eliminating the preempted time is reasonable and
doable as it is memory irrelevant but probably related to lack of CPU
etc.
