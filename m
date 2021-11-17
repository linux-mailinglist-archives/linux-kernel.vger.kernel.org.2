Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18828453D07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 01:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhKQAOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 19:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhKQAN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:13:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBE4C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 16:11:01 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 133so602864wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 16:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=P5VBbu5gpml7/nB+fmey5Qx/z4xj+2aVSUGEnQWB7dc=;
        b=jHgGhcLrAMZdDk+0DGNZcZPFxcAM4JpjO40P9WM7PRH2iwWvt+j8JPJx232L/tPtyy
         f60v0G2ej0TbQCYfl0VV+ShUB1/PjIhIGlgNpj9lqegpkGfNzOFfkbGhZmA1Vohi3nWD
         ZIp4aQl6tqMpz8Wq73O8qcLk9AzptYdbz3D5Oe0azv+Il+ynglC1dYBHpKY8wg0DGSGZ
         siQyEJyHo3w9hQ6rDRCNQ3rJO4AIWKbivBchn9/jvWqN8g4u970dWPJlfaEWFoikDmgW
         hb1W5tSAGEqzIG+vCqYkKS4RbfV6TO3Xr8DgRr3ahwO0bbmMFgktDudegepTtAbO2KJD
         8VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P5VBbu5gpml7/nB+fmey5Qx/z4xj+2aVSUGEnQWB7dc=;
        b=saKlRiN1OTtdjbuho6BiN4pORlIgxWtpT7EParprQ+EEjwHObkzcuBLdmm09esf2mu
         +2K4ouNypUcDo53yh0jfk+7wEMlL+YhJUd+vg7Mi3TIEybARcUWnKejW/9gFrG8VHbFO
         jhNW/jPbDbCxSGiM1mnaRrcpL9EmB8+z9mHu1c7UB/Gzi8egr/t8GF5KDmB+LtVe0NFa
         YBNbThUtjubKnIqL/ebKXXYHL6K7Ep92GtrybY6sI6JliNlfXUctWyTk+Dvkb9g7gGPa
         Di/zsJ+onENDGl1TcksY1L5KEL9iczwbNf05TC6cUAiMXiIAVuUAY3aZjj2BL/coO6ep
         bdAw==
X-Gm-Message-State: AOAM531srzFWFRr7dZ7erjhA1Mmi9f9zQ8JC5Q2zb27sjsqAIzEtKK6x
        QaljnS/gdK8spOzmvx8ihQE=
X-Google-Smtp-Source: ABdhPJxp2gVPuNY+5GujR4oBcRM+6BtcTX1XdtM8kykxabaF1k48Ze2xS2GQiCuBaQOm6JFkxq3WHA==
X-Received: by 2002:a05:600c:4308:: with SMTP id p8mr50282937wme.132.1637107859831;
        Tue, 16 Nov 2021 16:10:59 -0800 (PST)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id u14sm18699469wrt.49.2021.11.16.16.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 16:10:59 -0800 (PST)
Subject: Re: [device property] 995fe757ec:
 BUG:kernel_NULL_pointer_dereference,address
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     kernel test robot <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
References: <20211116074104.GC32102@xsang-OptiPlex-9020>
 <f54546b1-b0dc-c2bc-3a5f-bcdaf35297fc@redhat.com>
 <YZPjf1GfZHR2ZjpD@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <606a6bf2-e971-ddfe-74b0-cbc2b76935ba@gmail.com>
Date:   Wed, 17 Nov 2021 00:10:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZPjf1GfZHR2ZjpD@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans, Andy

