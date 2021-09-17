Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F7D40FE3D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244956AbhIQQ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244837AbhIQQ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:59:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A091DC061764
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:57:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so10509840wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ks7GRXH10LMoWisiAZleE5hGBUIZYE3yfvmoX1sU0ls=;
        b=XBqbtrjt9UiF/is+v8yiaFwaobmMqeGNEUIbLGRqD/cCT3S7wbGUHGPhO22dGAgdSb
         V1r563EI29nyagVm5akiPZPLMKj7rBNVKHxPbZ2RQUiWlyqSh47+MKF0gsJVJbW9AJBi
         W+5kd9fvD+2ckpNexlSsZAv1fHoxMMDHXITgFRtLL+R6QgC9hEvdaS8BG2kuHB07lx3T
         iej+UddW7EPYpbImMFrsdMMCvMC+Ov+G16rzXWXE1h9MJvLo8mzLBUVXMJkFQivOppqU
         vkrMK5kroTg1P0GreOea1cUFNxuP783qGQhen0kBy8BVAaHAWSJPGCdP9tL+Kh6dBHt2
         Zo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ks7GRXH10LMoWisiAZleE5hGBUIZYE3yfvmoX1sU0ls=;
        b=SGpz9dotCryuIPHDdRoifVyoYlMwjctcQyqyTK/7bqhyLOE7l8eTHQ0sv0pTAYrqVx
         iv1GmhTVDjTbqEtObp2IZKXe0xij+tAVJE5A7QR5+4MZ+1K3qtSE8mGw/H0fpuRbYVR/
         pYFFJ60N8djvrXATXOhIFRK8LF4VZPD5iSwIUNXW87oUYpUYrf5g1d0QjgWObVI9m9Pr
         s7cjZE/c0ISoF4OoGxgMuPMVJDxf6IbuZOJeQApW0g2etENXn0Z4UMKU5fsaEgUoavrw
         cHZu+ZB3jC62GcNT00UqkhGuAv0uVU18Vb4lqZj7J46Roog2Ke+7oHTI9IF5bRlvoFPY
         Q9Nw==
X-Gm-Message-State: AOAM532GmYHB7JltVv0BUs54Kt0+6JQ3zjhVHU5H9v+9ib0uQQEn28/g
        uIJC8YOdr7CTZz5Vw8/95rN88dXUL0OdJRm3GfcUplOPnibBAA==
X-Google-Smtp-Source: ABdhPJwjqpx4VqzYgQH8BEM50ODfJdJFLreTScAadEc8/uX1DoPpyNVBz4bHelwLnIFeiAK7imA6fDvyiJa/87TKN4Q=
X-Received: by 2002:a1c:3845:: with SMTP id f66mr11279924wma.63.1631897868994;
 Fri, 17 Sep 2021 09:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <163179356649.25758.16036449513954806322.tip-bot2@tip-bot2>
In-Reply-To: <163179356649.25758.16036449513954806322.tip-bot2@tip-bot2>
From:   Peter Oskolkov <posk@posk.io>
Date:   Fri, 17 Sep 2021 09:57:37 -0700
Message-ID: <CAFTs51Weqaig2tk-vMrSCzaQUch2Zr_Us0SPGutJAjMoYBK94A@mail.gmail.com>
Subject: Re: [tip: sched/core] sched: Fix -Wmissing-prototype
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 4:59 AM tip-bot2 for Peter Zijlstra
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the sched/core branch of tip:
>
> Commit-ID:     98a3270911f7abe2871a60799c20c95c9f991ddb

$ make defconfig
$ make -j16

ld: kernel/sched/core.o: in function `sched_free_group':
core.c:(.text+0x2cfd): undefined reference to `free_rt_sched_group'
ld: kernel/sched/core.o: in function `sched_create_group':
core.c:(.text+0xbdcb): undefined reference to `alloc_rt_sched_group'
ld: kernel/sched/core.o: in function `sched_init':
core.c:(.init.text+0x335): undefined reference to `init_cfs_bandwidth'
ld: kernel/sched/fair.o: in function `alloc_fair_sched_group':
fair.c:(.text+0x8427): undefined reference to `init_cfs_bandwidth'
make: *** [Makefile:1196: vmlinux] Error 1

