Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA03AED2B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFUQNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:13:38 -0400
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com ([40.107.94.84]:44001
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229789AbhFUQNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:13:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip8B8+vx8lGVVmzuu2zXC1w6RPrN8Lc4PIckW1kwjia2qy4KAN3+WF1OxcNMRkpgyhdFgjYq7YJr7rVhQeSDv3QgC1Nh8nJDLhewTta9ddHL/tWd9sbpnDPmpQa2pDhV9eqgoagedmXoqaQI8GFQ7zJQSxb+qEexPDQghbhC6ip2fWAbtOpg2QVLdFbSst3u9m48lSv1x2L+s289ylTb2zTYksEsLxt/2soaZWPHB5jIvusZjMDc440hqLwTiupdXhWV3quJRjmdUNiZ2DpBwLSCb4MrJOFh1hxZhb7uJtfOGq8UbSS7qmuv2RXob+gNOv9BN5uIfz57m3rW08MsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+tEVUKfxYPKBYhwLIHzlT6yjHdYzrKc7CIilD+VVEA=;
 b=O/XANj2igSkdeeEheIJEvWnGxaJwRJNyl5uFYIlRjv1yzMuSeC16BJPiR610wT1MKjM5OzJTp+kx9dtPq7JNDhPymjn9pF41fhYbuKNRhzDJ8rx9KS1155GCHP7E9fwAING7dzQxDhkEImogMUhlAutRD639M+s65BAs6FhwmenN/BKS7dfwt4db7voTso3mb1p4XFhAxanXzjMtEG84fIAISnYLx0lfOSqXhvwVrQQTfC7i6pKn21FLwv2S8Ra2dWaMwIKukFyK9pa3K2jaley/wxKRR0GoJuDe5PR7hgU6tX73gN8gfiNS1KgsD9u7Fs7ZBeJhww+hDWZVI7gWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+tEVUKfxYPKBYhwLIHzlT6yjHdYzrKc7CIilD+VVEA=;
 b=IGnzTGakShcjDDwbJRTHI9r33GaiUGmpNMWjevEg8mpUCN7wKGj5A6WCcmpF+Se/6ow+7ccWsRhqRxqBxuunw42SHLM4j8wG/mB2bGkxmuOWB8pyuBjL//pZ8MiSRH9t6pPaUZV0BSZtHmWaGsABYb2iwLtq+ZDHPtsfPGtVI/qL30Dc0oyCV0YBK7UMeFpDpZy3h5oH9XOccKnKl3VfYXElFfd/MLm2wOZM/kaEwkCaYS0MNOykfuvEMjBaJ2OZc9tHnk5iT2eTN30eA4j+T6L3Qna7ymNvTTEpxPLFN/PGTlJURZooBm+M1Q8cS3AIeQmamY1Gv5hUq/gUt8DFOg==
Received: from DS7PR03CA0270.namprd03.prod.outlook.com (2603:10b6:5:3b3::35)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 16:11:19 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::a7) by DS7PR03CA0270.outlook.office365.com
 (2603:10b6:5:3b3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Mon, 21 Jun 2021 16:11:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 16:11:19 +0000
Received: from [172.27.15.67] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Jun
 2021 16:11:15 +0000
Subject: Re: [PATCH 1/3] mm,memory_hotplug: export mhp min alignment
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>,
        <linux-nvme@lists.infradead.org>, <dan.j.williams@intel.com>,
        <logang@deltatee.com>, <linux-mm@kvack.org>, <hch@lst.de>
CC:     <sagi@grimberg.me>, <oren@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
 <20210602111055.10480-2-mgurtovoy@nvidia.com>
 <283740c3-db3f-3c9a-2954-f1c037a13e86@redhat.com>
 <46524325-8e2a-9395-e0d0-7d559c753c67@nvidia.com>
Message-ID: <7a4acae5-b7f8-9312-8191-aece7270104f@nvidia.com>
Date:   Mon, 21 Jun 2021 19:11:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <46524325-8e2a-9395-e0d0-7d559c753c67@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f7590c-9d11-454b-a5af-08d934cf346b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4090803C222B0C58344D1A22DE0A9@DM6PR12MB4090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtqZqYdLRMeC7JPYSQCNMEVHax+7VQ5fbuLRzs1IdN9FuHIHcbKuOLNUPOr1NTvu+mRlmQon4LKwX8/kAYnH26MbEnh370aDV9T2dgCHwnlcR3dBLaAkFOFteuc7YjlIDZTRlk83VkeTFwEcUB5yDoYLxEdG4t1JuYKn2IRO5QM0DRdXRUQ8FTo2n9Tbpn0FM9DjEeAJy8EGT3fnKUHGmsNGv/cMIDjV5aHgEIFAaPIS1SH1oWxNOtfZ/M1uKO0yjEaLevrG02Hni0uy1xODVSi6kGOeRxrE2VxrsuEsn7PVa236DiF8KWMjvDD/HjCOIlL6yLE8EVrqqJtdOkEvUPnBMBHP3lxrNxeZTHvqzS3jA1vkkKdC9iha/+bUHxdl855fK+9O2/xZtpvazvuvPkpQW0m9qal2kKRTeyQTdOHlyj6IXqXvUOKUAFFaTuL2JTqNDEkEuNxPWkymkdEdxOd8UC4bAL7pX+1XEK1o6uPF5md5gEdoJotVU95EZxBY5RIWiZ9b38SoX8swCX9tueBs3ST/CbIjOQf3o/tM/bvo9UdgfHnpHWmEaWSvsB+LzfbvjV+vfs9BKP1vxlDHVmJOm4ojoaz9HV4PkszAXNFdz9KYcmEkoMMh338Nk2GpIeodF2mxOP2CuuDYmKN+a9U0yS8xuGwdNmlXCiht6xEwuq7kAP/8R3Bs+s+zq7yONEjYBPw5eQ7j45qtpJOEDJyBlb9ZdGfACTqbCF/6yYs8RIF1D6+/ZFZUv4tCfJgoGSMQsGcr2biiFUcr0GM4da0CC1YSXexUGP8Zvjd5hVhYHKNP2VjOo1EPDOdUSd8RAHYmQ7XXwBxtI4LuqWN1Ew==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(36840700001)(8676002)(426003)(47076005)(82310400003)(966005)(8936002)(31686004)(478600001)(53546011)(36756003)(26005)(16526019)(4326008)(356005)(7636003)(83380400001)(82740400003)(186003)(31696002)(16576012)(70206006)(316002)(6666004)(86362001)(110136005)(54906003)(70586007)(36906005)(2616005)(2906002)(336012)(36860700001)(5660300002)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:11:19.0861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f7590c-9d11-454b-a5af-08d934cf346b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi David,

do we have a conclusion for this series ?

Is the below suggestion accepted by the maintainers ?

I would like to send a new series before closing 5.14 merge window.

On 6/3/2021 1:52 PM, Max Gurtovoy wrote:
>
> On 6/2/2021 3:14 PM, David Hildenbrand wrote:
>> On 02.06.21 13:10, Max Gurtovoy wrote:
>>> Hotplugged memory has alignmet restrictions. E.g, it disallows all
>>> operations smaller than a sub-section and only allow operations smaller
>>> than a section for SPARSEMEM_VMEMMAP. Export the alignment restrictions
>>> for mhp users.
>>>
>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> ---
>>>   include/linux/memory_hotplug.h |  5 +++++
>>>   mm/memory_hotplug.c            | 33 +++++++++++++++++++--------------
>>>   2 files changed, 24 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/include/linux/memory_hotplug.h 
>>> b/include/linux/memory_hotplug.h
>>> index 28f32fd00fe9..c55a9049b11e 100644
>>> --- a/include/linux/memory_hotplug.h
>>> +++ b/include/linux/memory_hotplug.h
>>> @@ -76,6 +76,7 @@ struct mhp_params {
>>>     bool mhp_range_allowed(u64 start, u64 size, bool need_mapping);
>>>   struct range mhp_get_pluggable_range(bool need_mapping);
>>> +unsigned long mhp_get_min_align(void);
>>>     /*
>>>    * Zone resizing functions
>>> @@ -248,6 +249,10 @@ void mem_hotplug_done(void);
>>>       ___page;                \
>>>    })
>>>   +static inline unsigned long mhp_get_min_align(void)
>>> +{
>>> +    return 0;
>>> +}
>>>   static inline unsigned zone_span_seqbegin(struct zone *zone)
>>>   {
>>>       return 0;
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 9e86e9ee0a10..161bb6704a9b 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -270,24 +270,29 @@ void __init 
>>> register_page_bootmem_info_node(struct pglist_data *pgdat)
>>>   }
>>>   #endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
>>>   +/*
>>> + * Disallow all operations smaller than a sub-section and only
>>> + * allow operations smaller than a section for
>>> + * SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
>>> + * enforces a larger memory_block_size_bytes() granularity for
>>> + * memory that will be marked online, so this check should only
>>> + * fire for direct arch_{add,remove}_memory() users outside of
>>> + * add_memory_resource().
>>> + */
>>> +unsigned long mhp_get_min_align(void)
>>> +{
>>> +    if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
>>> +        return PAGES_PER_SUBSECTION;
>>> +    return PAGES_PER_SECTION;
>>> +}
>>> +EXPORT_SYMBOL_GPL(mhp_get_min_align);
>>
>> We have to main interfaces to "hotplug" memory:
>>
>> a) add_memory() and friends for System RAM, which have memory block 
>> alignment requirements.
>>
>> b) memremap_pages(), which has the alignemnt requirements you mention 
>> here.
>>
>> I feel like what you need would better be exposed in mm/memremap.c, 
>> for example, via "memremap_min_alignment" so it matches the 
>> "memremap_pages" semantics.
>>
>> And then, memremap_pages() is only available with CONFIG_ZONE_DEVICE, 
>> which depends on SPARSEMEM_VMEMMAP. So you'll always have 
>> PAGES_PER_SUBSECTION.
>>
>> I can already spot "memremap_compat_align", maybe you can reuse that 
>> or handle it accordingly in there?
>
> Yes I think that since subsection is aligned to PAGE_SIZE I can do:
>
> size_t pci_p2pdma_align_size(size_t size)
> {
>         unsigned long min_align;
>
>         min_align = memremap_compat_align();
>         if (!IS_ALIGNED(size, min_align))
>                 return ALIGN_DOWN(size, min_align);
>
>         return size;
> }
>
>
> thoughts ?
>
>>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
