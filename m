Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A846424917
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 23:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbhJFVlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 17:41:20 -0400
Received: from mail-bn7nam10on2063.outbound.protection.outlook.com ([40.107.92.63]:28544
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229464AbhJFVlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 17:41:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LX+LN72BPZNU6QXQ8BrS9CyFjcqq+Y1Yfv0B1bOaA5Ya678FKXarHPwwipMyjRyOdJ1u4U6Iv5s+N+jXLbEDnqyeImBzaaMVTjkOcCNmav4zQH9bfmFYHJHA22xknIUbKXOhFDNRuOTlOU+xb9+bI+a6N9oRT1WCLGIUTYNNF31gZcBRteqN76dKXJrRmHq9sw8JIjeTkKaACsHcNyrfdmW5C3TXAW85Fqc3tFOZlgP95V44zgj+0NwekMLkHjAPQ1awFocrTUhkqV38cyYXKC6hamqHTZenoLv48Fj23eBEjiQvBFZcN4Dk0IrEpvE+SXzBpCyqHWoIYNzV1UInAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWcALdtkamateGT+yGPENyC6CiuNGNku63C4KtZXWLA=;
 b=YdXCgXL+Z5jY4/NzBpfnrGxq72k3Jy5oQU6m13pEqE4FmeNhAwo7gYl29EdS62WpbpxNHhFUB61bsj8zwiCAVIpcEDfdgNh7S9lJFSVPYzw4xZNBWDWRDnPhtz4GqQs7evCVza8wQ0rROtdDG33VqSvjEAdeeUqQdkY/3YkLp5YyOi77pNpwbHzpNHa/I/3mwRUco1XjTZNSbx7Ex5DmuDOcOmrR54QInGREiIEZlq9sTZ5+YRJO2PRFPrzZu0JzDdxFIrj73LqCg38lRx0VHgFN4Jg/JTtQpk6eWjo8JAKLbkQclPCxaGINJssJctRi69wvPm9CncP7OBeDwS69bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWcALdtkamateGT+yGPENyC6CiuNGNku63C4KtZXWLA=;
 b=073vnK7yZiMUSsYhGXLclavaO8ZPbPJHdzkeso9vB0YLZ/aFhQSLE2+Psl46xm+4ktAkIOQzFT3u1BosQH3HlU4iQht7yZzEzMiOGwdZ2qcqMQgbV4gg1YlGCqV2L5mitWsaMQqQKvn9xCo56jwbBq488jwdymxn1NDDmm0MSL4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 6 Oct
 2021 21:39:24 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 21:39:24 +0000
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
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <CADnq5_NgR7tdyeGOdqHCGRMd9DCTJwcRfBXaZcOQDJbEeypf2A@mail.gmail.com>
 <YV3pQCZ4GYbdpEm5@zn.tnic>
 <CADnq5_O8rTnWH5md1qWauW_3sDTO+qf=vNzPZC1E70NT7Wb99A@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <dfc53444-ff3d-1bb4-2b8a-0041e5d5db8f@amd.com>
Date:   Wed, 6 Oct 2021 16:39:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CADnq5_O8rTnWH5md1qWauW_3sDTO+qf=vNzPZC1E70NT7Wb99A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:806:122::26) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SN7PR04CA0111.namprd04.prod.outlook.com (2603:10b6:806:122::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 21:39:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66bc076c-3a3a-4dd0-278b-08d98911c37c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5184:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5184389CF008148A28D1C70FECB09@DM4PR12MB5184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LS/Jc8olCWFDNNjMPqTyRJuz0EvbUqSEtiZLuKAuQ+ZbAtSH1t/EboYCvLyGAZ8eEtDp0YKfsMp4abruVnMHZKouGhrNIZ1VmrG4JDgGnhElePmysuxOZtCZtrJM1nPRDwJgQBhb942BVRkSg9uUne5aXEctXMDNb6hU8LiahE3WAcm0eglAv5H4R1CXV7yfB5o7kZFtEK6ADpwVaKMrFrZMM6LFHni66ioB4wYkQW4c9ck2LzZ1VEStErF5TS+WlKXad0l8lqY8BUNzFAbALlm2BfUcZFY2qs9W05S76jyvq2robFWMc4poKlEEnZ4e8CrzcMu6hwe3H2Qt5uBHMZ+weo+2mN/p6kH8Yi+y9C7I2gQDsc8QgUsr1m0sArLNnQf3UbfohBe6jasaiYTYsrH0jWf80CpmN2FQB5p0mrtzN9CmP4qDjltF3pgHUuqSHvIA0G4KkBZ+YizeVtX3ajUo411erQZ1yZh4OTo8oplIlW9f3+UYVcHaTX84RwmiuEFfnmwgqL7WBJxisnyXX+RAJRdNI/uh6gC69UMJtdYkgAHKLvjc5YPBNJwhMK+QxEoq4Lv9h5JsZPkjVIKFwm29+c5ofnvfdOmvjRA2o9UjYLghflyaYIXVIPHtIK+HdvaRcQLXubS19IPoGU5siSSwdvb0JjyKavqy4nSnZx7kcWP+BUscnLJYbEfy9ELhpH8DcOU2qjcXz7IN+Aw0/3Xk+M1tRhOvmr9TSxrmdhA9FRLpTSwVkLlYFs2kD4aDx++nud1j76wEUZTvtt05CigKoaAoGjB6eJSL/qb56yxuT+6o6+kwgH8zGAx/YIxRg4aaRf0b32H7ecuudAqluK5Gtvw8Lcb2lSzaWPTlVQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(38100700002)(66556008)(66476007)(31686004)(66946007)(16576012)(86362001)(54906003)(36756003)(4326008)(2906002)(2616005)(110136005)(956004)(26005)(316002)(186003)(45080400002)(966005)(5660300002)(6486002)(7416002)(508600001)(53546011)(8676002)(8936002)(81973001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXRnMlJvZkdGek52M1dZMGlla0JpYVUxNVR6dzZaQlRueStmUFNwT0hZQ1hp?=
 =?utf-8?B?RTVsdm1JKzRLQ0NIRmdsSWhqY1V4azRNb2RNQmRiM0lqTnBITUx6RktyUTJI?=
 =?utf-8?B?VkJGUW1jMlN6dWhheUpKbnFtcm9PMWNhT2RLcXV6WGw4cDZWODZvdDgxRkVS?=
 =?utf-8?B?dHd5Z25PRDkvcHQ1akVJenZyTmE5dTdRNUppQ0xXUmxmQ2tNeVV0cGxYeWlp?=
 =?utf-8?B?MjNEUE50RTZnM3Qxc2dDZlp6dGtmYkM2elRsVkZkbzNvUEpUTlZHdjNPQmJR?=
 =?utf-8?B?SE05R085UkhWVnJkLzY4a1JkVEJ6RHNsaHFLZzZKNjNnUlNNdGJRWWlRdzN4?=
 =?utf-8?B?WVVBSmZUZGJJT3pSZkVJaHEySlhlU2JFdjVLYy9LbldkV2N3bFlZY1dqVE5Q?=
 =?utf-8?B?YTRiRjBrRmk0N2d2SytidU1ORzJXV3d1MFBlSjBoODh5VlQybzZKcGpIbFZu?=
 =?utf-8?B?Nk9XSFNHQVNuNk11eTlQQ255bTRvdDVmRFI1OEN0Tmt4RnN1SWdYVTRhWks1?=
 =?utf-8?B?aDBYaW5NQUg4UUNqc3N6elFjNW9BMkJXdy9uVS9kajRWeC9vNFBVVGdqQ3Bq?=
 =?utf-8?B?NWxkTHpkSERWYVc2SFl3cXJhcXJ1Qlo3UktVaFZranNXWnZseHMyWkZyOERr?=
 =?utf-8?B?YnBFUDFGb082a3MxMUVpRkc1aDRhcEFXZWRSSy83ZkordTBNb2kwQVRtLzRx?=
 =?utf-8?B?U1ZENFJJc1RoVXg0dVIvVTd3blhzZWhxZ1g2djJnOVEyUk4rU2FOOStpOHNh?=
 =?utf-8?B?S0VrMHRlbmU1VzYxdm9QaDVrT1JKYTdVUGVhYkp2eDNXUEU1MlZPQ1ZETXNB?=
 =?utf-8?B?KzZUc2J6NGJSNUxydkRyOTdkRkx3L0lId05QcVpSNGhkVmdNWVByOFdVMXhl?=
 =?utf-8?B?Z1Q1Zk5mOUw0L3RwNGxaeDJyQVlqekp6YWQ2aWxBUG1uanJKSW1Oa3FWcXlk?=
 =?utf-8?B?MjhtWXpOK2N5NE51SnUvOFJ1V0pTT2Qrc1F5eDJNSmZUSUNKOTBPRjVaYXpD?=
 =?utf-8?B?T2pVZ1ROazlZZFkyT2twcDBUVDhnOHhEaGtCSU5ROXV3elM1OWd0MWtuUTZx?=
 =?utf-8?B?cEpxRWlTTHNLOERXRHlrUldHTjdNRDlyZ0ozTlRYNWNEY3hvTDBQN082aWYx?=
 =?utf-8?B?S0FteVlnVGdySUxxRGpaamFSY2dBMWNNd09zOG9MeGhKZnRKc3RQWFNtWmVW?=
 =?utf-8?B?YXJuRFBSWkUvSTZ0L2RzUHh3R2hOcC9SNTJSWnJ4S0luZWVpQXFjQlBZckU1?=
 =?utf-8?B?ZzViR2x0ZXpiMGYreGkwN3BCSzliN0pTNEFHeE9WWDJ0di9TdC9YUm9yRHJU?=
 =?utf-8?B?R3psMHNDNDN0aVNUOXBJZzdwWGJ6dWJaUjB1MnJ5b3ZKeFdGRTBaN1pRRG8z?=
 =?utf-8?B?eXozc3dDVGdmemNWSCthVVg1ZERnZm52bzJaR2k4Q2ZSSHJIYXJjaU1pWkFQ?=
 =?utf-8?B?QURrTm5meFJRdE5Cdnhjb2tZemxodVFoUGNIUHc0NFk3MHlWU2VXcjU2eVQ1?=
 =?utf-8?B?SmNSaElWK2tob2t6Tk8xQmVFVjVweTZzaUpvWmgxWlFlOXFxblUyYWMvNlF0?=
 =?utf-8?B?R1pWS2haSTI3b3BqK1ZkcWM5VGlPTitpRnVUS012bnBDeEVyR2ZQZGhLUTlT?=
 =?utf-8?B?MlBmRTN0cnVRV3dwdlMxME16eTBmSXh2dE03ZEN1aGZZZklyUkgyUDdKZmlT?=
 =?utf-8?B?dVV5bDlML0tHWk1nRTB5aGR0WDNJR29FZEVoeitFdk1PU0VybVBHdndNZW9r?=
 =?utf-8?Q?o55c0wfXg+WxBYdlshqODsCRpIRYRfnO7as0h+g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bc076c-3a3a-4dd0-278b-08d98911c37c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 21:39:23.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKmVzZf+bYejX5BB+dP1QXe2BAt3eXDqhqAd+K4DioZ3kxg9sD+6foKAjw/w6Eo0WKyTq/k6X2bhy62vCMrCAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 1:36 PM, Alex Deucher wrote:
> On Wed, Oct 6, 2021 at 2:21 PM Borislav Petkov <bp@alien8.de> wrote:
>> On Wed, Oct 06, 2021 at 02:10:30PM -0400, Alex Deucher wrote:

> 
>  From the x86 model and family info?  I think Raven has different
> families from other Zen based CPUs.
> 
>> And even if we do, that's still not accurate enough - we wanna know
>> whether the IOMMU works.
> 
> Right.
> 
>>
>> So I guess we're all left to the user to decide. But I'm always open
>> to suggestions for solving things in sw and not requiring any user
>> interaction.
> 
> @Tom Lendacky Any ideas?

I think user decision is probably going to be best. We have to enable and 
encrypt the kernel for SME very early in boot, that, short of 
family/model/stepping checks, there's not a lot that we can do.

Thanks,
Tom

> 
> Alex
> 
>>
>>> Other than these comments, looks fine to me.
>>
>> Thx.
>>
>> --
>> Regards/Gruss,
>>      Boris.
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CThomas.Lendacky%40amd.com%7C88c625e0b5684c2df98708d988f84d26%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637691422304849477%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=47jfRaCMn16Ii7xGLXQ31RRdr7Iz%2BG52zU7u%2B3YEM2g%3D&amp;reserved=0
