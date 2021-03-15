Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EE233C72B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhCOTzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:55:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:42617 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232993AbhCOTy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:54:58 -0400
IronPort-SDR: tBPd19htwa32kl4scZWpxdQasaXaPYJimPSzLVczZN6jdIRaEA45+6kOQb9Vs1f4d2m40jhra1
 bxqlg4v70L/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="168420955"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="gz'50?scan'50,208,50";a="168420955"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 12:54:51 -0700
IronPort-SDR: f408T6Ajzfkbiv6m+cG52wXYOhvCgIJE4odpOLwFognlj7fgKRIqhANUEF7gVYtl0cZnwThq+K
 df2fUldz1+Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="gz'50?scan'50,208,50";a="410765692"
Received: from lkp-server02.sh.intel.com (HELO 1dc5e1a854f4) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2021 12:54:48 -0700
Received: from kbuild by 1dc5e1a854f4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lLtId-0000cl-9a; Mon, 15 Mar 2021 19:54:47 +0000
Date:   Tue, 16 Mar 2021 03:54:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: try oom if reclaim is unable to make
 forward progress
Message-ID: <202103160339.z59TH5v7-lkp@intel.com>
References: <20210315165837.789593-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20210315165837.789593-1-atomlin@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Aaron,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-linux-mm/master]

url:    https://github.com/0day-ci/linux/commits/Aaron-Tomlin/mm-page_alloc-try-oom-if-reclaim-is-unable-to-make-forward-progress/20210316-010203
base:   https://github.com/hnaz/linux-mm master
config: arc-randconfig-r024-20210315 (attached as .config)
compiler: arceb-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/77338aaff2606a7715c832545e79370e849e3b4e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Aaron-Tomlin/mm-page_alloc-try-oom-if-reclaim-is-unable-to-make-forward-progress/20210316-010203
        git checkout 77338aaff2606a7715c832545e79370e849e3b4e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   mm/page_alloc.c: In function 'should_reclaim_retry':
>> mm/page_alloc.c:4444:3: error: 'result' undeclared (first use in this function)
    4444 |   result false;
         |   ^~~~~~
   mm/page_alloc.c:4444:3: note: each undeclared identifier is reported only once for each function it appears in
>> mm/page_alloc.c:4444:9: error: expected ';' before 'false'
    4444 |   result false;
         |         ^~~~~~
         |         ;
>> mm/page_alloc.c:4447:50: error: expected ';' before 'for'
    4447 |   return unreserve_highatomic_pageblock(ac, true)
         |                                                  ^
         |                                                  ;
   mm/page_alloc.c:4426:18: warning: unused variable 'z' [-Wunused-variable]
    4426 |  struct zoneref *z;
         |                  ^
   mm/page_alloc.c:4425:15: warning: unused variable 'zone' [-Wunused-variable]
    4425 |  struct zone *zone;
         |               ^~~~
   mm/page_alloc.c: In function '__alloc_pages_slowpath':
>> mm/page_alloc.c:4720:11: error: expected ';' before ':' token
    4720 |   goto oom:
         |           ^
         |           ;
