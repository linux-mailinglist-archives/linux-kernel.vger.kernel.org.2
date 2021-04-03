Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B185A3531F4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhDCBbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbhDCBbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:31:02 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3102C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 18:31:00 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f12so240271qtf.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 18:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JHlNTCSKPYkPHrzVLO9kGXjpVBrIBz8nNq/De5MvCQ=;
        b=d7ko8MH+3BuL+ciOLlWbGd7DaIVJy1K77TLGQENN9dJgY2R5RJQIUlw7+x7/YEX2TD
         /21cXKw0dX/xCxocMhrmPF5NrkK2q3VNh3JckN2DlPRtPAi3IiQdMCA+oTCDT7wnM+fI
         K1AHYGBj/Pe8jkLhCvI/LSVIaw1Hm5VmXJpAqx9J1CqwN/KHwtx/gvuk3Sdv7c2862Qi
         z58k0J+ULoJopfR8UC8qznd8sBgSUJJNf5OCRl3nU0bg4XmbY886y3ykXwAOiwl1I2Kf
         kqHaVIGBybsA+rj05KkEtmNUVupfFvv34NotM/X+XyfCp40e4USpk4f+RFKCY+5vnEta
         ZJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JHlNTCSKPYkPHrzVLO9kGXjpVBrIBz8nNq/De5MvCQ=;
        b=dp4Y3/CVUP2QNrRMaZ3KmluRimHCLWtOo8GV2X6wcycUqOEkw6A11YjsjnQDtchlWR
         f3zRPupV0J5sjw+MyI/nlC94aKC+Z3QDSNx49l9WoQ23MVDj76FQIOmdwUm6v3ObM7zd
         0q3lQTUvLDd0KNxZWXwPJNFDsCdo2FRvVlunJVi6qjSWtAwunbYRvPUR+a1KpafK/t1O
         OAHaVIAYfT9XrEGhC05osTW2F5pk3SYafxuAZCcyMFvULdcSjsMCtipE1DhkBb17Urwh
         oGOHdf59MTc0jE26p3FwHiklaoyyqLDwG2/FfuX9v1fR7NNrwH2TMX/2pUF89hknrM3l
         j1AQ==
X-Gm-Message-State: AOAM532HgPcvumqX2BZen2jjyGxyjyWY/NNY4HQX6/mmkgnXJtW1EqVx
        Q3u21T9BbmyOEkBzsL//LAZPpSSZNaKQDKA5yBq76A==
X-Google-Smtp-Source: ABdhPJz1k9d1fbbJ4r2iaVShs5FXuhTsbDFXMm272iJ+XTqfG34UKWXe5ENW0mUWHp6kI9U+fhepoEbGRZIQaicLDrg=
X-Received: by 2002:a05:622a:114:: with SMTP id u20mr13559973qtw.317.1617413459565;
 Fri, 02 Apr 2021 18:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210401131012.395311786@infradead.org> <20210401133917.590280797@infradead.org>
In-Reply-To: <20210401133917.590280797@infradead.org>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 2 Apr 2021 18:30:48 -0700
Message-ID: <CABk29NvYfAAREeBV-gcoQa+LijphCUJXqeJLWjgPr_PTYumUMQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] sched: prctl() and cgroup interaction
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I walked through the reference counting, and it seems good to me
(though it did take a few passes to fully digest the invariants for
the fat cookie stuff).

> +unsigned long sched_core_alloc_cookie(unsigned int type)
>  {
>         struct sched_core_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
>         if (!ck)
>                 return 0;
> -       refcount_set(&ck->refcnt, 1);
> +       WARN_ON_ONCE(type > GROUP_COOKIE);
> +       sched_core_init_cookie(ck, type);
>         sched_core_get();
>
> -       return (unsigned long)ck;
> +       return (unsigned long)ck | type;
 > }

This feels like it needs to be stronger than a WARN_ON_ONCE; could
create a corrupted address that we later try to kfree().

Also, for my own edification, why will the bottom two bits here always be 0?

> -unsigned long sched_core_alloc_cookie(void)
> +static inline void *cookie_ptr(unsigned long cookie)
> +{
> +       return (void *)(cookie & ~3UL);
> +}
> +
> +static inline int cookie_type(unsigned long cookie)
> +{
> +       return cookie & 3;
> +}

s/3/FAT_COOKIE

> +#define FAT_COOKIE     0x03

Move to sched.h to group with TASK/GROUP_COOKIE?

> +static unsigned long __sched_core_fat_cookie(struct task_struct *p,
> +                                            void **spare_fat,
> +                                            unsigned long cookie)
> +{

This function looks good to me, but could use some more comments about
the pre/post-condition assumptions. Ie. cookie already has a get()
associated with it, caller is expected to kfree the spare_fat.

> +       raw_spin_lock_irqsave(&fat_lock, flags);
> +       n = rb_find_add(&fat->node, &fat_root, fat_cmp);
> +       raw_spin_unlock_irqrestore(&fat_lock, flags);
> +
> +       if (n) {
> +               sched_core_put_fat(fat);
> +               fat = node_2_fat(n);

This put() doesn't seem strictly necessary; caller will be
unconditionally freeing the spare_fat. Keep anyway for completeness,
but add a comment?
