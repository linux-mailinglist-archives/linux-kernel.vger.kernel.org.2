Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3B139F9D9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhFHPFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:05:18 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:40863 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbhFHPFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:05:15 -0400
Received: by mail-lj1-f176.google.com with SMTP id x14so13086057ljp.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p2VVI+QZ/E3Qyy8TJRSVbuUnoyJN14Hx4Ij/Bt7TFZ0=;
        b=NtPeiiCFzMemTwNzl2g3QiStSH+uSTKt6LlgtxDcMJpyWXIY0iTJDln/ehfFnKJzLH
         5Vhqrtw84xLPbaTAQRPVjDJ7zJHlWwZx5+8aA22O3Ivv5WmtQLEaMMtUp/oHXsI7F/TT
         kanMvxKisPu25mRhwoMs/aAFA2WRWlD9NnhGCMKXkmuA3ply/eW8E8Qlc01ELP1cx8aC
         irf9TW4zAXD359SBe77Czf6fqBV8b3FgodL8bZ4vLuwKzNz7WeUEg0zW5nchATEwQ5su
         /5HXnx9JgkhjykuUOfEgRtCABcIe5w9FSM9a4s8WIyC8zMt8H7MslnebalNHnvnWuNOm
         yPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p2VVI+QZ/E3Qyy8TJRSVbuUnoyJN14Hx4Ij/Bt7TFZ0=;
        b=lqPzQXE5nMfCGGwMYGxbG/9bDptmDJjzfJ3iiF5V6zb0r+P/LDOdcYU9QK7yOHjDqk
         RgNUV17Ces7CusGzkXlYK2eoK3eadOD1gNOeDhd2guVI/SedMfcxg6mDR1fYNTkhdfGj
         iA0hDihUJ0IpDdgKNfVC7pZaM9lhUugkKo5uU+LoXA50txjDGce6GW7vvvtUzD/6lhOG
         IRIR4a+7c7FEY0CDbzE6JeQ/R3KrD7Um/SvWkWxIZI3bN+UYD6XmqPHot1DeP30CyIvz
         uCvkxF59+qtQI9iFAJ4YLPggMaV5/A5HTunUPilelgrVoIFoXUDqd0htAJd86Mew/333
         zbiQ==
X-Gm-Message-State: AOAM5318x0MMIOnryj8/QEzpp2a1R7OnIJr/I/Q/xdhoScGrADY1Un7r
        AQJNkEPYRgWvJkFnqUkfsZW8CFEu+Ncp6VYz3Bo=
X-Google-Smtp-Source: ABdhPJy35WHAiJzDf91C1oxLdBLhQpvSYIG4iMISE1vBzXbe5Bq1RGkkS3zdeLpP9iPWJPo2O8sBTAsDG7APVEpy+U0=
X-Received: by 2002:a2e:a717:: with SMTP id s23mr18625093lje.282.1623164530255;
 Tue, 08 Jun 2021 08:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210602123803.15738-1-xuewen.yan94@gmail.com>
 <YLeF/556Wbvx1Ssc@google.com> <CAB8ipk9BqzEQ4Ta5s+vJeep=v1pmaXS-WsF2tq0u9G8Q2PGmsA@mail.gmail.com>
 <20210604160839.2op4ak75vle3gmt3@e107158-lin.cambridge.arm.com>
 <CAB8ipk9CgWvbGnJcvEtLcG=7v-pPmGJd25-R9jb2Am5zKngK3g@mail.gmail.com>
 <20210605114908.mqfsip5pskamls6k@e107158-lin.cambridge.arm.com>
 <CAB8ipk_a6VFNjiEnHRHkUMBKbA+qzPQvhtNjJ_YNzQhqV_o8Zw@mail.gmail.com>
 <20210607134902.nlgvqtzj35rhjg7x@e107158-lin.cambridge.arm.com>
 <CAB8ipk8FaovUYY8ncDgLHO7k_EoEHtsfm+1QYsFTMf4fb7ix_A@mail.gmail.com> <20210608142554.tbiu2s5qnwflmk27@e107158-lin.cambridge.arm.com>
