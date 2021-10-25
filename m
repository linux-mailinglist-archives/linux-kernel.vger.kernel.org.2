Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E0439BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhJYQpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:45:39 -0400
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:53409
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233155AbhJYQpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:45:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaWEQ/uKgx3crsxlfy9K8YOfi1JSMNiqfXL++Y0uuStdDMUbNs2zWCXaO78/s5OHGyoILkPa8DXwplA2ptwapC6682U6lgNv+d1zDCvgK/m2Gg8eOeKOwiGXP1cFJtgBjDIo+Psm7J7uY2inkzLkQ70kml/K4uJX+NsPDTxylt/fAJVZxzD0fJ89uV5rb9jPVavCbFSci1Yq1SCu78rsTXXiXqBKsVtRO/nn6zzMNJP4/P7XA4L5iTjLl1ypmFkPmzWxeI+o/IQg478Kt7uq80NuQHrsLLK53/bo1GaMRMGtqjVWE0QPRIvk8MgVZwpXAzEyOR/i0SnjEQT5967Vhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5rDtUZqimZVyV0toZguW7txROBrh1ytXNVEfl8RWMw=;
 b=PgLKcUYEpZ3ullBjkhr6o5PGJ11DzoOQUPlWhm9YBT8ygE359XPKBjLTZJMhC2GEyuX5wQlqZXLim7oH1IXF8eUXhZq2haXtRakgT5v5gcMIQyM35unNhxNNPptOBal6tmJM/tjiYBatHeB6kbn2Nq8UbxlXLjN9p8AU84vvfEfuE76bNIFhaPZBWofVh3WS5ADn9ljXl22gmShX0HRodB3aLI2T3E0h6PjUTmrtJ+nFWiyHdXrEJyG8hEYKANLaY9mFd2VDp2tp1XkjKSgTLhkYIHB61r5hgsdOLvDAJbzYQR/EPwfFwyLw2FjDGN9dNJO1PNSULaC1uMcFLqfwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5rDtUZqimZVyV0toZguW7txROBrh1ytXNVEfl8RWMw=;
 b=Aiq5qz9xH4nP+GIyctwCuyLUtAk0LwdcVY1VfriiMQwdiQbbQqsS0gauEzYyTZwrX/YapbYmcXP9PPcJ2bZmu27oqmF+ZkdXHUc6zGavMYa2wE1DFN81f3FeFo7CRHH56Vtq4butSyJDJoRbL4zrwdefHSce0sgQpKHKaDtHFdI=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1408.namprd12.prod.outlook.com
 (2603:10b6:300:12::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 16:43:09 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4628.018; Mon, 25 Oct
 2021 16:43:09 +0000
Subject: Re: I got an IOMMU IO page fault. What to do now?
To:     Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     x86@kernel.org, Xinhui Pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        it+linux-iommu@molgen.mpg.de, Thomas Gleixner <tglx@linutronix.de>
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
 <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
 <bc7142a1-82d3-43bf-dee2-25f9297e7182@arm.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2e315f82-1bbb-5570-8ece-a3aec42f45f0@amd.com>
Date:   Mon, 25 Oct 2021 18:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <bc7142a1-82d3-43bf-dee2-25f9297e7182@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM5PR1001CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::36) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:8129:53e5:4c:630b] (2a02:908:1252:fb60:8129:53e5:4c:630b) by AM5PR1001CA0023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 16:43:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba565e1-673e-4965-ee2f-08d997d6868c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1408:
X-Microsoft-Antispam-PRVS: <MWHPR12MB14087A2D46BAAFF1938A283483839@MWHPR12MB1408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTUniRrYheWCcLArxhMd6549KKtCvoLGasxVvGUW3PPiWcO8R4gh8L4BSpw+KS46oIbRuuntZbkG6KS/V0e+Wk+Vx4Oe5cuPImlMGnn5v4Cp/uotCO/nwI4TSvRp4YV5n4S/zKmXEsOMjoKBuV42/BeC7gYRrQ0/D/cRTPtstO7oLWJkNY01+aLFA906auh7twbJlDdlYDFKTQAoIjaFE23FbhnWCSH3f90NVx3tizElVUjPrBucH4piMdbmd40wAJ2t95MQVunoyFVeEbRIj87Kf4fjQGNqnfrZ8OBzOdM8lCaTqKwb3Z6t0ek+dmJ+FxHMCWiK6a2tKGEro1z3w3FCUnyOTg6+vYqVcgzrZab1f2TFoCpcImJr278hPQ/rwgMohWwtrkPE82ZWmnBQbsqF+RVa8wBjKJ+r0knzrJ3nBsgZRN/utwh6j6dn3rPIAY/PWA19RnXbrRPHr2GdLezeFV715gYnLhBgF7T0/w+RnrEQ8Lgf9UtD2BBxd9BcoHTpiu3LoLI62JrEGY5M/rodp/QeNl6aLk8uiT6uPhesojsIkDipV3WhoAQrcO1eR0I8Tkh9c5SrMlP3vNTTKoadVZ34+S1mfO7ZtV6TqL9VxUMD9g+qn+jFHXwrPVf0Rmh34BbpuSmGuusAoxYnRP5ai4SAK5sAwIAZUtQ8hhu9gd00Mvykw9dKZqAj8QPrD1wqYvTu9lK890z9M/ol3pifUCLoXQRXax5WGKO99RWgXkITqrlMxKLrUoYhVNqy3eJlCqN/YM7ujCHltoR6RNZDyOpQwwBnIixsreP69Sn8u+DsqlNviqzYxFYCsYpV++9We8IyLLtoV/o1IWLzFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(6666004)(508600001)(54906003)(4001150100001)(7416002)(83380400001)(2616005)(110136005)(86362001)(316002)(31686004)(31696002)(186003)(45080400002)(38100700002)(66556008)(8936002)(66946007)(66476007)(6486002)(8676002)(4326008)(2906002)(53546011)(36756003)(6636002)(5660300002)(66574015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1c3YmxMWG5oQUk1OXFtcjRITU1hV3JQakY1YkZLOXJ4aDV0ajExKzRiV1or?=
 =?utf-8?B?NGtRaC9BOXA3ZjBySDV2MklVMTdZQk4za3lrbzMvOENJS3BpVzhlbW5uVFVj?=
 =?utf-8?B?bGNjVmlKVm9hMmVRZjBsZ3JXa1N3M3pWOU45SjMwc1Q2OEUzVUFydWZMTzVt?=
 =?utf-8?B?cjVUOFJBZGVXNE54Titrb1ZpVXh6aDl1T1FxZ00zZW1BUnMraXdzRDRJMzFy?=
 =?utf-8?B?eWp3UWdrQzMrTzYyZ1UrWkdyLzNkOVpSbmxXN3kxVmdiQTVtTDZYMi9LWmNi?=
 =?utf-8?B?UHVCRDhIUUpFbDFmSjN0ZkZSNk1pVEo5NGpRUlpNak5QS3lEYkxRbnNHYVEv?=
 =?utf-8?B?czNuUFpsSU1SMEc4SHdXT1RQUFVRdUlQWFdiRXBUZStJNWlObmVaNUVXZXU0?=
 =?utf-8?B?WGIrUjNSNU9vSllOMEo3M0R6UHpWdjF0YU1MeWdmSTVMQkxaeHdZUUpLbWhj?=
 =?utf-8?B?OEtvY3NDSVhZTk1NenF3SWl2bFc1S0tOZEZpRmZ5T2I4T0dwUXp5SzREY3Fj?=
 =?utf-8?B?d2t1YytZWE9GYytYRWRjYWJFZnNyZjNPdHZ3MUZ0bllqUUNGUlRobnJYRGJ3?=
 =?utf-8?B?bFdFYno1c0hFUC8wMFBrQ0ZUcHArdm9uNW1PLzVieUVTeFNGeWFkbk8wYlpV?=
 =?utf-8?B?Ui9RK0QyVWtBSFkvem1sTTVvNFhXQS9rWWpMVGNmQ0lhYVNpUzhId1NIckhy?=
 =?utf-8?B?U2grYUk3andNSVFabXlvd1RLWFF5NXc2ZkxWRFdoSXFaVW5CMllkRHUweFhP?=
 =?utf-8?B?M29JV0hSTkF0OW5DUnBXN2xBU2J6ZXVtTjRwQ2dEckMxaU50QmpPME5wektU?=
 =?utf-8?B?ckdNQjVzQ3hJL0F2VmpSdDRwV011RWQ1T0R2L1lDMXpRMkk1d0ZKOEg3czZC?=
 =?utf-8?B?d1NZTnk4dzRBbDFSd0IybkF6cXo5aXFVeE1CenArTzIxYklJVGh5cGJpT2tq?=
 =?utf-8?B?c2ZtdlR0YnpPbjJtSWRvZlhmZ3B5YUNSdk1BVkRZTFMrV0J1VlE0OWlibC9H?=
 =?utf-8?B?cVg3QWlnWVZSTWV3MnRyRkp1K0hJRkpDVlN4Q1RsWkVZK3pRd3VuVmpOQkpY?=
 =?utf-8?B?Y3UvUU9MQXRwQTgxLzdVaU1hU2ZuUFRHYmxkaSs1U00wdjNxYVNXWmFjVmUw?=
 =?utf-8?B?b051OEp6VmRmL1RWaG12Rk01MDVWYWNYOUhrc2diVFhOeFRGMy9VSE9sL2Vq?=
 =?utf-8?B?Skd6KzduZ0xOaTI3VDdUM2VxMzNiRFJpTGJCK25YWEUxMFFza2o0Mm5uRlFJ?=
 =?utf-8?B?bStQUFczRml0SHBSeGIxQWJoM0VPTExLdGRjdTg5eWtuTmorcDVkYzBZSWpx?=
 =?utf-8?B?cWYxZURRcnJ6MkUxWUVsR3dGenhHRGt5MVZEVEt6NDhBNk1JUzlmc2lXMDRP?=
 =?utf-8?B?RVVud09KUUJGTUI0ZjdYUEZGek5HL1JURTV5dS9pdktSQllPZURWVDNxd3ZP?=
 =?utf-8?B?VWlEcHpnbU5SQnNwOXlIZHhBemJ1SVJKR2hCT3FYMXF6SGlxd0ZCOXBTTjF5?=
 =?utf-8?B?SHd1N2xyRVlkYy9CblBqdzliWXFWSFZFUGtXc0t2OXdxUWg3MzlsU3l4aTh5?=
 =?utf-8?B?MXBubHg4WjBHdjdtK2gybEkvYmxLbW02RlFOVGNGeE1pOERWZXJ0MTQ1ZC9F?=
 =?utf-8?B?Z1ZhZEZLTDRQa1RoOUpJUkN5eXZqM2hneStCMmRDaVcxbFd6R0lsRVMyckpx?=
 =?utf-8?B?WjhyNWZ4TWFKZlZzMDRjWFhrMTJKQXIybEtpb1U1bFlYcTFQMWR5dVNXbFBr?=
 =?utf-8?B?bzh3NFRvM0xacGpxNkJPd1ViczdlWnFhZjNVNkpkWnhDbC84Vm5NdWwxWGtH?=
 =?utf-8?B?aS8rN3g5TDhBbUU2T0EvT3VvdHJScmFYZnFJMDNzVGJqNldsQ1Z0cVFENlJW?=
 =?utf-8?B?S2tuUFdRbEJCSG1oUFJqZDRiNE1JTHRQWGZOdFgycUdTUm15WHBUa2Z3Kzdl?=
 =?utf-8?B?VkcvYmw4OU9iVjhnNnFQbnlHdkFsMmp0OEU0bVBlNGlIT1NxcnIzN2N0SU5t?=
 =?utf-8?B?VThTT1NNUVlLam42VzM5TnM4WlBMYTJzSWlFVGRsWi9QVlNOKzFrWHNnM1gz?=
 =?utf-8?B?NVByN292MUVaMll1MDZMR3NBeTZlRWpHUGlad3pMbUFGUUV1ci80cUI4Q0RL?=
 =?utf-8?B?VGFjQnhlUXdtYVpmeDhoU1VFLzUzQXRLRSsvd1BVRFJyc1NVOFpFamFhSytK?=
 =?utf-8?Q?ZTQIpbUAwjrBxnu8RDcrTLk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba565e1-673e-4965-ee2f-08d997d6868c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 16:43:08.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WaXeVW1XylOVAuQoYVwsGE36lyt6ehG2ARLyKRiBVw+dY7gRGzDwmJsHszK+nG4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1408
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Am 25.10.21 um 18:01 schrieb Robin Murphy:
> On 2021-10-25 12:23, Christian König wrote:
>> Hi Paul,
>>
>> not sure how the IOMMU gives out addresses, but the printed ones look 
>> suspicious to me. Something like we are using an invalid address like 
>> -1 or similar.
>
> FWIW those look like believable DMA addresses to me, assuming that the 
> DMA mapping APIs are being backed iommu_dma_ops and the device has a 
> 40-bit DMA mask, since the IOVA allocator works top-down.

Thanks for that information. In that case the addresses look valid to me.

> Likely causes are either a race where the dma_unmap_*() call happens 
> before the hardware has really stopped accessing the relevant 
> addresses, or the device's DMA mask has been set larger than it should 
> be, and thus the upper bits have been truncated in the round-trip 
> through the hardware.

That actually looks correct to me. The device indeed has a 40-bit DMA mask.

There is a third possibility which is actually quite likely and that are 
stale reads in the pipeline.

See for some use cases the device can queue reads into an internal 
pipeline, but when it later finds that the read isn't needed doesn't 
flush the pipeline.

The next operation pushes more read requests into the pipeline and 
eventually the stale read requests are executed as well.

Without IOMMU the result of those reads are simply discarded, so no harm 
done. But with IOMMU enabled it is perfectly possible that the stale 
read is now accessing unmapped memory -> BAM.

That's one of the reasons why we almost always have GPUs in passthrough 
mode on x86 and for example don't use system memory for GPU page tables 
on APUs.

Regards,
Christian.

>
> Given the addresses involved, my suspicions would initially lean 
> towards the latter case - the faults are in the very topmost pages 
> which imply they're the first things mapped in that range. The other 
> contributing factor being the trick that the IOVA allocator plays for 
> PCI devices, where it tries to prefer 32-bit addresses. Thus you're 
> only likely to see this happen once you already have ~3.5-4GB of live 
> DMA-mapped memory to exhaust the 32-bit IOVA space (minus some 
> reserved areas) and start allocating from the full DMA mask. You 
> should be able to check that with a 5.13 or newer kernel by booting 
> with "iommu.forcedac=1" and seeing if it breaks immediately 
> (unfortunately with an older kernel you'd have to manually hack 
> iommu_dma_alloc_iova() to the same effect).
>
> Robin.
>
>> Can you try that on an up to date kernel as well? E.g. ideally 
>> bleeding edge amd-staging-drm-next from Alex repository.
>>
>> Regards,
>> Christian.
>>
>> Am 25.10.21 um 12:25 schrieb Paul Menzel:
>>> Dear Linux folks,
>>>
>>>
>>> On a Dell OptiPlex 5055, Linux 5.10.24 logged the IOMMU messages 
>>> below. (GPU hang in amdgpu issue #1762 [1] might be related.)
>>>
>>>     $ lspci -nn -s 05:00.0
>>>     05:00.0 VGA compatible controller [0300]: Advanced Micro 
>>> Devices, Inc. [AMD/ATI] Oland [Radeon HD 8570 / R7 240/340 OEM] 
>>> [1002:6611] (rev 87)
>>>     $ dmesg
>>>     […]
>>>     [6318399.745242] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>>> [IO_PAGE_FAULT domain=0x000c address=0xfffffff0c0 flags=0x0020]
>>>     [6318399.757283] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>>> [IO_PAGE_FAULT domain=0x000c address=0xfffffff7c0 flags=0x0020]
>>>     [6318399.769154] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>>> [IO_PAGE_FAULT domain=0x000c address=0xffffffe0c0 flags=0x0020]
>>>     [6318399.780913] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>>> [IO_PAGE_FAULT domain=0x000c address=0xfffffffec0 flags=0x0020]
>>>     [6318399.792734] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>>> [IO_PAGE_FAULT domain=0x000c address=0xffffffe5c0 flags=0x0020]
>>>     [6318399.804309] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>>> [IO_PAGE_FAULT domain=0x000c address=0xffffffd0c0 flags=0x0020]
>>>     [6318399.816091] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>>> [IO_PAGE_FAULT domain=0x000c address=0xffffffecc0 flags=0x0020]
>>>     [6318399.827407] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>>> [IO_PAGE_FAULT domain=0x000c address=0xffffffd3c0 flags=0x0020]
>>>     [6318399.838708] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>>> [IO_PAGE_FAULT domain=0x000c address=0xffffffc0c0 flags=0x0020]
>>>     [6318399.850029] amdgpu 0000:05:00.0: AMD-Vi: Event logged 
>>> [IO_PAGE_FAULT domain=0x000c address=0xffffffdac0 flags=0x0020]
>>>     [6318399.861311] AMD-Vi: Event logged [IO_PAGE_FAULT 
>>> device=05:00.0 domain=0x000c address=0xffffffc1c0 flags=0x0020]
>>>     [6318399.872044] AMD-Vi: Event logged [IO_PAGE_FAULT 
>>> device=05:00.0 domain=0x000c address=0xffffffc8c0 flags=0x0020]
>>>     [6318399.882797] AMD-Vi: Event logged [IO_PAGE_FAULT 
>>> device=05:00.0 domain=0x000c address=0xffffffb0c0 flags=0x0020]
>>>     [6318399.893655] AMD-Vi: Event logged [IO_PAGE_FAULT 
>>> device=05:00.0 domain=0x000c address=0xffffffcfc0 flags=0x0020]
>>>     [6318399.904445] AMD-Vi: Event logged [IO_PAGE_FAULT 
>>> device=05:00.0 domain=0x000c address=0xffffffb6c0 flags=0x0020]
>>>     [6318399.915222] AMD-Vi: Event logged [IO_PAGE_FAULT 
>>> device=05:00.0 domain=0x000c address=0xffffffa0c0 flags=0x0020]
>>>     [6318399.925931] AMD-Vi: Event logged [IO_PAGE_FAULT 
>>> device=05:00.0 domain=0x000c address=0xffffffbdc0 flags=0x0020]
>>>     [6318399.936691] AMD-Vi: Event logged [IO_PAGE_FAULT 
>>> device=05:00.0 domain=0x000c address=0xffffffa4c0 flags=0x0020]
>>>     [6318399.947479] AMD-Vi: Event logged [IO_PAGE_FAULT 
>>> device=05:00.0 domain=0x000c address=0xffffff90c0 flags=0x0020]
>>>     [6318399.958270] AMD-Vi: Event logged [IO_PAGE_FAULT 
>>> device=05:00.0 domain=0x000c address=0xffffffabc0 flags=0x0020]
>>>
>>> As this is not reproducible, how would debugging go? (The system was 
>>> rebooted in the meantime.) What options should be enabled, that next 
>>> time the required information is logged, or what commands should I 
>>> execute when the system is still in that state, so the bug (driver, 
>>> userspace, …) can be pinpointed and fixed?
>>>
>>>
>>> Kind regards,
>>>
>>> Paul
>>>
>>>
>>> [1]: 
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1762&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C13ead10a4a584537d87208d997d0c693%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637707745295391463%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=jn1HS%2FhtmfLOQBD%2FI9w4ZXpspc4X7ik6G8N1W5AlqXg%3D&amp;reserved=0
>>>      "Oland [Radeon HD 8570 / R7 240/340 OEM]: GPU hang"
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.linuxfoundation.org%2Fmailman%2Flistinfo%2Fiommu&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C13ead10a4a584537d87208d997d0c693%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637707745295391463%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=WNsslcCFP2UJX%2FtuPmsFWv%2BpW1i02q3K7pIlIdaQcfE%3D&amp;reserved=0 
>>