On 16/11/2021 16:59, Andy Shevchenko wrote:
> On Tue, Nov 16, 2021 at 03:55:00PM +0100, Hans de Goede wrote:
>> On 11/16/21 08:41, kernel test robot wrote:
>>> FYI, we noticed the following commit (built with gcc-9):
>>>
>>> commit: 995fe757ecaeac44e023458af64d27655f9dbf73 ("[PATCH] device property: Check fwnode->secondary when finding properties")
>>> url: https://github.com/0day-ci/linux/commits/Daniel-Scally/device-property-Check-fwnode-secondary-when-finding-properties/20211114-044259
>>> base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git b5013d084e03e82ceeab4db8ae8ceeaebe76b0eb
>>> patch link: https://lore.kernel.org/lkml/20211113204141.520924-1-djrscally@gmail.com
>>>
>>> in testcase: boot
>>>
>>> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>>>
>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>>
>>>
>>> +---------------------------------------------+------------+------------+
>>> |                                             | b5013d084e | 995fe757ec |
>>> +---------------------------------------------+------------+------------+
>>> | boot_successes                              | 23         | 0          |
>>> | boot_failures                               | 0          | 22         |
>>> | BUG:kernel_NULL_pointer_dereference,address | 0          | 22         |
>>> | Oops:#[##]                                  | 0          | 22         |
>>> | EIP:fwnode_property_get_reference_args      | 0          | 22         |
>>> | Kernel_panic-not_syncing:Fatal_exception    | 0          | 22         |
>>> +---------------------------------------------+------------+------------+
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Ok, so this patch likely needs a v2 which changes the if to this:
>>
>>         if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
>>             !IS_ERR_OR_NULL(fwnode->secondary))
>>                 ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
>>                                          prop, nargs_prop, nargs, index, args);
>>
>>
>> So that we check fwnode before dereferencing it, note this also changes the
>> (ret < 0) check to (ret == -EINVAL), this makes the secondary node handling
>> identical to fwnode_property_read_int_array() and
>> fwnode_property_read_string_array()
>>
>> Danny, can you send a v2 with this change please?
> Hmm... So, you are suggesting that we need to check it only for EINVAL and
> ENOENT in this case the one that brings us to the NULL pointer dereference.
> But I don't understand what's the difference here.


Sticking point; the ACPI version of .get_reference_args() returns
-ENOENT (converted from -EINVAL [1]) if the property you ask for doesn't
exist against that fwnode, which unless I'm missing something means this
won't work in our use case. This confused me for a while because we
definitely call fwnode_property_read_int_array() in sensor driver probes
through v4l2_fwnode_endpoint_alloc_parse(), but it turns out the ACPI
version of _that_ operation has no matching conversion of the error
code, so when that fails to find the property it sends back -EINVAL and
so the form that exists in fwnode_property_read_int_array() currently
works fine.


We could align them all to if (ret < 0 && !IS_ERR_OR_NULL(fwnode) &&
!IS_ERR_OR_NULL(fwnode->secondary)). This is probably my preferred
option, because I can't really see why we'd only want to do the
secondary check on -EINVAL anyway - but maybe I miss something here.
Alternatively we can take Hans suggestion so they all match the existing
code, but this means we have to handle that conversion first - I
couldn't see from a cursory look that any of the direct callers check
the value of the return beyond "is it 0?", but of course it could be
done somewhere in calls to the fwnode->ops->get_reference_args()
callback instead.


Thoughts?


[1]
https://elixir.bootlin.com/linux/latest/source/drivers/acpi/property.c#L680

