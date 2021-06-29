Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F103B78D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhF2Tuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 15:50:32 -0400
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:1537
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232315AbhF2Tub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:50:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjMHbgih62HIKXjqaFNJZTsU2CHjKPhQ1U7em02F0ejVwgmScoQu0dpbYh2x2bH1ABx7b195N4XUnlS8TiWD9lJjLiaJwxisUbZKZmX0GpQPAZBn5RDL15r9sFbqoV0htvDs5NX6xZDt4xWdZsogTAv6MFNqPc458h44j02Bzb8SR3/Obf2fORVmURybO1Fh0a4kKpERA4ZFI6itYf7oLBH1wVfyCUxI9i6GUz997eV6xD3pNt0EndiUzMqWIwUBElilLpDx8Vbw6f6kL+DAiaU5XpTI6LjimTVgEJiJGZt8H9yUXFXjtiIgHUSsrPAYPmJXV1vRfCFQs/lJUjARKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIi4ybYoCQj0G8NC5dx9vq0gs3yHGDWBkidJLg0KbSA=;
 b=j9A7d7bltUV0UQPgoh/R+cw7DWbU//y/5atu2P8ptO/UBIy4nS/rF4kPqnYafvBZwfwrl15RxFfCQ21Wvlycd4uMKJPIuBDp6g/Dm14lUjPN/bKZj32idnenseH8htwkW1ACP6Tq92gjSKJSfd/J0YKiq6CodyzP2CD3Trv7k+9Ir8I34b+z07HKwzRIz9BSLUi9fygoh1oTz2EuTmoDsYJWVcpvCQimkR7UUjP/+jZnSHu60j7Isr12iPshfBBZEC8fp0m6wyzp0k43qnjr3PMzOLudAdA8EM44fu2Ue3EkbiUHNjaQeI7mIOyNYKA3Z1UezU6Yqe5+wvu7lp2bdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIi4ybYoCQj0G8NC5dx9vq0gs3yHGDWBkidJLg0KbSA=;
 b=Kpf6TB7AfN3gDMwyovkR9hwRdsipjGGWqPHJbdarbZcBk4uEord/4Ye9yZb2htSuZ20HmuEUH1eQApRyavcurFqr/xFh4j/dgP1pjYkcnrUx6Z3ZC0Ko231SLw7ubnwdDEX2EzBvxK2Kwheq8GKq8ynQtWWGs+j9ETP8YSYibjI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19; Tue, 29 Jun 2021 19:48:02 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686%12]) with mapi id 15.20.4264.026; Tue, 29 Jun
 2021 19:48:02 +0000
Subject: Re: [PATCH v3 04/11] x86: Introduce generic protected guest
 abstraction
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210618225755.662725-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9e188172-772c-8a33-46c0-e1e4bbf2668d@amd.com>
 <4853f140-9406-6d94-1546-6545472f86da@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <b19d6ab8-30ad-da4a-e1a6-77c8136c0fce@amd.com>
