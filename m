Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0350B3906C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhEYQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhEYQlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:41:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B13C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:39:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d20so2353992pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XW6NgJEjZ28nxbGvlAeJfphpHPzPfRyygy8oAg93vB4=;
        b=JKMBYRIcEmtMSmHpVWy6F1SPMPhFTbde+Mek15lijU7R2MA59L0jxyms8+FCe3PEpK
         FMutZioTAnTgTxlM4EB93wlRFU1emMur7wbMo++g98UpdL45fIAJAlt+ytteC+sH++xr
         dmSXiMp4PJjxhzHzjNTIyo5rSJ7hod8Pr7NV5PyoIs3+WEm8IwBuzlyl0HGzrD7/qmdy
         3rchz49g0T168NUhXNgZ1w/wlNab0HwynNZN5QT7syC6zbtbZ/+1isDSnp9Yl3/AS1Mt
         mYn7jBgp39MLbyDxExjr7qFSLqJcihaO+kQlKhjWPquOmfuFAfJ+Ad831mQhoPn6IWTF
         R/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XW6NgJEjZ28nxbGvlAeJfphpHPzPfRyygy8oAg93vB4=;
        b=ttA34cW+f6X3+G6k3nwxVySKP5sonf6YXRZWnoP6q7NVh73ZMSWs5FZ22kMoUQexBl
         w5qaV0VKH40FkUjfsED/uH6c+nS8cuvJgnrWfhGGcs1nKLvJx02R9uR8EZSaIHLddeuD
         gwuGsCZGZ/GviIJpjDBNBM9E3SpVSvCuMW8Q8EQaEy1+eTYPMZ38sOuvDO3YzzTU3zhA
         fRtsVwflehwvcQSrHHgBvvj44LQPE9ceDv37W0ikKnNlflekD9PQOkhCR/PRyBMjR3nF
         VXO8Sj+gMLLOC+NS0NkoVDADvyyz9lF4XNuRB3mn6pa8RD4G+ARMhpIm0q/WUJ2H6zs6
         7Lbg==
X-Gm-Message-State: AOAM530TG4ZePacJlbMfd5GoAGWrdjioOP7p9gjSg+94r+B5dpfn7Fy8
        urebrIRLn7M3wSPfnw3LtJA=
X-Google-Smtp-Source: ABdhPJz0DpWUr2CiOFMfGJijqrBU6YbB1Hl+Vf8amKhhPJHgRdSXJO7p/XmN7sLYzud+kdBA8UxfAA==
X-Received: by 2002:a17:90b:502:: with SMTP id r2mr5600542pjz.117.1621960775962;
        Tue, 25 May 2021 09:39:35 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:37cd:d6b4:7992:c290])
        by smtp.gmail.com with ESMTPSA id s23sm2417016pjg.15.2021.05.25.09.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:39:34 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 25 May 2021 09:39:31 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>
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
Message-ID: <YK0oQ76zX0uVZCwQ@google.com>
References: <20210520083144.GD14190@xsang-OptiPlex-9020>
 <YKasEeXCr9R5yzCr@google.com>
 <45f761de51d514f77cc48214846c5f8f@codeaurora.org>
 <YK0Us01mBTRWOQIw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK0Us01mBTRWOQIw@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 08:16:03AM -0700, Minchan Kim wrote:

< snip >

