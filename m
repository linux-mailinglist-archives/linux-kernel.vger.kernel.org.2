Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5092406649
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 06:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhIJETV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 00:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhIJETS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 00:19:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA333C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 21:18:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j12so1048915ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 21:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACI+kaI5QB65LpV5tns5Bzp71UPPaBwusSSeY5hjw/M=;
        b=UN22a8qX+iznaU8h3hrhCbhSAThy2z/4cZQRhJa9HP/9GbpEhHGrq+uTnqDDOxToOl
         iPANYQj68YQgj2rIiuGYjsuhvIv/6D7QguvaSUnjb01ysyVuaoIr1sOnstp1f693Pgup
         6VPPEzYfhTLi0OciVmwli19okmRb7mBTn546HKQ/eXlUZybbN0YCzC8nIsqPH0h7FSLI
         Zj3EC+vn16Exl4TI0NupZZxwri8Ejz1eCyAGZWSLBJhcmsmHQ+EgTiJfxRY+ZXRvs9m6
         18R2j4i0rMwrfy6CqWNOUI2vpEQ0wD5TAVYHP10kxW6fQmEM6JKxDynqS1J17HN2A/Fk
         ZNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACI+kaI5QB65LpV5tns5Bzp71UPPaBwusSSeY5hjw/M=;
        b=Fb4j3rs0zyh0HaCJ4sIOx64BP+VIq0x2Y/5VIIXYB1vo23fFNiAfXJG9zaZqd9+ZEX
         6OJ1x0CmKFe7fga7LYtn8fUjWSiEv2Z42LXMwlN0avd9CUL33TZGk2P4QLAARhDpOX3j
         HMWD6uXdM2GzatE7wEyVX1JM7q8NPMJoJmYM2kTPq4IbDYK1PHZBmK06YBJg4GX18CtP
         3aHpcYiokhjIdYcygSHPQ5acdW4GMB84zEc1cv4jX5uNj7lwU/ySsboOEgNwuIAhQKSn
         hS8tMeFOv7n0NY1atGYCBI52JlwAxEn0qzXWiIRIZ6J6p/NmqcmeBK0Gv/4pu91yQg7g
         fxwg==
X-Gm-Message-State: AOAM530LtA022HtDqsGV8xD1J1RnWTWXpIzuYrFenYoGHSl1HIs3Idym
        BEvQEpHLKbZGGcHvh9xKyO1vzjs4NCJLAwOUyCP02w==
X-Google-Smtp-Source: ABdhPJwNTYErfMkcSAQp56nNRqGOIapdEJwjDN8c5Eor19eb/cvIQkSiwbCb3MYkU/9o7GWKPEXEoe4XcyxbDtjvZ7I=
X-Received: by 2002:a2e:964b:: with SMTP id z11mr2542436ljh.91.1631247485805;
 Thu, 09 Sep 2021 21:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210902215504.dSSfDKJZu%akpm@linux-foundation.org>
 <20210905124439.GA15026@xsang-OptiPlex-9020> <CALvZod77aP7qdwc5FkaZJf4FikeD0NwSuoJB4N94Uf0yqZFQpQ@mail.gmail.com>
 <20210907033000.GA88160@shbuild999.sh.intel.com> <CALvZod6M_sySPM1KaWzb=tkLxXJksVDrSheckXaiBpMC3cNeqw@mail.gmail.com>
 <20210910010842.GA94434@shbuild999.sh.intel.com> <CALvZod5_L55RLzwOXh_5C+v9rjVQ4_FEaEB2QYS5+6kuHpHpQg@mail.gmail.com>
 <20210910023415.GB94434@shbuild999.sh.intel.com>
In-Reply-To: <20210910023415.GB94434@shbuild999.sh.intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 9 Sep 2021 21:17:54 -0700
Message-ID: <CALvZod79NnB=CG_sr5ZYLStageb-9W8c5uss22=p2tGJNsFmKQ@mail.gmail.com>
Subject: Re: [memcg] 45208c9105: aim7.jobs-per-min -14.0% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hillf Danton <hdanton@sina.com>,
        Huang Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Michal Koutn??" <mkoutny@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 7:34 PM Feng Tang <feng.tang@intel.com> wrote:
>
> On Thu, Sep 09, 2021 at 06:19:06PM -0700, Shakeel Butt wrote:
> [...]
> > > > > > I am looking into this. I was hoping we have resolution for [1] as
> > > > > > these patches touch similar data structures.
> > > > > >
> > > > > > [1] https://lore.kernel.org/all/20210811031734.GA5193@xsang-OptiPlex-9020/T/#u
> > > > >
> > > > > I tried 2 debug methods for that 36.4% vm-scalability regression:
> > > > >
> > > > > 1. Disable the HW cache prefetcher, no effect on this case
> > > > > 2. relayout and add padding to 'struct cgroup_subsys_state', reduce
> > > > >    the regression to 3.1%
> > > > >
> > > >
> > > > Thanks Feng but it seems like the issue for this commit is different.
> > > > Rearranging the layout didn't help. Actually the cause of slowdown is
> > > > the call to queue_work() inside __mod_memcg_lruvec_state().
> > > >
> > > > At the moment, queue_work() is called after 32 updates. I changed it
> > > > to 128 and the slowdown of will-it-scale:page_fault[1|2|3] halved
> > > > (from around 10% to 5%). I am unable to run reaim or
> > > > will-it-scale:fallocate2 as I was getting weird errors.
> > > >
> > > > Feng, is it possible for you to run these benchmarks with the change
> > > > (basically changing MEMCG_CHARGE_BATCH to 128 in the if condition
> > > > before queue_work() inside __mod_memcg_lruvec_state())?
> > >
> > > When I checked this, I tried different changes, including this batch
> > > number change :), but it didn't recover the regression (the regression
> > > is slightly reduced to about 12%)
> [...]
> >
> > Another change we can try is to remove this specific queue_work()
> > altogether because this is the only significant change for the
> > workload. That will give us the base performance number. If that also
> > has regression then there are more issues to debug. Thanks a lot for
> > your help.
>
> I just tested with patch removing the queue_work() in __mod_memcg_lruvec_state(),
> and the regression is gone.

Thanks again for confirming this. I will follow this lead and see how
to improve this.
