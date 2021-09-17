Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581B340EF2D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 04:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242720AbhIQCWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 22:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhIQCWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 22:22:32 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC7CC061574;
        Thu, 16 Sep 2021 19:21:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j6so7758448pfa.4;
        Thu, 16 Sep 2021 19:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yNer32S3VdZfnkk5lNb33b2jqu1cbV3VwHRQ/8k0xh8=;
        b=ViR1TWGqeM9UYHVXzKNI0aBuq9X29TkQf1A1/mUD1xQh2TR1cRbuQeTj4PCIFPGKAN
         48gTwDuSPsEf7VEWc+2+i24aJgzGOb8UoO3oFFgpXaXyjHz3TCag8NvEMbJ6n05fHCrK
         qSVZK63wvRqpiOFwcGpq9tQnCFCwYY9osoZMxj27oFpnT+kAVhf55Gg8yZFJ8VCs+y8l
         nHIu35pTPoG0zWr+g1N/sgq/K9g9Pq1SBlmCe9bdwddWV/DoOcw4pX4irjUap2sJJlQf
         JQV4ZP6eIn0c5TJMWVq/f5N63F2nfJe/BqYOw5OE5MK65XoUcscbTJIMB21qJvgYIoiQ
         679g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yNer32S3VdZfnkk5lNb33b2jqu1cbV3VwHRQ/8k0xh8=;
        b=DNvXU5eOFlzWlHoIh6BpG4yOfLSkk6WtkfI6uJwhAasgdV1fM9S48uo7JeAgtIUbx3
         z5zBTVu25+3M0qkQ6l4fiR5gqJzyz/Ksa9sgxivB4R6pyiQw1yRT2y51BQ5becctq8lV
         vOLrAD1NzmTiCO7ODSs7Y5Bs3m4I4VVSCqzfRXKegpMsO/abdMDTtSKaJOxKTZFlnHBO
         rz0WhAsah0M3n44DMkwJL/Kv/+VVuwYl9uXHget8h73Kdg3M6S74bDlGTc+CAnAZ5Z2U
         FfLZRX+mUGmFMXWX0c84MSjN/nCgG72g4jNx++e9hihfD4ZZI3cwl8YvmXdhpEtqcv1p
         5/6w==
X-Gm-Message-State: AOAM530KhqHjPwVxs8y8HVqiuJvW2YbxqoDo62sdIqjXD9qQ9h3PJwBT
        cdzYajNKkG91JY+uUXxHR4k=
X-Google-Smtp-Source: ABdhPJxTXiZf8fgd+ooaxqyK2h4q3q6amxbnkteWkfhSEROXcDV8IoHjOcBSYbl7I+2shskdZ0D43A==
X-Received: by 2002:a63:3748:: with SMTP id g8mr7758562pgn.102.1631845270348;
        Thu, 16 Sep 2021 19:21:10 -0700 (PDT)
Received: from [10.230.31.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h4sm4505454pjc.28.2021.09.16.19.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 19:21:09 -0700 (PDT)
Message-ID: <45576ceb-562c-9ca7-3ef4-31add52b2168@gmail.com>
Date:   Thu, 16 Sep 2021 19:21:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] Revert "of: property: fw_devlink: Add support for
 "phy-handle" property"
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210915081933.485112-1-saravanak@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210915081933.485112-1-saravanak@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/2021 1:19 AM, Saravana Kannan wrote:
> This reverts commit cf4b94c8530d14017fbddae26aad064ddc42edd4.
> 
> Some PHYs pointed to by "phy-handle" will never bind to a driver until a
> consumer attaches to it. And when the consumer attaches to it, they get
> forcefully bound to a generic PHY driver. In such cases, parsing the
> phy-handle property and creating a device link will prevent the consumer
> from ever probing. We don't want that. So revert support for
> "phy-handle" property until we come up with a better mechanism for
> binding PHYs to generic drivers before a consumer tries to attach to it.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Thanks for getting this revert submitted, I just ran a bisection this 
afternoon that pointed to this offending commit. It would cause the dead 
lock on boot with drivers/net/dsa/bcm_sf2.c pasted below. Saravana, can 
you CC on me on your fix or what you would want me to be testing?

Rob can you send this to Linus quickly so we can have it in net/master 
soon thereafter? Thanks a lot!

