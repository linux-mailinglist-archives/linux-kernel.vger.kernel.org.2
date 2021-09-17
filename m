Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D03540F444
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245208AbhIQIl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhIQIl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:41:27 -0400
Received: from frontdoor.pr.hu (frontdoor.pr.hu [IPv6:2a02:808:3:101:250:56ff:fe8e:1370])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07225C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:40:05 -0700 (PDT)
Received: from [2a02:808:3:101::5] (helo=mail.pr.hu)
        by frontdoor.pr.hu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <zboszor@pr.hu>)
        id 1mR9AA-0007CP-0J
        for linux-kernel@vger.kernel.org; Fri, 17 Sep 2021 10:24:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pr.hu;
        s=pr20170203; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=s3DywLISGztjo5+w8nLTPx/J3r1NzKNOS+jdtraCtTk=; b=ObXzFOBTpP0Ch2zANXbuXUbat6
        At6TglVi1krkeZgrWc05ipgKiA4A3GkiJw3nj4gHOBG4sNXECykJ05N/RGwPjPrfgruKiaVCU7g0x
        jPza7vCKsWFl4dTLN8RzR/2KsgCyQlCdBw0iNr4LMnR0STjGv6k/4WeJBZ9heDVs2kEOr5vN2WWo9
        Mv5ElTBnKoa9NX5tmcfe5Ikt0+evs9rGcwEU/fLZJyhSpkj3KpFIPqvYoop0880GiHvVSr4SYlzO/
        te1e9mXTH8A0F1uRJvNkQXYPGRPQzmCVrhAUV6QcbWsM6V77AtkKy+NMmzlr0TQYapOdrpbYdKSAf
        AonxI7Mg==;
Received: from host-87-242-23-58.prtelecom.hu ([87.242.23.58] helo=localhost.localdomain)
        by mail.pr.hu with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <zboszor@pr.hu>)
        id 1mR9A5-0007j0-UB
        for linux-kernel@vger.kernel.org; Fri, 17 Sep 2021 10:23:59 +0200
To:     lkml <linux-kernel@vger.kernel.org>
From:   =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@pr.hu>
Subject: Oops wih 5.14.5 on an ElkhartLake machine, missing /dev/dri/card0
Message-ID: <48c134b5-79a4-aa8b-144a-dd31a8e22f88@pr.hu>
Date:   Fri, 17 Sep 2021 10:23:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.0 (---)
X-Scan-Signature: 3c72c192bf287bc15837ddc11decd820
X-Spam-Tracer: backend.mail.pr.hu -3.0 20210917082359Z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

booting kernel 5.14.5 (OS: Yocto 3.4 master, GCC 11.2), I got this Oops:

