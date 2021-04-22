Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A864368881
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 23:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbhDVVXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 17:23:55 -0400
Received: from mail-eopbgr700065.outbound.protection.outlook.com ([40.107.70.65]:54368
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237018AbhDVVXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 17:23:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+5sqia9RNvo3GIk4Zky3RgpZzTaLg9ID8FiI51iHgRAQL+srF9LYkH19Py3GZkfabXdXaIHz51+aEuMyrybOVkupBJl9iytdmUIfCcENr9rNWcAbQSIf6uH66GNO7zLnxR0gfho3xs/kYF125472V6J3A05QNB5TEQgG7/qDCCF8qzJrmd13p3Vck1yvk24Xy6vmspmkUqfvfvDf3MdFd6qMq3im69KSpR75J9lEXhJD/ygpixQ02i2SIZrJVz2DppS4nHPSB8uvLlx1F5u7MUIRiXKQet8V50TXzn3R1rxilFAGJedYFVCYkS3KNI0Byu/vY132DYOv/hVHQZ4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fStG6XAdMQ+94MrEf2AkzcZ6ywz7LC6+q/kOyy5FNzo=;
 b=gX45emxOMyb5qIZZ/z7ckIfygpxd6fNVrekbOeQARe6jNPtqcC9IkKB01TBlFkvUMaDkKBN5VVcgS6zmgCWGEXjrSjFsG9micVPW7tXOrjgvrQGZCcDjcPmeE5vAmLAETsx5wxYu6iyO+xQGXH3ZuLI/IbDOOR171SSY7WTSVS4VHoTaWLQ5j+F2Kh0WKVVabicRagSRCTA7vGHV3okZuRzPsxP82AwKAFk+H4y0eJXRfFCYQqezl0Mt6D1WbuKkzyOkjBvp8iUUfU7wjSWF3CSHpQSFLgg9Ih7UGG2y6XesEemKBvHKG9Sn7MoUrr6Adt8WCn/UpZAdm30Pmbu4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fStG6XAdMQ+94MrEf2AkzcZ6ywz7LC6+q/kOyy5FNzo=;
 b=YaSOZIABbmwU3SaaoWvqknIj4MN8fNfcf4R8xJo6sAPTXF9zewKaqFBpHbyKi1j8A7tR3pUS/cGnBX+SCzEe17cVKvOozeYfssm1B+AOq/cFXuboq9L7iMKJgobu/24xc5bt8IeyGh/MCUP3A0gJaHmfZmgCFPf0IwRbxKfEqXw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Thu, 22 Apr 2021 21:23:18 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 21:23:17 +0000
Subject: Re: [v2 1/1] x86/cpufeatures: Implement Predictive Store Forwarding
 control.
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>
Cc:     bsd@redhat.com
References: <20210422171013.50207-1-rsaripal@amd.com>
 <20210422171013.50207-2-rsaripal@amd.com>
 <ee949efc-018c-8b70-3224-da4f24b217b6@infradead.org>
 <6813af1c-6a59-47ca-ce40-939512092b09@amd.com>
 <6e755a24-1309-e75a-175c-196951f1167c@infradead.org>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <4511e1d1-9ca9-c434-9a3f-322e54ffbe73@amd.com>
Date:   Thu, 22 Apr 2021 16:23:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <6e755a24-1309-e75a-175c-196951f1167c@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN7PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:806:f2::6) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.241] (165.204.78.25) by SN7PR04CA0001.namprd04.prod.outlook.com (2603:10b6:806:f2::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 21:23:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56f238cf-25f0-4ef0-b65e-08d905d4d8a5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4186:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4186E746345B0C0BA7102DCC9B469@DM6PR12MB4186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pm82zOVeXfGzDfDFYYpT9kEM4oqxLte6cxwgYLC+06mjxhr3BiUnBWjp3Lc00DZ4TW8goJe6YOdBxJXMJk/ZNjbFYisJ/KIoncu5DnmsaoL7DP8S+67SQ+Puw80KRExLRlNDsW+hzVF3awGDgA82INpHgx6Nqskx1HmukZR39LRyhcPE2oqlygkobf+PbD1G5S92egIXiDHbILscsgRBPAVfVHvXxYcBz5UHXuTbIqAZpU+z78QyCU2ot23xRRwktoAsbq6L2tMmpXFGmrEzMML8vKZIh2ABKMhmM4ibXSjDSJHpOAVWRMr1d6yXEdSBihWgdgfyWiyXXVpBX2lT6JwVZes8Vr7wEP5+qXHwYHuddNJZtRsztqtc7txPymWxJUMh3DfdY12pLhQ6oK0fiW3oRdHIHfVPMV5lioU5kZUPrV/JDLEpwCBfM9spOsM6wBDVFmQ1LBLgI6g1WgeVLIXLeGAumsXmeLYPOueOJeGJgKVytGfMoiAzQ96NW4DiZlaQxqJZqFbY/G+e8XcoH1vmpnZ21Jd5I9+4LOGg1oDYyCeT3MZFCz4DC5Ihk0uWjXd75v/oea+01LdRYnlav5eh54DBb0GPoP6Q325SqfTTDpPgpzwrrp3u/aP1ZN/If+V5IhhDLYLR5NAT0heXSv7iHtP8p9J7j/u8ih3Vu7owiRMyT1NCMJcEiuhSDoLp8Ri8rSXzMzyMuxmBeXTKKJrIdII21drJp1vXkM9nKsPMxCXoycNVzsdDKOZiNLHeF7RSu2FNKhs3rklaIlBHrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(186003)(2616005)(956004)(316002)(26005)(5660300002)(31696002)(66556008)(36756003)(31686004)(66476007)(2906002)(6486002)(45080400002)(966005)(38100700002)(16526019)(53546011)(16576012)(83380400001)(66946007)(8676002)(4326008)(8936002)(110136005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZG5tQmJiejFqa3FoYzYwMHhxWEVWY21MQ0pwWnpwWkhqTk5LaXFncVJXTjd1?=
 =?utf-8?B?anNwaHVUa0ZORGMxZTlOcitjYjU2TWJMNllVUVE3UmpiQjErVXE2WCt5STNT?=
 =?utf-8?B?M0tJQXpzK01EdjFRSkZqTEJnd1ZZdkxVMWZqek56M2tPMjJ4Qjl4VlUzdGt1?=
 =?utf-8?B?VmR1M3NFU3lsVmJnVG9UdUh3S2xWNlNjdGc0Z21HWEN2UG1mQ2wwdk51MVVE?=
 =?utf-8?B?Wm1tYWpLWk5BUlFscUtMa2RyRS9iTUtCUDdHb2pYRnR4by9QSEpKWXQ3Ymgr?=
 =?utf-8?B?aHdlMmhjNkt2TTV5bmgvRW8ycTNVRzJQOG5QWkJrUlptMnFZeGYxdE9VVDNY?=
 =?utf-8?B?Qmt3em9BVVhlQUR3bUVEU3JIZHFUd1o5elBSVFljejhSaWgyV28rU0JRNTV1?=
 =?utf-8?B?bldxNXFDUUpXOGdSbjN6aWY0eG9rdXM1WXcyeC82NWNvbHlwWGR6NyswbG9x?=
 =?utf-8?B?UTNzVUg2TmM2b3VqMDRpSW9wVzFkU3F2dVFJZXBTU3dZamJlN3RqVDdBdjZu?=
 =?utf-8?B?QnpJR2locXlNRWJsRWY0d2c4SHZ5ejBzeXZycHhxQmFORmgzREtqRWpURVI3?=
 =?utf-8?B?bXE3cWZSeDBlRWJBL3RmcW9yRXBndWQvYUlBaXQ0VjdwbGVkRnV0QUVaZXBr?=
 =?utf-8?B?VU1yWGd3eHdvY2tFSDd3ZnBQSGJmTUtldld6VFlPN2RYRDFGNzc4aHlQMnJR?=
 =?utf-8?B?dGp0TkduSzVHclVJVjExTXZOWGhUcjVPREtCU2NZSE5RLzd3OHNaKzJIYzRC?=
 =?utf-8?B?ckNWOTFqSlg3WjZPdGl3WjRaTVN3MUt3OTFYejRJNkJrYWV3T3Vpck1Cc29S?=
 =?utf-8?B?TDlnT2N3N25JOTRFRnZFTStIYUlFMFFYdE0vbk9CcDlUaExZZUJDbWphRFBj?=
 =?utf-8?B?SEVBVjA5aGhGcmxoTU9nTFZTL3dFaXB6dWg2OWRTWm84TFpuUUdLbzdjYmIy?=
 =?utf-8?B?M3Y4WkJwR2N6T3FMRE9tRmZ5aWlFUjdnQ2FVSkNOWERJN1h0Uk5vRU5Ma1pH?=
 =?utf-8?B?Y3N5WFRwUE82bkFIOG5OTWxXN2JSZXZQcTFacVhyUk5jamg3TFNBeWlSRis3?=
 =?utf-8?B?c21xazdZZkhRMy85aU40UnN0RUdxMThHRXVESjNoSXNMeGlZU3oxZ2Rpa1NN?=
 =?utf-8?B?YVBzcFpPL0RXRitXK1kxWklVZnpRSHF4RDE0Q2h4OTEzdjVQdEJhMFd0MFVu?=
 =?utf-8?B?R1BGbVFSVXhGbFM3U2pmamljbUxoNWp0NXVjVjN2ZlRRcmtvcnNHYWExakFI?=
 =?utf-8?B?ZGdrSHNXdFk0U2s5ZGwzY2R2ZUJBWWJ5dUd2d0JCeXB0VTVXVk93QysvNUJO?=
 =?utf-8?B?TmNnbHcvRTgyNWlveDRUbVVkVnNIVXBXRnlHZXBIeGpqOW51MDRnWGNlejNn?=
 =?utf-8?B?L1RmbkR2M0tucWpwaEk0MDVnVFl5eXZNZXhDakx3aURXVnFEU1pxNzg4M3E2?=
 =?utf-8?B?RHpudXkzV1h0ZlZ3dkJUdURPazRUS3ByNHpEVTV2aTROaWpNZDkyNExzdjdD?=
 =?utf-8?B?ZVhVOGVnVFhyZGRpNWY2TGNYcnhUanFFMW5vbUFCVHI2VHVFQkpCM0pBWmdF?=
 =?utf-8?B?dkRhTUdNT0VsMDh2ZDk5MSt4L3FobFVMc2J6Njd4OVh0N0FXMHBlRWVLTW1h?=
 =?utf-8?B?N3dNUFdBSk1RZWlvRkZJai9LSEJ5ZFdTOFkwVElVRGErQWpHUmZEOE82YkhR?=
 =?utf-8?B?QnpiZHVFWTJ3TkR5dGtMRnpIZkM2MERLWXkrVzhwSUZPTXRxc3c4cjNFVld0?=
 =?utf-8?Q?KJsOxJUN4Bq5pZWEMTq/z6X50PmKD7EcGokCrBX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f238cf-25f0-4ef0-b65e-08d905d4d8a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 21:23:17.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNmPH+60mE5iCorWsPHXW9IPsSEgjeFezlbBHDwhYjuP8FAYA5OfaXTi+ewui//O7BF2HrcTZWzAf621DPARfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/2021 3:46 PM, Randy Dunlap wrote:
> On 4/22/21 12:32 PM, Saripalli, RK wrote:
>>
>>
>> On 4/22/2021 12:49 PM, Randy Dunlap wrote:
>>> On 4/22/21 10:10 AM, Ramakrishna Saripalli wrote:
>>>> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
>>>>
>>>> ====================
>>>> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
>>>> ---
>>>>  .../admin-guide/kernel-parameters.txt         |  5 +++++
>>>>  arch/x86/include/asm/cpufeatures.h            |  1 +
>>>>  arch/x86/include/asm/msr-index.h              |  2 ++
>>>>  arch/x86/kernel/cpu/amd.c                     | 19 +++++++++++++++++++
>>>>  4 files changed, 27 insertions(+)
>>>
>>> as from v1:
>>
>> Randy, could you clarify your comments please?. Is there something here I need to change/clarify/fix?
>>
> 
> Only that I had made these same comments (below)
> in v1 of the patch.

Yes I see them. I missed them. I will include them in the next patch release (batch them with other changes)
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F4c688fc7-67df-3187-54b2-bf20e510fb39%40infradead.org%2F&amp;data=04%7C01%7Crk.saripalli%40amd.com%7Cfd08fbf7545d4c27c4cd08d905cfde95%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637547212629713144%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=hlGLgbZobkqXf3aBdMhSFC6Lg8nBLg1ssjHJDoyzI9s%3D&amp;reserved=0
> 
>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index 04545725f187..58f6bd02385b 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -3940,6 +3940,11 @@
>>>>  			Format: {"off"}
>>>>  			Disable Hardware Transactional Memory
>>>>  
>>>> +	predict_store_fwd	[X86] This option controls PSF mitigation
>>>
>>> 	predict_store_fwd=	...
>>>
>>
>> OK
>>
>>>> +			off - Turns on PSF mitigation.
>>>> +			on  - Turns off PSF mitigation.
>>>> +			default : on.
>>>
>>> 			default: on.
>>>
>>
>> OK
>>
>>>> +
>>>>  	preempt=	[KNL]
>>>>  			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
>>>>  			none - Limited to cond_resched() calls
> 

thanks,
RK
