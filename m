Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2130E390500
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhEYPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhEYPRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:17:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D7AC06138A
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:16:09 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q15so22980094pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GlZpEK9HpCLX1XVPm0LSC4rLTUHCcfxj2n178z32Y0M=;
        b=mxAE3NfwZ9iFCmSb9LqnY+Hg5FJVex131Y+wRoKqcZ124YRsHEGuBnE8sdHNiyy7WV
         RCukxHD8R0fk6D7vDs2qzGyaMIZFu/trrMVFay62WXEQVmGfRxqOXj1DkxdLfHMRlWk2
         K0CtqExsQoXwFGn4yjtDPrT1LV9xrQnKlwtY6qpwW4eG3uv9gKKB8T5HMEwdkPl6CPsc
         mHPFvlpbM/ZQQdMkiyCUGasOa3+xLJfY8cMugA3TsoYP3NcuvtYhDW0SJ2+dH8vz0AW5
         8NK9w16HQYOxwV6POF8rOGgWbWRoeeTYAWG01UiKPZI6rADtMrh4g565+oVNWGVtZmXg
         y10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GlZpEK9HpCLX1XVPm0LSC4rLTUHCcfxj2n178z32Y0M=;
        b=ud78lm3YxLYRB+jM+WLIzAE3U7dw51LtL2a+XxNJp2LNXC+5bMNcgd8cr5uFU7Z5hi
         FHSqSItenhaQWxTOqJL6A+Uibyt91GNKimujq80xc0gjjZ8s9Fdq+GC4cTsI0lY23bMt
         XBvGMqDq19QWIRHTGD+zN1/XYDo4tognqUhqxdYHkTUxNIDhztKNUCooxT4+3w6gnO2q
         lExmHHdMEL5mFaRxZBuPiqAjsM8rOCaspP729QkKor1b+c4sNLJiBQs+Me4RPtsiCICW
         58Mnkn+/ZeGPc2qM50aA1UU1XAfs9JCY1u7Qh/J8ztgrduIu+q5lXnA1I8Wwq9M8k5B8
         GKvg==
X-Gm-Message-State: AOAM533DP5yxZfAppN5fvqj28LiklOztouB8Fns7TCnCSpKi5JnUeaPd
        Rcz3J+sZJ6zDXOkgqHIBGgyBrexUF2I=
X-Google-Smtp-Source: ABdhPJz6slXGUUqNbPIe/QZEs+FilVAqqJJX0wFIgd8URduuQQBJKbAB2wMgf+BOJLU40MDsVaNPbw==
X-Received: by 2002:a05:6a00:134b:b029:2bf:2c30:ebbd with SMTP id k11-20020a056a00134bb02902bf2c30ebbdmr30723883pfu.74.1621955768488;
        Tue, 25 May 2021 08:16:08 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:37cd:d6b4:7992:c290])
        by smtp.gmail.com with ESMTPSA id s6sm2286711pjr.29.2021.05.25.08.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 08:16:06 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 25 May 2021 08:16:03 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Laura Abbott <labbott@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [mm]  8cc621d2f4:  fio.write_iops -21.8% regression
Message-ID: <YK0Us01mBTRWOQIw@google.com>
References: <20210520083144.GD14190@xsang-OptiPlex-9020>
 <YKasEeXCr9R5yzCr@google.com>
 <45f761de51d514f77cc48214846c5f8f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45f761de51d514f77cc48214846c5f8f@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 10:37:49AM -0700, Chris Goldsworthy wrote:
> Hi Minchan,
> 
> This looks good to me, I just have some minor feedback.
> 
> Thanks,

Hi Chris,

Thanks for the review. Please see below.

