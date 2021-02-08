Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1263128A5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 01:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBHArE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 7 Feb 2021 19:47:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:9261 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhBHArC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 19:47:02 -0500
IronPort-SDR: 97V1X4RiVu2XaC3L+XQBbx6qgsboOMSGMIf6YhDGq9QT0dPMZhn21P4zjrDYOtiT+sHlKtVldn
 44gjOGAaTeew==
X-IronPort-AV: E=McAfee;i="6000,8403,9888"; a="179081234"
X-IronPort-AV: E=Sophos;i="5.81,160,1610438400"; 
   d="scan'208";a="179081234"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 16:46:21 -0800
IronPort-SDR: 970OPowdUYRFOdQD7CEPdKRfC4V/7gSGKUyl65dkCDi2S3/Obu3VKSwXqnnuVfyrctDS2ojCDb
 v+cmN//ex/0g==
X-IronPort-AV: E=Sophos;i="5.81,160,1610438400"; 
   d="scan'208";a="395129684"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 16:46:15 -0800
Date:   Mon, 8 Feb 2021 08:45:44 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     "Chiou, Cooper" <cooper.chiou@intel.com>
Cc:     "Tang, Feng" <feng.tang@intel.com>,
        "Li, Tiejun" <tiejun.li@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "Du, Frank" <frank.du@intel.com>,
        "Chen, Guobing" <guobing.chen@intel.com>,
        "Tseng, William" <william.tseng@intel.com>,
        "Xie, Gengxin" <gengxin.xie@intel.com>,
        "Fan, Shuhua" <shuhua.fan@intel.com>,
        "Zhao, Fan" <fan.zhao@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Kang, Shan" <shan.kang@intel.com>,
        "Xing, Zhengjun" <zhengjun.xing@intel.com>,
        "Huang, Wenhuan" <wenhuan.huang@intel.com>,
        "Nikula, Jani" <jani.nikula@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "Chen, Ming A" <ming.a.chen@intel.com>, "Ma, Yu" <yu.ma@intel.com>,
        "Ji, Jessica" <jessica.ji@intel.com>,
        "Li, Guangli" <guangli.li@intel.com>,
        "Guo, Wangyang" <wangyang.guo@intel.com>,
        "Mi, Dapeng1" <dapeng1.mi@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sun, Jiebin" <jiebin.sun@intel.com>
Subject: Re: [Intel-gfx] [drm/i915] 04ff178484:
 phoronix-test-suite.supertuxkart.1024x768.Fullscreen.Ultimate.1.GranParadisoIsland.frames_per_second
 -30.4% regression
Message-ID: <20210208004544.GA1712029@shao2-debian>
References: <20200916180745.627-1-cooper.chiou@intel.com>
 <20200921092220.GH13157@shao2-debian>
 <SA2PR11MB49694B1464470425AF44AAAB9DA19@SA2PR11MB4969.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <SA2PR11MB49694B1464470425AF44AAAB9DA19@SA2PR11MB4969.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The problem can't be reproduced after test environment changed,
there's no regression found on this patch now, we don't know yet
why it caused a regression in September 2020, but we'll continue
to root cause.

Best Regards,
Rong Chen

