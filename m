Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364FB30D557
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhBCIhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:37:41 -0500
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:42144
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232644AbhBCIhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:37:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaNaQh1bMX3fO+haXt1zG+8atqOLxgkRILGnctDBq+4RT+MZoWXo7m26IFTwvO7Pm+XzepRjwVS6Pmyi8sSzdSIEh3qku2Z5Ssjm8+TM/Rqo6lm2CFrib4FDxZAHvepkHWWzlnp3sAK+8obmy+FXW2iuto9IRoyeMbZ79z6dkXW9ueQTX/mxVxI4UYIr55+dwTxS9uhjugBBsnZ0PNWbtTIr2Ed/tqWbx1lJ/AAeRnrWi94DtirS824u6cOGr1G8jjZtVF/44ITJmjJtYXWhO3pDOlfLct/Kp7lBQQTMklIfb2YXeU01/19FRWhhiYlVxk6uM7BT3d7APFLE2mZ9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2taqLDRtvN/1R3xPgvTbgNOgvRCBDGepU4eTv1QrPz8=;
 b=PCPPLrp4cs4q9QHlndj1OTDNmdZ75rz1kvqKzaoucullV7xwGMBYOyg9KdXguBV5HC5J79bb4oAdStFG6OeB+nq/oKci0iDpzWEmPIq6tdHR5+NNaFb3pRyqP32oTaPd6AhJxJd5IUkDdyIaZeHQss3YT6wP2gK5t491GDK8UDkvZ85vaR6hp/67t9zqtXP2zafnEU8VDVDxEaWMPqdKyAz3lLA+76ayFCCHuGDi7AtuCcE+mAf+EUS4FD/JcxV3wYa9IQRZqFHgT+h+UzWNpGI8UAT2CgdEzG2+65l+GMeyLkoewbq6Teo44wyUKUhIQj+Jms/Xl0qe1BXjPkGCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2taqLDRtvN/1R3xPgvTbgNOgvRCBDGepU4eTv1QrPz8=;
 b=yBbo8n8aRcSzUF7EtD4wgyU1NuBBbAs4IxCOKFAJiKZ2D9t9MU1ASpK9icCBYIqHSwBqXixCQa1VPxVXgAaKvDDnmYqsp482R9xZDLg/ngKQW+jEtWVlTnW9X0Pttu4TcwNDNZ3InWx+nB/2vnATL2/KN5ZOY3JTu8zmtPkv7iU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 08:36:45 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 08:36:45 +0000
