Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AF7313CE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhBHSM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhBHPl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:41:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2039C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 07:40:43 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id t2so3825933pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 07:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Qc/45eRqfQBEqGJzHaK7yd+vGYvqGu3tixgC95meQM=;
        b=ADAdFY96oK/I7o3ug5tJCI7osmm84XxY6ZcJC1dr4wp6o5mwqhiAYugzWpzgFwyunC
         yTTyCZolYCEXb0kYEL0SQmTfBsVq26Ucyq3osiHJGYd0PMeu2Umivj0RyLa7TePa62Ug
         oHNg9zblMo28u90xXEhH3HawKmkSWlNGl77MSEa8O1qGDw49+21SpVx3NaMGIIxTRWae
         Hvbr6lsA+MQnxlXQjsuTANo6nw3cEJLkQNeFJIWOIzGUkHzze2RLN40mPePiDoRtAIuf
         B6UTnJo9LBBRA7mzAQdgV8vwEigVzvTP96KXzRDHOTVnWEG9eM7jTTV0apzhCdwIatmx
         U0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Qc/45eRqfQBEqGJzHaK7yd+vGYvqGu3tixgC95meQM=;
        b=lnq52uZJQ2XAbarFp24Td+kjK5r+WAIS8EWP3r+4L5nijI8Qy6M/QQIs6uWiLZDTtd
         r9O1oABsgIXhZPWdc2IXLDWAcBVxqbl9PPQdVFmJIWeiorGAqUBsFWydhZakQbqu3/7i
         +ywazgz7kHVuSIn+yDoOOpsBuzLcjmCu4zz+CfTthiQT4RxCU1gveEytFbkeIlRb88Uu
         pwOeAeHzLDymCuMF62r5h8UPfFQLOx5L8MmYhIxhY63AlYVX4ozV6WsnuYj+6kspTpKa
         u3zecefVK2uxcv8NeGPmNRHU/VW8miN8uQB1KlIs7SQIwAS1gbEo1XAHqJ6yaLIaiHMJ
         faFg==
X-Gm-Message-State: AOAM533+QO/HPOW+0AMuMQujL2jjCdhI9/rRpmwwQ61TZLCXcI4MlJsw
        aLFNPPdp7UqZu5LywOQEofh/9Cnhmwz6Ak+VpIkBFA==
X-Google-Smtp-Source: ABdhPJx9zpu9jF8CnSyo6G801+5B1HD3eq8nP3UGL8LEyz4STIsURtt7Sc3jnaVGYGfUwSGbK0Mk3RN9e1GusuYSmII=
X-Received: by 2002:a17:90a:b702:: with SMTP id l2mr17651515pjr.13.1612798843383;
 Mon, 08 Feb 2021 07:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20210206054124.6743-1-songmuchun@bytedance.com>
 <YCDcAy39BbPItdGY@jagdpanzerIV.localdomain> <CAMZfGtVBVSuH=HGNs7KFOtixSviy_stoZsiG4au0RUkUnH-0rQ@mail.gmail.com>
 <YCE4tIrz/u/RkDc/@jagdpanzerIV.localdomain>
In-Reply-To: <YCE4tIrz/u/RkDc/@jagdpanzerIV.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 8 Feb 2021 23:40:07 +0800
Message-ID: <CAMZfGtX-bHXoF_4rU+WzDNp+LmZj3CHWmurEvjCZBCyM2uiDMw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] printk: fix deadlock when kernel panic
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        john.ogness@linutronix.de,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 9:12 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (21/02/08 16:49), Muchun Song wrote:
> > On Mon, Feb 8, 2021 at 2:38 PM Sergey Senozhatsky
> > <sergey.senozhatsky@gmail.com> wrote:
> > >
> > > On (21/02/06 13:41), Muchun Song wrote:
> > > > We found a deadlock bug on our server when the kernel panic. It can be
> > > > described in the following diagram.
> > > >
> > > > CPU0:                                         CPU1:
> > > > panic                                         rcu_dump_cpu_stacks
> > > >   kdump_nmi_shootdown_cpus                      nmi_trigger_cpumask_backtrace
> > > >     register_nmi_handler(crash_nmi_callback)      printk_safe_flush
> > > >                                                     __printk_safe_flush
> > > >                                                       raw_spin_lock_irqsave(&read_lock)
> > > >     // send NMI to other processors
> > > >     apic_send_IPI_allbutself(NMI_VECTOR)
> > > >                                                         // NMI interrupt, dead loop
> > > >                                                         crash_nmi_callback
> > >
> > > At what point does this decrement num_online_cpus()? Any chance that
> > > panic CPU can apic_send_IPI_allbutself() and printk_safe_flush_on_panic()
> > > before num_online_cpus() becomes 1?
> >
> > I took a closer look at the code. IIUC, It seems that there is no point
> > which decreases num_online_cpus.
>
> So then this never re-inits the safe_read_lock?

Right. If we encounter this case, we do not flush printk
buffer. So, it seems my previous patch is the right fix.
Right?

https://lore.kernel.org/patchwork/patch/1373563/

>
>                if (num_online_cpus() > 1)
>                        return;
>
>                debug_locks_off();
>                raw_spin_lock_init(&safe_read_lock);
>
>         -ss
