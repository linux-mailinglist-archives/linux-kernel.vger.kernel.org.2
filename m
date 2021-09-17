Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4340A40F443
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhIQIl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhIQIl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:41:26 -0400
X-Greylist: delayed 959 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Sep 2021 01:40:04 PDT
Received: from frontdoor.pr.hu (frontdoor.pr.hu [IPv6:2a02:808:3:101:250:56ff:fe8e:1370])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378E8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:40:04 -0700 (PDT)
Received: from [2a02:808:3:101::5] (helo=mail.pr.hu)
        by frontdoor.pr.hu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <zboszor@pr.hu>)
        id 1mR9B4-0007kH-Vh
        for linux-kernel@vger.kernel.org; Fri, 17 Sep 2021 10:24:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pr.hu;
        s=pr20170203; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sPqLV9sPuBkCWaOZFOe+tchbHNEsZ0E71Yf1i+Ya8nE=; b=M7c8ARBAz3J06cqE0jZf2aN4xr
        Ji9u34CeRj9dW3LIUtCj5waZUkMT28/oaHbNS4Xl0dJW7+u+7e38expxVVFdLj+0AKlKLprXMQ8Tv
        1QNduB33j7r5ShqEKE/2+Sf9e1YcD0O+V49CJwXlgiguw4CRSzS0LkNDqVkhBwy9fReCPb/LoApFp
        nsYi3ZkgesuqK6VXkvrq9uWSTTU883LLtiCF7k/KjVRE7Yb8+mWkudvomX3/WLoHTrwHXSiQGQ5hk
        AX/V4lr3owgpSQqH4yPwGKmIdSVDGVlAImvkJUzgGmdJCQb7zL9JIvk41oxV6dslmf5/LOFQegzkl
        bARMFpBw==;
Received: from host-87-242-23-58.prtelecom.hu ([87.242.23.58] helo=localhost.localdomain)
        by mail.pr.hu with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <zboszor@pr.hu>)
        id 1mR9B0-0007uy-Qk
        for linux-kernel@vger.kernel.org; Fri, 17 Sep 2021 10:24:56 +0200
