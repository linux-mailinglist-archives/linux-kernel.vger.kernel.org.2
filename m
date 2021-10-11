Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CFA42949D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 18:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhJKQbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 12:31:52 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:37345
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232033AbhJKQbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:31:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6zQc2ARSXCJF58Bpi65GejfMr6sUuTYKqttZqtc4ky0hIY9LpKaNOTL5EhIdpWvu+zGuMdTbeYCL39hIjDFijdWkV3YQBBPJJYjS+/ofHUPTeewpavMmBFe9gVTCWyik1o9Uvy6UxI9XhIYbRkiuyNblgRCMypk1K45GCX1nXXFEfxVQDsXGWNTwYWv5S3wPNBLZYfF5DwvzV8Jwz8cRVoobsMd2kYVsb3HbkOWOZ1S9T2/rle1Fjvg6sjbyEve7hLT0TG3zFW7yorng3j4nbp9ydQIkL7cFXDQba8M1Ku9/e2/ZWu0DhnB9oKm6zNcrH68c0DXtxx2XVXlS7dYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjSxFtF+aq5JwXTNnX5P2QpFjvzUEHlEkCahxOhzwnY=;
 b=crKub8YeczVualni6eO6QdcIIcC7bHmKnHl/jhh2Qjhyuo8ZCtWWQVqdoKA19nQZna1zLV286u5ePc8W2MB/vWZZGOF/kFF0FHD6LmuRdf3UNqDnWO060inAR947zEDJctjXQZBKBXlq8ZTF6iFs60BrPSc4dLw6s3+scv2xtbPp2k6UgEuMaLiF2I839ERxRUly0nMXRzHnhV1AxdIpSzoVI0Ud/J1oz+Ilb28ruYIfcqSoBU5yc5gv3wsw6ffK/RYsbnF1JrbpqytwSO9GSiArfgWGRBCvzvq7CTEGaF6vUYeDUJgoBrXlH99KlUi75nCdP1RBBzRA6Wpm3OBn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjSxFtF+aq5JwXTNnX5P2QpFjvzUEHlEkCahxOhzwnY=;
 b=1Oyd9jUKyE53QIannwOw12D2LpogSzmoZSYYC1zsFvpvkIxj8zx9jAZ25Tblexb4/VDU/F/VqFQ8TJx7e8fMF9/6yyH4mh6PO7Sr617MSlsx8YueUqQVhHx32YT3Cm+FGFLnyMefokIbNq62Z8FUDz7mTOP3Cby3B0bhERbEi60=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5200.namprd12.prod.outlook.com (2603:10b6:5:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 16:29:48 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 16:29:48 +0000
Subject: Re: [PATCH -v2] x86/Kconfig: Do not enable
 AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT automatically
To:     Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de>
 <YWQ3963xcO3xbFo5@zn.tnic> <87d93314-ba3e-464f-d051-84a8de674b06@amd.com>
 <139ed784-d622-b0d2-3650-736b42e624f0@molgen.mpg.de>
 <be2b3cca-9822-4bb7-12b4-4c5c89318625@amd.com>
 <8b21ebbd-f7ca-8af3-5398-8320c6ed6422@molgen.mpg.de>
 <CADnq5_OLaFFuK-LaEw+aXdbJcXa0pEUEBJaCbaeuOxVbEat_oA@mail.gmail.com>
 <YWRgN63FOrQGO8jS@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <414740f6-a1fd-08fb-95a4-e37286734355@amd.com>
Date:   Mon, 11 Oct 2021 11:29:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YWRgN63FOrQGO8jS@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:f2::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SN7PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 16:29:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e71855f-28d6-44e6-29d5-08d98cd457de
X-MS-TrafficTypeDiagnostic: DM4PR12MB5200:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5200836677144051114B16F9ECB59@DM4PR12MB5200.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVss9d8QhIvMRZACFHsv/IAGPsb0c+czzyN27tnvWfg3EZFDYGhw1fUGfQQR00vtY7zEOXm/sTpJ35vB0dj5q+hQd7xErw4WTbwzCIBioCo+WpTaSoWrgKw8XV8+XhFDf4Dpxc8ptp5gpnQJex/9rm89B17p8r8NvLEm7H5qstB9DJGDVd/nTTq/XajztZ+imxqLpUME94K6qwSooWPvFnwCD2Tyss9LN7b9Wr91F/o7Pbnpp6s83KXzNvPlH2IQn74AGU5yjs8MpRn/QdWydmibnO2vw+Jb37RaUbs+YqvflMljMEG/jHPqbpu8P6nLXckDEH7ZV9jaD8EyQfXxmuGQN8IqRt45LVGPXAAODdo9xA4HBLYLo6Fw37C9Bt6724HplOCWolszrM+EFNl+qXanbUSFC5Uhj3T6GHtkkS7pDiqgI+BUH+V6t5YenTMqLI9M715XLuRYkeh9lJKyIUcFallqGo7iJo+LiLZNG5Sg5jcktQCG3DA33Z5old+yWYkMwwu3Ezzz/uJOHqUAWn23XNPjuvoTCy7awYlAufSWKhqlJM82qiwx7LiL9CshUvPX76GZkcljPd+lCNJ7GiCuaVsWOSZ8vVhH4UayTVc6iLkbQHP5nx+nw6fs3n5zuyFwQrBPIfZ10L9Ma9lHSuZy2imGA1aQL092pczWsd/RCrXYHjl92LlsNDBBGU3O0cLf189h/mpC67M1FWbz0mUVULqFGlKLqClfGq3gj9p09ckGZqpM+cp4cW72/+zFwCyw7i8Q5bymgA09oqCziNBKsyXB5t8DLPvddibeZyuAQ/lV/8rIVqRQn842A9bQlrbyRc+GSlhqSjonCtGOPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(86362001)(8676002)(66556008)(66476007)(2906002)(4326008)(53546011)(36756003)(966005)(186003)(7416002)(6486002)(31696002)(31686004)(8936002)(5660300002)(508600001)(38100700002)(2616005)(26005)(45080400002)(16576012)(83380400001)(110136005)(956004)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHhIRXA3cnpUZGFlYTBEQkFMVWI4eEJza1ZqVkEwQ2dvelNOQVFJZUJveHBH?=
 =?utf-8?B?VjhLOXFxVmZwSDNsb2w2Mm1xclNZRlRmTkhDWnc4dXdTNFBwMGF5REh4R0tE?=
 =?utf-8?B?MzMwSnFxUEd1d2diclpZL2R0bTk2TExhWlZ3TFVrcEFlbU9HUnAvS1V3Mzhx?=
 =?utf-8?B?NUhkbjdpcVl2RzQ2SVdiNTFDd3hnTVFJdkpLY2RJZE5RSzhrSjFOQ01iVmhp?=
 =?utf-8?B?YU9XaTBuS08zVzJyVVN5QUd3SHpYV2tSNkZNdUJzRG13UzdSVFh5MFpyZ2JL?=
 =?utf-8?B?SlpuYWR2YTFiTmpnbDhvN2tUeEFhTjcxTVRuRlBUdjlGdGU2YURtODRMdkpH?=
 =?utf-8?B?WWpBU2ticEpVWVNVZzcvNFhjK29OcXhETmIwV3pnQkwrTGhib0tRQldzanU2?=
 =?utf-8?B?SE5hZ3BzNXp1TjYxeVZYNzRVVFV0bzlxY2x6czJPdlJKN2dic0FDSEFCZDFz?=
 =?utf-8?B?M3FzK2NiY0FnN2FacUpwQUp0ODNWZHhXOWUzZkl4VTBQenJqOFZmYmoyNDMr?=
 =?utf-8?B?RzZybVNJZW15YWdLaVAzTjZ6R1lkVURXMW9BdVlIV3o5b2FzZHhaMkx6WWVq?=
 =?utf-8?B?MnJwTVF3ZWFLTkZOejFBdmROeXlXOC92Mm1UeE96dzcrZDMyUHphS05xczF2?=
 =?utf-8?B?R3hIemFyUXlUQmx5cVliZ1lrell4LzE1ZEdOU3lKWFNmZWsxb3dndjBnR0lK?=
 =?utf-8?B?ckF6UjZvR0dtS3FHZHEyYlZDOXZkeXozc1FzWlp5RW5qVUxRTXFkWXJmNngx?=
 =?utf-8?B?cmhtM0M3amxBb29kaUYzSTVXMFc3WGhKNnhIaDcrTzQzRGFhZ0xmVXVCRGdG?=
 =?utf-8?B?OVFYbzR3WVhaeU5ycmQwM1dTTjZQSis4TWVUaFB0bVNmcmVCaUQ0cFBXM2lK?=
 =?utf-8?B?WnJTN2dxL1RpZXlPRWNIOStuck00TUtvNDFVUmV5UFErZXlVMlZ3YnAyNFpv?=
 =?utf-8?B?OEJHcjNxNHQ4OEpyZTFUNU1aTG9ta0JkSFA2VkpMMmFvbDZPUjAybE04dG9R?=
 =?utf-8?B?Y3k2WlRJczlBQTNQQUhWSS9aRGs1cksxdnJRYUVkT2wrZW1wOXRQODluZFE5?=
 =?utf-8?B?c0Nsdmt6K1BxSFUwbjMvc0ZPazB4UWVZa0MwUDNaMkRGakhNaGE1dkxVVmZl?=
 =?utf-8?B?cUx5dU00SDlrVEN1R29tbUtFU1RjY2FsVzJNNjV0cCtxNXk0ZFU2UHVGUzRF?=
 =?utf-8?B?UDYyNUdRaU9BaDlDZitCTlNzQlNSSHdpdytLWFBDSVZEaFFGT0VrUFlYZndY?=
 =?utf-8?B?Zyt5cW9wTFJWRGpScWx4VlZwZUlnTTFFSnQyOXVIU0dPUVBwZVVxbklGTkpk?=
 =?utf-8?B?aHBQQ1JySUZpMm4zSTBzZ2NMNkNENGovQVdQcGFHd0dkM2tyL0pFVnBGK0N6?=
 =?utf-8?B?ckpwMFZMcS9COEE5L3d4NlJmWHRRVHJlRDRIN0VUNmYrNmgzdHk5VVhydHUy?=
 =?utf-8?B?WW9xbTRPMVJzNHhBdVZvYXhyVG9LaVdGL0hBM1FsVG9JVE5uclNTUElNVG9v?=
 =?utf-8?B?S1ZHZUJYa0FQeXpvd3ZZNmVscThLcmhOR1dYejk2aHRlM1R2eDRjelluODVS?=
 =?utf-8?B?c3FmeVV0SHFreDlXUGpPUVJ4MkVQY1Q5M1FNYU0rYnVRVGwzM1FIZjJLY0xq?=
 =?utf-8?B?aWpCY2Qvb3NzQXJ1R1BPeW5TWjRhMlF4b1hoR0lVbFlXSUpiVnU2UkpEZDZS?=
 =?utf-8?B?VXhlVGZiNVRTV1ZadVdxQ0dvTERpeW93UFE4endLemQ0MGNJOG0vaHJCOUQv?=
 =?utf-8?Q?0RjQE5Ovyb4hB3LAYWf6EFSQy5t+ud/aCZKCXsV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e71855f-28d6-44e6-29d5-08d98cd457de
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 16:29:48.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkawT21Lc6pd5SnpdFYkJmIZbJoYcZP9BXUzx6jC98ufW2ZLDZ4GqwQIaw5CyB9Gbby069fOLi6m/3lDTRib9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5200
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 11:03 AM, Borislav Petkov wrote:
> Ok,
> 
> here's v2, I've added "however" number 3 below which should summarize
> Christian's note about coherent and concurrent use of memory by the GPU
> and CPU, which obviously cannot work with bounce buffers.
> 
> I'll send it to Linus next week if there are no more complaints.
> 
> Thx.
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> 
> This Kconfig option was added initially so that memory encryption is
> enabled by default on machines which support it.
> 
> However, devices which have DMA masks that are less than the bit
> position of the encryption bit, aka C-bit, require the use of an IOMMU
> or the use of SWIOTLB.
> 
> If the IOMMU is disabled or in passthrough mode, the kernel would switch
> to SWIOTLB bounce-buffering for those transfers.
> 
> In order to avoid that,
> 
>    2cc13bb4f59f ("iommu: Disable passthrough mode when SME is active")
> 
> disables the default IOMMU passthrough mode so that devices for which the
> default 256K DMA is insufficient, can use the IOMMU instead.
> 
> However 2, there are cases where the IOMMU is disabled in the BIOS, etc.
> (think the usual hardware folk "oops, I dropped the ball there" cases) or a
> driver doesn't properly use the DMA APIs or a device has a firmware or
> hardware bug, e.g.:
> 
>    ea68573d408f ("drm/amdgpu: Fail to load on RAVEN if SME is active")
> 
> However 3, in the above GPU use case, there are APIs like Vulkan and
> some OpenGL/OpenCL extensions which are under the assumption that
> user-allocated memory can be passed in to the kernel driver and both the
> GPU and CPU can do coherent and concurrent access to the same memory.
> That cannot work with SWIOTLB bounce buffers, of course.
> 
> So, in order for those devices to function, drop the "default y" for the
> SME by default active option so that users who want to have SME enabled,
> will need to either enable it in their config or use "mem_encrypt=on" on
> the kernel command line.
> 
>   [ tlendacky: Generalize commit message. ]
> 
> Fixes: 7744ccdbc16f ("x86/mm: Add Secure Memory Encryption (SME) support")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> Cc: <stable@vger.kernel.org>
> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F8bbacd0e-4580-3194-19d2-a0ecad7df09c%40molgen.mpg.de&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7Cf9321f8ec7ba426182f908d98cd09ef0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637695649962742668%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=TybLSD8uU84WT4%2BRQbdL4unTJMQm5gDH4ykXaG8Dg1s%3D&amp;reserved=0
> ---
>   arch/x86/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index bd70e8a39fbf..d9830e7e1060 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1525,7 +1525,6 @@ config AMD_MEM_ENCRYPT
>   
>   config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
>   	bool "Activate AMD Secure Memory Encryption (SME) by default"
> -	default y
>   	depends on AMD_MEM_ENCRYPT
>   	help
>   	  Say yes to have system memory encrypted by default if running on
> 
