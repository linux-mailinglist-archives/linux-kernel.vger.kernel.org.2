Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5E8336E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhCKIux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:50:53 -0500
Received: from mail-eopbgr770051.outbound.protection.outlook.com ([40.107.77.51]:44645
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231753AbhCKIuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:50:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEGMK4/5DizHRKIQpUSFx4yV29XbEFaxOfB7Rh0dMRFnixYFzPjcItIJD2kfq9/Snk+74HKuA9x4hGRtKT/Z0UpoIjvSUwrKMfjtqHbLtapoThYKZdwGbXriy2aiD/G1z7MOzLldms5N8FC45u0zEcW2ZAPM9QtiWgnyC1Yv8IxMLFRPtNVt6lg8qPBiN4yy/taYY5AfUlwiA6luwi4h2Mx+lK2k1zdr+I0PZo1E05HDnJap1dX6BiU6upExW0pa8OZFkbdCoIhYPCmpgi3sZIfNUDNO/6wb0lz24k1n0i+FD6mZL2VqyIZcPa8yW153e7PKTLJbsDph2h9HyP1IAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/XXndemTbsLL64WrW7GvUIaf6WgXrXg5O5lNJGtjdU=;
 b=MBvgtv44LMzpv7LRoJ6dL7CrqLTmeB8pljig++6Sg+amFEeN7wjp/WxmwzBaj0DSOdMyJrt7l1v5PK6ivLcJiamh6dlKaxJoRGbtK5/+YrXVYxIkrT+rWmzSU44itEVqja0//DhW1Xd9al5oSM8XsojDyjdgrUldGTBWEnz4AyKSUbJ8bbiZcArB7pv5xyXupEDRXi4UuMVcHWdFt8kzOEQUMbuuX3J//n9vQuKGYxtB1lGwTuiY/rWq+6iOIUXPd05htLgznKHDFZr5KV87w2neEJdKjRujei90SN+jYJHFW8nyJj9RRoBwQ+r98zQk2vddxuhHtl6uYl06xnJ3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/XXndemTbsLL64WrW7GvUIaf6WgXrXg5O5lNJGtjdU=;
 b=OdeITTb0GkSO9jNGSSa5sPI7aRE3U9cwv++wL165TRveKQ3JI2cVLo3XFuE/X4ulcWf+gfxGo46Vcqc4YO4yursf/bA+1l6+aC6K6e0J5wUnrb8sOPq/lLLpCa1menGhhEKHzb3XxbsjdFw2GuBSfuokPvKfNRlgT1ENGlYA78k=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3837.namprd12.prod.outlook.com (2603:10b6:208:166::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Thu, 11 Mar
 2021 08:50:20 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 08:50:20 +0000
Subject: Re: [PATCH v2 1/1] drm/amdkfd: fix build error with AMD_IOMMU_V2=m
To:     Felix Kuehling <felix.kuehling@amd.com>, arnd@kernel.org,
        alexander.deucher@amd.com
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de
References: <4c692eff-9d57-278e-8da4-36bc2c293506@amd.com>
 <20210309165018.26213-1-Felix.Kuehling@amd.com>
 <67f7c50a-cc5d-073c-b91b-8c9641e2aa8f@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bea068f5-dea9-db80-50aa-f65b6315a908@amd.com>
Date:   Thu, 11 Mar 2021 09:50:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <67f7c50a-cc5d-073c-b91b-8c9641e2aa8f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:e21c:b1e1:cff0:2c70]
X-ClientProxiedBy: AM9P193CA0004.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::9) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:e21c:b1e1:cff0:2c70] (2a02:908:1252:fb60:e21c:b1e1:cff0:2c70) by AM9P193CA0004.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 08:50:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7611fe70-f789-4a8f-f3e8-08d8e46ab2ea
X-MS-TrafficTypeDiagnostic: MN2PR12MB3837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3837880E21C85F9747DB32DC83909@MN2PR12MB3837.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvbGtCS4ZcK+Pv8TIYj6eBTlmVa2/K4qQy2LKyDWO6Cxk8kIqlZHGTuiaWhCwYLUToauj77CMSQOCwtFI8i7HvATbiRnLPtr/aUdkEHCuet49V3d1D6cTIS09fUMPhbHLW+eiSUCIVEkZ/vFgEiiJE+4Xmn7bdbpozdve3ARgbcIk8JbhKReRtgAlOThLiv8WesTTiuzJYG1lSs/K61WuJGkzB6B1clOpFGZreI2jt+UHcM5V0QFQMLKY61c3dZsdNsS01AqXYb+QW1OOj+xKsqGvyQ0Kbf2JTyPu6KHQrM5NXEFTxMLaBw7rGvfOYxMivAP4ZASGjnLU2zCrYS8SIoj/sj1bR9j48eZIs78Oxcn+U/wH68bpiN7VCOMepPPjznoP9eq7WdlX0AkNNODXDIi/nkPM8iQcp6zS2rPiDrQyiR5r5msd6EAO1fNDeMlqG7L8n1PJ/OfBmGiMhZ6o8Y6f95CffJhamgCmuhasZe17qq+ZUP3SnAR2kENjTP/+lXfdpbDU3GJuRkSC/E6llzfMwPiPtWEhUHfc6Ysv0IPVWFHZU5HfI/5CiZaZEsH2bvDPRaRmyv39JocflocckBzBBF4IyR3zm8Yflkki2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(4326008)(31686004)(2616005)(83380400001)(8936002)(6636002)(66574015)(66556008)(66476007)(316002)(16526019)(86362001)(8676002)(36756003)(52116002)(5660300002)(2906002)(31696002)(53546011)(186003)(478600001)(66946007)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NWs5RTFOZXBhNDJqTGcwZ0Nad0N2NlZLZE1OaERLZkErYy94M0E1ZGFkNFhR?=
 =?utf-8?B?a3VGYXZHSGFnS01qN2U0aWdxTTRLb2JTRkcvOEQwK3cyajRXSVdtRGNHbjZw?=
 =?utf-8?B?eUxGc0hGTzlwK05iWmhzeDN5WC8wRlZyM0pzZ1lKMWRuMkxFbHY4UVFFVjFm?=
 =?utf-8?B?UU5vQTRxUU1LNnlveHYvUVhURWgyTUhpb1BCSHN5eVNZenFGZ1FRL2pUaHAy?=
 =?utf-8?B?YVRDc1g5RnkxMnZ2M1dqK0NueHFrd3ZqSkNvTUJJRVJUcDlESVpiRFFjb051?=
 =?utf-8?B?a2NNdVJEQmxLSGhNaWhkditFNTBiRW9IenFKTDFoMEM4bTRhbEo5cTNnZUVS?=
 =?utf-8?B?bTlLRGdIdkJ0ei9UWktQbXkwaWlEUWRXdjVOTmI5OW0rSjdrODhOUXVMRlJi?=
 =?utf-8?B?enFBVEszNEQ2RDVMUHB6WStReE1OVyt6Y0ZxckpjOHZmbkM1SW9zeGxBMWZJ?=
 =?utf-8?B?eUdiam5zVlMvYmR2akI1ZGw2Mkc2SEtmMjhwcjlDM0RxbWFXeURCOTc4QU4v?=
 =?utf-8?B?bjZzU3dwbkN5QWJBQnJpZENrQ1pwNHRCL0VYdUZBTWhPUmtHK2FIUko0S0o1?=
 =?utf-8?B?bTFQOVFzRnZBT3VWbURIUk1FdkZRd3RlRzc0eHQwZkNQTXVaeUxvczd6QnR6?=
 =?utf-8?B?azdLWWhpNlhuWWp5SGV1S3JmM2J1bFBVZmVUZi8veWF6ZzdJRWh6N3NWOVBX?=
 =?utf-8?B?Yi9vY2ltcGczeW5EdVdKODhBd0V0VWkyQ3V0eXRVcnh4Y0ZLdjQ3Mk83MG1h?=
 =?utf-8?B?SVBlWkdyZytkbXMyZEduNTRPWWJ6UXJsY2JwMGxCNmd5YUYxdnRQWEJFWGVW?=
 =?utf-8?B?dXZnaThnaTBQa0tabmhDK3U1TTVWRXNYeHY2SWdQNU9TVFZNMkpDeDNzUlNj?=
 =?utf-8?B?TEJvNzdqQ01nRks1b3hKZnZOeVFZUmdKSTBSN2FtdDVwTURsTlp1TTJDRHhk?=
 =?utf-8?B?UEpWZitGamZiSEsyM3Q2dTJZSmQ3RERRNjYzcTUxUlVyRWpDVU9CUTFNbFgz?=
 =?utf-8?B?R1pGVE5VQzAyMGJ6b25CUlVqTzZONjdIZnZGSTI2LzNaK014bXhKcU16UmFh?=
 =?utf-8?B?YTdqYm1WVUM3WnVudzB4cGRUVUNmMXp5eU9YSStJTXlscnVtR0pxRDg5TDVq?=
 =?utf-8?B?cEZXNXpOUHRGdmt4VkxrZlRsZVpPenJQRFJOZ0t6dlNvOTRXOWt2ZmV5T1JZ?=
 =?utf-8?B?MFJNbENFLzRrNEhaUStNWUxJWE1FQkpxekxCaTRoNHFOSG1vb0UxdHZkbzhm?=
 =?utf-8?B?bUg5N2srdlZrbS8zMDNQNDNVRzJLOWFLQ3BYMGtWWVByUVpiNnhtREZOb0V5?=
 =?utf-8?B?cm9rSTc3WmptZDRBd1JvdnpMdEU0WG9GdWk4Tm1md2J0SEpKQ3d4bk8yc2NG?=
 =?utf-8?B?bWdXYTZmZWViRW12UTl6UTIrOGxXcjYvd3FCUUd3c2ZkNUxUTGhKRmphNWZD?=
 =?utf-8?B?ejRrTjZTUGVSQmNrclN3c1FUd2RxMnNsL1ZqZFFnYWNPM0FFa2RRYjNIN3J1?=
 =?utf-8?B?NUVoWlQxUGpjTmJtU1ovbFFwNDIwN0xFWHVTdHRIeGRzeG0xVEduZDRPSzRu?=
 =?utf-8?B?eGh1Y0NsR0Zya3dhK3lheUdtNDBPTlBjWCs2YVA0VFhrdjBXZ29KTHpWZCtV?=
 =?utf-8?B?a2ljOUVEQWNOR2xCczk2SnhJZXBHZHp5SXlEbVNMYmU2bi9NTXd5MGZiYjhK?=
 =?utf-8?B?d1g5RTNEdXpFTElNWlh1SEtJQzY5REtZUzg0Ly9OeXl1aEM2a3htK1JCN2dq?=
 =?utf-8?B?UEhoTDBQUlU3UENHSmZGZnQrRFk4MGVqMGxPT0pQK3NtaGxnYmVXZVpnRjY1?=
 =?utf-8?B?c3dJb0MvVU0xN2IwMHlyK29NaW1Ud1lrSSthMDBqcEViUjFvTUYvbnhRNjhn?=
 =?utf-8?Q?LWnkt+q+Tt9CW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7611fe70-f789-4a8f-f3e8-08d8e46ab2ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 08:50:20.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBQBk1EDC5jk63lMZfmh2Av1Rk7Xn0iyKSJvw7kkzDBq7OTzq5Aub/s5yV1UyiF9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3837
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.03.21 um 23:13 schrieb Felix Kuehling:
> On 2021-03-09 11:50 a.m., Felix Kuehling wrote:
>> Using 'imply AMD_IOMMU_V2' does not guarantee that the driver can link
>> against the exported functions. If the GPU driver is built-in but the
>> IOMMU driver is a loadable module, the kfd_iommu.c file is indeed
>> built but does not work:
>>
>> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function 
>> `kfd_iommu_bind_process_to_device':
>> kfd_iommu.c:(.text+0x516): undefined reference to `amd_iommu_bind_pasid'
>> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function 
>> `kfd_iommu_unbind_process':
>> kfd_iommu.c:(.text+0x691): undefined reference to 
>> `amd_iommu_unbind_pasid'
>> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function 
>> `kfd_iommu_suspend':
>> kfd_iommu.c:(.text+0x966): undefined reference to 
>> `amd_iommu_set_invalidate_ctx_cb'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0x97f): undefined reference to 
>> `amd_iommu_set_invalid_ppr_cb'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0x9a4): undefined reference to 
>> `amd_iommu_free_device'
>> x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function 
>> `kfd_iommu_resume':
>> kfd_iommu.c:(.text+0xa9a): undefined reference to 
>> `amd_iommu_init_device'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0xadc): undefined reference to 
>> `amd_iommu_set_invalidate_ctx_cb'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0xaff): undefined reference to 
>> `amd_iommu_set_invalid_ppr_cb'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0xc72): undefined reference to 
>> `amd_iommu_bind_pasid'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0xe08): undefined reference to 
>> `amd_iommu_set_invalidate_ctx_cb'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0xe26): undefined reference to 
>> `amd_iommu_set_invalid_ppr_cb'
>> x86_64-linux-ld: kfd_iommu.c:(.text+0xe42): undefined reference to 
>> `amd_iommu_free_device'
>>
>> Use IS_REACHABLE to only build IOMMU-V2 support if the amd_iommu symbols
>> are reachable by the amdkfd driver. Output a warning if they are not,
>> because that may not be what the user was expecting.
>>
>> Fixes: 64d1c3a43a6f ("drm/amdkfd: Centralize IOMMUv2 code and make it 
>> conditional")
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Ping. Can I get an R-b for this patch.

Reviewed-by: Christian König <christian.koenig@amd.com>

>
> Thanks,
>   Felix
>
>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_iommu.c | 6 ++++++
>>   drivers/gpu/drm/amd/amdkfd/kfd_iommu.h | 9 +++++++--
>>   2 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
>> index 66bbca61e3ef..9318936aa805 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
>> @@ -20,6 +20,10 @@
>>    * OTHER DEALINGS IN THE SOFTWARE.
>>    */
>>   +#include <linux/kconfig.h>
>> +
>> +#if IS_REACHABLE(CONFIG_AMD_IOMMU_V2)
>> +
>>   #include <linux/printk.h>
>>   #include <linux/device.h>
>>   #include <linux/slab.h>
>> @@ -355,3 +359,5 @@ int kfd_iommu_add_perf_counters(struct 
>> kfd_topology_device *kdev)
>>         return 0;
>>   }
>> +
>> +#endif
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
>> index dd23d9fdf6a8..afd420b01a0c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
>> @@ -23,7 +23,9 @@
>>   #ifndef __KFD_IOMMU_H__
>>   #define __KFD_IOMMU_H__
>>   -#if defined(CONFIG_AMD_IOMMU_V2_MODULE) || 
>> defined(CONFIG_AMD_IOMMU_V2)
>> +#include <linux/kconfig.h>
>> +
>> +#if IS_REACHABLE(CONFIG_AMD_IOMMU_V2)
>>     #define KFD_SUPPORT_IOMMU_V2
>>   @@ -46,6 +48,9 @@ static inline int kfd_iommu_check_device(struct 
>> kfd_dev *kfd)
>>   }
>>   static inline int kfd_iommu_device_init(struct kfd_dev *kfd)
>>   {
>> +#if IS_MODULE(CONFIG_AMD_IOMMU_V2)
>> +    WARN_ONCE(1, "iommu_v2 module is not usable by built-in KFD");
>> +#endif
>>       return 0;
>>   }
>>   @@ -73,6 +78,6 @@ static inline int 
>> kfd_iommu_add_perf_counters(struct kfd_topology_device *kdev)
>>       return 0;
>>   }
>>   -#endif /* defined(CONFIG_AMD_IOMMU_V2) */
>> +#endif /* IS_REACHABLE(CONFIG_AMD_IOMMU_V2) */
>>     #endif /* __KFD_IOMMU_H__ */

