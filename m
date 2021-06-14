Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2454D3A65EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhFNLpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:45:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:22687 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235981AbhFNLm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:42:57 -0400
IronPort-SDR: R8J25+u7MI8wt3DnkSEcaL5sT384Apirexw/y+BdZwoB3jWcNF+Z0oC7Z6sYYRi3uCR7XVQFpj
 Mw0Bo+K9fc9A==
X-IronPort-AV: E=McAfee;i="6200,9189,10014"; a="269645485"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="269645485"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 04:40:50 -0700
IronPort-SDR: vYpJpvw8/EcNsCbeO+xrLrbwmmYTykp8jv1fVZMFVPYMm2KeIdFBBxOcu4PmGXYiHAbF+29gvr
 DrebkfzxIQNA==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="484056862"
Received: from ideak-desk.fi.intel.com ([10.237.68.141])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 04:40:49 -0700
Date:   Mon, 14 Jun 2021 14:40:45 +0300
From:   Imre Deak <imre.deak@intel.com>
To:     Thomas Voegtle <tv@lio96.de>
Cc:     linux-kernel@vger.kernel.org,
        Khaled Almahallawy <khaled.almahallawy@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Subject: Re: Warning at drivers/gpu/drm/i915/intel_runtime_pm.c:638
Message-ID: <20210614114045.GA828547@ideak-desk.fi.intel.com>
References: <cea1f9a-52e0-b83-593d-52997fe1aaf6@er-systems.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cea1f9a-52e0-b83-593d-52997fe1aaf6@er-systems.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the report.

It looks like a pre-SKL machine, so I presume

commit ("d339ef1c4d6b") drm/i915: Uninit the DMC FW loader state during shutdown

in the

https://cgit.freedesktop.org/drm-tip/log/

branch will not help. Could you open a ticket at
https://gitlab.freedesktop.org/drm/intel/-/issues/new
(you need a freedesktop.org GitLab account for this)

booting a CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y kernel with the
drm.debug=0xe param and providing the dmesg log captured after
reproducing the problem?

Thanks,
Imre

On Sun, Jun 13, 2021 at 08:11:48PM +0200, Thomas Voegtle wrote:
> 
> Hi,
> 
> since 5.13.0-rcX I get that warning below when shutting down or reboot.
> There is only this warning I have no other problems with the driver.
> Shutdown or reboot is successful.
> 
> I bisected it down to:
> 
> commit 7962893ecb853aa7c8925ce237ab6c4274cfc1c7
> Author: Imre Deak <imre.deak@intel.com>
> Date:   Wed Jan 27 20:19:09 2021 +0200
> 
>     drm/i915: Disable runtime power management during shutdown
> 
> 
> ...
> [  OK  ] Reached target Shutdown.
> [   43.142532] ------------[ cut here ]------------
> [   43.147160] i915 0000:00:02.0: i915 raw-wakerefs=1 wakelocks=1 on cleanup
> [   43.153949] WARNING: CPU: 3 PID: 1 at
> drivers/gpu/drm/i915/intel_runtime_pm.c:638
> intel_runtime_pm_driver_release+0x42/0x50
> [   43.165069] CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted
> 5.13.0-rc5-i5-00235-g43cb5d49a99b #333
> [   43.174019] Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./H81 Pro BTC R2.0, BIOS P1.20 07/22/2014
> [   43.184176] RIP: 0010:intel_runtime_pm_driver_release+0x42/0x50
> [   43.190096] Code: fc 10 0f b7 d9 48 8b 6f 50 48 85 ed 74 23 e8 05 c4 10
> 00 45 89 e0 89 d9 48 89 ea 48 89 c6 48 c7 c7 c0 96 07 94 e8 0e 8c b6 ff <0f>
> 0b 5b 5d 41
> 5c c3 48 8b 2f eb d8 66 90 48 8b 87 68 99 ff ff 48
> [   43.208842] RSP: 0018:ffffb2028002bd30 EFLAGS: 00010282
> [   43.214069] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
> 00000000ffff7fff
> [   43.221200] RDX: ffffb2028002bb50 RSI: 00000000ffff7fff RDI:
> 0000000000000003
> [   43.228324] RBP: ffff971840982e80 R08: 0000000000000000 R09:
> 0000000000000001
> [   43.235448] R10: 0000000000000000 R11: ffffb2028002bb48 R12:
> 0000000000000001
> [   43.242572] R13: ffffffff940a33d3 R14: ffff971840a22948 R15:
> 0000000000000000
> [   43.249696] FS:  00007f1bba03a1c0(0000) GS:ffff971a53780000(0000)
> knlGS:0000000000000000
> [   43.257776] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   43.263519] CR2: 00007f1bb97d94a0 CR3: 00000001080b8002 CR4:
> 00000000001706e0
> [   43.270645] Call Trace:
> [   43.273089]  device_shutdown+0x149/0x1f0
> [   43.277015]  kernel_restart+0x9/0x50
> [   43.280593]  __do_sys_reboot+0xe7/0x1d0
> [   43.284433]  ? vfs_writev+0xb4/0x150
> [   43.288014]  ? __cond_resched+0x10/0x40
> [   43.291851]  ? task_work_run+0x6c/0xa0
> [   43.295604]  do_syscall_64+0x5d/0x70
> [   43.299185]  ? syscall_exit_to_user_mode+0x20/0x40
> [   43.303978]  ? do_syscall_64+0x69/0x70
> [   43.307730]  ? exc_page_fault+0x201/0x600
> [   43.311741]  ? asm_exc_page_fault+0x8/0x30
> [   43.315841]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   43.320894] RIP: 0033:0x7f1bb95177d6
> [   43.324475] Code: 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
> 00 00 48 63 d7 be 69 19 12 28 48 c7 c7 ad de e1 fe b8 a9 00 00 00 0f 05 <48>
> 3d 00 f0 ff
> ff 77 02 f3 c3 48 8b 15 91 06 2c 00 f7 d8 64 89 02
> [   43.343218] RSP: 002b:00007fffea4c3cc8 EFLAGS: 00000202 ORIG_RAX:
> 00000000000000a9
> [   43.350785] RAX: ffffffffffffffda RBX: 0000000001234567 RCX:
> 00007f1bb95177d6
> [   43.357909] RDX: 0000000001234567 RSI: 0000000028121969 RDI:
> fffffffffee1dead
> [   43.365041] RBP: 0000000000000000 R08: 0000000000000000 R09:
> 0000000000000000
> [   43.372166] R10: 0000000000000002 R11: 0000000000000202 R12:
> 0000000000000000
> [   43.379291] R13: 00007fffea4c3e78 R14: 0000000000000000 R15:
> 0000000000000000
> [   43.386422] ---[ end trace be6a3ef0677f3d04 ]---
> [   43.391174] reboot: Restarting system
> 
> 
> Hope this useful for you,
> 
>       Thomas
> 
> 
