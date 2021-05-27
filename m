Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBC2392C25
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbhE0KvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbhE0KvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:51:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1406C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:49:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a4so186368ljd.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ua/saZqvwIMzSQnurwAoIde+A9NKg6vplyBhL5Gjil4=;
        b=n3Ys6kd7oq4RSx9GNj8DAA5OwUiXPsXOyHkKi4ZRtB5UzEfN9jKd8g9uQ+py8Fchnu
         fI7VGGVjbWZy5DS5ow4F8bDjLto8EruGhYNLiocK0BczIXSdROGiHePAUQv0qODETxxA
         G2p21I16bmk3PmwbTJlbd/AbqrRwZohgPCkEIBMmzq0nbqqaJZmGrFqx9q4Y7ktsaM2S
         /+UL/lN3Lu1j+/wVUJjJqf6gvjEkcxY26sZWu4IU5uWRbI3wyXkK9tzIx5CrU51KmbSw
         EujG94Xm2TUwhicxy48R02bwtQQMzRXMSSY8dTBGEXDxAKL7en4rsM+CtVzkyhO+qq9V
         ASyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ua/saZqvwIMzSQnurwAoIde+A9NKg6vplyBhL5Gjil4=;
        b=sFWGrJMzGkhM71xrzO5lc3i0pjwCElg0NDap99vak4xELxzWCGDTV6lO+SzVgVvgHC
         /HRVdB3BISP0rEHyixwc2eGl13/XHI6ZHEY+faI9kHmfbTctZ2vQLCYsxXvEknyJIR3b
         TA7t8q8SuLBr0/WwkI1lGxf4CRFyBKuDZpqFUpE3fnuUnCgBfCgNWUJ8ak9VdfhaH/rm
         TzOIV6ubeyHYiAuMBVMScWSoqoH7ayyprLbF0slrW7PQr94plwkCIy8LaYuZHi2L5oet
         dbS3L4c2dd1r4/OAIQMFZlgRgZ6OE4AHwKQwk3YRd6zFPB9eEBDTCcOLoydhVLcqFz/v
         DOOw==
X-Gm-Message-State: AOAM533zxbSVgiutJUgwLa4qKDRfX6I/d0uWfWtt/XRc0XK5P/4wykCk
        4F0pZ60t3i7YTro7LGtncYyCzkjpJw0xJaQnWE9HIA==
X-Google-Smtp-Source: ABdhPJw5PrpS6wRAqAuy1LwBF+ZprULcob3L33drJjObvMSeJtf2Aj5MH+3//EqJ+/kgp6sn/feEUp2dJDEZSsa2X6g=
X-Received: by 2002:a2e:8557:: with SMTP id u23mr2055801ljj.221.1622112574244;
 Thu, 27 May 2021 03:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-2-odin@uged.al>
 <CAKfTPtCCZhjOCZR6DMSxb9qffG2KceWONP_MzoY6TpYBmWp+hg@mail.gmail.com>
 <CAFpoUr0f50hKUtWvpTy221xT+pUocY7LXCMCo3cPJupjgMtotg@mail.gmail.com>
 <CAKfTPtCaZOSEzRXVN9fTR2vTxGiANEARo6iDNMFiQV5=qAA4Tw@mail.gmail.com>
 <CAKfTPtAFn3=anfTCxKTDXF0wpttpEiAhksLvcEPdSiYZTj38_A@mail.gmail.com>
 <CAFpoUr1zGNf9vTbWjwsfY9E8YBjyE5xJ0SwzLebPiS7b=xz_Zw@mail.gmail.com>
 <CAKfTPtDRdFQqphysOL+0g=befwtJky0zixyme_V5eDz71hC5pQ@mail.gmail.com> <CAFpoUr0SOqyGifT5Lpf=t+A+REWdWezR-AY2fM_u1-CCs8KFYQ@mail.gmail.com>
In-Reply-To: <CAFpoUr0SOqyGifT5Lpf=t+A+REWdWezR-AY2fM_u1-CCs8KFYQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 May 2021 12:49:22 +0200
Message-ID: <CAKfTPtArj_XkgPXRJKZxN0MM2+v=3+RjAVVkmbpB1gBLCuzJvA@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Add tg_load_contrib cfs_rq decay checking
To:     Odin Ugedal <odin@uged.al>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 at 11:46, Odin Ugedal <odin@uged.al> wrote:
>
> Hi,
>
> > I finally got it this morning with your script and I confirm that the
> > problem of load_sum == 0 but load_avg != 0 comes from
> > update_tg_cfs_load(). Then, it seems that we don't call
> > update_tg_load_avg for this cfs_rq in __update_blocked_fair() because
> > of a recent update while propagating child's load changes. At the end
> > we remove the cfs_rq from the list without updating its contribution.
> >
> > I'm going to prepare a patch to fix this
>
> Yeah, that is another way to look at it. Have not verified, but
> wouldn't update_tg_load_avg() in this case
> just remove the diff (load_avg - tg_load_avg_contrib)? Wouldn't we
> still see some tg_load_avg_contrib
> after the cfs_rq is removed from the list then? Eg. in my example
> above, the cfs_rq will be removed from
> the list while tg_load_avg_contrib=2, or am I missing something? That
> was my thought when I looked
> at it last week at least..

1st : ensure that cfs_rq->load_sum is not null if cfs_rq-> load_isn't too
2nd : call update_tg_load_avg() during child update so we will be sure
to update tg_load_avg_contrib before removing the cfs from the list

>
> Thanks
> Odin
