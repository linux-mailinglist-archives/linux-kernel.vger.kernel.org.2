Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55537A1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhEKI3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:29:53 -0400
Received: from mail-dm3nam07on2071.outbound.protection.outlook.com ([40.107.95.71]:53193
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231216AbhEKI33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:29:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB2r/Y1JCvMnaHcgz9IqaGxFy8WYCtHIHj4TT6Bb8nnoRpVNIw+Pw4XHuPwGX3wfh7tZGR31WXFEHErEEdxw0gIXXRLhvI2OTx4ghQftlISNkROiX3DJrh1XsVQYTNLo8en6ScjG2a+TSdQifpDLPAmQwHJAVbqIZGhbE4xb+0L2wF5IFvJ2bKBhRhJZED9J2dtKByZhRSxaAHSLUguoersiv58mS4gtSsFmKWgdCrV1phYPU39IbU6Y3iRpC8g5fhq/rAoQVM9RoznP1ZXFr01H35+LIpnDLSqYEnEKYIf7c9krAdGHmlFAthwHoxT3e5kG9HeKUZ4Bdr1hgVfqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHOqp9b8NHSWWj+Z7oA1C1I7GeYR7P6vFJlba/irJSk=;
 b=TqrRZADh7szaOEW9pIFp+3m559VJMslvysxOUWOJZrRDMyjvxX+HOOz6mrZDLwETAL1z97pFtJx8M8FN0/gtwOaygPhHhMmQd7060IcN55YEY0UFP1lpKStCQxNgnOauYvKOLERk1t5XU3HyIeaX3sT+rN6FjKTaDKmis9F3Zb1y84LepM9+AsoNown/MH+FeW2sV+6irXV1VOAAZfQb6Rm+kC9Khdg2JnN9hWzH0rVMRuNjavHgncZlxoxD1x4MFvvpXL9m0rMNBgOkZy0AYZa3FusaqbRNtgUroH+rw9p8yJzh9x99iBRsVHGxYs3bAZbTmk38SdjqSkOqXzNi7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHOqp9b8NHSWWj+Z7oA1C1I7GeYR7P6vFJlba/irJSk=;
 b=mHAzTOsD5CEmyODY62nuGYqUTy0wRnQOJrcwSbh3/NIqt5s4wzNAuDOOamqJ1RDp9yyWmJB0vQXqFOqTqb5JiLiO9fxjLkNGCCcMwmg4G0exCg04dy+Tz/JculjsJAA5MZw9Ve4oE/YSVrnyJ5QGTsXiwIvWWBMmj1m/aG4wzVkZgjum4+klMDxnZ8OLnQxudGGCa7hKTOLeXBo1BFVd/cyEZi3JsdIg0Q02OZU664I0nsK0/qgJp6yd4kgNQZQl5kvJrpOjgvCNLOSDYVo5yp5TJsHZrYRDeoFz3m97sKKl29G0UYMeYDpB7wt/cQAXR+U67pL9qrfWNUEvTmGxIA==
Received: from BN6PR22CA0039.namprd22.prod.outlook.com (2603:10b6:404:37::25)
 by SJ0PR12MB5487.namprd12.prod.outlook.com (2603:10b6:a03:301::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 08:28:20 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::f2) by BN6PR22CA0039.outlook.office365.com
 (2603:10b6:404:37::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 11 May 2021 08:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 08:28:20 +0000
Received: from nvdebian.localnet (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 11 May
 2021 08:28:17 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <smuchun@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>
Subject: Re: [kernel/resource]  56fd94919b: BUG:KASAN:use-after-free_in__region_intersects
Date:   Tue, 11 May 2021 18:28:15 +1000
Message-ID: <1620740641.H8NWFiPkCk@nvdebian>
In-Reply-To: <20210511072158.GF8539@xsang-OptiPlex-9020>
References: <20210511072158.GF8539@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a092ebfb-bebf-470d-b345-08d91456bc3f
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5487:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5487544A3D4B41CB97251F9EDF539@SJ0PR12MB5487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyDtynNaOBH3KgeR9nsA+lVwkwbPIQ8WOmz+CMNgUX7zk3CXKpb1SZ5stT6lAsJ4HO3fovOpj6p3DzzAdHBUS35URH/IE0REbgVrivXyGApL9wXPKkYBLnTXXDkcDtu8Y+bTDoZjHHvF3/15OquGqpCMrYWqHJH/w7vZJtEVvgiTcYKFcuWiuhEK1mP2NWLF72WEBt0iizzdDbnLpt2FSaToY85bK9JXXEAGMqKD4vw9XI33QhlSbeV+ekM23PvIueyRdqB09xzdhI7bI+/ftViAC3AeunsJnDZAQm4bdvEwKpchCqpqWDKICUEsDy4yDuTNKCGaEmJ0QEZqqsob4vLd0dTRT75nHo4srRLqJvIPVcU2biUBuudf4EJqA7gdGXU1o1nrUYPalKrvgcfpEJYYZxbLfHaNMEzxTmvLyTyNkwgJpXgPNhmAj+M0PpINDI+YHqPybDTxcUJKmYHW6vUAMm1vfHyccflIR6+cdOrq8KR4IZphxtDV2S6iE62IsEF8wc0m1TR7YQqyOD3+GbVoZR0slpV2Hxhcfg4kyT1lTPxrFHIHigJxbikrAS6PKMcwXWvfRdHKUEVAX2+7t5ayv3Qj2OkTUk2NO7I/Ob4T+NsPq94YTkpjeFqT0lGhodTFibOXrB1EvLf3EPm5rAgczhP7U7Oe7j03oJVh3DA+ar976swfIhI1HRxgLGudraPiGni1QKxarTV93q7XEy16iIcUEpYyuj68+ybNQr4J6VGC39A+B444hdH9cqyspbL/kRkzU3QdE/N0xBlsucsS9Ur9ODDGuXotNTKdhls=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(6916009)(966005)(478600001)(70586007)(4326008)(36860700001)(9576002)(7416002)(70206006)(86362001)(8676002)(426003)(47076005)(9686003)(82310400003)(7636003)(356005)(8936002)(5660300002)(83380400001)(26005)(316002)(2906002)(16526019)(36906005)(54906003)(82740400003)(336012)(33716001)(186003)(101420200003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 08:28:20.5901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a092ebfb-bebf-470d-b345-08d91456bc3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5487
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I see the issue. For some reason when I split the original patch 
series up I inverted the return code for __request_region_locked() but failed 
to do so in __request_free_mem_region(). Additionally hmm_test doesn't always 
check the return code from dmirror_allocate_chunk() which hides the more 
obvious failure resulting in this one which I didn't see on my local setup.

Will post fixes for both of these problems.

 - Alistair

On Tuesday, 11 May 2021 5:21:58 PM AEST kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 56fd94919b8bfdbe162f78920b4ebc72b4ce2f39 ("kernel/resource: fix 
locking in request_free_mem_region")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: trinity
> version: trinity-x86_64-03f10b67-1_20210507
> with following parameters:
> 
>         number: 99999
>         group: group-01
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 
16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/
backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [  148.514812] BUG: KASAN: use-after-free in __region_intersects (kbuild/
src/consumer/kernel/resource.c:516)
> [  148.515030] Read of size 8 at addr ffff8881238c7258 by task swapper/0/1
> [  148.515030]
> [  148.515030] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.12.0-11529-
g56fd94919b8b #1
> [  148.515030] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
1.12.0-1 04/01/2014
> [  148.515030] Call Trace:
> [  148.515030] dump_stack (kbuild/src/consumer/lib/dump_stack.c:122)
> [  148.515030] print_address_description.cold+0x82/0x326
> [  148.515030] ? __region_intersects (kbuild/src/consumer/kernel/resource.c:
516)
> [  148.515030] kasan_report.cold (kbuild/src/consumer/mm/kasan/report.c:420 
kbuild/src/consumer/mm/kasan/report.c:436)
> [  148.515030] ? lock_contended (kbuild/src/consumer/kernel/locking/
lockdep.c:229 kbuild/src/consumer/kernel/locking/lockdep.c:5674 kbuild/src/
consumer/kernel/locking/lockdep.c:5747)
> [  148.515030] ? __region_intersects (kbuild/src/consumer/kernel/resource.c:
516)
> [  148.515030] __region_intersects (kbuild/src/consumer/kernel/resource.c:
516)
> [  148.515030] __request_free_mem_region+0x11b/0x300
> [  148.515030] ? test_stackinit_init (kbuild/src/consumer/lib/test_hmm.c:
1114)
> [  148.515030] dmirror_allocate_chunk (kbuild/src/consumer/lib/test_hmm.c:
468)
> [  148.515030] ? __sanitizer_cov_trace_pc (kbuild/src/consumer/kernel/
kcov.c:197)
> [  148.515030] ? kobject_get (kbuild/src/consumer/lib/kobject.c:662)
> [  148.515030] ? __sanitizer_cov_trace_pc (kbuild/src/consumer/kernel/
kcov.c:197)
> [  148.515030] ? test_stackinit_init (kbuild/src/consumer/lib/test_hmm.c:
1114)
> [  148.515030] hmm_dmirror_init (kbuild/src/consumer/lib/test_hmm.c:1123)
> [  148.515030] do_one_initcall (kbuild/src/consumer/init/main.c:1249)
> [  148.515030] ? perf_trace_initcall_level (kbuild/src/consumer/init/main.c:
1240)
> [  148.515030] ? rcu_read_lock_sched_held (kbuild/src/consumer/kernel/rcu/
update.c:125)
> [  148.515030] ? rcu_read_lock_bh_held (kbuild/src/consumer/kernel/rcu/
update.c:120)
> [  148.515030] ? __kasan_kmalloc (kbuild/src/consumer/mm/kasan/common.c:475 
kbuild/src/consumer/mm/kasan/common.c:516)
> [  148.515030] ? write_comp_data (kbuild/src/consumer/kernel/kcov.c:218)
> [  148.515030] ? __sanitizer_cov_trace_pc (kbuild/src/consumer/kernel/
kcov.c:197)
> [  148.515030] kernel_init_freeable (kbuild/src/consumer/init/main.c:1321 
kbuild/src/consumer/init/main.c:1338 kbuild/src/consumer/init/main.c:1358 
kbuild/src/consumer/init/main.c:1560)
> [  148.515030] ? console_on_rootfs (kbuild/src/consumer/init/main.c:1526)
> [  148.515030] ? tracer_hardirqs_on (kbuild/src/consumer/kernel/trace/
trace_irqsoff.c:57 kbuild/src/consumer/kernel/trace/trace_irqsoff.c:610)
> [  148.515030] ? mark_held_locks (kbuild/src/consumer/kernel/locking/
lockdep.c:4069)
> [  148.515030] ? rest_init (kbuild/src/consumer/init/main.c:1444)
> [  148.515030] kernel_init (kbuild/src/consumer/init/main.c:1449)
> [  148.515030] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_64.S:
300)
> [  148.515030]
> [  148.515030] Allocated by task 1:
> [  148.515030] kasan_save_stack (kbuild/src/consumer/mm/kasan/common.c:38)
> [  148.515030] __kasan_kmalloc (kbuild/src/consumer/mm/kasan/common.c:46 
kbuild/src/consumer/mm/kasan/common.c:428 kbuild/src/consumer/mm/kasan/
common.c:507 kbuild/src/consumer/mm/kasan/common.c:516)
> [  148.515030] kmem_cache_alloc_trace (kbuild/src/consumer/mm/slub.c:2941)
> [  148.515030] alloc_resource (kbuild/src/consumer/include/linux/slab.h:556 
kbuild/src/consumer/include/linux/slab.h:686 kbuild/src/consumer/kernel/
resource.c:178)
> [  148.515030] __request_free_mem_region+0x6a/0x300
> [  148.515030] dmirror_allocate_chunk (kbuild/src/consumer/lib/test_hmm.c:
468)
> [  148.515030] hmm_dmirror_init (kbuild/src/consumer/lib/test_hmm.c:1123)
> [  148.515030] do_one_initcall (kbuild/src/consumer/init/main.c:1249)
> [  148.515030] kernel_init_freeable (kbuild/src/consumer/init/main.c:1321 
kbuild/src/consumer/init/main.c:1338 kbuild/src/consumer/init/main.c:1358 
kbuild/src/consumer/init/main.c:1560)
> [  148.515030] kernel_init (kbuild/src/consumer/init/main.c:1449)
> [  148.515030] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_64.S:
300)
> [  148.515030]
> [  148.515030] Freed by task 1:
> [  148.515030] kasan_save_stack (kbuild/src/consumer/mm/kasan/common.c:38)
> [  148.515030] kasan_set_track (kbuild/src/consumer/mm/kasan/common.c:46)
> [  148.515030] kasan_set_free_info (kbuild/src/consumer/mm/kasan/generic.c:
359)
> [  148.515030] __kasan_slab_free (kbuild/src/consumer/mm/kasan/common.c:362 
kbuild/src/consumer/mm/kasan/common.c:368)
> [  148.515030] slab_free_freelist_hook (kbuild/src/consumer/mm/slub.c:1606)
> [  148.515030] kfree (kbuild/src/consumer/mm/slub.c:3166 kbuild/src/
consumer/mm/slub.c:4225)
> [  148.515030] free_resource (kbuild/src/consumer/kernel/resource.c:162)
> [  148.515030] __request_free_mem_region+0x161/0x300
> [  148.515030] dmirror_allocate_chunk (kbuild/src/consumer/lib/test_hmm.c:
468)
> [  148.515030] hmm_dmirror_init (kbuild/src/consumer/lib/test_hmm.c:1123)
> [  148.515030] do_one_initcall (kbuild/src/consumer/init/main.c:1249)
> [  148.515030] kernel_init_freeable (kbuild/src/consumer/init/main.c:1321 
kbuild/src/consumer/init/main.c:1338 kbuild/src/consumer/init/main.c:1358 
kbuild/src/consumer/init/main.c:1560)
> [  148.515030] kernel_init (kbuild/src/consumer/init/main.c:1449)
> [  148.515030] ret_from_fork (kbuild/src/consumer/arch/x86/entry/entry_64.S:
300)
> [  148.515030]
> [  148.515030] The buggy address belongs to the object at ffff8881238c7240
> [  148.515030]  which belongs to the cache kmalloc-64 of size 64
> [  148.515030] The buggy address is located 24 bytes inside of
> [  148.515030]  64-byte region [ffff8881238c7240, ffff8881238c7280)
> [  148.515030] The buggy address belongs to the page:
> [  148.515030] page:(____ptrval____) refcount:1 mapcount:0 mapping:
0000000000000000 index:0xffff8881238c6440 pfn:0x1238c6
> [  148.515030] head:(____ptrval____) order:1 compound_mapcount:0
> [  148.515030] flags: 0x17ffffc0010200(slab|head|node=0|zone=2|
lastcpupid=0x1fffff)
> [  148.515030] raw: 0017ffffc0010200 ffff888100040d50 ffff888100040d50 
ffff88810004ce00
> [  148.515030] raw: ffff8881238c6440 000000000010000f 00000001ffffffff 
0000000000000000
> [  148.515030] page dumped because: kasan: bad access detected
> [  148.515030]
> [  148.515030] Memory state around the buggy address:
> [  148.515030]  ffff8881238c7100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc
> [  148.515030]  ffff8881238c7180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc
> [  148.515030] >ffff8881238c7200: fc fc fc fc fc fc fc fc fa fb fb fb fb fb 
fb fb
> [  148.515030]                                                     ^
> [  148.515030]  ffff8881238c7280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc
> [  148.515030]  ffff8881238c7300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc
> [  148.515030] 
==================================================================
> [  148.515030] Disabling lock debugging due to kernel taint
> [  148.690200] HMM test module loaded. This is only for testing HMM.
> [  148.691899] test_free_pages: Testing with GFP_KERNEL
> 
> Kboot worker: lkp-worker29
> Elapsed time: 180
> 
> kvm=(
> qemu-system-x86_64
> -enable-kvm
> -cpu SandyBridge
> -kernel $kernel
> -initrd initrd-vm-snb-123.cgz
> -m 16384
> -smp 2
> -device e1000,netdev=net0
> 
> 
> To reproduce:
> 
>         # build kernel
>         cd linux
>         cp config-5.12.0-11529-g56fd94919b8b .config
>         make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 olddefconfig prepare 
modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in 
this email
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology 
Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel 
Corporation
> 
> Thanks,
> Oliver Sang
> 




