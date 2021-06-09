Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448223A13B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhFIMHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:07:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3186 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhFIMHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:07:16 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G0QTG20Sdz6J9VQ;
        Wed,  9 Jun 2021 19:52:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 14:05:20 +0200
Received: from [10.47.80.201] (10.47.80.201) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 13:05:19 +0100
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Subject: [report] use-after-free in __irq_resolve_mapping()
Message-ID: <6715098c-6845-c4a1-31ca-42101350c80a@huawei.com>
Date:   Wed, 9 Jun 2021 12:59:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.201]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JFYI, on -next 20210608, I find this on my arm64 D06 and D05:

root@(none)$ echo 0000:74:02.0 > /sys/bus/pci/drivers/hisi_sas_v3_hw/unbind
[   33.623607] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   33.667127] sd 0:0:1:0: [sdb] Synchronizing SCSI cache
[   33.703457] sd 0:0:2:0: [sdc] Synchronizing SCSI cache
[   33.708770] sd 0:0:2:0: [sdc] Stopping disk
[   36.399020] sd 0:0:3:0: [sdd] Synchronizing SCSI cache
[   36.450432] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   36.457808] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   36.465169] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   36.472545] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   36.480007] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   36.487355] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   36.494676] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   36.512742] hisi_sas_v3_hw 0000:74:02.0: dev[6:1] is gone
[   36.605821] hisi_sas_v3_hw 0000:74:02.0: dev[5:1] is gone
[   36.697987] hisi_sas_v3_hw 0000:74:02.0: dev[4:5] is gone
[   36.803796] hisi_sas_v3_hw 0000:74:02.0: dev[3:1] is gone
[   36.880908] hisi_sas_v3_hw 0000:74:02.0: dev[2:1] is gone
[   36.898881] hisi_sas_v3_hw 0000:74:02.0: dev[1:2] is gone
root@(none)$ echo 0000:74:02.0 > /sys/bus/pci/drivers/hisi_sas_v3_hw/bind
[   41.189833] 
==================================================================
[   41.197058] BUG: KASAN: use-after-free in 
__irq_resolve_mapping+0x58/0xd8
[   41.203846] Read of size 8 at addr ffff002097048470 by task 
kworker/0:1/25
[   41.210713]
[   41.212195] CPU: 0 PID: 25 Comm: kworker/0:1 Not tainted 
5.13.0-rc5-next-20210608 #80
[   41.220019] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[   41.228535] Workqueue: events work_for_cpu_fn
[   41.232893] Call trace:
[   41.235330]  dump_backtrace+0x0/0x2d0
[   41.238989]  show_stack+0x18/0x28
[   41.242299]  dump_stack_lvl+0xfc/0x138
[   41.246042]  print_address_description.constprop.13+0x78/0x314
[   41.251870]  kasan_report+0x1e0/0x248
[   41.255527]  __asan_load8+0x9c/0xd8
[   41.259010]  __irq_resolve_mapping+0x58/0xd8
[   41.263274]  msi_domain_alloc+0xd8/0x218
[   41.267191]  __irq_domain_alloc_irqs+0x188/0x458
[   41.271801]  __msi_domain_alloc_irqs+0x164/0x5b8
[   41.276413]  msi_domain_alloc_irqs+0x54/0x68
[   41.280677]  pci_msi_setup_msi_irqs.isra.18+0x4c/0x70
[   41.285725]  __pci_enable_msi_range+0x30c/0x4e0
[   41.290250]  pci_alloc_irq_vectors_affinity+0x144/0x1a8
[   41.295470]  hisi_sas_v3_probe+0x564/0x11c0
[   41.299648]  local_pci_probe+0x78/0xf8
[   41.303392]  work_for_cpu_fn+0x30/0x50
[   41.307136]  process_one_work+0x424/0x698
[   41.311139]  worker_thread+0x438/0x6d0
[   41.314881]  kthread+0x204/0x218
[   41.318104]  ret_from_fork+0x10/0x18
[   41.321673]
[   41.323155] Allocated by task 593:
[   41.326548]  kasan_save_stack+0x28/0x58
[   41.330378]  __kasan_kmalloc+0x8c/0xb0
[   41.334121]  alloc_desc+0x68/0x2f0
[   41.337516]  __irq_alloc_descs+0x1a4/0x2d0
[   41.341607]  irq_domain_alloc_descs+0x64/0xd8
[   41.345957]  __irq_domain_alloc_irqs+0x1fc/0x458
[   41.350567]  __msi_domain_alloc_irqs+0x164/0x5b8
[   41.355178]  msi_domain_alloc_irqs+0x54/0x68
[   41.359442]  pci_msi_setup_msi_irqs.isra.18+0x4c/0x70
[   41.364488]  __pci_enable_msi_range+0x30c/0x4e0
[   41.369012]  pci_alloc_irq_vectors_affinity+0x144/0x1a8
[   41.374232]  hisi_sas_v3_probe+0x564/0x11c0
[   41.378409]  local_pci_probe+0x78/0xf8
[   41.382152]  work_for_cpu_fn+0x30/0x50
[   41.385894]  process_one_work+0x424/0x698
[   41.389896]  worker_thread+0x438/0x6d0
[   41.393638]  kthread+0x204/0x218
[   41.396859]  ret_from_fork+0x10/0x18
[   41.400427]
[   41.401908] Freed by task 0:
[   41.404780]  kasan_save_stack+0x28/0x58
[   41.408609]  kasan_set_track+0x28/0x40
[   41.412352]  kasan_set_free_info+0x28/0x50
[   41.416442]  __kasan_slab_free+0xd8/0x138
[   41.420446]  kfree+0xb4/0x478
[   41.423406]  irq_kobj_release+0x30/0x40
[   41.427235]  kobject_put+0xa8/0x180
[   41.430716]  delayed_free_desc+0x14/0x20
[   41.434632]  rcu_core+0x4a8/0x840
[   41.437939]  rcu_core_si+0x10/0x20
[   41.441333]  __do_softirq+0x1ac/0x3d0
[   41.444987]
[   41.446468] Last potentially related work creation:
[   41.451336]  kasan_save_stack+0x28/0x58
[   41.455166]  kasan_record_aux_stack+0xc0/0xd8
[   41.459517]  call_rcu+0x64/0x2e8
[   41.462736]  free_desc+0x6c/0x80
[   41.465957]  irq_free_descs+0x74/0xb8
[   41.469612]  irq_domain_free_irqs+0x170/0x1d8
[   41.473962]  __msi_domain_free_irqs+0x70/0xa8
[   41.478312]  msi_domain_free_irqs+0x4c/0x60
[   41.482488]  free_msi_irqs+0x2a8/0x2b0
[   41.486231]  pci_disable_msi+0x104/0x138
[   41.490147]  pci_free_irq_vectors+0x20/0x30
[   41.494324]  hisi_sas_v3_remove+0x194/0x1f0
[   41.498501]  pci_device_remove+0x6c/0x138
[   41.502502]  device_release_driver_internal+0x158/0x280
[   41.507722]  device_driver_detach+0x2c/0x40
[   41.511899]  unbind_store+0xc8/0x160
[   41.515466]  drv_attr_store+0x4c/0x68
[   41.519123]  sysfs_kf_write+0x90/0xa8
[   41.522781]  kernfs_fop_write_iter+0x198/0x260
[   41.527219]  new_sync_write+0x1ec/0x2d8
[   41.531050]  vfs_write+0x3d4/0x548
[   41.534446]  ksys_write+0xc8/0x178
[   41.537839]  __arm64_sys_write+0x44/0x58
[   41.541754]  invoke_syscall+0x5c/0x178
[   41.545497]  el0_svc_common+0xc4/0x130
[   41.549240]  do_el0_svc+0x90/0xa0
[   41.552548]  el0_svc+0x24/0x38
[   41.555596]  el0t_64_sync_handler+0x90/0xb8
[   41.559773]  el0t_64_sync+0x178/0x17c
[   41.563428]
[   41.564908] The buggy address belongs to the object at ffff002097048400
[   41.564908]  which belongs to the cache kmalloc-512 of size 512
[   41.577418] The buggy address is located 112 bytes inside of
[   41.577418]  512-byte region [ffff002097048400, ffff002097048600)
[   41.589146] The buggy address belongs to the page:
[   41.593928] page:(____ptrval____) refcount:1 mapcount:0 
mapping:0000000000000000 index:0x0 pfn:0x2097048
[   41.603400] head:(____ptrval____) order:3 compound_mapcount:0 
compound_pincount:0
[   41.610873] flags: 
0xbfffc0000010200(slab|head|node=0|zone=2|lastcpupid=0xffff)
[   41.618180] raw: 0bfffc0000010200 dead000000000100 dead000000000122 
ffff00208000c780
[   41.625916] raw: 00000000   41.639211]
[   41.640692] Memory state around the buggy address:
[   41.645474]  ffff002097048300: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   41.652687]  ffff002097048380: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   41.659900] >ffff002097048400: fa fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   41.667112]  ^
[   41.673977]  ffff002097048480: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   41.681190]  ffff002097048500: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   41.688403] 
==================================================================
[   41.695614] Disabling lock debugging due to kernel taint
[   41.822545] hisi_sas_v3_hw: probe of 0000:74:02.0 failed with error -2
sh: echo: write error: No such device
root@(none)$

I didn't see a report elsewhere.

Thanks,
john
