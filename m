Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B08A34E095
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 07:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhC3FSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:18:12 -0400
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:50913
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhC3FRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:17:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDo+AvZ8uFoEyIy7X4PFPmxDl9coHxxlWIcNrfZwL8dSSE4rGsoVokP2dkuzwl9w/IAY75KNbY4V548dc9tQ7VjWeBh6Z1ETeSKt+MbGWmISQvpB7eON7vrrFObe1iKRUlhbkhphCInHksd5raB6oDt+XuPCokdeMGuEC6nq1wshzCrKTuQJM/euh8blAFzQ7BVpAce4a3Szdr2op4hNhKRrGQh9rQqLwholIsedYZ5Ym5Ka21gSsMhQOKi4v2QjApFkW23Rptqw7OliTtG5wLXCIJO/pobpGQ+FenWbUaBfpo57mZh2WLCA3Wp+3ufdu8hdZJULOBZdXYRWeeQsgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXuo7iYnrsjFjsE3ld5AVW1Xw2KZEg71KKbhjk8VR1M=;
 b=hDL2BK7nCs5ZMwTox0c+RznPrPbmmpNOMj6c/9fTTHbIJTszPqfFLziofwePqhbrY0WqOOqxnlpvfCTC86hw3wxPxvOJsh3wQLm52ktyMV2Y2tXzdMkts7Yf/aCpOTbtitGG5YLjB4Kc8NSJkH2KYZ/DxwJHZREVUyOv9yWyUusMfa8PCZvusrOd8/Psu6MrC34ZT59zAdtgOLkMg+mcdzojkLhJM6kUBb/In/rJBa2A1J0xHubl9kBo3+LiNiw9b2Y4Db0G4zeRiXNZhrWsGYiXh7uMGcueQjoFQAnMzVp6O0yq/cMJqKs896/6gJQY2ZYiaOR92JxT9/N++VVsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXuo7iYnrsjFjsE3ld5AVW1Xw2KZEg71KKbhjk8VR1M=;
 b=LVf4f5qxMReyoSOhNfEJwids2bcK/FpOXtrdigB8lVUs+Mqxn4cEM2riDyt9W/2FVo8ae+rAHX01wOj30UH8T02xZQ1HUA1ojrF93SwnabtSUDjAOKPjv1874SKDsWh+y10+7K90Z+rd8Kq3gZmN0asdXg/30vx3lFQu2D6xwhTQEYjaMhgAEFg0shZulAgiIv25mxeakm1oE7r4o6SjX2oiAeCDmvHmACuKcYPUSDYphq0bw8Gl6u20Bhphj6SrXo+/qvqYJ2cF2viSOnF+b3bpKN87tp1X4KF3TOYQvZnkAH8m+ZuCokxX7C32zxfyBotb7BPNeWZBUXlKwm3C4g==