>
>>> [   17.327851][    T7] BUG: kernel NULL pointer dereference, address: 00000000
>>> [   17.329758][    T7] #PF: supervisor read access in kernel mode
>>> [   17.331371][    T7] #PF: error_code(0x0000) - not-present page
>>> [   17.332992][    T7] *pde = 00000000
>>> [   17.334107][    T7] Oops: 0000 [#1] PREEMPT
>>> [   17.335310][    T7] CPU: 0 PID: 7 Comm: kworker/u2:0 Tainted: G S                5.15.0-11191-g995fe757ecae #1
>>> [   17.338036][    T7] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>>> [   17.340544][    T7] Workqueue: events_unbound deferred_probe_work_func
>>> [ 17.342291][ T7] EIP: fwnode_property_get_reference_args (drivers/base/property.c:486 (discriminator 1)) 
>>> [ 17.344051][ T7] Code: 8b 45 0c 50 8b 45 08 50 89 d8 89 55 f4 ff d6 83 c4 0c 89 c6 85 c0 78 55 8d 65 f8 89 f0 5b 5e 5d c3 8d 74 26 00 be fa ff ff ff <8b> 03 85 c0 74 e8 3d 00 f0 ff ff 77 e1 8b 58 04 85 db 74 37 8b 5b
>>> All code
>>> ========
>>>    0:	8b 45 0c             	mov    0xc(%rbp),%eax
>>>    3:	50                   	push   %rax
>>>    4:	8b 45 08             	mov    0x8(%rbp),%eax
>>>    7:	50                   	push   %rax
>>>    8:	89 d8                	mov    %ebx,%eax
>>>    a:	89 55 f4             	mov    %edx,-0xc(%rbp)
>>>    d:	ff d6                	callq  *%rsi
>>>    f:	83 c4 0c             	add    $0xc,%esp
>>>   12:	89 c6                	mov    %eax,%esi
>>>   14:	85 c0                	test   %eax,%eax
>>>   16:	78 55                	js     0x6d
>>>   18:	8d 65 f8             	lea    -0x8(%rbp),%esp
>>>   1b:	89 f0                	mov    %esi,%eax
>>>   1d:	5b                   	pop    %rbx
>>>   1e:	5e                   	pop    %rsi
>>>   1f:	5d                   	pop    %rbp
>>>   20:	c3                   	retq   
>>>   21:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
>>>   25:	be fa ff ff ff       	mov    $0xfffffffa,%esi
>>>   2a:*	8b 03                	mov    (%rbx),%eax		<-- trapping instruction
>>>   2c:	85 c0                	test   %eax,%eax
>>>   2e:	74 e8                	je     0x18
>>>   30:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
>>>   35:	77 e1                	ja     0x18
>>>   37:	8b 58 04             	mov    0x4(%rax),%ebx
>>>   3a:	85 db                	test   %ebx,%ebx
>>>   3c:	74 37                	je     0x75
>>>   3e:	8b                   	.byte 0x8b
>>>   3f:	5b                   	pop    %rbx
>>>
>>> Code starting with the faulting instruction
>>> ===========================================
>>>    0:	8b 03                	mov    (%rbx),%eax
>>>    2:	85 c0                	test   %eax,%eax
>>>    4:	74 e8                	je     0xffffffffffffffee
>>>    6:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
>>>    b:	77 e1                	ja     0xffffffffffffffee
>>>    d:	8b 58 04             	mov    0x4(%rax),%ebx
>>>   10:	85 db                	test   %ebx,%ebx
>>>   12:	74 37                	je     0x4b
>>>   14:	8b                   	.byte 0x8b
>>>   15:	5b                   	pop    %rbx
>>> [   17.350847][    T7] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: c37cd6d8
>>> [   17.352783][    T7] ESI: ffffffea EDI: f5b5a400 EBP: c4cffd24 ESP: c4cffd14
>>> [   17.354673][    T7] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
>>> [   17.362075][    T7] CR0: 80050033 CR2: 00000000 CR3: 04206000 CR4: 00000690
>>> [   17.363993][    T7] Call Trace:
>>> [ 17.365018][ T7] fwnode_find_reference (drivers/base/property.c:514) 
>>> [ 17.366430][ T7] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
>>> [ 17.367825][ T7] ? lockdep_init_map_type (kernel/locking/lockdep.c:4813) 
>>> [ 17.369325][ T7] ? phylink_run_resolve+0x20/0x20 
>>> [ 17.370897][ T7] ? init_timer_key (kernel/time/timer.c:818) 
>>> [ 17.372228][ T7] fwnode_get_phy_node (drivers/net/phy/phy_device.c:2986) 
>>> [ 17.373574][ T7] phylink_fwnode_phy_connect (drivers/net/phy/phylink.c:1180 drivers/net/phy/phylink.c:1166) 
>>> [ 17.375014][ T7] phylink_of_phy_connect (drivers/net/phy/phylink.c:1152) 
>>> [ 17.376373][ T7] dsa_slave_create (net/dsa/slave.c:1889 net/dsa/slave.c:2036) 
>>> [ 17.377765][ T7] dsa_tree_setup_switches (net/dsa/dsa2.c:477 net/dsa/dsa2.c:977) 
>>> [ 17.379282][ T7] dsa_register_switch (net/dsa/dsa2.c:1065 net/dsa/dsa2.c:1565 net/dsa/dsa2.c:1579) 
>>> [ 17.380762][ T7] dsa_loop_drv_probe (drivers/net/dsa/dsa_loop.c:333) 
>>> [ 17.382137][ T7] mdio_probe (drivers/net/phy/mdio_device.c:157) 
