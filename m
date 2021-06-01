Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A04A392B13
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhE0JsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbhE0JsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:48:12 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBD7C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:46:39 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v8so13977qkv.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGSqh763sJ9tRWKESBK9C6KkYC01mkebqHWMvcOi984=;
        b=PZqwC6CnqXIdNEBEYc5be4bb5TccuGjFHDTVOl6jEnmBTLckP6WY85jbCuEoM7Hn89
         uyKnQniI/yGgivD73pop7f7tmhTCzq2sEclTRfSApZZihg+b4jBZvtgGXXjFkwFVx7TA
         0eNicuik9UNu5kptl4bnyD2lz1SXH4eV01tQxhn0cKNXT0IAxDGbChUbVPipuhb3SnkK
         JQG6FCCHir0bSm0RBZCX1wYCBd2gH02QUaYNrSC1Iu3YPJzcPwD9B/qIknRrdSoiVL61
         ag3Pa47muV/fq2zJ2RLaG1Vg2FYVkWdvcTnEXfvdKIc62AwNLBG39/9uoRDG0RgiUGyl
         JZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGSqh763sJ9tRWKESBK9C6KkYC01mkebqHWMvcOi984=;
        b=s7h0WKuUi38BvkKpazwyKTOOqMeXN/DhV1RytfZbSAf6LeevkhmRImbcQodAYxsjQh
         m9qBz6X9uMxbo9OuG3SOIYi5JFDJPdiouJHylUthj0ej0SzcCo1Q9EROMVqXc4sEarLv
         xHAZ9tz435t+8d14JtWvdxAgjOQVlYieKIWsTmRvoaViWXtUHtHT2n43DtcV/183LSbr
         ingAKM1NmlEbm8cK8c6+sOZz35YSPh+M989yRAfZwDYUOYQIzuqx7oh/owUO14/YCF0p
         ZZwYlSxsCy4xBCb6AwWyVEuIifhptKBrozb9cbCktKWdM2mY+uQ/DrNFDxARBITEqDRg
         WeIQ==
X-Gm-Message-State: AOAM530hcGLr+iHPmw242f60Y7g9JlWdLFlymdwqbK8zL0wzlvcxcPjW
        eTpnsXK4WdRpiR5oBLKVZrHZa4oZ1w4i5VzriNgokg==
X-Google-Smtp-Source: ABdhPJwIF05wpXAw9pqMwDQ5xcuoUYcj0EY3dS+QUG3fROu4t9IkVfLbYNK7UmvxjdWvmIKk1R19pbREb7TVFt0XHtE=
X-Received: by 2002:a37:9b84:: with SMTP id d126mr2417755qke.209.1622108797671;
 Thu, 27 May 2021 02:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-2-odin@uged.al>
 <CAKfTPtCCZhjOCZR6DMSxb9qffG2KceWONP_MzoY6TpYBmWp+hg@mail.gmail.com>
 <CAFpoUr0f50hKUtWvpTy221xT+pUocY7LXCMCo3cPJupjgMtotg@mail.gmail.com>
 <CAKfTPtCaZOSEzRXVN9fTR2vTxGiANEARo6iDNMFiQV5=qAA4Tw@mail.gmail.com>
 <CAKfTPtAFn3=anfTCxKTDXF0wpttpEiAhksLvcEPdSiYZTj38_A@mail.gmail.com>
 <CAFpoUr1zGNf9vTbWjwsfY9E8YBjyE5xJ0SwzLebPiS7b=xz_Zw@mail.gmail.com> <CAKfTPtDRdFQqphysOL+0g=befwtJky0zixyme_V5eDz71hC5pQ@mail.gmail.com>
In-Reply-To: <CAKfTPtDRdFQqphysOL+0g=befwtJky0zixyme_V5eDz71hC5pQ@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 27 May 2021 11:45:58 +0200
Message-ID: <CAFpoUr0SOqyGifT5Lpf=t+A+REWdWezR-AY2fM_u1-CCs8KFYQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Add tg_load_contrib cfs_rq decay checking
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
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

Hi,

> I finally got it this morning with your script and I confirm that the
> problem of load_sum == 0 but load_avg != 0 comes from
> update_tg_cfs_load(). Then, it seems that we don't call
> update_tg_load_avg for this cfs_rq in __update_blocked_fair() because
> of a recent update while propagating child's load changes. At the end
> we remove the cfs_rq from the list without updating its contribution.
>
> I'm going to prepare a patch to fix this

Yeah, that is another way to look at it. Have not verified, but
wouldn't update_tg_load_avg() in this case
just remove the diff (load_avg - tg_load_avg_contrib)? Wouldn't we
still see some tg_load_avg_contrib
after the cfs_rq is removed from the list then? Eg. in my example
above, the cfs_rq will be removed from
the list while tg_load_avg_contrib=2, or am I missing something? That
was my thought when I looked
at it last week at least..

Thanks
Odin
