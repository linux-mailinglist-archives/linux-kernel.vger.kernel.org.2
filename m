Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD1830DD03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhBCOjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:39:19 -0500
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:56417
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232772AbhBCOie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:38:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuOghxjFL2BGdRhq7nCB9GSGDy05lEdpfLOqRxBe6W96QdDpxDmVY5dvOF7pVxBKAvJ3HXEMRd+nG4IASHgd9bDiQ/XR0F+wr688VDVNsPqILPqggK6iyaPt41T5hL+Au91EZKbeDLrklp61IYY/aLgHO8KOzjzgpMR7u0LGmr19fpSsVRGBXukOpHy8F3YZJxVPUsR8BJrmCJ/W4Jk15eoiJAg5OrTFI00osNsa1Vj4hGCktC+DZHSsZFh1vNU8tOezLfVm0k+0I2R0fsdkEyYKlTS9mU6qa1EekEaQ+u4CK+8NWPBVz18REYjpZfU38kMkKnyzjE+Q4WsVXUhe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f4CEiavHIr85pcsOGhZCk7b5pQtt1igi6kyGAMDfXY=;
 b=CY+V2XXETAQqZgcnXe+24u7M2ZdTA9bigjCPG3bLQITsrG9hzASeNMhGaVjzC5pfUgkesFrBqepzshcC54XZlx/TkmUPEH3xPKuO6cR8iRirM6SQ8g5GbvaYWDV+L2DHeHlGiVU7i4dQlwzz6u55Y67s38/YNM8Bc8TG0y99NHUKeQrvfF3jAnkK9x4ItWJAANZRPfwu0w8rpS/2Z6NpSUkdZ3C477MhLM6XKisJQ6S4E5nYfWluoFD/TnT49FK4O+Kx0lWrIcv1BanuTQWAwIBuyjDQ5q7TnVGC/d5nSskwRkdKVd6dZWrR7sdK9kpH4ZY9wqGvQ2tTwCJJat78vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1f4CEiavHIr85pcsOGhZCk7b5pQtt1igi6kyGAMDfXY=;
 b=MkP0j+De/KZ+2u5xQ4fOg7vEt3ODSoaSM4J8Jh+L7lgTC+KcXmpyLbcTYUN9ZXcvmtrjxQMdjDk6p8fxKUhjEAvEAp25OHILlvdpEJG0BWa2oR1QUp+yHMvHlPEanYSnhGHmeV2L3j7Cby+jl3rncjv19FuLs73bzzm1nWzvum4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 3 Feb
 2021 14:37:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 14:37:38 +0000
