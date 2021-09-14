Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F3B40B035
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhINOFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:05:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:12980 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232682AbhINOFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:05:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="244334885"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="244334885"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 07:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="609639345"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Sep 2021 07:03:15 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Sep 2021 17:03:13 +0300
Date:   Tue, 14 Sep 2021 17:03:13 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [driver core]  bd1e336aa8:
 WARNING:at_lib/refcount.c:#refcount_warn_saturate
Message-ID: <YUCrobcWISfeOWxy@kuha.fi.intel.com>
References: <20210912161001.GJ25450@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912161001.GJ25450@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 12:10:01AM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: bd1e336aa8535a99f339e2d66a611984262221ce ("driver core: platform: Remove platform_device_add_properties()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-d0cba0d1-1_20210907
> with following parameters:
> 
> 	group: group-01
> 	ucode: 0xe2
> 
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> 
> 
> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> 
> [  375.495537][T18669] ------------[ cut here ]------------
> [  375.500874][T18669] refcount_t: underflow; use-after-free.
> [  375.506401][T18669] WARNING: CPU: 3 PID: 18669 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0x100
> [  375.515762][T18669] Modules linked in: gpio_mockup(-) btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c ipmi_devintf ipmi_msghandler sd_mod t10_pi sg intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel rapl intel_cstate i915 mei_wdt wmi_bmof intel_uncore ahci libahci mei_me intel_gtt libata i2c_i801 ttm mei intel_pch_thermal i2c_smbus wmi video intel_pmc_core acpi_pad ip_tables [last unloaded: preemptirq_delay_test]
> [  375.561538][T18669] CPU: 3 PID: 18669 Comm: modprobe Not tainted 5.14.0-rc5-00035-gbd1e336aa853 #1
> [  375.570537][T18669] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
> [  375.578649][T18669] RIP: 0010:refcount_warn_saturate+0xa6/0x100
> [  375.584588][T18669] Code: 05 ac 60 f4 01 01 e8 9a 86 7c 00 0f 0b c3 80 3d 9a 60 f4 01 00 75 95 48 c7 c7 08 59 83 82 c6 05 8a 60 f4 01 01 e8 7b 86 7c 00 <0f> 0b c3 80 3d 79 60 f4 01 00 0f 85 72 ff ff ff 48 c7 c7 60 59 83
> [  375.604089][T18669] RSP: 0018:ffffc90000dc7df8 EFLAGS: 00010282
> [  375.610027][T18669] RAX: 0000000000000000 RBX: ffff8888153a4040 RCX: 0000000000000002
> [  375.617880][T18669] RDX: 0000000000000001 RSI: ffffffff8123838f RDI: ffffffff8123838f
> [  375.625744][T18669] RBP: ffff8881c249d810 R08: 0000000000000001 R09: 0000000000000001
> [  375.633592][T18669] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
> [  375.641466][T18669] R13: ffff8888153a4000 R14: 0000000000000000 R15: 0000000000000000
> [  375.649317][T18669] FS:  00007f82e999a480(0000) GS:ffff8887c8580000(0000) knlGS:0000000000000000
> [  375.658127][T18669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  375.664589][T18669] CR2: 00007ffe84be8b38 CR3: 00000008165f8005 CR4: 00000000003706e0
> [  375.672490][T18669] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  375.680356][T18669] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  375.688214][T18669] Call Trace:
> [  375.691373][T18669]  software_node_notify+0xaf/0x140
> [  375.696381][T18669]  device_platform_notify+0x2c/0x80
> [  375.701488][T18669]  device_del+0x1c7/0x440
> [  375.705694][T18669]  platform_device_del+0x13/0x80
> [  375.711121][T18669]  platform_device_unregister+0x1c/0x40
> [  375.716540][T18669]  gpio_mockup_exit+0x2b/0x3d1 [gpio_mockup]
> [  375.722396][T18669]  __x64_sys_delete_module+0x143/0x280
> [  375.727744][T18669]  ? syscall_enter_from_user_mode+0x21/0x80
> [  375.733512][T18669]  ? lockdep_hardirqs_on+0x79/0x100
> [  375.738584][T18669]  do_syscall_64+0x5c/0x80
> [  375.742884][T18669]  ? asm_exc_page_fault+0x1e/0x30
> [  375.747781][T18669]  ? asm_exc_page_fault+0x8/0x30
> [  375.752603][T18669]  ? lockdep_hardirqs_on+0x79/0x100
> [  375.757673][T18669]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  375.763462][T18669] RIP: 0033:0x7f82e9abadd7
> [  375.767749][T18669] Code: 73 01 c3 48 8b 0d b9 10 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 89 10 0c 00 f7 d8 64 89 01 48
> [  375.787252][T18669] RSP: 002b:00007ffe84beab38 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> [  375.795543][T18669] RAX: ffffffffffffffda RBX: 00005607a92de100 RCX: 00007f82e9abadd7
> [  375.803428][T18669] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005607a92de168
> [  375.811292][T18669] RBP: 00005607a92de168 R08: 00007ffe84be9ae1 R09: 0000000000000000
> [  375.819142][T18669] R10: 00007f82e9b2cae0 R11: 0000000000000206 R12: 0000000000000000
> [  375.826993][T18669] R13: 0000000000000000 R14: 00005607a92de168 R15: 00005607a92de210
> [  375.834852][T18669] irq event stamp: 11203
> [  375.838975][T18669] hardirqs last  enabled at (11213): [<ffffffff81238c70>] console_unlock+0x330/0x540
> [  375.848319][T18669] hardirqs last disabled at (11222): [<ffffffff81238d10>] console_unlock+0x3d0/0x540
> [  375.857649][T18669] softirqs last  enabled at (11160): [<ffffffff82200331>] __do_softirq+0x331/0x494
> [  375.866803][T18669] softirqs last disabled at (11155): [<ffffffff811a081e>] irq_exit_rcu+0x11e/0x140
> [  375.875961][T18669] ---[ end trace d5655f8d61e2815a ]---

There is a fix for this already, just hasn't been picked yet:

https://lore.kernel.org/lkml/20210716101602.1891-1-laurentiu.tudor@nxp.com/


thanks,

-- 
heikki
