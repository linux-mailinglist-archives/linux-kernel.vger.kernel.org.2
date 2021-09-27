Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978494199AC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbhI0QwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbhI0QwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:52:13 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4388CC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:50:35 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y13so25402874ybi.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TIYpQ8TRXmbwlv5vcUv+AmTBjQHdc48qvKNzwC1i4rE=;
        b=nMOEyLScq7miHOdEzy1rJz8s5KNgr/zxqB09KCXh7y+ty5u4EcVMIwkm9H3M0UeDul
         RWpXGbf8SznnvMocTS+XDD8RdxJX7woW4dvLLtRP3AGQXMK7hxF9TUrG6/hr4BDFxHG0
         Krk4pv+7qxXvR1Wl6QIufjiBTMD9Gq9N/B47S/Ms1q27vBPMLnr/BwkAilBVhX2cQ3Tw
         /ODQTOcL+0a+Su8SNfGPaomoBMqxojKHRVE71xRe1VBlDFtzfhQXBqQgPrmE0kPhJoq+
         0v4KcwK2TAzPzUf+tW2WvXVwAlBcr8bQx2IG9tJEst2pptW/et4UbctnpA+AErjIgH29
         YWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIYpQ8TRXmbwlv5vcUv+AmTBjQHdc48qvKNzwC1i4rE=;
        b=BI+vwQvdsgU2NsVFhxMkTpFnuLC86H03/N3kXP9Hkhtcm/4QA9JSPOeQ8IxTnYEBmY
         bsLuqOl+XJxg/ypICNEyreE10MhoyeuTUHgntfia3XlZqiokNJeW2muHxvP2TDudh9jV
         THbigbDPY+qIPwC9oPGkzaGgpsISjxUMMXDb3n2QpgSUJ6p+/5WTh8mfBxMotIfwAB3n
         TM732/HvuNzWHBtY/64jwnUwW9uG6ZIjuQ5vbdkpgrj0dswtTe1bjBHHWMbdJ0TPKX/U
         xANsPng+4Lzn6L0ejArXC6Yxnwdm+EykexxJIb79iM4mfugjtWOEmwnSeX8SwJvJKO7O
         4p6w==
X-Gm-Message-State: AOAM530SUmGv0/f6mU0MaPuM4DaTDC/x7BLv+tgc6HkTEqPp09HXORTa
        Enh1mwoSGlBIkdiJIc14Oflxlm7Rj87A90Z/uI2ZHg==
X-Google-Smtp-Source: ABdhPJy/ejHqy7xdYijO6CpxOSS2cVh6FemI/7Ghg5YNw3yafh3xQVF3HU0lR6hCZOZscQeWQqLjheZ54vxHbZRgtkI=
X-Received: by 2002:a25:9011:: with SMTP id s17mr919651ybl.61.1632761433793;
 Mon, 27 Sep 2021 09:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210927114635.GH3959@techsingularity.net>
In-Reply-To: <20210927114635.GH3959@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 27 Sep 2021 18:50:23 +0200
Message-ID: <CAKfTPtDvxZt8U=xc104VgSgvyqfrPztSMkbApJvBowr6T7i1Bw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Null terminate buffer when updating tunable_scaling
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sept 2021 at 13:46, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> This patch null-terminates the temporary buffer in sched_scaling_write()
> so kstrtouint() does not return failure and checks the value is valid.
>
> Before
> $ cat /sys/kernel/debug/sched/tunable_scaling
> 1
> $ echo 0 > /sys/kernel/debug/sched/tunable_scaling
> -bash: echo: write error: Invalid argument
> $ cat /sys/kernel/debug/sched/tunable_scaling
> 1
>
> After
> $ cat /sys/kernel/debug/sched/tunable_scaling
> 1
> $ echo 0 > /sys/kernel/debug/sched/tunable_scaling
> $ cat /sys/kernel/debug/sched/tunable_scaling
> 0
> $ echo 3 > /sys/kernel/debug/sched/tunable_scaling
> -bash: echo: write error: Invalid argument
>
> Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/debug.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 49716228efb4..17a653b67006 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -173,16 +173,22 @@ static ssize_t sched_scaling_write(struct file *filp, const char __user *ubuf,
>                                    size_t cnt, loff_t *ppos)
>  {
>         char buf[16];
> +       unsigned int scaling;
>
>         if (cnt > 15)
>                 cnt = 15;
>
>         if (copy_from_user(&buf, ubuf, cnt))
>                 return -EFAULT;
> +       buf[cnt] = '\0';
>
> -       if (kstrtouint(buf, 10, &sysctl_sched_tunable_scaling))
> +       if (kstrtouint(buf, 10, &scaling))
>                 return -EINVAL;
>
> +       if (scaling >= SCHED_TUNABLESCALING_END)
> +               return -EINVAL;
> +
> +       sysctl_sched_tunable_scaling = scaling;
>         if (sched_update_scaling())
>                 return -EINVAL;
>
