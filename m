Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F39B35E504
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347146AbhDMR2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:28:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:54646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241408AbhDMR2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:28:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AEF73B301;
        Tue, 13 Apr 2021 17:28:30 +0000 (UTC)
Date:   Tue, 13 Apr 2021 19:28:27 +0200
From:   Borislav Petkov <bp@suse.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [thermal]  9223d0dccb:  stress-ng.msg.ops_per_sec -27.4%
 regression
Message-ID: <20210413172827.GC17097@zn.tnic>
References: <20210413135800.GA10266@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210413135800.GA10266@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 09:58:01PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -27.4% regression of stress-ng.msg.ops_per_sec due to commit:
> 
> 
> commit: 9223d0dccb8f8523754122f68316dd1a4f39f7f8 ("thermal: Move therm_throt there from x86/mce")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Hmm, so I went and ran your reproducer, but simplified (see end of
mail), on a KBL box here. The kernel is tip:x86/urgent from last week:

5.12.0-rc6+
-----------
stress-ng: info:  [1430] dispatching hogs: 9 msg
stress-ng: info:  [1430] successful run completed in 60.01s (1 min, 0.01 secs)
stress-ng: info:  [1430] stressor       bogo ops real time  usr time  sys time   bogo ops/s   bogo ops/s
stress-ng: info:  [1430]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
stress-ng: info:  [1430] msg           237390147     60.01    104.03    255.85   3955872.56    659636.95
stress-ng: info:  [1430] for a 60.01s run time:
stress-ng: info:  [1430]     360.08s available CPU time
stress-ng: info:  [1430]     104.11s user time   ( 28.91%)
stress-ng: info:  [1430]     255.93s system time ( 71.08%)
stress-ng: info:  [1430]     360.04s total time  ( 99.99%)
stress-ng: info:  [1430] load average: 8.47 3.71 1.48

Now the same kernel with

>   4f432e8bb1 ("x86/mce: Get rid of mcheck_intel_therm_init()")
>   9223d0dccb ("thermal: Move therm_throt there from x86/mce")

reverted.

5.12.0-rc6-rev+
---------------
stress-ng: info:  [1246] dispatching hogs: 9 msg
stress-ng: info:  [1246] successful run completed in 60.02s (1 min, 0.02 secs)
stress-ng: info:  [1246] stressor       bogo ops real time  usr time  sys time   bogo ops/s   bogo ops/s
stress-ng: info:  [1246]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
stress-ng: info:  [1246] msg           215174467     60.01     99.64    260.24   3585438.79    597906.15
stress-ng: info:  [1246] for a 60.02s run time:
stress-ng: info:  [1246]     360.10s available CPU time
stress-ng: info:  [1246]      99.72s user time   ( 27.69%)
stress-ng: info:  [1246]     260.32s system time ( 72.29%)
stress-ng: info:  [1246]     360.04s total time  ( 99.98%)
stress-ng: info:  [1246] load average: 7.98 2.33 0.80

so if I'm reading this correctly, reverting the patches here brings the
*slow-down*.

What's up?

reproducer:
----------

#!/usr/bin/bash

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
        online_file="$cpu_dir"/online
        [ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

        file="$cpu_dir"/cpufreq/scaling_governor
        [ -f "$file" ] && echo "performance" > "$file"
done

stress-ng --timeout 60 --times --verify --metrics-brief --msg 9

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
