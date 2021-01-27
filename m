Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157023066C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbhA0Vva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:51:30 -0500
Received: from mail-bn7nam10on2079.outbound.protection.outlook.com ([40.107.92.79]:25824
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234951AbhA0VvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:51:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgtP/tF4s4xxNjv7RFDisbFXHUvdDn56s9oU2extczQ8OhtK7pR4ECJB3Xj0oL7Fj0cTVNq2xwQZFG1916dP+gO8rN8El3BH5hZXTZvHhVZ2feQloOD/UJOZbEmo1byWsXbnho/A6U5yoHik7SdeFZNBae2CC8XcDxeWw3nPPAVsNE91c+jj89OmskmjvPFkFa9sbhcxx5e3AYsr5xF/xUWPZjsT2CnAva6mz9IN7dnjvSmeuOwORV1gb2TDb00CmZdLvE+JUfWxV6NNCrFaL58F9ttEk2feJ3cnvKIMOyoxsvYaZf6RfaS4oFVzK8FKt9qqFG6jdwqcpOuQI1K/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phummsQVpQoLfdupR+43JoKzuSKiL1GByqw0/cKucxY=;
 b=LvKfJyXv8Rc5LmKkBe15nBiggXeNI19hj7T7wLJkTBwIsYym1LPvWk1zCAoxNpCZWcXCJ8YCj6wHit8ZOInOfdFC58g2alHx5VfBgC+WHiaymCVmJC/hdEEpN2hOGSofOSGjO9+VUtEo7/qIfqYaL7reoyLPsbWeXRvcyVpMsfzhIbdq8k4XO8UeCanmCNhfLQbhtrQ7VcrL6yZM1Upmwqzoh7SqXApLi7Xo6qnvCrci9En2Sr+T9d6EHi9K7WALd+MJ8DPe3aKjVNf9Uitfa0g2BA1picNawnfp9ll9y+QdMhY0StdWOyHZN0254swmiGj6PAwKjMfP+DX8BQz01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phummsQVpQoLfdupR+43JoKzuSKiL1GByqw0/cKucxY=;
 b=0Kj1C4STcKdu1riDvg/lK95H4KpatkrvXH9OlW9ecfJHHbhF9rUIGNV4HmizNk94pQM9lreGYV2ja3NanN9HqCKkwQ5r8wapQi9ZFWhlT1Mlc1nuerUWylH1wKxzIaiYcLhhkRlZ++4qtcENyLkiXKbRG8/Vze0Qr7yqY9KGeXU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:3f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 27 Jan
 2021 21:50:09 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 21:50:09 +0000
Subject: Re: [PATCH] drm/amdkfd: dqm fence memory corruption
To:     Qu Huang <jinsdb@126.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1611750806-10730-1-git-send-email-jinsdb@126.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <4de809ac-fdd7-b02a-c55f-3c79321cfb7f@amd.com>
Date:   Wed, 27 Jan 2021 16:50:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1611750806-10730-1-git-send-email-jinsdb@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Wed, 27 Jan 2021 21:50:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5dfa1c2f-a72c-46f6-1f02-08d8c30d842e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2355787346AA623A25ECF14492BB9@BL0PR12MB2355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbENbqAy+oYfjNXwbiu46mMCgmV+iuizXX/QKhylUEZpgKRCJl2fDwLpmV40DF6QCUj0sDR2cS5PLNtHbrqLwPgbZAwlmMv3xDR20T0yacxU+K9nMzvlp9fHj1o+SCkNEsmyrxIEES0rGVob9vPVdAVlK5r3yX0eDI8Bs8z3vfmD821JVEYmSK6CJqdGzDqLoGuDzpIJ8LG7W7DMsRe4EbdzfpbYq3OJhP0/yqSoJ7NbbwBHykGoqUZZxq8uiFzKtU4iHOy36SpmwVHJFHC/opi2erxng+woVe9LZ7yndtSUdwlcwMsEILxZc6YuCYKZHytuW1qzxB1A14m81EJ2oVRk/otBLSTI7cFblY6gpnoCZuleyXSNRz7stDu3S8iNuR4e9qD9ufZSU/LcsEnJSesH56bVSzpMD2xH2vxu7Qzg54bMcKpFDv/XvmdsiQM3uRbrxrT4r44DmhpGYRCjgJKjFo8THYm2rgNCZ54sAbtRyNztluQZneVQnvxe4GHdN0E4+s/VLX2g1dVlM47wg+hkJjMT0L3jMVRufJgp01lvdg9sb1w1WCHNGmumn3tpiu5OXQ+3qpLofUsjuQAJbyeW4jmKJczsVuQjbbFpuaQuSLmiCP1e8LLcPZ8voJPkEdbytnUWD+RZ75UGWPR9ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(83380400001)(16526019)(186003)(8936002)(316002)(26005)(6486002)(16576012)(44832011)(478600001)(4326008)(6916009)(8676002)(86362001)(66556008)(66476007)(52116002)(2616005)(31686004)(66946007)(36756003)(956004)(31696002)(2906002)(5660300002)(525324002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VVdIcm9UaXFhWHdDZ3pRS01UaWhVUUJNVXdtR2NlcGxnS3pTM0U5Y25hb0d5?=
 =?utf-8?B?ZXh4UmlSQ0hBNzZCb05ERmx5bzJ1R25BemcxcGtPVTUvSFhGd1JnZU9EdWJo?=
 =?utf-8?B?VUxxUzJXeUd0VW9vRzY0YUpMLy8wSU5LSitZa3JOVU56MGtxN3BXNWFhTkRk?=
 =?utf-8?B?TCtzRkRtclNJWW1ueFl4M2JnZzR4eTA2MFBTT1hqQ2NhSzk5TkFJWFVxejZC?=
 =?utf-8?B?dUJ0U3picEx4amkwWlROcGVuOCtDaGl3WHRVVWxKK2JkcnRlNEVndmREUnZi?=
 =?utf-8?B?dFZIOXZobklNSVYrL04rUXFEQVh4eHgwakQwTEpDT1YxM0hpNTdLQTdvMUho?=
 =?utf-8?B?aTgvR0VsUXY0YzNVTjdvUmNVTTV4N3pUYkREcldZRDZvRUJZSVF2Z2VkNS82?=
 =?utf-8?B?eUltbFFNUGlDSUsya1Rpek9wTnBodzEyNEtrZk10ZkZtNDk2OUJISit5Y3RM?=
 =?utf-8?B?RmozcjZGVlF4NjJ2R2N3SWhmU21NMHp3RlgwM1ZwZ0NPcUdUekpJeU8xSXRI?=
 =?utf-8?B?WXkzVUt2QjBCTHVkT2ZvcTgzVm9CbXNOWVdaZFRGdlFkdVhrQVFObFlTZnh5?=
 =?utf-8?B?MEJqSUtWQmY3Slc0MExCMzBnWVNLYnVzcHVMZXVpUHB6TEhvemYzcE95cWZp?=
 =?utf-8?B?MVZadzVhK1orS2luTitSNXdGMzAzRkNITHYwbUUrWWF3Si8xcWFzR2hDYldS?=
 =?utf-8?B?RWVMNnlMQU9RdnBiV0tTLzdmSElGc1hENG9HckJqTDI1dHphU0gzaTJreWhz?=
 =?utf-8?B?M0xvOFF1MURLVWJVSTYwV3pocFpNbUdHaE9mSU53cFQ1RjhTamVPekFoa3Z4?=
 =?utf-8?B?Yk5aMHJSZEVUNThtR04zcStIUzFHQmtNbTVaejVmWFVScnRpYkdaTWhPdDFL?=
 =?utf-8?B?NVJ6ekdVbVpMZyt6TnFGL1pEUjBNaHFrREdYbTVvSVRmRTR5Y3ptZU4vUXk3?=
 =?utf-8?B?cWZxMWdWOHgzc3p3UGlGVktHWnh4RDVIU20zRlNTZ1ZXUnBuM0hsSlFYbFNI?=
 =?utf-8?B?eWYwVFcvQWNLNGhvTktITm1wMUhmZWVncDA2UlFpU21HSXo1RUpBTzN5SWt3?=
 =?utf-8?B?Rk1KYVo4V2d3QUdDaGdrQlpmMCtmL1F6RnpiSkNmZW9qN3ZZM3JEM1E0Z3FL?=
 =?utf-8?B?YlJ2OEVZek1LYml5dkhNcHRpT0U3elZ5enptcm5TOVpGa0xDUERRTkRQR1l0?=
 =?utf-8?B?VEVtSVBObi9teFFJWENKODFidm50YzA4N21RVGRTZG0xZmdGNlBiRGFHc0JC?=
 =?utf-8?B?b1piWHh4bmhDMlhCNGpVeEVBMWJ6N1RmT3I5KzJFbFNZb2dkcUhiYmFQWjdm?=
 =?utf-8?B?ZTdIdjBHVXlRd3JObStCaklFQ3VFTmNHUUU4OVpUMlFpOTFvajNUM2hZTWdL?=
 =?utf-8?B?UU1jMGF6UFhscFN4Qi9NSUc2UGhGdXZRUUZJNUdDZ3BVT0trSGNreko5UVFm?=
 =?utf-8?B?WHhKUHY0dHhNNVlMRUo3L2N6c2tCMTdoeHFoMTRBPT0=?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfa1c2f-a72c-46f6-1f02-08d8c30d842e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 21:50:09.3626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3WVE+fSN6JU5dFi3WgoDQSdkYoMnm1FinimAnGQEy9A1Z4QADDEcRsvdewf949iMUeu1iPd0vhsfx45drDjoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-01-27 um 7:33 a.m. schrieb Qu Huang:
> Amdgpu driver uses 4-byte data type as DQM fence memory,
> and transmits GPU address of fence memory to microcode
> through query status PM4 message. However, query status
> PM4 message definition and microcode processing are all
> processed according to 8 bytes. Fence memory only allocates
> 4 bytes of memory, but microcode does write 8 bytes of memory,
> so there is a memory corruption.

Thank you for pointing out that discrepancy. That's a good catch!

I'd prefer to fix this properly by making dqm->fence_addr a u64 pointer.
We should probably also fix up the query_status and
amdkfd_fence_wait_timeout function interfaces to use a 64 bit fence
values everywhere to be consistent.

Regards,
  Felix


>
> Signed-off-by: Qu Huang <jinsdb@126.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e686ce2..8b38d0c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1161,7 +1161,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
>  	pr_debug("Allocating fence memory\n");
>  
>  	/* allocate fence memory on the gart */
> -	retval = kfd_gtt_sa_allocate(dqm->dev, sizeof(*dqm->fence_addr),
> +	retval = kfd_gtt_sa_allocate(dqm->dev, sizeof(uint64_t),
>  					&dqm->fence_mem);
>  
>  	if (retval)