> > > On Thu, May 20, 2021 at 04:31:44PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Greeting,
> > > > 
> > > > FYI, we noticed a -21.8% regression of fio.write_iops due to commit:
> > > > 
> > > > 
> > > > commit: 8cc621d2f45ddd3dc664024a647ee7adf48d79a5 ("mm: fs:
> > > > invalidate BH LRU during page migration")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > 
> > > > 
> > > > in testcase: fio-basic
> > > > on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU
> > > > @ 2.10GHz with 256G memory
> > > > with following parameters:
> > > > 
> > > > 	disk: 2pmem
> > > > 	fs: ext4
> > > > 	runtime: 200s
> > > > 	nr_task: 50%
> > > > 	time_based: tb
> > > > 	rw: randwrite
> > > > 	bs: 4k
> > > > 	ioengine: libaio
> > > > 	test_size: 200G
> > > > 	cpufreq_governor: performance
> > > > 	ucode: 0x5003006
> > > > 
> > > > test-description: Fio is a tool that will spawn a number of threads
> > > > or processes doing a particular type of I/O action as specified by
> > > > the user.
> > > > test-url: https://github.com/axboe/fio
> > > > 
> > > > 
> > > > 
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > 
> > > > 
> > > > Details are as below:
> > > > -------------------------------------------------------------------------------------------------->
> > > > 
> > > > 
> > > > To reproduce:
> > > > 
> > > >         git clone https://github.com/intel/lkp-tests.git
> > > >         cd lkp-tests
> > > >         bin/lkp install                job.yaml  # job file is
> > > > attached in this email
> > > >         bin/lkp split-job --compatible job.yaml  # generate the yaml
> > > > file for lkp run
> > > >         bin/lkp run                    generated-yaml-file
> > > 
> > > Hi,
> > > 
> > > I tried to insall the lkp-test in my machine by following above guide
> > > but failed
> > > due to package problems(I guess it's my problem since I use something
> > > particular
> > > environement). However, I guess it comes from increased miss ratio of
> > > bh_lrus
> > > since the patch caused more frequent invalidation of the bh_lrus calls
> > > compared
> > > to old. For example, lru_add_drain could be called from several hot
> > > places(e.g.,
> > > unmap and pagevec_release from several path) and it could keeps
> > > invalidating
> > > bh_lrus.
> > > 
> > > IMO, we should move the overhead from such hot path to cold one. How
> > > about this?
> > > 
> > > From ebf4ede1cf32fb14d85f0015a3693cb8e1b8dbfe Mon Sep 17 00:00:00 2001
> > > From: Minchan Kim <minchan@kernel.org>
> > > Date: Thu, 20 May 2021 11:17:56 -0700
> > > Subject: [PATCH] invalidate bh_lrus only at lru_add_drain_all
> > > 
> > > Not-Yet-Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > ---
> > >  mm/swap.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/mm/swap.c b/mm/swap.c
> > > index dfb48cf9c2c9..d6168449e28c 100644
> > > --- a/mm/swap.c
> > > +++ b/mm/swap.c
> > > @@ -642,7 +642,6 @@ void lru_add_drain_cpu(int cpu)
> > >  		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
> > > 
> > >  	activate_page_drain(cpu);
> > > -	invalidate_bh_lrus_cpu(cpu);
> > >  }
> > > 
> > >  /**
> > > @@ -725,6 +724,17 @@ void lru_add_drain(void)
> > >  	local_unlock(&lru_pvecs.lock);
> > >  }
> > > 
> > > +void lru_and_bh_lrus_drain(void)
> > > +{
> > > +	int cpu;
> > > +
> > > +	local_lock(&lru_pvecs.lock);
> > > +	cpu = smp_processor_id();
> > > +	lru_add_drain_cpu(cpu);
> > > +	local_unlock(&lru_pvecs.lock);
> > > +	invalidate_bh_lrus_cpu(cpu);
> > > +}
> > > +
> > 
> > Nit: drop int cpu?
> 
> Do you mean to suggest using smp_processor_id at both places
> instead of local varaible? Since the invalidate_bh_lrus_cpu
> is called out of the lru_pvecs.lock, I wanted to express
> the draining happens at the same CPU via storing the CPU.
> 
> > 
> > >  void lru_add_drain_cpu_zone(struct zone *zone)
> > >  {
> > >  	local_lock(&lru_pvecs.lock);
> > > @@ -739,7 +749,7 @@ static DEFINE_PER_CPU(struct work_struct,
> > > lru_add_drain_work);
> > > 
> > >  static void lru_add_drain_per_cpu(struct work_struct *dummy)
> > >  {
> > > -	lru_add_drain();
> > > +	lru_and_bh_lrus_drain();
> > >  }
> > > 
> > >  /*
> > > @@ -881,6 +891,7 @@ void lru_cache_disable(void)
> > >  	__lru_add_drain_all(true);
> > >  #else
> > >  	lru_add_drain();
> > > +	invalidate_bh_lrus_cpu(smp_processor_id());
> > >  #endif
> > >  }
> > 
> > Can't we replace the call to lru_add_drain() and
> > invalidate_bh_lrus_cpu(smp_processor_id()) with a single call to
> > lru_and_bh_lrus_drain()?
> 
> Good idea.

From 8caadeb49d82403a08643dfbdb0b7749017c00bb Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Tue, 25 May 2021 08:19:17 -0700
Subject: [PATCH] mm: fs: invalidate bh_lrus for only cold path

kernel test robot reported the regression of fio.write_iops[1]
with [2].

Since lru_add_drain is called frequently, invalidate bh_lrus
there could increase bh_lrus cache miss ratio, which needs
more IO in the end.

This patch moves the bh_lrus invalidation from the hot path(
e.g., zap_page_range, pagevec_release) to cold path(i.e.,
lru_add_drain_all, lru_cache_disable).

[1] https://lore.kernel.org/lkml/20210520083144.GD14190@xsang-OptiPlex-9020/
[2] 8cc621d2f45d, mm: fs: invalidate BH LRU during page migration
Cc: Xing, Zhengjun <zhengjun.xing@intel.com>
Cc: Chris Goldsworthy <cgoldswo@codeaurora.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/swap.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 1958d5feb148..3e25d99a9dbb 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -642,7 +642,6 @@ void lru_add_drain_cpu(int cpu)
 		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
 
 	activate_page_drain(cpu);
-	invalidate_bh_lrus_cpu(cpu);
 }
 
 /**
@@ -725,6 +724,17 @@ void lru_add_drain(void)
 	local_unlock(&lru_pvecs.lock);
 }
 
+static void lru_add_and_bh_lrus_drain(void)
+{
+	int cpu;
+
+	local_lock(&lru_pvecs.lock);
+	cpu = smp_processor_id();
+	lru_add_drain_cpu(cpu);
+	local_unlock(&lru_pvecs.lock);
+	invalidate_bh_lrus_cpu(cpu);
+}
+
 void lru_add_drain_cpu_zone(struct zone *zone)
 {
 	local_lock(&lru_pvecs.lock);
@@ -739,7 +749,7 @@ static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
 
 static void lru_add_drain_per_cpu(struct work_struct *dummy)
 {
-	lru_add_drain();
+	lru_add_and_bh_lrus_drain();
 }
 
 /*
@@ -880,7 +890,7 @@ void lru_cache_disable(void)
 	 */
 	__lru_add_drain_all(true);
 #else
-	lru_add_drain();
+	lru_add_and_bh_lrus_drain();
 #endif
 }
 
-- 
2.31.1.818.g46aad6cb9e-goog

