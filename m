Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343BE360A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhDONRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:17:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:23637 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhDONRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:17:46 -0400
IronPort-SDR: 0qTLG80XTVR5pZtTdv2U6FJnVlJN2vRGgD6VUYoQTIuzG6BuXGP4WU78xzL5SQaJ5ZpWGnOydH
 /PULSr5une2w==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="191660689"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="191660689"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 06:17:22 -0700
IronPort-SDR: paL3/EwV1myg1aP9Iv1Py3BJX2j/Qc1tLpcLyw0bBYKrWCIeYTGoLp50KXWosEPR+9z2tHYrcK
 35fELMgquAMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="444174967"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2021 06:17:19 -0700
Date:   Thu, 15 Apr 2021 21:17:19 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@suse.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, zhengjun.xing@intel.com
Subject: Re: [thermal]  9223d0dccb:  stress-ng.msg.ops_per_sec -27.4%
 regression
Message-ID: <20210415131719.GA77225@shbuild999.sh.intel.com>
References: <20210413135800.GA10266@xsang-OptiPlex-9020>
 <20210413172827.GC17097@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210413172827.GC17097@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris, Srinivas,

On Tue, Apr 13, 2021 at 07:28:27PM +0200, Borislav Petkov wrote:
> On Tue, Apr 13, 2021 at 09:58:01PM +0800, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a -27.4% regression of stress-ng.msg.ops_per_sec due to commit:
> > 
> > 
> > commit: 9223d0dccb8f8523754122f68316dd1a4f39f7f8 ("thermal: Move therm_throt there from x86/mce")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

This seems to be another case that performance jump is caused by 
kernel's data alignment change triggered by an irrelevant patch.  

With a debug patch to force aligned all data sections of .o files,
the performance diff is reduced from -27.4 to -2.8%.

And from perf profile and c2c data, we did see differenc about spinlock
around calling do_msgrcv/do_msgsnd with the 2 commits

> Hmm, so I went and ran your reproducer, but simplified (see end of
> mail), on a KBL box here. The kernel is tip:x86/urgent from last week:
> 
> 5.12.0-rc6+
> -----------
> stress-ng: info:  [1430] dispatching hogs: 9 msg
> stress-ng: info:  [1430] successful run completed in 60.01s (1 min, 0.01 secs)
> stress-ng: info:  [1430] stressor       bogo ops real time  usr time  sys time   bogo ops/s   bogo ops/s
> stress-ng: info:  [1430]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
> stress-ng: info:  [1430] msg           237390147     60.01    104.03    255.85   3955872.56    659636.95
> stress-ng: info:  [1430] for a 60.01s run time:
> stress-ng: info:  [1430]     360.08s available CPU time
> stress-ng: info:  [1430]     104.11s user time   ( 28.91%)
> stress-ng: info:  [1430]     255.93s system time ( 71.08%)
> stress-ng: info:  [1430]     360.04s total time  ( 99.99%)
> stress-ng: info:  [1430] load average: 8.47 3.71 1.48
> 
> Now the same kernel with
> 
> >   4f432e8bb1 ("x86/mce: Get rid of mcheck_intel_therm_init()")
> >   9223d0dccb ("thermal: Move therm_throt there from x86/mce")
> 
> reverted.
> 
> 5.12.0-rc6-rev+
> ---------------
> stress-ng: info:  [1246] dispatching hogs: 9 msg
> stress-ng: info:  [1246] successful run completed in 60.02s (1 min, 0.02 secs)
> stress-ng: info:  [1246] stressor       bogo ops real time  usr time  sys time   bogo ops/s   bogo ops/s
> stress-ng: info:  [1246]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
> stress-ng: info:  [1246] msg           215174467     60.01     99.64    260.24   3585438.79    597906.15
> stress-ng: info:  [1246] for a 60.02s run time:
> stress-ng: info:  [1246]     360.10s available CPU time
> stress-ng: info:  [1246]      99.72s user time   ( 27.69%)
> stress-ng: info:  [1246]     260.32s system time ( 72.29%)
> stress-ng: info:  [1246]     360.04s total time  ( 99.98%)
> stress-ng: info:  [1246] load average: 7.98 2.33 0.80
> 
> so if I'm reading this correctly, reverting the patches here brings the
> *slow-down*.
> 
> What's up?
> 
> reproducer:
> ----------
> 
> #!/usr/bin/bash
> 
> for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
> do
>         online_file="$cpu_dir"/online
>         [ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue
> 
>         file="$cpu_dir"/cpufreq/scaling_governor
>         [ -f "$file" ] && echo "performance" > "$file"
> done
> 
> stress-ng --timeout 60 --times --verify --metrics-brief --msg 9

The original test case is for 'nr_threads=10%' which turns to '9' for the
96 CPU 2-sockets  Cascade Lake platform. So I guess it may not be reproduced
on 1 socket platform, and sometimes kernel config also matters for
micro-benchmark like 'stress-ng' 

Thanks,
Feng

> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
