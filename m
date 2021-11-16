Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF8F4534B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhKPO6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:58:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42416 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233685AbhKPO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637074503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJsdqckMpSrnjgsJbAncoNF9lWAO7/84piA2ZLXdMvk=;
        b=XcIcVbA0Y5/j/T5jolPhhl5k/42egTMbQPUl6EdbMpk7yftTkmZLzL+oYRCiO/juNyu4JP
        rUlpi8g7iy46kKSD/pebkGqAsnToGY/HgcV0tKHyX9XPSElxsAiYZ1dkyb5i56Tz+mY3Tb
        7kBoE5A+h4sl8Z8OgHYo1PGt4NoAhPE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-gJQXi4QpO326wQE1o_dong-1; Tue, 16 Nov 2021 09:55:02 -0500
X-MC-Unique: gJQXi4QpO326wQE1o_dong-1
Received: by mail-ed1-f71.google.com with SMTP id y9-20020aa7c249000000b003e7bf7a1579so6035176edo.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 06:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aJsdqckMpSrnjgsJbAncoNF9lWAO7/84piA2ZLXdMvk=;
        b=oB0MoDgQUn02r2vd5SoQCqzjdkLqozNZxoOevmAOEeNDuphZ0B06z+O7kADuGK+dZr
         jKqbr0UN1p98sSHUa/BH6MIviZwI02Ucu3cuLZSj6AxNSVggURl1ee1xo1PV1wjpXU8Q
         OJzJnl8tPsqpJ4mm0jdPqGY3auLIU3+6pJ3iLL8SpQAtGkFgRilIJGEeWKcVoa2S8Sch
         ENOuf7ivvTzvc14RP+vmSkHlRme6Q8dvBib/zstkkTSu46aaOqVPJhAV09MU1P4oZ9Mj
         7gVmr8V6y2B/z0yNuJTlqm4xeIMfWOTnjtYCMY+BP0ji6Pc4mihXEGLJGGIs8eKUwxyB
         6VBA==
X-Gm-Message-State: AOAM531rgOXgzXXbZHys5duBslQzZyH9AwWNlSMZ79YGSxLAIAYXl0Uf
        hGmm0EXVfADmYjAhfJ/JaRKTk02+tXiBwXzpKhG21cvWc/9E6Dm2Z7uQXTYnJx7+yG0xYsxXIsF
        uQtFUa8hS5Voqq7IbbfQZ0JFn
X-Received: by 2002:a17:907:7850:: with SMTP id lb16mr10773091ejc.67.1637074501309;
        Tue, 16 Nov 2021 06:55:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuubmLlbRPpMLaXbB55egMjZQjbrU8Iv0RwixL6xLUvtTh1WVnaG2lAjC4K9g+JVxyCXsWPA==
X-Received: by 2002:a17:907:7850:: with SMTP id lb16mr10773053ejc.67.1637074501058;
        Tue, 16 Nov 2021 06:55:01 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u16sm8308560ejy.16.2021.11.16.06.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 06:55:00 -0800 (PST)
Message-ID: <f54546b1-b0dc-c2bc-3a5f-bcdaf35297fc@redhat.com>
Date:   Tue, 16 Nov 2021 15:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [device property] 995fe757ec:
 BUG:kernel_NULL_pointer_dereference,address
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Daniel Scally <djrscally@gmail.com>
Cc:     lkp@lists.01.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20211116074104.GC32102@xsang-OptiPlex-9020>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211116074104.GC32102@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/16/21 08:41, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 995fe757ecaeac44e023458af64d27655f9dbf73 ("[PATCH] device property: Check fwnode->secondary when finding properties")
> url: https://github.com/0day-ci/linux/commits/Daniel-Scally/device-property-Check-fwnode-secondary-when-finding-properties/20211114-044259
> base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git b5013d084e03e82ceeab4db8ae8ceeaebe76b0eb
> patch link: https://lore.kernel.org/lkml/20211113204141.520924-1-djrscally@gmail.com
> 
> in testcase: boot
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +---------------------------------------------+------------+------------+
> |                                             | b5013d084e | 995fe757ec |
> +---------------------------------------------+------------+------------+
> | boot_successes                              | 23         | 0          |
> | boot_failures                               | 0          | 22         |
> | BUG:kernel_NULL_pointer_dereference,address | 0          | 22         |
> | Oops:#[##]                                  | 0          | 22         |
> | EIP:fwnode_property_get_reference_args      | 0          | 22         |
> | Kernel_panic-not_syncing:Fatal_exception    | 0          | 22         |
> +---------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>

Ok, so this patch likely needs a v2 which changes the if to this:

        if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
            !IS_ERR_OR_NULL(fwnode->secondary))
                ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
                                         prop, nargs_prop, nargs, index, args);


So that we check fwnode before dereferencing it, note this also changes the
(ret < 0) check to (ret == -EINVAL), this makes the secondary node handling
identical to fwnode_property_read_int_array() and
fwnode_property_read_string_array()

Danny, can you send a v2 with this change please?

