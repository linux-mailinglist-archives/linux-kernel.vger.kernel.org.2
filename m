Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09033D9617
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 21:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhG1TgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 15:36:02 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:33958 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhG1Tf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 15:35:59 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2021 15:35:59 EDT
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 957DE2A0C0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 19:29:48 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.118])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3BEE21C0069
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 19:29:47 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0D7EA1C007E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 19:29:47 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id A2AFA13C2B1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 12:29:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A2AFA13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627500586;
        bh=U/FCF8EbjQZxLMYU9PF0qk2FH0WyjMbyXHCubbDre/8=;
        h=To:From:Subject:Date:From;
        b=V7GjMLeSp0/AXTCVCcNxzl1Y0+2nSGDCBEzNGlzfyiHicrhOYeVbxvxEmQVi5RFIp
         +nKGUHC3BaLT8Xf8sMWdwX1Q8qYhVG8QAwceO0/UvCwDIJ9Hdkx4oTPSBrEGmZmio2
         PJ9LuhOcn5MBMSQ31sDyW2wpYKrgSs1AFqdgtrgs=
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: kasan warning related to hwmon/acpi, 5.13.5+
Organization: Candela Technologies
Message-ID: <84eb3a9d-5f94-1136-f94e-c04ff6b0d1b9@candelatech.com>
Date:   Wed, 28 Jul 2021 12:29:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1627500587-CSfzcklQqHtP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm seeing this warning often right after/during boot, but not always.
I am pretty sure this is not some regression I've added to my tree, but
of course that is possible.

If someone has already got a fix for this or debugged it, please let me know.

