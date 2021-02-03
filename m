Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF69630D59C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhBCIw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:52:56 -0500
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com ([40.107.237.61]:44289
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232710AbhBCIwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:52:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6GSkgjVDdleJzBe86c04VygAPR+DbYqjaav/Td8rjHz3hjOmZ69CPUL0bWCOLU0Im6D94qzBS45K16AwS6SPN4lPa74M2CWfJQ7XsoanAbt6idmZU9DgsxMi0AHnjCBCWkguznENrgdFwf8ehlMliSNqfMrWS4B66qFVVC81TQ6tbkLgl4nsRiqv8CgjxAMaL5xg6IQha8SMh6dNSfir81HEcKWZOzbHKKng7Z8Ch+2LEy5xNdSv/+5Lzqrhlzcg8txnYD57LBPfag86AueaS7KuglaUHG6OXaATYSkJ5liWXU8iAUvgJJ/fdmfH4TalfV+Q8ZEwRDAHFbltnNY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhJJsZjgnvSW6/aUx0l0gx0rP0kWAbdknfFfhbh+nJI=;
 b=aFjV76P+czJ8/Vs92WMGTUXXMzzq/vV76Hwd9r7DdXt6svvm7VtFxelwTsKqGnndQlgxnVZF6GKE3r5vuuYE//iXLhhibdd+Dr/X/rDsLNmmoDUBRSLqREe1w1xJ+dpFRLh6jusqtJUW/wZWB00C9laCl3nTbTMxtyGMfxeuqcG/OSkm4pg8MVMEAe+87dk1h7fgNABc47E9q3z5Gw+A/0SRjQenV9rWmKDDTTfpSbGzsn4gx+7elMLiMCEOL1hQYogsmCrEHwiSBSURzEJHDVtUo2dESIY0hXPj6GFuYfezdFyrYuf+KxR4jzizcQrmWC0w0X/tXNSS7fZrA30lJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhJJsZjgnvSW6/aUx0l0gx0rP0kWAbdknfFfhbh+nJI=;
 b=ThtrRr45xzO0Yn6Fntr+7olzRhR68M3+aihlu4w6MpYWSLPbZgy+ufo4spYGViKzc2pym3Z6KWtvoDfJ577/OiS3GFrc0Mo1IWVrsj/5A2tdul1xNvutNbCd1l5Fxnf7uTVZyWD5SERPlw05HbAmQbWxiG542nvb1a6rvZr0J8w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 08:51:45 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 08:51:45 +0000
Subject: Re: [amdgpu] deadlock
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Gomez <daniel@qtec.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAH1Ww+TPCSyiaC3oeoWPtsi-vDfDY=K4ByoLD37-onMvsAB5Rg@mail.gmail.com>
 <58e41b62-b8e0-b036-c87d-a84d53f5a26e@amd.com>
 <CAKMK7uGTFYWnBG+JtbAK=zQVT1dT=nKor_SHP-t958oebgn8_A@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fa170c5c-2f46-58ef-6847-e0bc9907fc8b@amd.com>
Date:   Wed, 3 Feb 2021 09:51:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAKMK7uGTFYWnBG+JtbAK=zQVT1dT=nKor_SHP-t958oebgn8_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM8P192CA0014.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM8P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Wed, 3 Feb 2021 08:51:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8fceba75-9606-4705-e191-08d8c820ef75
X-MS-TrafficTypeDiagnostic: MN2PR12MB4207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4207A708E1AFDEEC7DFE5CE983B49@MN2PR12MB4207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5BTX/zPV/svqRfcn5SIQVpdSyW8jdAFMcVt74r30XgV9To/hLApSU9+UrPrvQrQoU7uO0KWim50XkES6BDyLlf5x+dIp3Cc+fRAAui0HW5OkzvtHv7Z7nysuziA5gnsD25u33ghvVWGA8mus3CgfCOXDcn2IGCxwy8Qf//ux2hwpBg4zMWtd4KpxGlPLN9014rVAxTyg0prODOOdrv0AgOLrw2Y3lRsPY11AG5tSQKGne70bmxnV0FzC2Zj/HsU5zFcVcJU12CDTytH/TH8d1shg257z16WT0rJhQ9XIUzSpNtS0ExEJHrx2h6HfP+MEI7ouFZs9MHuC6GsBc1w47anJZhFVlYmtugpPHk0JbHVc03VuEWQAHJ82q2z3CfL4RAJ/fBdKlP2Ra5/70CpuoY2AHoGPlsf+rwoaU57QtczBUkK8p+wReKg/4llpoQ6rkOzPcMpFcV0p0v1dHt9i9udkPWmNpYVheflMswSvsb7Hi3OeZx7i4ixBZTgoUR1aMpnC14EacOxYR86bOvaGJpxIRReZJ0DheN1oFh6MntqsfC8Tx2pIauBW15HcFz71/nVR+47ED8165BcugRzs1FEHEcwsyPQlAJXCoctaeMfLpuyjtc98p6lt5reLhxYsgRQuq4YLK/HcV/CXHRB6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(478600001)(66476007)(6916009)(66946007)(52116002)(2906002)(966005)(54906003)(6666004)(316002)(66556008)(45080400002)(4326008)(16526019)(8936002)(5660300002)(31686004)(36756003)(31696002)(8676002)(86362001)(83380400001)(186003)(66574015)(6486002)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?LytnUmdldENZa2tYRW93N01MRXNnbDdOcld2aGxIVGwxZXlHN0JNVmJsd2F6?=
 =?utf-8?B?amgwWW81NHVxMkV3YXllV1pIa1lPWHQ2S0t0dWlVZ3dEbitPWjFkVnZXekx3?=
 =?utf-8?B?ZG1lbUFsZW5hTjF2WmpBRzZDR0NoenovWWFjblRzYXJHR1BaaEZ4RVh1Tzhw?=
 =?utf-8?B?bTFESnFmSkJpYXRsaXhRRVZoc0wvb1FkTzk0SVdaYVBYRTE0a3pKcVFhZkdK?=
 =?utf-8?B?MThtTmdBTldoSDZsd3YvQllXM01vTnRIREdWWnBRbzdzZ2d4WUxENkFNTEhx?=
 =?utf-8?B?R3dXcXlLczZWWExQSEorWTBCT20zZjZwQ0FDTzA2Y01SQUxvU1VYNkE4NmVZ?=
 =?utf-8?B?RWRBdnVvNkFjRGREMVJLMExYNUtidUZ2TC9XeTRKL0VaZXpJRnlMamxCQ1ZG?=
 =?utf-8?B?YVgvcTNWUnNOWXRPcUtNKzY0OGtySzlzMVo1UFo3a3ErRjAyQkdTWGpxMUNn?=
 =?utf-8?B?WjkzYjBxZWNoTER5TjB3NDJzQ1dDdnZpd0xXbTNocTBUa2VwWXRweEZMSS9L?=
 =?utf-8?B?V2Q0TGNRVytYbGpuZzYwdmYyMDdYU0dDK0lENmNtWEdBWnN0NFliVmc4YlJV?=
 =?utf-8?B?YSs2cEx0dDkrR2JrQnN4RU1oYVJPdFJwNThWR0NhbjNUOTNobjdzZnkvUVh4?=
 =?utf-8?B?RG5BSGlMM2NIQ0NqMm9PZnpwemwvTlpZM0RQN0xVVDIwNldSOGkzT2N1dTYw?=
 =?utf-8?B?VFJZK3ZDSGpSdnVDZVJtRTVBaXlzRTlRemlBcFdzVFZxYzBsUVhQelpORVUy?=
 =?utf-8?B?OHNXcjV3TW5wZ1FIT2J2MWdIU0NtMGNDakpoYU85MlFCVk85ZEhRNGlDUXZL?=
 =?utf-8?B?cGwxMzVwK2wwaDB2STFwR0ZFUWtYRkZQY2FHNjdXMUF0VTFjMDJuQ3E4Q1NN?=
 =?utf-8?B?RGdYSGFoR1V3SmRTV0luekNxZ2hoVXQ4SUtoQU9GSFJXQk9XR0JqYXJINXo4?=
 =?utf-8?B?WEg2YUpTMUcyT21qa1JsdkRDa2l4RDNOdUFjMGtBVGZQanJmVmRxSFBrNlBn?=
 =?utf-8?B?dnQ0K0ZVaXJLcTg0aG9vRDNRYytqM1Uxa3lPOWJmRXdZTzhHdi81dFMxU0Qx?=
 =?utf-8?B?eldmNk1ab3VVOWQ0bEN4TXJXeGprVlVtN0I1RElpUDNBcGhrSXJoREFHOEtJ?=
 =?utf-8?B?d3FEZlJnYjk3ampaajRHUC9BUVpXWnZIa0tHT0RqOC8wWDVNWHZSYmVPbUFi?=
 =?utf-8?B?WDlnLzEvM3dRZHZyd2I1bUtHcjg1SDIwekoxenNLbExndlF6bnZoZHNxMks4?=
 =?utf-8?B?T3RFNHhtckZoeVAxZXlJZlBMa0lybHNZODdFL3VMNjU3Tm9XSFFqL0ZReXVH?=
 =?utf-8?B?ZFZlOUhkWlV1M3JtYmZkdzA2R0VkYjhBbW5DRFdFdXNHUUU4WGtlRFlNaW1D?=
 =?utf-8?B?TFFqNFBjajAvcVNOdDVHVHR2K0oyS2NzVDNpNzdiWEllLzY0bGUvSFdGRFdt?=
 =?utf-8?B?TFUwbUxna3U0bEpJaGd0TThuemNXd3lWSjVma3dVd1ZoV2p2b1R0MUR5VFlZ?=
 =?utf-8?B?aENTWW9XTHFIRjFEelVzK3hqU2FEelVianYweEs4b3crc1RNUENLVlV4Ly90?=
 =?utf-8?B?ZTg4d24xajBWbE1WNUkwMk9Zdy9pTUF3VDQ4Tk1UL1VXM0dZbWkwYlhoZDdk?=
 =?utf-8?B?UTBYSnN4bFJpRFBGVnluVUJCQTdkb080c09ib2lWVk5SSVBkKzF0UnIxNU05?=
 =?utf-8?B?Z09nNExCOGFoOWtpb2xzUlhZRWFCQzk3MEM4bVgwTlVxNmFLdDZSRktEUzRB?=
 =?utf-8?B?UXFBbkJTdkY4S1JGQWg1MXBtNWRLYmxRcTN5aVdPR1NIdzVmSEVZcTN1NzU2?=
 =?utf-8?B?aHo2T0VadkdhVUlyNmVxeVllOWNWUzdOVHMybllrTHdNb2xMMEorUGFqV3Nq?=
 =?utf-8?Q?6sG/lR6RiOJ6J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fceba75-9606-4705-e191-08d8c820ef75
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 08:51:45.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gp4VN5m+gT+RKN2NXl6kjo+vXu88tC3PGB9VRHJGfjPkcpSs8NTnnDgHyJrxORkh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.02.21 um 09:48 schrieb Daniel Vetter:
> On Wed, Feb 3, 2021 at 9:36 AM Christian König <christian.koenig@amd.com> wrote:
>> Hi Daniel,
>>
>> this is not a deadlock, but rather a hardware lockup.
> Are you sure? Ime getting stuck in dma_fence_wait has generally good
> chance of being a dma_fence deadlock. GPU hang should never result in
> a forever stuck dma_fence.

Yes, I'm pretty sure. Otherwise the hardware clocks wouldn't go up like 
this.

Question is rather why we end up in the userptr handling for GFX? Our 
ROCm OpenCL stack shouldn't use this.

> Daniel, can you pls re-hang your machine and then dump backtraces of
> all tasks into dmesg with sysrq-t, and then attach that? Without all
> the backtraces it's tricky to construct the full dependency chain of
> what's going on. Also is this plain -rc6, not some more patches on
> top?

Yeah, that's still a good idea to have.

Christian.

> -Daniel
>
>> Which OpenCl stack are you using?
>>
>> Regards,
>> Christian.
>>
>> Am 03.02.21 um 09:33 schrieb Daniel Gomez:
>>> Hi all,
>>>
>>> I have a deadlock with the amdgpu mainline driver when running in parallel two
>>> OpenCL applications. So far, we've been able to replicate it easily by executing
>>> clinfo and MatrixMultiplication (from AMD opencl-samples). It's quite old the
>>> opencl-samples so, if you have any other suggestion for testing I'd be very
>>> happy to test it as well.
>>>
>>> How to replicate the issue:
>>>
>>> # while true; do /usr/bin/MatrixMultiplication --device gpu \
>>>       --deviceId 0 -x 1000 -y 1000 -z 1000 -q -t -i 50; done
>>> # while true; do clinfo; done
>>>
>>> Output:
>>>
>>> After a minute or less (sometimes could be more) I can see that
>>> MatrixMultiplication and clinfo hang. In addition, with radeontop you can see
>>> how the Graphics pipe goes from ~50% to 100%. Also the shader clocks
>>> goes up from ~35% to ~96%.
>>>
>>> clinfo keeps printing:
>>> ioctl(7, DRM_IOCTL_SYNCOBJ_WAIT, 0x7ffe46e5f950) = -1 ETIME (Timer expired)
>>>
>>> And MatrixMultiplication prints the following (strace) if you try to
>>> kill the process:
>>>
>>> sched_yield()                           = 0
>>> futex(0x557e945343b8, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
>>> NULL, FUTEX_BITSET_MATCH_ANYstrace: Process 651 detached
>>>    <detached ...>
>>>
>>> After this, the gpu is not functional at all and you'd need a power cycle reset
>>> to restore the system.
>>>
>>> Hardware info:
>>> CPU: AMD Ryzen Embedded V1605B with Radeon Vega Gfx (8) @ 2.000GHz
>>> GPU: AMD ATI Radeon Vega Series / Radeon Vega Mobile Series
>>>
>>> 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
>>> [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series]
>>> (rev 83)
>>>       DeviceName: Broadcom 5762
>>>       Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Raven Ridge
>>> [Radeon Vega Series / Radeon Vega Mobile Series]
>>>       Kernel driver in use: amdgpu
>>>       Kernel modules: amdgpu
>>>
>>> Linux kernel info:
>>>
>>> root@qt5222:~# uname -a
>>> Linux qt5222 5.11.0-rc6-qtec-standard #2 SMP Tue Feb 2 09:41:46 UTC
>>> 2021 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> By enabling the kernel locks stats I could see the MatrixMultiplication is
>>> hanged in the amdgpu_mn_invalidate_gfx function:
>>>
>>> [  738.359202] 1 lock held by MatrixMultiplic/653:
>>> [  738.359206]  #0: ffff88810e364fe0
>>> (&adev->notifier_lock){+.+.}-{3:3}, at:
>>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
>>>
>>> I can see in the the amdgpu_mn_invalidate_gfx function: the
>>> dma_resv_wait_timeout_rcu uses wait_all (fences) and MAX_SCHEDULE_TIMEOUT so, I
>>> guess the code gets stuck there waiting forever. According to the
>>> documentation: "When somebody tries to invalidate the page tables we block the
>>> update until all operations on the pages in question are completed, then those
>>> pages are marked  as accessed and also dirty if it wasn’t a read only access."
>>> Looks like the fences are deadlocked and therefore, it never returns. Could it
>>> be possible? any hint to where can I look to fix this?
>>>
>>> Thank you  in advance.
>>>
>>> Here the full dmesg output:
>>>
>>> [  738.337726] INFO: task MatrixMultiplic:653 blocked for more than 122 seconds.
>>> [  738.344937]       Not tainted 5.11.0-rc6-qtec-standard #2
>>> [  738.350384] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>> disables this message.
>>> [  738.358240] task:MatrixMultiplic state:D stack:    0 pid:  653
>>> ppid:     1 flags:0x00004000
>>> [  738.358254] Call Trace:
>>> [  738.358261]  ? dma_fence_default_wait+0x1eb/0x230
>>> [  738.358276]  __schedule+0x370/0x960
>>> [  738.358291]  ? dma_fence_default_wait+0x117/0x230
>>> [  738.358297]  ? dma_fence_default_wait+0x1eb/0x230
>>> [  738.358305]  schedule+0x51/0xc0
>>> [  738.358312]  schedule_timeout+0x275/0x380
>>> [  738.358324]  ? dma_fence_default_wait+0x1eb/0x230
>>> [  738.358332]  ? mark_held_locks+0x4f/0x70
>>> [  738.358341]  ? dma_fence_default_wait+0x117/0x230
>>> [  738.358347]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
>>> [  738.358353]  ? _raw_spin_unlock_irqrestore+0x39/0x40
>>> [  738.358362]  ? dma_fence_default_wait+0x117/0x230
>>> [  738.358370]  ? dma_fence_default_wait+0x1eb/0x230
>>> [  738.358375]  dma_fence_default_wait+0x214/0x230
>>> [  738.358384]  ? dma_fence_release+0x1a0/0x1a0
>>> [  738.358396]  dma_fence_wait_timeout+0x105/0x200
>>> [  738.358405]  dma_resv_wait_timeout_rcu+0x1aa/0x5e0
>>> [  738.358421]  amdgpu_mn_invalidate_gfx+0x55/0xa0 [amdgpu]
>>> [  738.358688]  __mmu_notifier_release+0x1bb/0x210
>>> [  738.358710]  exit_mmap+0x2f/0x1e0
>>> [  738.358723]  ? find_held_lock+0x34/0xa0
>>> [  738.358746]  mmput+0x39/0xe0
>>> [  738.358756]  do_exit+0x5c3/0xc00
>>> [  738.358763]  ? find_held_lock+0x34/0xa0
>>> [  738.358780]  do_group_exit+0x47/0xb0
>>> [  738.358791]  get_signal+0x15b/0xc50
>>> [  738.358807]  arch_do_signal_or_restart+0xaf/0x710
>>> [  738.358816]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
>>> [  738.358822]  ? _raw_spin_unlock_irqrestore+0x39/0x40
>>> [  738.358831]  ? ktime_get_mono_fast_ns+0x50/0xa0
>>> [  738.358844]  ? amdgpu_drm_ioctl+0x6b/0x80 [amdgpu]
>>> [  738.359044]  exit_to_user_mode_prepare+0xf2/0x1b0
>>> [  738.359054]  syscall_exit_to_user_mode+0x19/0x60
>>> [  738.359062]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [  738.359069] RIP: 0033:0x7f6b89a51887
>>> [  738.359076] RSP: 002b:00007f6b82b54b18 EFLAGS: 00000246 ORIG_RAX:
>>> 0000000000000010
>>> [  738.359086] RAX: fffffffffffffe00 RBX: 00007f6b82b54b50 RCX: 00007f6b89a51887
>>> [  738.359091] RDX: 00007f6b82b54b50 RSI: 00000000c02064c3 RDI: 0000000000000007
>>> [  738.359096] RBP: 00000000c02064c3 R08: 0000000000000003 R09: 00007f6b82b54bbc
>>> [  738.359101] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000165a0bc00
>>> [  738.359106] R13: 0000000000000007 R14: 0000000000000001 R15: 0000000000000000
>>> [  738.359129]
>>>                  Showing all locks held in the system:
>>> [  738.359141] 1 lock held by khungtaskd/54:
>>> [  738.359148]  #0: ffffffff829f6840 (rcu_read_lock){....}-{1:2}, at:
>>> debug_show_all_locks+0x15/0x183
>>> [  738.359187] 1 lock held by systemd-journal/174:
>>> [  738.359202] 1 lock held by MatrixMultiplic/653:
>>> [  738.359206]  #0: ffff88810e364fe0
>>> (&adev->notifier_lock){+.+.}-{3:3}, at:
>>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
>>>
>>> Daniel
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C81203e5bac5841b8e5a108d8c82087a9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637479389339295622%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=RDSxD6OqD8HaOA2VnNfbJwLnKzhCLgOr5SVLjLF91bA%3D&amp;reserved=0
>
>