>> mm/page_alloc.c:4556:6: warning: variable 'compaction_retries' set but not used [-Wunused-but-set-variable]
    4556 |  int compaction_retries;
         |      ^~~~~~~~~~~~~~~~~~
   mm/page_alloc.c: At top level:
   mm/page_alloc.c:6136:23: warning: no previous prototype for 'memmap_init' [-Wmissing-prototypes]
    6136 | void __meminit __weak memmap_init(unsigned long size, int nid,
         |                       ^~~~~~~~~~~


vim +/result +4444 mm/page_alloc.c

  4409	
  4410	/*
  4411	 * Checks whether it makes sense to retry the reclaim to make a forward progress
  4412	 * for the given allocation request.
  4413	 *
  4414	 * We give up when we either have tried MAX_RECLAIM_RETRIES in a row
  4415	 * without success, or when we couldn't even meet the watermark if we
  4416	 * reclaimed all remaining pages on the LRU lists.
  4417	 *
  4418	 * Returns true if a retry is viable or false to enter the oom path.
  4419	 */
  4420	static inline bool
  4421	should_reclaim_retry(gfp_t gfp_mask, unsigned order,
  4422			     struct alloc_context *ac, int alloc_flags,
  4423			     bool did_some_progress, int *no_progress_loops)
  4424	{
  4425		struct zone *zone;
  4426		struct zoneref *z;
  4427		bool ret = false;
  4428	
  4429		/*
  4430		 * Costly allocations might have made a progress but this doesn't mean
  4431		 * their order will become available due to high fragmentation so
  4432		 * always increment the no progress counter for them
  4433		 */
  4434		if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER)
  4435			*no_progress_loops = 0;
  4436		else
  4437			(*no_progress_loops)++;
  4438	
  4439		/*
  4440		 * Make sure we converge to OOM if we cannot make any progress
  4441		 * several times in the row.
  4442		 */
  4443		if (*no_progress_loops > MAX_RECLAIM_RETRIES)
> 4444			result false;
  4445		/* Last chance before OOM, try draining highatomic_reserve once */
  4446		else if (*no_progress_loops == MAX_RECLAIM_RETRIES)
> 4447			return unreserve_highatomic_pageblock(ac, true)
  4448	
  4449		/*
  4450		 * Keep reclaiming pages while there is a chance this will lead
  4451		 * somewhere.  If none of the target zones can satisfy our allocation
  4452		 * request even if all reclaimable pages are considered then we are
  4453		 * screwed and have to go OOM.
  4454		 */
  4455		for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
  4456					ac->highest_zoneidx, ac->nodemask) {
  4457			unsigned long available;
  4458			unsigned long reclaimable;
  4459			unsigned long min_wmark = min_wmark_pages(zone);
  4460			bool wmark;
  4461	
  4462			available = reclaimable = zone_reclaimable_pages(zone);
  4463			available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
  4464	
  4465			/*
  4466			 * Would the allocation succeed if we reclaimed all
  4467			 * reclaimable pages?
  4468			 */
  4469			wmark = __zone_watermark_ok(zone, order, min_wmark,
  4470					ac->highest_zoneidx, alloc_flags, available);
  4471			trace_reclaim_retry_zone(z, order, reclaimable,
  4472					available, min_wmark, *no_progress_loops, wmark);
  4473			if (wmark) {
  4474				/*
  4475				 * If we didn't make any progress and have a lot of
  4476				 * dirty + writeback pages then we should wait for
  4477				 * an IO to complete to slow down the reclaim and
  4478				 * prevent from pre mature OOM
  4479				 */
  4480				if (!did_some_progress) {
  4481					unsigned long write_pending;
  4482	
  4483					write_pending = zone_page_state_snapshot(zone,
  4484								NR_ZONE_WRITE_PENDING);
  4485	
  4486					if (2 * write_pending > reclaimable) {
  4487						congestion_wait(BLK_RW_ASYNC, HZ/10);
  4488						return true;
  4489					}
  4490				}
  4491	
  4492				ret = true;
  4493				goto out;
  4494			}
  4495		}
  4496	
  4497	out:
  4498		/*
  4499		 * Memory allocation/reclaim might be called from a WQ context and the
  4500		 * current implementation of the WQ concurrency control doesn't
  4501		 * recognize that a particular WQ is congested if the worker thread is
  4502		 * looping without ever sleeping. Therefore we have to do a short sleep
  4503		 * here rather than calling cond_resched().
  4504		 */
  4505		if (current->flags & PF_WQ_WORKER)
  4506			schedule_timeout_uninterruptible(1);
  4507		else
  4508			cond_resched();
  4509		return ret;
  4510	}
  4511	
  4512	static inline bool
  4513	check_retry_cpuset(int cpuset_mems_cookie, struct alloc_context *ac)
  4514	{
  4515		/*
  4516		 * It's possible that cpuset's mems_allowed and the nodemask from
  4517		 * mempolicy don't intersect. This should be normally dealt with by
  4518		 * policy_nodemask(), but it's possible to race with cpuset update in
  4519		 * such a way the check therein was true, and then it became false
  4520		 * before we got our cpuset_mems_cookie here.
  4521		 * This assumes that for all allocations, ac->nodemask can come only
  4522		 * from MPOL_BIND mempolicy (whose documented semantics is to be ignored
  4523		 * when it does not intersect with the cpuset restrictions) or the
  4524		 * caller can deal with a violated nodemask.
  4525		 */
  4526		if (cpusets_enabled() && ac->nodemask &&
  4527				!cpuset_nodemask_valid_mems_allowed(ac->nodemask)) {
  4528			ac->nodemask = NULL;
  4529			return true;
  4530		}
  4531	
  4532		/*
  4533		 * When updating a task's mems_allowed or mempolicy nodemask, it is
  4534		 * possible to race with parallel threads in such a way that our
  4535		 * allocation can fail while the mask is being updated. If we are about
  4536		 * to fail, check if the cpuset changed during allocation and if so,
  4537		 * retry.
  4538		 */
  4539		if (read_mems_allowed_retry(cpuset_mems_cookie))
  4540			return true;
  4541	
  4542		return false;
  4543	}
  4544	
  4545	static inline struct page *
  4546	__alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
  4547							struct alloc_context *ac)
  4548	{
  4549		bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
  4550		const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
  4551		struct page *page = NULL;
  4552		unsigned int alloc_flags;
  4553		unsigned long did_some_progress;
  4554		enum compact_priority compact_priority;
  4555		enum compact_result compact_result;
> 4556		int compaction_retries;
  4557		int no_progress_loops;
  4558		unsigned int cpuset_mems_cookie;
  4559		int reserve_flags;
  4560	
  4561		/*
  4562		 * We also sanity check to catch abuse of atomic reserves being used by
  4563		 * callers that are not in atomic context.
  4564		 */
  4565		if (WARN_ON_ONCE((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
  4566					(__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
  4567			gfp_mask &= ~__GFP_ATOMIC;
  4568	
  4569	retry_cpuset:
  4570		compaction_retries = 0;
  4571		no_progress_loops = 0;
  4572		compact_priority = DEF_COMPACT_PRIORITY;
  4573		cpuset_mems_cookie = read_mems_allowed_begin();
  4574	
  4575		/*
  4576		 * The fast path uses conservative alloc_flags to succeed only until
  4577		 * kswapd needs to be woken up, and to avoid the cost of setting up
  4578		 * alloc_flags precisely. So we do that now.
  4579		 */
  4580		alloc_flags = gfp_to_alloc_flags(gfp_mask);
  4581	
  4582		/*
  4583		 * We need to recalculate the starting point for the zonelist iterator
  4584		 * because we might have used different nodemask in the fast path, or
  4585		 * there was a cpuset modification and we are retrying - otherwise we
  4586		 * could end up iterating over non-eligible zones endlessly.
  4587		 */
  4588		ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
  4589						ac->highest_zoneidx, ac->nodemask);
  4590		if (!ac->preferred_zoneref->zone)
  4591			goto nopage;
  4592	
  4593		if (alloc_flags & ALLOC_KSWAPD)
  4594			wake_all_kswapds(order, gfp_mask, ac);
  4595	
  4596		/*
  4597		 * The adjusted alloc_flags might result in immediate success, so try
  4598		 * that first
  4599		 */
  4600		page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
  4601		if (page)
  4602			goto got_pg;
  4603	
  4604		/*
  4605		 * For costly allocations, try direct compaction first, as it's likely
  4606		 * that we have enough base pages and don't need to reclaim. For non-
  4607		 * movable high-order allocations, do that as well, as compaction will
  4608		 * try prevent permanent fragmentation by migrating from blocks of the
  4609		 * same migratetype.
  4610		 * Don't try this for allocations that are allowed to ignore
  4611		 * watermarks, as the ALLOC_NO_WATERMARKS attempt didn't yet happen.
  4612		 */
  4613		if (can_direct_reclaim &&
  4614				(costly_order ||
  4615				   (order > 0 && ac->migratetype != MIGRATE_MOVABLE))
  4616				&& !gfp_pfmemalloc_allowed(gfp_mask)) {
  4617			page = __alloc_pages_direct_compact(gfp_mask, order,
  4618							alloc_flags, ac,
  4619							INIT_COMPACT_PRIORITY,
  4620							&compact_result);
  4621			if (page)
  4622				goto got_pg;
  4623	
  4624			/*
  4625			 * Checks for costly allocations with __GFP_NORETRY, which
  4626			 * includes some THP page fault allocations
  4627			 */
  4628			if (costly_order && (gfp_mask & __GFP_NORETRY)) {
  4629				/*
  4630				 * If allocating entire pageblock(s) and compaction
  4631				 * failed because all zones are below low watermarks
  4632				 * or is prohibited because it recently failed at this
  4633				 * order, fail immediately unless the allocator has
  4634				 * requested compaction and reclaim retry.
  4635				 *
  4636				 * Reclaim is
  4637				 *  - potentially very expensive because zones are far
  4638				 *    below their low watermarks or this is part of very
  4639				 *    bursty high order allocations,
  4640				 *  - not guaranteed to help because isolate_freepages()
  4641				 *    may not iterate over freed pages as part of its
  4642				 *    linear scan, and
  4643				 *  - unlikely to make entire pageblocks free on its
  4644				 *    own.
  4645				 */
  4646				if (compact_result == COMPACT_SKIPPED ||
  4647				    compact_result == COMPACT_DEFERRED)
  4648					goto nopage;
  4649	
  4650				/*
  4651				 * Looks like reclaim/compaction is worth trying, but
  4652				 * sync compaction could be very expensive, so keep
  4653				 * using async compaction.
  4654				 */
  4655				compact_priority = INIT_COMPACT_PRIORITY;
  4656			}
  4657		}
  4658	
  4659	retry:
  4660		/* Ensure kswapd doesn't accidentally go to sleep as long as we loop */
  4661		if (alloc_flags & ALLOC_KSWAPD)
  4662			wake_all_kswapds(order, gfp_mask, ac);
  4663	
  4664		reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
  4665		if (reserve_flags)
  4666			alloc_flags = current_alloc_flags(gfp_mask, reserve_flags);
  4667	
  4668		/*
  4669		 * Reset the nodemask and zonelist iterators if memory policies can be
  4670		 * ignored. These allocations are high priority and system rather than
  4671		 * user oriented.
  4672		 */
  4673		if (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
  4674			ac->nodemask = NULL;
  4675			ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
  4676						ac->highest_zoneidx, ac->nodemask);
  4677		}
  4678	
  4679		/* Attempt with potentially adjusted zonelist and alloc_flags */
  4680		page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
  4681		if (page)
  4682			goto got_pg;
  4683	
  4684		/* Caller is not willing to reclaim, we can't balance anything */
  4685		if (!can_direct_reclaim)
  4686			goto nopage;
  4687	
  4688		/* Avoid recursion of direct reclaim */
  4689		if (current->flags & PF_MEMALLOC)
  4690			goto nopage;
  4691	
  4692		/* Try direct reclaim and then allocating */
  4693		page = __alloc_pages_direct_reclaim(gfp_mask, order, alloc_flags, ac,
  4694								&did_some_progress);
  4695		if (page)
  4696			goto got_pg;
  4697	
  4698		/* Try direct compaction and then allocating */
  4699		page = __alloc_pages_direct_compact(gfp_mask, order, alloc_flags, ac,
  4700						compact_priority, &compact_result);
  4701		if (page)
  4702			goto got_pg;
  4703	
  4704		/* Do not loop if specifically requested */
  4705		if (gfp_mask & __GFP_NORETRY)
  4706			goto nopage;
  4707	
  4708		/*
  4709		 * Do not retry costly high order allocations unless they are
  4710		 * __GFP_RETRY_MAYFAIL
  4711		 */
  4712		if (costly_order && !(gfp_mask & __GFP_RETRY_MAYFAIL))
  4713			goto nopage;
  4714	
  4715		if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
  4716					 did_some_progress > 0, &no_progress_loops))
  4717			goto retry;
  4718	
  4719		if (should_try_oom(no_progress_loops, compact_result))
  4720			goto oom:
  4721		/*
  4722		 * It doesn't make any sense to retry for the compaction if the order-0
  4723		 * reclaim is not able to make any progress because the current
  4724		 * implementation of the compaction depends on the sufficient amount
  4725		 * of free memory (see __compaction_suitable)
  4726		 */
  4727		if (did_some_progress > 0 &&
  4728				should_compact_retry(ac, order, alloc_flags,
  4729					compact_result, &compact_priority,
  4730					&compaction_retries))
  4731			goto retry;
  4732	
  4733	
  4734		/* Deal with possible cpuset update races before we start OOM killing */
  4735		if (check_retry_cpuset(cpuset_mems_cookie, ac))
  4736			goto retry_cpuset;
  4737	
  4738	oom:
  4739		/* Reclaim has failed us, start killing things */
  4740		page = __alloc_pages_may_oom(gfp_mask, order, ac, &did_some_progress);
  4741		if (page)
  4742			goto got_pg;
  4743	
  4744		/* Avoid allocations with no watermarks from looping endlessly */
  4745		if (tsk_is_oom_victim(current) &&
  4746		    (alloc_flags & ALLOC_OOM ||
  4747		     (gfp_mask & __GFP_NOMEMALLOC)))
  4748			goto nopage;
  4749	
  4750		/* Retry as long as the OOM killer is making progress */
  4751		if (did_some_progress) {
  4752			no_progress_loops = 0;
  4753			goto retry;
  4754		}
  4755	
  4756	nopage:
  4757		/* Deal with possible cpuset update races before we fail */
  4758		if (check_retry_cpuset(cpuset_mems_cookie, ac))
  4759			goto retry_cpuset;
  4760	
  4761		/*
  4762		 * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
  4763		 * we always retry
  4764		 */
  4765		if (gfp_mask & __GFP_NOFAIL) {
  4766			/*
  4767			 * All existing users of the __GFP_NOFAIL are blockable, so warn
  4768			 * of any new users that actually require GFP_NOWAIT
  4769			 */
  4770			if (WARN_ON_ONCE(!can_direct_reclaim))
  4771				goto fail;
  4772	
  4773			/*
  4774			 * PF_MEMALLOC request from this context is rather bizarre
  4775			 * because we cannot reclaim anything and only can loop waiting
  4776			 * for somebody to do a work for us
  4777			 */
  4778			WARN_ON_ONCE(current->flags & PF_MEMALLOC);
  4779	
  4780			/*
  4781			 * non failing costly orders are a hard requirement which we
  4782			 * are not prepared for much so let's warn about these users
  4783			 * so that we can identify them and convert them to something
  4784			 * else.
  4785			 */
  4786			WARN_ON_ONCE(order > PAGE_ALLOC_COSTLY_ORDER);
  4787	
  4788			/*
  4789			 * Help non-failing allocations by giving them access to memory
  4790			 * reserves but do not use ALLOC_NO_WATERMARKS because this
  4791			 * could deplete whole memory reserves which would just make
  4792			 * the situation worse
  4793			 */
  4794			page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_HARDER, ac);
  4795			if (page)
  4796				goto got_pg;
  4797	
  4798			cond_resched();
  4799			goto retry;
  4800		}
  4801	fail:
  4802		warn_alloc(gfp_mask, ac->nodemask,
  4803				"page allocation failure: order:%u", order);
  4804	got_pg:
  4805		return page;
  4806	}
  4807	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--DocE+STaALJfprDB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
kWZoz91Rnqf/B9TjNrocVQEA

--DocE+STaALJfprDB--
