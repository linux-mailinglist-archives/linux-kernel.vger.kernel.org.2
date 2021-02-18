Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C879131EFEA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhBRTdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbhBRSxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:53:18 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22002C061788
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:52:38 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t2so2084980pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 10:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7G3JVW2KBRmJBfDlGzhqslH0TpNnVSsRPoclsWcVzgU=;
        b=nH4c5dgFbUZmDtgfk+VV1PCxveHS/Cq4rmiOFy2ks+yFW3f773CI/SqukOQzVv2U68
         kLPB2WFYxM4HtXwie9S8onJLm1N6gmKbodxFDR6n02UzYHl6nKq+zBIXan1D1UhbuDyn
         Y0h3ZcN56AyPZT1Vy6FWaHdkL3MrTtrypHIgsBBWXbvjjbndDfhD9vNSfR5DuxVmEzI9
         PnhKm7nVnV7obC1McKnlkablLJV5EKcMWY1/aD/zbo4xhPClgqZLsqTWRttPQdIj4qwy
         Mz2NTPdV9m6V/6NjyIzKT1vpfFC1Yc0WO0QRlf/z46LAO1Yv0k8JRvdZTZ9Gtd/9+F6a
         eupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7G3JVW2KBRmJBfDlGzhqslH0TpNnVSsRPoclsWcVzgU=;
        b=NmNg5LJm+y6O9DQYLFcDmf6coavUXWhENJXe3WydQtjveyY7cnjoAY0utrFfskvKBE
         Z5wVJ37kXFMwftDD/gMNji/i16eukb1InZ2Am7oYyEPEBRgCZanWBLt7Ih6PiCMFb7GB
         jL+i4P2aquI5A4M4qzumtdJRS22bEqgvbHb8CgY+MKbQHzDvq3YiOE3XZkq7zuagMBNj
         T1v5Cg7oj3CP1pMt30eFu7GgCsfp7w9D4jQ/eoefHDQLC+qUMdXPn/us0DBv1dxNuOYK
         xN11FldzU0V88TtuHGYSkwQuABnJx3u64AqKHOSbuqKfAZl/uXr39MbahHUZgMxX9Ks2
         ubCA==
X-Gm-Message-State: AOAM532e/ZUlNRYyerJImUs5mLBTzpY7LLdNjXXiiLt/c4rJC+AfLiPc
        Mj8iQdMpL5pvSqd93dEG+/nST47/ben1FCwg8dOoXA==
X-Google-Smtp-Source: ABdhPJxTDNxytDrytdjt6u1XDnbyZYaZwSlN2Ui/3fTuueZZtGN8U2CcGMml9XPuFoL6bJSJVu3mogdNrWT9Af5+fxs=
X-Received: by 2002:a17:90b:3756:: with SMTP id ne22mr5109449pjb.41.1613674357497;
 Thu, 18 Feb 2021 10:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20210218173124.iy5iyqv3a4oia4vv@linutronix.de>
In-Reply-To: <20210218173124.iy5iyqv3a4oia4vv@linutronix.de>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 18 Feb 2021 19:52:26 +0100
Message-ID: <CAAeHK+x92X_NZt7MXw1a_=23tLqKyiuOesGHo_Y=aqdZZqdzEQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: Remove kcov include from sched.h and move it to its users.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 6:31 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The recent addition of in_serving_softirq() to kconv.h results in
> compile failure on PREEMPT_RT because it requires
> task_struct::softirq_disable_cnt. This is not available if kconv.h is
> included from sched.h.
>
> It is not needed to include kconv.h from sched.h. All but the net/ user
> already include the kconv header file.
>
> Move the include of the kconv.h header from sched.h it its users.
> Additionally include sched.h from kconv.h to ensure that everything
> task_struct related is available.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/kcov.h  | 1 +
>  include/linux/sched.h | 1 -
>  net/core/skbuff.c     | 1 +
>  net/mac80211/iface.c  | 1 +
>  net/mac80211/rx.c     | 1 +
>  5 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index 4e3037dc12048..55dc338f6bcdd 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_KCOV_H
>  #define _LINUX_KCOV_H
>
> +#include <linux/sched.h>
>  #include <uapi/linux/kcov.h>
>
>  struct task_struct;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 7337630326751..183e9d90841cb 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -14,7 +14,6 @@
>  #include <linux/pid.h>
>  #include <linux/sem.h>
>  #include <linux/shm.h>
> -#include <linux/kcov.h>
>  #include <linux/mutex.h>
>  #include <linux/plist.h>
>  #include <linux/hrtimer.h>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 785daff48030d..e64d0a2e21c31 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -60,6 +60,7 @@
>  #include <linux/prefetch.h>
>  #include <linux/if_vlan.h>
>  #include <linux/mpls.h>
> +#include <linux/kcov.h>
>
>  #include <net/protocol.h>
>  #include <net/dst.h>
> diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
> index b31417f40bd56..39943c33abbfa 100644
> --- a/net/mac80211/iface.c
> +++ b/net/mac80211/iface.c
> @@ -15,6 +15,7 @@
>  #include <linux/if_arp.h>
>  #include <linux/netdevice.h>
>  #include <linux/rtnetlink.h>
> +#include <linux/kcov.h>
>  #include <net/mac80211.h>
>  #include <net/ieee80211_radiotap.h>
>  #include "ieee80211_i.h"
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index 972895e9f22dc..3527b17f235a8 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -17,6 +17,7 @@
>  #include <linux/etherdevice.h>
>  #include <linux/rcupdate.h>
>  #include <linux/export.h>
> +#include <linux/kcov.h>
>  #include <linux/bitops.h>
>  #include <net/mac80211.h>
>  #include <net/ieee80211_radiotap.h>
> --
> 2.30.0

Acked-by: Andrey Konovalov <andreyknvl@google.com>
