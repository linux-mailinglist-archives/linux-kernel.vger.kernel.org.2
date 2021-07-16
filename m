Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA713CAFD5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 02:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhGPAEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 20:04:46 -0400
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com ([40.107.93.54]:64865
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230519AbhGPAEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 20:04:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zp1vtDjXLL1zYnIcXmo2yzStmwBDGV0MMCknLlHGCNIOpAR8/OaRLidh5nIYwRuVhywESf/MTwM2+8vPbmzPANChfEKTxBy/j5yKHbQ6TId9W646Cay+6gH+zTAajz2S7mqXHLBe7Af1hxXRm7H6eTAjtJRQtzKOYGYjidjs+wtn3vYOQunAXpT+AFhVPcHUKUbr8tMx9AUgKM8ksNu6qgZBiKDvtAAUjctXQYef9DfiyhO1juzRqYaOG8My+RpCR9B9tdPxEnf7FaJuPFEPlMtPXL1Y7wYtpr7u+5Lz5LU/Pp/6q+QLxMbM3DvjKzf4bJGUHPythnwAIkwYJVuuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+RgC3Jkn/tvAzG34GUla3Tb03NxghbFzOnPVQ1AFzg=;
 b=mvT6/XtnJeUVNB3p2bsopWGn82XSkqwHvp2MG8h+A9o1xXUGjBJtjZOLzEMGVtA57OKsBX5yWLaj04vBS2VZU1/s0zGaHbFxM8VZMaio4VYwTzhngEr7whvJruezW8hrgD1C5GXlPqIuWDr3Bg1y50cam54+BSmr1rOVVmIUGy1uS7E9t15Tbf4tFzgtYM2R3agsmPi6zo1nW8Piyuz6PC7M69Wv1oYD4IyYbCOcFUWGyhjMHrVroS9RJe6S6A3LHqcBQmCKecmjcGSEH7INZFYXL3e/jZ945CcyyLhn1ON8X/AYDNW6HNfn+6NCLX4288PXzdmRdWmqMmfIuyv8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=cmpxchg.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+RgC3Jkn/tvAzG34GUla3Tb03NxghbFzOnPVQ1AFzg=;
 b=KqMQFsX1niLkwlcuRyvwwjhJ6rTLQMBEhvLRH2NVkkvx0SdMPcCHHASExb8svZZlmSupXpoAD9/c5BVc0RTuwaO5yIu0nbtv96hxVVRaVKb7Q3TlUGLQkIwFN40YYb/jV8BW2uPO7gX+L1wHEnTVMEHp81zqMvinhEmQtfYOsA+0vhWrdouf7UR9sY6EZmcp2kF/Uda5ryM3wHdB3dnVbispneihGAi9oYz+bySTeX4K2trEsASmiFmKVRIK01zDv4F3NTUrJCP5CwSy8TY6tKi+vaBkbFCsEilMmv6OBNxrApk2Y02mB0/A7PDvLeRoVQwMxMbfXTfwuZQV3RTBxQ==
Received: from BN9PR03CA0873.namprd03.prod.outlook.com (2603:10b6:408:13c::8)
 by MN2PR12MB3261.namprd12.prod.outlook.com (2603:10b6:208:108::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Fri, 16 Jul
 2021 00:01:46 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::29) by BN9PR03CA0873.outlook.office365.com
 (2603:10b6:408:13c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 00:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 00:01:46 +0000
Received: from [10.2.84.248] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Jul
 2021 00:01:45 +0000
Subject: Re: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to
 anonymous LRU list
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <vbabka@suse.cz>, <axboe@kernel.dk>, <iamjoonsoo.kim@lge.com>,
        <alexs@kernel.org>, <apopple@nvidia.com>, <minchan@kernel.org>,
        <david@redhat.com>, <shli@fb.com>, <hillf.zj@alibaba-inc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-2-linmiaohe@huawei.com>
 <YOvtmy9ggJA4KUIQ@dhcp22.suse.cz>
 <9409189e-44f7-2608-68af-851629b6d453@huawei.com>
 <YO1dGvcTLaRJplRQ@dhcp22.suse.cz>
 <ec86d902-1da5-2f49-7324-a796d32ac979@huawei.com>
 <YO2WUx0a5go71Vhm@casper.infradead.org>
 <b17caa5f-f3db-9fb0-fe1f-45510ff902c8@huawei.com>
 <YO7PJCm+1zFPZZPS@casper.infradead.org>
 <b7bb60b6-986d-02c5-e58a-d249c0185092@nvidia.com>
 <0634e9d6-9fcc-e65f-dc5e-bed13004b8fe@huawei.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a20a937e-da73-0aea-0373-36f01b3a6425@nvidia.com>
Date:   Thu, 15 Jul 2021 17:01:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0634e9d6-9fcc-e65f-dc5e-bed13004b8fe@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d293b68-55ce-43df-6167-08d947ece74a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3261:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3261067D2155307C3D3D1290A8119@MN2PR12MB3261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V05whQushzShOjWVV18cCxMgXrxV6ktc3B9gKqv/w0B4csuACvmus0kh1UYb/qpK5boXXnRyv7puFjUGuJJ0XR6GQij8hLzZxpsNwoPIiE6Sgb4PW25e40sJhzqKQLtOYooyqMNncRt+0bcYVdlbZQMGldHilg72S32e7ONKPY09fuek7LBkCOyYkL6FsJNY1lDLlwz6YBfwfsMFf6+fUZUw+WLKDtvMpN9viPHPLym7IlarHrDaQOHxMa4qrLNDTjTzZe9iPlLdp+6d+m+cf5BkG6wyIka84/+Lx9we0WShzc+sS30eA/Oiyts8Vvbe70fX0HLrs1MTVfNMobH3r2MCM00BXOYdjgzDXiVF4y1SfhEfRzRnzz/Ep4ZYsGeuMehzRAvCnuARgDpKyHWRAyjgq+HGF1kxHoERTuEtcXpToVScFtc0p+x6cWHD5GCsKVA3t0Y8bMbnatDnCeXRlfXEEbKb5Gc36qtElBNYRhsJGPJZejfGi/FF+MEIraJp1JnS4ipt+gYcAkWYGFkKETh5Dloue6/dPcYvKFYPVysaCRJyaIzkOT2ohfdB5nG+vVVpK6vbdNxUJa9A+MB96v/VlTIac81d2+qSzgt8sRGQfNB/PM5x8xrNBtnLWVhJRej95XvcRa3SuYd6KGSdbMlq/aq3+AK6BbwCoDqZ+SZ9o6h6sNzj/1ICQhRZkaGdwv0YNYLfNQyyUhQ1fPOLp2XPS/GuYIP5pCMhN2HvKIwtYSf9iq0M1PisUeknacIdszSr47rekSI6ycf0fxcZzA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(2906002)(16576012)(36906005)(5660300002)(16526019)(4326008)(34020700004)(7636003)(8676002)(53546011)(47076005)(36860700001)(316002)(82310400003)(356005)(36756003)(2616005)(70206006)(8936002)(7416002)(478600001)(110136005)(186003)(426003)(31686004)(31696002)(26005)(54906003)(86362001)(336012)(83380400001)(82740400003)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 00:01:46.6112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d293b68-55ce-43df-6167-08d947ece74a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3261
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/21 4:30 AM, Miaohe Lin wrote:
...
>>>> So, it seems lockless GUP can redirty the MADV_FREE page. But is it ok to just release
>>>> a redirtied MADV_FREE pages? Because we hold the last reference here and the page will
>>>> be freed anyway...
>>>
>>> I don't see how lockless GUP can redirty the page.  It can grab the
>>> refcount, thus making the refcount here two.  Then the call to freeze
>>> here fails and the page stays on the list.  But the lockless GUP checks
>>> the page is still in the page table (and discovers it isn't, so releases
>>> the reference count).  Am I missing a path that lets lockless GUP dirty
>>> the page?
>>>
>>
>> If a device driver pins some pages using gup, and the device then uses dma
>> to write to those pages, then you could get there. That story is part of the
>> reasoning that led to creating pin_user_pages(), which btw does not yet
>> fully solve that case.
> 
> Many thanks for your explanation.
> So the similar scenario that is clarified in the __remove_mapping() is possible:

I probably should have added that the scenario I was describing is broken even
before any patches that you might apply here. I was just trying to ensure that
the complete list of scenarios was known.



thanks,
-- 
John Hubbard
NVIDIA
