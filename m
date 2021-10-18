Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B05431E03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhJRN44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 09:56:56 -0400
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com ([40.107.93.55]:11046
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234025AbhJRNyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 09:54:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY6ZMnVDghQFI4mwtVpjhrjizWe+1H+VmcNtQXKQ+GndMbf7DZdWWasvyOyE80nxc0AwElZdxkA+WidbQzyOZBHRrgWuH+YSFbtf9GkLvYxGB/f/c0cGHw508JNddwIua/7BK3W6xCC/sNyE7khJs9lCR5WprYVnyPN76p8JJ62cwyhfk0slUCOLTDSFbPtzlDLhsiSP3fvtfqqWIscAYG8EDksrpw5KrTos2dPlo/zpz8PffZ882tzYJL+HxHhFndSKCqABHmDyF62aRPwp5GL8vFcJ3Yvh7Qk5uM3gWIRa6Rl7OHwywllhQg5M5L7WlHqcTgkdlgziMYyzHa8GPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iiKJkF2ZGbzJwY+ZEJvQodcLy5UUhzxak71Bu8VBLc=;
 b=ja1OftxiP4zL0rjHCT0TJCKeWixeuiJo+qdhMlgVbePBXe4kR1F1bDjYzDAv+1ypKLf1GDMw3fTfkP3UE3rl8f86yg//BXyNbY93U3G0q8YihUkv8uh2WAKOCkj2IZ8lDhYk1ST7cBSoNhT4XwA6TPxjUWaQNyzQEE4gIHp8XwczoDXsF2VKua0nsG7sZ5wxkNmNCTM15aLozldhC/Mlj9NXoDdC6/WZEXGVBqXLuDEkMfukLsu2mPJXrkkaU7ne9eNdRFCdkOcrTBMwIDQWXynJQAkhp2hJ4rAPvqWqegcq2T41eEEZFw4pkdyCd3VwXJ8Q6jarGcbIUvkSV+xK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iiKJkF2ZGbzJwY+ZEJvQodcLy5UUhzxak71Bu8VBLc=;
 b=bgONVt8ghJ+upBFaE8QbK+wR6jmEXpzNAmBck/PDoHVeGULbPQqkme9MA9qu4quF60fcd9tebu7/unxRdgMfGIjSZ78S9z7p0LxSzwS1EEB9YBEmjO54C9fuNWqNw06sFTjVJZLtAXrKXrMfKbFM/D23My6KFpKoh7cNbIytROs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 13:52:33 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::a87d:568d:994f:c5f9%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 13:52:33 +0000
Subject: Re: [PATCH v7 05/10] x86/tdx: Handle port I/O
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005204136.1812078-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87v91v2zkk.ffs@tglx> <eadc3025-a32d-3641-de83-e5f05728a755@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <51511837-f712-35e2-fdb7-05a2c3f473cb@amd.com>
Date:   Mon, 18 Oct 2021 08:52:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <eadc3025-a32d-3641-de83-e5f05728a755@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Mon, 18 Oct 2021 13:52:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ddc09f4-175e-4b47-617e-08d9923e8906
X-MS-TrafficTypeDiagnostic: DM8PR12MB5448:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5448ABAF632CABD74D300998ECBC9@DM8PR12MB5448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ei+M3qdWFpXu9bCn2K+ODYL7gn4qKAab/74NxCYv3ID3zbvJ1la/CvoCRKEkcsqQb1cat7OoZdjiHK6EfyAFhzTRg94Pz94lVHD8226iUhiot0dBSJiTK8DSAAk/7+AowSEWnU+7AmxhCcd/XhEL0FgJ3ptUu5nsQxAJqJB15wguMxt/HGiQVJmc3RYW7xA/6Aph+wAGQjXDbm4SSjjXD+z8S0+TFlRpKu/gKgIT+HePnsDXFrfWD4VQYS5qRBSmgzNnvhT6+M5NgWuedAy1z1n3a6+q+3rztw7IIiacwSz+XrE5UfhxyaA5jqRmXiadc8rhf87i7hsdm+sbBf38qVqYIXv2TV5DZGuVfimpO2xDAnPFYKVYC7Ut3aGtSYY4+8vstk9m8DIsKQtvlyTvhp+J5R9AsAdpd+ltGgniuij0658ZzLERslxAankHCb6iX82XFB/OKzJ5TVsIHHsz5BiZ1SFKGFZfl0lKCqG8JOHFy4pZ/SSPZ5/wEKX9VcA9lrMQJgh55JWBmd5TDT0vzdP1wog+wwpSFAnPQpGOTKIyAtpSNUDLyz1eUwLskDmqFx8ORmk+kw6gMUu97p7K4A5VtsB714qiu/Gd0/9FcMh4g+kbYp7PWI5OCLRBq0YuhQ7XnZ6ga8iZN97WkknwvOcH/nSgFdxBIWAjO+hVObc+9a+PVeB1gpXmo5vLl1OlKtSI42K9+aRX5QLmuTyZFb2IWsWXXn01nklg0O/uWLsvjgfvzpyS2swUDHiDxqXX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(316002)(36756003)(31686004)(8676002)(86362001)(921005)(66946007)(7416002)(2906002)(66556008)(5660300002)(16576012)(508600001)(31696002)(66476007)(54906003)(53546011)(956004)(110136005)(2616005)(38100700002)(6486002)(8936002)(186003)(4326008)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1dCWFREVHAvSTNxS1Nya2lFajlpYWdMYmZLN1pSN3Z5MnpKWTZCTi9HaGpq?=
 =?utf-8?B?QmxpNXBDOXMyOXV3anlRWlhiTVBud0xSMkRnaUMrcjIwSTJ2MzNKenBUNWRE?=
 =?utf-8?B?TFB5Q2ZIMkRpRGRuMk1DVGM4d1V2b2R3dXl0SFdKNEphR2REM3dudUxYZUEw?=
 =?utf-8?B?a2ZXVnNlaUhpaDMzQXN1djBtSFJ5N01ubmQ3Y1hBM3dSaEFKWlVmVTNKcUtW?=
 =?utf-8?B?YjhSbTlMMDdOWlZrL1E4YUJCeFRmQXJnWUkvNnJRYVZXTFJ3NlliV0ZSZHY5?=
 =?utf-8?B?UGJ4SzF6TW9uZXVwdHJvRFNtVFdUN3pZWEJDR0QzNUprdWxFNWpsL29teWpR?=
 =?utf-8?B?U01PeHl0a0pvR1hvUlBUZlBicGl1K2lTWU5pWHV3anJvT2Z2S29HSzFXZ1kw?=
 =?utf-8?B?MmZlVHJLS2lGTnVpbDFyMHNqQ2lhTzh5SkpKeWJrdVc2WkxDTzNlTVZnakI2?=
 =?utf-8?B?ZUZPSW9WOXl3eXlUZnAwQ01jYXJoc1lGeFI0QXpOUFhvcWxVMWxUUmh0RDZ6?=
 =?utf-8?B?RjVFTm5VOGUyQzRmZDhhVjJuNytLVXBhNzlGOCt5OGxCNXhZQ1F4dW1RZFJ1?=
 =?utf-8?B?VHQ2QURMUjlxamFvNFF6M2hrUVFWSWI1UlFGR3hqQWwzUFdOenJlbEdwT3ZD?=
 =?utf-8?B?OTBGUXZxTlpOMVZQNGkzdHVkOUV0SlRyT0hyZVB6amMwQTlmWVVJQThZZncy?=
 =?utf-8?B?OElqVm91OTZYRGxXSXM2SWxyVDFINVlaTnVKOVFNdVMzZS8xR3E3d2tQVWcy?=
 =?utf-8?B?dXQybFpvbDQraDEyZ0s5bVJQU3lUbkFmRGdaaVR6Z3E3ODlFQnFwdEcvcTVH?=
 =?utf-8?B?a0cxQVBXLzFRY3hUQllpLys4Y0UzMndMQkdpTUNpK0d5cTkyVG5NZ25VNkhH?=
 =?utf-8?B?d3dSVDRUMUZlYlQrWXJTT0Z3cnQ3bDFuYkZQSnRORUNyVlhqNERjSFU0Nkha?=
 =?utf-8?B?b3Npbm1wWTNvTXVWL3dhNVMzZDAvQ3hJV0d5R0pxVE50VVliZGRNd3RZNjV0?=
 =?utf-8?B?Q2RuSC9WV0RhRkh5QlFsL3hmUm12NXFiSVhVMVloem1CbTNWbEVobTNtdkJI?=
 =?utf-8?B?c1N0TUFGOUJpQm81SnhXTEEvaDJhME9XY0pMWGxDc2lMbEdjL0VvMkx6UEZM?=
 =?utf-8?B?dElrMUxmdEFCTEVjUUMzSm1jczgvMWNQZE1xU1h0SEd4cyt2dFdPYzNVV0pi?=
 =?utf-8?B?WGRiTjd3NUVzT0R5YnoxeGlBOERlYU1oY253MDZOUjkrbHNhZ3RwMzU3SXNK?=
 =?utf-8?B?bC81SzFQM1RTaWt3eEZRV2dCQU5vck5jWWFSUStLRmRoRmpnZlBkR3dyTER5?=
 =?utf-8?B?bjYwRnRiQ0hnOG9jNmdVdi9DbTk5RGVkakxtb3pLanU0MW8zQW1JbFZRbklG?=
 =?utf-8?B?L3pxRDIzTDN1Z2FDeG1NK3oxd0p3YTVyM1VKOEZhSytrR1Y0ZDVNYXJJbjdL?=
 =?utf-8?B?MFRhMm5iYWxTa1BMTk5CSW51MmVPZG8zWWtDdnVaM2tCRDlPdUtwUlRWY2g0?=
 =?utf-8?B?SjVSL1RpNjRRZm9ZblVTdU81QzU5UWhvT2xUQ2UrTldiRDJtVlFrc1ozS3lI?=
 =?utf-8?B?OTc5QUZNaFhaU3Btd3UvbXozYS9UNWZCbkVMdkhDTHlCZzZtR0NjTHEwMm1U?=
 =?utf-8?B?UitjNmdmZVo0ZXlzdUlvejFuVVlkcnA0dE5zb2FVMW85QmdGWEJvaWc0eFYr?=
 =?utf-8?B?Qnl0MVhzSVpZOG1vbkNzL3pHZDh0Q0JGU0RmN1FDWFptaTVxbVVSL1NVUjc5?=
 =?utf-8?Q?hWb1RvmLLaXYWRwpCEEBxYR80lVzFCHSMATkvjN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddc09f4-175e-4b47-617e-08d9923e8906
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 13:52:33.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JnOLfytaj6uw4AyYxfAVESqpjD2I39Jy1/o+Hrv0lMT19skz7ulSeUFN7Z4B/uI03i+GUzSgTRgCWYR4UvxWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/21 3:35 PM, Sathyanarayanan Kuppuswamy wrote:
> 
> On 10/17/21 12:58 PM, Thomas Gleixner wrote:
>> On Tue, Oct 05 2021 at 13:41, Kuppuswamy Sathyanarayanan wrote:
>>>                                       \
>>>   static inline void outs##bwl(int port, const void *addr, unsigned 
>>> long count) \
>>>   {                                    \
>>> -    if (sev_key_active()) {                        \
>>> +    if (sev_key_active() ||                        \
>>> +        cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {        \
>> Instead of adding an extra check, can you please replace that
>> sev_key_active() with cc_platform_has() completely?
> 
> Yes. sev_key_active() can be removed and replaced with
> cc_platform_has().
> 
> Thomas Lendacky also proposed to introduce as common
> static key which can be set by both AMD SEV and TDX code.
> 
> @Thomas Lendacky, any comments?

Either way works for me.

For the cc_platform_has() path, you will need to update the 
amd_cc_platform_has() to return true for CC_ATTR_GUEST_UNROLL_STRING_IO 
for SEV only, i.e.:

	case CC_ATTR_GUEST_UNROLL_STRING_IO:
		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
		       !(sev_status & MSR_AMD64_SEV_ES_ENABLED);

Thanks,
Tom
