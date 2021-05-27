Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23621392FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbhE0NmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:42:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:7121 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236007AbhE0NmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:42:16 -0400
IronPort-SDR: MRPR46rFCf+ZfIRRoiY+rwzZbvXMQMkT8NnSQWqb2JirlatVHDPE9fasF4NJCVTpNKxCgJLSdA
 Ldz8Tj3py4Hg==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202498695"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="gz'50?scan'50,208,50";a="202498695"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 06:40:43 -0700
IronPort-SDR: BeT847io7I1eF1Rf5AQqcDXfpOPmcjvrv89rB79AuSy42r0I27dcZ8Z+b3PF1YDC3fm9wbqsb/
 lBrR9dKhRhjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="gz'50?scan'50,208,50";a="445019057"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 27 May 2021 06:40:40 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lmGFc-0002nI-3X; Thu, 27 May 2021 13:40:40 +0000
Date:   Thu, 27 May 2021 21:40:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        odin@uged.al
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 1/2] sched/fair: keep load_avg and load_sum synced
Message-ID: <202105272107.27aKS18U-lkp@intel.com>
References: <20210527122916.27683-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20210527122916.27683-2-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Vincent,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on tip/master linux/master linus/master v5.13-rc3 next-20210527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Vincent-Guittot/schd-fair-fix-stalled-cfs_rq-tg_load_avg_contrib/20210527-203115
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a8ea6fc9b089156d9230bfeef964dd9be101a4a9
config: s390-randconfig-c024-20210527 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/725167b3ef5a796c98add27cb21e543c7b72cf0e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Vincent-Guittot/schd-fair-fix-stalled-cfs_rq-tg_load_avg_contrib/20210527-203115
        git checkout 725167b3ef5a796c98add27cb21e543c7b72cf0e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'update_tg_cfs_load':
>> kernel/sched/fair.c:3459:6: warning: variable 'delta_sum' set but not used [-Wunused-but-set-variable]
    3459 |  s64 delta_sum;
         |      ^~~~~~~~~


vim +/delta_sum +3459 kernel/sched/fair.c

