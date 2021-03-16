Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0234A33CA47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 01:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhCPAN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 20:13:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:38753 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232008AbhCPAM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 20:12:56 -0400
IronPort-SDR: ClWJOcphmhtfVV04+kjGZ/FRh6iLelaqmfr/JgNCbJQ8TuZ0pI05oSge5Vur68yX/0ttwcjA04
 AuIIAMP8Nv1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="176303876"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="gz'50?scan'50,208,50";a="176303876"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 17:12:54 -0700
IronPort-SDR: Hsjnuxto2RKvJLVMJL1Gy1mJort+Dx39FlGZ84gdA9kDGwYqQSmGqJ+SgfUTdc2Q24gOxA1IM2
 vlneOCRiJJcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="gz'50?scan'50,208,50";a="373606257"
Received: from lkp-server02.sh.intel.com (HELO 1dc5e1a854f4) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2021 17:12:51 -0700
Received: from kbuild by 1dc5e1a854f4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lLxKN-0000hz-2r; Tue, 16 Mar 2021 00:12:51 +0000
Date:   Tue, 16 Mar 2021 08:12:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: drivers/gpu/drm/i915/gem/selftests/i915_gem_object_blt.c:233
 igt_fill_blt_thread() error: 'ce' dereferencing possible ERR_PTR()
Message-ID: <202103160805.VxpcGAAl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1e28eed17697bcf343c6743f0028cc3b5dd88bf0
commit: 03c62d886dd6d3dfebf59d385a37245fe667fe90 drm/i915: Make GEM errors non-fatal by default
date:   8 weeks ago
config: x86_64-randconfig-m001-20210316 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/gpu/drm/i915/gem/selftests/i915_gem_object_blt.c:233 igt_fill_blt_thread() error: 'ce' dereferencing possible ERR_PTR()
drivers/gpu/drm/i915/gem/selftests/i915_gem_object_blt.c:351 igt_copy_blt_thread() error: 'ce' dereferencing possible ERR_PTR()
drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c:693 igt_ctx_exec() error: 'ce' dereferencing possible ERR_PTR()
drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c:834 igt_shared_ctx_exec() error: 'ce' dereferencing possible ERR_PTR()
drivers/gpu/drm/i915/selftests/i915_request.c:216 igt_request_rewind() error: 'ce' dereferencing possible ERR_PTR()
drivers/gpu/drm/i915/selftests/i915_request.c:351 __igt_breadcrumbs_smoketest() error: 'ce' dereferencing possible ERR_PTR()

Old smatch warnings:
drivers/gpu/drm/i915/gem/i915_gem_object.h:127 __i915_gem_object_lock() error: we previously assumed 'ww' could be null (see line 119)
drivers/gpu/drm/i915/gem/i915_gem_object_blt.c:140 move_obj_to_gpu() warn: maybe use && instead of &
drivers/gpu/drm/i915/gem/i915_gem_context.h:204 i915_gem_context_get_engine() warn: inconsistent indenting
drivers/gpu/drm/i915/gem/i915_gem_context.h:206 i915_gem_context_get_engine() warn: inconsistent indenting
drivers/gpu/drm/i915/gem/i915_gem_context.h:204 i915_gem_context_get_engine() warn: inconsistent indenting
drivers/gpu/drm/i915/gem/i915_gem_context.h:206 i915_gem_context_get_engine() warn: inconsistent indenting
drivers/gpu/drm/i915/gem/i915_gem_object.h:127 __i915_gem_object_lock() error: we previously assumed 'ww' could be null (see line 119)
drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c:709 igt_ctx_exec() error: 'ce' dereferencing possible ERR_PTR()
drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c:716 igt_ctx_exec() error: 'ce' dereferencing possible ERR_PTR()
drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c:729 igt_ctx_exec() error: 'ce' dereferencing possible ERR_PTR()
drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c:847 igt_shared_ctx_exec() error: 'ce' dereferencing possible ERR_PTR()
drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c:854 igt_shared_ctx_exec() error: 'ce' dereferencing possible ERR_PTR()
drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c:867 igt_shared_ctx_exec() error: 'ce' dereferencing possible ERR_PTR()
drivers/gpu/drm/i915/selftests/i915_request.c:230 igt_request_rewind() error: 'ce' dereferencing possible ERR_PTR()
drivers/gpu/drm/i915/gem/i915_gem_context.h:204 i915_gem_context_get_engine() warn: inconsistent indenting
drivers/gpu/drm/i915/gem/i915_gem_context.h:206 i915_gem_context_get_engine() warn: inconsistent indenting

