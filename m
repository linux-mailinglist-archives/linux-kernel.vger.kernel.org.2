Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE33E40A52E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhINEVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhINEVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:21:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A19C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:20:26 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f2so21270617ljn.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FFQKtCicsoRb4jBcWE+kkWFD8gMvEX1ULgtaJcmBLyw=;
        b=QD7ueQYq88HtqxaEsTj/L85GKbnbMp0ZWRHoBv0wdr80fYWYMJU+rD90zFAif6gI2/
         SllACLTYWOFZMczxZKPflirR8xl85X4ZsWtURxv18xDT8ztkh2ErclAEQNHH4B6KEz8R
         KHJq/oAXzxUlDoZRMEK1How/97yF6qcjC1MelZhukmgIYElLEQzhSK3Y/6hRtVdaX0EV
         3vBQGk3Xet4ViTmmhTu0CYgpAP5F8wlrW4XI6TCoC/5siWiDG5gC5xzSBGLKsjgswcPZ
         05SF9qPdLL7Qxc7cnOftGeR9zdErdGdAX5wuon+5Fe2beczbuQeOzdc+u1Z4Bmvsr6bO
         8MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FFQKtCicsoRb4jBcWE+kkWFD8gMvEX1ULgtaJcmBLyw=;
        b=NaUcalgZrQMa6T9OGpca7lxi8TtLCvBhfWiKXWe+KVKNXKBiomSRgU6AOEVqeSi714
         goD+Xj3u+ySoGyKi9BUkqNczJZbsQSdk0UqcdeWEJi9OS7DPn0xu85qjeaDAxMe8YswS
         xqwy7R383XRTj8ZaKJAajwQmP2hlLQBDDvBbzKQz5Q/d02sCwMMDqJ4Pbcs7P4i2FrqE
         E8Js76+rAq1ejxk8jDwSzNCSDlVwnSSpXXqMio16fZlBzO3E8sV8UDQtB9w2FLS+bgVv
         hM0F4pT3iL3KMfo6AGydBBOHxxRgB6iJ2F5UxF4Up6pK+sgLRSRNUxqwLjWlwlkIasc6
         cIag==
X-Gm-Message-State: AOAM533SqCV1cExpB01g6e1YslOJtFyphXab8NqTRXRoww97vgNQ79QU
        Xg2Hw3Qf9AbqEscQ+BLEVOJInxgaTUSEjVaH3K1dhQ==
X-Google-Smtp-Source: ABdhPJwEnf76kghB83MZCvOcklnM3QjIzyqjoxjczjR5LrpD/y55RQxaUou/OJNCm19FPqMyQOV+rFJTF7zWeWM7Lig=
X-Received: by 2002:a2e:9ed9:: with SMTP id h25mr13179989ljk.40.1631593224970;
 Mon, 13 Sep 2021 21:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210907033000.GA88160@shbuild999.sh.intel.com>
 <CALvZod6M_sySPM1KaWzb=tkLxXJksVDrSheckXaiBpMC3cNeqw@mail.gmail.com>
 <20210912111756.4158-1-hdanton@sina.com> <20210912132914.GA56674@shbuild999.sh.intel.com>
 <CALvZod4VbdSux5RaQuhqbC7ENm39UbdkJF8LhYedbFwHKyJgfw@mail.gmail.com>
 <CALvZod7Oa7q=P0gzfA3F26bHPrNz+F-d6G9qKpSiHy9g=msM_w@mail.gmail.com>
 <YT+ptg1Lf1kGLyUX@slm.duckdns.org> <CALvZod7mBLbkqZJzZz=XNGTDB4mxCd6dwM40aCv6t8fWbdUJdw@mail.gmail.com>
 <YT+wKFZg0OS0YFrF@slm.duckdns.org> <CALvZod7BFZ1M4KWYWEhRHdZCeLV8Km=NqpkCZ=k67mBNSgX0cQ@mail.gmail.com>
 <20210914021322.GE56674@shbuild999.sh.intel.com>