In-Reply-To: <20210608142554.tbiu2s5qnwflmk27@e107158-lin.cambridge.arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 8 Jun 2021 23:01:59 +0800
Message-ID: <CAB8ipk_w9JeFmbjSOFR-GnaPNiAoFt8f30Oxh3fZRw58wDXo4w@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Avoid setting cpu.uclamp.min bigger than cpu.uclamp.max
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Jun 8, 2021 at 10:25 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> --->8---
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9e9a5be35cde..1d2d3e6648a6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1403,38 +1403,28 @@ static void uclamp_sync_util_min_rt_default(void)
>  static inline struct uclamp_se
>  uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
>  {
> -       struct uclamp_se uc_req = p->uclamp_req[clamp_id];
> +       /* Copy by value as we could modify it */
> +       struct uclamp_se uc_eff = p->uclamp_req[clamp_id];
>  #ifdef CONFIG_UCLAMP_TASK_GROUP
> +       unsigned long tg_min, tg_max, value;
>
>         /*
>          * Tasks in autogroups or root task group will be
>          * restricted by system defaults.
>          */
>         if (task_group_is_autogroup(task_group(p)))
> -               return uc_req;
> +               return uc_eff;
>         if (task_group(p) == &root_task_group)
> -               return uc_req;
> +               return uc_eff;
>
> -       switch (clamp_id) {
> -       case UCLAMP_MIN: {
> -               struct uclamp_se uc_min = task_group(p)->uclamp[clamp_id];
> -               if (uc_req.value < uc_min.value)
> -                       return uc_min;
> -               break;
> -       }
> -       case UCLAMP_MAX: {
> -               struct uclamp_se uc_max = task_group(p)->uclamp[clamp_id];
> -               if (uc_req.value > uc_max.value)
> -                       return uc_max;
> -               break;
> -       }
> -       default:
> -               WARN_ON_ONCE(1);
> -               break;
> -       }
> +       tg_min = task_group(p)->uclamp[UCLAMP_MIN].value;
> +       tg_max = task_group(p)->uclamp[UCLAMP_MAX].value;
> +       value = uc_eff.value;
> +       value = clamp(value, tg_min, tg_max);
> +       uclamp_se_set(&uc_eff, value, false);

Is it reasonable to set user_defined to be false here?

>  #endif
>
> -       return uc_req;
> +       return uc_eff;
>  }
>
>  /*
> @@ -1661,8 +1651,7 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
>
>  #ifdef CONFIG_UCLAMP_TASK_GROUP
>  static inline void
> -uclamp_update_active_tasks(struct cgroup_subsys_state *css,
> -                          unsigned int clamps)
> +uclamp_update_active_tasks(struct cgroup_subsys_state *css)
>  {
>         enum uclamp_id clamp_id;
>         struct css_task_iter it;
> @@ -1670,10 +1659,8 @@ uclamp_update_active_tasks(struct cgroup_subsys_state *css,
>
>         css_task_iter_start(css, 0, &it);
>         while ((p = css_task_iter_next(&it))) {
> -               for_each_clamp_id(clamp_id) {
> -                       if ((0x1 << clamp_id) & clamps)
> -                               uclamp_update_active(p, clamp_id);
> -               }
> +               for_each_clamp_id(clamp_id)
> +                       uclamp_update_active(p, clamp_id);
>         }
>         css_task_iter_end(&it);
>  }
> @@ -9626,7 +9613,7 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
>                 }
>
>                 /* Immediately update descendants RUNNABLE tasks */
> -               uclamp_update_active_tasks(css, clamps);
> +               uclamp_update_active_tasks(css);
>         }
>  }

Would you resend another email? maybe it would be better to resend an
email with a new subject?

BR
xuewen
