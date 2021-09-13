Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F47409DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242237AbhIMUKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbhIMUKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:10:41 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9167C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:09:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s3so19408803ljp.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMsg97l00l07oCtcmcZSQu1PJBjVeWs3GkR0hZw6dIQ=;
        b=OEVqTP7bLY9vgVkI9Xz/mX9hc+2K43vUH/Ddy/z8+OQ8i3LKL8oMHKJNOMMEmT2FQA
         or6Ea/NN1JVc3aMwVFI57e3Y0X8YxzIE5TDaL6K3xoKXE2zuVKT71IF8nKc1zU0vjRgm
         uLu4v+NJ8b33vdbdCxLMVLh+H13FybIBCjiAfhFwt8+dB2mmH95uS2LKiGvqFN8yuBW5
         R13Q4LkNAbWaXt1f7pKtAh6FRgKmfXRmg5f1uk9E5yOh/AhZkoabYxEDivGEOLF0nRyL
         DK7t6zyXUnjL2hxWx3+H8C0JWzWY10SaCafKxpTyhJ4woN/Cqi/DRWBoL5q4TWQmh8cE
         EMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMsg97l00l07oCtcmcZSQu1PJBjVeWs3GkR0hZw6dIQ=;
        b=i51iwPsXwj57EuSOkvDC2PxvEvzJa+fD2hGkXxmVAyb/l0ppmGz2aL5gV3MJJrKnLK
         8f8+o1FD86W3PoXdOBDxcMK5b4/FlHHVqAOAD49kWe4FN1ZqAKj3Xjqniq+u76OqSNq9
         ZQXgJpDV2m4SSfrWnlSBv+tQC520mZxPzg5HqQgr11vVxjoSikp1gdUNm0HqM8+DAbX9
         fod7DBBFv4zPitLZWh/96heIU9vpW/938lkwK1GqbLENFP9sXC3xv5XTiAmYEq/0jfED
         EpK1pbBzi7nhI4BZg8T4lJT2vYjSTYIiXl12mbo/GLs/CqribTlAnvR4BMsUqvBjRh3w
         ojlA==
X-Gm-Message-State: AOAM531Hf+BfGKojIWz9aLOHFc70Zjg+N4SepuTI4HL1OIqk/QnQ6HDJ
        vBI3g0CBAgZlSoobTurjDlRsS8DpJveVoTIhAqOqvA==
X-Google-Smtp-Source: ABdhPJyLyyBzBDlii/148UlbF+rM9IFcc8sAvJXelm26Rs/xwETntp1x/YIRfVq/35b9la5OaaKJh8KhhZJCRM0qVPc=
X-Received: by 2002:a2e:9ed9:: with SMTP id h25mr11740309ljk.40.1631563762705;
 Mon, 13 Sep 2021 13:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210902215504.dSSfDKJZu%akpm@linux-foundation.org>
 <20210905124439.GA15026@xsang-OptiPlex-9020> <CALvZod77aP7qdwc5FkaZJf4FikeD0NwSuoJB4N94Uf0yqZFQpQ@mail.gmail.com>
 <20210907033000.GA88160@shbuild999.sh.intel.com> <CALvZod6M_sySPM1KaWzb=tkLxXJksVDrSheckXaiBpMC3cNeqw@mail.gmail.com>
 <20210912111756.4158-1-hdanton@sina.com> <20210912132914.GA56674@shbuild999.sh.intel.com>
 <CALvZod4VbdSux5RaQuhqbC7ENm39UbdkJF8LhYedbFwHKyJgfw@mail.gmail.com>
 <CALvZod7Oa7q=P0gzfA3F26bHPrNz+F-d6G9qKpSiHy9g=msM_w@mail.gmail.com> <YT+ptg1Lf1kGLyUX@slm.duckdns.org>
In-Reply-To: <YT+ptg1Lf1kGLyUX@slm.duckdns.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 13 Sep 2021 13:09:11 -0700
Message-ID: <CALvZod7mBLbkqZJzZz=XNGTDB4mxCd6dwM40aCv6t8fWbdUJdw@mail.gmail.com>
Subject: Re: [memcg] 45208c9105: aim7.jobs-per-min -14.0% regression
To:     Tejun Heo <tj@kernel.org>
Cc:     Feng Tang <feng.tang@intel.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 12:42 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Sep 13, 2021 at 12:40:06PM -0700, Shakeel Butt wrote:
> > I did one more experiment with same workload but with system_wq
> > instead system_unbound_wq and there is clear difference in profile:
> >
> > With system_unbound_wq:
> > -    4.63%     0.33%  mmap  [kernel.kallsyms]  [k] queue_work_on
> >      4.29% queue_work_on
> >       - __queue_work
> >          - 3.45% wake_up_process
> >             - try_to_wake_up
> >                - 2.46% ttwu_queue
> >                   - 1.66% ttwu_do_activate
> >                      - 1.14% activate_task
> >                         - 0.97% enqueue_task_fair
> >                              enqueue_entity
> >
> > With system_wq:
> > -    1.36%     0.06%  mmap  [kernel.kallsyms]  [k] queue_work_on
> >      1.30% queue_work_on
> >       - __queue_work
> >          - 1.03% wake_up_process
> >             - try_to_wake_up
> >                - 0.97% ttwu_queue
> >                     0.66% ttwu_do_activate
> >
> > Tejun, is this expected? i.e. queuing work on system_wq has a
> > different performance impact than on system_unbound_wq?
>
> Yes, system_unbound_wq is putting the work item on the global shared
> workqueue while the system_wq is per-cpu, so on a loaded system, overhead
> difference showing up isn't too surprising.
>

Thanks a lot for the explanation. Are there any concerns to call
cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup) in system_wq?
This will be called every 2 seconds, so, we can assume the updated
tree would be small most of the time.

Thanks,
Shakeel