9f68395333ad7f Vincent Guittot 2020-02-24  3452  
09a43ace1f986b Vincent Guittot 2016-11-08  3453  static inline void
0dacee1bfa70e1 Vincent Guittot 2020-02-24  3454  update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
09a43ace1f986b Vincent Guittot 2016-11-08  3455  {
a4c3c04974d648 Vincent Guittot 2017-11-16  3456  	long delta_avg, running_sum, runnable_sum = gcfs_rq->prop_runnable_sum;
0dacee1bfa70e1 Vincent Guittot 2020-02-24  3457  	unsigned long load_avg;
0dacee1bfa70e1 Vincent Guittot 2020-02-24  3458  	u64 load_sum = 0;
a4c3c04974d648 Vincent Guittot 2017-11-16 @3459  	s64 delta_sum;
95d685935a2edf Vincent Guittot 2020-05-06  3460  	u32 divider;
09a43ace1f986b Vincent Guittot 2016-11-08  3461  
0e2d2aaaae52c2 Peter Zijlstra  2017-05-08  3462  	if (!runnable_sum)
0e2d2aaaae52c2 Peter Zijlstra  2017-05-08  3463  		return;
09a43ace1f986b Vincent Guittot 2016-11-08  3464  
0e2d2aaaae52c2 Peter Zijlstra  2017-05-08  3465  	gcfs_rq->prop_runnable_sum = 0;
09a43ace1f986b Vincent Guittot 2016-11-08  3466  
95d685935a2edf Vincent Guittot 2020-05-06  3467  	/*
95d685935a2edf Vincent Guittot 2020-05-06  3468  	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
95d685935a2edf Vincent Guittot 2020-05-06  3469  	 * See ___update_load_avg() for details.
95d685935a2edf Vincent Guittot 2020-05-06  3470  	 */
87e867b4269f29 Vincent Guittot 2020-06-12  3471  	divider = get_pelt_divider(&cfs_rq->avg);
95d685935a2edf Vincent Guittot 2020-05-06  3472  
a4c3c04974d648 Vincent Guittot 2017-11-16  3473  	if (runnable_sum >= 0) {
a4c3c04974d648 Vincent Guittot 2017-11-16  3474  		/*
a4c3c04974d648 Vincent Guittot 2017-11-16  3475  		 * Add runnable; clip at LOAD_AVG_MAX. Reflects that until
a4c3c04974d648 Vincent Guittot 2017-11-16  3476  		 * the CPU is saturated running == runnable.
a4c3c04974d648 Vincent Guittot 2017-11-16  3477  		 */
a4c3c04974d648 Vincent Guittot 2017-11-16  3478  		runnable_sum += se->avg.load_sum;
95d685935a2edf Vincent Guittot 2020-05-06  3479  		runnable_sum = min_t(long, runnable_sum, divider);
a4c3c04974d648 Vincent Guittot 2017-11-16  3480  	} else {
a4c3c04974d648 Vincent Guittot 2017-11-16  3481  		/*
a4c3c04974d648 Vincent Guittot 2017-11-16  3482  		 * Estimate the new unweighted runnable_sum of the gcfs_rq by
a4c3c04974d648 Vincent Guittot 2017-11-16  3483  		 * assuming all tasks are equally runnable.
a4c3c04974d648 Vincent Guittot 2017-11-16  3484  		 */
a4c3c04974d648 Vincent Guittot 2017-11-16  3485  		if (scale_load_down(gcfs_rq->load.weight)) {
a4c3c04974d648 Vincent Guittot 2017-11-16  3486  			load_sum = div_s64(gcfs_rq->avg.load_sum,
a4c3c04974d648 Vincent Guittot 2017-11-16  3487  				scale_load_down(gcfs_rq->load.weight));
a4c3c04974d648 Vincent Guittot 2017-11-16  3488  		}
a4c3c04974d648 Vincent Guittot 2017-11-16  3489  
a4c3c04974d648 Vincent Guittot 2017-11-16  3490  		/* But make sure to not inflate se's runnable */
a4c3c04974d648 Vincent Guittot 2017-11-16  3491  		runnable_sum = min(se->avg.load_sum, load_sum);
a4c3c04974d648 Vincent Guittot 2017-11-16  3492  	}
a4c3c04974d648 Vincent Guittot 2017-11-16  3493  
a4c3c04974d648 Vincent Guittot 2017-11-16  3494  	/*
a4c3c04974d648 Vincent Guittot 2017-11-16  3495  	 * runnable_sum can't be lower than running_sum
23127296889fe8 Vincent Guittot 2019-01-23  3496  	 * Rescale running sum to be in the same range as runnable sum
23127296889fe8 Vincent Guittot 2019-01-23  3497  	 * running_sum is in [0 : LOAD_AVG_MAX <<  SCHED_CAPACITY_SHIFT]
23127296889fe8 Vincent Guittot 2019-01-23  3498  	 * runnable_sum is in [0 : LOAD_AVG_MAX]
a4c3c04974d648 Vincent Guittot 2017-11-16  3499  	 */
23127296889fe8 Vincent Guittot 2019-01-23  3500  	running_sum = se->avg.util_sum >> SCHED_CAPACITY_SHIFT;
a4c3c04974d648 Vincent Guittot 2017-11-16  3501  	runnable_sum = max(runnable_sum, running_sum);
a4c3c04974d648 Vincent Guittot 2017-11-16  3502  
0e2d2aaaae52c2 Peter Zijlstra  2017-05-08  3503  	load_sum = (s64)se_weight(se) * runnable_sum;
95d685935a2edf Vincent Guittot 2020-05-06  3504  	load_avg = div_s64(load_sum, divider);
09a43ace1f986b Vincent Guittot 2016-11-08  3505  
a4c3c04974d648 Vincent Guittot 2017-11-16  3506  	delta_sum = load_sum - (s64)se_weight(se) * se->avg.load_sum;
a4c3c04974d648 Vincent Guittot 2017-11-16  3507  	delta_avg = load_avg - se->avg.load_avg;
09a43ace1f986b Vincent Guittot 2016-11-08  3508  
a4c3c04974d648 Vincent Guittot 2017-11-16  3509  	se->avg.load_sum = runnable_sum;
a4c3c04974d648 Vincent Guittot 2017-11-16  3510  	se->avg.load_avg = load_avg;
a4c3c04974d648 Vincent Guittot 2017-11-16  3511  	add_positive(&cfs_rq->avg.load_avg, delta_avg);
725167b3ef5a79 Vincent Guittot 2021-05-27  3512  	cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;
725167b3ef5a79 Vincent Guittot 2021-05-27  3513  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qAu4/wEzMyuVRPAAAA==

--VbJkn9YxBvnuCH5J--
