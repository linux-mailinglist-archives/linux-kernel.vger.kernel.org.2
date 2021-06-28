Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238293B67F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 19:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhF1Ryu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 13:54:50 -0400
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:60800
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232563AbhF1Ryr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:54:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jqr5PCyeGSBIaJOEE6eU9O6ryb4Zkv+RHXUxKeOKTfE1wizK7LdYtYu53ovOfC6NJwUkCkuQYrsnC+13DnNYNzwexHze0dUTuc+bhkvf/tCBzbUVf3xiU7ObaHhaSsBbFlBid4j6711AWWolwHkLnTDqlZW+g6V364BCTQPXtvWDrkJALgu+2j+lDRsvCi1b5ijR3kUDG9D6UeTk+wqCgfFL6iHUJZkrlTlxE8ufZGwnOYPaYdCEgugbX3KnBY3I7Jylg6dTw+5rUutSWmH2PHZkFufCwSaQJmjvi1xNhzzUpxLaD9Uy/aGMa0da0E1JPKqvRalqxmDrTgbSYBE0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fahv8DSDYbZiooPWXpblxJbqkIdFNJEkmdoeFZbXS+o=;
 b=gj5WSvZpxaW2xVz+orDMovD9FCxSGvJ/f5He6xRAHscjxzrMUbkd9UaIujmAAL9G9GRuRtYgstd58rZWzW6IdZwZ+n1dcSd2/MG7k9Tpw/a6AohNn4MOmIgTvozTyNHhH+GaWhYcBthTGUYw2EMBE06FRoBK3o7E0qrh5Sz539hMMQ8CdbZNL4qOTIBNU2rxxGTbK5TVphLpzHEnzcTurULfUVO9H/wv0B+DfCSjJoiflaatm91yuYGD3tk09kPB4gMCuykgahD5XCkqN9m7TGnVZWe1zVK5eHhJ78JGcYVu5+xF7Njj8qrN0S0uFEXUrJQ1226MDaMvfhY30mm4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fahv8DSDYbZiooPWXpblxJbqkIdFNJEkmdoeFZbXS+o=;
 b=ANDGgGAh3L4H/eiGYDbE1VqmOlXTLgt05F2gq6Aspzuyx9LRSza9E/N3AVb10xCdENt3H9hF7I/5p02zLL/Xu9YeWxZOaEqxXUz7KQ4mSAegWyv6f5xvZK2enqkeDGts+b45kSXMDVWRw87sn0I84mBjDsxalMLEhawIH10nf4M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB2618.namprd12.prod.outlook.com (2603:10b6:5:49::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.26; Mon, 28 Jun 2021 17:52:18 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686%12]) with mapi id 15.20.4264.026; Mon, 28 Jun
 2021 17:52:17 +0000
Subject: Re: [PATCH v3 04/11] x86: Introduce generic protected guest
 abstraction