Subject: Re: Oops wih 5.14.5 on an ElkhartLake machine, missing /dev/dri/card0
From:   =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@pr.hu>
To:     lkml <linux-kernel@vger.kernel.org>
References: <48c134b5-79a4-aa8b-144a-dd31a8e22f88@pr.hu>
Message-ID: <43aa8847-4537-a554-5e0f-04d5226bcdde@pr.hu>
Date:   Fri, 17 Sep 2021 10:24:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <48c134b5-79a4-aa8b-144a-dd31a8e22f88@pr.hu>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.8 (------)
X-Scan-Signature: 631c646d8c1ca3165e089419b2fc5af1
X-Spam-Tracer: backend.mail.pr.hu -6.8 20210917082456Z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021. 09. 17. 10:23 keltezéssel, Böszörményi Zoltán írta:
> Hi,
> 
> booting kernel 5.14.5 (OS: Yocto 3.4 master, GCC 11.2), I got this Oops:
> 
> [    1.756613] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    1.758089] #PF: supervisor read access in kernel mode
> [    1.758090] #PF: error_code(0x0000) - not-present page
> [    1.758092] PGD 0 P4D 0
> [    1.760851] Oops: 0000 [#1] SMP NOPTI
> [    1.763555] CPU: 1 PID: 375 Comm: systemd-udevd Not tainted 5.14.5 #1
> [    1.763558] Hardware name: Insyde ElkhartLake/Type2 - Board Product Name1, BIOS 
> F340V030(F340-030) 08/27/2021
> [    1.763559] RIP: 0010:strcmp+0xc/0x20
> [    1.763566] Code: 06 49 89 f8 48 83 c6 01 48 83 c7 01 88 47 ff 84 c0 75 eb 4c 89 c0 c3 
> 0f 1f 80 00 00 00 00 31 c0 eb 08 48 83 c0 01 84 d2 74 0f <0f> b6 14 07 3a 14 06 74 ef 19 
> c0 83 c8 01 c3 31 c0 c3 66 90 48 85
> [    1.763568] RSP: 0018:ffffbc9f40387c10 EFLAGS: 00010246
> [    1.763570] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffbc9f40387be8
> [    1.763571] RDX: 0000000000000000 RSI: ffffffffc0210c3f RDI: 0000000000000000
> [    1.763572] RBP: ffffffffc02140e0 R08: ffff9b00c7981610 R09: ffff9b00c7981610
> [    1.763573] R10: ffff9b00ceaf7700 R11: 0000000000000000 R12: ffffffffc0212be0
> [    1.763574] R13: 0000000000000000 R14: 00007f1c4bde436b R15: ffffbc9f40387e08
> [    1.763575] FS:  00007f1c4ba12c00(0000) GS:ffff9b0247e80000(0000) knlGS:0000000000000000
> [    1.779123] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.779126] CR2: 0000000000000000 CR3: 000000010dc80000 CR4: 0000000000350ee0
> [    1.779128] Call Trace:
> [    1.783391]  intel_pinctrl_get_soc_data+0x62/0xb0
> [    1.783403]  intel_pinctrl_probe_by_uid+0xe/0x30
> [    1.783406]  platform_probe+0x54/0xb0
> [    1.783410]  really_probe+0x1f2/0x3f0
> [    1.783413]  ? pm_runtime_barrier+0x43/0x80
> [    1.783416]  __driver_probe_device+0xfe/0x180
> [    1.783418]  driver_probe_device+0x1e/0x90
> [    1.783422]  __driver_attach+0xc0/0x1c0
> [    1.783427]  ? __device_attach_driver+0xe0/0xe0
> [    1.783429]  ? __device_attach_driver+0xe0/0xe0
> [    1.783431]  bus_for_each_dev+0x75/0xc0
> [    1.783433]  bus_add_driver+0x12b/0x1e0
> [    1.783436]  driver_register+0x8f/0xe0
> [    1.783438]  ? 0xffffffffc0217000
> [    1.783440]  do_one_initcall+0x41/0x1d0
> [    1.783448]  ? kmem_cache_alloc_trace+0x17a/0x2b0
> [    1.783451]  do_init_module+0x5c/0x260
> [    1.783454]  __do_sys_init_module+0x12e/0x1b0
> [    1.783457]  do_syscall_64+0x59/0x80
> [    1.783465]  ? syscall_exit_to_user_mode+0x18/0x40
> [    1.783467]  ? do_syscall_64+0x69/0x80
> [    1.783468]  ? exc_page_fault+0x72/0x150
> [    1.783470]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    1.783475] RIP: 0033:0x7f1c4bc7dfbe
> [    1.783480] Code: 48 8b 0d 5d 2e 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 
> 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 
> 8b 0d 2a 2e 0e 00 f7 d8 64 89 01 48
> [    1.783482] RSP: 002b:00007fff29e9e3a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> [    1.783485] RAX: ffffffffffffffda RBX: 0000563789f4fbd0 RCX: 00007f1c4bc7dfbe
> [    1.783486] RDX: 00007f1c4bde436b RSI: 00000000000073c1 RDI: 00007f1c4b919010
> [    1.783487] RBP: 00007f1c4b919010 R08: 00007f1c4b97b000 R09: 0000000000000000
> [    1.783488] R10: 0000000000000021 R11: 0000000000000246 R12: 00007f1c4bde436b
> [    1.783489] R13: 0000000000000000 R14: 0000000000000007 R15: 0000563789f4fbd0
> [    1.783491] Modules linked in: pinctrl_elkhartlake(+)
> [    1.783494] CR2: 0000000000000000
> [    1.783497] ---[ end trace 3dbd0ade322948ac ]---
> [    2.003648] RIP: 0010:strcmp+0xc/0x20
> [    2.004862] Code: 06 49 89 f8 48 83 c6 01 48 83 c7 01 88 47 ff 84 c0 75 eb 4c 89 c0 c3 
> 0f 1f 80 00 00 00 00 31 c0 eb 08 48 83 c0 01 84 d2 74 0f <0f> b6 14 07 3a 14 06 74 ef 19 
> c0 83 c8 01 c3 31 c0 c3 66 90 48 85
> [    2.006134] RSP: 0018:ffffbc9f40387c10 EFLAGS: 00010246
> [    2.007375] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffbc9f40387be8
> [    2.008639] RDX: 0000000000000000 RSI: ffffffffc0210c3f RDI: 0000000000000000
> [    2.009875] RBP: ffffffffc02140e0 R08: ffff9b00c7981610 R09: ffff9b00c7981610
> [    2.011095] R10: ffff9b00ceaf7700 R11: 0000000000000000 R12: ffffffffc0212be0
> [    2.012303] R13: 0000000000000000 R14: 00007f1c4bde436b R15: ffffbc9f40387e08
> [    2.013520] FS:  00007f1c4ba12c00(0000) GS:ffff9b0247e80000(0000) knlGS:0000000000000000
> [    2.014778] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.016035] CR2: 0000000000000000 CR3: 000000010dc80000 CR4: 0000000000350ee0
> 
> The relevant setting is set: CONFIG_PINCTRL_ELKHARTLAKE=m
> CONFIG_SND_SOC_SOF_ELKHARTLAKE=m
> 
> Also, /dev/dri/card0 is missing so neither plymouth nor Xorg works.

