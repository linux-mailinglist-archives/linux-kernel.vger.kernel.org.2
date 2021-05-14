Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6720E38105E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhENTRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:17:11 -0400
Received: from mail-bn8nam08on2081.outbound.protection.outlook.com ([40.107.100.81]:37473
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229610AbhENTRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:17:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWRW7DMCmDuvHPEl9o1E0YQHqXgHs5h9MJ0BN1dbSeaI0cwczXD0nLH40qX4R1ENDPZ9H+bVZ+6IVvknuMDl/aHsaa91F+T/TEyuNw6t2sSOSs0Jb73WhGO3IpRHbof1IVQIj/R+umK9oHWaq2R/MoRWR2EcG9fV87Sb9A4pZR0vb977+S6Y+EKiPmuM3wNL8+gqvRE44pJvA9hKwGCRAFK3ifwlIeh3Jl+cALC9DXC68PtEmGuL243g/aZv1VGlYDS+r90wLYS6SsI71/Qa2h9/dOG2s1nE/QfN68RCUeaGdYLwkjawcI2TFUdoM8rykweRGy+IU5SdbQWWRH4V7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w7dIFusWkuXXz/Bsld8z57gTjsBzbvoAg6WIfzHmG4=;
 b=eF/DK2RsAMYGlQtYz7D9ZBKAKX/CfswM4CTCXieNb3yhQ+bL11bNZM90Ohri+s5B5tnNKPftdd81S1+V5pERz+KjjlAaNpxJZ9AIZmD/3wZLSUFuF2wtCPV37rE/nul1KwSEC6S/+EtYa3ivi0yTUGkGpn0PXN8pXH9s4Q+BzpVC+9eVLns73HEtdQUWiz/QqUenNXibN1cJispfY17qgZrA3YjbPiSuVrlRfxra7S6/ElBNIPELxljlnmNO3TM+BpvINPalvXLIZpP3ppRa+wS7s1Le6m6+B6XJsbl2v6/Jzpxlkexfn3AxzMecy5VJj8zhPo+bXvWJ4//hKV/zFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w7dIFusWkuXXz/Bsld8z57gTjsBzbvoAg6WIfzHmG4=;
 b=USQhpKtylj0Cmuk6X6QhI/+8MEz+JmUfnWqkeEshI0i0iW+47GUlTgSP6/gnlQ9zj8sE0gnYMQi9gdzve7YeY56Sq171bLONjwhJzdL32x2lSg/c/OwMOJM0dJVorpuPe7XPHQ3ENaYSPzYgct6WcXneHjj+BD25lmGVKCW8Sxw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB1866.namprd12.prod.outlook.com (2603:10b6:3:10c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 19:15:56 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4129.025; Fri, 14 May
 2021 19:15:56 +0000
Subject: Re: [PATCH] x86/sev-es: Invalidate the GHCB after completing VMGEXIT
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Joerg Roedel <jroedel@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <fa408ec4020d7ab056875ec8c80d793b75f20a39.1621019553.git.thomas.lendacky@amd.com>
Message-ID: <2d6cdc7d-2da5-018b-45bc-6e3a87684c9e@amd.com>
Date:   Fri, 14 May 2021 14:15:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <fa408ec4020d7ab056875ec8c80d793b75f20a39.1621019553.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA0PR11CA0096.namprd11.prod.outlook.com
 (2603:10b6:806:d1::11) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SA0PR11CA0096.namprd11.prod.outlook.com (2603:10b6:806:d1::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 19:15:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5991d167-5979-4a0c-cae6-08d9170cb314
X-MS-TrafficTypeDiagnostic: DM5PR12MB1866:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1866541EEFB0B53058E09D7EEC509@DM5PR12MB1866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Wp9s3uFIx29jFZaw3vZsKuf71uu1GlvAaj9HWkJqtn6vJbfm5n2h+eJhaFW4Sit7Y9n2+Ne7h3CMf0yUFeUae2DtIPjS05vYQNFI498T/ZluPdwqPYXOHE+gpi36W147TYFATwtvmxpBElO1wP1OZa8r9j+tv060lDqiSWtTIbmN0lnUcnmKXL0t1QZ7eNsI1wx7N0iEQIZBS6mGZn4xM4c/DzQjY6g7S0O2V7ZgdnWsGmhSibPjWhG5vGdnDgmP1EKpt2cdP5ia2pSis6acObE0VjtxQ+2dxorR8UAegUh6j2gl2ZmFg/aEfImA/9epXQR+HHp0v6dS5RaWk9nUpNSIGB2koeA0LMwoG9M32Y2wLlCPANKCWINALQp+twThIweAUd4Yf8CuUfi0NMwFkRLYFgMPsAZSZw1Ly4voFYtbx2kn3kutU8l5bIMVRJdMUHJfM0efW50SpUwIfBQDjyxNx4H+N9m/TYV8IaEDA84GaqPUCtAO/3g+f63RcDgRWy5TBxm+ToRHl3c+2olGzefocf+5zV11FpwvVSvPKWQGLc0nrQQbwH5Vd4rxEL1oDYSwpyr0JCnoXFdcb7bNqt8T2H3wrv9JwpCHNCzMEn77LKq27CDFQzyJx09TtlBeaXvttUN3duSNNlNKSFaQb31yJ/5piF75UFPODHMfF/9/d85AXZwLhNR68Ru+sJ7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(4326008)(66556008)(66476007)(7416002)(478600001)(36756003)(2616005)(86362001)(5660300002)(6506007)(53546011)(31686004)(16526019)(66946007)(8936002)(38100700002)(26005)(6486002)(186003)(8676002)(54906003)(6512007)(316002)(956004)(31696002)(83380400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K2JvdUsya0NoZjB5ZlJhNFpuanJNZkVrMjRnS01haU5GVWphdTYwY09tTVN6?=
 =?utf-8?B?MmxZbDdCU1g5SmpzRUhCV0tXOEFwUEdHdG1FZDByOXVHYVJ2b1dPaFV0T2ds?=
 =?utf-8?B?bEtqd2RGejlNZHZEOElaVWhSTm1pcngwS3dIZHB6UlpvRW5sZmwrTEZKOUVF?=
 =?utf-8?B?VzBpSnR0YTVManY4UkVTWndtV2p0UGR1MThaR1NTUEhwbDdNclZXcUdyVjdX?=
 =?utf-8?B?WHpTeHJ2K3VUb2JXUURhOUpEZ2IxbDJnNWNIS0prOTVkWWw1L25jYlFkNXR3?=
 =?utf-8?B?SDh0emJtNHIzMlpacTRWV3VIQnUvSkFJUDJxOUZ0ZUFMdnBpZmtoNVBScnl3?=
 =?utf-8?B?OFNrcmZzcFgwdnFqcjY5enZDQnNyS2Y1K2F6WWwwaGk2bWpEVDhLYWFUNlU1?=
 =?utf-8?B?S25CeSs3dE04U3hqeDhLVlJGMXNBdFpWb0UrdXlCcm9ob2xNbnU1dFJGZE1I?=
 =?utf-8?B?V0xxUTd5S0dsQTQrZldxMUpwVDdiSjNCTEtaU1VOTUVTSWZwajBnR24xZDJW?=
 =?utf-8?B?ZjQ0K0dKWWdVUGoyVFFmbU9Fd1IyckpQM2s4L0tCMHVVMWpBT3IrN2daa0V6?=
 =?utf-8?B?VDRnZ1U5Y3hyQnBBVkFmNklrQndpamI4blkwYTZlOHRDVGYxZytPSU9ueVhG?=
 =?utf-8?B?QnJwd3lxUDczVitoazBnNVBjVWRHakF4cVdnM0xvMHJ1Z3NLWiswZ0tjMXlv?=
 =?utf-8?B?NGV0S3dWYURMNnIrWTl3akw0UXJvUlo3Z1JWZEYyOVBudTVVNmpwUS9pbHlD?=
 =?utf-8?B?YmVhcmFodXNXb2lFaWtYN0xYb1czcGhYRlI1QjVGWWdlUEtLQzJVY3ZucjN4?=
 =?utf-8?B?eTEvQW9kSVIzWUp4T2Fka2NEaGc5MzlDVUZNTjB0T2VEckswd01GU3FaQy9t?=
 =?utf-8?B?OEhQMzRjMzhzREpjRGFkNTRBc3VhY3YrT3Q5SjYrUWRrMDV4OXZ3MlFkTkZy?=
 =?utf-8?B?YnJlSW14QkZYQzBlcEErWjFzYjhuWnpnQ3dxZlcwWTZxR0EyTXN3TUdwNnI5?=
 =?utf-8?B?SlNmaDlWTFgyaWJyNmU2Q3VHaFJWNS96YmdoQktQN0d1cFJtdUhGbE8zRXlz?=
 =?utf-8?B?NlNyai9jK3BGYzZnWVpYUmNhQXAwbEVDVlRxWWhhMVhpL1NzU0RqNGVJZVlk?=
 =?utf-8?B?U09ZYjdGNm11YnJJQzZzT1FJZkxQOG1pVGVtUERCMmN2djVWSUJ6eGFnT3ls?=
 =?utf-8?B?ZGh2Z1cvN3lMK24rTUpNK3kxQUR2MDUrWnJ6dmRiSmU5YVo2R1Zsaml2S2Nh?=
 =?utf-8?B?cktOaUhObXNab2xHTkk0SWZCWkNPMVUvRDhZaVhUSk03K254SGZlTndMcmR4?=
 =?utf-8?B?M0ljeW9ET2dEZVZGbXFidjFkWmFBWk5FeHkvRXBzcmN3SFpWd2dmeTlTM0pr?=
 =?utf-8?B?M0M2NmVONFZIT2Q1dzZRQmpkYUpvTGsrdUtTUlR5TGY1eEFacFkrZ01aRzZ4?=
 =?utf-8?B?V0VmR3REeVcvL2NaUVpFUVh0d2t3NGQ4Y21JYnFWVyt5R1loc2RJcklRZ2xS?=
 =?utf-8?B?WHBROXZha0tvQ0xEWlFGSXhPUWpvTFVkaEhNemR3cGVxMk90UjVXeE5SRy9Z?=
 =?utf-8?B?cUdUOGlQT0hYeFpFRnNRQ1pEQ2pFRk56NlBFcGMvbFhKNmVrQnh4Rm02K0RE?=
 =?utf-8?B?TnlXMVJENmtFUFI0aXhkenZSbisvRFlmS2RpL2ZyaEpUcDNMbytnSnA0SXUz?=
 =?utf-8?B?Z01OOUFGSElxck5tdk4vbis4ZVFLTHRNS28xeFdXZzRUb3huU1hIMTBiaWta?=
 =?utf-8?Q?ziulgo7RhTjA04FzuC6mtOuDaZTm7l1IIDIy/Zj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5991d167-5979-4a0c-cae6-08d9170cb314
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 19:15:56.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1tF1cZMmL+Nz4I11VKuw1Vlr9m9MDg4Sq33p16vDAbtlANOD1I51pl+o1VNZ9G1svadCSeVgIqSu2BX+q1NKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1866
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 2:12 PM, Tom Lendacky wrote:
> Since the VMGEXIT instruction can be issued from userspace, invalidate
> the GHCB after performing VMGEXIT processing in the kernel.
> 
> Invalidation is only required after userspace is available, so call
> vc_ghcb_invalidate() from sev_es_put_ghcb(). Update vc_ghcb_invalidate()
> to additionally clear the GHCB exit code, so that a value of 0 is always
> present outside VMGEXIT processing in the kernel.
> 
> Since vc_ghcb_invalidate() is part of sev-shared.c, move sev_es_put_ghcb()
> down to after where sev-shared.c is included.
> 
> Fixes: 0786138c78e79 ("x86/sev-es: Add a Runtime #VC Exception Handler")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/sev-shared.c |  1 +
>  arch/x86/kernel/sev.c        | 37 ++++++++++++++++++------------------
>  2 files changed, 20 insertions(+), 18 deletions(-)

I was debating whether to do this as two patches, with the first patch
moving sev_es_put_ghcb() and then the second patch would more clearly show
the changes related to the invalidation.

Let me know if that would be preferred and I'll re-submit this as a
two-patch series.

Thanks,
Tom

> 
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 6ec8b3bfd76e..9f90f460a28c 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -63,6 +63,7 @@ static bool sev_es_negotiate_protocol(void)
>  
>  static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
>  {
> +	ghcb->save.sw_exit_code = 0;
>  	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
>  }
>  
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 9578c82832aa..5ccb0218c885 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -221,24 +221,6 @@ static __always_inline struct ghcb *sev_es_get_ghcb(struct ghcb_state *state)
>  	return ghcb;
>  }
>  
> -static __always_inline void sev_es_put_ghcb(struct ghcb_state *state)
> -{
> -	struct sev_es_runtime_data *data;
> -	struct ghcb *ghcb;
> -
> -	data = this_cpu_read(runtime_data);
> -	ghcb = &data->ghcb_page;
> -
> -	if (state->ghcb) {
> -		/* Restore GHCB from Backup */
> -		*ghcb = *state->ghcb;
> -		data->backup_ghcb_active = false;
> -		state->ghcb = NULL;
> -	} else {
> -		data->ghcb_active = false;
> -	}
> -}
> -
>  /* Needed in vc_early_forward_exception */
>  void do_early_exception(struct pt_regs *regs, int trapnr);
>  
> @@ -461,6 +443,25 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
>  /* Include code shared with pre-decompression boot stage */
>  #include "sev-shared.c"
>  
> +static __always_inline void sev_es_put_ghcb(struct ghcb_state *state)
> +{
> +	struct sev_es_runtime_data *data;
> +	struct ghcb *ghcb;
> +
> +	data = this_cpu_read(runtime_data);
> +	ghcb = &data->ghcb_page;
> +
> +	if (state->ghcb) {
> +		/* Restore GHCB from Backup */
> +		*ghcb = *state->ghcb;
> +		data->backup_ghcb_active = false;
> +		state->ghcb = NULL;
> +	} else {
> +		vc_ghcb_invalidate(ghcb);
> +		data->ghcb_active = false;
> +	}
> +}
> +
>  void noinstr __sev_es_nmi_complete(void)
>  {
>  	struct ghcb_state state;
> 
