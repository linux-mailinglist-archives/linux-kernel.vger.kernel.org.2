Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346384464E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 15:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhKEO2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 10:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhKEO2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 10:28:40 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C6C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 07:26:00 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y3so23249199ybf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/iZosAqOCPRrV2DIseKYh152abP8wsS0XjzUed2AtU=;
        b=hRG00Os+0h8SA08WLYoUXrgjEiZsH0Qlmhw7AWdASKh4J7CPOUOKhUiKRC3G+wjlh0
         s7xdn8oOuj+AQ66Rg293BmjBFBcwIk56iScsYKogk/UuLyhLhrZaRsesXmo6kXewxcFx
         Vfj4Zzlif9Co4wnrobrHGUQFO2XfPtltEpJgpJ4EZU5cqOFy0/fPv+I3LNRXwKYjLtIt
         dYqaJ/B/89m0+dLopuM4Rz1Nuq3LZSE6ZDuK3aUQF4a7Gx+kuNVDdY9v1dGSPOd/Ykmy
         wnX3B9V1zzrZvRPXzqhb1IqXBjfzx7bt+5beuWO/qXzAcyYIJ6Pjd4imgL3mjctvOx0d
         Phcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/iZosAqOCPRrV2DIseKYh152abP8wsS0XjzUed2AtU=;
        b=6Eeybcvwotzu7j4eEHIEMd+/G0tGU7Sr2ojOB2L/UQ5rteliqRH78ruxR10b4Lg6dS
         DgT+No5GapgaSJVBdQmC6Dq94ZRtX1jEjs3aiYLXXIXlf38ixKuOmJ/PJe3MI3v04GjC
         L12I0gDzFNyZQCog7JHUTjR76tBELnOH6R7lf/XqoIJY83KiJZo4AYcuiy7TbA1vzdk9
         aWAP+05bFJ4MqFDL0r+pN0tKo0Xigv7nRcT5F57V4fJb00clSsrOmxjE0fZEkPWXCdK9
         55DCvi0OYTHge0eDtfcw7bGx1N0l3/YWSuNna0V0ZuOJA+vomygXdi84Go3pOoRsXDmy
         zECA==
X-Gm-Message-State: AOAM533myxytEzk5T2lbN0EQNMR83gB266M4+vROJHki2uocODMjfR4z
        Da70FTI1/1WpZGLP/2ckThzLrEbKVbDjbrkphugN9A==
X-Google-Smtp-Source: ABdhPJyegx6Xxks3GI/f1GGRLaRJuxhnxQ2/hMIAPEFeIlpX2QoFInIMp2i8SL3chBBSF4sIx29soh76mP8f/nc4GCQ=
X-Received: by 2002:a25:d707:: with SMTP id o7mr29474179ybg.546.1636122359835;
 Fri, 05 Nov 2021 07:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <b98e3434-67cd-34b7-9e81-148ea31a851c@grsecurity.net>
 <20211103190613.3595047-1-minipli@grsecurity.net> <xm26ilx86gmp.fsf@google.com>
 <CAKfTPtBm4vHr=svju=Qg6eZmcv8YDghtM2r_pOahZ2gC3tzTxg@mail.gmail.com>
 <a6a3c6c9-d5ea-59b6-8871-0f72bff38833@grsecurity.net> <CAKfTPtBxoKBRWs4Z3Pxsk8==Ka9SG7NS3LzfOV33-2UXfhSM=g@mail.gmail.com>
 <cd3778d3-6980-a804-47e3-82b09dc960a4@grsecurity.net>
In-Reply-To: <cd3778d3-6980-a804-47e3-82b09dc960a4@grsecurity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 5 Nov 2021 15:25:46 +0100
Message-ID: <CAKfTPtDthksitm02sLowDMKbWZ29efth-YcPi0zVSFqbaZfiMA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prevent dead task groups from regaining cfs_rq's
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Benjamin Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org, Odin Ugedal <odin@uged.al>,
        Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Brad Spengler <spender@grsecurity.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2021 at 18:37, Mathias Krause <minipli@grsecurity.net> wrote:
>
> Am 04.11.21 um 17:49 schrieb Vincent Guittot:
> > [snip]
> >
> > Ok so we must have 2 GPs:
> >
> > list_del_rcu(&tg->siblings);
> > GP to wait for the end of ongoing walk_tg_tree_from : synchronize_rcu
> > in your patch
> > list_del_leaf_cfs_rq(tg->cfs_rq[cpu]); if on_list
> > remove_entity_load_avg(tg->se[cpu]);
> > GP to wait for the end of ongoing for_each_leaf_cfs_rq_safe (print_cfs_stats)
> > kfree everything
>
> Basically yes, but with my patch we already have these two, as there's
> at least one RCU GP between after sched_offline_group() finishes and
> sched_free_group() / cpu_cgroup_css_free() starts.
>
> So we either use my patch as-is or move unregister_fair_sched_group() to
> free_fair_sched_group() and use kfree_rcu() instead of kfree(). Both
> approaches have pros and cons.
>
> Pro for my version is the early unlinking of cfs_rq's for dead task
> groups, so no surprises later on. Con is the explicit synchronize_rcu().

which blocks the caller and could be problematic

It seems that LKP has reported such issue:
20211104145128.GC6499@xsang-OptiPlex-9020

>
> Pro for the kfree_rcu() approach is the lack of the explicit
> synchronize_rcu() call, so no explicit blocking operation. Con is that
> we have cfs_rq's re-added to dead task groups which feels wrong and need
> to find a suitable member to overlap with the rcu_head in each involved
> data type.
>
> Which one do you prefer?
>
> Thanks,
> Mathias
