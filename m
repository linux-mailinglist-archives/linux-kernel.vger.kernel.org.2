Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD7631E46D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 04:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhBRDEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 22:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBRDEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 22:04:52 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519ECC061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:04:12 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id z18so237924ile.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 19:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNggqLKtzXuYZAHFzTbfh5YHmEXSP/0UgvQxrF83CoY=;
        b=dlEMxlCP4YJvIMWiBqmZGmNkTNvsbRbaG4HmUkyDc2sUZxnMwrI6s1ECCdhTfBfEww
         /9CXnai3+rpOIwMkhgjP5BtohS8i8Gmx9gPAyMET9N5Eskhc5pX0ncLrbI4fe+mIh8sD
         2vFQiYluoiwNZZVTCj/lv2YeuwsRHV0FLMna3XbEbZCjkMm5KLPNJFjolJ/HBL5Vk2aB
         USTEIPc0FsqmpWgrj9XrRFI1HbbVo0CzvNL+8CTkoKsjzUupx2fLlGrIjaTRTGlY0mPh
         8uqH/InAV81icQEp2TzHO1W2uBouGEg7WQSHpg2uB586NyF3lu/ST68olYw44jva65+v
         yo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNggqLKtzXuYZAHFzTbfh5YHmEXSP/0UgvQxrF83CoY=;
        b=MxhWf00RHHtH7ndluA2tF2/SL8+xnzWyUAGlo59Dn6ybx66eXYW81zx0F1BDnMtMnj
         fLXxa69Xufttu3zAZjfw8EJIW06LTL0pe1w/FoQaYYUf+j/kVLMWrkYNIosPOQsbDG7V
         j9aLDGjpDjTCybUigt8LHUx5ey8QVqfMKmoBEQz22U3CMiau2C9TiAQGJZZ0BqCcJPXQ
         eAW+C5WLo/t4k5DZrCoMpC8QqcAje63iXfFe3qWAa/8SdPFU+nwsTx7aQY+Ila3ED+K0
         mwI4YhfBV4YX5TEYXOvxT6cgGZ5zI1SPpYfNLYTgL6ntebnP/IOMll7UMKhnQr089bLL
         Ytog==
X-Gm-Message-State: AOAM5301MQVEde2XUwHqamz0wNxDBdV8ns3+tld+FtG/nniOIf55/qr6
        Z9Vx70Y/7PcezwOa/YscN9zI9AY3njieTLg8Zl8=
X-Google-Smtp-Source: ABdhPJxBxyPhAYBkpCL+Gci953DJ6b0l1Brb4dbL/0ogFgG/L9WkMGdnYOikmRW5+cHg/hgOw6nEzY2lsIXJRM+tpS8=
X-Received: by 2002:a05:6e02:1a8e:: with SMTP id k14mr1964474ilv.308.1613617451718;
 Wed, 17 Feb 2021 19:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20210217115802.49580-1-qiang.zhang@windriver.com>
In-Reply-To: <20210217115802.49580-1-qiang.zhang@windriver.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 18 Feb 2021 11:04:00 +0800
Message-ID: <CAJhGHyDE18PwQtS_W-aZA4Z6SAX3ZiCr6bA1Gqpu=XMN2n724w@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Remove rcu_read_lock/unlock() in workqueue_congested()
To:     "Zhang, Qiang" <qiang.zhang@windriver.com>
Cc:     Tejun Heo <tj@kernel.org>, Tejun Heo <htejun@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Paul


On Wed, Feb 17, 2021 at 7:58 PM <qiang.zhang@windriver.com> wrote:
>
> From: Zqiang <qiang.zhang@windriver.com>
>
> The RCU read critical area already by preempt_disable/enable()
> (equivalent to rcu_read_lock_sched/unlock_sched()) mark, so remove
> rcu_read_lock/unlock().

I think we can leave it which acks like document, especially
workqueue_congested() is not performance crucial.  Either way
is Ok for me.

If it needs to be changed, please also do the same for
rcu_read_lock() in wq_watchdog_timer_fn().

And __queue_work() and try_to_grab_pending() also use local_irq_save()
and rcu_read_lock() at the same time, but I don't know will these
local_irq_save() be changed to raw_local_irq_save() in PREEMPT_RT.


>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  kernel/workqueue.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 0d150da252e8..c599835ad6c3 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4540,7 +4540,6 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
>         struct pool_workqueue *pwq;
>         bool ret;
>
> -       rcu_read_lock();
>         preempt_disable();
>
>         if (cpu == WORK_CPU_UNBOUND)
> @@ -4553,7 +4552,6 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
>
>         ret = !list_empty(&pwq->delayed_works);
>         preempt_enable();
> -       rcu_read_unlock();
>
>         return ret;
>  }
> --
> 2.25.1
>