[    1.756613] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    1.758089] #PF: supervisor read access in kernel mode
[    1.758090] #PF: error_code(0x0000) - not-present page
[    1.758092] PGD 0 P4D 0
[    1.760851] Oops: 0000 [#1] SMP NOPTI
[    1.763555] CPU: 1 PID: 375 Comm: systemd-udevd Not tainted 5.14.5 #1
[    1.763558] Hardware name: Insyde ElkhartLake/Type2 - Board Product Name1, BIOS 
F340V030(F340-030) 08/27/2021
[    1.763559] RIP: 0010:strcmp+0xc/0x20
[    1.763566] Code: 06 49 89 f8 48 83 c6 01 48 83 c7 01 88 47 ff 84 c0 75 eb 4c 89 c0 c3 
0f 1f 80 00 00 00 00 31 c0 eb 08 48 83 c0 01 84 d2 74 0f <0f> b6 14 07 3a 14 06 74 ef 19 
c0 83 c8 01 c3 31 c0 c3 66 90 48 85
[    1.763568] RSP: 0018:ffffbc9f40387c10 EFLAGS: 00010246
[    1.763570] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffbc9f40387be8
[    1.763571] RDX: 0000000000000000 RSI: ffffffffc0210c3f RDI: 0000000000000000
[    1.763572] RBP: ffffffffc02140e0 R08: ffff9b00c7981610 R09: ffff9b00c7981610
[    1.763573] R10: ffff9b00ceaf7700 R11: 0000000000000000 R12: ffffffffc0212be0
[    1.763574] R13: 0000000000000000 R14: 00007f1c4bde436b R15: ffffbc9f40387e08
[    1.763575] FS:  00007f1c4ba12c00(0000) GS:ffff9b0247e80000(0000) knlGS:0000000000000000
[    1.779123] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.779126] CR2: 0000000000000000 CR3: 000000010dc80000 CR4: 0000000000350ee0
[    1.779128] Call Trace:
[    1.783391]  intel_pinctrl_get_soc_data+0x62/0xb0
[    1.783403]  intel_pinctrl_probe_by_uid+0xe/0x30
[    1.783406]  platform_probe+0x54/0xb0
[    1.783410]  really_probe+0x1f2/0x3f0
[    1.783413]  ? pm_runtime_barrier+0x43/0x80
[    1.783416]  __driver_probe_device+0xfe/0x180
[    1.783418]  driver_probe_device+0x1e/0x90
[    1.783422]  __driver_attach+0xc0/0x1c0
[    1.783427]  ? __device_attach_driver+0xe0/0xe0
[    1.783429]  ? __device_attach_driver+0xe0/0xe0
[    1.783431]  bus_for_each_dev+0x75/0xc0
[    1.783433]  bus_add_driver+0x12b/0x1e0
[    1.783436]  driver_register+0x8f/0xe0
[    1.783438]  ? 0xffffffffc0217000
[    1.783440]  do_one_initcall+0x41/0x1d0
[    1.783448]  ? kmem_cache_alloc_trace+0x17a/0x2b0
[    1.783451]  do_init_module+0x5c/0x260
[    1.783454]  __do_sys_init_module+0x12e/0x1b0
[    1.783457]  do_syscall_64+0x59/0x80
[    1.783465]  ? syscall_exit_to_user_mode+0x18/0x40
[    1.783467]  ? do_syscall_64+0x69/0x80
[    1.783468]  ? exc_page_fault+0x72/0x150
[    1.783470]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    1.783475] RIP: 0033:0x7f1c4bc7dfbe
[    1.783480] Code: 48 8b 0d 5d 2e 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 
00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 
8b 0d 2a 2e 0e 00 f7 d8 64 89 01 48
[    1.783482] RSP: 002b:00007fff29e9e3a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[    1.783485] RAX: ffffffffffffffda RBX: 0000563789f4fbd0 RCX: 00007f1c4bc7dfbe
[    1.783486] RDX: 00007f1c4bde436b RSI: 00000000000073c1 RDI: 00007f1c4b919010
[    1.783487] RBP: 00007f1c4b919010 R08: 00007f1c4b97b000 R09: 0000000000000000
[    1.783488] R10: 0000000000000021 R11: 0000000000000246 R12: 00007f1c4bde436b
[    1.783489] R13: 0000000000000000 R14: 0000000000000007 R15: 0000563789f4fbd0
[    1.783491] Modules linked in: pinctrl_elkhartlake(+)
[    1.783494] CR2: 0000000000000000
[    1.783497] ---[ end trace 3dbd0ade322948ac ]---
[    2.003648] RIP: 0010:strcmp+0xc/0x20
[    2.004862] Code: 06 49 89 f8 48 83 c6 01 48 83 c7 01 88 47 ff 84 c0 75 eb 4c 89 c0 c3 
0f 1f 80 00 00 00 00 31 c0 eb 08 48 83 c0 01 84 d2 74 0f <0f> b6 14 07 3a 14 06 74 ef 19 
c0 83 c8 01 c3 31 c0 c3 66 90 48 85
[    2.006134] RSP: 0018:ffffbc9f40387c10 EFLAGS: 00010246
[    2.007375] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffbc9f40387be8
[    2.008639] RDX: 0000000000000000 RSI: ffffffffc0210c3f RDI: 0000000000000000
[    2.009875] RBP: ffffffffc02140e0 R08: ffff9b00c7981610 R09: ffff9b00c7981610
[    2.011095] R10: ffff9b00ceaf7700 R11: 0000000000000000 R12: ffffffffc0212be0
[    2.012303] R13: 0000000000000000 R14: 00007f1c4bde436b R15: ffffbc9f40387e08
[    2.013520] FS:  00007f1c4ba12c00(0000) GS:ffff9b0247e80000(0000) knlGS:0000000000000000
[    2.014778] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.016035] CR2: 0000000000000000 CR3: 000000010dc80000 CR4: 0000000000350ee0

The relevant setting is set: CONFIG_PINCTRL_ELKHARTLAKE=m
CONFIG_SND_SOC_SOF_ELKHARTLAKE=m

Also, /dev/dri/card0 is missing so neither plymouth nor Xorg works.

Thanks for any help.

Zoltán Böszörményi
