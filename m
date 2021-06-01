Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B763739721C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 13:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhFALKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 07:10:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:9792 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231219AbhFALKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 07:10:41 -0400
IronPort-SDR: FXTQtpLkvgKZ52ooIFZeiJA8wNnYwc0QmV7iPuz4Gh0d5KLsRZL6WUzlCt4OnQUTPyM+KW6A9r
 5+FdEj1E2ecw==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="224797822"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="gz'50?scan'50,208,50";a="224797822"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 04:08:59 -0700
IronPort-SDR: 9Bg5crH13RHduebID1EDzawA+zeRWcah0yyzPVED11ba5j8BxDJUkLNXsshbeBM2GNhahEEog+
 rFVUxdTDND0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="gz'50?scan'50,208,50";a="445293798"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 01 Jun 2021 04:08:55 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lo2GV-0005D9-0p; Tue, 01 Jun 2021 11:08:55 +0000
Date:   Tue, 1 Jun 2021 19:08:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v8] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <202106011959.5wcQP2E6-lkp@intel.com>
References: <1622542057-14632-1-git-send-email-faiyazm@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <1622542057-14632-1-git-send-email-faiyazm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Faiyaz,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.13-rc4]
[cannot apply to hnaz-linux-mm/master next-20210601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Faiyaz-Mohammed/mm-slub-move-sysfs-slab-alloc-free-interfaces-to-debugfs/20210601-180903
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c2131f7e73c9e9365613e323d65c7b9e5b910f56
config: i386-tinyconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/9540acc4691d680b7124d8daa1a2eb98a97ee19a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Faiyaz-Mohammed/mm-slub-move-sysfs-slab-alloc-free-interfaces-to-debugfs/20210601-180903
        git checkout 9540acc4691d680b7124d8daa1a2eb98a97ee19a
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/slab_common.c: In function 'slab_caches_to_rcu_destroy_workfn':
>> mm/slab_common.c:452:3: error: implicit declaration of function 'debugfs_slab_release' [-Werror=implicit-function-declaration]
     452 |   debugfs_slab_release(s);
         |   ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/debugfs_slab_release +452 mm/slab_common.c

   427	
   428	static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
   429	{
   430		LIST_HEAD(to_destroy);
   431		struct kmem_cache *s, *s2;
   432	
   433		/*
   434		 * On destruction, SLAB_TYPESAFE_BY_RCU kmem_caches are put on the
   435		 * @slab_caches_to_rcu_destroy list.  The slab pages are freed
   436		 * through RCU and the associated kmem_cache are dereferenced
   437		 * while freeing the pages, so the kmem_caches should be freed only
   438		 * after the pending RCU operations are finished.  As rcu_barrier()
   439		 * is a pretty slow operation, we batch all pending destructions
   440		 * asynchronously.
   441		 */
   442		mutex_lock(&slab_mutex);
   443		list_splice_init(&slab_caches_to_rcu_destroy, &to_destroy);
   444		mutex_unlock(&slab_mutex);
   445	
   446		if (list_empty(&to_destroy))
   447			return;
   448	
   449		rcu_barrier();
   450	
   451		list_for_each_entry_safe(s, s2, &to_destroy, list) {
 > 452			debugfs_slab_release(s);
   453			kfence_shutdown_cache(s);
   454	#ifdef SLAB_SUPPORTS_SYSFS
   455			sysfs_slab_release(s);
   456	#else
   457			slab_kmem_cache_release(s);
   458	#endif
   459		}
   460	}
   461	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--M9NhX3UHpAaciwkO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
OtggvU1+vTH3H4bfuk9DawAA

--M9NhX3UHpAaciwkO--
