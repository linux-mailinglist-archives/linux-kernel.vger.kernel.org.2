Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05E545383F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbhKPRHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:07:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:38616 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237079AbhKPRHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:07:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="220944957"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="220944957"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 08:59:59 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="604369959"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 08:59:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mn1o8-007UoO-1c;
        Tue, 16 Nov 2021 18:59:44 +0200
Date:   Tue, 16 Nov 2021 18:59:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Daniel Scally <djrscally@gmail.com>, lkp@lists.01.org,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Subject: Re: [device property] 995fe757ec:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <YZPjf1GfZHR2ZjpD@smile.fi.intel.com>
References: <20211116074104.GC32102@xsang-OptiPlex-9020>
 <f54546b1-b0dc-c2bc-3a5f-bcdaf35297fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f54546b1-b0dc-c2bc-3a5f-bcdaf35297fc@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 03:55:00PM +0100, Hans de Goede wrote:
> On 11/16/21 08:41, kernel test robot wrote:

> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 995fe757ecaeac44e023458af64d27655f9dbf73 ("[PATCH] device property: Check fwnode->secondary when finding properties")
> > url: https://github.com/0day-ci/linux/commits/Daniel-Scally/device-property-Check-fwnode-secondary-when-finding-properties/20211114-044259
> > base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git b5013d084e03e82ceeab4db8ae8ceeaebe76b0eb
> > patch link: https://lore.kernel.org/lkml/20211113204141.520924-1-djrscally@gmail.com
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +---------------------------------------------+------------+------------+
> > |                                             | b5013d084e | 995fe757ec |
> > +---------------------------------------------+------------+------------+
> > | boot_successes                              | 23         | 0          |
> > | boot_failures                               | 0          | 22         |
> > | BUG:kernel_NULL_pointer_dereference,address | 0          | 22         |
> > | Oops:#[##]                                  | 0          | 22         |
> > | EIP:fwnode_property_get_reference_args      | 0          | 22         |
> > | Kernel_panic-not_syncing:Fatal_exception    | 0          | 22         |
> > +---------------------------------------------+------------+------------+
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> Ok, so this patch likely needs a v2 which changes the if to this:
> 
>         if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
>             !IS_ERR_OR_NULL(fwnode->secondary))
>                 ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
>                                          prop, nargs_prop, nargs, index, args);
> 
> 
> So that we check fwnode before dereferencing it, note this also changes the
> (ret < 0) check to (ret == -EINVAL), this makes the secondary node handling
> identical to fwnode_property_read_int_array() and
> fwnode_property_read_string_array()
> 
> Danny, can you send a v2 with this change please?

Hmm... So, you are suggesting that we need to check it only for EINVAL and
ENOENT in this case the one that brings us to the NULL pointer dereference.
But I don't understand what's the difference here.

