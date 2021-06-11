Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D42D3A4464
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhFKOy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:54:57 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:51745
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230508AbhFKOyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:54:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnpYgnOM8lvwlS/UbWA7ZpQCpQjnMB26kXzQqFQAI3E4KQeK9XSfekjssft3Qhh2MSzrwga027Idto+CxjvexXbsfHVHTT7uvoap1XthRrjVdSqDGMl4eAL40tkMx54N7NOj+a7SmBYpvuSRatt3YMwZoZQCH4Yi9bysC0MSZFIm8ZDgEKduu8Tcdokv6SYl0y61LxNKeuEAPVS+0CgFbJZr8Wor+P5Mj4wS5h6Yu2V9SXoa6gbeNOsPQM+jL543eOWNEe9Ed5NCbBp6jkhTBGOmyOSXdQUobmvVmAgQoEfHvCNr4WhhHbVVsmfde24G7dLZdINX9S/Iw9YHD9Lifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxZr1Jbtnxap4uxyARpW/cKBaqZqX962Vh2/GImiS3E=;
 b=M63vL60tXL4DbEwyVj0iE7HE3lmS4y7pJOAHQvrR3hwhnwa+dfUykRDLRIg+0g8O63KhAGd9MrjoMg3PhBIVupdl1znCsIcqFQfUjtG/Sz/+y4k5g+VCU95WDPc2W7+J+sKyT722SK8suGS0/4SziLirq/nzyAMHNN1PBxYu6T3oytgi6Ne69AZam59MlplcZwOfxH5EYuB2SDrLbIMK0qG3502jKyr/6TnXU7ruO14hjitRJ1tjLrV31nybgn2ojkPFDAfCHBdUoP+l4nqZpcqn6+Zv1SVDx4lacLBPc+2LqNfuz3H8wFEQiGXnD/VSO1ysUrIcSkypwyWchbHKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxZr1Jbtnxap4uxyARpW/cKBaqZqX962Vh2/GImiS3E=;
 b=x9Fjf1nxo5q2ih8PkZ0Ko3urigmV0BlzyX9AkobGQpwwfFV5gdWhIsPP3wDhGkubE8lbTS2+n5JV/ToG373gbN4D92si94lDGHD76aTyKE1nz21/naejyJ69ffMlWfXE9AoQTQIkN6W0Oy6Su6aj0rn/HpuskVl0AANyCf2oB9A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.23; Fri, 11 Jun 2021 14:52:51 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4195.032; Fri, 11 Jun
 2021 14:52:51 +0000
