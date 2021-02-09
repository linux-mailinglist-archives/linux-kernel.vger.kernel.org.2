Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A293150BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhBINsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:48:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:21819 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231496AbhBINqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:46:39 -0500
IronPort-SDR: Zcb5x47M44OH7UiAgT+atTBR8ahN0l456JYmTzsiY6w0QozIWvEl6zwSFQzY+EJZQ8Ob8Iyje3
 9HzcVSdWqqGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="266714842"
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="266714842"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 05:44:53 -0800
IronPort-SDR: K5mgQptzIDhEIUYR4BWL9GK34qH+yj5BbANCpPZjKMs54EFp8Tmq1u19iqR1vwh+6OWvAIlg03
 NA0Yx/THSyuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="436121377"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 09 Feb 2021 05:44:53 -0800
Received: from [10.251.23.108] (kliang2-MOBL.ccr.corp.intel.com [10.251.23.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C9C5258088F;
        Tue,  9 Feb 2021 05:44:51 -0800 (PST)
Subject: Re: [PATCH 23/49] perf/x86/msr: Add Alder Lake CPU support
To:     kernel test robot <lkp@intel.com>, peterz@infradead.org,
        acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com
References: <1612797946-18784-24-git-send-email-kan.liang@linux.intel.com>
 <202102091153.8YFcmWIL-lkp@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <f0cbcf58-7db8-b0c8-4c9b-a3090b21ddb4@linux.intel.com>
Date:   Tue, 9 Feb 2021 08:44:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <202102091153.8YFcmWIL-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/2021 10:58 PM, kernel test robot wrote:
> Hi,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/perf/core]
> [cannot apply to tip/master linus/master tip/x86/core v5.11-rc6 next-20210125]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/kan-liang-linux-intel-com/Add-Alder-Lake-support-for-perf/20210209-070642
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 32451614da2a9cf4296f90d3606ac77814fb519d
> config: x86_64-randconfig-s021-20210209 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>          # apt-get install sparse
>          # sparse version: v0.6.3-215-g0fb77bb6-dirty
>          # https://github.com/0day-ci/linux/commit/ef3d3e5028f5f70a78fa37d642e8e7e65c60dee7
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review kan-liang-linux-intel-com/Add-Alder-Lake-support-for-perf/20210209-070642
>          git checkout ef3d3e5028f5f70a78fa37d642e8e7e65c60dee7
>          # save the attached .config to linux build tree
>          make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     arch/x86/events/msr.c: In function 'test_intel':
>>> arch/x86/events/msr.c:104:7: error: 'INTEL_FAM6_ALDERLAKE_L' undeclared (first use in this function); did you mean 'INTEL_FAM6_ALDERLAKE'?
>       104 |  case INTEL_FAM6_ALDERLAKE_L:
>           |       ^~~~~~~~~~~~~~~~~~~~~~
>           |       INTEL_FAM6_ALDERLAKE
>     arch/x86/events/msr.c:104:7: note: each undeclared identifier is reported only once for each function it appears in


The patchset is on top of PeterZ's perf/core branch plus
commit id 6e1239c13953 ("x86/cpu: Add another Alder Lake CPU to the 
Intel family")

The above patch is also missed in the tip/perf/core branch. All the 
issues should be gone once the tip/perf/core sync with the tip/x86/urgent.


Thanks,
Kan


