Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F21348222
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhCXTps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:45:48 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:37313
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237905AbhCXTpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:45:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuPBY/pUOCUSnJhzh0Uaw1oKvBuJcY9cUmcta3XVnuT6Hr4S62HqSpiMfpagurzvTBjUm7F0yVKKtNSYQmDTxkgqguzUk67E/Rhnrl5Z+pRgPBh3zfgMyH5fqQEVx3tvuRkTIeV6z8/EjYwp2F6s7lcBPGW73kFWEmhP+pbCdNaTIUU4pkOBt48zNrCug9JFnSQC8/Q1z/VDRvj5pGCS6bETMx+V+thwDndyC+W4xAg9hGQ3X7M1Nq5iqFZWDXhiV1DtYRYJc9XidZYsqCXYflbj6A56/1Y1/ZO8kOCqp5Au2zSvM0ibYZ0OGD377J5zcfwYQCd6FJgEQIhuNy1qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3V6vrcHJTLfh9/wz3rmfdZGkwzSG6O1Sc2xu/plBKVY=;
 b=PFb4bSYrtA13/hnCoGJ/BitFWfQWZ4OumIx3YYYae/WaeBBgFLhahxe5yZTDTteYAGBb7Jq7O48XhqcntfAr4YHe4pAlt8COvfLUo3y1apnP4/64BRqNzmoZGq6CFxXsadvhTkiS0ye882I/r8PlKMmquHrQN2/ScMECpRfTaTi75azU0stG17wYlFXgyQFu0NK41gQwe0kOPgZVHtpVehlYu3DDGyl1fHpnpF0hHnZd+10OQ3N1lCySaqfl8GfNkEsbHYbf/+/3V58u7XVoJp96/D2plLaIlRFQbaKB7M5TyMFzyZGkIX6DelLuSQLMmyE27su8bJliiUAO8ytVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3V6vrcHJTLfh9/wz3rmfdZGkwzSG6O1Sc2xu/plBKVY=;
 b=BNiBD0BZllyBvlEsZDB1SIg5A6uZzvaSFMC3TtJzkTiy2dA2RrrBzv4FbpeX3FnihL4VgbcpFc6+KeJS+rUiFD/5Onvm25MvzCh4yJEbichl9klX6evZ4ytl230TgF+nxm3WCvSfXBHHYVDA61iwm1z0bSgt3kezuM0vsVJWcq3ixe4UzBfDF55flu4kC2OS5AxeeYsH+B/MBKTWMXF/rx9sOznY0lI3U5BZbqT0o2YjNjYSrdsn8K98gd3+sxcMXhg9fVlBGR0HyJf3BgWLMXpVhrVRdoj7UuR0uDQcgX6QJOgCm4I3dkyjMI/jI7JLHRooVF1P7jZs27UUcav64Q==