Regards,

Hans






> 
> 
> [   17.327851][    T7] BUG: kernel NULL pointer dereference, address: 00000000
> [   17.329758][    T7] #PF: supervisor read access in kernel mode
> [   17.331371][    T7] #PF: error_code(0x0000) - not-present page
> [   17.332992][    T7] *pde = 00000000
> [   17.334107][    T7] Oops: 0000 [#1] PREEMPT
> [   17.335310][    T7] CPU: 0 PID: 7 Comm: kworker/u2:0 Tainted: G S                5.15.0-11191-g995fe757ecae #1
> [   17.338036][    T7] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   17.340544][    T7] Workqueue: events_unbound deferred_probe_work_func
> [ 17.342291][ T7] EIP: fwnode_property_get_reference_args (drivers/base/property.c:486 (discriminator 1)) 
> [ 17.344051][ T7] Code: 8b 45 0c 50 8b 45 08 50 89 d8 89 55 f4 ff d6 83 c4 0c 89 c6 85 c0 78 55 8d 65 f8 89 f0 5b 5e 5d c3 8d 74 26 00 be fa ff ff ff <8b> 03 85 c0 74 e8 3d 00 f0 ff ff 77 e1 8b 58 04 85 db 74 37 8b 5b
> All code
> ========
>    0:	8b 45 0c             	mov    0xc(%rbp),%eax
>    3:	50                   	push   %rax
>    4:	8b 45 08             	mov    0x8(%rbp),%eax
>    7:	50                   	push   %rax
>    8:	89 d8                	mov    %ebx,%eax
>    a:	89 55 f4             	mov    %edx,-0xc(%rbp)
>    d:	ff d6                	callq  *%rsi
>    f:	83 c4 0c             	add    $0xc,%esp
>   12:	89 c6                	mov    %eax,%esi
>   14:	85 c0                	test   %eax,%eax
>   16:	78 55                	js     0x6d
>   18:	8d 65 f8             	lea    -0x8(%rbp),%esp
>   1b:	89 f0                	mov    %esi,%eax
>   1d:	5b                   	pop    %rbx
>   1e:	5e                   	pop    %rsi
>   1f:	5d                   	pop    %rbp
>   20:	c3                   	retq   
>   21:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>   25:	be fa ff ff ff       	mov    $0xfffffffa,%esi
>   2a:*	8b 03                	mov    (%rbx),%eax		<-- trapping instruction
>   2c:	85 c0                	test   %eax,%eax
>   2e:	74 e8                	je     0x18
>   30:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
>   35:	77 e1                	ja     0x18
>   37:	8b 58 04             	mov    0x4(%rax),%ebx
>   3a:	85 db                	test   %ebx,%ebx
>   3c:	74 37                	je     0x75
>   3e:	8b                   	.byte 0x8b
>   3f:	5b                   	pop    %rbx
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	8b 03                	mov    (%rbx),%eax
>    2:	85 c0                	test   %eax,%eax
>    4:	74 e8                	je     0xffffffffffffffee
>    6:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
>    b:	77 e1                	ja     0xffffffffffffffee
>    d:	8b 58 04             	mov    0x4(%rax),%ebx
>   10:	85 db                	test   %ebx,%ebx
>   12:	74 37                	je     0x4b
>   14:	8b                   	.byte 0x8b
>   15:	5b                   	pop    %rbx
> [   17.350847][    T7] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: c37cd6d8
> [   17.352783][    T7] ESI: ffffffea EDI: f5b5a400 EBP: c4cffd24 ESP: c4cffd14
> [   17.354673][    T7] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
> [   17.362075][    T7] CR0: 80050033 CR2: 00000000 CR3: 04206000 CR4: 00000690
> [   17.363993][    T7] Call Trace:
> [ 17.365018][ T7] fwnode_find_reference (drivers/base/property.c:514) 
> [ 17.366430][ T7] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
> [ 17.367825][ T7] ? lockdep_init_map_type (kernel/locking/lockdep.c:4813) 
> [ 17.369325][ T7] ? phylink_run_resolve+0x20/0x20 
> [ 17.370897][ T7] ? init_timer_key (kernel/time/timer.c:818) 
> [ 17.372228][ T7] fwnode_get_phy_node (drivers/net/phy/phy_device.c:2986) 
> [ 17.373574][ T7] phylink_fwnode_phy_connect (drivers/net/phy/phylink.c:1180 drivers/net/phy/phylink.c:1166) 
> [ 17.375014][ T7] phylink_of_phy_connect (drivers/net/phy/phylink.c:1152) 
> [ 17.376373][ T7] dsa_slave_create (net/dsa/slave.c:1889 net/dsa/slave.c:2036) 
> [ 17.377765][ T7] dsa_tree_setup_switches (net/dsa/dsa2.c:477 net/dsa/dsa2.c:977) 
> [ 17.379282][ T7] dsa_register_switch (net/dsa/dsa2.c:1065 net/dsa/dsa2.c:1565 net/dsa/dsa2.c:1579) 
> [ 17.380762][ T7] dsa_loop_drv_probe (drivers/net/dsa/dsa_loop.c:333) 
> [ 17.382137][ T7] mdio_probe (drivers/net/phy/mdio_device.c:157) 
> [ 17.383362][ T7] really_probe (drivers/base/dd.c:744) 
> [ 17.384808][ T7] really_probe (drivers/base/dd.c:678) 
> [ 17.385999][ T7] __driver_probe_device (drivers/base/dd.c:751) 
> [ 17.387393][ T7] driver_probe_device (drivers/base/dd.c:781) 
> [ 17.388787][ T7] __device_attach_driver (drivers/base/dd.c:899) 
> [ 17.390253][ T7] ? driver_allows_async_probing (drivers/base/dd.c:867) 
> [ 17.391829][ T7] bus_for_each_drv (drivers/base/bus.c:427) 
> [ 17.393226][ T7] __device_attach (drivers/base/dd.c:969) 
> [ 17.394610][ T7] ? driver_allows_async_probing (drivers/base/dd.c:867) 
> [ 17.396270][ T7] device_initial_probe (drivers/base/dd.c:1017) 
> [ 17.397637][ T7] bus_probe_device (drivers/base/bus.c:487) 
> [ 17.398907][ T7] deferred_probe_work_func (drivers/base/dd.c:123) 
> [ 17.400385][ T7] process_one_work (arch/x86/include/asm/jump_label.h:41 include/linux/jump_label.h:212 include/trace/events/workqueue.h:108 kernel/workqueue.c:2303) 
> [ 17.401834][ T7] worker_thread (include/linux/list.h:282 kernel/workqueue.c:2358 kernel/workqueue.c:2450) 
> [ 17.403204][ T7] kthread (kernel/kthread.c:327) 
> [ 17.404417][ T7] ? process_one_work (kernel/workqueue.c:2388) 
> [ 17.405766][ T7] ? set_kthread_struct (kernel/kthread.c:272) 
> [ 17.407168][ T7] ret_from_fork (arch/x86/entry/entry_32.S:775) 
> [   17.408421][    T7] Modules linked in:
> [   17.409637][    T7] CR2: 0000000000000000
> [   17.410743][    T7] ---[ end trace f8ecb8c3f56e69be ]---
> [ 17.412229][ T7] EIP: fwnode_property_get_reference_args (drivers/base/property.c:486 (discriminator 1)) 
> [ 17.414104][ T7] Code: 8b 45 0c 50 8b 45 08 50 89 d8 89 55 f4 ff d6 83 c4 0c 89 c6 85 c0 78 55 8d 65 f8 89 f0 5b 5e 5d c3 8d 74 26 00 be fa ff ff ff <8b> 03 85 c0 74 e8 3d 00 f0 ff ff 77 e1 8b 58 04 85 db 74 37 8b 5b
> All code
> ========
>    0:	8b 45 0c             	mov    0xc(%rbp),%eax
>    3:	50                   	push   %rax
>    4:	8b 45 08             	mov    0x8(%rbp),%eax
>    7:	50                   	push   %rax
>    8:	89 d8                	mov    %ebx,%eax
>    a:	89 55 f4             	mov    %edx,-0xc(%rbp)
>    d:	ff d6                	callq  *%rsi
>    f:	83 c4 0c             	add    $0xc,%esp
>   12:	89 c6                	mov    %eax,%esi
>   14:	85 c0                	test   %eax,%eax
>   16:	78 55                	js     0x6d
>   18:	8d 65 f8             	lea    -0x8(%rbp),%esp
>   1b:	89 f0                	mov    %esi,%eax
>   1d:	5b                   	pop    %rbx
>   1e:	5e                   	pop    %rsi
>   1f:	5d                   	pop    %rbp
>   20:	c3                   	retq   
>   21:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>   25:	be fa ff ff ff       	mov    $0xfffffffa,%esi
>   2a:*	8b 03                	mov    (%rbx),%eax		<-- trapping instruction
>   2c:	85 c0                	test   %eax,%eax
>   2e:	74 e8                	je     0x18
>   30:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
>   35:	77 e1                	ja     0x18
>   37:	8b 58 04             	mov    0x4(%rax),%ebx
>   3a:	85 db                	test   %ebx,%ebx
>   3c:	74 37                	je     0x75
>   3e:	8b                   	.byte 0x8b
>   3f:	5b                   	pop    %rbx
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	8b 03                	mov    (%rbx),%eax
>    2:	85 c0                	test   %eax,%eax
>    4:	74 e8                	je     0xffffffffffffffee
>    6:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
>    b:	77 e1                	ja     0xffffffffffffffee
>    d:	8b 58 04             	mov    0x4(%rax),%ebx
>   10:	85 db                	test   %ebx,%ebx
>   12:	74 37                	je     0x4b
>   14:	8b                   	.byte 0x8b
>   15:	5b                   	pop    %rbx
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.15.0-11191-g995fe757ecae .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 

