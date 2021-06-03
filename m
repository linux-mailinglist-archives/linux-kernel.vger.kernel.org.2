Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D399399F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCKyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:54:53 -0400
Received: from mail-dm6nam11on2056.outbound.protection.outlook.com ([40.107.223.56]:21372
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229885AbhFCKyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:54:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc/6m8yQEL/Dw14ziIzJNGVsxzCKLmYgcU+GKa+3c/A/9FwnKt94xNuXhLUDTsIROcA4LNcH4PO6gSMEe12vyVorbD2GHS7xwxeMpc8xTOAoQlA1NXg/o9yaEuh0+6yvxbHe1G9WK1kcC1IECWx4R5SyS1/Jjb3WeM71W1YKCd+3UFhXOw0HR4eIXHChJXAx671Owfay6nLUDRyz0WUOiEpMisHTZP+E6GtCgR8N3CUbMsa6L2w3ULOQQdZ4I/+K3O5bxS7Lbko1IA5Zgi76uRLlB49cMRwf7EMtlDRfb89X4vvepUcBxdP6aFOI8Hfw667KuD0+J0THO/eODnm/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifcF+1oKwZHIn+s3rLQCg4Qe6LYnZYYMgf1eTUfJeAY=;
 b=AuyM5r5Y5EkcG5AymY8UenPayrLi/svrQN0fkATXKC4CiHQoCQZej5Ee9zc7Db5gF02/ZgzFrawCsXU+1L1TEgyGqGwnSbr2LRcX+lzHFhPtxIiylJqXtnHVfMlR1rElL57VZhYnqYV8Yl/NOQr77pjSBHm5fc9+d3cKUhaBHBQcOA3X3FdEufyJqfzR0iTgP82VQ8nCBan/ksqMXtlLKl4476OpxT0LEKVooU5XHbnu3a9RUv+UNeesQgej0sgx4c9rzUpImK2JnNhTBYL5fBlBkn+cppetDMytHNxzKiF8A2bOOoWh1pmIW3U0VqD7AmFreKFXErngN9JeP769eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifcF+1oKwZHIn+s3rLQCg4Qe6LYnZYYMgf1eTUfJeAY=;
 b=Mk3s+ROq/q3SDC5uL240OW0kVtlO6+wieKKyWcPqom/Ei0kwDYe3wB/184wb2kJO4ShxqNyhMnIpimQmaXsh1TlQ1lcQeujIs5gjibZdUMeS2gaBzqqTX0fOjPiZ97v4CvGVXF5XcNeRhlQzSiU5MUAZ1nVwLPR8hAoj9C9bo8eheMM+3ETCLV7jyazWnGHqpr1fD2Tv2BEgfHSvjmKR/ggI40iA99z4MSEOfIaia174UAofJKKSBmOTtua/3FU+Q7MhpWaXaPNPKOCNSOBc9oLQE6vcAvU0wFejRXh5iI6OTxmk+RBfxk7q1lzR+8xWy+xWlEar1R3j2wxrXl/2uQ==
Received: from BN6PR19CA0116.namprd19.prod.outlook.com (2603:10b6:404:a0::30)
 by BN8PR12MB3635.namprd12.prod.outlook.com (2603:10b6:408:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 3 Jun
 2021 10:53:06 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::41) by BN6PR19CA0116.outlook.office365.com
 (2603:10b6:404:a0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Thu, 3 Jun 2021 10:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 10:53:06 +0000
Received: from [172.27.14.209] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Jun
 2021 10:53:02 +0000
Subject: Re: [PATCH 1/3] mm,memory_hotplug: export mhp min alignment
To:     David Hildenbrand <david@redhat.com>,
        <linux-nvme@lists.infradead.org>, <dan.j.williams@intel.com>,
        <logang@deltatee.com>, <linux-mm@kvack.org>, <hch@lst.de>
CC:     <sagi@grimberg.me>, <oren@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
 <20210602111055.10480-2-mgurtovoy@nvidia.com>
 <283740c3-db3f-3c9a-2954-f1c037a13e86@redhat.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <46524325-8e2a-9395-e0d0-7d559c753c67@nvidia.com>
Date:   Thu, 3 Jun 2021 13:52:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <283740c3-db3f-3c9a-2954-f1c037a13e86@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40e2e3b1-5947-4d61-9c9f-08d9267dc4d4
X-MS-TrafficTypeDiagnostic: BN8PR12MB3635:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3635135CE9F54B099BDE9839DE3C9@BN8PR12MB3635.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4FHQMuVvrnlje7lTo+7yUC+h9/v6NiiEJjTzsEBflaRv1uAOCmzTGWO8orInBmv4xu0K8p/iyohC3mftiaoQaaxKyr4c1GzdZ1acWHIpO4oG+B6BNK//qkwLKMciFTdpFPTWSoeiQ2xH/GN2lx1gAy56iLl0NVnbkw+Dj4NjYqKYuO5QhPQJswxS/FMjcRY7rSBaMF1ICLO34E/bnH9GllsG5ZZLsCEoXWjGg6SJgXEqkxSKMhiVecijoAMzGp3P7W+ID4u95CT1HX6iCreL2EDRZWrIVrQxYC57z4tp+njzAs246eSl3onbpxwr2ipYqmReHL6o6GsxhubIIYskGk80NqjJQbZoXSTgB8Wu1XZbmbb0aDgNMX+n6po2p+cySVb1G5zSeR1cR70utEM0yf0/EUDUT15A5i3tUAEdpe21680cc/mVL1TkLorDi1ZOaBn4UF6KO+m6rE9ve5iNxvmrfJak7CYxD7EJhwCBXWbiEsrIWaIYIBoEUI/iPnQ0WvAtdxerwrFZ3Q4GGtH2kWMnmbdMN2Aso4KE8g1yBYLFPuabraqhzfNBljR/wLrGrdvNMmGl2f38lvRe8D/0Xjhzso4CM3Ei83R6Al8Vq+fcgMeHgFNpRy/q4gyx6iRyl3fzcMmPzeIiV3GRESvpnrj99uf8Ux9MwzsGEGUBTGYUCzxg8tTkf4zSKl8EwffIwq/Yqz5EkTlc4jb2dc6MQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(82310400003)(426003)(53546011)(5660300002)(316002)(4326008)(36906005)(31696002)(82740400003)(47076005)(16576012)(36756003)(7636003)(356005)(110136005)(2616005)(8936002)(70586007)(478600001)(31686004)(336012)(70206006)(16526019)(2906002)(8676002)(6666004)(26005)(36860700001)(186003)(54906003)(86362001)(83380400001)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 10:53:06.2670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e2e3b1-5947-4d61-9c9f-08d9267dc4d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3635
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/2021 3:14 PM, David Hildenbrand wrote:
> On 02.06.21 13:10, Max Gurtovoy wrote:
>> Hotplugged memory has alignmet restrictions. E.g, it disallows all
>> operations smaller than a sub-section and only allow operations smaller
>> than a section for SPARSEMEM_VMEMMAP. Export the alignment restrictions
>> for mhp users.
>>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   include/linux/memory_hotplug.h |  5 +++++
>>   mm/memory_hotplug.c            | 33 +++++++++++++++++++--------------
>>   2 files changed, 24 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/memory_hotplug.h 
>> b/include/linux/memory_hotplug.h
>> index 28f32fd00fe9..c55a9049b11e 100644
>> --- a/include/linux/memory_hotplug.h
>> +++ b/include/linux/memory_hotplug.h
>> @@ -76,6 +76,7 @@ struct mhp_params {
>>     bool mhp_range_allowed(u64 start, u64 size, bool need_mapping);
>>   struct range mhp_get_pluggable_range(bool need_mapping);
>> +unsigned long mhp_get_min_align(void);
>>     /*
>>    * Zone resizing functions
>> @@ -248,6 +249,10 @@ void mem_hotplug_done(void);
>>       ___page;                \
>>    })
>>   +static inline unsigned long mhp_get_min_align(void)
>> +{
>> +    return 0;
>> +}
>>   static inline unsigned zone_span_seqbegin(struct zone *zone)
>>   {
>>       return 0;
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 9e86e9ee0a10..161bb6704a9b 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -270,24 +270,29 @@ void __init 
>> register_page_bootmem_info_node(struct pglist_data *pgdat)
>>   }
>>   #endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
>>   +/*
>> + * Disallow all operations smaller than a sub-section and only
>> + * allow operations smaller than a section for
>> + * SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
>> + * enforces a larger memory_block_size_bytes() granularity for
>> + * memory that will be marked online, so this check should only
>> + * fire for direct arch_{add,remove}_memory() users outside of
>> + * add_memory_resource().
>> + */
>> +unsigned long mhp_get_min_align(void)
>> +{
>> +    if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
>> +        return PAGES_PER_SUBSECTION;
>> +    return PAGES_PER_SECTION;
>> +}
>> +EXPORT_SYMBOL_GPL(mhp_get_min_align);
>
> We have to main interfaces to "hotplug" memory:
>
> a) add_memory() and friends for System RAM, which have memory block 
> alignment requirements.
>
> b) memremap_pages(), which has the alignemnt requirements you mention 
> here.
>
> I feel like what you need would better be exposed in mm/memremap.c, 
> for example, via "memremap_min_alignment" so it matches the 
> "memremap_pages" semantics.
>
> And then, memremap_pages() is only available with CONFIG_ZONE_DEVICE, 
> which depends on SPARSEMEM_VMEMMAP. So you'll always have 
> PAGES_PER_SUBSECTION.
>
> I can already spot "memremap_compat_align", maybe you can reuse that 
> or handle it accordingly in there?

Yes I think that since subsection is aligned to PAGE_SIZE I can do:

size_t pci_p2pdma_align_size(size_t size)
{
         unsigned long min_align;

         min_align = memremap_compat_align();
         if (!IS_ALIGNED(size, min_align))
                 return ALIGN_DOWN(size, min_align);

         return size;
}


thoughts ?

>