On Thu, Jan 21, 2021 at 02:18:25PM +0000, Chiou, Cooper wrote:
> I run “phoronix-test-suite run supertuxkart-1.5.2” on my CML Ubuntu 18.04.5 LTS device, and compared the fps between patch and original upstream, there is no any fps performance drop issue. 
> 
>         5.10.0-rc3 upstream /  5.10.0-rc3+patch
> fps     12.586326           /  12.687711
> 
> Best Regards,
> Cooper
> +886-2-6622-1166
> 
> -----Original Message-----
> From: kernel test robot <rong.a.chen@intel.com> 
> Sent: Monday, September 21, 2020 5:22 PM
> To: Chiou, Cooper <cooper.chiou@intel.com>
> Cc: intel-gfx@lists.freedesktop.org; Chiou, Cooper <cooper.chiou@intel.com>; Tseng, William <william.tseng@intel.com>; Nikula, Jani <jani.nikula@intel.com>; Chris Wilson <chris@chris-wilson.co.uk>; lkp <lkp@intel.com>; Ville Syrjälä <ville.syrjala@linux.intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>; Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>; Lee, Shawn C <shawn.c.lee@intel.com>; LKML <linux-kernel@vger.kernel.org>; lkp@lists.01.org; Huang, Ying <ying.huang@intel.com>; Tang, Feng <feng.tang@intel.com>; Xing, Zhengjun <zhengjun.xing@intel.com>; Chen, Guobing <guobing.chen@intel.com>; Chen, Ming A <ming.a.chen@intel.com>; Du, Frank <frank.du@intel.com>; Fan, Shuhua <shuhua.fan@intel.com>; Guo, Wangyang <wangyang.guo@intel.com>; Huang, Wenhuan <wenhuan.huang@intel.com>; Ji, Jessica <jessica.ji@intel.com>; Kang, Shan <shan.kang@intel.com>; Li, Guangli <guangli.li@intel.com>; Li, Tiejun <tiejun.li@intel.com>; Ma, Yu <yu.ma@intel.com>; Mi, Dapeng1 <dapeng1.mi@intel.com>; Sun, Jiebin <jiebin.sun@intel.com>; Xie, Gengxin <gengxin.xie@intel.com>; Zhao, Fan <fan.zhao@intel.com>
> Subject: [drm/i915] 04ff178484: phoronix-test-suite.supertuxkart.1024x768.Fullscreen.Ultimate.1.GranParadisoIsland.frames_per_second -30.4% regression
> 
> Greeting,
> 
> FYI, we noticed a -30.4% regression of phoronix-test-suite.supertuxkart.1024x768.Fullscreen.Ultimate.1.GranParadisoIsland.frames_per_second due to commit:
> 
> 
> commit: 04ff1784840f5f954a656c7e8795c76467e29128 ("[Intel-gfx] [PATCH] drm/i915: Enable WaProgramMgsrForCorrectSliceSpecificMmioReads for Gen9")
> url: https://github.com/0day-ci/linux/commits/Cooper-Chiou/drm-i915-Enable-WaProgramMgsrForCorrectSliceSpecificMmioReads-for-Gen9/20200917-021540
> base: git://anongit.freedesktop.org/drm-intel for-linux-next
> 
> in testcase: phoronix-test-suite
> on test machine: 4 threads Intel(R) Core(TM) i7-7567U CPU @ 3.50GHz with 32G memory with following parameters:
> 
> 	need_x: true
> 	test: supertuxkart-1.5.2
> 	option_a: Fullscreen
> 	option_b: Ultimate
> 	option_c: 1
> 	option_d: Gran Paradiso Island [Approximately 275k triangles; advanced graphics]
> 	cpufreq_governor: performance
> 	ucode: 0xd6
> 
> test-description: The Phoronix Test Suite is the most comprehensive testing and benchmarking platform available that provides an extensible framework for which new tests can be easily added.
> test-url: http://www.phoronix-test-suite.com/
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/need_x/option_a/option_b/option_c/option_d/rootfs/tbox_group/test/testcase/ucode:
>   gcc-9/performance/x86_64-rhel-8.3/true/Fullscreen/Ultimate/1/Gran Paradiso Island [Approximately 275k triangles; advanced graphics]/debian-x86_64-phoronix/lkp-kbl-nuc1/supertuxkart-1.5.2/phoronix-test-suite/0xd6
> 
> commit: 
>   400d4953f1 ("drm/i915/pll: Centralize PLL_ENABLE register lookup")
>   04ff178484 ("drm/i915: Enable WaProgramMgsrForCorrectSliceSpecificMmioReads for Gen9")
> 
> 400d4953f1f434d5 04ff1784840f5f954a656c7e879
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      35.32           -30.4%      24.59        phoronix-test-suite.supertuxkart.1024x768.Fullscreen.Ultimate.1.GranParadisoIsland.frames_per_second
>       3638 ± 15%     -39.2%       2211 ±  4%  phoronix-test-suite.time.involuntary_context_switches
>      32.00           -30.5%      22.25        phoronix-test-suite.time.percent_of_cpu_this_job_got
> 
> 
>                                                                                 
>                                                                                 
>                                                                                 
>   36 +----------------------------------------------------------------------+   
>      |.+.+..+.+.+.+..+.+.+.+.+..+.+.+.+..+.+.+.+.+..+.+.+.+.+..+   +.+..+.+.|   
>   34 |-+                                                                    |   
>      |                                                                      |   
>      |                                                                      |   
>   32 |-+                                                                    |   
>      |                                                                      |   
>   30 |-+                                                                    |   
>      |                                                                      |   
>   28 |-+                                                                    |   
>      |                                                                      |   
>      |                                                                      |   
>   26 |-+                                                                    |   
>      | O O  O O O O  O O O O O  O O O O  O O O O O  O O                     |   
>   24 +----------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>               phoronix-test-suite.time.percent_of_cpu_this_job_got              
>                                                                                 
>   32 +----------------------------------------------------------------------+   
>      |               +       +.              +      +   +.+.+.              |   
>   30 |-+                                                                    |   
>      |                                                                      |   
>      |                                                                      |   
>   28 |-+                                                                    |   
>      |                                                                      |   
>   26 |-+                                                                    |   
>      |                                                                      |   
>   24 |-+                                                                    |   
>      |                                   O       O                          |   
>      |                                                                      |   
>   22 |-O O  O O   O  O O O O O  O O O O    O O O    O O                     |   
>      |          O                                                           |   
>   20 +----------------------------------------------------------------------+   
>                                                                                 
>                                                                                 
> [*] bisect-good sample
> [O] bisect-bad  sample
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
> Thanks,
> Rong Chen
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