In-Reply-To: <20210914021322.GE56674@shbuild999.sh.intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 13 Sep 2021 21:20:12 -0700
Message-ID: <CALvZod5hSdJFXa_5KmXg0_rXn+RuqUpX2VOHjgG1vkbsZ+eJ+w@mail.gmail.com>
Subject: Re: [memcg] 45208c9105: aim7.jobs-per-min -14.0% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     Tejun Heo <tj@kernel.org>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 wi

On Mon, Sep 13, 2021 at 7:13 PM Feng Tang <feng.tang@intel.com> wrote:
>
> Hi Shakeel,
>
> On Mon, Sep 13, 2021 at 01:13:57PM -0700, Shakeel Butt wrote:
> > On Mon, Sep 13, 2021 at 1:10 PM Tejun Heo <tj@kernel.org> wrote:
> > >
> > > On Mon, Sep 13, 2021 at 01:09:11PM -0700, Shakeel Butt wrote:
> > > > Thanks a lot for the explanation. Are there any concerns to call
> > > > cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup) in system_w=
q?
> > > > This will be called every 2 seconds, so, we can assume the updated
> > > > tree would be small most of the time.
> > >
> > > I can't think of a reason why this would be problematic.
> > >
> >
> > Thanks again.
> >
> > Feng, is it possible to re-run these benchmarks with
> > queue_work(system_wq) instead of queue_work(system_unbound_wq)?
>
> I just run the patch twice, and there was no obvious change, the
> hotspot is still the spinlock.
>
> Thanks,
> Feng
>
> $git-diff aa48e47e
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4d8c9af..fa9cae9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -683,7 +683,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, =
enum node_stat_item idx,
>         /* Update lruvec */
>         __this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
>         if (!(__this_cpu_inc_return(stats_flush_threshold) % MEMCG_CHARGE=
_BATCH))
> -               queue_work(system_unbound_wq, &stats_flush_work);
> +               queue_work(system_wq, &stats_flush_work);
>  }
>
>
> 7e1c0d6f58207e7e aa48e47e3906c332eaf1e5d7b58 1638eee6432c1a5175685a7945a
> ---------------- --------------------------- ---------------------------
>              \          |                \          |                \
>     648.62          +243.0%       2224 =C2=B1  3%    +246.1%       2244  =
      aim7.cpu
>     588139           -13.4%     509421           -13.5%     508738       =
 aim7.jobs-per-min
>     196.05           -13.4%     169.81           -13.5%     169.58       =
 aim7.jobs-per-min-per-task
>       3.93 =C2=B1  3%     +62.8       66.70           +63.4       67.37  =
      pp.child.native_queued_spin_lock_slowpath
>       3.96 =C2=B1  4%     +62.8       66.76           +63.5       67.46  =
      pp.child._raw_spin_lock_irqsave
>       3.66 =C2=B1  5%     +62.9       66.54           +63.6       67.22  =
      pp.child.lock_page_lruvec_irqsave
>       0.00            +0.1        0.10 =C2=B1  5%      +0.1        0.09  =
      pp.self.queue_work_on
>       0.00            +0.2        0.18 =C2=B1  5%      +0.2        0.22  =
      pp.self.cgroup_rstat_flush_locked
>       0.00            +0.6        0.60 =C2=B1  7%      +0.7        0.72 =
=C2=B1  3%  pp.self.mem_cgroup_css_rstat_flush
>       0.19            +0.7        0.86 =C2=B1  5%      +0.7        0.84 =
=C2=B1  4%  pp.self.cgroup_rstat_updated
>       3.92 =C2=B1  3%     +62.8       66.70           +63.4       67.37  =
      pp.self.native_queued_spin_lock_slowpath
>
>

Thanks Feng, the spinlock in lock_page_lruvec_irqsave() is unrelated
and not taken in __mod_memcg_lruvec_state().

If removing queue_work() from __mod_memcg_lruvec_state() removes the
regression then I was expecting some improvement by replacing
system_unbound_wq with system_wq. Anyways thanks for your help. I will
run some benchmarks as well (the page fault ones from will-it-scale).