Jul 28 12:23:08 ct523c-0b29 kernel: ==================================================================
Jul 28 12:23:08 ct523c-0b29 kernel: BUG: KASAN: use-after-free in string_nocheck+0x9d/0x160
Jul 28 12:23:08 ct523c-0b29 kernel: Read of size 1 at addr ffff88810ac29820 by task sadc/1243
Jul 28 12:23:08 ct523c-0b29 kernel:
Jul 28 12:23:08 ct523c-0b29 kernel: CPU: 4 PID: 1243 Comm: sadc Not tainted 5.13.5+ #37
Jul 28 12:23:08 ct523c-0b29 kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/19/2019
Jul 28 12:23:08 ct523c-0b29 kernel: Call Trace:
Jul 28 12:23:08 ct523c-0b29 kernel:  dump_stack+0x9b/0xce
Jul 28 12:23:08 ct523c-0b29 kernel:  ? string_nocheck+0x9d/0x160
Jul 28 12:23:08 ct523c-0b29 kernel:  print_address_description.constprop.9+0x3a/0x60
Jul 28 12:23:08 ct523c-0b29 kernel:  ? string_nocheck+0x9d/0x160
Jul 28 12:23:08 ct523c-0b29 kernel:  ? string_nocheck+0x9d/0x160
Jul 28 12:23:08 ct523c-0b29 kernel:  kasan_report.cold.14+0x7c/0xd8
Jul 28 12:23:08 ct523c-0b29 kernel:  ? string_nocheck+0x9d/0x160
Jul 28 12:23:08 ct523c-0b29 kernel:  string_nocheck+0x9d/0x160
Jul 28 12:23:08 ct523c-0b29 kernel:  ? widen_string+0x160/0x160
Jul 28 12:23:08 ct523c-0b29 kernel:  ? string_nocheck+0x160/0x160
Jul 28 12:23:08 ct523c-0b29 kernel:  string+0xb6/0xc0
Jul 28 12:23:08 ct523c-0b29 kernel:  ? netdev_bits+0x170/0x170
Jul 28 12:23:08 ct523c-0b29 kernel:  vsnprintf+0x20c/0x780
Jul 28 12:23:08 ct523c-0b29 kernel:  ? unwind_get_return_address+0x2a/0x40
Jul 28 12:23:08 ct523c-0b29 kernel:  ? pointer+0x540/0x540
Jul 28 12:23:08 ct523c-0b29 kernel:  sprintf+0x9e/0xd0
Jul 28 12:23:08 ct523c-0b29 kernel:  ? scnprintf+0xf0/0xf0
Jul 28 12:23:08 ct523c-0b29 kernel:  ? name_show+0x11/0x30 [hwmon]
Jul 28 12:23:08 ct523c-0b29 kernel:  name_show+0x24/0x30 [hwmon]
Jul 28 12:23:08 ct523c-0b29 kernel:  dev_attr_show+0x2f/0x60
Jul 28 12:23:08 ct523c-0b29 kernel:  sysfs_kf_seq_show+0x114/0x1f0
Jul 28 12:23:08 ct523c-0b29 kernel:  ? device_remove_bin_file+0x10/0x10
Jul 28 12:23:08 ct523c-0b29 kernel:  seq_read_iter+0x25c/0x6d0
Jul 28 12:23:08 ct523c-0b29 kernel:  new_sync_read+0x248/0x360
Jul 28 12:23:08 ct523c-0b29 kernel:  ? __x64_sys_llseek+0x1d0/0x1d0
Jul 28 12:23:08 ct523c-0b29 kernel:  ? __ia32_sys_lstat+0x30/0x30
Jul 28 12:23:08 ct523c-0b29 kernel:  ? __fsnotify_parent+0x3a8/0x540
Jul 28 12:23:08 ct523c-0b29 kernel:  ? fsnotify+0x7d0/0x7d0
Jul 28 12:23:08 ct523c-0b29 kernel:  ? kernfs_iop_getattr+0x6c/0x80
Jul 28 12:23:08 ct523c-0b29 kernel:  vfs_read+0x14f/0x220
Jul 28 12:23:08 ct523c-0b29 kernel:  ksys_read+0xaf/0x140
Jul 28 12:23:08 ct523c-0b29 kernel:  ? vfs_write+0x360/0x360
Jul 28 12:23:08 ct523c-0b29 kernel:  ? __audit_syscall_entry+0x19b/0x200
Jul 28 12:23:08 ct523c-0b29 kernel:  ? ktime_get_coarse_real_ts64+0x4c/0x70
Jul 28 12:23:08 ct523c-0b29 kernel:  do_syscall_64+0x36/0xa0
Jul 28 12:23:08 ct523c-0b29 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Jul 28 12:23:08 ct523c-0b29 kernel: RIP: 0033:0x7fe9fe559145
Jul 28 12:23:08 ct523c-0b29 kernel: Code: fe ff ff 50 48 8d 3d ca fb 09 00 e8 a5 eb 01 00 0f 1f 44 00 00 f3 0f 1e fa 48 8d 05 15 84 0d 00 8b 00 85 c0 75 0f 31 
c0 0f 05 <48> 3d 00 f0 ff ff 77 53 c3 66 90 48 83 ec 28 48 89 54 24 18 48 89
Jul 28 12:23:08 ct523c-0b29 kernel: RSP: 002b:00007ffcfa5f0d28 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
Jul 28 12:23:08 ct523c-0b29 kernel: RAX: ffffffffffffffda RBX: 00000000021712e0 RCX: 00007fe9fe559145
Jul 28 12:23:08 ct523c-0b29 kernel: RDX: 0000000000001000 RSI: 000000000217bf80 RDI: 0000000000000004
Jul 28 12:23:08 ct523c-0b29 kernel: RBP: 0000000000000d68 R08: 0000000000000004 R09: 000000000000006f
Jul 28 12:23:08 ct523c-0b29 kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe9fe628800
Jul 28 12:23:08 ct523c-0b29 kernel: R13: 00007fe9fe629400 R14: 00007ffcfa5f0e10 R15: 000000000000007f
Jul 28 12:23:08 ct523c-0b29 kernel:
Jul 28 12:23:08 ct523c-0b29 kernel: Allocated by task 1:
Jul 28 12:23:08 ct523c-0b29 kernel:  kasan_save_stack+0x19/0x40
Jul 28 12:23:08 ct523c-0b29 kernel:  __kasan_kmalloc+0x7f/0xa0
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_ns_internalize_name+0xb2/0x120
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_ns_get_node_unlocked+0xfd/0x18c
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_ns_get_node+0x3b/0x50
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_get_handle+0xeb/0x13a
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_has_method+0x5a/0x90
Jul 28 12:23:08 ct523c-0b29 kernel:  acpiphp_add_context+0x498/0x650
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_ns_walk_namespace+0xfa/0x1f3
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_walk_namespace+0x95/0xbd
Jul 28 12:23:08 ct523c-0b29 kernel:  acpiphp_enumerate_slots+0x269/0x3b0
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_pci_add_bus+0x94/0x170
Jul 28 12:23:08 ct523c-0b29 kernel:  pci_register_host_bridge+0x485/0x540
Jul 28 12:23:08 ct523c-0b29 kernel:  pci_create_root_bus+0x121/0x160
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_pci_root_create+0x1c3/0x390
Jul 28 12:23:08 ct523c-0b29 kernel:  pci_acpi_scan_root+0x2b8/0x2d0
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_pci_root_add.cold.12+0xb0/0x752
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_bus_attach+0x26a/0x4b0
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_bus_attach+0x122/0x4b0
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_bus_attach+0x122/0x4b0
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_bus_scan+0x8f/0x150
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_scan_init+0x1a6/0x3ca
Jul 28 12:23:08 ct523c-0b29 kernel:  acpi_init+0x581/0x60e
Jul 28 12:23:08 ct523c-0b29 kernel:  do_one_initcall+0x82/0x290
Jul 28 12:23:08 ct523c-0b29 kernel:  kernel_init_freeable+0x347/0x3d8
Jul 28 12:23:08 ct523c-0b29 kernel:  kernel_init+0x7/0x10d
Jul 28 12:23:08 ct523c-0b29 kernel:  ret_from_fork+0x1f/0x30
Jul 28 12:23:08 ct523c-0b29 kernel:
Jul 28 12:23:08 ct523c-0b29 kernel: The buggy address belongs to the object at ffff88810ac29820
                                      which belongs to the cache kmalloc-8 of size 8
