Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E58E3621F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbhDPOQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:16:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:47843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235928AbhDPOQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618582558;
        bh=vE5GrS733/RrZ22cLogW6LoNL/hnyh/ZY7WM3vAm+ec=;
        h=X-UI-Sender-Class:Subject:From:To:Date;
        b=ZuD//IT7dBybY+xlLcjNWIM5f/BZWeeSOZq5Sc/wz3pxPLEtgqCJAnrctw0K+rPWW
         UcknfqN7iS6N+IeXZhb2aD5mNm//2842gy5bp5DwnKO0slWg1AYKdGcPqQL5BCd0Xe
         plmG65Bq1krD3hkmTzVHy9OYXHM/cI+V0ezZN5fc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.210]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3il-1l5BJ71fS7-00TVfQ; Fri, 16
 Apr 2021 16:15:58 +0200
Message-ID: <cdd087832f06a10d4c8f753c37cf2afec2cf1b6d.camel@gmx.de>
Subject: BUG: KASAN: slab-out-of-bounds in
 acpi_cppc_processor_probe+0x15c/0xa50
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 16 Apr 2021 16:15:57 +0200
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZIMr/elVy5hyfPtruWD2zhceKDSGumL/mIHTm1HCpZ4DzYbGaBv
 AcFDBcbqneBbJo+b5r+VverDGxi96QQubNpETBaW2MRvG8xzFjVWcCqVRbEjmJEchZ5JxuZ
 ZB4QQmsItJ/NET5EQHHX9sXD4jQBvjf9vojFIJ2ICE7b749m7/SSVsaV4ht3aSs1JQoX5fl
 TmKd6oUQ8PrPttAxQeTbA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fR8cE+wvjIs=:LbpItk1gDlcP3Za6lGAyz+
 bTO3kY6TgLfD/rZWDeVYZXc8+5xlCFwPAh77FIql07kvXW1SapXq57+cliDf/Pl8so0M3RjHp
 iiM6ByIIqRIkxNbfK6kbIhT3voaC6yN6kDgpqFOIwvTn0rYKA6RgYWf2yixqo/lMJNSPYaOPW
 fxt5TSeofI5ToU7PgLPyAQz7v6ewB9/90CM0AB6A60/cJ9i+UgNPjQSU8Mzm2XALrxCd8rDNm
 k8YVFs8386LdkapbiO2NFAYFzRCmaeaStO1QzQHtEt8SnVwuKKPKjGuLZg93dGaFElsynw6F7
 cSC/z+rdL4lo7+4QqljtrSHHW+kzR6tqdjTbKks3NrA/HbJQ0ayxbBvLtFiI93O4CnJUdnyzE
 6Af3ixddxMxEy5dVJN2yx2h66v48iZafecVz0IDueU1lbP6uzAZYLtEdwrwN/l/DernLv3wVd
 Tt3klge/lpw3K0VjaqH9fzK05DX48xlsPSRZvNo0FNsmaptVRJN8H15e4iinTxu+f0WPdK7DR
 qbzAZq0fcrNwtmBFt+mKgItNP8PxLgQQ4PV8SB/leQdv3jsraRgF5u9JK09t5EhWcR7EsPMxI
 c44bp4kQqyw1BQIbs5d4q/ryj1j+FP4VQfFuCdhCkwL07cJKdNZJknOqEtKGgqjwO+v3rRBWZ
 5SR1wGTvHq1YDtEBPsJBky0bRb+Eigsqyj3b+0haVziGewRae1ObSJ7OaBT4PoTiTW/ItawR1
 UriG4BeajZI3iu5pcjBDyXsJkbnBFX/ow5Vb3WOoYviAVZulJr1wFufDB1WaGOcBZlLgVb1iK
 0A2PaeUlVfi7WcfvfWdTxusdaEINkVaoqngATKDn2FklJpzV+KPVgMkvDhY3C6QnsbKVIPEL8
 HzEIoiYXFQ9LaJzZR5CasC+CV0bBPD5gG3yfDXtH5Vp+1uQRjUOl8H2pjIRKTF7+z2xbr0gvt
 2SdZ30vu5T/+qF/cbcvJ9gxLd5k3weID1e1CtWDj69NX8mVNlN0ueJAd9MYA3yUD7oY/CgjGo
 v8KbSGAj+uP77DYfmmxj2PD0kpfV1SnyWw+iuc3eYDgFzN2Nk5boK2IvZJY6U5iodu750W8tz
 tD6JMGJKeY/0pPcmACnTdT6QXQIaMd4LI1/zFbSC5xfAC9ZkdL6sHcTFc4GL1fppx6iX0gmdQ
 93pSEuFqYKWSaNEhPn0b6iNxpzw4fQ5fKu9j3zcJxWer5rzrPU4azanWA0uXeLTh+kUlk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[    6.343387] BUG: KASAN: slab-out-of-bounds in acpi_cppc_processor_probe+0x15c/0xa50