To:     Kuppuswamy Sathyanarayanan 
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <9e188172-772c-8a33-46c0-e1e4bbf2668d@amd.com>
Date:   Mon, 28 Jun 2021 12:52:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210618225755.662725-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA9PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:806:20::16) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SA9PR03CA0011.namprd03.prod.outlook.com (2603:10b6:806:20::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.22 via Frontend Transport; Mon, 28 Jun 2021 17:52:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cdbdfa6-cb43-444e-998c-08d93a5d7865
X-MS-TrafficTypeDiagnostic: DM6PR12MB2618:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26181C33E6CCB9B7EE23D7A5EC039@DM6PR12MB2618.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nWYANAMhV5ayXh+IpujjxMwuMCk9aT5F2InQQ+TPlCTB0H0NGQLuqjAznrwhWMR11Xl92OqYmFbyMygZAox5bdhkzzshNq/huAFCG/2+o2o7gu4iksPFYrJZmIxC8Zs72/WDT0GUR/vxN2h0P6H+du+Qf8pYMM98W/7rpUBBBNLtItjNdLwMNW/O1yMNRunZ9dq0/iA5kgHIFvL0RGS0mSpvc6EakkXM/kMAdDuro0jZPBBqXXOFoyUdg9fM2M3+27RWodhsWEg1GbjKSvNqmTtmdu69coQwSkGgaw8Jpn4evM+phpTTaibRZxug4l/O9uqSFe1Q6+WOUR610T807xEqXGidhnzQl4+pumEX0KNdvqkM+DhUYqKN+EJXnF30HYA5zHZ9VYea5VpO65UW09xypRLV/GIlbc7mPYGlOS8XXRpMtj+LOpm+xGfoC41UE05P1SWU7SkkoBfsbtYFsrnL7E5/K1oD4GqfYc9s89QvUw+NQAfsf4ycWV4dc5vrpDBKZe27Q8AitXi6+m83LRW+zuENTvO7CYhghoTPdATkVoDzO74Vc3ANvxsB8JqsazEW+my2fRv6W764JaCe1Q5EMuKg7KWvf0Mo8UTkckRMzSKM7boO6bRwt4xLQTv7bamkdg6vdt8LBpv7WNdP9EXTY/p/+Ce6wyb7HfuAaRs/AX3krtqNnBVpF6lmEmvUrXT9rpLrHumOHZciXEM3/OpuiblAL/NPYMG/vvvW5I8xYUdymWMHFIuWiKf8j3WjjXeQ+9foiCLO6I7fG1sMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(8936002)(26005)(478600001)(6506007)(6512007)(5660300002)(53546011)(86362001)(31696002)(956004)(7416002)(2906002)(316002)(6486002)(38100700002)(110136005)(54906003)(2616005)(186003)(66946007)(16526019)(36756003)(83380400001)(66476007)(8676002)(4326008)(66556008)(31686004)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkNSSGxIdlVuU2RpSWthenBqL1NBSThkUVA1eGdmanlySGFKLzRtRHhxdTRZ?=
 =?utf-8?B?a05xUDhjWTBlaHRXRllzNWNpZk40RVc1b3kyd0dJa2FtbHQ3cTRCcUR6SmJ0?=
 =?utf-8?B?VWY3NWhyOXRGZ0ZrWGV6bnU2OWRXb0NKaVNnc21vZHNoSGorTHVHNXBhazJr?=
 =?utf-8?B?U0FvY29tS09HRjZLNVdjalY0U1VBejlhWVlYMi9HUVAzR3AvYmp6QWQzRWlM?=
 =?utf-8?B?NW1ScHdTYWl4UkFOaVFxOG1LcFFFYVZFS3lZeHQ2aUJkUmFoekRXRGdNaURH?=
 =?utf-8?B?Y1NJaVlyRUhFdkpJZ1lZakxzcExlbUQ4SGsrMno1R1JlLzVhd1A2c1BDd1dz?=
 =?utf-8?B?a1h5dDd3TzBSc0NZelRLOVJsMU1HWFczZXhQVCswdWpLMmxPcERsL3pWVFE4?=
 =?utf-8?B?a0dOMXUwYnVUZkR5RTgwK1YxSDRlVGQ3dEFlWmtqV0FVSmFMRzZPeFRMREFy?=
 =?utf-8?B?UzU5anBoSDk0MkJoOUlMWTJRVGthZFR3c25PajEvc2dFZ0dITVpWdzNMcWFs?=
 =?utf-8?B?MUZQMlJwVTU0T0VHK2w0SjhTTUJSWkpPNmpOZnNFcGI1a1VkYUtJUkFCR3dJ?=
 =?utf-8?B?TXdLTUlscmFjM0x4RUFWSSt3aDNMSThHYWF3S000WTZlSmROTzVtRXNwYXVo?=
 =?utf-8?B?YUpHOThwSE5qZ2c2dlhRQWs4eEEzYkZqK1QvYWFuMXo2cnFiRkZld2xKd1lm?=
 =?utf-8?B?OG1RQS94T21hSkp1VStMdjFiZmhsa0JLa2JjNHcrZThJZmUwZXNLMkRETGJs?=
 =?utf-8?B?eC9LYTEvSlhyNmNnL2ZuT29IdUZYWmN3VjVsZHN2TGtOSEV6OWJJLytLeE5P?=
 =?utf-8?B?OW80Y2FXN2JZRUFyMEtBU3lxLzFtWU84M29QUjl0TnBrQ1lLY2g0TGd0YWdu?=
 =?utf-8?B?WEZWWjZER0FhR3ZDV0puZFFiK1I5OXVGWEZBNzluUk1MTGkvQmFwYzlaUVBM?=
 =?utf-8?B?aHFjRzUxQXVFaEQ2SFlJSDEyS3NLaXZNM1pmSzRZL0ZRODRPUlQvRWFuWWdq?=
 =?utf-8?B?bHpvN1VLdFg2NWN0ZTJ6S2NiY2lGSXB6b0dQU2VYS3M5V1dTNUtWS0RlOG0r?=
 =?utf-8?B?ZmIwUjZISGdqczRaNzgreWxJbFBEUk9iTElQZ3AyY0JNMHBXWGJBc0NmUkEy?=
 =?utf-8?B?RDhwUXE5ODlRQnNMdEdYd00vWFUzY2lHTEsrSm5aWitDMi8rYW1DbnNUVHIr?=
 =?utf-8?B?enBoblk0MTdvY3c2c1lXTHl2RzJOdVBLTm1kbjVTbzlORVFxN0llcFNvVE5j?=
 =?utf-8?B?clh0TEhoNXRZU3pWTEg4NmRBWGdLWVk0REF6c2NtSUdDNWQ1enQrQVZCb1NB?=
 =?utf-8?B?NVY0OVp0SXJDd212WUtGaEVvY0VHaXRlRC9IcXJ4Uy9tbUc4aVJjWFFzck13?=
 =?utf-8?B?eFMrRFh1WWRmaG54OUlBZUdVWnZlTkpySk5lV25aNFdYRE5WMlBUL292djVV?=
 =?utf-8?B?dW1zcWJrR21CWTlqMEVtN1BSZCtUcm1sbDQxclc2RFRCZjBWeUdONWFlbjNU?=
 =?utf-8?B?MlU5U2Q5Q2NIWUFnUUY0NmNkWVR4cXgzZjJyZnE2dFJOdDg1S2tMVUU1TkVB?=
 =?utf-8?B?THFoNlpvd052K3F4dUF0ekxZeElIQ3VyUDFUdUk0WGswZEpsQTQ5ZlE0Z29z?=
 =?utf-8?B?T1pOeFY0UUlWT2swdG5YcktEUmdDKzFPVWpQVHlON3B1WFNyMllVRFh5Wk96?=
 =?utf-8?B?dlRCMEcyWmhFQ2NPMFdZQXNqVlp6alA3Wi9iK1BITU1LaWQ2cDFNcStnSUZZ?=
 =?utf-8?Q?tfIFRM3v82MOVRBAnjV21M/XwfGJMNxq4vdE/od?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdbdfa6-cb43-444e-998c-08d93a5d7865
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 17:52:17.7828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f++Ub7k0AF/1+pAu4rdIQUDQZo3s0BDDK+MCaUFjt+z6UEKdJHq3qg819DxVH7xcEThcmarY5uFcw6dcxLxxCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/21 5:57 PM, Kuppuswamy Sathyanarayanan wrote:
> Add a generic way to check if we run with an encrypted guest,
> without requiring x86 specific ifdefs. This can then be used in
> non architecture specific code. 
> 
> prot_guest_has() is used to check for protected guest feature
> flags.
> 
> Originally-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Change since v1:
>  * Introduced PR_GUEST_TDX and PR_GUEST_SEV vendor flags as per
>    Boris suggestion.
>  * Replaced is_tdx_guest() with if (boot_cpu_data.x86_vendor ==
>    X86_VENDOR_INTEL) in prot_guest_has().
>  * Modified tdx_protected_guest_has() and sev_protected_guest_has()
>    to support vendor flags.
> 
>  arch/Kconfig                           |  3 +++
>  arch/x86/Kconfig                       |  2 ++
>  arch/x86/include/asm/protected_guest.h | 20 +++++++++++++++++
>  arch/x86/include/asm/sev.h             |  3 +++
>  arch/x86/include/asm/tdx.h             |  4 ++++
>  arch/x86/kernel/sev.c                  | 17 +++++++++++++++
>  arch/x86/kernel/tdx.c                  | 17 +++++++++++++++
>  include/linux/protected_guest.h        | 30 ++++++++++++++++++++++++++
>  8 files changed, 96 insertions(+)
>  create mode 100644 arch/x86/include/asm/protected_guest.h
>  create mode 100644 include/linux/protected_guest.h
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index c45b770d3579..3c5bf55ee752 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1011,6 +1011,9 @@ config HAVE_ARCH_NVRAM_OPS
>  config ISA_BUS_API
>  	def_bool ISA
>  
> +config ARCH_HAS_PROTECTED_GUEST
> +	bool
> +
>  #
>  # ABI hall of shame
>  #
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index ff79263aebd1..d506aae29dd9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -883,6 +883,7 @@ config INTEL_TDX_GUEST
>  	select PARAVIRT_XL
>  	select X86_X2APIC
>  	select SECURITY_LOCKDOWN_LSM
> +	select ARCH_HAS_PROTECTED_GUEST
>  	help
>  	  Provide support for running in a trusted domain on Intel processors
>  	  equipped with Trusted Domain eXtenstions. TDX is a new Intel
> @@ -1539,6 +1540,7 @@ config AMD_MEM_ENCRYPT
>  	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>  	select INSTRUCTION_DECODER
>  	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> +	select ARCH_HAS_PROTECTED_GUEST
>  	help
>  	  Say yes to enable support for the encryption of system memory.
>  	  This requires an AMD processor that supports Secure Memory
> diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
> new file mode 100644
> index 000000000000..d47668dee6c2
> --- /dev/null
> +++ b/arch/x86/include/asm/protected_guest.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2020 Intel Corporation */
> +#ifndef _ASM_PROTECTED_GUEST_H
> +#define _ASM_PROTECTED_GUEST_H 1
> +
> +#include <asm/processor.h>
> +#include <asm/tdx.h>
> +#include <asm/sev.h>
> +
> +static inline bool prot_guest_has(unsigned long flag)
> +{
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		return tdx_protected_guest_has(flag);
> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +		return sev_protected_guest_has(flag);

So as I think about this, I don't think this will work if the hypervisor
decides to change the vendor name, right?

And doesn't TDX supply "IntelTDX    " as a signature. I don't see where
the signature is used to set the CPU vendor to X86_VENDOR_INTEL.

The current SEV checks to set sev_status, which is used by sme_active(),
sev_active, etc.) are based on the max leaf and CPUID bits, but not a
CPUID vendor check.

So maybe we can keep the prot_guest_has() but I think it will have to be a
common routine, with a "switch" statement that has supporting case element
that check for "sev_active() || static_cpu_has(X86_FEATURE_TDX_GUEST)", etc.

> +
> +	return false;
> +}
> +
> +#endif /* _ASM_PROTECTED_GUEST_H */
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index fa5cd05d3b5b..e9b0b93a3157 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -81,12 +81,15 @@ static __always_inline void sev_es_nmi_complete(void)
>  		__sev_es_nmi_complete();
>  }
>  extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
> +bool sev_protected_guest_has(unsigned long flag);
> +
>  #else
>  static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>  static inline void sev_es_ist_exit(void) { }
>  static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
>  static inline void sev_es_nmi_complete(void) { }
>  static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
> +static inline bool sev_protected_guest_has(unsigned long flag) { return false; }
>  #endif
>  
>  #endif
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index c738bde944d1..1c17c9080a2c 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -11,10 +11,14 @@
>  
>  void __init tdx_early_init(void);
>  
> +bool tdx_protected_guest_has(unsigned long flag);
> +
>  #else
>  
>  static inline void tdx_early_init(void) { };
>  
> +static inline bool tdx_protected_guest_has(unsigned long flag) { return false; }
> +
>  #endif /* CONFIG_INTEL_TDX_GUEST */
>  
>  #endif /* _ASM_X86_TDX_H */
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 651b81cd648e..3e88576555d2 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -19,6 +19,7 @@
>  #include <linux/memblock.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
> +#include <linux/protected_guest.h>
>  
>  #include <asm/cpu_entry_area.h>
>  #include <asm/stacktrace.h>
> @@ -1493,3 +1494,19 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>  	while (true)
>  		halt();
>  }
> +
> +bool sev_protected_guest_has(unsigned long flag)
> +{
> +	switch (flag) {
> +	case PR_GUEST_MEM_ENCRYPT:
> +	case PR_GUEST_MEM_ENCRYPT_ACTIVE:
> +	case PR_GUEST_UNROLL_STRING_IO:
> +	case PR_GUEST_HOST_MEM_ENCRYPT:
> +		return true;

This will need to be fixed up because this function will be called for
baremetal and legacy guests and those properties aren't true for those
situations. Something like (although I'm unsure of the difference between
PR_GUEST_MEM_ENCRYPT and PR_GUEST_MEM_ENCRYPT_ACTIVE):

	case PR_GUEST_MEM_ENCRYPT:
	case PR_GUEST_MEM_ENCRYPT_ACTIVE:
		return sev_active();
	case PR_GUEST_UNROLL_STRING_IO:
		return sev_active() && !sev_es_active();
	case PR_GUEST_HOST_MEM_ENCRYPT:
		return sme_active();

But you (or I) would have to audit all of the locations where
mem_encrypt_active(), sme_active(), sev_active() and sev_es_active() are
used, to be sure the right thing is being done. And for bisectability,
that should probably be the first patch if you will be invoking
prot_guest_has() in the same location as any of the identified functions.

Create the new helper and fixup the locations should be one (or more)
patches. Then add the TDX support to the helper function as a follow-on patch.

> +	case PR_GUEST_SEV:
> +		return sev_active();
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(sev_protected_guest_has);
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index b1492e076168..ae3334a2b29d 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -4,6 +4,8 @@
>  #undef pr_fmt
>  #define pr_fmt(fmt)     "x86/tdx: " fmt
>  
> +#include <linux/protected_guest.h>
> +
>  #include <asm/tdx.h>
>  
>  static inline bool cpuid_has_tdx_guest(void)
> @@ -18,6 +20,21 @@ static inline bool cpuid_has_tdx_guest(void)
>  	return !memcmp("IntelTDX    ", sig, 12);
>  }
>  
> +bool tdx_protected_guest_has(unsigned long flag)
> +{
> +	switch (flag) {
> +	case PR_GUEST_MEM_ENCRYPT:
> +	case PR_GUEST_MEM_ENCRYPT_ACTIVE:
> +	case PR_GUEST_UNROLL_STRING_IO:
> +	case PR_GUEST_SHARED_MAPPING_INIT:
> +	case PR_GUEST_TDX:
> +		return static_cpu_has(X86_FEATURE_TDX_GUEST);
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(tdx_protected_guest_has);
> +
>  void __init tdx_early_init(void)
>  {
>  	if (!cpuid_has_tdx_guest())
> diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
> new file mode 100644
> index 000000000000..c5b7547e5a68
> --- /dev/null
> +++ b/include/linux/protected_guest.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _LINUX_PROTECTED_GUEST_H
> +#define _LINUX_PROTECTED_GUEST_H 1
> +
> +/* Protected Guest Feature Flags (leave 0-0xfff for vendor specific flags) */
> +
> +/* 0-ff is reserved for Intel specific flags */
> +#define PR_GUEST_TDX				0x0000
> +
> +/* 100-1ff is reserved for AMD specific flags */
> +#define PR_GUEST_SEV				0x0100
> +
> +/* Support for guest encryption */
> +#define PR_GUEST_MEM_ENCRYPT			0x1000

I'm not sure I follow the difference between this and
PR_GUEST_MEM_ENCRYPT_ACTIVE. Is this saying that the host has support for
starting guests that support memory encryption or the guest has support
for memory encryption but it hasn't been activated yet (which doesn't seem
possible)?

Thanks,
Tom

> +/* Encryption support is active */
> +#define PR_GUEST_MEM_ENCRYPT_ACTIVE		0x1001
> +/* Support for unrolled string IO */
> +#define PR_GUEST_UNROLL_STRING_IO		0x1002
> +/* Support for host memory encryption */
> +#define PR_GUEST_HOST_MEM_ENCRYPT		0x1003
> +/* Support for shared mapping initialization (after early init) */
> +#define PR_GUEST_SHARED_MAPPING_INIT		0x1004
> +
> +#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
> +#include <asm/protected_guest.h>
> +#else
> +static inline bool prot_guest_has(unsigned long flag) { return false; }
> +#endif
> +
> +#endif /* _LINUX_PROTECTED_GUEST_H */
> 