> > [   17.327851][    T7] BUG: kernel NULL pointer dereference, address: 00000000
> > [   17.329758][    T7] #PF: supervisor read access in kernel mode
> > [   17.331371][    T7] #PF: error_code(0x0000) - not-present page
> > [   17.332992][    T7] *pde = 00000000
> > [   17.334107][    T7] Oops: 0000 [#1] PREEMPT
> > [   17.335310][    T7] CPU: 0 PID: 7 Comm: kworker/u2:0 Tainted: G S                5.15.0-11191-g995fe757ecae #1
> > [   17.338036][    T7] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > [   17.340544][    T7] Workqueue: events_unbound deferred_probe_work_func
> > [ 17.342291][ T7] EIP: fwnode_property_get_reference_args (drivers/base/property.c:486 (discriminator 1)) 
> > [ 17.344051][ T7] Code: 8b 45 0c 50 8b 45 08 50 89 d8 89 55 f4 ff d6 83 c4 0c 89 c6 85 c0 78 55 8d 65 f8 89 f0 5b 5e 5d c3 8d 74 26 00 be fa ff ff ff <8b> 03 85 c0 74 e8 3d 00 f0 ff ff 77 e1 8b 58 04 85 db 74 37 8b 5b
> > All code
> > ========
> >    0:	8b 45 0c             	mov    0xc(%rbp),%eax
> >    3:	50                   	push   %rax
> >    4:	8b 45 08             	mov    0x8(%rbp),%eax
> >    7:	50                   	push   %rax
> >    8:	89 d8                	mov    %ebx,%eax
> >    a:	89 55 f4             	mov    %edx,-0xc(%rbp)
> >    d:	ff d6                	callq  *%rsi
> >    f:	83 c4 0c             	add    $0xc,%esp
> >   12:	89 c6                	mov    %eax,%esi
> >   14:	85 c0                	test   %eax,%eax
> >   16:	78 55                	js     0x6d
> >   18:	8d 65 f8             	lea    -0x8(%rbp),%esp
> >   1b:	89 f0                	mov    %esi,%eax
> >   1d:	5b                   	pop    %rbx
> >   1e:	5e                   	pop    %rsi
> >   1f:	5d                   	pop    %rbp
> >   20:	c3                   	retq   
> >   21:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
> >   25:	be fa ff ff ff       	mov    $0xfffffffa,%esi
> >   2a:*	8b 03                	mov    (%rbx),%eax		<-- trapping instruction
> >   2c:	85 c0                	test   %eax,%eax
> >   2e:	74 e8                	je     0x18
> >   30:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
> >   35:	77 e1                	ja     0x18
> >   37:	8b 58 04             	mov    0x4(%rax),%ebx
> >   3a:	85 db                	test   %ebx,%ebx
> >   3c:	74 37                	je     0x75
> >   3e:	8b                   	.byte 0x8b
> >   3f:	5b                   	pop    %rbx
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	8b 03                	mov    (%rbx),%eax
> >    2:	85 c0                	test   %eax,%eax
> >    4:	74 e8                	je     0xffffffffffffffee
> >    6:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
> >    b:	77 e1                	ja     0xffffffffffffffee
> >    d:	8b 58 04             	mov    0x4(%rax),%ebx
> >   10:	85 db                	test   %ebx,%ebx
> >   12:	74 37                	je     0x4b
> >   14:	8b                   	.byte 0x8b
> >   15:	5b                   	pop    %rbx
> > [   17.350847][    T7] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: c37cd6d8
> > [   17.352783][    T7] ESI: ffffffea EDI: f5b5a400 EBP: c4cffd24 ESP: c4cffd14
> > [   17.354673][    T7] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
> > [   17.362075][    T7] CR0: 80050033 CR2: 00000000 CR3: 04206000 CR4: 00000690
> > [   17.363993][    T7] Call Trace:
> > [ 17.365018][ T7] fwnode_find_reference (drivers/base/property.c:514) 
> > [ 17.366430][ T7] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
> > [ 17.367825][ T7] ? lockdep_init_map_type (kernel/locking/lockdep.c:4813) 
> > [ 17.369325][ T7] ? phylink_run_resolve+0x20/0x20 
> > [ 17.370897][ T7] ? init_timer_key (kernel/time/timer.c:818) 
> > [ 17.372228][ T7] fwnode_get_phy_node (drivers/net/phy/phy_device.c:2986) 
> > [ 17.373574][ T7] phylink_fwnode_phy_connect (drivers/net/phy/phylink.c:1180 drivers/net/phy/phylink.c:1166) 
> > [ 17.375014][ T7] phylink_of_phy_connect (drivers/net/phy/phylink.c:1152) 
> > [ 17.376373][ T7] dsa_slave_create (net/dsa/slave.c:1889 net/dsa/slave.c:2036) 
> > [ 17.377765][ T7] dsa_tree_setup_switches (net/dsa/dsa2.c:477 net/dsa/dsa2.c:977) 
> > [ 17.379282][ T7] dsa_register_switch (net/dsa/dsa2.c:1065 net/dsa/dsa2.c:1565 net/dsa/dsa2.c:1579) 
> > [ 17.380762][ T7] dsa_loop_drv_probe (drivers/net/dsa/dsa_loop.c:333) 
> > [ 17.382137][ T7] mdio_probe (drivers/net/phy/mdio_device.c:157) 

-- 
With Best Regards,
Andy Shevchenko


