Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6913C8EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 21:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbhGNTu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 15:50:26 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:52353
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235386AbhGNTqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:46:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OarhPD6wJdbJUzISojhMp6hP6X0fKsoiME3KUA+S5/q1B+mXLYJqea6aunhXOX5X203kh2JheDFtG4o+8HScj1jERLcNQsRH/hnJ7PpdpDGbhbpH7sv51RenEhFu+lvBHpVpeIlkfWvpCQlhTn6EYP5e36M0/bIS9jnajSf4tavLdAVGVDqYMwhS6//MvNgTKNz6J8+9r4D4xrY5af8W0PN5LFCcoLgEZssATEL013oQCr6tkJ8E55vYeik6H0peEOg4XFZYyN3lere0WOaNkH6goqAWBV1Tw/cCz4ThrQ8kh5ZAQkgMSwrcNdwdQnAnHwkizAYJGglOme6Q4PCQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQDVC9iYT9zCyaiRwPtWzTGsDjT5yO6wjlbFppcF1LY=;
 b=ZiQSi17o3acFx5yUljhkmvdJEIjWH8m3zUniWPwAHNmC9WubM7L8Z0utvSVtqM53ZTZBNHd1n3M3SptajCW/tI8eYB5+M0wJZIqfblvimgI4y8l3zNxuJoF3CDJuGUpZ+rZ3n10DzX3ltSlDd+K2PV2BBSgfn16fJom4tW/tHN/0mpZgd24kxza0+ZAUibHaJCYxIOWH6PXSTJ81VQf8WTUF/rfiLQf5BJEKmBtGPyaFP6hByznWJBorExnqkXvdqwu65Ebp9VE8xU9W2ca+cWfZ1cc7O0fPQats2MeE+YGvhYT6XKo6Z3fdtAq2pY9dHRx7wJ8uzNR8Njbhb9fyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=cmpxchg.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQDVC9iYT9zCyaiRwPtWzTGsDjT5yO6wjlbFppcF1LY=;
 b=hQv8I6cHgd0cgEvOIr7hOFMgnVEH10wr06kTkP5XMcA4d2+7nW22sPiI3qMSiB6KFRi3BRx06E83hYnKX6BJswQ5AXLBLNRkknEDOsnfeH5jSG6KEcaOlyaW0h+flzkyPF3D2bY0lOC4ftQiSvZh5BsFkFtW6gC48hUee5teOzlEMxqy76A42Raq4Begs2nnPpoSS7LoUhWRwjeyAL4mGR+PFsQnr9Dw/TEON5sIWGvDhJguPAdAgCxWmu4IysGdhnXrvxCWM6nDrRDGd5x4z4lC09A9crZzi0rqxEK/NRH6w1SmesWxjgidZORFhyI/THxU7tnwZ1Kgniyp76vtHw==