Received: from DM5PR2201CA0020.namprd22.prod.outlook.com (2603:10b6:4:14::30)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 24 Mar
 2021 19:45:21 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::92) by DM5PR2201CA0020.outlook.office365.com
 (2603:10b6:4:14::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 19:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 24 Mar 2021 19:45:20 +0000
Received: from [10.2.88.242] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Mar
 2021 19:45:18 +0000
Subject: Re: [PATCH] mm: cma: fix corruption cma_sysfs_alloc_pages_count
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, <willy@infradead.org>, <digetx@gmail.com>
References: <20210324192044.1505747-1-minchan@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <01e09f8b-93f9-cd59-1f12-7ab4c86743e6@nvidia.com>
Date:   Wed, 24 Mar 2021 12:45:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324192044.1505747-1-minchan@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b4663da-eecb-4a44-aa2f-08d8eefd5bf4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5238:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5238EAF7B27F241D672CF087A8639@BL1PR12MB5238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjvuGTuxTfYosEzTItJbKRaViKGMaNcx8gmpWRkSpoCo2r3lQFVzPa+7efEfi4YC1ONvNx3pgpYlU4KxRrdbudQu9a5Y5iUOYj8u/BDD1xMhHg0lmS5g2tbVawiCcGM1KaoF2xF9hnTKtsaDlrdyhcEHbZm8dRr/zRWj7GpGnV7c7b9uk7CLQMAdKF3/UBiiYAoga4N51aFVtr/bn4aw3MigPaI/duV+qfTbssk6DBsKgxmxT4iOV5rsyrHc7c/tkLmvPYjAKmvUZ3g6kHo0zFBQiHaXSSCxDkzrqiW81BAjUA0TlhbZV2QrYfWNpA9iue837vZT+xNHSSXtoEEDks2muy8uH34Hnt9a5t+NysDG/gRs3xPjOidTHLcvJpK8z7+YufHYUuWWp9BhKtuPmArLI+1huR9Dh+pOnO2mYMd1y3Q4umS9FYp7s3XzvZB4na9MG65TwdocqmMEctia6GJsiMwlwpRC3V3DibrCkSiieR76OHNH91x7UOQ+Tcsmymi2D7Ygd9QtuGVfwzHr2jyZRurxmr1fzxkB7h0jsVHMABZaW3pJCZpnhcadBx6WaNWbI+RipK+mMRxozDjl0KY3itUTwsaThTBYU4s8b1CV0lN/bZvoAQQZw066pYOtTQLGWQMDlYaFj6y6wjRhhFzvBPHSLJzZgfBIVrPyRUJ+wTD72K7/QNAfYnm5Sp4MtJ3JaAhLF5ccZ1eexrAgRrRmbVgQxG7tMQTYjtzuZ6fAe1mAIPBwOoNRc3+z1OnPBAIjX/fNGJuTbpw9v/RgWg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(2616005)(4326008)(16576012)(54906003)(36906005)(316002)(5660300002)(36756003)(186003)(26005)(110136005)(16526019)(478600001)(53546011)(8676002)(86362001)(8936002)(82740400003)(426003)(2906002)(7636003)(82310400003)(70206006)(47076005)(70586007)(31696002)(966005)(356005)(336012)(31686004)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 19:45:20.8693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4663da-eecb-4a44-aa2f-08d8eefd5bf4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 12:20 PM, Minchan Kim wrote:
> struct cma_stat's lifespan for cma_sysfs is different with
> struct cma because kobject for sysfs requires dynamic object
> while CMA is static object[1]. When CMA is initialized,
> it couldn't use slab to allocate cma_stat since slab was not
> initialized yet. Thus, it allocates the dynamic object
> in subsys_initcall.
> 
> However, the cma allocation can happens before subsys_initcall
> then, it goes crash.
> 
> Dmitry reported[2]:
> 
> ..
> [    1.226190] [<c027762f>] (cma_sysfs_alloc_pages_count) from [<c027706f>] (cma_alloc+0x153/0x274)
> [    1.226720] [<c027706f>] (cma_alloc) from [<c01112ab>] (__alloc_from_contiguous+0x37/0x8c)
> [    1.227272] [<c01112ab>] (__alloc_from_contiguous) from [<c1104af9>] (atomic_pool_init+0x7b/0x126)
> [    1.233596] [<c1104af9>] (atomic_pool_init) from [<c0101d69>] (do_one_initcall+0x45/0x1e4)
> [    1.234188] [<c0101d69>] (do_one_initcall) from [<c1101141>] (kernel_init_freeable+0x157/0x1a6)
> [    1.234741] [<c1101141>] (kernel_init_freeable) from [<c0a27fd1>] (kernel_init+0xd/0xe0)
> [    1.235289] [<c0a27fd1>] (kernel_init) from [<c0100155>] (ret_from_fork+0x11/0x1c)
> 
> This patch moves those statistic fields of cma_stat into struct cma
> and introduces cma_kobject wrapper to follow kobject's rule.
> 
> At the same time, it fixes other routines based on suggestions[3][4].
> 
> [1] https://lore.kernel.org/linux-mm/YCOAmXqt6dZkCQYs@kroah.com/
> [2] https://lore.kernel.org/linux-mm/fead70a2-4330-79ff-e79a-d8511eab1256@gmail.com/
> [3] https://lore.kernel.org/linux-mm/20210323195050.2577017-1-minchan@kernel.org/
> [4] https://lore.kernel.org/linux-mm/20210324010547.4134370-1-minchan@kernel.org/
> 
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Suggested-by: Dmitry Osipenko <digetx@gmail.com>
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> I belive it's worth to have separate patch rather than replacing
> original patch. It will also help to merge without conflict
> since we already filed other patch based on it.
> Strictly speaking, separating fix part and readbility part
> in this patch would be better but it's gray to separate them
> since most code in this patch was done while we were fixing
> the bug. Since we don't release it yet, I hope it will work.
> Otherwise, I can send a replacement patch inclucing all of
> changes happend until now with gathering SoB.

If we still have a choice, we should not merge a patch that has a known
serious problem, such as a crash. That's only done if the broken problematic
patch has already been committed to a tree that doesn't allow rebasing,
such as of course the main linux.git.

Here, I *think* it's just in linux-next and mmotm, so we still are allowed
to fix the original patch.

thanks,
-- 
John Hubbard
NVIDIA
