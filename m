Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAE337079A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 16:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhEAOmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 10:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhEAOm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 10:42:28 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A64C06138B
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 07:41:37 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q136so1074266qka.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9JnfpgxvBiyhUpVXmBLUzz03NBbrZEjK+KMYKJ2t20=;
        b=RnQunxucB260CYXVbm79inYUHgZ5kmjIdmnW3OLRGx5Q+i4uqZCiTmKRoKd0R0TXLV
         P6L8xkfjAcIlpz2bAmkNzp+L9/JpLVObdX27DZEcg1F9p+BCVj364+5+rces1tNfa5U/
         I8UPM+Ya3vSjP4F5N3Dqg4/XCVuoUSHmiQVqb8hXDcrR/amfimYOkdx3EefnQaOnVIxg
         tLbrEAHfJZ5LvRMFZJWULKFp+nASHLjP64VqxjGylJvIXlAdfGkU3WXhYQfXAfP8u3IQ
         Sezbjwgv+EJe6NEYmcNoE7zGIV6U/G2Hhz2dZ6geBBw85xFAQY5QdrVb4DWUSRrjsMrp
         0t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9JnfpgxvBiyhUpVXmBLUzz03NBbrZEjK+KMYKJ2t20=;
        b=avAyU8pgkThW/2xj8vsM9A3o0ZCMUIrqJ7n99E9A/gaBT4ZMkFJOYcZSDLPek0HgJI
         JODUX+f9+7rHH/MyspdB0QTqTHLgOalmybk18l5QkRRr5n+MWMqcDGzrpg5pkrDWZwaf
         1EWOc9qnbnf6HzjB4JxN1daqRQBUZGIjdzosTkyhbSUbT7bhSxNEY1fAFGZY1HDRTcEL
         we1i9OpEmBBlX0ygwAcWIAYdnGf/CGLjW92wdyA5m4p8OzBw33su/QNEzNUujWU+jkoN
         F/w0ZOFSO9IMM0BlFNee+yeBjeuu41PQ3JC8IOeuxnjnatJFNC6jWdBF97bAiPwYw268
         RfsQ==
X-Gm-Message-State: AOAM533yLFaYxWhncjMLKctxXP60qI2OnbBIeYCLnDbImYFTW68ECh/w
        AM4JWtYbYyt+lslgr8OpT/XGwOYBua50XapSyxHl7Q==
X-Google-Smtp-Source: ABdhPJyWgSHVKEXPER/7IfIcz98GlwMr0AgGhNvCqe19/dta7G7yZ+iD5nISVKSVlTChdgopDKP+A2OctJgI/Y5NmQc=
X-Received: by 2002:a37:e10e:: with SMTP id c14mr10319909qkm.209.1619880096227;
 Sat, 01 May 2021 07:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210425080902.11854-1-odin@uged.al> <20210425080902.11854-2-odin@uged.al>
 <20210427142611.GA22056@vingu-book> <CAFpoUr1KOvLSUoUac8MMTD+TREDWmDpeku950U=_p-oBDE4Avw@mail.gmail.com>
 <CAKfTPtCtt9V69AvkJTuMDRPJXGPboFsnSmwLM5RExnU2h5stSw@mail.gmail.com> <4ba77def-c7e9-326e-7b5c-cd491b063888@arm.com>
In-Reply-To: <4ba77def-c7e9-326e-7b5c-cd491b063888@arm.com>
From:   Odin Ugedal <odin@ugedal.com>
Date:   Sat, 1 May 2021 16:41:03 +0200
Message-ID: <CAFpoUr3vMQq8QYajXZsQ6zWQOncO5Q8-2gFWOJLFm-APUznuZA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix unfairness caused by missing load decay
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I think what I see on my Juno running the unfairness_missing_load_decay.sh script is
> in sync which what you discussed here:

Thanks for taking a look!

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..7214e6e89820 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10854,6 +10854,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>                         break;
>
>                 update_load_avg(cfs_rq, se, UPDATE_TG);
> +               if (!cfs_rq_is_decayed(cfs_rq))
> +                       list_add_leaf_cfs_rq(cfs_rq);
>         }
> }

This might however lead to "loss" at /slice/cg-2/sub and
slice/cg-1/sub in this particular case tho, since
propagate_entity_cfs_rq skips one cfs_rq
by taking the parent of the provided se. The loss in that case would
however not be equally big, but will still often contribute to some
unfairness.


Thanks
Odin