Reverting this patch fixes the issue.

> Gitweb:        https://git.kernel.org/tip/98a3270911f7abe2871a60799c20c95=
c9f991ddb
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Mon, 13 Sep 2021 15:27:44 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Wed, 15 Sep 2021 17:49:00 +02:00
>
> sched: Fix -Wmissing-prototype
>
>   kernel/sched/fair.c:5403:6: warning: no previous prototype for =E2=80=
=98init_cfs_bandwidth=E2=80=99 [-Wmissing-prototypes]
>   kernel/sched/fair.c:11525:6: warning: no previous prototype for =E2=80=
=98free_fair_sched_group=E2=80=99 [-Wmissing-prototypes]
>   kernel/sched/fair.c:11527:5: warning: no previous prototype for =E2=80=
=98alloc_fair_sched_group=E2=80=99 [-Wmissing-prototypes]
>   kernel/sched/fair.c:11532:6: warning: no previous prototype for =E2=80=
=98online_fair_sched_group=E2=80=99 [-Wmissing-prototypes]
>   kernel/sched/fair.c:11534:6: warning: no previous prototype for =E2=80=
=98unregister_fair_sched_group=E2=80=99 [-Wmissing-prototypes]
>
>   kernel/sched/rt.c:253:6: warning: no previous prototype for =E2=80=98fr=
ee_rt_sched_group=E2=80=99 [-Wmissing-prototypes]
>   kernel/sched/rt.c:255:5: warning: no previous prototype for =E2=80=98al=
loc_rt_sched_group=E2=80=99 [-Wmissing-prototypes]
>   kernel/sched/rt.c:669:6: warning: no previous prototype for =E2=80=98sc=
hed_rt_bandwidth_account=E2=80=99 [-Wmissing-prototypes]
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/deadline.c |  2 --
>  kernel/sched/fair.c     | 15 ---------------
>  kernel/sched/rt.c       |  6 ------
>  kernel/sched/sched.h    |  2 ++
>  4 files changed, 2 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d2c072b..29dd188 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1191,8 +1191,6 @@ int dl_runtime_exceeded(struct sched_dl_entity *dl_=
se)
>         return (dl_se->runtime <=3D 0);
>  }
>
> -extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
> -
>  /*
>   * This function implements the GRUB accounting rule:
>   * according to the GRUB reclaiming algorithm, the runtime is
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e26d622..9571254 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5408,8 +5408,6 @@ static inline int throttled_lb_pair(struct task_gro=
up *tg,
>         return 0;
>  }
>
> -void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
> -
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
>  #endif
> @@ -11562,19 +11560,6 @@ next_cpu:
>         return 0;
>  }
>
> -#else /* CONFIG_FAIR_GROUP_SCHED */
> -
> -void free_fair_sched_group(struct task_group *tg) { }
> -
> -int alloc_fair_sched_group(struct task_group *tg, struct task_group *par=
ent)
> -{
> -       return 1;
> -}
> -
> -void online_fair_sched_group(struct task_group *tg) { }
> -
> -void unregister_fair_sched_group(struct task_group *tg) { }
> -
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index bb945f8..929fb37 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -250,12 +250,6 @@ static inline struct rt_rq *rt_rq_of_se(struct sched=
_rt_entity *rt_se)
>         return &rq->rt;
>  }
>
> -void free_rt_sched_group(struct task_group *tg) { }
> -
> -int alloc_rt_sched_group(struct task_group *tg, struct task_group *paren=
t)
> -{
> -       return 1;
> -}
>  #endif /* CONFIG_RT_GROUP_SCHED */
>
>  #ifdef CONFIG_SMP
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 094ea86..1d8bc76 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3065,3 +3065,5 @@ extern int sched_dynamic_mode(const char *str);
>  extern void sched_dynamic_update(int mode);
>  #endif
>
> +extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
> +