[    6.343474] Read of size 4 at addr ffff888120cf1630 by task swapper/0/1

[    6.343565] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G          I       5.12.0.g8b1fdf9-tip #2
[    6.343654] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.47 11/22/2017
[    6.343735] Call Trace:
[    6.343766]  ? acpi_cppc_processor_probe+0x15c/0xa50
[    6.343824]  dump_stack+0x8a/0xb5
[    6.343865]  print_address_description.constprop.0+0x16/0xa0
[    6.343931]  kasan_report+0xcb/0x110
[    6.343974]  ? acpi_cppc_processor_probe+0x15c/0xa50
[    6.344032]  acpi_cppc_processor_probe+0x15c/0xa50
[    6.344086]  ? mutex_unlock+0x1d/0x40
[    6.344130]  ? kernfs_add_one+0x1b1/0x210
[    6.344177]  ? __might_sleep+0x31/0xd0
[    6.344223]  ? acpi_get_psd_map+0x2d0/0x2d0
[    6.344271]  ? mutex_lock+0x91/0xd0
[    6.344313]  __acpi_processor_start+0x4e/0x150
[    6.344364]  acpi_processor_start+0x3d/0x60
[    6.344412]  really_probe+0x182/0x6c0
[    6.344458]  driver_probe_device+0x13f/0x1d0
[    6.346259]  device_driver_attach+0x110/0x120
[    6.347081]  ? device_driver_attach+0x120/0x120
[    6.347081]  __driver_attach+0xae/0x190
[    6.347081]  ? device_driver_attach+0x120/0x120
[    6.347081]  bus_for_each_dev+0xd8/0x120
[    6.347081]  ? subsys_dev_iter_exit+0x10/0x10
[    6.347081]  bus_add_driver+0x1f8/0x2e0
[    6.347081]  driver_register+0x10f/0x190
[    6.347081]  acpi_processor_driver_init+0x2f/0xc3
[    6.347081]  ? acpi_pci_slot_init+0x11/0x11
[    6.347081]  do_one_initcall+0x71/0x260
[    6.347081]  ? trace_event_raw_event_initcall_finish+0x120/0x120
[    6.347081]  ? parameq+0x90/0x90
[    6.347081]  ? kasan_unpoison+0x21/0x50
[    6.347081]  ? __kasan_slab_alloc+0x24/0x70
[    6.347081]  do_initcalls+0xff/0x129
[    6.347081]  kernel_init_freeable+0x19c/0x1ce
[    6.347081]  ? rest_init+0xc6/0xc6
[    6.347081]  kernel_init+0xd/0x11a
[    6.347081]  ret_from_fork+0x1f/0x30

[    6.347081] Allocated by task 1:
[    6.347081]  kasan_save_stack+0x1b/0x40
[    6.347081]  __kasan_kmalloc+0x7a/0x90
[    6.347081]  acpi_ut_initialize_buffer+0x41/0x8b
[    6.347081]  acpi_evaluate_object+0x306/0x395
[    6.347081]  acpi_evaluate_object_typed+0xd4/0x201
[    6.347081]  acpi_cppc_processor_probe+0xa0/0xa50
[    6.347081]  __acpi_processor_start+0x4e/0x150
[    6.347081]  acpi_processor_start+0x3d/0x60
[    6.347081]  really_probe+0x182/0x6c0
[    6.347081]  driver_probe_device+0x13f/0x1d0
[    6.347081]  device_driver_attach+0x110/0x120
[    6.347081]  __driver_attach+0xae/0x190
[    6.347081]  bus_for_each_dev+0xd8/0x120
[    6.347081]  bus_add_driver+0x1f8/0x2e0
[    6.347081]  driver_register+0x10f/0x190
[    6.347081]  acpi_processor_driver_init+0x2f/0xc3
[    6.347081]  do_one_initcall+0x71/0x260
[    6.347081]  do_initcalls+0xff/0x129
[    6.347081]  kernel_init_freeable+0x19c/0x1ce
[    6.347081]  kernel_init+0xd/0x11a
[    6.347081]  ret_from_fork+0x1f/0x30

[    6.347081] The buggy address belongs to the object at ffff888120cf1600
                which belongs to the cache kmalloc-64 of size 64
[    6.347081] The buggy address is located 48 bytes inside of
                64-byte region [ffff888120cf1600, ffff888120cf1640)
[    6.347081] The buggy address belongs to the page:
[    6.347081] page:000000001f073982 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x120cf1
[    6.347081] flags: 0x8000000000000200(slab)
[    6.347081] raw: 8000000000000200 dead000000000100 dead000000000122 ffff888100042640
[    6.347081] raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
[    6.347081] page dumped because: kasan: bad access detected

[    6.347081] Memory state around the buggy address:
[    6.347081]  ffff888120cf1500: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[    6.347081]  ffff888120cf1580: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[    6.347081] >ffff888120cf1600: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
[    6.347081]                                      ^
[    6.347081]  ffff888120cf1680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[    6.347081]  ffff888120cf1700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

