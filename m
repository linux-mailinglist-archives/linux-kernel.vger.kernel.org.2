Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ECB400119
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349338AbhICOOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:14:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:56993 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349257AbhICOOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:14:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="304994689"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="304994689"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 07:13:22 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="500376060"
Received: from achiranj-mobl.gar.corp.intel.com ([10.213.105.90])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 07:13:19 -0700
Message-ID: <c56cde110210bec6537fe69b495334c6c70c814e.camel@linux.intel.com>
Subject: Re: Bug: d0e936adbd22 crashes at boot
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, inux-pm@vger.kernel.org
Date:   Fri, 03 Sep 2021 07:13:16 -0700
In-Reply-To: <942f4041-e4e7-1b08-3301-008ab37ff5b8@kernel.dk>
References: <942f4041-e4e7-1b08-3301-008ab37ff5b8@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axboe,

Thanks for reporting.
On Fri, 2021-09-03 at 07:36 -0600, Jens Axboe wrote:
> Hi,
> 
> Booting Linus's tree causes a crash on my laptop, an x1 gen9. This was
> a bit
> difficult to pin down as it crashes before the display is up, but I
> managed
> to narrow it down to:
> 
> commit d0e936adbd2250cb03f2e840c6651d18edc22ace
> Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Date:   Thu Aug 19 19:40:06 2021 -0700
> 
>     cpufreq: intel_pstate: Process HWP Guaranteed change notification
> 
> which crashes with a NULL pointer deref in notify_hwp_interrupt() ->
> queue_delayed_work_on().
> 
> Reverting this change makes the laptop boot fine again.
> 
Does this change fixes your issue?

diff --git a/drivers/cpufreq/intel_pstate.c
b/drivers/cpufreq/intel_pstate.c
index b4ffe6c8a0d0..6a3c6f60ad12 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1650,7 +1650,10 @@ void notify_hwp_interrupt(void)
                return;
 
        cpudata = all_cpu_data[this_cpu];
-       schedule_delayed_work_on(this_cpu, &cpudata->hwp_notify_work,
msecs_to_jiffies(10));
+       if (cpudata)
+               schedule_delayed_work_on(this_cpu, &cpudata-
>hwp_notify_work, msecs_to_jiffies(10));
+       else
+               wrmsrl(MSR_HWP_STATUS, 0);
 }
 
 static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)


Thanks,
Srinivas

