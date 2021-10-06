Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA85F423FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhJFODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:03:54 -0400
Received: from mail-mw2nam08on2082.outbound.protection.outlook.com ([40.107.101.82]:45920
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231403AbhJFODx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:03:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2U8S11DAVcG6s6p0Eox/odQSvWY1cCZPg9+Q4M3RHaxhYC3CRk8sc/xsr6Ze8Tjalq3VT+Bbci3ce/c/yOllDjEIBHF2JuCZR4yby/W5SQUjMQBW5hzGH3v0+PtzCCoGKntTSyQ7LPYahJcVhqCQXURE+GLBvqkdfdI8Ma6wocrWwV05dBLpXOStDSWjzX4aAC85hnj3pgdGOXFLoo9gfFh/51lXvO7hwlhV3dJeXLarbUgHTfSuGlGPu2tme/xEwBKZ7feWvGv4nruBrWLZyEduJ+Oqa0Kcu5k+QQiw0QCX8wH26UXLk0FaILjCL3uxWRy9tR7DqlFCrmFDZ9row==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj3tnp0VRvr/gjwnAbWvkuwtSQEe8zeL37/eP2eLc+E=;
 b=eodtBMXR3FlfqtnxqkUrq+p2WVM1MaBUP1azirtGJ3XJ7NmA0kWleqk2a0Ch7sCKgAXtFUZwJVAdpyqKAea+iAYXD7DN886sax9nDgMtILoPCEacayidpsPkjKPRfI7JDu03v4frCL8yp4ApIBz9lY967LJM0G4c2L43JUVi1nm2vX3xBq41kNnPiweFw6vjcTjAzmKzkpTfgkEBcJHv7hKbGRv7KXHf0iZCeHiKw5pc6/uXOER7ElPjjGzJ+Pv/8MsXnqVUaw2lVyyUk797IZ54PzLHpHRIsNQyc2vLcn5vz+USy2R3LTV6UI00c+aYd0HLMbWIGp1V9dP747NUOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj3tnp0VRvr/gjwnAbWvkuwtSQEe8zeL37/eP2eLc+E=;
 b=KOf5thvTeNn3skmg/sldx7q2HieRaGXdzXSoxVLZaZMtXniqGJ5D1QInlXoe/7xODgJd9BqB+BMIcc43KqrGQy7cwPMLAb9pF/eylhqOY55GUClfqJgYwN5csNpTUGy47HsyWNcb/VqdXyrX4PzZ5es8+Xa1CWP1BISD6axMNHU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5134.namprd12.prod.outlook.com (2603:10b6:5:391::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 6 Oct
 2021 14:01:59 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 14:01:59 +0000
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To:     Alex Deucher <alexdeucher@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com>
Date:   Wed, 6 Oct 2021 09:01:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:805:ca::39) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SN6PR16CA0062.namprd16.prod.outlook.com (2603:10b6:805:ca::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Wed, 6 Oct 2021 14:01:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb7c588e-a671-4223-d063-08d988d1dd29
X-MS-TrafficTypeDiagnostic: DM4PR12MB5134:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5134BC645FEEC7CD7191BC73ECB09@DM4PR12MB5134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEyLFA6ZXN+SUZJLitp+4dtdOr4pA0WF83FoHE6rl6ik/Ex67yqy5Kmv7kPGCUGs1n9Fxtq1ZJsqswydHX/1dKXxuNXYU12Zk7MRgArybQTvXW2fGGrV9MztqJouR76XxKyVKx3dVUBAHXu9nqqU5XbTbxD7cImgVjdUVGtkwtiHfGAYOjhr18j0c+VcZQXNeuikLANw0C8id9M1cfggTOuG+6U/YE8bnbyKVrgdZAAr42vjPIZdI7gvvYF9kq04TwnftUeiThf4+eXHHe6hlU/nACGV+a3vns8M5AXohIVi21DMmd7wpfY2Y8iIcFCn9Jq4WZ3UdBzT+eupdqpXYV5ha6dCEmyReFy0ts5m/ftiZYJTyh4c0C9sGgST+YeSUwAN/d16Ua40kPmRynHKQlC5m15L7qgfHkrLhBdBuAZlrAkBOrH+/OzGvDkLd1cYrTEcBym+qgvVsOwmDu/7fJazLxR1FxOZnOXzClh1K3ZSkwbOttgyO9hc0KoYSrZBXIRxIYqm7j5KZsZ34SnQUzrHlsUAknR3oHkqFSh1ra+Re/5/BRR8wFuh4yxbjwKzzwKUh6HVuVRHj0b1ITUGda2bmUaTjIErfcNoqB81VgI4o/jsaYm8AJwXmuV1p0WaFRfGjHTfg3WxK9TlLxl0ahgrqjE1yM3lkwVhydzWYc2cG+h5e5zVN3uhAnoqsXocpCDh+BN/WAgm4UR79FOVLD08jBzc8LYH6pMyN+u0O5/aoZzBwAwnEUQ19anGiVRR6FblH15NTNJLKsHlFu4DNRYB4rglA6DEKb5eGRJHQYTLQm92ZnoIIi7fk/rBkOv/kbkcFNi2u2OEKcTKcfbPHQ8pj7vKEbzi6MRvNtW1Umc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(31686004)(8676002)(956004)(2616005)(186003)(8936002)(66476007)(6486002)(53546011)(26005)(5660300002)(66946007)(83380400001)(66556008)(38100700002)(966005)(7416002)(31696002)(508600001)(16576012)(316002)(36756003)(54906003)(110136005)(45080400002)(86362001)(4326008)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NSVjh6eEdVanpJK3lQcU5sMFV6VEpTT3dZOU9mc2NDSmtjdHY0RUdsZklN?=
 =?utf-8?B?dmdoT3VNUE9adDFUbmVBdExCbjdJWFdvV1hDbXdJc1NKT25JT20yU3V2eHFU?=
 =?utf-8?B?eE5JT3grb1FvVFVSN1VHMmRaSHhBWjNSSEpKRkc5aGdKK3dpeTdDTG02b29W?=
 =?utf-8?B?RDFiVjRrVzIzb2JjbUFCcjJ3UkJKOHdnN2kzRjk5OGdLMitIdEJ6d2ROZ2o0?=
 =?utf-8?B?eUI4WWlRc3p6MC85TTBCVW5jOGpPa3Y4eXNQSFltQnp1dnNyazk1ZVFnTGI2?=
 =?utf-8?B?NHk4b05LeDlRRS8rRURjYUNtR0dZbjJQWUhId05sRHdoSWFBRFBQQVlRUFIr?=
 =?utf-8?B?dENnVHlDWWxPZy8zbDlLWElpYzA0cEdFakpkOENZdllWUk1qUC9EaHZCOVFj?=
 =?utf-8?B?bnk2ejF6OXNpNzVTT2hEN0JNOVk4QVBTOEcyVnROUCtaWG9QOGxHT2JIK1or?=
 =?utf-8?B?WC9ocVNld2hxZGVUV2VlWTdhVldTZ2syNVNEa1ZNZmdaT2Y2dGhKc0FuVjRv?=
 =?utf-8?B?dk5DQndoaXNWb2h0TXJHa3BFVWFnMXpRUlZQbUV5V0orTUYzQjNoQXh1bXJB?=
 =?utf-8?B?MERwOWdyWmJqS2N6NDVZandyTXl1ZlZBTzZHTjVGRm9NWDNnY01XZzBYSjZp?=
 =?utf-8?B?RTZLQ0psdE53NkEzcUhSNXlaenlLc1ZSbUxMZTBRMHhKUXQ5OHdqb1Bxd3lH?=
 =?utf-8?B?dkpYL1ZWT29iT0hJREU3QTlQUGpuWnNjbk4razVmYUtrTjBmeitOQzI3Yjky?=
 =?utf-8?B?b252NDd3My9MMnNlR2IyMExlSDBYQWxXL0c0K05XVnVRZE5zQnNPc0Fadklj?=
 =?utf-8?B?OUtzOUMrbk1pQmsvNjErbUVWbnp3K2RXd3N6emRiKzRQUitVSWVRNmtxOVc0?=
 =?utf-8?B?ZERzUTB3WXJRcm1SZXNTRVVXMFBCazB3K1U3d2g5QlFmRU9Ed3VVUEUrRUZm?=
 =?utf-8?B?alNsSCtPMS9LOU1WazBUY3V0bHdBbk9yeXBCQzVHdWdCYS9LOVU4eWkyNkow?=
 =?utf-8?B?NC94QWRYMERSU1J6SlE0RWxsbkkycUpldFM2UE1RNnRyUFBHdXdPaTUvWTRi?=
 =?utf-8?B?UVZlOW94a0NoMGVsMnFxQmF3Y1hkVlhNNVloQXMxbWREYkpSQVZONjdteDFy?=
 =?utf-8?B?QS9NNGZyNmlVRzJieUljT1Jyek03TzA1ZGFSTEd5dkd6OWpwOFRZUDRFb0NT?=
 =?utf-8?B?b04wSGFqTG5JYUF2ai95cDdITHMyQmdORGVlSUJtQWVMUG56TlpLdXlVUWVo?=
 =?utf-8?B?L2NFdW1lRU03MmViWDg2Zkk3eTBEeU1BeTJaZS9oQnE2K2tybytnOGp4UkVa?=
 =?utf-8?B?d2NMUVNJWkNnMGkwVURmVVJDKzFSSzg1KzhhNEZ3WXh2TWVMc2x1cWk3VmUx?=
 =?utf-8?B?aDF3ODhkc2gxRmlReXR1bWZBdjcydjhkT05ZaG5udnp5M3NLeGdmS2pSalpD?=
 =?utf-8?B?T0c2Nzk3aGVHRlVEMHhxZE45MTh4amdNN2VRWGNEd3RVWHJaTlRYNE9UVEg0?=
 =?utf-8?B?ZUJtN0ZGUHRKcWtEWVdGY240RER0L3dwNGpucGZtR2dpdStwQzlGTHlIV1FI?=
 =?utf-8?B?TFZFTDFoOUdUeWd3K0hMWlJFeHo1dmNhRnI1eDlKU1IrcldTSVl5eFlpZTc1?=
 =?utf-8?B?TDJpaGJkR2xIbFN6dDVhenAvNG1vWDFzTTJGSFVGVUNscjFSK0JCM0lQTi9s?=
 =?utf-8?B?QzRiMFNIWkVZaWVaZzJLU3BqWDBBaTlZekV4N0F1eFhqbFpYdXB1cnVUNnhT?=
 =?utf-8?Q?B8GdNPQ3EXVmPYk897FHOm8XlovXjj1iXTo/1xN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7c588e-a671-4223-d063-08d988d1dd29
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 14:01:59.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSm0d/e88BuvDZCAK4wis3tCdJul5cWllg3o0Is8kBZlwhyDMNtMgdG2PK9WmrsEUAvP6HlfRyvmIfpxOr5f9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 8:23 AM, Alex Deucher wrote:
> On Wed, Oct 6, 2021 at 5:42 AM Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Tue, Oct 05, 2021 at 10:48:15AM -0400, Alex Deucher wrote:
>>> It's not incompatible per se, but SEM requires the IOMMU be enabled
>>> because the C bit used for encryption is beyond the dma_mask of most
>>> devices.  If the C bit is not set, the en/decryption for DMA doesn't
>>> occur.  So you need IOMMU to be enabled in remapping mode to use SME
>>> with most devices.  Raven has further requirements in that it requires
>>> IOMMUv2 functionality to support some features which currently uses a
>>> direct mapping in the IOMMU and hence the C bit is not properly
>>> handled.
>>
>> So lemme ask you this: do Raven-containing systems exist out there which
>> don't have IOMMUv2 functionality and which can cause boot failures when
>> SME is enabled in the kernel .config?
> 
> There could be some OEM systems that disable the IOMMU on the platform
> and don't provide a switch in the bios to enable it.  The GPU driver
> will still work in that case, it will just not be able to enable KFD
> support for ROCm compute.  SME won't work for most devices in that
> case however since most devices have a DMA mask too small to handle
> the C bit for encryption.  SME should be dependent on IOMMU being
> enabled.

That's not completely true. If the IOMMU is not enabled (off or in 
passthrough mode), then the DMA api will check the DMA mask and use 
SWIOTLB to bounce the DMA if the device doesn't support DMA at the 
position where the c-bit is located (see force_dma_unencrypted() in 
arch/x86/mm/mem_encrypt.c).

To avoid bounce buffering, though, commit 2cc13bb4f59f was introduced to 
disable passthrough mode when SME is active (unless iommu=pt was 
explicitly specified).

Thanks,
Tom

> 
>>
>> IOW, can we handle this at boot time properly, i.e., disable SME if we
>> detect Raven or IOMMUv2 support is missing?
>>
>> If not, then we really will have to change the default.
> 
> I'm not an SME expert, but I thought that that was already the case.
> We just added the error condition in the GPU driver to prevent the
> driver from loading when the user forced SME on.  IIRC, there were
> users that cared more about SME than graphics support.
> 
> Alex
> 
>>
>> Thx.
>>
>> --
>> Regards/Gruss,
>>      Boris.
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7Cbab2eedbc1704f90f63408d988cc7fb2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637691234178637291%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=xCXc1pcfJiWvKG1DTJKq986Ecid8M7M7K3gvCDWrZL8%3D&amp;reserved=0