Date:   Tue, 29 Jun 2021 14:47:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <4853f140-9406-6d94-1546-6545472f86da@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA9PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:806:21::8) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SA9PR13CA0003.namprd13.prod.outlook.com (2603:10b6:806:21::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Tue, 29 Jun 2021 19:48:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64fdf9d8-782e-4641-a3e5-08d93b36cdd0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4941:
X-Microsoft-Antispam-PRVS: <DM6PR12MB49419590C514FBC4E33B6B33EC029@DM6PR12MB4941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H82vS/7DKoohgF24nervBFOaonhj6gIGfSGMDFHHYGKz5KnrBmbKNzfXqmZAh9XNCggPq9mBWJ/qecbAe/EV3IK8XCXQtS4YoWV4YmLQnV4u2yXtW/2oXz03ruCQzm5EGHffzPRMnxLAYadz/UDnvScSSTy4yJfjyKRyxtwB1Qnq8BRYsk18jDFbsZXYfwvADO5qFbPhmoBJAqhgdwWPSTI3ZRMxIAfSMH7HXkErQZZJjXPN+AkdA8hjQCBPe88YReeoMW7b7grHkL+LjZTmo1BJoYauNlAi7MpiNVNRZxt3tDHW8BQ8maYfDvfz0XPR0QEpCIvW3ke5FrdrJ9huB4zs2WkkY2jwB6kh4R1O5QPG3WpqtyT46gYKhZUdMuCega2WWlia8cbkEFwsvKKv3OYDF62czX6EahiaZfTMiAq/wxfwoyEnFd1box7S87hXGlT9N1RE62KJPd97mfm5PPTEYHTPzEBKxGsP4NAUyPGdYD5bK0Evjv/NoNKaGVKBZOXt6FcPstQmq0E5opV4Di4KLzzl6Qc60BhL9Sg5yp0YYOE11+eQs6zOkFNDq90unCZDwRgEXpUQhYO/IhHvrhfkFMDbvNwtcgG+QnuIkRHlsWBz+CHdSAKM34BVOwCcfxj/3dk23GV22WqCafr0S7iFATrQpB/OjaCmjJaQ5pIa5hZNmAIkUBxi2zJh5A0ggorAqOpmyb9P6EQ72NPqufJWyGNjSCM/yU7Ka1lVyUt3LPNbiQEgEScFNWrLgPOrYDaPSfAmKQKWxiHW99pm/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(956004)(478600001)(66556008)(8936002)(8676002)(36756003)(316002)(4326008)(110136005)(66946007)(38100700002)(66476007)(2616005)(26005)(54906003)(6506007)(7416002)(86362001)(5660300002)(186003)(16526019)(53546011)(31686004)(2906002)(6512007)(6486002)(31696002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXdIQld2SHZEVmVaang5NU1WZDVZdExYa2ZxUlA3eDlnQklMWkhZbzJXMUhQ?=
 =?utf-8?B?SmN6Mm5SSnd4R1dWWFFtanVwdDFhVFJzblllNHNObWtOcTdHZUs3RVcweE53?=
 =?utf-8?B?Ty9ZSHZXU2NBMzlWc3l0SWVGeVVBODVBTm92OFVFVlpENVB4bWxvWk5WcWJi?=
 =?utf-8?B?aXduWEwxYjRCNTBSUzllUFF3OFJQanZjKzhzemdMalIvT2U1TDNycVY1UUdF?=
 =?utf-8?B?SzlteFVselJ5U3VDekErTDROYUZaSEk1MHByMHFtQXR1R2dtcklTOWszYnN3?=
 =?utf-8?B?VTh4eFpQUEt3dHdsaHhyMzVHeEdrdjVwbnZUYWs1Q0RaRVd2MWFaT0VuMTdQ?=
 =?utf-8?B?bHFEZExrcXZUZ0E3eFlKQ3RPRExKQWJQWnl0WFJJem16VThEOVZTU016YzU0?=
 =?utf-8?B?dUpFQkxsWUw2SUx2K2JiUVNFUXlnczdwaEkxUmYrM3NIbGVEMXh5STVTM21x?=
 =?utf-8?B?UmFFZ1BhNmRhNllQaGRLMW02Z1VhTUxINHB3a0ZDeFBVaDZXNFpXdktzZFBW?=
 =?utf-8?B?T1lqdGhjTU92bzA5YzFpM1FBRytRTVJJelRRODBFWVN3RWp3QWNsc2U0V1ZQ?=
 =?utf-8?B?cCtZMFI5UnRvbWxrMEV6Vm56d3o2dTlRUGI2NTh2dDVGaWVIcjNwUmo2U1px?=
 =?utf-8?B?TjU2elVHZVZvZGdvQ2g2Mk9LQnNRVXI1c0FrbEVTNk1nNWdTM1plcXNwV0NM?=
 =?utf-8?B?VmpvWXgwNVZvM1ZGVVlFcE96YWxBQjdENzduZnlhWHJTNmloTE81STRRbFZB?=
 =?utf-8?B?eVNPM25oS3BFZnh5Rys0eURiL280VXNKNnk3TCtoa0luallPTHl2YmZTN3hW?=
 =?utf-8?B?S09TZ3V0djhycGw4ZnA1QXpEenl6NUt1SFpCTnZPQ1NWaXh6RXpnbmk2WGg5?=
 =?utf-8?B?b1Q3UmJ6WCtYM1hwMnppNWowcjY1ejNlV1dBeUU4OC9qNTZZcTJmRTRaamtl?=
 =?utf-8?B?blVzaDVNTXdjWlpUdEFWd25RSHJHWmxrUC8rYXErWGFxa3RZT09KbmFQbytz?=
 =?utf-8?B?bDlYTmJScTBKRGs0TzgxQWd6RTJFbWZKRUpzSW1PeG9yN0ZqbktqVEN5bTUr?=
 =?utf-8?B?R3NRU0pQQVpYVmNlc3hTam00VTlhK294anRkdzdwQjdlN3o3enBvb0x4K3pZ?=
 =?utf-8?B?UG5uWTFLem1xeXlWUkdEaEhyTVUrMEkwcW8yLytvanVzbm92SUdXUW4rM0FG?=
 =?utf-8?B?Y3ozc29pMGVheFU1c3IzN1o4enptYkJXNHlQU0lndDhmaWhUc25iUFI4S0tG?=
 =?utf-8?B?elpWeVBGck1Gd2d2d3NVUTdwMmNjTys0bzE4OENRZ0o1cG5lWVY1aGVwWits?=
 =?utf-8?B?WGJmSjZxWFdoYktTVUhCWjMzbnJQNW5Jb2MyRHNlVlFjSENMOGg0emdhTjRG?=
 =?utf-8?B?UFowUE5xVnRNaVZOSjJ2bk40WW14OU9FQjR3STMvY0pWMXpKU04xQnZmdlA1?=
 =?utf-8?B?bHNLOUtXRnk2ZHNiby9wUDFBKzlGclN3VXFDdlAxZW9kV3FmK0h1bTF2RTQr?=
 =?utf-8?B?SXRPOUdwMENaclJKY1J0d3NIVlFIOEJnRWp4Y2NEM0dXQ0xYelRmM25tQmgx?=
 =?utf-8?B?ZktnaVhKQUNsWkZhaGdPTEczdDZPT25JRHd2eHNvSEpBVnVuNXdwVE1yMitI?=
 =?utf-8?B?T2RRK3VtMkJaRlI5TWZrZC9zWFh1NTUxckVFd3JrbzNObFBDeHZjdnVKNHFh?=
 =?utf-8?B?b1RwK2ZVY3VHVDlxZDBZd09zeDd4VTB1R0l3OG92L0lRZlV0WWNxbEc0cnZZ?=
 =?utf-8?Q?slOVOw4O4pWPbIMrocHmKHBcG42NVbL9l8Map84?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fdf9d8-782e-4641-a3e5-08d93b36cdd0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 19:48:01.9140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FwZQdVEzY0I0QKWx0WKaxVUsrnPLFBVJ4geG2mR84J17WmzWm2B1PhDJYxyEkgniv2cVCqYD+WeEYP7kXDfBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 2:14 PM, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 6/28/21 10:52 AM, Tom Lendacky wrote:
>> On 6/18/21 5:57 PM, Kuppuswamy Sathyanarayanan wrote:

>>> +static inline bool prot_guest_has(unsigned long flag)
>>> +{
>>> +    if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>>> +        return tdx_protected_guest_has(flag);
>>> +    else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>>> +        return sev_protected_guest_has(flag);
>>
>> So as I think about this, I don't think this will work if the hypervisor
>> decides to change the vendor name, right?
> 
> For TDX guest, vendor name cannot be changed. It is set by TDX module and
> it is fixed as per TDX module spec.
> 
>>
>> And doesn't TDX supply "IntelTDX    " as a signature. I don't see where
>> the signature is used to set the CPU vendor to X86_VENDOR_INTEL.>
> We don't need to specially handle it for TDX. Generic early_identify_cpu()
> will
> set boot_cpu_data.x86_vendor as X86_VENDOR_INTEL for TDX guest. I think it is
> based on Intel in vendor string.

Hmmm..., I must be missing something then. I thought early_identify_cpu()
will read the signature, which would be "IntelTDX    ", right? Then that
is be compared against the structs that register via cpu_dev_register()
which would contain the x86_vendor value. I don't see anything registering
with the "IndexTDX    " signature so I don't know how you'll get an
x86_vendor value of X86_VENDOR_INTEL.

I'm probably missing something there, but it shouldn't matter for this
routine going forward.

> 
>>
>> The current SEV checks to set sev_status, which is used by sme_active(),
>> sev_active, etc.) are based on the max leaf and CPUID bits, but not a
>> CPUID vendor check.
>>
> 
> You also set x86_vendor id as AMD based on SEV checks?

No, we don't.

> 
>> So maybe we can keep the prot_guest_has() but I think it will have to be a
>> common routine, with a "switch" statement that has supporting case element
>> that check for "sev_active() || static_cpu_has(X86_FEATURE_TDX_GUEST)",
>> etc.
> 
>>>   }
>>> +
>>> +bool sev_protected_guest_has(unsigned long flag)
>>> +{
>>> +    switch (flag) {
>>> +    case PR_GUEST_MEM_ENCRYPT:
>>> +    case PR_GUEST_MEM_ENCRYPT_ACTIVE:
>>> +    case PR_GUEST_UNROLL_STRING_IO:
>>> +    case PR_GUEST_HOST_MEM_ENCRYPT:
>>> +        return true;
>>
>> This will need to be fixed up because this function will be called for
>> baremetal and legacy guests and those properties aren't true for those
>> situations. Something like (although I'm unsure of the difference between
>> PR_GUEST_MEM_ENCRYPT and PR_GUEST_MEM_ENCRYPT_ACTIVE):
> 
> MEM_ENCRYPT_ACTIVE is suggested for mem_encrypt_active() case (I think it
> means some sort of encryption is active).
> 
> PR_GUEST_MEM_ENCRYPT means guest supports memory encryption (sev_active()
> case).

Yeah, this is the problem with the name having guest in everything when
there are host and guest scenarios for AMD.

We have PR_GUEST_HOST_MEM_ENCRYPT but it would look strange to have
PR_GUEST_GUEST_MEM_ENCRYPT.

> 
> Yes, I can include following changes in next version.
> 
>>
>>     case PR_GUEST_MEM_ENCRYPT:
>>     case PR_GUEST_MEM_ENCRYPT_ACTIVE:
>>         return sev_active();
>>     case PR_GUEST_UNROLL_STRING_IO:
>>         return sev_active() && !sev_es_active();
>>     case PR_GUEST_HOST_MEM_ENCRYPT:
>>         return sme_active();
>>
>> But you (or I) would have to audit all of the locations where
>> mem_encrypt_active(), sme_active(), sev_active() and sev_es_active() are
>> used, to be sure the right thing is being done. And for bisectability,
>> that should probably be the first patch if you will be invoking
>> prot_guest_has() in the same location as any of the identified functions.
>>
>> Create the new helper and fixup the locations should be one (or more)
>> patches. Then add the TDX support to the helper function as a follow-on
>> patch.
> 
> Can you submit a patch to replace all existing uses cases of
> mem_encrypt_active()
> ,sme_active(), sev_active() and sev_es_active() with prot_guest_has()
> calls? Since
> I cannot test any of these changes for AMD, it would be better if you
> could do it.
> 
> Once you submit a tested version, I can enable these features for TDX and
> test
> and submit it separately.
> 
> This patch can be split as below:
> 
> 1. x86: Introduce generic protected guest abstraction patch (with below
> changes).
>    - Remove all PR_GUEST flags in sev_protected_guest_has() and
>      tdx_protected_guest_has().
> 2. Patch from you to use prot_guest_has() for AMD code and enable relevant
>    PR_GUEST flags in sev_protected_guest_has().
> 3. Patch from me to us prot_guest_has() for TDX cases and enable relevant
>    PR_GUEST flags in tdx_protected_guest_has().
> 
> Agree?

So I can work on a pre-patch series. It will be purely a replacement for
the current SME/SEV calls. You'll need to add all of the TDX support in a
subsequent patch in the TDX series. Given this is a pre-patch, I will
probably reset the flag values slightly and work on the names to be less
confusing.

Thanks,
Tom