Jul 28 12:23:08 ct523c-0b29 kernel: The buggy address is located 0 bytes inside of
                                      8-byte region [ffff88810ac29820, ffff88810ac29828)
Jul 28 12:23:08 ct523c-0b29 kernel: The buggy address belongs to the page:
Jul 28 12:23:08 ct523c-0b29 kernel: page:00000000347308e1 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88810ac29820 pfn:0x10ac29
Jul 28 12:23:08 ct523c-0b29 kernel: flags: 0x5fff8000000200(slab|node=0|zone=2|lastcpupid=0x3fff)
Jul 28 12:23:08 ct523c-0b29 kernel: raw: 005fff8000000200 ffffea000428ab00 0000000a0000000a ffff888108042280
Jul 28 12:23:08 ct523c-0b29 kernel: raw: ffff88810ac29820 0000000080660051 00000001ffffffff 0000000000000000
Jul 28 12:23:08 ct523c-0b29 kernel: page dumped because: kasan: bad access detected
Jul 28 12:23:08 ct523c-0b29 kernel:
Jul 28 12:23:08 ct523c-0b29 kernel: Memory state around the buggy address:
Jul 28 12:23:08 ct523c-0b29 kernel:  ffff88810ac29700: fc 00 fc fc fc fc 00 fc fc fc fc 00 fc fc fc fc
Jul 28 12:23:08 ct523c-0b29 kernel:  ffff88810ac29780: 00 fc fc fc fc 00 fc fc fc fc 00 fc fc fc fc 00
Jul 28 12:23:08 ct523c-0b29 kernel: >ffff88810ac29800: fc fc fc fc fb fc fc fc fc 00 fc fc fc fc fb fc
Jul 28 12:23:08 ct523c-0b29 kernel:                                ^
Jul 28 12:23:08 ct523c-0b29 kernel:  ffff88810ac29880: fc fc fc fb fc fc fc fc fb fc fc fc fc fb fc fc
Jul 28 12:23:08 ct523c-0b29 kernel:  ffff88810ac29900: fc fc 00 fc fc fc fc 00 fc fc fc fc 00 fc fc fc
Jul 28 12:23:08 ct523c-0b29 kernel: ==================================================================
Jul 28 12:23:08 ct523c-0b29 kernel: Disabling lock debugging due to kernel taint


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