# lspci
00:00.0 Host bridge: Intel Corporation Device 4538 (rev 01)
00:02.0 VGA compatible controller: Intel Corporation Device 4555 (rev 01)
00:08.0 System peripheral: Intel Corporation Device 4511 (rev 01)
00:14.0 USB controller: Intel Corporation Device 4b7d (rev 11)
00:14.2 RAM memory: Intel Corporation Device 4b7f (rev 11)
00:16.0 Communication controller: Intel Corporation Device 4b70 (rev 11)
00:17.0 SATA controller: Intel Corporation Device 4b63 (rev 11)
00:1c.0 PCI bridge: Intel Corporation Device 4b38 (rev 11)
00:1c.1 PCI bridge: Intel Corporation Device 4b39 (rev 11)
00:1c.4 PCI bridge: Intel Corporation Device 4b3c (rev 11)
00:1c.6 PCI bridge: Intel Corporation Device 4b3e (rev 11)
00:1f.0 ISA bridge: Intel Corporation Device 4b00 (rev 11)
00:1f.3 Audio device: Intel Corporation Device 4b58 (rev 11)
00:1f.4 SMBus: Intel Corporation Device 4b23 (rev 11)
00:1f.5 Serial bus controller [0c80]: Intel Corporation Device 4b24 (rev 11)
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express 
Gigabit Ethernet Controller (rev 15)

# lspci -n
00:00.0 0600: 8086:4538 (rev 01)
00:02.0 0300: 8086:4555 (rev 01)
00:08.0 0880: 8086:4511 (rev 01)
00:14.0 0c03: 8086:4b7d (rev 11)
00:14.2 0500: 8086:4b7f (rev 11)
00:16.0 0780: 8086:4b70 (rev 11)
00:17.0 0106: 8086:4b63 (rev 11)
00:1c.0 0604: 8086:4b38 (rev 11)
00:1c.1 0604: 8086:4b39 (rev 11)
00:1c.4 0604: 8086:4b3c (rev 11)
00:1c.6 0604: 8086:4b3e (rev 11)
00:1f.0 0601: 8086:4b00 (rev 11)
00:1f.3 0403: 8086:4b58 (rev 11)
00:1f.4 0c05: 8086:4b23 (rev 11)
00:1f.5 0c80: 8086:4b24 (rev 11)
02:00.0 0200: 10ec:8168 (rev 15)

> 
> Thanks for any help.
> 
> Zoltán Böszörményi