Subject: Re: [PATCH v1 6/7] x86/kvm: Use bounce buffers for TD guest
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
References: <20210609215537.1956150-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210609215537.1956150-7-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <5f4dd90d-3761-3e1d-4f7b-86f504f769ae@amd.com>
Date:   Fri, 11 Jun 2021 09:52:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210609215537.1956150-7-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA0PR11CA0158.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::13) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SA0PR11CA0158.namprd11.prod.outlook.com (2603:10b6:806:1bb::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Fri, 11 Jun 2021 14:52:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9e7dc19-3c24-4be3-324b-08d92ce89627
X-MS-TrafficTypeDiagnostic: DM6PR12MB4958:
X-Microsoft-Antispam-PRVS: <DM6PR12MB49589F1DABB6B2703CF8638DEC349@DM6PR12MB4958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pEj4gMKX3r3lUMgWV64LiNkc8Ddhdp1SiHIQGt5h7wgmU856gL/xiwhyAJsEuaOqDTOlo0Iu5i5eZay/DpXrj+oBv2eZaYAqAuq4LYWx1r0RtAEhg+U+Dzc4DR7pCSw/LhX5Sy+ceA9eSDN0ivUyHhNITBXxvQiqsw1rhD7gs5U6S4qplMZJxqPweD+pnmjnT4ifU+DRLQiQQz+ToqDAa8SeleFsZ1hUAw3T8rdMnOKu4vWBAuV6I7bLuEjLA0BEb66HdSAAkIdsDTIhRBErZ5840N0A29t1QD8eI7q3IjHqs1wsethoGKbasBdfANBHvEiRZwTxkhoFB0KkWE4nmNZszFBExiIipOqv5RZLC9pH7uXKHtpxHxBFo1zLWie8J5jeX4uLJ7fVgmVCjVevCUMiYCElFQC2GNh4v1cBExaFs1UULjzDLxJ1fR4YYJkRhgxA1APPZNbh0BqdTJKq4oFI4/taA2Ej4yT0DPxyJGNC3pjY7dlm4FhrI+jPWCbJnQEjKh2jHQl6SQvaH1pF61X+I3DIF356MdwhZl8b7eJd2dbww4OWroOk4kg1ggySZ00cUofFhtOtpSu+e0Wg83sxKR654ln593m5o6w9jk+5zatFM+aj3GdG7xFpkDmhaHuHhsJRpmm+m1Q8KX7QXMjoAcumN1c2hdfZBRMRm0Ery2g0mec6aBE86I5y+Yw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39850400004)(396003)(366004)(8676002)(4326008)(6486002)(66556008)(2906002)(956004)(6512007)(16526019)(86362001)(66476007)(26005)(31686004)(83380400001)(8936002)(53546011)(186003)(6506007)(31696002)(478600001)(316002)(110136005)(54906003)(7416002)(38100700002)(66946007)(2616005)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFRpN0hOWkszeEU5S0F6bTY2WEZBNWhZdVZrSklISnQ0eUJkREVPV05JQjZC?=
 =?utf-8?B?WU1CUzR0RWQ5QitXY3ZxS0sxNDV2bEVrbzh4cWFFdG52T2NxeFNXZVd6bldw?=
 =?utf-8?B?ZTBjOTl2WlozRFVkRmRpMjNyRFZkZ24yVWlGVUdVSUJPODNuRjVySlhYMFFS?=
 =?utf-8?B?NXRycy93QnVMSTNDQUZKM1lvRDZMV1pnQURGNU5NZCtCMndMTTQwYWVOK2p0?=
 =?utf-8?B?cW9NZ2ZhRFYwcHBDWXpxVnRaTFRjNU9SeTJzbW1aU3BMR3lKeEFwMy9iL29a?=
 =?utf-8?B?cDJucUNLSE9ReEpNRmlzdnMvczNkT291TjVzTGx3RC9YT3VBNTNPTy9zUDFs?=
 =?utf-8?B?Q1BUbkREUndaYkFXNENETCtDRDFiYjZBQmJqUG8vcUdTUi92T1Q0WCtweXRw?=
 =?utf-8?B?d0hqRDlrcnUycjFmOXRoOGVnQnFQYjh1ZEFIUHpQWHdFWGltaURDY3JKNHov?=
 =?utf-8?B?QmIrdXJqdkM5ZWY0aFBybTZZM0ZBd3F2VU54UzkyeE5jMUZuMjRlb0pmZDlr?=
 =?utf-8?B?L0VmV2NQeFZpTkdBdE4xSnBpR0ErOTU5Yi9QWUl5cmM0Sy9sSVZMWm44WGpW?=
 =?utf-8?B?RG9Zb1hUSHdlODBEWUJWTGgrZXBHbmhuUUtUL3hYUERkTllCZm1uN01Cd3ky?=
 =?utf-8?B?ZnRHeEhKd24zNlo0WWFOUjRGNG5iZzdkWk5nMjBIdVlCbEtmWXkxeng2eVpF?=
 =?utf-8?B?T0trNk1DdjR3M1hzSVcrZEZ3RnJaUzVGSUZFR0p4dElLUDdSNUgyQUR3a3FE?=
 =?utf-8?B?dWF1YlZ1ZENmLzdqdmp6bWFUN2J0Q1NkUjRRWVI0bmZLcktEdUlKcVcyT3Jj?=
 =?utf-8?B?Mzh3dGZjMEJDNHdtbUNMOFYyZ3lDQkp3MmVWZ3BpbmdsWDRYa0xVMzNEbmRP?=
 =?utf-8?B?aXI5aVo3RWdNZEF1V0FjSmVFdmQvQ2laYVR0a0x1LzlzbVNyZnRNUWtDQTJ4?=
 =?utf-8?B?VEs2OEpRbDljUjNwbXorWUp4ditYdlo5WjBsNDk4eTlvODg4djN4SWcwWExX?=
 =?utf-8?B?REJVdW9GZkdONGFaMGtBYnNwWWJwaWluWHdpMDgrMG5WY05ncUwrVytoc0xS?=
 =?utf-8?B?L2hac0VjakMyYzRpZzhEMXZJY0hwMU9wbzhZdlFmNjI0YmhpY0RmenJVOTJQ?=
 =?utf-8?B?bUVFSDg3YnJDWjFLd2dUa0NVMFgwTVcva3RpalZQaDIxNFJrZDVwcnlkeWx4?=
 =?utf-8?B?bDVleU5XcllvUElZYnQzWndPeW01M0RRKzRKTm1YQWRlYnhZaWRnQjZSOUtW?=
 =?utf-8?B?dHkxdmk5c1JrWWpBbFY4d2llVWJGbnpSMFp2QzRmVm5tRGhrd3FCaFZaUjN0?=
 =?utf-8?B?Y09vODVyT2hSSkk2dFRaMUZkaTlZaW1VWTVQYm5OSkxoTnZMb0NybFFZeENR?=
 =?utf-8?B?bGwzTXJxYlBReHNOaS9NWUZiODl1YlJkZmZlUE5FWlBxYmZiK24yTGpDQWRX?=
 =?utf-8?B?RjczL2VIVENCaHdkU3hHZVdXNG5NU0J3RlpZOFBWSXZVQkhTRXdDYWxaQ3N0?=
 =?utf-8?B?Z1RFTjQ2WWJkY1o2M1gzY0Q3dkhXWnpZYkx0Z3RjZEJ4TnpaUjNYUS8wTDRp?=
 =?utf-8?B?cWtPRFFFUEVCeDhVcWRpdU83STFBYzQydmxvbXVadnY3clBiM0c0TjVQcU5D?=
 =?utf-8?B?L29TbWFlemRNd1dXY2NlcktITmEvS0F4T3dYWm54UUVZT1hCQ3k0SExoOThM?=
 =?utf-8?B?SHpHUktQN0U1Ris0VHc2eFMzQi9meithVFA4emE1VkxINE1rZUxsNFQwS29a?=
 =?utf-8?Q?gg0Ta8FGYdeN5MdkUhXSLNXyNannJYEOs7P7Vc4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e7dc19-3c24-4be3-324b-08d92ce89627
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 14:52:51.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvLuPAfUOdHi7UWve7dv2SSUHJx7KVmKA/OqadBbdf0YgSYFRPbCVU6+yZz7HQEbph/cQWQVbc5SUsUeVULc+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 4:55 PM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
> index 8053b43298ff..2da70f58b208 100644
> --- a/arch/x86/mm/mem_encrypt_common.c
> +++ b/arch/x86/mm/mem_encrypt_common.c
> @@ -9,6 +9,7 @@
>  
>  #include <asm/mem_encrypt_common.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/swiotlb.h>
>  
>  /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>  bool force_dma_unencrypted(struct device *dev)
> @@ -21,3 +22,18 @@ bool force_dma_unencrypted(struct device *dev)
>  
>  	return false;
>  }
> +
> +/* Architecture __weak replacement functions */
> +void __init mem_encrypt_init(void)
> +{
> +	/*
> +	 * For TDX guest or SEV/SME, call into SWIOTLB to update
> +	 * the SWIOTLB DMA buffers
> +	 */
> +	if (sme_me_mask || prot_guest_has(PR_GUEST_MEM_ENCRYPT))
> +		swiotlb_update_mem_attributes();
> +
> +	if (sme_me_mask)
> +		amd_mem_encrypt_init();

The sme_me_mask is checked in amd_mem_encrypt_init(), so you should just
invoke amd_mem_encrypt_init() unconditionally.

Thanks,
Tom

> +}
> +
> 
