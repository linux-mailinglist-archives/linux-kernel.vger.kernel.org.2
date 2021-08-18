Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BBF3F0868
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbhHRPt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:49:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:54262 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237755AbhHRPtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:49:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="216391659"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="gz'50?scan'50,208,50";a="216391659"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 08:45:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="gz'50?scan'50,208,50";a="511279902"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2021 08:45:34 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGNkz-000T5b-I1; Wed, 18 Aug 2021 15:45:33 +0000
Date:   Wed, 18 Aug 2021 23:44:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:perf/core 7/8] arch/x86/events/amd/ibs.c:829:5: error:
 redefinition of 'get_ibs_caps'
Message-ID: <202108182341.z6digIOK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kim,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
head:   0b8f94ea282357a79781d10024708c2cf0ff5305
commit: 10684f2b277c733c018c5d07ddb4aa980ba4fcc5 [7/8] perf/amd/uncore: Allow the driver to be built as a module
config: i386-tinyconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=10684f2b277c733c018c5d07ddb4aa980ba4fcc5
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/core
        git checkout 10684f2b277c733c018c5d07ddb4aa980ba4fcc5
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/events/amd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/events/amd/ibs.c:829:5: error: redefinition of 'get_ibs_caps'
     829 | u32 get_ibs_caps(void)
         |     ^~~~~~~~~~~~
   In file included from include/linux/perf_event.h:25,
                    from arch/x86/events/amd/ibs.c:9:
   arch/x86/include/asm/perf_event.h:426:19: note: previous definition of 'get_ibs_caps' was here
     426 | static inline u32 get_ibs_caps(void) { return 0; }
         |                   ^~~~~~~~~~~~
   arch/x86/events/amd/ibs.c: In function 'get_eilvt':
>> arch/x86/events/amd/ibs.c:838:10: error: implicit declaration of function 'setup_APIC_eilvt' [-Werror=implicit-function-declaration]
     838 |  return !setup_APIC_eilvt(offset, 0, APIC_EILVT_MSG_NMI, 1);
         |          ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/get_ibs_caps +829 arch/x86/events/amd/ibs.c

b716916679e720 arch/x86/kernel/cpu/perf_event_amd_ibs.c Robert Richter 2011-09-21  828  
b716916679e720 arch/x86/kernel/cpu/perf_event_amd_ibs.c Robert Richter 2011-09-21 @829  u32 get_ibs_caps(void)
b716916679e720 arch/x86/kernel/cpu/perf_event_amd_ibs.c Robert Richter 2011-09-21  830  {
b716916679e720 arch/x86/kernel/cpu/perf_event_amd_ibs.c Robert Richter 2011-09-21  831  	return ibs_caps;
b716916679e720 arch/x86/kernel/cpu/perf_event_amd_ibs.c Robert Richter 2011-09-21  832  }
b716916679e720 arch/x86/kernel/cpu/perf_event_amd_ibs.c Robert Richter 2011-09-21  833  
b716916679e720 arch/x86/kernel/cpu/perf_event_amd_ibs.c Robert Richter 2011-09-21  834  EXPORT_SYMBOL(get_ibs_caps);
b716916679e720 arch/x86/kernel/cpu/perf_event_amd_ibs.c Robert Richter 2011-09-21  835  
b716916679e720 arch/x86/kernel/cpu/perf_event_amd_ibs.c Robert Richter 2011-09-21  836  static inline int get_eilvt(int offset)
b716916679e720 arch/x86/kernel/cpu/perf_event_amd_ibs.c Robert Richter 2011-09-21  837  {
b716916679e720 arch/x86/kernel/cpu/perf_event_amd_ibs.c Robert Richter 2011-09-21 @838  	return !setup_APIC_eilvt(offset, 0, APIC_EILVT_MSG_NMI, 1);
b716916679e720 arch/x86/kernel/cpu/perf_event_amd_ibs.c Robert Richter 2011-09-21  839  }
b716916679e720 arch/x86/kernel/cpu/perf_event_amd_ibs.c Robert Richter 2011-09-21  840  

:::::: The code at line 829 was first introduced by commit
:::::: b716916679e72054d436afadce2f94dcad71cfad perf, x86: Implement IBS initialization

:::::: TO: Robert Richter <robert.richter@amd.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ibTvN161/egqYuK8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
1K7CXGId6GCH9A759cHcfyKmS8hjawAA

--ibTvN161/egqYuK8--