Received: from CO2PR07CA0050.namprd07.prod.outlook.com (2603:10b6:100::18) by
 BL0PR12MB4756.namprd12.prod.outlook.com (2603:10b6:208:8d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.21; Wed, 14 Jul 2021 19:43:40 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::8d) by CO2PR07CA0050.outlook.office365.com
 (2603:10b6:100::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 14 Jul 2021 19:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 19:43:39 +0000
Received: from [10.2.84.248] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Jul
 2021 19:43:38 +0000
Subject: Re: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to
 anonymous LRU list
To:     Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>
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
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b7bb60b6-986d-02c5-e58a-d249c0185092@nvidia.com>
Date:   Wed, 14 Jul 2021 12:43:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO7PJCm+1zFPZZPS@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a62bf12-6a8d-4b9b-8598-08d946ffae02
X-MS-TrafficTypeDiagnostic: BL0PR12MB4756:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4756DEE04E08F662DB89FAA8A8139@BL0PR12MB4756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3yXMwxQjmMFOKKaX+61gW60X4bWyWO/28GDaTQk0ZbnMhZqAyARZObcZigohxL7IdyN+8wpPJ76JDgE2zRGFBGukO0+ec+zBpj+X71lARxs/K7rm7u4HffTt2rOMzWWRNyah3mmhDjgylpN7FOT4at0C3L1LPHhgkbX29Vhoh9ChDcqMi3KehoVMmdc2z9v9t5FIR4xL1pAQRJS/fKplwhxBarsZicUDnX9WZ/2atZj1kjxLR0/BYVAWXQ7GtLijg+gGy0643C/Fv8zn2+EMTRkj20tnq+TtIX+w+ZjfPC1Yhd5moKpZXfTJBf31zyDT9cAPqTdpgoUAmnig+km0xbfri+mQlPDmKxIeB2+yAj+IlzJ/kKkujzG/TgwMacXhW19hva5uy2E6Syok6yEM9eYWAcND0Xh2WylNpzF5qnuj1x+PMgCbo1M5P5dDqgl2K89ufWbiBb98E6XfKKLHLKywVyzBabZsPE347tXAz2ej0WaWBDfLH7k9atx8w0xKU2YlzqbHfsy02r+QAvq+GKYMPECaG8aMEtDZH8rUnMcorc6QNS5LPMoVTjATvBgIjVjpU2ycOpTH0iS0sMv9fI65WS16/5r94y92KXi+TRUa/+vAi0/NWwGRzyE208vOArgO6NPJWjmQzDigVmu92/QFplbHPKX7WmBtJtkHG+jkJjNWMPtVzXB07SK0bhWuzKGX4gW8Ju0uWb3UJ1PQPKeZ5fxjTEYFH9+X64x2Ge/T1OxnCPuVkBbi5DArYkOLUlcq/7v1DPNNytunEz47A==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(83380400001)(47076005)(31696002)(4326008)(82310400003)(34020700004)(86362001)(53546011)(7416002)(8936002)(36860700001)(2906002)(356005)(16576012)(36756003)(36906005)(70586007)(186003)(426003)(31686004)(82740400003)(7636003)(478600001)(70206006)(54906003)(26005)(8676002)(16526019)(5660300002)(110136005)(2616005)(316002)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 19:43:39.8302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a62bf12-6a8d-4b9b-8598-08d946ffae02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4756
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/21 4:48 AM, Matthew Wilcox wrote:
> On Wed, Jul 14, 2021 at 07:36:57PM +0800, Miaohe Lin wrote:
>> On 2021/7/13 21:34, Matthew Wilcox wrote:
>>> On Tue, Jul 13, 2021 at 09:13:51PM +0800, Miaohe Lin wrote:
>>>>>> When the MADV_FREE pages are redirtied before they could be reclaimed, the pages
>>>>>> should be put back to anonymous LRU list by setting SwapBacked flag, thus the
>>>>>> pages will be reclaimed in normal swapout way.
>>>>>
>>>>> Agreed. But the question is why this needs an explicit handling here
>>>>> when we already do handle this case when trying to unmap the page.
>>>>
>>>> This makes me think more. It seems even the page_ref_freeze call is guaranteed to
>>>> success as no one can grab the page refcnt after the page is successfully unmapped.
>>>
>>> NO!  This is wrong.  Every page can have its refcount speculatively raised
>>> (and then lowered).  The two prime candidates for this are lockless GUP
>>> and page cache lookups, but there can be others too.
>>>
>>
>> Many thanks for pointing this out. My overlook! Sorry!
>> So, it seems lockless GUP can redirty the MADV_FREE page. But is it ok to just release
>> a redirtied MADV_FREE pages? Because we hold the last reference here and the page will
>> be freed anyway...
> 
> I don't see how lockless GUP can redirty the page.  It can grab the
> refcount, thus making the refcount here two.  Then the call to freeze
> here fails and the page stays on the list.  But the lockless GUP checks
> the page is still in the page table (and discovers it isn't, so releases
> the reference count).  Am I missing a path that lets lockless GUP dirty
> the page?
> 

If a device driver pins some pages using gup, and the device then uses dma
to write to those pages, then you could get there. That story is part of the
reasoning that led to creating pin_user_pages(), which btw does not yet
fully solve that case.

Basically, though, unless a non-CPU device has access to the page, it's
hard to see how gup itself can lead to a page getting dirtied.

thanks,
-- 
John Hubbard
NVIDIA
