Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED04064EA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240615AbhIJBHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhIJAzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 20:55:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C2EC06114C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 17:43:55 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w4so385953ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 17:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7uuVd30s2WHbNN7lmdDhnwmn6gKKOjm5ZXOnnVPJOAc=;
        b=gHtlqt+DwPRv1ejJ4sOoZNXBRm7rh4PT1EOgN6JuPS+IpgiuiwPgrOsidYVLyj3dLp
         PMG/QeOd1hk+EwhqyFBdc6dT7F/fLM0/2aYgcriLKtO7Mj9jft8z8qN1+rbjMq++qbLp
         CDaqK3Va1LGh9NGm0a7cgsmKOkz/hd/8/r0RXmYCDbP2/dcQ9uRwdbnk//d8ta8fCxqM
         +A/PWqa8+YYIpm8uSrdpE4hrzS3pNXXjHK7OknZ8zBNYEWiRpLhho8In6csV3u1++gqU
         Lvc+4pVAbxzSXQRVWDDBobX9oZPxBo4aPEa1dFn+QIjEbQ2b+g5t3Kg+zYr+eta2QMvl
         sVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uuVd30s2WHbNN7lmdDhnwmn6gKKOjm5ZXOnnVPJOAc=;
        b=QbJwMH4VK6p+DtRg+3UMraJzhAQV2WK8QMD0UO6cx+aSBIDg3WqztIDDF/iJwnbUOM
         fcL6h4SOq2biYEmSoVKlVdAt7vG2J9L/WiVeVRCg81LjZA1pMr3e3xJOXTu3lmhSxLUm
         oyDJO7pWC2CA/paMaISQfXhvLakUfYaZXQTn75kJN4r99O8grUhvQAhC5hNzvUCym4dw
         SHL9NjpAMJQkKwF7Vf80JxP+NCWqRYMqIZ1ietsHo8+U/ptfldsugCkHZy3AAN/bDUxA
         hPdKxzcIPEdQ1R8RLBngOBxYFc0s/STqdw3FW9qOnbwYYSyaMjNiv2EoPm3NG5aNqUfE
         LGfg==
X-Gm-Message-State: AOAM533W5bpnbSMnWoRJ3eZ2YGF5wTE3t9M1akHFrpMsOYPS0FgS3Anx
        ZkYTMYglS/Tu7qI6yyj7Qfeu9MrFjkz6+gX9a1nIeg==
X-Google-Smtp-Source: ABdhPJzeCz6w0q2U+ulvoyoJWdHD+nGGyY4JW/MWaqGjcHA3gGLSDaljkucvPJBwYPGeR5s6gbQ6arp4upt1qhQTYN8=
X-Received: by 2002:a2e:a363:: with SMTP id i3mr2168651ljn.86.1631234632179;
 Thu, 09 Sep 2021 17:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210902215504.dSSfDKJZu%akpm@linux-foundation.org>
 <20210905124439.GA15026@xsang-OptiPlex-9020> <CALvZod77aP7qdwc5FkaZJf4FikeD0NwSuoJB4N94Uf0yqZFQpQ@mail.gmail.com>
 <20210907033000.GA88160@shbuild999.sh.intel.com>
In-Reply-To: <20210907033000.GA88160@shbuild999.sh.intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 9 Sep 2021 17:43:40 -0700
Message-ID: <CALvZod6M_sySPM1KaWzb=tkLxXJksVDrSheckXaiBpMC3cNeqw@mail.gmail.com>
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

On Mon, Sep 6, 2021 at 8:30 PM Feng Tang <feng.tang@intel.com> wrote:
>
> Hi Shakeel,
>
> On Sun, Sep 05, 2021 at 03:15:46PM -0700, Shakeel Butt wrote:
> > On Sun, Sep 5, 2021 at 5:27 AM kernel test robot <oliver.sang@intel.com> wrote:
> [...]
> > > =========================================================================================
> > > compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase/ucode:
> > >   gcc-9/performance/1BRD_48G/xfs/x86_64-rhel-8.3/3000/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp2/disk_rr/aim7/0xd000280
> > >
> > > commit:
> > >   3c28c7680e ("memcg: switch lruvec stats to rstat")
> > >   45208c9105 ("memcg: infrastructure to flush memcg stats")
> >
> > I am looking into this. I was hoping we have resolution for [1] as
> > these patches touch similar data structures.
> >
> > [1] https://lore.kernel.org/all/20210811031734.GA5193@xsang-OptiPlex-9020/T/#u
>
> I tried 2 debug methods for that 36.4% vm-scalability regression:
>
> 1. Disable the HW cache prefetcher, no effect on this case
> 2. relayout and add padding to 'struct cgroup_subsys_state', reduce
>    the regression to 3.1%
>

Thanks Feng but it seems like the issue for this commit is different.
Rearranging the layout didn't help. Actually the cause of slowdown is
the call to queue_work() inside __mod_memcg_lruvec_state().

At the moment, queue_work() is called after 32 updates. I changed it
to 128 and the slowdown of will-it-scale:page_fault[1|2|3] halved
(from around 10% to 5%). I am unable to run reaim or
will-it-scale:fallocate2 as I was getting weird errors.

Feng, is it possible for you to run these benchmarks with the change
(basically changing MEMCG_CHARGE_BATCH to 128 in the if condition
before queue_work() inside __mod_memcg_lruvec_state())?

For the formal patch/fix, I will write down a better explanation on
what should be the batch size.

thanks,
Shakeel