Subject: Re: [amdgpu] deadlock
To:     Daniel Gomez <daniel@qtec.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, alexander.deucher@amd.com
References: <CAH1Ww+TPCSyiaC3oeoWPtsi-vDfDY=K4ByoLD37-onMvsAB5Rg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e62c6c4a-b8d2-4f7e-09c2-b5151fe12046@amd.com>
Date:   Wed, 3 Feb 2021 15:37:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAH1Ww+TPCSyiaC3oeoWPtsi-vDfDY=K4ByoLD37-onMvsAB5Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM8P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM8P192CA0025.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21b::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Wed, 3 Feb 2021 14:37:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96c27b8f-c47b-46b0-e0fc-08d8c85140f5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40487A1B250568D087C9B59A83B49@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FkrzC6tg3PrGAdfFaWbGnk7AjPKgxD2k2I9wnJNOxFKYIY4y0Ht5f7nP6y4Ac3PCvoIwC4Dor7jQRbB479CcEBJ1tGe77/r5OAytt4O2gSiqIUn+fFKuH1OENo9nJ7tbc+wMjVMtnPctUsMi3t4F41hK8ej3EGaiSsMaFAYT064K5Dg5P0R39tw5GcEmxwws1D1vv3zWp3Uiebwlu3sXfuFNp5yXVCcQYNQy3R+d8WTFMBW/scc7L2F+4zwqdeGWBOd7d3fd9TxhhGBxCACZ8U2L155MaqSe6y/XmapJEcFoG917vC2H/B5KKRt/HLpdTzDE7B9v02ksn/zmHQOjewKehWWbGRaLeCrlE+0fZif/YiBRZFtfhFNdRYp5k2Uoa4RCqGt3NJZNqC858k2P6jbBt2SKnbzrZQU1fkvC0Z0/Emu87zM3HphlIG0KYiZ3zoJk5IWHCtkorDOI7PjPsxQ9hCV/c+CY95nf6WT8nlRewRBnmZFehp75cCgbF/lXC8+5szshfxVDkuWTueG9Ii2rhdGTkMtZvfa2oQIrJ3L4iSptZ5mb6KxyWnQ2LOWQkg83YR8oJ2Opha6806dqJs+LFaO2rxzL4Pw2gOaDUD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(8676002)(186003)(16526019)(66946007)(83380400001)(36756003)(52116002)(86362001)(2616005)(6486002)(31696002)(8936002)(4326008)(6666004)(66476007)(66556008)(478600001)(2906002)(5660300002)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OTRkSnAvVkV6cWdDRlN3OHRCWHNoZzVzaVV5cnFmRXdVenBaUlgxN28yN1lS?=
 =?utf-8?B?dFRPYmx5THBVVjVJZmdPWXhsRTNBTU5iVDZxSXBoVDlDR1d3eXJLVm1rR2dl?=
 =?utf-8?B?NmNNdHZ0bGRvUXZVRGI5OGM5YUNLeWNVbEtzNWFuZXQ0VW1JdmRKcGNyYWM0?=
 =?utf-8?B?dTVlU3dIZ3J6YVJieVh0NU5RRUdwV0dYaHBjR3N1L0pzK1JERE9iMC9sYWli?=
 =?utf-8?B?cFRpaXkwYWlOR01PQmVxemFHdGk0Y0VEcThPYnVCYXZlL1ZKa0kzMG90NWpV?=
 =?utf-8?B?cUJYdWdscjZHRy82Q2sxYWJLTFVUTWVYL051Q1pIekhDVHV5QzdwZTBReHpC?=
 =?utf-8?B?S1JFU0owcy9OV3ozTVA2ZEJZZDNKeDVaZm9hZjRoeFdpeGZWZU5rU0tGcnJR?=
 =?utf-8?B?bVJkdlY4S1RXcVdjYk5jeGx2dEoyWWNPUC9Rck5rSlQyUFVSVHhPL05FSno0?=
 =?utf-8?B?OWV2K3YrSHNFM01wQ2NSRTRGdlJyNGNybWYrdllZbG9JRlVXMkIvRzZpemo1?=
 =?utf-8?B?cU5wRUJpWlRpRVlOaHJBRkVNdEFudWRveFJ1YWtqSWFWcmNob2RSZE4yeFB2?=
 =?utf-8?B?aCtqZWo5MUZTMmRadHkvSWhuZUh5bG45Z3NtRmhQRVNSZGlZTjR3ZVcwdUVL?=
 =?utf-8?B?YzNkeEhaK1RhUUw5L1picUdwZWUrMXpiUmFoNVgveDlIZ09FL0pnN0E3QkZz?=
 =?utf-8?B?SmovVEx6bjhzcHUzNmFoVjQ0NWR5YmtmdzI2VzY4WmxzbmplSyt6WWt5M0Ja?=
 =?utf-8?B?bFlaK1REUFBLUEVPc29BRDZ5Z20rTWJXSnViWXZJVFlUZXFCQ01MQUUxQS9J?=
 =?utf-8?B?NkxLd1RlcS9UV0RYb3ppbUFpS2c0Wlo0VmtZQ0M1dzVLUUlGckNNQWRGaG8w?=
 =?utf-8?B?Zy9qc0xuRklwR2dDK2t4eHhSQTFEcktKVDVibkhYUUd5ZDJXR2hnMTcwdU5M?=
 =?utf-8?B?WndhUzBLNzlPbndRK0JibG5VMktyeVo1MFZZT2FtUEFGZG9HSE1iR2Z4cUNK?=
 =?utf-8?B?aHJaOVAwSUxzd0sxZUdDaFlCNkh6eEtYUTE2ZjJGRlZIeGlMbFFuNUhHZGY4?=
 =?utf-8?B?cXFBYTBka09EMndVemJxR2ZxSmNTOGVEakVJa3RqeGNPYXEza0lKMmVDMTM2?=
 =?utf-8?B?ZUpMSFpkNi96RWZDQTluL3JTYXpybzhHQk9nRFhlcnlGWC9CQ1Z2YkR0M3ht?=
 =?utf-8?B?UHFqdzlPWFNWSHlHMHdDSDBaZm16Nzd6dWFHdlBXU1JPWHF2c09Ja1Jwa2hV?=
 =?utf-8?B?UEswY0pxWDFWM0YzSTJ0bldFN21MSENRcjZBZE9ZT1dEL0RnMVVwSjM0Qk0x?=
 =?utf-8?B?VUlWbDJoNWtWYUdxNmpOVE1EaUk2OXh0R1VWc1VYUlNlTi9qTkk4NnJJcWFJ?=
 =?utf-8?B?SDhtcGJ0LzVOZkZlYldmV1lrK2hsUnZ5N3A4WWNOZlZNNTR5d1dJcGszNnc2?=
 =?utf-8?B?VHhRMFRHQktQNkJTL2VHVjJXZ1ZFMFZ5dzlNY3lxNGt6aTBuWE1VSGx0ZzVH?=
 =?utf-8?B?OHpPSGNHc05JRUZmdnBDSzlYcHBmTUFDWlV1OVVSbVYwUzRKa1F6Sk5SOWhR?=
 =?utf-8?B?aW85ZHZCWGwwaFNaZGc3K205dkVpL0V0Ky9XSDNTenZndTlvbFVROXZ1QWND?=
 =?utf-8?B?YVR5anN6ZC9pTHMzY081SDFLRC9vTkVTZXVIVzl4VVlOV3Y0RmNFaHRGK2ha?=
 =?utf-8?B?aU4vMm9uajNvZDl5VWNINUYzNElBZWNZYWNNaWVzR1NHV2xad3FLaG1lRlE5?=
 =?utf-8?B?ZldEdUp0VHcxMnp3cEtEK2xiZWgxMys3THNWSzhYZ1crNFcwR2ZNT2FzZHJl?=
 =?utf-8?B?elkxWmFqMmpudTNpTFdLVzZDNzJHS1hlbmV3OWRWNGoxQ0RtNVE4RVBmR2VP?=
 =?utf-8?Q?5c1FL4P0mFBh9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c27b8f-c47b-46b0-e0fc-08d8c85140f5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 14:37:38.3075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ICG9h6gspbHt9ID4ZfYUjXliUPewxGW+xK2ACMB1PXSdVaJP8ed0kRKjM8TTp6H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I've talked a bit with our internal team.