[    3.577221] unimac-mdio f0b403c0.mdio: Broadcom UniMAC MDIO bus
[    4.480608]  sda: sda1 sda2 sda3 sda4
[    4.486248] sd 0:0:0:0: [sda] Attached SCSI disk
[   25.492127] rcu: INFO: rcu_sched self-detected stall on CPU
[   25.497722] rcu:     2-....: (21000 ticks this GP) 
idle=3e2/1/0x40000002 softirq=292/292 fqs=5240
[   25.506448]  (t=21015 jiffies g=-395 q=69)
[   25.510560] NMI backtrace for cpu 2
[   25.514062] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 
5.14.0-rc1-gcf4b94c8530d #100
[   25.521739] Hardware name: Broadcom STB (Flattened Device Tree)
[   25.527672] Backtrace:
[   25.530131] [<c0cba30c>] (dump_backtrace) from [<c0cba5bc>] 
(show_stack+0x20/0x24)
[   25.537741]  r7:c0e021cc r6:00000002 r5:c0f71914 r4:60000193
[   25.543412] [<c0cba59c>] (show_stack) from [<c0cbf5f4>] 
(dump_stack_lvl+0x48/0x54)
[   25.551009] [<c0cbf5ac>] (dump_stack_lvl) from [<c0cbf618>] 
(dump_stack+0x18/0x1c)
[   25.558602]  r5:00000000 r4:00000002
[   25.562187] [<c0cbf600>] (dump_stack) from [<c06bf89c>] 
(nmi_cpu_backtrace+0xc8/0xf4)
[   25.570045] [<c06bf7d4>] (nmi_cpu_backtrace) from [<c06bf9f0>] 
(nmi_trigger_cpumask_backtrace+0x128/0x140)
[   25.579729]  r5:c22056e0 r4:c020ff84
[   25.583313] [<c06bf8c8>] (nmi_trigger_cpumask_backtrace) from 
[<c02111c0>] (arch_trigger_cpumask_backtrace+0x20/0x24)
[   25.593957]  r7:00000002 r6:c230e186 r5:c2204e0c r4:c2249d00
[   25.599629] [<c02111a0>] (arch_trigger_cpumask_backtrace) from 
[<c0cbbf00>] (rcu_dump_cpu_stacks+0x14c/0x17c)
[   25.609573] [<c0cbbdb4>] (rcu_dump_cpu_stacks) from [<c02a3adc>] 
(rcu_sched_clock_irq+0x708/0xa80)
[   25.618562]  r10:2df0b000 r9:00000000 r8:c2203d00 r7:c20bbfc0 
r6:c230eec0 r5:effc6fc0
[   25.626411]  r4:c2249d00
[   25.628950] [<c02a33d4>] (rcu_sched_clock_irq) from [<c02b15e8>] 
(update_process_times+0xb0/0xdc)
[   25.637852]  r10:c02c5bf4 r9:effc08c0 r8:effc0880 r7:00000005 
r6:00000000 r5:c2203d00
[   25.645700]  r4:effbf580
[   25.648239] [<c02b1538>] (update_process_times) from [<c02c5878>] 
(tick_sched_handle+0x64/0x68)
[   25.656967]  r7:00000005 r6:eef70001 r5:c2573bb8 r4:effc0be8
[   25.662638] [<c02c5814>] (tick_sched_handle) from [<c02c5c50>] 
(tick_sched_timer+0x5c/0xb8)
[   25.671015] [<c02c5bf4>] (tick_sched_timer) from [<c02b2544>] 
(__hrtimer_run_queues+0x1bc/0x35c)
[   25.679829]  r7:c230f280 r6:c230f2a0 r5:effc0880 r4:effc0be8
[   25.685501] [<c02b2388>] (__hrtimer_run_queues) from [<c02b3308>] 
(hrtimer_interrupt+0x130/0x2b8)
[   25.694400]  r10:effc09d0 r9:effc0a00 r8:ffffffff r7:7fffffff 
r6:00000003 r5:20000193
[   25.702247]  r4:effc0880
[   25.704786] [<c02b31d8>] (hrtimer_interrupt) from [<c0a08884>] 
(arch_timer_handler_phys+0x38/0x40)
[   25.713779]  r10:c0fd74f8 r9:c20ba51c r8:c2573bb8 r7:00000024 
r6:c251d940 r5:c22056fc
[   25.721625]  r4:c2520c00
[   25.724167] [<c0a0884c>] (arch_timer_handler_phys) from [<c028d760>] 
(handle_percpu_devid_irq+0x9c/0x214)
[   25.733763] [<c028d6c4>] (handle_percpu_devid_irq) from [<c0287074>] 
(handle_domain_irq+0x6c/0x88)
[   25.742754]  r7:0000001e r6:00000000 r5:00000000 r4:c20ba510
[   25.748425] [<c0287008>] (handle_domain_irq) from [<c02012cc>] 
(gic_handle_irq+0x8c/0xa0)
[   25.756632]  r7:f080200c r6:f0802000 r5:c22b8bd4 r4:c22056fc
[   25.762304] [<c0201240>] (gic_handle_irq) from [<c0200b38>] 
(__irq_svc+0x58/0x74)
[   25.769809] Exception stack(0xc2573bb8 to 0xc2573c00)
[   25.774874] 3ba0: 
    c22c268c 00000000