Received: from DS7PR05CA0025.namprd05.prod.outlook.com (2603:10b6:5:3b9::30)
 by MN2PR12MB3936.namprd12.prod.outlook.com (2603:10b6:208:16a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Tue, 30 Mar
 2021 05:17:43 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::d1) by DS7PR05CA0025.outlook.office365.com
 (2603:10b6:5:3b9::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.17 via Frontend
 Transport; Tue, 30 Mar 2021 05:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 05:17:42 +0000
Received: from [10.2.63.109] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Mar
 2021 05:17:41 +0000
Subject: Re: [PATCH v3] kernel/resource: Fix locking in
 request_free_mem_region
To:     Alistair Popple <apopple@nvidia.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <david@redhat.com>,
        <daniel.vetter@ffwll.ch>, <dan.j.williams@intel.com>,
        <gregkh@linuxfoundation.org>, <jglisse@redhat.com>,
        <bsingharora@gmail.com>, kernel test robot <oliver.sang@intel.com>
References: <20210330003842.18948-1-apopple@nvidia.com>
 <801cd23e-9ac0-adb6-88ba-63ad18d4664c@nvidia.com>
 <7635785.yHxt4vaozm@nvdebian>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4738a7e1-ec62-0b11-28df-e81c0f904f84@nvidia.com>
Date:   Mon, 29 Mar 2021 22:17:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <7635785.yHxt4vaozm@nvdebian>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1d18322-b3a8-4c68-bbb1-08d8f33b2551
X-MS-TrafficTypeDiagnostic: MN2PR12MB3936:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3936F6A0F1CD5341AFF4193AA87D9@MN2PR12MB3936.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrkLw6Zf5JrhWnB+heThMtJNd9J33JpGAsuZgz2YjZQC++J2Jy7/7hDnkYXjyClObQVa44ku7b5OPY87eDnJrNaACIdyY3heURN6v21xtkBXQwGmeGjmbBkzAC5Eoh0Gmg8fBKzkZkuZGLxYzmDEMvg+p8kBoQMAzQjtKMP8c6ZOofLtvUX2BCvwlmT1V8V3jzwGQWgOLAbNtBTabozgSKaAf38R4LvA1/L4NjSUNo8nwWx+Ix1l/wRhGvzImAuon/35kMxb8xohcy/XkGj7JbKcJKWPuQJZ/jHpdkWXkaVNjgov/TJxmFKOCWopoXCxFuTUjZweOrNbQ8/YI3IkwiUVSHvMOhH3UKdaaNcNpCemhZ1v1o6PzyJIBsEgrt3QXCZMH0YkHv90c6Lb1brOzWduInPTIBxfjkqygNPWXfdbMLSHovFJL1yrEqkFmMGVhYsHssuigSQ9EXl1pYm+yZqGvamx3CkVvDFqXCK3gdxD3/CDZctbBsRi4TI1/gmhQfzb00zTPQ5lSk4CgmRWPUNLRl8mPVKQZsfz4a/jJCmz7813O1n9CIyzh3cFlmYPCnh5MDOBXqnU+U9xhuaNhd3Et9yqCvbdrPCOCeYMMhMJXHD8hc6BzVE792KggoQ7TuaFHm4eRDDNTvvPs8SID3lIQGRlyfhjZ9RNkFTbEXzMAyV3FASZTlLXAN2BnzSn
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(36840700001)(46966006)(7636003)(82740400003)(31686004)(36860700001)(26005)(336012)(16576012)(53546011)(31696002)(54906003)(70206006)(16526019)(2906002)(426003)(6636002)(356005)(186003)(47076005)(7416002)(8936002)(36906005)(4326008)(316002)(36756003)(2616005)(6862004)(5660300002)(37006003)(70586007)(86362001)(82310400003)(478600001)(83380400001)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 05:17:42.6589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d18322-b3a8-4c68-bbb1-08d8f33b2551
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3936
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 9:59 PM, Alistair Popple wrote:
...
>>>    		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
>>> +		if (dev) {
>>> +			dr->parent = &iomem_resource;
>>> +			dr->start = addr;
>>> +			dr->n = size;
>>> +			devres_add(dev, dr);
>>> +		}
>>> +
>>> +		write_unlock(&resource_lock);
>>> +		revoke_iomem(res);
>>
>> This is new, and not mentioned in the commit log, and therefore quite
>> surprising. It seems like the right thing to do but it also seems like a
>> different fix! I'm not saying that it should be a separate patch, but it
>> does seem worth loudly mentioning in the commit log, yes?
> 
> This isn't a different fix though, it is just about maintaining the original
> behaviour which called revoke_iomem() after dropping the lock. I inadvertently
> switched this around in the initial patch such that revoke_iomem() got called
> with the lock, leading to deadlock on x86 with CONFIG_IO_STRICT_DEVMEM=y.
> 
> This does change the order of revoke_iomem() and devres_add() slightly, but as
> far as I can tell that shouldn't be an issue. Can call that out in the commit
> log.

Maybe that's why it looked like a change to me. I do think it's worth mentioning.


thanks,
-- 
John Hubbard
NVIDIA