vim +/ce +233 drivers/gpu/drm/i915/gem/selftests/i915_gem_object_blt.c

0e99f939f08fc3 Matthew Auld   2019-10-25  202  
0e99f939f08fc3 Matthew Auld   2019-10-25  203  static int igt_fill_blt_thread(void *arg)
6501aa4e3a4507 Matthew Auld   2019-05-29  204  {
0e99f939f08fc3 Matthew Auld   2019-10-25  205  	struct igt_thread_arg *thread = arg;
d61345f342981f Chris Wilson   2020-06-04  206  	struct intel_engine_cs *engine = thread->engine;
0e99f939f08fc3 Matthew Auld   2019-10-25  207  	struct rnd_state *prng = &thread->prng;
6501aa4e3a4507 Matthew Auld   2019-05-29  208  	struct drm_i915_gem_object *obj;
0e99f939f08fc3 Matthew Auld   2019-10-25  209  	struct i915_gem_context *ctx;
0e99f939f08fc3 Matthew Auld   2019-10-25  210  	struct intel_context *ce;
0e99f939f08fc3 Matthew Auld   2019-10-25  211  	unsigned int prio;
6501aa4e3a4507 Matthew Auld   2019-05-29  212  	IGT_TIMEOUT(end);
4746fd5c2c1322 Chris Wilson   2020-02-10  213  	u64 total, max;
0e99f939f08fc3 Matthew Auld   2019-10-25  214  	int err;
6501aa4e3a4507 Matthew Auld   2019-05-29  215  
34485832cb9872 Chris Wilson   2019-11-11  216  	ctx = thread->ctx;
34485832cb9872 Chris Wilson   2019-11-11  217  	if (!ctx) {
d61345f342981f Chris Wilson   2020-06-04  218  		ctx = live_context_for_engine(engine, thread->file);
34485832cb9872 Chris Wilson   2019-11-11  219  		if (IS_ERR(ctx))
34485832cb9872 Chris Wilson   2019-11-11  220  			return PTR_ERR(ctx);
0e99f939f08fc3 Matthew Auld   2019-10-25  221  
0e99f939f08fc3 Matthew Auld   2019-10-25  222  		prio = i915_prandom_u32_max_state(I915_PRIORITY_MAX, prng);
0e99f939f08fc3 Matthew Auld   2019-10-25  223  		ctx->sched.priority = I915_USER_PRIORITY(prio);
34485832cb9872 Chris Wilson   2019-11-11  224  	}
0e99f939f08fc3 Matthew Auld   2019-10-25  225  
d61345f342981f Chris Wilson   2020-06-04  226  	ce = i915_gem_context_get_engine(ctx, 0);
0e99f939f08fc3 Matthew Auld   2019-10-25  227  	GEM_BUG_ON(IS_ERR(ce));
554e330ceb9f00 Matthew Auld   2019-08-10  228  
4746fd5c2c1322 Chris Wilson   2020-02-10  229  	/*
4746fd5c2c1322 Chris Wilson   2020-02-10  230  	 * If we have a tiny shared address space, like for the GGTT
4746fd5c2c1322 Chris Wilson   2020-02-10  231  	 * then we can't be too greedy.
4746fd5c2c1322 Chris Wilson   2020-02-10  232  	 */
4746fd5c2c1322 Chris Wilson   2020-02-10 @233  	max = ce->vm->total;
4746fd5c2c1322 Chris Wilson   2020-02-10  234  	if (i915_is_ggtt(ce->vm) || thread->ctx)
4746fd5c2c1322 Chris Wilson   2020-02-10  235  		max = div_u64(max, thread->n_cpus);
4746fd5c2c1322 Chris Wilson   2020-02-10  236  	max >>= 4;
4746fd5c2c1322 Chris Wilson   2020-02-10  237  
4746fd5c2c1322 Chris Wilson   2020-02-10  238  	total = PAGE_SIZE;
6501aa4e3a4507 Matthew Auld   2019-05-29  239  	do {
4746fd5c2c1322 Chris Wilson   2020-02-10  240  		/* Aim to keep the runtime under reasonable bounds! */
4746fd5c2c1322 Chris Wilson   2020-02-10  241  		const u32 max_phys_size = SZ_64K;
0e99f939f08fc3 Matthew Auld   2019-10-25  242  		u32 val = prandom_u32_state(prng);
0e99f939f08fc3 Matthew Auld   2019-10-25  243  		u32 phys_sz;
0e99f939f08fc3 Matthew Auld   2019-10-25  244  		u32 sz;
0e99f939f08fc3 Matthew Auld   2019-10-25  245  		u32 *vaddr;
6501aa4e3a4507 Matthew Auld   2019-05-29  246  		u32 i;
6501aa4e3a4507 Matthew Auld   2019-05-29  247  
4746fd5c2c1322 Chris Wilson   2020-02-10  248  		total = min(total, max);
4746fd5c2c1322 Chris Wilson   2020-02-10  249  		sz = i915_prandom_u32_max_state(total, prng) + 1;
c8b56cd01433af Chris Wilson   2020-02-12  250  		phys_sz = sz % max_phys_size + 1;
0e99f939f08fc3 Matthew Auld   2019-10-25  251  
6501aa4e3a4507 Matthew Auld   2019-05-29  252  		sz = round_up(sz, PAGE_SIZE);
554e330ceb9f00 Matthew Auld   2019-08-10  253  		phys_sz = round_up(phys_sz, PAGE_SIZE);
c8b56cd01433af Chris Wilson   2020-02-12  254  		phys_sz = min(phys_sz, sz);
6501aa4e3a4507 Matthew Auld   2019-05-29  255  
554e330ceb9f00 Matthew Auld   2019-08-10  256  		pr_debug("%s with phys_sz= %x, sz=%x, val=%x\n", __func__,
554e330ceb9f00 Matthew Auld   2019-08-10  257  			 phys_sz, sz, val);
6501aa4e3a4507 Matthew Auld   2019-05-29  258  
d61345f342981f Chris Wilson   2020-06-04  259  		obj = huge_gem_object(engine->i915, phys_sz, sz);
6501aa4e3a4507 Matthew Auld   2019-05-29  260  		if (IS_ERR(obj)) {
fd1e194f4869dc Colin Ian King 2019-05-31  261  			err = PTR_ERR(obj);
6501aa4e3a4507 Matthew Auld   2019-05-29  262  			goto err_flush;
6501aa4e3a4507 Matthew Auld   2019-05-29  263  		}
6501aa4e3a4507 Matthew Auld   2019-05-29  264  
6501aa4e3a4507 Matthew Auld   2019-05-29  265  		vaddr = i915_gem_object_pin_map(obj, I915_MAP_WB);
6501aa4e3a4507 Matthew Auld   2019-05-29  266  		if (IS_ERR(vaddr)) {
6501aa4e3a4507 Matthew Auld   2019-05-29  267  			err = PTR_ERR(vaddr);
6501aa4e3a4507 Matthew Auld   2019-05-29  268  			goto err_put;
6501aa4e3a4507 Matthew Auld   2019-05-29  269  		}
6501aa4e3a4507 Matthew Auld   2019-05-29  270  
6501aa4e3a4507 Matthew Auld   2019-05-29  271  		/*
6501aa4e3a4507 Matthew Auld   2019-05-29  272  		 * Make sure the potentially async clflush does its job, if
6501aa4e3a4507 Matthew Auld   2019-05-29  273  		 * required.
6501aa4e3a4507 Matthew Auld   2019-05-29  274  		 */
554e330ceb9f00 Matthew Auld   2019-08-10  275  		memset32(vaddr, val ^ 0xdeadbeaf,
554e330ceb9f00 Matthew Auld   2019-08-10  276  			 huge_gem_object_phys_size(obj) / sizeof(u32));
6501aa4e3a4507 Matthew Auld   2019-05-29  277  
6501aa4e3a4507 Matthew Auld   2019-05-29  278  		if (!(obj->cache_coherent & I915_BO_CACHE_COHERENT_FOR_WRITE))
6501aa4e3a4507 Matthew Auld   2019-05-29  279  			obj->cache_dirty = true;
6501aa4e3a4507 Matthew Auld   2019-05-29  280  
6501aa4e3a4507 Matthew Auld   2019-05-29  281  		err = i915_gem_object_fill_blt(obj, ce, val);
6501aa4e3a4507 Matthew Auld   2019-05-29  282  		if (err)
6501aa4e3a4507 Matthew Auld   2019-05-29  283  			goto err_unpin;
6501aa4e3a4507 Matthew Auld   2019-05-29  284  
4746fd5c2c1322 Chris Wilson   2020-02-10  285  		err = i915_gem_object_wait(obj, 0, MAX_SCHEDULE_TIMEOUT);
6501aa4e3a4507 Matthew Auld   2019-05-29  286  		if (err)
6501aa4e3a4507 Matthew Auld   2019-05-29  287  			goto err_unpin;
6501aa4e3a4507 Matthew Auld   2019-05-29  288  
4746fd5c2c1322 Chris Wilson   2020-02-10  289  		for (i = 0; i < huge_gem_object_phys_size(obj) / sizeof(u32); i += 17) {
4746fd5c2c1322 Chris Wilson   2020-02-10  290  			if (!(obj->cache_coherent & I915_BO_CACHE_COHERENT_FOR_READ))
4746fd5c2c1322 Chris Wilson   2020-02-10  291  				drm_clflush_virt_range(&vaddr[i], sizeof(vaddr[i]));
4746fd5c2c1322 Chris Wilson   2020-02-10  292  
6501aa4e3a4507 Matthew Auld   2019-05-29  293  			if (vaddr[i] != val) {
6501aa4e3a4507 Matthew Auld   2019-05-29  294  				pr_err("vaddr[%u]=%x, expected=%x\n", i,
6501aa4e3a4507 Matthew Auld   2019-05-29  295  				       vaddr[i], val);
6501aa4e3a4507 Matthew Auld   2019-05-29  296  				err = -EINVAL;
6501aa4e3a4507 Matthew Auld   2019-05-29  297  				goto err_unpin;
6501aa4e3a4507 Matthew Auld   2019-05-29  298  			}
6501aa4e3a4507 Matthew Auld   2019-05-29  299  		}
6501aa4e3a4507 Matthew Auld   2019-05-29  300  
6501aa4e3a4507 Matthew Auld   2019-05-29  301  		i915_gem_object_unpin_map(obj);
6501aa4e3a4507 Matthew Auld   2019-05-29  302  		i915_gem_object_put(obj);
4746fd5c2c1322 Chris Wilson   2020-02-10  303  
4746fd5c2c1322 Chris Wilson   2020-02-10  304  		total <<= 1;
6501aa4e3a4507 Matthew Auld   2019-05-29  305  	} while (!time_after(jiffies, end));
6501aa4e3a4507 Matthew Auld   2019-05-29  306  
6501aa4e3a4507 Matthew Auld   2019-05-29  307  	goto err_flush;
6501aa4e3a4507 Matthew Auld   2019-05-29  308  
6501aa4e3a4507 Matthew Auld   2019-05-29  309  err_unpin:
6501aa4e3a4507 Matthew Auld   2019-05-29  310  	i915_gem_object_unpin_map(obj);
6501aa4e3a4507 Matthew Auld   2019-05-29  311  err_put:
6501aa4e3a4507 Matthew Auld   2019-05-29  312  	i915_gem_object_put(obj);
6501aa4e3a4507 Matthew Auld   2019-05-29  313  err_flush:
6501aa4e3a4507 Matthew Auld   2019-05-29  314  	if (err == -ENOMEM)
6501aa4e3a4507 Matthew Auld   2019-05-29  315  		err = 0;
6501aa4e3a4507 Matthew Auld   2019-05-29  316  
0e99f939f08fc3 Matthew Auld   2019-10-25  317  	intel_context_put(ce);
6501aa4e3a4507 Matthew Auld   2019-05-29  318  	return err;
6501aa4e3a4507 Matthew Auld   2019-05-29  319  }
6501aa4e3a4507 Matthew Auld   2019-05-29  320  
0e99f939f08fc3 Matthew Auld   2019-10-25  321  static int igt_copy_blt_thread(void *arg)
05f219d709ec57 Matthew Auld   2019-08-10  322  {
0e99f939f08fc3 Matthew Auld   2019-10-25  323  	struct igt_thread_arg *thread = arg;
d61345f342981f Chris Wilson   2020-06-04  324  	struct intel_engine_cs *engine = thread->engine;
0e99f939f08fc3 Matthew Auld   2019-10-25  325  	struct rnd_state *prng = &thread->prng;
05f219d709ec57 Matthew Auld   2019-08-10  326  	struct drm_i915_gem_object *src, *dst;
0e99f939f08fc3 Matthew Auld   2019-10-25  327  	struct i915_gem_context *ctx;
0e99f939f08fc3 Matthew Auld   2019-10-25  328  	struct intel_context *ce;
0e99f939f08fc3 Matthew Auld   2019-10-25  329  	unsigned int prio;
05f219d709ec57 Matthew Auld   2019-08-10  330  	IGT_TIMEOUT(end);
4746fd5c2c1322 Chris Wilson   2020-02-10  331  	u64 total, max;
0e99f939f08fc3 Matthew Auld   2019-10-25  332  	int err;
05f219d709ec57 Matthew Auld   2019-08-10  333  
34485832cb9872 Chris Wilson   2019-11-11  334  	ctx = thread->ctx;
34485832cb9872 Chris Wilson   2019-11-11  335  	if (!ctx) {
d61345f342981f Chris Wilson   2020-06-04  336  		ctx = live_context_for_engine(engine, thread->file);
34485832cb9872 Chris Wilson   2019-11-11  337  		if (IS_ERR(ctx))
34485832cb9872 Chris Wilson   2019-11-11  338  			return PTR_ERR(ctx);
0e99f939f08fc3 Matthew Auld   2019-10-25  339  
0e99f939f08fc3 Matthew Auld   2019-10-25  340  		prio = i915_prandom_u32_max_state(I915_PRIORITY_MAX, prng);
0e99f939f08fc3 Matthew Auld   2019-10-25  341  		ctx->sched.priority = I915_USER_PRIORITY(prio);
34485832cb9872 Chris Wilson   2019-11-11  342  	}
0e99f939f08fc3 Matthew Auld   2019-10-25  343  
d61345f342981f Chris Wilson   2020-06-04  344  	ce = i915_gem_context_get_engine(ctx, 0);
0e99f939f08fc3 Matthew Auld   2019-10-25  345  	GEM_BUG_ON(IS_ERR(ce));
05f219d709ec57 Matthew Auld   2019-08-10  346  
4746fd5c2c1322 Chris Wilson   2020-02-10  347  	/*
4746fd5c2c1322 Chris Wilson   2020-02-10  348  	 * If we have a tiny shared address space, like for the GGTT
4746fd5c2c1322 Chris Wilson   2020-02-10  349  	 * then we can't be too greedy.
4746fd5c2c1322 Chris Wilson   2020-02-10  350  	 */
4746fd5c2c1322 Chris Wilson   2020-02-10 @351  	max = ce->vm->total;
4746fd5c2c1322 Chris Wilson   2020-02-10  352  	if (i915_is_ggtt(ce->vm) || thread->ctx)
4746fd5c2c1322 Chris Wilson   2020-02-10  353  		max = div_u64(max, thread->n_cpus);
4746fd5c2c1322 Chris Wilson   2020-02-10  354  	max >>= 4;
4746fd5c2c1322 Chris Wilson   2020-02-10  355  
4746fd5c2c1322 Chris Wilson   2020-02-10  356  	total = PAGE_SIZE;
05f219d709ec57 Matthew Auld   2019-08-10  357  	do {
4746fd5c2c1322 Chris Wilson   2020-02-10  358  		/* Aim to keep the runtime under reasonable bounds! */
4746fd5c2c1322 Chris Wilson   2020-02-10  359  		const u32 max_phys_size = SZ_64K;
0e99f939f08fc3 Matthew Auld   2019-10-25  360  		u32 val = prandom_u32_state(prng);
0e99f939f08fc3 Matthew Auld   2019-10-25  361  		u32 phys_sz;
0e99f939f08fc3 Matthew Auld   2019-10-25  362  		u32 sz;
0e99f939f08fc3 Matthew Auld   2019-10-25  363  		u32 *vaddr;
05f219d709ec57 Matthew Auld   2019-08-10  364  		u32 i;
05f219d709ec57 Matthew Auld   2019-08-10  365  
4746fd5c2c1322 Chris Wilson   2020-02-10  366  		total = min(total, max);
4746fd5c2c1322 Chris Wilson   2020-02-10  367  		sz = i915_prandom_u32_max_state(total, prng) + 1;
c8b56cd01433af Chris Wilson   2020-02-12  368  		phys_sz = sz % max_phys_size + 1;
0e99f939f08fc3 Matthew Auld   2019-10-25  369  
05f219d709ec57 Matthew Auld   2019-08-10  370  		sz = round_up(sz, PAGE_SIZE);
05f219d709ec57 Matthew Auld   2019-08-10  371  		phys_sz = round_up(phys_sz, PAGE_SIZE);
c8b56cd01433af Chris Wilson   2020-02-12  372  		phys_sz = min(phys_sz, sz);
05f219d709ec57 Matthew Auld   2019-08-10  373  
05f219d709ec57 Matthew Auld   2019-08-10  374  		pr_debug("%s with phys_sz= %x, sz=%x, val=%x\n", __func__,
05f219d709ec57 Matthew Auld   2019-08-10  375  			 phys_sz, sz, val);
05f219d709ec57 Matthew Auld   2019-08-10  376  
d61345f342981f Chris Wilson   2020-06-04  377  		src = huge_gem_object(engine->i915, phys_sz, sz);
05f219d709ec57 Matthew Auld   2019-08-10  378  		if (IS_ERR(src)) {
05f219d709ec57 Matthew Auld   2019-08-10  379  			err = PTR_ERR(src);
05f219d709ec57 Matthew Auld   2019-08-10  380  			goto err_flush;
05f219d709ec57 Matthew Auld   2019-08-10  381  		}
05f219d709ec57 Matthew Auld   2019-08-10  382  
05f219d709ec57 Matthew Auld   2019-08-10  383  		vaddr = i915_gem_object_pin_map(src, I915_MAP_WB);
05f219d709ec57 Matthew Auld   2019-08-10  384  		if (IS_ERR(vaddr)) {
05f219d709ec57 Matthew Auld   2019-08-10  385  			err = PTR_ERR(vaddr);
05f219d709ec57 Matthew Auld   2019-08-10  386  			goto err_put_src;
05f219d709ec57 Matthew Auld   2019-08-10  387  		}
05f219d709ec57 Matthew Auld   2019-08-10  388  
05f219d709ec57 Matthew Auld   2019-08-10  389  		memset32(vaddr, val,
05f219d709ec57 Matthew Auld   2019-08-10  390  			 huge_gem_object_phys_size(src) / sizeof(u32));
05f219d709ec57 Matthew Auld   2019-08-10  391  
05f219d709ec57 Matthew Auld   2019-08-10  392  		i915_gem_object_unpin_map(src);
05f219d709ec57 Matthew Auld   2019-08-10  393  
05f219d709ec57 Matthew Auld   2019-08-10  394  		if (!(src->cache_coherent & I915_BO_CACHE_COHERENT_FOR_READ))
05f219d709ec57 Matthew Auld   2019-08-10  395  			src->cache_dirty = true;
05f219d709ec57 Matthew Auld   2019-08-10  396  
d61345f342981f Chris Wilson   2020-06-04  397  		dst = huge_gem_object(engine->i915, phys_sz, sz);
05f219d709ec57 Matthew Auld   2019-08-10  398  		if (IS_ERR(dst)) {
05f219d709ec57 Matthew Auld   2019-08-10  399  			err = PTR_ERR(dst);
05f219d709ec57 Matthew Auld   2019-08-10  400  			goto err_put_src;
05f219d709ec57 Matthew Auld   2019-08-10  401  		}
05f219d709ec57 Matthew Auld   2019-08-10  402  
05f219d709ec57 Matthew Auld   2019-08-10  403  		vaddr = i915_gem_object_pin_map(dst, I915_MAP_WB);
05f219d709ec57 Matthew Auld   2019-08-10  404  		if (IS_ERR(vaddr)) {
05f219d709ec57 Matthew Auld   2019-08-10  405  			err = PTR_ERR(vaddr);
05f219d709ec57 Matthew Auld   2019-08-10  406  			goto err_put_dst;
05f219d709ec57 Matthew Auld   2019-08-10  407  		}
05f219d709ec57 Matthew Auld   2019-08-10  408  
05f219d709ec57 Matthew Auld   2019-08-10  409  		memset32(vaddr, val ^ 0xdeadbeaf,
05f219d709ec57 Matthew Auld   2019-08-10  410  			 huge_gem_object_phys_size(dst) / sizeof(u32));
05f219d709ec57 Matthew Auld   2019-08-10  411  
05f219d709ec57 Matthew Auld   2019-08-10  412  		if (!(dst->cache_coherent & I915_BO_CACHE_COHERENT_FOR_WRITE))
05f219d709ec57 Matthew Auld   2019-08-10  413  			dst->cache_dirty = true;
05f219d709ec57 Matthew Auld   2019-08-10  414  
05f219d709ec57 Matthew Auld   2019-08-10  415  		err = i915_gem_object_copy_blt(src, dst, ce);
05f219d709ec57 Matthew Auld   2019-08-10  416  		if (err)
05f219d709ec57 Matthew Auld   2019-08-10  417  			goto err_unpin;
05f219d709ec57 Matthew Auld   2019-08-10  418  
4746fd5c2c1322 Chris Wilson   2020-02-10  419  		err = i915_gem_object_wait(dst, 0, MAX_SCHEDULE_TIMEOUT);
05f219d709ec57 Matthew Auld   2019-08-10  420  		if (err)
05f219d709ec57 Matthew Auld   2019-08-10  421  			goto err_unpin;
05f219d709ec57 Matthew Auld   2019-08-10  422  
4746fd5c2c1322 Chris Wilson   2020-02-10  423  		for (i = 0; i < huge_gem_object_phys_size(dst) / sizeof(u32); i += 17) {
4746fd5c2c1322 Chris Wilson   2020-02-10  424  			if (!(dst->cache_coherent & I915_BO_CACHE_COHERENT_FOR_READ))
4746fd5c2c1322 Chris Wilson   2020-02-10  425  				drm_clflush_virt_range(&vaddr[i], sizeof(vaddr[i]));
4746fd5c2c1322 Chris Wilson   2020-02-10  426  
05f219d709ec57 Matthew Auld   2019-08-10  427  			if (vaddr[i] != val) {
05f219d709ec57 Matthew Auld   2019-08-10  428  				pr_err("vaddr[%u]=%x, expected=%x\n", i,
05f219d709ec57 Matthew Auld   2019-08-10  429  				       vaddr[i], val);
05f219d709ec57 Matthew Auld   2019-08-10  430  				err = -EINVAL;
05f219d709ec57 Matthew Auld   2019-08-10  431  				goto err_unpin;
05f219d709ec57 Matthew Auld   2019-08-10  432  			}
05f219d709ec57 Matthew Auld   2019-08-10  433  		}
05f219d709ec57 Matthew Auld   2019-08-10  434  
05f219d709ec57 Matthew Auld   2019-08-10  435  		i915_gem_object_unpin_map(dst);
05f219d709ec57 Matthew Auld   2019-08-10  436  
05f219d709ec57 Matthew Auld   2019-08-10  437  		i915_gem_object_put(src);
05f219d709ec57 Matthew Auld   2019-08-10  438  		i915_gem_object_put(dst);
4746fd5c2c1322 Chris Wilson   2020-02-10  439  
4746fd5c2c1322 Chris Wilson   2020-02-10  440  		total <<= 1;
05f219d709ec57 Matthew Auld   2019-08-10  441  	} while (!time_after(jiffies, end));
05f219d709ec57 Matthew Auld   2019-08-10  442  
05f219d709ec57 Matthew Auld   2019-08-10  443  	goto err_flush;
05f219d709ec57 Matthew Auld   2019-08-10  444  
05f219d709ec57 Matthew Auld   2019-08-10  445  err_unpin:
05f219d709ec57 Matthew Auld   2019-08-10  446  	i915_gem_object_unpin_map(dst);
05f219d709ec57 Matthew Auld   2019-08-10  447  err_put_dst:
05f219d709ec57 Matthew Auld   2019-08-10  448  	i915_gem_object_put(dst);
05f219d709ec57 Matthew Auld   2019-08-10  449  err_put_src:
05f219d709ec57 Matthew Auld   2019-08-10  450  	i915_gem_object_put(src);
05f219d709ec57 Matthew Auld   2019-08-10  451  err_flush:
05f219d709ec57 Matthew Auld   2019-08-10  452  	if (err == -ENOMEM)
05f219d709ec57 Matthew Auld   2019-08-10  453  		err = 0;
05f219d709ec57 Matthew Auld   2019-08-10  454  
0e99f939f08fc3 Matthew Auld   2019-10-25  455  	intel_context_put(ce);
05f219d709ec57 Matthew Auld   2019-08-10  456  	return err;
05f219d709ec57 Matthew Auld   2019-08-10  457  }
05f219d709ec57 Matthew Auld   2019-08-10  458  

:::::: The code at line 233 was first introduced by commit
:::::: 4746fd5c2c132225bdd817ddf04e8454e872f8c2 drm/i915/selftests: Trim blitter block size

:::::: TO: Chris Wilson <chris@chris-wilson.co.uk>
:::::: CC: Chris Wilson <chris@chris-wilson.co.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--gBBFr7Ir9EOA20Yy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gBBFr7Ir9EOA20Yy--