Subject: Re: [amdgpu] deadlock
To:     Daniel Gomez <daniel@qtec.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, alexander.deucher@amd.com
References: <CAH1Ww+TPCSyiaC3oeoWPtsi-vDfDY=K4ByoLD37-onMvsAB5Rg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <58e41b62-b8e0-b036-c87d-a84d53f5a26e@amd.com>
Date:   Wed, 3 Feb 2021 09:36:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAH1Ww+TPCSyiaC3oeoWPtsi-vDfDY=K4ByoLD37-onMvsAB5Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR10CA0105.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::22) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR10CA0105.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 08:36:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4efce771-bc03-4f5f-44cd-08d8c81ed6d4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4552987EF9B8A8072A38225C83B49@MN2PR12MB4552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Po9r47subTUOhkDTB9r9z93BhSUf8zeWu7PV0J6z9CTFnAXuBnxKfHwhsSKRE59C+9SYzGjP9JvnOuvmFTSJzm++8NhZvv4gk9V9zXZA6y1TeZgZ9RzQZsdFDlvXJ0xiyA2Y5HQwFe2Hb05+v4x5Ef9rJ6a9IIlwNjSy4z1j95m7WBunHWN7U0R3XOjyOwh4u2pYrCoBLPN4fYeCmnakwuFZTdgO0KAQt0MYDfcMTKpExQpUZeb7t97fA1p2wD73+cXkLJ6DBZIOhuCShCzLc7J190Bqb6l4Mtj/AZ3R87SSkH1pOK/zJzH6KcLk/JmwuVwv+eShEAynJW6NFoociBomyo8EhLxU6UIs8bubIjolVbzqdoiP/6+AAOyzB5zA1UYsvVdWCXW9wHEhOkMNI3BQ0Y84toK9IcN3s5OYYDeXO9sgG+dsGMQfdFNeE0eAqFT9gAibz2NDZdcrKZjTtiUGFOAvv+XsitK4PAaGq/qpSkEXw7oO13Dnvzc2QmjuzeztXKyqz3//o04ddriBzrQs/UYXVDPItqqczhjDdrWiRHRUeN1FRFVn6AgT8p34p1/T0T2z5NMztO3SeRLX5H5imcggUJjXf4jr364GFSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(316002)(52116002)(6486002)(16526019)(31686004)(478600001)(6666004)(36756003)(31696002)(4326008)(5660300002)(86362001)(2906002)(186003)(8676002)(2616005)(83380400001)(66476007)(8936002)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a2plbXpVVGRhemZTU2VEVzZLTENjTEY2SS9QcVBHNThmRm5LN3BBamhZY0FW?=
 =?utf-8?B?Q1R0dGJPNUZJai9xYmhlbzZONTNWOC9OZHcxOHpnNFgvUWdCVGZ1cjdxL1Fn?=
 =?utf-8?B?RjJPUkN5N01kUnkvVnhabVdGSVNHaHNXWEl1RlNUVmJCeFRUMVBFTFhkNzJ0?=
 =?utf-8?B?WDFidXMwcVdXNktKSGk4RTJrM3N1ZlZYN21HZEV6OTB1L05Kck54UHZsY3Ey?=
 =?utf-8?B?Rks1WXFCZHpCaERlb21zQW91VXpzMDV3MEFUM1FpUnpqcWNoUUxyc3Y3K25X?=
 =?utf-8?B?RUxBRk9hNkRhdDZFN2RlNkZlME50bzBNQlpacGVWUWZYbHQ3RmZ4NkY4b3FY?=
 =?utf-8?B?MHRZRjRCK3ppbjJQSHhkQk1KN20wbE03bEtncjNUaHhZdThUR0E4QzFGOHRq?=
 =?utf-8?B?YU14ZlFaK2ZMeWZFR2lnV2kvVGM0MjBmUXErVFhkKzhTbHFUOUh5YkRTY0Ix?=
 =?utf-8?B?RGlkWDF5VVlsVCtZSElQMmErSkZyZmd2NUJWUHIwYU9zTU9vSllscXlqSURW?=
 =?utf-8?B?cHNPMERYTmtsVnpYdktUTkxjRXU2WGkrQTJnUkhrbkNWQTJoK1pMbDdxZ2Ji?=
 =?utf-8?B?alFTS1JuNHNiZkc3U3lOSUJBaU5Ba21kUkNtcEpPaE93UmQ3T1FtOExQcXFq?=
 =?utf-8?B?aFBnM0V6TFp1OFowWHBpK2JVR3IwQmxneE9ReW5kc1B6ZU5WUGdudW4rSktJ?=
 =?utf-8?B?dU5zdVE5ZUoxUVhqS2ZybUd0ekJhZ2N2R09Oay9RcENxdHRlLzdXMlVMSEcx?=
 =?utf-8?B?ajkyTjBLUVFxcDNFamtvbkxuZWVLR0pwT2FmVG5SNUxQS1N6NzI0OU15ZlJx?=
 =?utf-8?B?Ynp6enhYdW1mVDYwVEo0SHhRbWNxdHVYZnlQMitXcWtIRzlKTE9PMEY0WURI?=
 =?utf-8?B?dkp6amlISHBiNFM1SVBIZXh1L0hRVjFBd2s2L29TUi80VWlEMC9sTHY3UmZl?=
 =?utf-8?B?UWRFaVppSE1Kb2svOWtyTGM3Tkw5eWh0MHplTm0rbVY5MzF6VVBMeEVUakwz?=
 =?utf-8?B?VTFsS2Q5MmNRckoyUG54UlBVQTVQSXlONUxJNkdxa1c0R0YvSWVJL0pqMVhU?=
 =?utf-8?B?Smo3VnFCZW9QWDJUSTNQYlNuSlZxdnAyN2RZd245KzgrYjBEL2hDRGVWdGd0?=
 =?utf-8?B?MDFxajVUUTYrYUZLaTR5ay9Ka2VUbUMvM2JpWmJ3d09XaHJuQjVNTnpLM0gv?=
 =?utf-8?B?TFhEamxVcVl4UDF0b3k4WlJTRW9xOGg1T0o3N1BlaU9adVI5RFk1S09Tekxn?=
 =?utf-8?B?Y0JWNzZWMnpEZ2REcUIzNm1XTXFsMzhLM1MwaFFhelpXTUVSczNBVjh2WjRv?=
 =?utf-8?B?QXE3Ykd4VllUUEdRVUhRTHZFZVlXczJBc0l3Yk9xWVpjcklJajJMa0htU1M5?=
 =?utf-8?B?c3lQR3VyOXdKMzJPOENHU21ldlFzRVRkREk4ei80VWlUSjNtNFE3dGQ2Rkx5?=
 =?utf-8?B?RUN1UU1lNFZNVFVKTWJoWXB2RFRsWndCM2F3K2c2YWxhcVg3b05GNjQwSTVL?=
 =?utf-8?B?Nm5rK1l4Q3VYZjJyTnFDM0FRYjcvS01pcWNPSUpFRnZDNG11SS9sU21EWk1u?=
 =?utf-8?B?KzdZODdNYnVGeHBseWpwVWFFVnpYLzVzTlhJTlZsY0w2SEZhOWxWNFFjUnh2?=
 =?utf-8?B?SnFIWEhQV3haWDZkUlE0QU05cktyWitkNkNydWRvNyt2RVBncWZPZnZNYUNF?=
 =?utf-8?B?ZGw0ajd6U1FERFduaEIrOWJPL1VSTFZKRGlBNEUrWFovWER5OUZLRW9valV5?=
 =?utf-8?B?RXBDSUpRVFBXNnJXYnlYQXU1Skx6eXhveStjaXZDV0VsUk1waEVoa0JZK2Jr?=
 =?utf-8?B?NThaaEFUU0UxWTVvbzVZU0JKelpkR25hK3NIRGpPTFhpWUtQY0VNUkZiVW03?=
 =?utf-8?Q?yb5P4brCdfLhA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efce771-bc03-4f5f-44cd-08d8c81ed6d4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 08:36:45.3503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POD2S7mtVbD6yyw5W8WFonSvfwTwZj/Dq5j00tXZajeaxbGiIXUGTu/DJuo/9XQO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

this is not a deadlock, but rather a hardware lockup.

Which OpenCl stack are you using?

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