The problem is that the 20.20 release still uses the older OpenCL stack 
which obviously has a bug here and causes a hang.

The best approach I can give you is to switch to the ROCm stack instead.

Regards,
Christian.

Am 03.02.21 um 09:33 schrieb Daniel Gomez:
> Hi all,
>
> I have a deadlock with the amdgpu mainline driver when running in parallel two
> OpenCL applications. So far, we've been able to replicate it easily by executing
> clinfo and MatrixMultiplication (from AMD opencl-samples). It's quite old the
> opencl-samples so, if you have any other suggestion for testing I'd be very
> happy to test it as well.
>
> How to replicate the issue:
>
> # while true; do /usr/bin/MatrixMultiplication --device gpu \
>      --deviceId 0 -x 1000 -y 1000 -z 1000 -q -t -i 50; done
> # while true; do clinfo; done
>
> Output:
>
> After a minute or less (sometimes could be more) I can see that
> MatrixMultiplication and clinfo hang. In addition, with radeontop you can see
> how the Graphics pipe goes from ~50% to 100%. Also the shader clocks
> goes up from ~35% to ~96%.
>
> clinfo keeps printing:
> ioctl(7, DRM_IOCTL_SYNCOBJ_WAIT, 0x7ffe46e5f950) = -1 ETIME (Timer expired)
>
> And MatrixMultiplication prints the following (strace) if you try to
> kill the process:
>
> sched_yield()                           = 0
> futex(0x557e945343b8, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
> NULL, FUTEX_BITSET_MATCH_ANYstrace: Process 651 detached
>   <detached ...>
>
> After this, the gpu is not functional at all and you'd need a power cycle reset
> to restore the system.
>
> Hardware info:
> CPU: AMD Ryzen Embedded V1605B with Radeon Vega Gfx (8) @ 2.000GHz
> GPU: AMD ATI Radeon Vega Series / Radeon Vega Mobile Series
>
> 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series]
> (rev 83)
>      DeviceName: Broadcom 5762
>      Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Raven Ridge
> [Radeon Vega Series / Radeon Vega Mobile Series]
>      Kernel driver in use: amdgpu
>      Kernel modules: amdgpu
>
> Linux kernel info:
>
> root@qt5222:~# uname -a
> Linux qt5222 5.11.0-rc6-qtec-standard #2 SMP Tue Feb 2 09:41:46 UTC
> 2021 x86_64 x86_64 x86_64 GNU/Linux
>
> By enabling the kernel locks stats I could see the MatrixMultiplication is
> hanged in the amdgpu_mn_invalidate_gfx function:
>
> [  738.359202] 1 lock held by MatrixMultiplic/653:
> [  738.359206]  #0: ffff88810e364fe0
> (&adev->notifier_lock){+.+.}-{3:3}, at:
> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
>
> I can see in the the amdgpu_mn_invalidate_gfx function: the
> dma_resv_wait_timeout_rcu uses wait_all (fences) and MAX_SCHEDULE_TIMEOUT so, I
> guess the code gets stuck there waiting forever. According to the
> documentation: "When somebody tries to invalidate the page tables we block the
> update until all operations on the pages in question are completed, then those
> pages are marked  as accessed and also dirty if it wasn’t a read only access."
> Looks like the fences are deadlocked and therefore, it never returns. Could it
> be possible? any hint to where can I look to fix this?
>
> Thank you  in advance.
>
> Here the full dmesg output:
>
> [  738.337726] INFO: task MatrixMultiplic:653 blocked for more than 122 seconds.
> [  738.344937]       Not tainted 5.11.0-rc6-qtec-standard #2
> [  738.350384] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  738.358240] task:MatrixMultiplic state:D stack:    0 pid:  653
> ppid:     1 flags:0x00004000
> [  738.358254] Call Trace:
> [  738.358261]  ? dma_fence_default_wait+0x1eb/0x230
> [  738.358276]  __schedule+0x370/0x960
> [  738.358291]  ? dma_fence_default_wait+0x117/0x230
> [  738.358297]  ? dma_fence_default_wait+0x1eb/0x230
> [  738.358305]  schedule+0x51/0xc0
> [  738.358312]  schedule_timeout+0x275/0x380
> [  738.358324]  ? dma_fence_default_wait+0x1eb/0x230
> [  738.358332]  ? mark_held_locks+0x4f/0x70
> [  738.358341]  ? dma_fence_default_wait+0x117/0x230
> [  738.358347]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> [  738.358353]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> [  738.358362]  ? dma_fence_default_wait+0x117/0x230
> [  738.358370]  ? dma_fence_default_wait+0x1eb/0x230
> [  738.358375]  dma_fence_default_wait+0x214/0x230
> [  738.358384]  ? dma_fence_release+0x1a0/0x1a0
> [  738.358396]  dma_fence_wait_timeout+0x105/0x200
> [  738.358405]  dma_resv_wait_timeout_rcu+0x1aa/0x5e0
> [  738.358421]  amdgpu_mn_invalidate_gfx+0x55/0xa0 [amdgpu]
> [  738.358688]  __mmu_notifier_release+0x1bb/0x210
> [  738.358710]  exit_mmap+0x2f/0x1e0
> [  738.358723]  ? find_held_lock+0x34/0xa0
> [  738.358746]  mmput+0x39/0xe0
> [  738.358756]  do_exit+0x5c3/0xc00
> [  738.358763]  ? find_held_lock+0x34/0xa0
> [  738.358780]  do_group_exit+0x47/0xb0
> [  738.358791]  get_signal+0x15b/0xc50
> [  738.358807]  arch_do_signal_or_restart+0xaf/0x710
> [  738.358816]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> [  738.358822]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> [  738.358831]  ? ktime_get_mono_fast_ns+0x50/0xa0
> [  738.358844]  ? amdgpu_drm_ioctl+0x6b/0x80 [amdgpu]
> [  738.359044]  exit_to_user_mode_prepare+0xf2/0x1b0
> [  738.359054]  syscall_exit_to_user_mode+0x19/0x60
> [  738.359062]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  738.359069] RIP: 0033:0x7f6b89a51887
> [  738.359076] RSP: 002b:00007f6b82b54b18 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [  738.359086] RAX: fffffffffffffe00 RBX: 00007f6b82b54b50 RCX: 00007f6b89a51887
> [  738.359091] RDX: 00007f6b82b54b50 RSI: 00000000c02064c3 RDI: 0000000000000007
> [  738.359096] RBP: 00000000c02064c3 R08: 0000000000000003 R09: 00007f6b82b54bbc
> [  738.359101] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000165a0bc00
> [  738.359106] R13: 0000000000000007 R14: 0000000000000001 R15: 0000000000000000
> [  738.359129]
>                 Showing all locks held in the system:
> [  738.359141] 1 lock held by khungtaskd/54:
> [  738.359148]  #0: ffffffff829f6840 (rcu_read_lock){....}-{1:2}, at:
> debug_show_all_locks+0x15/0x183
> [  738.359187] 1 lock held by systemd-journal/174:
> [  738.359202] 1 lock held by MatrixMultiplic/653:
> [  738.359206]  #0: ffff88810e364fe0
> (&adev->notifier_lock){+.+.}-{3:3}, at:
> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
>
> Daniel

