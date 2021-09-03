Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D00D40015A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349412AbhICOjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:39:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:10629 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230332AbhICOjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:39:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="219497684"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="219497684"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 07:38:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="477243645"
Received: from achiranj-mobl.gar.corp.intel.com ([10.213.105.90])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 07:38:44 -0700
Message-ID: <7f115f0476618d34b24ddec772acbbd7c0c4a572.camel@linux.intel.com>
Subject: Re: Bug: d0e936adbd22 crashes at boot
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, inux-pm@vger.kernel.org
Date:   Fri, 03 Sep 2021 07:38:41 -0700
In-Reply-To: <3ac87893-55ba-f2d4-bb1e-382868f12d4c@kernel.dk>
References: <942f4041-e4e7-1b08-3301-008ab37ff5b8@kernel.dk>
         <c56cde110210bec6537fe69b495334c6c70c814e.camel@linux.intel.com>
         <3ac87893-55ba-f2d4-bb1e-382868f12d4c@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-03 at 08:15 -0600, Jens Axboe wrote:
> On 9/3/21 8:13 AM, Srinivas Pandruvada wrote:
> > Hi Axboe,
> > 
> > Thanks for reporting.
> > On Fri, 2021-09-03 at 07:36 -0600, Jens Axboe wrote:
> > > Hi,
> > > 
> > > Booting Linus's tree causes a crash on my laptop, an x1 gen9. This
> > > was
> > > a bit
> > > difficult to pin down as it crashes before the display is up, but I
> > > managed
> > > to narrow it down to:
> > > 
> > > commit d0e936adbd2250cb03f2e840c6651d18edc22ace
> > > Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Date:   Thu Aug 19 19:40:06 2021 -0700
> > > 
> > >     cpufreq: intel_pstate: Process HWP Guaranteed change
> > > notification
> > > 
> > > which crashes with a NULL pointer deref in notify_hwp_interrupt() -
> > > >
> > > queue_delayed_work_on().
> > > 
> > > Reverting this change makes the laptop boot fine again.
> > > 
> > Does this change fixes your issue?
> 
> I would assume so, as it's crashing on cpudata == NULL :-)
> 
> But why is it NULL? Happy to test patches, but the below doesn't look
> like
> a real fix and more of a work-around.

This platform is sending an HWP interrupt on a CPU which we didn't yet
bring it up for pstate control. So somehow firmware decided to send
very early during boot, which previously we would have ignored it

Actually try this, with more prevention

diff --git a/drivers/cpufreq/intel_pstate.c
b/drivers/cpufreq/intel_pstate.c
index b4ffe6c8a0d0..6ee88d7640ea 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1645,12 +1645,24 @@ void notify_hwp_interrupt(void)
        if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
                return;
 
-       rdmsrl(MSR_HWP_STATUS, value);
+       rdmsrl_safe(MSR_HWP_STATUS, &value);
        if (!(value & 0x01))
                return;
 
+       /*
+        * After hwp_active is set and all_cpu_data is allocated, there
+        * is small window.
+        */
+       if (!all_cpu_data) {
+               wrmsrl_safe(MSR_HWP_STATUS, 0);
+               return;
+       }
+
        cpudata = all_cpu_data[this_cpu];
-       schedule_delayed_work_on(this_cpu, &cpudata->hwp_notify_work,
msecs_to_jiffies(10));
+       if (cpudata)
+               schedule_delayed_work_on(this_cpu, &cpudata-
>hwp_notify_work, msecs_to_jiffies(10));
+       else
+               wrmsrl_safe(MSR_HWP_STATUS, 0);
 }
 


> 


