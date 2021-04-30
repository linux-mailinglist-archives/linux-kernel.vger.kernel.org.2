Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD8536F9BA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 14:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhD3ME6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 08:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhD3ME4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:04:56 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9009CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 05:04:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a13so26635845ljp.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 05:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcOJzmy6gAjS3Och51hWtGgtigCtRIoMvFe4KlmC6I0=;
        b=hpsGpSCOe81NOr363oM1c77yVHUGeH+sL66lOefAHBh+8xwARpwG0BvFrmapBq0m5b
         sqMlTQcpvhE88vAhYcwA6Czi78HK9ubTfXmF55tBCmYYvSUIv5fCxLqSFdoNERhjFJHj
         8PZuFg4gJ9I/hqbvZysrkbrIitqEQ6oHUJc4ZHwOuLSdx0qry6b/kHTc6GR1g0Lod+54
         /XYADXxSPBnnMQeDkGzWVRaAxdh6CNOZPmblxGiP2YtBP1wGMXK/274W3C0Ij/e1c7Mx
         qM4wbcPYCXfu+VsJIKxOQcfQyxxUyUNr5L38W83QdTaneAxToovIAHqw90O4IpijlCE6
         MaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcOJzmy6gAjS3Och51hWtGgtigCtRIoMvFe4KlmC6I0=;
        b=NfriHhxcallHcuyXinGHyENlZmfZxbFLVQKsfFaqlKlIwJYiMyiAgBW6xWUmTe1FFn
         f6JbL4FKRgY+exmBC2hGZJ95aZyB2Ku/4xve6ki4P1uNgb6oZiZvHL/4pO5PGXevi2kd
         oG1O8wLZyrYgvLQxRQLS8h+mD6RqxVDJ0WvTds60Qbi87YcsMpzCFYIy9BAlBFUxkbui
         0n5fOizrsY37LeseXRRapQt1eWmlUZ37d0VKnWe/L/6DeRnvFL3Q2mikFy0EPEPogHse
         RWAkbDVMRFz7oKZ7SfUXvKLkyzD4Q0Kr9kc2kWkKbT7HGZsQ1ILEWyGQtMkaHSHJjNAC
         ihlQ==
X-Gm-Message-State: AOAM532QR+KDDlj6ofWPWI44cYfiLYFvp7VaypXGqWcw/fHl9b8eYuvA
        6HlUiik2bVLa4XmWpNb6eXs4RnuS2C1z+q7B/LS38g==
X-Google-Smtp-Source: ABdhPJxbrAg3T+iwzf2sYkZ0R2C8xB0h3DBRbhyqgsgZOXH2tEHrFp+8S5dB/Xa+aYmL+ImAP2Zn3ds+bV6PCNSxeJw=
X-Received: by 2002:a2e:9f47:: with SMTP id v7mr3427568ljk.176.1619784245696;
 Fri, 30 Apr 2021 05:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210429152656.4118460-1-qperret@google.com> <CAKfTPtAfgVnMYkY_M+SDmNQDb_EsxSctQw-fkt2WJhczZakOjQ@mail.gmail.com>
 <YIu/EjZ8QsEl9sum@google.com> <CAKfTPtDOuB0UzZM5OtNzCUABftz_A40Z4W1z9OAORzFitfPDEQ@mail.gmail.com>
 <YIvQoG52Vk96DJQ/@google.com>
In-Reply-To: <YIvQoG52Vk96DJQ/@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 30 Apr 2021 14:03:54 +0200
Message-ID: <CAKfTPtB-0N7ogk0snCgj78zDrXRWgFUL=G7MoRDn+Bg8Hnk-PQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Fix out-of-bound access in uclamp
To:     Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 at 11:40, Quentin Perret <qperret@google.com> wrote:
>
> On Friday 30 Apr 2021 at 10:49:50 (+0200), Vincent Guittot wrote:
> > 20 buckets is probably not the best example because of the rounding of
> > the division. With 16 buckets, each bucket should be exactly 64 steps
> > large except the last one which will have 65 steps because of the
> > value 1024. With your change, buckets will be 65 large and the last
> > one will be only 49 large
>
> OK, so what do you think of this?

Looks good to me


>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c5fb230dc604..dceeb5821797 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -920,14 +920,14 @@ static struct uclamp_se uclamp_default[UCLAMP_CNT];
>   */
>  DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
>
> -#define UCLAMP_BUCKET_DELTA (SCHED_CAPACITY_SCALE / UCLAMP_BUCKETS + 1)
> +#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
>
>  #define for_each_clamp_id(clamp_id) \
>         for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
>
>  static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
>  {
> -       return clamp_value / UCLAMP_BUCKET_DELTA;
> +       return min(clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);
>  }
>
>  static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