[   25.783072] 3bc0: 00000000 c25b8000 c43f2400 00000000 c22d083c 
c2204d08 c4530578 efff4160
[   25.791269] 3be0: c0fd74f8 c2573c14 c2573c18 c2573c08 c07b0fe8 
c0ccd024 60000013 ffffffff
[   25.799467]  r9:c2572000 r8:c4530578 r7:c2573bec r6:ffffffff 
r5:60000013 r4:c0ccd024
[   25.807226] [<c0cccfe4>] (mutex_lock) from [<c07b0fe8>] 
(device_links_busy+0x20/0x90)
[   25.815085] [<c07b0fc8>] (device_links_busy) from [<c07b6990>] 
(device_release_driver_internal+0x94/0x1c8)
[   25.824767]  r5:00000000 r4:c43f2400
[   25.828352] [<c07b68fc>] (device_release_driver_internal) from 
[<c07b6ae4>] (device_release_driver+0x20/0x24)
[   25.838295]  r7:c2204d08 r6:c22cd174 r5:c43f2400 r4:c2e7f030
[   25.843967] [<c07b6ac4>] (device_release_driver) from [<c07b4bac>] 
(bus_remove_device+0xf0/0x148)
[   25.852866] [<c07b4abc>] (bus_remove_device) from [<c07af544>] 
(device_del+0x18c/0x3f8)
[   25.860895]  r7:c2204d08 r6:c2573d20 r5:c43f2444 r4:c43f2400
[   25.866566] [<c07af3b8>] (device_del) from [<c0899dec>] 
(phy_device_remove+0x1c/0x34)
[   25.874422]  r10:c0fd74f8 r9:efff4160 r8:c2204d08 r7:c2cb1240 
r6:c2573d20 r5:efff43c0
[   25.882268]  r4:c43f2400
[   25.884810] [<c0899dd0>] (phy_device_remove) from [<c08a4014>] 
(bcm_sf2_sw_probe+0x640/0x900)
[   25.893363]  r5:efff43c0 r4:c2cb1240
[   25.896947] [<c08a39d4>] (bcm_sf2_sw_probe) from [<c07b8e44>] 
(platform_probe+0x6c/0xc8)
[   25.905069]  r10:c2331000 r9:c1253854 r8:00000000 r7:c22d0aa8 
r6:c22d0aa8 r5:00000000
[   25.912917]  r4:c25eb010
[   25.915457] [<c07b8dd8>] (platform_probe) from [<c07b5ca8>] 
(really_probe+0xe8/0x45c)
[   25.923314]  r7:c22d0aa8 r6:c231d168 r5:00000000 r4:c25eb010
[   25.928985] [<c07b5bc0>] (really_probe) from [<c07b60cc>] 
(__driver_probe_device+0xb0/0x230)
[   25.937451]  r7:c231d168 r6:c22d0aa8 r5:c22d0aa8 r4:c25eb010
[   25.943123] [<c07b601c>] (__driver_probe_device) from [<c07b6290>] 
(driver_probe_device+0x44/0xd4)
[   25.952111]  r9:c1253854 r8:00000000 r7:c25eb010 r6:c22d0aa8 
r5:c236c21c r4:c236c218
[   25.959871] [<c07b624c>] (driver_probe_device) from [<c07b6830>] 
(__driver_attach+0xdc/0x188)
[   25.968424]  r9:c1253854 r8:ffffe000 r7:c07b6754 r6:c22d0aa8 
r5:00000000 r4:c25eb010
[   25.976183] [<c07b6754>] (__driver_attach) from [<c07b3a68>] 
(bus_for_each_dev+0x84/0xc4)
[   25.984387]  r7:c07b6754 r6:c22d0aa8 r5:c2204d08 r4:c2e4d4b4
[   25.990059] [<c07b39e4>] (bus_for_each_dev) from [<c07b5510>] 
(driver_attach+0x2c/0x30)
[   25.998088]  r7:00000000 r6:c2780a00 r5:c22c2a68 r4:c22d0aa8
[   26.003759] [<c07b54e4>] (driver_attach) from [<c07b4dd4>] 
(bus_add_driver+0x1d0/0x210)
[   26.011787] [<c07b4c04>] (bus_add_driver) from [<c07b739c>] 
(driver_register+0x84/0x118)
[   26.019904]  r7:00000000 r6:c122ae8c r5:c2204d08 r4:c22d0aa8
[   26.025574] [<c07b7318>] (driver_register) from [<c07b8a90>] 
(__platform_driver_register+0x2c/0x34)
[   26.034648]  r5:c2204d08 r4:c230e780
[   26.038232] [<c07b8a64>] (__platform_driver_register) from 
[<c122aeb0>] (bcm_sf2_driver_init+0x24/0x28)
[   26.047655] [<c122ae8c>] (bcm_sf2_driver_init) from [<c0202180>] 
(do_one_initcall+0x64/0x254)
[   26.056206] [<c020211c>] (do_one_initcall) from [<c12014f4>] 
(kernel_init_freeable+0x1e0/0x238)
[   26.064935]  r8:00000007 r7:c26f4900 r6:c1253834 r5:00000119 r4:c1289ab8
[   26.071650] [<c1201314>] (kernel_init_freeable) from [<c0cc7918>] 
(kernel_init+0x20/0x138)
[   26.079946]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 
r6:00000000 r5:c0cc78f8
[   26.087794]  r4:00000000
[   26.090334] [<c0cc78f8>] (kernel_init) from [<c0200140>] 
(ret_from_fork+0x14/0x34)
[   26.097927] Exception stack(0xc2573fb0 to 0xc2573ff8)
[   26.102992] 3fa0:                                     00000000 
00000000 00000000 00000000
[   26.111188] 3fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[   26.119385] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   26.126013]  r5:c0cc78f8 r4:00000000
[   88.495125] rcu: INFO: rcu_sched self-detected stall on CPU
[   88.500716] rcu:     2-....: (83367 ticks this GP) 
idle=3e2/1/0x40000002 softirq=292/292 fqs=20831
[   88.509526]  (t=84018 jiffies g=-395 q=69)
[   88.513637] NMI backtrace for cpu 2
[   88.517136] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 
5.14.0-rc1-gcf4b94c8530d #100
[   88.524812] Hardware name: Broadcom STB (Flattened Device Tree)
[   88.530745] Backtrace:
[   88.533203] [<c0cba30c>] (dump_backtrace) from [<c0cba5bc>] 
(show_stack+0x20/0x24)
[   88.540803]  r7:c0e021cc r6:00000002 r5:c0f71914 r4:60000193
[   88.546475] [<c0cba59c>] (show_stack) from [<c0cbf5f4>] 
(dump_stack_lvl+0x48/0x54)
[   88.554069] [<c0cbf5ac>] (dump_stack_lvl) from [<c0cbf618>] 
(dump_stack+0x18/0x1c)
[   88.561662]  r5:00000000 r4:00000002
[   88.565246] [<c0cbf600>] (dump_stack) from [<c06bf89c>] 
(nmi_cpu_backtrace+0xc8/0xf4)
[   88.573100] [<c06bf7d4>] (nmi_cpu_backtrace) from [<c06bf9f0>] 
(nmi_trigger_cpumask_backtrace+0x128/0x140)
[   88.582782]  r5:c22056e0 r4:c020ff84
[   88.586367] [<c06bf8c8>] (nmi_trigger_cpumask_backtrace) from 
[<c02111c0>] (arch_trigger_cpumask_backtrace+0x20/0x24)
[   88.597007]  r7:00000002 r6:c230e186 r5:c2204e0c r4:c2249d00
[   88.602679] [<c02111a0>] (arch_trigger_cpumask_backtrace) from 
[<c0cbbf00>] (rcu_dump_cpu_stacks+0x14c/0x17c)
[   88.612622] [<c0cbbdb4>] (rcu_dump_cpu_stacks) from [<c02a3adc>] 
(rcu_sched_clock_irq+0x708/0xa80)
[   88.621610]  r10:2df0b000 r9:00000000 r8:c2203d00 r7:c20bbfc0 
r6:c230eec0 r5:effc6fc0
[   88.629456]  r4:c2249d00
[   88.631995] [<c02a33d4>] (rcu_sched_clock_irq) from [<c02b15e8>] 
(update_process_times+0xb0/0xdc)
[   88.640894]  r10:c02c5bf4 r9:effc08c0 r8:effc0880 r7:00000014 
r6:00000000 r5:c2203d00
[   88.648742]  r4:effbf580
[   88.651283] [<c02b1538>] (update_process_times) from [<c02c5878>] 
(tick_sched_handle+0x64/0x68)
[   88.660009]  r7:00000014 r6:9a3c7c9b r5:c2573ba8 r4:effc0be8
[   88.665680] [<c02c5814>] (tick_sched_handle) from [<c02c5c50>] 
(tick_sched_timer+0x5c/0xb8)
[   88.674057] [<c02c5bf4>] (tick_sched_timer) from [<c02b2544>] 
(__hrtimer_run_queues+0x1bc/0x35c)
[   88.682870]  r7:c230f280 r6:c230f2a0 r5:effc0880 r4:effc0be8
[   88.688540] [<c02b2388>] (__hrtimer_run_queues) from [<c02b3308>] 
(hrtimer_interrupt+0x130/0x2b8)
[   88.697439]  r10:effc09d0 r9:effc0a00 r8:ffffffff r7:7fffffff 
r6:00000003 r5:20000193
[   88.705285]  r4:effc0880
[   88.707826] [<c02b31d8>] (hrtimer_interrupt) from [<c0a08884>] 
(arch_timer_handler_phys+0x38/0x40)
[   88.716815]  r10:c0fd74f8 r9:c20ba51c r8:c2573ba8 r7:00000024 
r6:c251d940 r5:c22056fc
[   88.724662]  r4:c2520c00
[   88.727201] [<c0a0884c>] (arch_timer_handler_phys) from [<c028d760>] 
(handle_percpu_devid_irq+0x9c/0x214)
[   88.736797] [<c028d6c4>] (handle_percpu_devid_irq) from [<c0287074>] 
(handle_domain_irq+0x6c/0x88)
[   88.745785]  r7:0000001e r6:00000000 r5:00000000 r4:c20ba510
[   88.751455] [<c0287008>] (handle_domain_irq) from [<c02012cc>] 
(gic_handle_irq+0x8c/0xa0)
[   88.759659]  r7:f080200c r6:f0802000 r5:c22b8bd4 r4:c22056fc
[   88.765330] [<c0201240>] (gic_handle_irq) from [<c0200b38>] 
(__irq_svc+0x58/0x74)
[   88.772835] Exception stack(0xc2573ba8 to 0xc2573bf0)
[   88.777900] 3ba0:                   c22c268c 00000000 00000000 
c25b8000 c43f2460 00000004
[   88.786097] 3bc0: c22c268c c43f2400 c4530578 efff4160 c0fd74f8 
c2573c04 c2573c08 c2573bf8
[   88.794293] 3be0: c07b10d4 c0ccbe44 60000013 ffffffff
[   88.799358]  r9:c2572000 r8:c4530578 r7:c2573bdc r6:ffffffff 
r5:60000013 r4:c0ccbe44
[   88.807116] [<c0ccbe14>] (mutex_unlock) from [<c07b10d4>] 
(device_links_unbind_consumers+0x7c/0xe8)
[   88.816187] [<c07b1058>] (device_links_unbind_consumers) from 
[<c07b6970>] (device_release_driver_internal+0x74/0x1c8)
[   88.826914]  r9:efff4160 r8:c4530578 r7:c2204d08 r6:c22d083c 
r5:00000000 r4:c43f2400
[   88.834672] [<c07b68fc>] (device_release_driver_internal) from 
[<c07b6ae4>] (device_release_driver+0x20/0x24)
[   88.844617]  r7:c2204d08 r6:c22cd174 r5:c43f2400 r4:c2e7f030
[   88.850287] [<c07b6ac4>] (device_release_driver) from [<c07b4bac>] 
(bus_remove_device+0xf0/0x148)
[   88.859186] [<c07b4abc>] (bus_remove_device) from [<c07af544>] 
(device_del+0x18c/0x3f8)
[   88.867214]  r7:c2204d08 r6:c2573d20 r5:c43f2444 r4:c43f2400
[   88.872884] [<c07af3b8>] (device_del) from [<c0899dec>] 
(phy_device_remove+0x1c/0x34)
[   88.880739]  r10:c0fd74f8 r9:efff4160 r8:c2204d08 r7:c2cb1240 
r6:c2573d20 r5:efff43c0
[   88.888585]  r4:c43f2400
[   88.891124] [<c0899dd0>] (phy_device_remove) from [<c08a4014>] 
(bcm_sf2_sw_probe+0x640/0x900)
[   88.899677]  r5:efff43c0 r4:c2cb1240
[   88.903261] [<c08a39d4>] (bcm_sf2_sw_probe) from [<c07b8e44>] 
(platform_probe+0x6c/0xc8)
[   88.911381]  r10:c2331000 r9:c1253854 r8:00000000 r7:c22d0aa8 
r6:c22d0aa8 r5:00000000
[   88.919228]  r4:c25eb010
[   88.921767] [<c07b8dd8>] (platform_probe) from [<c07b5ca8>] 
(really_probe+0xe8/0x45c)
[   88.929625]  r7:c22d0aa8 r6:c231d168 r5:00000000 r4:c25eb010
[   88.935297] [<c07b5bc0>] (really_probe) from [<c07b60cc>] 
(__driver_probe_device+0xb0/0x230)
[   88.943761]  r7:c231d168 r6:c22d0aa8 r5:c22d0aa8 r4:c25eb010
[   88.949431] [<c07b601c>] (__driver_probe_device) from [<c07b6290>] 
(driver_probe_device+0x44/0xd4)
[   88.958419]  r9:c1253854 r8:00000000 r7:c25eb010 r6:c22d0aa8 
r5:c236c21c r4:c236c218
[   88.966177] [<c07b624c>] (driver_probe_device) from [<c07b6830>] 
(__driver_attach+0xdc/0x188)
[   88.974730]  r9:c1253854 r8:ffffe000 r7:c07b6754 r6:c22d0aa8 
r5:00000000 r4:c25eb010
[   88.982489] [<c07b6754>] (__driver_attach) from [<c07b3a68>] 
(bus_for_each_dev+0x84/0xc4)
[   88.990694]  r7:c07b6754 r6:c22d0aa8 r5:c2204d08 r4:c2e4d4b4
[   88.996365] [<c07b39e4>] (bus_for_each_dev) from [<c07b5510>] 
(driver_attach+0x2c/0x30)
[   89.004394]  r7:00000000 r6:c2780a00 r5:c22c2a68 r4:c22d0aa8
[   89.010065] [<c07b54e4>] (driver_attach) from [<c07b4dd4>] 
(bus_add_driver+0x1d0/0x210)
[   89.018093] [<c07b4c04>] (bus_add_driver) from [<c07b739c>] 
(driver_register+0x84/0x118)
[   89.026209]  r7:00000000 r6:c122ae8c r5:c2204d08 r4:c22d0aa8
[   89.031880] [<c07b7318>] (driver_register) from [<c07b8a90>] 
(__platform_driver_register+0x2c/0x34)
[   89.040954]  r5:c2204d08 r4:c230e780
[   89.044538] [<c07b8a64>] (__platform_driver_register) from 
[<c122aeb0>] (bcm_sf2_driver_init+0x24/0x28)
[   89.053959] [<c122ae8c>] (bcm_sf2_driver_init) from [<c0202180>] 
(do_one_initcall+0x64/0x254)
[   89.062509] [<c020211c>] (do_one_initcall) from [<c12014f4>] 
(kernel_init_freeable+0x1e0/0x238)
[   89.071237]  r8:00000007 r7:c26f4900 r6:c1253834 r5:00000119 r4:c1289ab8
[   89.077951] [<c1201314>] (kernel_init_freeable) from [<c0cc7918>] 
(kernel_init+0x20/0x138)
[   89.086246]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 
r6:00000000 r5:c0cc78f8
[   89.094093]  r4:00000000
[   89.096633] [<c0cc78f8>] (kernel_init) from [<c0200140>] 
(ret_from_fork+0x14/0x34)
[   89.104226] Exception stack(0xc2573fb0 to 0xc2573ff8)
[   89.109291] 3fa0:                                     00000000 
00000000 00000000 00000000
[   89.117487] 3fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[   89.125682] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   89.132311]  r5:c0cc78f8 r4:00000000

-- 
Florian