> 
> Chris.
> 
> On 2021-05-20 11:36, Minchan Kim wrote:
> > On Thu, May 20, 2021 at 04:31:44PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed a -21.8% regression of fio.write_iops due to commit:
> > > 
> > > 
> > > commit: 8cc621d2f45ddd3dc664024a647ee7adf48d79a5 ("mm: fs:
> > > invalidate BH LRU during page migration")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > 
> > > in testcase: fio-basic
> > > on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU
> > > @ 2.10GHz with 256G memory
> > > with following parameters:
> > > 
> > > 	disk: 2pmem
> > > 	fs: ext4
> > > 	runtime: 200s
> > > 	nr_task: 50%
> > > 	time_based: tb
> > > 	rw: randwrite
> > > 	bs: 4k
> > > 	ioengine: libaio
> > > 	test_size: 200G
> > > 	cpufreq_governor: performance
> > > 	ucode: 0x5003006
> > > 
> > > test-description: Fio is a tool that will spawn a number of threads
> > > or processes doing a particular type of I/O action as specified by
> > > the user.
> > > test-url: https://github.com/axboe/fio
> > > 
> > > 
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > 
> > > 
> > > Details are as below:
> > > -------------------------------------------------------------------------------------------------->
> > > 
> > > 
> > > To reproduce:
> > > 
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         bin/lkp install                job.yaml  # job file is
> > > attached in this email
> > >         bin/lkp split-job --compatible job.yaml  # generate the yaml
> > > file for lkp run
> > >         bin/lkp run                    generated-yaml-file
> > 
> > Hi,
> > 
> > I tried to insall the lkp-test in my machine by following above guide
> > but failed
> > due to package problems(I guess it's my problem since I use something
> > particular
> > environement). However, I guess it comes from increased miss ratio of
> > bh_lrus
> > since the patch caused more frequent invalidation of the bh_lrus calls
> > compared
> > to old. For example, lru_add_drain could be called from several hot
> > places(e.g.,
> > unmap and pagevec_release from several path) and it could keeps
> > invalidating
> > bh_lrus.
> > 
> > IMO, we should move the overhead from such hot path to cold one. How
> > about this?
> > 
> > From ebf4ede1cf32fb14d85f0015a3693cb8e1b8dbfe Mon Sep 17 00:00:00 2001
> > From: Minchan Kim <minchan@kernel.org>
> > Date: Thu, 20 May 2021 11:17:56 -0700
> > Subject: [PATCH] invalidate bh_lrus only at lru_add_drain_all
> > 
> > Not-Yet-Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  mm/swap.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/swap.c b/mm/swap.c
> > index dfb48cf9c2c9..d6168449e28c 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -642,7 +642,6 @@ void lru_add_drain_cpu(int cpu)
> >  		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
> > 
> >  	activate_page_drain(cpu);
> > -	invalidate_bh_lrus_cpu(cpu);
> >  }
> > 
> >  /**
> > @@ -725,6 +724,17 @@ void lru_add_drain(void)
> >  	local_unlock(&lru_pvecs.lock);
> >  }
> > 
> > +void lru_and_bh_lrus_drain(void)
> > +{
> > +	int cpu;
> > +
> > +	local_lock(&lru_pvecs.lock);
> > +	cpu = smp_processor_id();
> > +	lru_add_drain_cpu(cpu);
> > +	local_unlock(&lru_pvecs.lock);
> > +	invalidate_bh_lrus_cpu(cpu);
> > +}
> > +
> 
> Nit: drop int cpu?

Do you mean to suggest using smp_processor_id at both places
instead of local varaible? Since the invalidate_bh_lrus_cpu
is called out of the lru_pvecs.lock, I wanted to express
the draining happens at the same CPU via storing the CPU.

> 
> >  void lru_add_drain_cpu_zone(struct zone *zone)
> >  {
> >  	local_lock(&lru_pvecs.lock);
> > @@ -739,7 +749,7 @@ static DEFINE_PER_CPU(struct work_struct,
> > lru_add_drain_work);
> > 
> >  static void lru_add_drain_per_cpu(struct work_struct *dummy)
> >  {
> > -	lru_add_drain();
> > +	lru_and_bh_lrus_drain();
> >  }
> > 
> >  /*
> > @@ -881,6 +891,7 @@ void lru_cache_disable(void)
> >  	__lru_add_drain_all(true);
> >  #else
> >  	lru_add_drain();
> > +	invalidate_bh_lrus_cpu(smp_processor_id());
> >  #endif
> >  }
> 
> Can't we replace the call to lru_add_drain() and
> invalidate_bh_lrus_cpu(smp_processor_id()) with a single call to
> lru_and_bh_lrus_drain()?

Good idea.

Thanks!
