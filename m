Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA08337647
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhCKO5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:57:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:41875 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233504AbhCKO5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:57:06 -0500
IronPort-SDR: fAyazLXBGm+RCxZjvt0AjIOjE/01HrKh8F0C9yLLr0cOcaXvBAdSkTa0jnFhbMoI6DpUcy+3sG
 1kB49NbdEIcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="167951520"
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="167951520"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 06:57:06 -0800
IronPort-SDR: bZLHUbU5lneKMCBYas2V2r3BJKdyXm2SdvIVCwHjyPj4+Y4rSPauRNbsxZDTWKnVTYRvEWayYN
 TUY2jDJfgbMg==
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="404094375"
Received: from ideak-desk.fi.intel.com ([10.237.68.141])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 06:57:04 -0800
Date:   Thu, 11 Mar 2021 16:57:00 +0200
From:   Imre Deak <imre.deak@intel.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Khaled Almahallawy <khaled.almahallawy@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [LKP] Re: [drm/i915] 7962893ecb:
 WARNING:at_drivers/gpu/drm/i915/intel_runtime_pm.c:#intel_runtime_pm_driver_release[i915]
Message-ID: <20210311145700.GA2970909@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20210303055517.GB2708@xsang-OptiPlex-9020>
 <20210304005518.GD1137473@ideak-desk.fi.intel.com>
 <9575be26-f9e5-814b-b24c-a2497847980e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9575be26-f9e5-814b-b24c-a2497847980e@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 11, 2021 at 09:32:04AM +0800, Xing Zhengjun wrote:
> On 3/4/2021 8:55 AM, Imre Deak wrote:
> > Hi Oliver,
> > 
> > On Wed, Mar 03, 2021 at 01:55:17PM +0800, kernel test robot wrote:
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed the following commit (built with gcc-9):
> > > 
> > > commit: 7962893ecb853aa7c8925ce237ab6c4274cfc1c7 ("drm/i915: Disable runtime power management during shutdown")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > [...]
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > 
> > > 
> > > [   49.686892] ------------[ cut here ]------------
> > > [   49.691510] i915 0000:00:02.0: i915 raw-wakerefs=1 wakelocks=1 on cleanup
> > 
> > 
> > THanks for the report. I couldn't reproduce this. Could you add the
> > following kconfig option for these tests (and if possible reproduce the
> > problem with that?):
> > 
> > CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y
> > 
> I add "CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y" to the kernel config, re-test it,
> the issue still happened. The kernel log is in the attachment.

thanks, the following should fix this:
https://patchwork.freedesktop.org/patch/423617/?series=87883&rev=1

The leaked wakeref was due to not handling the case where the DMC
firmware is missing:

[   20.316022] i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver1_27.bin failed with error -2
[   20.338032] i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915

...

[   47.439434] i915 0000:00:02.0: i915 raw-wakerefs=1 wakelocks=1 on cleanup
...
[   47.646836] Call Trace:
[   47.650215]  pci_device_shutdown+0x34/0x60
[   47.655264]  device_shutdown+0x162/0x1d0
[   47.660103]  kernel_restart+0xe/0x40
[   47.664615]  __do_sys_reboot+0x1d2/0x210
[   47.669445]  ? __check_object_size+0x136/0x150
[   47.674792]  ? rcu_nocb_try_bypass+0x1f2/0x340
[   47.680132]  ? get_max_files+0x10/0x10
[   47.684781]  ? exit_to_user_mode_prepare+0x112/0x150
[   47.690672]  do_syscall_64+0x33/0x40
...
[   47.831502] i915 Wakeref count: 1
[   47.835731] i915 Wakeref x1 taken at:
[   47.835731]    track_intel_runtime_pm_wakeref+0x19/0xa0 [i915]
[   47.835731]    intel_display_power_get+0x25/0x60 [i915]
[   47.835731]    intel_csr_runtime_pm_get+0x22/0x60 [i915]
[   47.835731]    intel_csr_ucode_init+0x49/0x270 [i915]
[   47.835731]    intel_modeset_init_noirq+0x65/0x280 [i915]
[   47.835731]    i915_driver_probe+0x518/0x990 [i915]
[   47.835731]    i915_pci_probe+0x54/0x140 [i915]
[   47.835731]    local_pci_probe+0x42/0x80

This could also be a real problem if the FW loading hadn't yet finished
by shutdown/reboot.

--Imre
