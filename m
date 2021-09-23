Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23EF4164C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242665AbhIWSBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:01:21 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:38721
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242152AbhIWSBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:01:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgEljaS1o3I+i28/K0XhFFF0zuLAMk6IAC0Bf5eKjvWoZDBJ149ieL7TYbCQgxii7/uGPwqNAodIf2wZmX6PoYl5kl2r0C0JyI1X7H1QNYogjxqobMOuAHJD7AE+XRqdzZoXcAcad8aGJBYiifhGYBJX5ArDQ26a40NMugbr4BKapL9kXud/H1i46bmU8GxuHBcQBlATp3JlfgdmXyolYm/AcjqtQytpXQnHQW/Sy5D17URaUI/Spj6ARa7dYOZnJnnEbGBHa8Juex844sk0Vt0Aqe0tt+pbodX33dAwBsQujO2gIvdzbYVX4Yic53HI75seWHaEsC7kqYNhPNTPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=twiJs6F4Jy67UyfQZZtwj0GQ8h5ArUZmxu1vS2Lj7bs=;
 b=T95j0515kJRaoiwO4gGa5dZB4lZonFyoL6nIY/lp5ehCoNalq4bBi1Abrc0zGI0+7sOIvZ+Gdj0ayd1P1DU43nzk6GsCmq+R9yR1gpb9V5OfqWQCcLfjun9OlaUU7yNqkXlj9Swm5yDsL7OjE4FAzl+QqRdrEFPvLbAKvsyymLJXA5PMHyNHpRK/l09YUMwePXu1V6zjX2WJLSc8NNWNtNQYGqDGjE1Hme3YDgolFCOcDqlbglGmRT8H8UBnFDUuxPhL/Pxg67A9uIB9/yVSaqDOlfhtwlCaKQh29He8tQu4e3RfdU0Z64E6cZTcK5AiXKD/Cfzg1VlWMEiAhB4Bxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twiJs6F4Jy67UyfQZZtwj0GQ8h5ArUZmxu1vS2Lj7bs=;
 b=A6KePIDwjdCygZJNtVWKOaydSSxn68uA2THd2NRzUHJz3PhwmHhXK1+sEVFvcJKj9mhcW+yzclLsCntCMbWfqslCHujVKYGy9jPy+V0ZdpeIUl7nmzOKh1FuiF58jjn17q3rbAiufZ4iFCXBNV8VL8+D8h+Q8sn0elIEI5eGj4I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5463.namprd12.prod.outlook.com (2603:10b6:8:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 17:59:46 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 17:59:46 +0000
Subject: Re: [PATCH v6 05/10] x86/tdx: Handle port I/O
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210922225239.3501262-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210922225239.3501262-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <c2fa7839-49d5-3e1c-97c4-c1b77e11ef93@amd.com>
 <6cb4efa4-6f40-37f4-8807-e44b2c069021@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <0f2a09ca-b098-03ba-a166-6f31c718220b@amd.com>
Date:   Thu, 23 Sep 2021 12:59:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <6cb4efa4-6f40-37f4-8807-e44b2c069021@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:806:6f::35) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SA0PR12CA0030.namprd12.prod.outlook.com (2603:10b6:806:6f::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Thu, 23 Sep 2021 17:59:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e8e5f08-f6ed-42af-0e5a-08d97ebbed5a
X-MS-TrafficTypeDiagnostic: DM8PR12MB5463:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5463E3EFF93354FA5ECA44C5ECA39@DM8PR12MB5463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlkQ9ONA21EaYHQy9NNme1NJd1SJFerLZEhYZOjUQwR+LvYo/tdZjmCiV+SPcTphNG4g93ql4F7BzrM59HHq2jfEAgrlEsqLjqRA5/c25t3MWBeuCA6cu9PO9Hae0VLTtNmFjbcDDB+giaD2dKU1hhLLhXPW/eRBTcREkSvPA/bBOzscM5R4mj/h3sjnvQ2ASMD291+Arpyjkb4VlYOdnlwnE7HYGDwCIBhmFK3p6k3D7YW1bXuLOCx8NTHJUBzK3j0+ENqAr6ODXerLEhrQQ9/X4RCdRqhpekAFh4U/5Hudyf4LSB1UTbx4sL8QPmmwQaBm8IxYFgSCjuXFVcZoSUqof+JUD4UC6XQgo/V3wrRNc6ORZ1o75IqgR0cbiF+7jNnXGmWFVEqq/JfIyWsFpR3EtweqEVcFJEUH7I8Oj1v+JZBoHJyuq7lVJgx8cLXjTs87/HD9wzUYMwXzGLEk7fnDmfPfVq1EWJ+c3pfZkOe7erltPet8nkH5ZhvZS8YLtso+UvT/azaOHGH1zFdWJ0p0uj6uityuSCCIP9325vaRq9hx5TbNyHqHIrKv0mbwtoAev4iifW0VQBe8WkwgJkBOUBAnilOK/4iR9T5u64qHiCEsNz70/ZPdz/E8Ap4tQt5SDoc71c4KPl6ruDkQtKband3TZWN1iWWP3D4Wy/Wwy4FdvVvkO07OCPEbyA0Qvu+3RU6Mt+Rm/UAbZAeIB7KlaRS5P8lQsoyP5l5uc9CCebQXgd6ePj21b3KF/LC9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(2616005)(110136005)(54906003)(66946007)(8676002)(66476007)(66556008)(83380400001)(31696002)(2906002)(86362001)(36756003)(186003)(26005)(316002)(8936002)(508600001)(7416002)(5660300002)(6486002)(4326008)(53546011)(16576012)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUtCK3V3Mko5VjJQZDlCbmJ1STd2aTJlN1dIaFErMVlwelJtSGo2b3FibFV2?=
 =?utf-8?B?M2JuSnhYZU5yQUJqWjhkY2ttblc5S3ppVXRuNTd5MFIvK3VMcTZyNWpnSU1V?=
 =?utf-8?B?WXN0d2NjU3BjZEJSdDFHR21qV3BsRTU2WEFLZUo5M21NNTVJMHRMNmQ3YnBx?=
 =?utf-8?B?ZnRndWRkc2JENC8vTklWY2dlTFRmQzRWV1V0NVVIemxLUzlpbFZzSWVyZlYx?=
 =?utf-8?B?R2tqSjlpL2pDSUtieEJVaDVjeXhhSjdQSTlxdlZ3Y1RYMnU4U05ITGlITHlJ?=
 =?utf-8?B?TnQ5aFErR1ZTYjMxR2ZEYlZYa253djUrNWdJN0VBcGx0M1pnYUJmRXdyS2d2?=
 =?utf-8?B?QkI2a005RmdDSUVjajJJT0FFMGx1ZmVGTkdnOWlOemErSzBNKzNMdW1VSTFr?=
 =?utf-8?B?QnppRnNxaUUwaTltWTROeGNvZEM0OEdGTlNKeDhVOE91Z2VscE5uVGRXNjRQ?=
 =?utf-8?B?R3VhcEliUXlmNzBxcUFIMmpPc0hwVHYvbExrVDA5cy9WenJ6SzJwYkNVbUpu?=
 =?utf-8?B?Vkx1MmhUWUdHMit4L1NobmNGei9yMjc1ZHpLRjNDNjZiL2hqeTlrYm0zOFRT?=
 =?utf-8?B?U0NheC9XNmxsbk9YM1JpSlA5ZVplQmp4V0JhOXFJZzFuRmFaT3dLd3R1Z1NC?=
 =?utf-8?B?QVBIeHNPTVNZN205V3ZCL1dBQytRS0RmVVhSaXRFUE1UeUJCV0hPbUpnS0o5?=
 =?utf-8?B?b2NGbFlGUDh0TFRDeTQ1MFBFN09PMFFoYjZGVVJxRVRhakhGaXBUYUhCZGwz?=
 =?utf-8?B?cTFQVXVSRlpYMzUxU3ZLbk5HUVhvZEdXajZQT08zcDU5aWpvNE5jcGxuU1k2?=
 =?utf-8?B?Z1FvdjBVY3hieDhhTkg3ZUNmWkVYTzJQMEVsa2xwZE5PUXh5S3dQUjNQVTMv?=
 =?utf-8?B?L1B0VFM3UHYzZTI3Y2d1Z3YwUnU3UGhnV2xGQ3V6bVBuTWx3Wk9IWHZxYmhT?=
 =?utf-8?B?QVhONzBPdlRHSVZudTlqV0tBUkxxVk5iUjhPY2ZnbXpPcVhueUl4TjVCeXR2?=
 =?utf-8?B?cS9kWVNRa3BzcnNEMExlSzdXbEJISXJaNThDeEVMaDU5WFBxNXZQQnltK0ZF?=
 =?utf-8?B?aEduVEY4eXk3djdEdkx4VThFc3J0R1lFZ00wcE5TREQ2RkJRb1pLQzR5OFJZ?=
 =?utf-8?B?enJrZU5GVVRyUDlhK3RqNGVrQVh5a2NKV1RkSVpYMUhvdFkrRzhianpYeHRq?=
 =?utf-8?B?NVoyY1dseWpuMlhSRXNJOVpsL1FxWnNmTVpFMXg5Um1nK3U1eHk3R2xERUFk?=
 =?utf-8?B?V1dVdnNUOW5SVko5WjJWMFhwUkRzeEVheUZBc0FkTnRKbHBPTm1DcUdOcFhu?=
 =?utf-8?B?LzBRRnBmRkI4UlViRmUrRUd4SVp3ZXBLTXF5VFp1ZlBQeVFwMW1raEYzb2ty?=
 =?utf-8?B?RkpweHEremFHK2tIKzFTS3RkY01LbXRvV3RaVC9KQzV5NU1UckY4Y0lybWQr?=
 =?utf-8?B?RTkxUzIxbVZCOXpjRllwa096eUdRdXNzelJac1d5NE5RZ2w0YWJwU0NtZ0tG?=
 =?utf-8?B?WFk5OVNkNHZReUtqUUlTc2tTam11L2tBY2FzNXMzN2kwNUxWaVhYbkNkNk9j?=
 =?utf-8?B?ckY0dnNtbU5WYzNDZ0xTN080Z2tVSklFSE9JV0hTaHF2NU5aemhWSXo4Q1FP?=
 =?utf-8?B?ZE1mRkJpRlpBYUt0eGh1eWY3NmlTYklwWFBXckE1Q1JzQ3MxS3U1SVhZejdN?=
 =?utf-8?B?cStBeHRJZGJ3Tzg0VzFzWkhBdHZvdjdlSUdTZWdxVFU5VEZYNzQySUpYMG1a?=
 =?utf-8?Q?2tMNefljkomtQIYPfnphu6ieJSu/3YplfdNjzvA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8e5f08-f6ed-42af-0e5a-08d97ebbed5a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 17:59:45.9455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHJxC/AwgWc8guf7z92Ppw13ahi9J35wCK4p4a9Fm0H8Jy6oF6W6TL5REWvYN7/40le8BVD/bpXJG9Q4lc+xug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5463
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/21 12:24 PM, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 9/23/21 9:32 AM, Tom Lendacky wrote:
>> On 9/22/21 5:52 PM, Kuppuswamy Sathyanarayanan wrote:
>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>
>>> TDX hypervisors cannot emulate instructions directly. This includes
>>> port IO which is normally emulated in the hypervisor. All port IO
>>> instructions inside TDX trigger the #VE exception in the guest and
>>> would be normally emulated there.
>>>
>>> Also string I/O is not supported in TDX guest. So, unroll the string
>>> I/O operation into a loop operating on one element at a time. This
>>> method is similar to AMD SEV, so just extend the support for TDX guest
>>> platform.
>>>
>>> Add a new confidential guest flag CC_ATTR_GUEST_UNROLL_STRING_IO to
>>> add string unroll support in asm/io.h
>>>
>>> Co-developed-by: Kuppuswamy Sathyanarayanan 
>>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan 
>>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>
>>> Changes since v5:
>>>   * Changed prot_guest_has() to cc_platform_has().
>>>
>>> Changes since v4:
>>>   * Changed order of variable declaration in tdx_handle_io().
>>>   * Changed tdg_* prefix with tdx_*.
>>>
>>> Changes since v3:
>>>   * Included PATTR_GUEST_UNROLL_STRING_IO protected guest flag
>>>     addition change in this patch.
>>>   * Rebased on top of Tom Lendacks protected guest change.
>>>
>>> Changes since v2:
>>>   * None
>>>
>>> Changes since v1:
>>>   * Fixed comments for tdg_handle_io().
>>>   * Used _tdx_hypercall() instead of __tdx_hypercall() in tdg_handle_io().
>>>
>>>   arch/x86/include/asm/io.h   |  7 +++++--
>>>   arch/x86/kernel/cpu/intel.c |  1 +
>>>   arch/x86/kernel/tdx.c       | 35 +++++++++++++++++++++++++++++++++++
>>>   include/linux/cc_platform.h | 11 +++++++++++
>>>   4 files changed, 52 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
>>> index fa6aa43e5dc3..67e0c4a0a0f4 100644
>>> --- a/arch/x86/include/asm/io.h
>>> +++ b/arch/x86/include/asm/io.h
>>> @@ -40,6 +40,7 @@
>>>   #include <linux/string.h>
>>>   #include <linux/compiler.h>
>>> +#include <linux/cc_platform.h>
>>>   #include <asm/page.h>
>>>   #include <asm/tdx.h>
>>>   #include <asm/early_ioremap.h>
>>> @@ -310,7 +311,8 @@ static inline unsigned type in##bwl##_p(int 
>>> port)            \
>>>                                       \
>>>   static inline void outs##bwl(int port, const void *addr, unsigned 
>>> long count) \
>>>   {                                    \
>>> -    if (sev_key_active()) {                        \ > +    if 
>>> (sev_key_active() ||                        \
>>> +        cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {        \
>>
>> Would it make sense to make sev_key_active() and sev_enable_key generic 
>> and just re-use those instead of adding CC_ATTR_GUEST_UNROLL_STRING_IO 
>> and having multiple conditions here?
>>
>> You can set the key in the TDX init routine just like SEV does.
> 
> Any reason for using sev_enable_key over CC attribute? IMO, CC attribute 
> exist
> to generalize the common feature code. My impression is SEV is specific to 
> AMD
> code.

When the SEV series was initially submitted, it originally did an 
sev_active() check. For various reasons a static key and the 
sev_key_active() call was requested.

My suggestion was to change the name to something that doesn't have 
SEV/sev in it that can be used by both SEV and TDX. The sev_enable_key can 
be moved to a common file (maybe cc_platform.c) and renamed. Then 
arch/x86/include/asm/io.h can change the #ifdef from 
CONFIG_AMD_MEM_ENCRYPT to CONFIG_ARCH_HAS_CC_PLATFORM.

Not sure if anyone else feels the same, though, so just my suggestion.

Thanks,
Tom

> 
>>
>> Thanks,
>> Tom
>>
> 
