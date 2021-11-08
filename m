Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26A8447AC1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhKHHYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 02:24:18 -0500
Received: from mail-bn7nam10on2066.outbound.protection.outlook.com ([40.107.92.66]:38625
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232046AbhKHHYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 02:24:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHB89gpwGzr6FC72C0YJLDtmtUNGgpsMjPQS0l9roHFXEaJ2bMI1J/x5tW+8O9DEXw4O9i+FhHXQ3kQlKEf29TFbzbu5AWaD0vKiiv3k4qt//7ZDsoZvFW9eZUitN7d6wqNfR9D5QYQ9YjihPkMmRG7VCtA1RDQw8bSUeMQ1L9wFtzEjHEe8zIalzBHj1GutLTrDweitFUBEZzgdJOqEElz1Xl7NpiiMdhAK8f4iF6JrjEYuij6y4UUt5XHXp3kUbCcXSnKStZUDgsvKNm5dKjHrnlMY0jb3ILn27aVE5bucG8rijy8VqXu1RW1zqf8KXnRrPTWTWXnban65eZ0HcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYGlni1ifR8fbE1cm5CQOfzOwsYEQZg8uFqL7d7yKzc=;
 b=PjN9Wtonad+zM3pbL88NR6PCsYxt8fFRTnHoQE8SseJb2efpAZR+jnWLuQVOk+69T/cFOz5QxnoHkq55XxV0PqpGUqIGhthMPfYLHovqZu/qHZZlr4AZGpo0z4TZd/J0CtUBSVCAsfM7thamVznE8Cn2sqX9O9GmhvrpZ/8dBtXZBQKM/dEywxPoHgYGddo9hPsoZ1q4qPR0JYZJxZzb7H8feVUC6zK1nXJgIUxfKM054tANiqfr8UruavNqJmhnsizCVK8hu9fS7OZX9f4+r+Fh1ZNKVbW947bbrDD43INRl+8c19W4pGg3Qif1N6LUTKj3lR1LkQbBJiW+AxaZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYGlni1ifR8fbE1cm5CQOfzOwsYEQZg8uFqL7d7yKzc=;
 b=ETctO1GepSGBiG/nuSJwknyMc3kCC5qN/iB0KpplM2wWoGBpSXp9QfuCWL4q71diGtZefatkTyvUx0VYTTuIq2YfgpbdxiiYSZXV8sLTqZmwuhEMLv+iV+RhclzWPaMufVTy3oRfI6YFddqhxBTYlzfzJOE/7OkNRTQmU4yM51o47vOeCM+30ZUAoMt/Ix62ul58F81bgX535VUnJ0K5VNfkmm4mY2I/EN1g3dyUamMOO8Pk+1r+zve4ayZVmanaEcMpxbsYgqJaoNqAAXbbcdloLJZ+e6JoieiqYb/CLvIGwxrkaDLTVa+RlysR2sbPT5bogIhsEssLn87xfBFUGA==
Received: from BN6PR2001CA0009.namprd20.prod.outlook.com
 (2603:10b6:404:b4::19) by BL0PR12MB2498.namprd12.prod.outlook.com
 (2603:10b6:207:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Mon, 8 Nov
 2021 07:21:30 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::c6) by BN6PR2001CA0009.outlook.office365.com
 (2603:10b6:404:b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Mon, 8 Nov 2021 07:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 07:21:27 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 8 Nov
 2021 07:21:22 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "hughd@google.com" <hughd@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/migrate.c: Rework migration_entry_wait() to not take a pageref
Date:   Mon, 8 Nov 2021 18:21:20 +1100
Message-ID: <6225389.G64U8xaFcF@nvdebian>
In-Reply-To: <202111051726.2NFKxAPH-lkp@intel.com>
References: <20211104103338.891258-1-apopple@nvidia.com> <202111051726.2NFKxAPH-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0b0d92c-9f8f-45a2-d96c-08d9a2886152
X-MS-TrafficTypeDiagnostic: BL0PR12MB2498:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2498BCC48531F9474E4A3867DF919@BL0PR12MB2498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mw5rmZ4qKdMPewzVXWenE70AjN7tSCt5SuVtxV3qlZ4BqVJhE1QBVZmeIx1aZ0cNuQyxJimeW/Vt6czHoI6iLQ7S7pkAnMQznnAMv1rAhzL/KR70So09X/siDLSZcSSy9lUSNgUcTnAP1ygcCJrebaE/0mbOo7agKiDACxSfu1MB4bfOo9uKm/j8lp9yd7FWohum3gHGeMs0uSDRBy1xKbOu+LmLLIpVwDaryoKeabwspJaFsmRFT0tm+jyb2G0rdhf5AL0XfALQo977Z3Gm1b8HTQHVM4EoW3mT9s8gK9np20Hl8hYhyDfqk7leDSPxu6ZhtlTPdJ3K/9hhL+/WJjv8940V0W+6FbSZMLusZWoXQOHzr+dYd+JUcV3ARCEww4KkhJ0bXHkE6o9utq4NHKAJvPUcyFokuVwvPtxye2ooDZT31U35os1wDt4jqnTZa10daug5rJf4ruHY5a17tTldo6mEvZYrb45Phsp3mktQWfOhTrBeSEWa4UATjozmGShJ/rJLkyVIKnoAPkucNyAklK3/R8c0lT/vsSzZK6hMMBUQ0MrD1lG6C8dawq0Cn/8O4BMXmFGZ1UmiH0oqN4EzUwoqO406YVNzQWV266O1dgqAluAQNFCeHHgixRwSDS3k5MuTf4juoI7YPxvX6eoB+BIpXK0ZtzX2yZIY+2V1hHFeECiFpztxqKucCuIhoM98JGua4mqldrLjQxOcJ3xbJjXp15W6LIJmDEvCPlmfSwPLsl0YjfnS/pXdO4R7CcUhoLCvMej4t5itiC7TnNVxdU41z0M3PKnoaiMm/B4BSTTTgHkd7Ch3Ejl8qEiogRWqalUYMYqCLLaLtoRbqs5Ke2I2HjKu46ZjuSdCZO8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36860700001)(47076005)(508600001)(4326008)(186003)(356005)(16526019)(82310400003)(8936002)(8676002)(7636003)(336012)(966005)(70586007)(2906002)(7416002)(426003)(107886003)(86362001)(70206006)(54906003)(26005)(83380400001)(316002)(9686003)(33716001)(5660300002)(110136005)(9576002)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 07:21:27.1263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b0d92c-9f8f-45a2-d96c-08d9a2886152
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2498
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got this after sending v2 but it will have the same problem. This occurs for
CONFIG_MMU=n which seems to be broken anyway due to other arch build errors (at
least for Arm SA1100 based builds). Fixing this is easy enough though - only
defining migration_entry_wait_on_locked() when CONFIG_MIGRATION=y fixes this
and is probably a good idea anyway.

I will wait a bit for feedback on v2 before sending v3 with this fix.

 - Alistair

On Friday, 5 November 2021 8:50:08 PM AEDT kernel test robot wrote:
> Hi Alistair,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linux/master]
> [also build test ERROR on v5.15]
> [cannot apply to hnaz-mm/master linus/master next-20211105]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Alistair-Popple/mm-migrate-c-Rework-migration_entry_wait-to-not-take-a-pageref/20211104-183442
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2f111a6fd5b5297b4e92f53798ca086f7c7d33a4
> config: arm-randconfig-r026-20211105 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 847a6807332b13f43704327c2d30103ec0347c77)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/0day-ci/linux/commit/e9447498f8f8758741f3dae044c3e4593130595c
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Alistair-Popple/mm-migrate-c-Rework-migration_entry_wait-to-not-take-a-pageref/20211104-183442
>         git checkout e9447498f8f8758741f3dae044c3e4593130595c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> mm/filemap.c:1468:2: error: implicit declaration of function 'pte_unmap' [-Werror,-Wimplicit-function-declaration]
>            pte_unmap_unlock(ptep, ptl);
>            ^
>    include/linux/mm.h:2275:2: note: expanded from macro 'pte_unmap_unlock'
>            pte_unmap(pte);                                 \
>            ^
>    1 error generated.
> 
> 
> vim +/pte_unmap +1468 mm/filemap.c
> 
>   1413	
>   1414	/**
>   1415	 * migration_entry_wait_on_locked - Wait for a migration entry to be removed
>   1416	 * @page: page referenced by the migration entry.
>   1417	 * @ptep: mapped pte pointer. This function will return with the ptep unmapped.
>   1418	 * @ptl: already locked ptl. This function will drop the lock.
>   1419	 *
>   1420	 * Wait for a migration entry referencing the given page to be removed. This is
>   1421	 * equivalent to put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE) except
>   1422	 * this can be called without taking a reference on the page. Instead this
>   1423	 * should be called while holding the ptl for the migration entry referencing
>   1424	 * the page.
>   1425	 *
>   1426	 * Returns after unmapping and unlocking the pte/ptl with pte_unmap_unlock().
>   1427	 *
>   1428	 * This follows the same logic as wait_on_page_bit_common() so see the comments
>   1429	 * there.
>   1430	 */
>   1431	void migration_entry_wait_on_locked(struct page *page, pte_t *ptep,
>   1432					spinlock_t *ptl)
>   1433	{
>   1434		struct wait_page_queue wait_page;
>   1435		wait_queue_entry_t *wait = &wait_page.wait;
>   1436		bool thrashing = false;
>   1437		bool delayacct = false;
>   1438		unsigned long pflags;
>   1439		wait_queue_head_t *q;
>   1440	
>   1441		q = page_waitqueue(page);
>   1442		if (!PageUptodate(page) && PageWorkingset(page)) {
>   1443			if (!PageSwapBacked(page)) {
>   1444				delayacct_thrashing_start();
>   1445				delayacct = true;
>   1446			}
>   1447			psi_memstall_enter(&pflags);
>   1448			thrashing = true;
>   1449		}
>   1450	
>   1451		init_wait(wait);
>   1452		wait->func = wake_page_function;
>   1453		wait_page.page = page;
>   1454		wait_page.bit_nr = PG_locked;
>   1455		wait->flags = 0;
>   1456	
>   1457		spin_lock_irq(&q->lock);
>   1458		SetPageWaiters(page);
>   1459		if (!trylock_page_bit_common(page, PG_locked, wait))
>   1460			__add_wait_queue_entry_tail(q, wait);
>   1461		spin_unlock_irq(&q->lock);
>   1462	
>   1463		/*
>   1464		 * If a migration entry exists for the page the migration path must hold
>   1465		 * a valid reference to the page, and it must take the ptl to remove the
>   1466		 * migration entry. So the page is valid until the ptl is dropped.
>   1467		 */
> > 1468		pte_unmap_unlock(ptep, ptl);
>   1469	
>   1470		for (;;) {
>   1471			unsigned int flags;
>   1472	
>   1473			set_current_state(TASK_UNINTERRUPTIBLE);
>   1474	
>   1475			/* Loop until we've been woken or interrupted */
>   1476			flags = smp_load_acquire(&wait->flags);
>   1477			if (!(flags & WQ_FLAG_WOKEN)) {
>   1478				if (signal_pending_state(TASK_UNINTERRUPTIBLE, current))
>   1479					break;
>   1480	
>   1481				io_schedule();
>   1482				continue;
>   1483			}
>   1484			break;
>   1485		}
>   1486	
>   1487		finish_wait(q, wait);
>   1488	
>   1489		if (thrashing) {
>   1490			if (delayacct)
>   1491				delayacct_thrashing_end();
>   1492			psi_memstall_leave(&pflags);
>   1493		}
>   1494	}
>   1495	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 




