Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860803F3424
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhHTS7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:59:00 -0400
Received: from mail-sn1anam02on2077.outbound.protection.outlook.com ([40.107.96.77]:58462
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229512AbhHTS6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:58:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHcqNsWxHB53SRDLY57et1Rirva+OuW3VlAsVuEet+4rQeNDbvg+aTG5tuCbGWgh84z6TNfhwFvngRhgYP2ZJUcHMqF5LyH6xDvnqDczSDLY8U77x+6CLU2xcxW9yhv2vToydb8HpLVhu7F34BHqJTEzULggM5F1Ijs5EkPauOs/HrtEQpgGmQg7gpe+iFbAKBraq8QfV6QMaAtHR6gZzTNueMV10HCDXO4MuEVXK2VN0Vyrh1cFW3jKsswT7yUY43rZ4VaJuwT/punt/CZ1KthVe5YYwtXxMTWcgfiG5aC53AzUEDJvzTWetwM1NQVoFpA5tMf+mVV802epwUy5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqTQRgpE6LwVmL98UUNywjoqeA7xiRRZ2PPVNcSzDwc=;
 b=kC9/YELrTxOACi5SB1QZFPJ8/p6BZ/3Q6h0WTJ1rKrhi2xPC+ANDFr6D1u4BeVbbwswqT3PiksVV014sSxRijMzoRANTKMzVPp2W+amzzE9kfFz30e1w0Eg5Ka2xwGhm8cH4iBnfpdTsn3aoaK59IdWO4rT+eUj3s4Ju/Cfe2NdS0OdnKmfgUGi7jueCPKSa2LQECr/BxA8VOMvqxviZ6aCaoziFu24ue898CYJPo9c8bxkBS94bHn30aIa/5LNFbDr6UB4T9qRLxoXRitahtawZM8hDaq8j9v/0TCDyvTRAEuR0WkiT3nEn7BrXoPFuXuuT29AGRd9TA5IIpYHRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqTQRgpE6LwVmL98UUNywjoqeA7xiRRZ2PPVNcSzDwc=;
 b=crxqcCqyPAQY41N25zFwcFlCDe+EaB0Wwzweje/sPMtTPUpqKy2/9+Q8QG5hAliRHeRyEviUDarSHhpzn5VPN+vF4yAVa6m24HfZfjqv8JykLpo98FqntUUZoRPN7S1NOdl2SmEYLh7mh0wwgzfx8fc65fgnDbvNAgwpnt6oXZY=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR12MB1502.namprd12.prod.outlook.com (2603:10b6:301:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Fri, 20 Aug
 2021 18:58:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3987:37e5:4db7:944e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3987:37e5:4db7:944e%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 18:58:05 +0000
Subject: Re: [PATCH] x86/resctrl: Fix 'uninitialized symbol' build warning
To:     Wei Huang <wei.huang2@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, Terry.Bowman@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        reinette.chatre@intel.com
References: <162947718839.12313.2592762168334394449.stgit@bmoger-ubuntu>
 <d0450e83-8e31-611f-5224-12742764e4d0@amd.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <1c81318c-c5d5-241a-ed32-bf6ba3ec56d4@amd.com>
Date:   Fri, 20 Aug 2021 13:58:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <d0450e83-8e31-611f-5224-12742764e4d0@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.0] (165.204.77.1) by SN6PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:805:106::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.1 via Frontend Transport; Fri, 20 Aug 2021 18:58:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c14ba037-3f08-418e-de65-08d9640c7176
X-MS-TrafficTypeDiagnostic: MWHPR12MB1502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB150229DB1EEA2B769F0940F295C19@MWHPR12MB1502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mC/0v+H8xu6M4PeRw/xaUyCAP9325/7j2kvOfuSHRXB6xzP+YQ02nsU8yaq2wSHW+AFh6DKgEEtpcsYIAZJSWUeZzQHY1HqZybZ3+yrKpo8VY89GIIkZbl+c3hnThsE5la/dO8aXr6ARJkSvmgWI7dko0IeLMsReY4g/35Q6Q/8DQSPE8Nxu1qsm35sqtwKWdGZsz9v/mEzBgt7sl5kU0xxguLTAyVZIv5C+yAgk58Rg/2As+np1fxx6HK7CzvETmPS28DO9kH4BaKi71Q+KMYwUND455UrncRpGDlOfj9DwBQoJ8OTM3Z2kK6ojW1rjbd+H69Awq/oD9qLgYUq6BtbLmlfUqZ2kioiarSY5pgCBc6YkDJVKTVcCTL+gt7t0UDdFd1v8mqKeP5cfxie1HG+bhfeFKxkD7/Bvobvuh6WG7OPL1RBosRD3RQn0ekSuq4m/Lt7UInht97tV5cF9nGFmoEyPEWEcArg2oA7+YQBF6yp89sy85OziJbxJf2wanadTgk6EPjQkk08ZJfcyQ4pfbcIJiPbjqBKuF52hEuD3Hb7RMLsrcmv5JiwdFv8nPo9bIt5bgLRlGfoZ4dSx3qe6VpicDs9mD7fyOhmY//+ARzOwUtAbgt/9KY4J3kHFyDaaLU2xcoyDOiMKE/awSy3cFbLkEqKkrgo5nVZj7xPhrxiuUOpowLaRxK6SsFhO9JGAuxsjEWWfsHufogCi327QBacnRz3nlH/TwYvtptjrcsIBB+73ZW7unL9PLlBOLJmYvjEQQhcRfhnU9HfYiUga/e983RC+zKDkY3dhlTyZHFvzYsj2cZ8TO0u5sgPq4a+ePpG06IN6CoMQnPX8W0vkU8VU+/3YMn1z5WTVupY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(186003)(5660300002)(53546011)(26005)(86362001)(31696002)(36756003)(44832011)(2906002)(478600001)(83380400001)(52116002)(316002)(31686004)(16576012)(6486002)(66556008)(66476007)(66946007)(4326008)(956004)(8936002)(2616005)(8676002)(38350700002)(38100700002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alMzS3JUakI1Mnp1N3BSbDVkL3A5b3hQOERSeWgwZkw1OWlrRXhmQ0tKaVlQ?=
 =?utf-8?B?aUhDaVhvbWhaaHZoOFFRWlJLK2lyZ25rVWEwcGp0RUJ1TE44blpQd1gxcWJL?=
 =?utf-8?B?dHl6RVQyNXBkQlBUMHBVeEVBNG4vWFhJVUdjMUtoRTM2RTFTd3daR2NjU2Jo?=
 =?utf-8?B?TG40a0hwVCtRR2p3SHBRUnFBT3NQVzFoenhtSml3UUxlbWxDQ1RiMnF4SmtM?=
 =?utf-8?B?d3Iyb2M0R3dOY3YvNFE0dnNRTTVGQlZnWGJZcDFBK0ppT2xtZlcwQWtWbERE?=
 =?utf-8?B?SWhjU1JCVmo1Y2grSlk4YnVFWjZCankvV0hzUVh1bkJHaVNlYld4NzN6c3pD?=
 =?utf-8?B?a2RIcE9FdE9PNU1jamJySnU3c2NWelEyWkdLUDFuby8xayt6S2dVR09NNHhj?=
 =?utf-8?B?SnlpdnJGdG9GbDJNajJSZit6L3BvTUd0R2tRYmJxZ2R0dDNVb1hlMGJrbG50?=
 =?utf-8?B?OHhyZUgxNmk4VDRCU1E0S3o2UlJhOTBNdjk4aDRqSllzb0w0ZzIyTDBUZGw5?=
 =?utf-8?B?aEwrMlhCOGVDRzh5U1VycXVXd3hoL0s0cjA4b25XQnFsMVAxM3RKTENRaVVl?=
 =?utf-8?B?QmxFNVlkMENKNGNsYk1hNDhNQkpOM2RhenVFSmRRWVkrd29mdktuejFJVC8y?=
 =?utf-8?B?aGNmVDgrWVJRNTdPZWhLL1F3NTdzT21XU1FLZmRPWGNEdmFBMnhuOE5Raktr?=
 =?utf-8?B?UjZIZWFpTDZWNGU4YTZWQWZiMTd3ckQ0TExrckJ5d2pNN0htZ2hHVHFZbHJP?=
 =?utf-8?B?OE1acjFsWTh0dDY3bG5DZlF2ODRIOVV4amZ4T24zZHNjUW53QnlsdHJ2VGpY?=
 =?utf-8?B?T2xBa2Y2WnhhckJmS2Uwd1JCSVo2Mk10WXRac2RaWW43cW5ndUV4OVluSVdi?=
 =?utf-8?B?cU9oMFVDSVM5VWMvK1lLZVJmYVhRejFjcTM4WVVGVExZemRtUGZLTDVKK2Nx?=
 =?utf-8?B?eVcwbEQxUk1aaHI2eXlnbXFlVkJ1VndLZWlITWFFMWw2dnZrOWRmTFRpS3py?=
 =?utf-8?B?eFBCTEcwT2xEVVd5YzlsdGlqbHR1cGFXd3JKU3ZWM0NDYVhaZHk2ZkVxaity?=
 =?utf-8?B?U3hHaWduVS82UVhZa1E2TFMzRG9reHltdEZCRm5iNDVOMHBSVWxzOUNzdlhY?=
 =?utf-8?B?aG4wUkkxTE55UWhrZk1wL1MxeENtL2o3Y3g5TFBLQys5OC95bHR0N1JRczN0?=
 =?utf-8?B?YVBQdnN0YmFIandNUWVFTklDRHIzaWFkU2lyVFlPWTc3QmJkK3VFK0VBWmpN?=
 =?utf-8?B?RHdhcTdNTTY0RlgwRlV2amtpWU5YcHhGS00yMFZrbmFJZ2RxenFWSzVidTZS?=
 =?utf-8?B?NE1qeFV2bktRb2VKTVB6RjZhemRYdHQwVHJpOHdYWUlUL2pCaGxSUm5mTnlX?=
 =?utf-8?B?bTBESHhhQ2xZM05rTmQ1Zld0ZkZzSFN1ZW9VUkk1QWRRSFJpMVgwSHlJUzli?=
 =?utf-8?B?WFJsY2VYc09mbDBYeThUdi9DVnhWdFFoU0dhb3gvbmVQbWtpdWE3VytBcUsz?=
 =?utf-8?B?Y2FObGR4T3ZVZHVHczlmZDJEUEVSbUh1U2l1cHEyOTJ0WlVjbmZyOW1hYjlB?=
 =?utf-8?B?RldwdnI5R2ZWck1OcEpuQk92NTlCM3BiNE1YVjJGdW5vcXZUcnBuc1BhWGF3?=
 =?utf-8?B?MUZkcjdpbVQ2enE0aytzTjA5QjAyWmRlS0lBNjVlWmZwOURYZk02NjUwdnNK?=
 =?utf-8?B?U0VpTFErSVVNbE9BSVRjdmNKemc4RStER0RzUzc2d2JOdVZvaGRiNGpyUUdU?=
 =?utf-8?Q?YCtkW/BgAloObl7STC1dHGcyFv/94KensOo49js?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14ba037-3f08-418e-de65-08d9640c7176
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 18:58:05.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeKyqrSRFBR0F+yXc1mrzcifQ5CEHP6+E5tgGFnIEkt4/FxWCi5RnmxXO22JTAzo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1502
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/21 11:40 AM, Wei Huang wrote:
> 
> 
> On 8/20/21 11:33 AM, Babu Moger wrote:
>> The recent commit 064855a69003 ("x86/resctrl: Fix default monitoring
>> groups reporting"), caused a RHEL8.5 build failure with an uninitialized
> 
> Don't mention RHEL in the commit message, just use "commercial Linux
> distro".

Talked to Wei on this. I will replace RHEL8.5 with just RHEL.
> 
>> variable warning treated as an error. The commit removed the default case
>> snippet. The RHEL8.5 Makefile uses '-Werror=maybe-uninitialized' to force
> 
> Ditto

Same as above.

> 
>> uninitialized variable warnings to be treated as errors. This is also
>> reported by kernel test robot. The error from the RHEL8.5 build is below:
>>
>> arch/x86/kernel/cpu/resctrl/monitor.c: In function ‘__mon_event_count’:
>> arch/x86/kernel/cpu/resctrl/monitor.c:261:12: error: ‘m’ may be used
>> uninitialized in this function [-Werror=maybe-uninitialized]
>>   m->chunks += chunks;
>>             ^~
>>
>> The upstream Makefile does not build using '-Werror=maybe-uninitialized'.
>> So, the problem is not seen there. Fix the problem by putting back the
>> default case snippet.
>>
>> Fixes: 064855a69003 ("x86/resctrl: Fix default monitoring groups reporting")
>> Cc: stable@vger.kernel.org
>> Reported-by: Terry Bowman <Terry.Bowman@amd.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/lkml/6118d218.4ZZRXYKZCzQSq1Km%25lkp@intel.com/
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/monitor.c |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 57e4bb695ff9..8caf871b796f 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -304,6 +304,12 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>>  	case QOS_L3_MBM_LOCAL_EVENT_ID:
>>  		m = &rr->d->mbm_local[rmid];
>>  		break;
>> +	default:
>> +		/*
>> +		 * Code would never reach here because an invalid
>> +		 * event id would fail the __rmid_read.
>> +		 */
>> +		return RMID_VAL_ERROR;
>>  	}
> 
> It used to return -EINVAL, you might want to do the same?

No. The function prototype has changed a bit. We have to return
RMID_VAL_ERROR(u64).
Thanks
Babu
> 
>>  
>>  	if (rr->first) {
>>
