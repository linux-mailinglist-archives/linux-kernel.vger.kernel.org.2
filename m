Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979CE3587A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhDHO5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:57:04 -0400
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:33729
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231679AbhDHO5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:57:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS0rIPNr+E8dabZSnjZP/UlRYlE+dSwCcL+8/y1HDmmCllYHB0B1NyRxU81RLEv72rar1etDy2Zzz4Dk9PEhN447osN+MEfgSd5u4DV0/XJSbPGKcElRUvOTlmswK7mqq4WlX6648vFROeZ9LpLtN1mMM3LzuJb7idx6cse81r7PUL2AwPn3c4WmkttQw9SJtkYlVuEelXOO1adXAxpQWP9pqafyf8agJCEOL1tMLMWBq+Z9XRRuAsZYNR409QTHeYla0tT0wFG+N7+no2fOo7cRZayk5uu1JYLIBEu12nhgS014uywX1Zqo+rrpZD4uQs/ffH9Yi61RDqBBqznJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDs/OM4e04jXdpIZPcNtMlQNYyvlXO+dsjUBe8U3G7s=;
 b=YRwXN0126AGrmWKtYPT4mUKOnV6HFIZFmzENuMOuTYG5neCn94IPiPSfKqfmiA+yVHkotuu1vfAfrSlViDQj4xk2ejyg0AXlZCTVY0xGXxWYF28XOq2eP+ojfRt1PVUC1XB9+QR2yB4WHMXhKv0Y/tpJR/PPmEMEoIrH+FTiGQbjuohu2QL072q+9MnG82zOY8+ndGjEE2xzRg3ubZIqcTvmA/GPdfir4m1nc5B6VxW1OGOj0Q6SWp9aU9gqXwKP5OyNGT4O1g8T/rTyDwT3gkg8j3MwWmFLxnEaZmiQGp58f/JkL/ZBXGJLtR6krz+9l0uZWosLuipT3Ud21D534A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDs/OM4e04jXdpIZPcNtMlQNYyvlXO+dsjUBe8U3G7s=;
 b=P47m+4sq/c6YTqemsttqwXg/+z05GogbrmfZ0gOeeybjiKz+MVU3jzL54TYwBLQxScp4STzEk8yWzTW22NvJAVzryqewU8OmS0BQMOrXyio6+JlUaq+wM4TYCSvZU0wP7jFRXUB6NpAmoBQKipSGgAgfXT2Kd2FFqQE5QPh0AwA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB3788.namprd12.prod.outlook.com (2603:10b6:5:1c5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Thu, 8 Apr 2021 14:56:50 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 14:56:50 +0000
Subject: Re: [PATCH 0/5] Introduce support for PSF mitigation
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210406155004.230790-1-rsaripal@amd.com>
 <20210407223905.5dqgzdaibvgq7jeq@treble>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <e72bc628-111f-5e3a-bb79-7e77c9fe0424@amd.com>
Date:   Thu, 8 Apr 2021 09:56:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210407223905.5dqgzdaibvgq7jeq@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SN6PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:805:ca::20) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.231] (165.204.78.25) by SN6PR16CA0043.namprd16.prod.outlook.com (2603:10b6:805:ca::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 14:56:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf0a0b3b-c400-450a-649b-08d8fa9e8a37
X-MS-TrafficTypeDiagnostic: DM6PR12MB3788:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37881861E2719938399894E29B749@DM6PR12MB3788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jx2Wu3yqVFQTFWeRi3lo72MuTmbrri7BfozaJ7FyGpim/Dz2jl0lsnwtqTvF86iokMS4E5q0HvaRoSkDm85wb9KqDrb/HZzPUbVZaf/yFTJcTje7HwqM3UDFcH74Sl6lGJL3Z7N7+Y/RIT9JODCa04sEeqg966E27g7LfW3aZz1yN9NhuMFSMerZTcVS14X2yjKddJ/v1fjNoCxPFuQR2OAF/vRr4UO6a1y83L0gePXCxiWSCT3J0bdJjQ6ILE2FppfgSgAhxmFosqBJR5Ls42xW4DUvpU47w0l+yt1MGdN1rDu/so6Ux0N4U/GfcrjnGoI3jymfrA/swS+S1h9Zznj+FI1e5v3JvS9Gs5YmSqCpPjKxbFyZkysn3FQwJx061B83Qf8Qdq18QJqy99zXXuuzlLx47z87QSKCgfqYnLLZDEaCIpSh7sXnai8Xmrq+8Qggi/bN7nMCfR/oNhqanLRY+bpwMYmLdzlMnGMXpeZiDQhTBvl82Agr/r7X1KQLtVbeUdU9xNtiWiOXpF/YxXzLfnjIaii9r8t1Q7IaLObWrnBvMwBqY5yn/D0Aj1JOOLHGt90lprXDzbUSIS/2C5vhenOn0W+Le9j+6nPtguFRwe1VA4dbeqk22T3kWkyWxFA9981gSn0MqO62KAd4aYowLpLJTVfQFCMHz13Ds0Z8WXNkPrp57bnjgEp0UDM9sGsyHeyn3YOD9vmWpnyOJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(8676002)(31686004)(8936002)(186003)(6916009)(478600001)(83380400001)(31696002)(36756003)(16576012)(16526019)(38100700001)(53546011)(66476007)(66556008)(956004)(26005)(6486002)(2906002)(2616005)(316002)(4326008)(5660300002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?elBSSC80KzNJWVRzdTlZSm56WklJRUd1d1lpWktDSnZyMUEzYnJkeExNTUN6?=
 =?utf-8?B?cjR1ZGFtZExvNU8reFBsRVd0VjdkVDFZejg1Uzc5Y3ErQVo2RU5GQnlzM0Y4?=
 =?utf-8?B?SGllZ0Qxa01rYTFSOW5mOVdOdGtXM0JPWk9NMkZRN21DYTArdlFuYUpXZHJH?=
 =?utf-8?B?ZjN4UkVkMzdBdDNDRHdEazI1MnNOVGFRVW5sajV1YnhvNkFXNnVkVC90ZmRF?=
 =?utf-8?B?eHl1T0FVMjNmK1hrTmZCVldKS3prcnNSdmN4b3ZLL25UMnN3eXF5L2hSOVU4?=
 =?utf-8?B?T0xJQUtaYlRBTGpRcXFlM0dKTWQ2K0xHcG16N0IyWEU5OEl0Ti8rZnJkRFoy?=
 =?utf-8?B?YVB3eGJ5bzVmTEh0OENGUUozK2k1RmpSZHBRK3pzdWpSQzJuNmxvbElKaUc0?=
 =?utf-8?B?alB5U3htZFVRNkQ1SGRaRmxVenBmaThEMHpUc3hFd2l3OUNTTDdCRWpkMkR2?=
 =?utf-8?B?OXhXeVB0MWJrZXF6ZVpjcllIcFQ4OUhmRXZOTE9mSHpqd0orYlhvcEZxZ3RV?=
 =?utf-8?B?b3RMZXlXV0ZnS1c5U2JsSm9Ha3RCZ01yV2RLS2R3WHlZbkRqemV5b2Zxb1VU?=
 =?utf-8?B?Y1JuUGw1QmZXa1ZISlBadHFjUldCOWFrdTJkM1VvQXFzZUQrRlJDbDFtb2V3?=
 =?utf-8?B?eDlZRk5ZaFNaWnhHOUZyc0Vxem9qdVhpM3lQU0FxUXA0NTEwY3JRK3l2eVNr?=
 =?utf-8?B?anZrR2ttOCs0UlUxalpsaDNZU1pObkZsNjJkUnBrYXROcXhsOTZVV3BEWUJx?=
 =?utf-8?B?cHU1eEJMUDZCTS9YWDVkZW5na0hwTGhDM2ZOUk5zWUttYjgzMmthVGFaSmlL?=
 =?utf-8?B?dmw4dG12RmtyNGlINlQ3d0Q5cXE1RFAxVkp0RnJFWXFmQ3dpcitmblJOdnli?=
 =?utf-8?B?ZFUvbzEzYWJzNEdsS1RwYVdtbW1BcVVXUFg1U29VZ0J1b0JsYjBZRHBOSkc0?=
 =?utf-8?B?SjR0U29mNExDVUpBN1luanNWc3hNODl1bWFtOGxPUm02cXorejBRSHBxM0tR?=
 =?utf-8?B?d3NhUTgya25MMGYrMU1mcVl4RVJCOEp2d2w2WTBlZlZxc3BtbHkvM3VUcmQ5?=
 =?utf-8?B?emdYSjFxL0hhRjdXN1B4WitxME5HVWk1ek9vKzZlTXpUengvSHJMdG1ZNFpG?=
 =?utf-8?B?WGlCcElKWWVFUllZNi8zL2JZZTkzS3lUSmJGeWVpK0RJaW5jVVJVOG1GbWlM?=
 =?utf-8?B?azh4bU52R25YeVB4UmVBOSttTFlRS1pRZ0FsSEQ1WXV3NHlRdDdBalBSMFln?=
 =?utf-8?B?YkhtdXpxMi9KeEtHeFE2ai9FSVFoajE2UzVqeDMzU2tDMHJLNXNkcmtpT1Bv?=
 =?utf-8?B?SDE1U2FNaXJSbktKN0Y0bVo0REdXRW5jV1BweFlFaGpsVWpIVXIzMXd2QmJr?=
 =?utf-8?B?RTdENnhJZTFjd2pjQ25DdDRGOWtzY3VTeDcyc1lYRnRxSEdaZHU4azdCT0RC?=
 =?utf-8?B?bUIrZkFSbkxzZm5meFFna0pORzNrN3NmdmFTQXBBTE5qeWI0Sy9XL1RFb0w0?=
 =?utf-8?B?dys4STFWYXFzQnNPaTJ4aTVxQ1FScWNXU1lwOWxIOHVrZ3dmWGhrbmNSblEv?=
 =?utf-8?B?MjJOZVBuNVBVTkxrWmY4ZHhzM3grQkpsWEorbDZNTmE2anNubnpjYS95QzVq?=
 =?utf-8?B?R0V2Q05ZZGtpU1IrYUdpTWYxenMxSm5jL1RQRFpPcHVicVA3NzM5SFRFUS9a?=
 =?utf-8?B?NS8yVTFxWjJNcng5eEZBbjdMWGk5VHc0aEI4em1NV3lUV2ZJZWh0a0gySzdJ?=
 =?utf-8?Q?0jo17AnIq3eKXiKyFQsBHGDwuB6lyzFhacK8KbE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0a0b3b-c400-450a-649b-08d8fa9e8a37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 14:56:50.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIg9Gm6oMdhjyzK7t2fjzq+O2c4BGvhuBeLTZtb+wd29cdv7CVn4odhDWNUl+sM0osuI/JnIXWokSL+5Rta41A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3788
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh, thank you for taking the time to review the patches.

On 4/7/2021 5:39 PM, Josh Poimboeuf wrote:
> On Tue, Apr 06, 2021 at 10:49:59AM -0500, Ramakrishna Saripalli wrote:
>> Because PSF speculation is limited to the current program context,
>> the impact of bad PSF speculation is very similar to that of
>> Speculative Store Bypass (Spectre v4)
>>
>> Predictive Store Forwarding controls:
>> There are two hardware control bits which influence the PSF feature:
>> - MSR 48h bit 2 – Speculative Store Bypass (SSBD)
>> - MSR 48h bit 7 – Predictive Store Forwarding Disable (PSFD)
>>
>> The PSF feature is disabled if either of these bits are set.  These bits
>> are controllable on a per-thread basis in an SMT system. By default, both
>> SSBD and PSFD are 0 meaning that the speculation features are enabled.
>>
>> While the SSBD bit disables PSF and speculative store bypass, PSFD only
>> disables PSF.
>>
>> PSFD may be desirable for software which is concerned with the
>> speculative behavior of PSF but desires a smaller performance impact than
>> setting SSBD.
> 
> Hi Ramakrishna,
> 
> Is there a realistic scenario where an application would want to disable
> PSF, but not disable SSB?

It is possible most applications have been reviewed and scrubbed for SSB-type attacks but PSF-type issues may not have been looked at yet.
This may be one of the cases where SSB is enabled but PSF is disabled until the application(s) are scrubbed for the same.

In certain cases, disabling PSF may have less impact performance-wise than disabling SSB.


> 
> Maybe I'm missing something, but I'd presume an application would either
> care about this class of attacks, or not.
> 
