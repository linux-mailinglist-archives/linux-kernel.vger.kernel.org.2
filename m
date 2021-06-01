Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F160397BEF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhFAV4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:56:17 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:49760
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234698AbhFAV4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:56:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZ1UD9rBpVhD7blZRZXQPr7Xz3Iud7E8ea8UGaI+XSFAWDVcRU8L/XTqSxC4DEC/Z7h2PuZVhpngRSjuUMHczPUkFbvfxnRNTtYRNVbbPc6EmC7Ex66La062OYB3pxHVzROk32XjbwXJ6xwk/9Ug1QC0iU+wROdgwP4Ispn+Xphz/WUoMdB4uNsEVmzOBdDJOMOh/uFUb9rXTAZ7vyN7tP3Rh8mY3It3fGwv9Fwri0M1GVjAJjmdyLld355fteWcXlOiskfKrZWfTobpxTbYQal51YPp4QnJXp/cH3kqlZJFjiw2OJBNCkT1pjedxHBTAV1eXjHzZSNlqU/iLeEjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7c59FXEQ/lTRzFIDqYmrUs05wsQvy036XfgzGiMp4c=;
 b=T75Rv5HLrFofipKMpN0CX0oWkdiZ/xFy7jJ8xQBDUy1uTYXkiEvlxn5JFjDAuVUv6aSEva9w58yMojApVOPru3isQE4jTICO0PIAb9M8HuSdfHzIFEhF3ppSFPEHeZzGPcXWkrtqC7fpbqXDCkqRfTli4bX0VwPyh5fx5HZ8wBntpDdk+y6VvtUMHZlYQ6eOAx1YBQO2udf3iK1VWtAYCR5USI7qxZ7AKdRDvORTDzVSu+rwR71w31olWf4dqwq/qOcI2n67ic/te2Efh5V2mpXkC24p/e3KY2fD/xuBkyIobdMloBNenzogjD0xVEbGIfUQSiI6OYsw8x3o/OeeVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7c59FXEQ/lTRzFIDqYmrUs05wsQvy036XfgzGiMp4c=;
 b=BEOfJMz6WrzvhlEeIgSP24viKX3/rmHd/F06i1LkfVo5Jd7wYOD4jK1m61F2V0tSdIT5Eboauo+Kg4rIWzLh10D03OM4x8J+iJJIEhtAm3+CkQAjeWeWRBrf09okRInx9EWHTARf39p8PnNuatwYDdhDZyVki2DRTG+uQQP+W/0=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 21:54:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 21:54:31 +0000
Subject: Re: [PATCH 4/5] x86/pkeys: replace PKRU modification infrastructure
To:     Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, luto@kernel.org, shuah@kernel.org,
        dave.kleikamp@oracle.com, linuxram@us.ibm.com,
        bauerman@linux.ibm.com, bigeasy@linutronix.de
References: <20210527235109.B2A9F45F@viggo.jf.intel.com>
 <20210527235118.88C9831B@viggo.jf.intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <0f98bc0a-3ee4-3fe9-f7c6-9c2b873bec38@amd.com>
Date:   Tue, 1 Jun 2021 16:54:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210527235118.88C9831B@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0701CA0046.namprd07.prod.outlook.com
 (2603:10b6:803:2d::33) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN4PR0701CA0046.namprd07.prod.outlook.com (2603:10b6:803:2d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 1 Jun 2021 21:54:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 331d9b77-87dd-4101-e002-08d92547d5da
X-MS-TrafficTypeDiagnostic: MW3PR12MB4460:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4460AE3A8136A2B75BB3AC31953E9@MW3PR12MB4460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wt06vPuP/IbMtCY+h7z6iDoIfeT2PCLvYnnH3alC07zBTEgE59YDcPv0xUOaXJkfVdnqwnh1WwCIG6Pkhpmc+Cmk0iyOEcywZCtud6gBY6F9dZaOByAYLk4f+5uT4YVWQ7eFIoPhvAHH1979a+QKFTDI1VK7rpsdiomWDJxwTEhAc7XjoZiBnyRbBXBbugqV/VBZbdwk/C2nrGbC367eMh+ootjV6pLpuroVy+Sz15W8XJ43HKL0hGqi10mvYN2566a3PNa2RpgLj/BAGEQsR2LTbJExk9LSI38q6avD9kz5+cX3hqCo8JJikcb4kSw3cvDWzInVg65FXBV48dFQkYJMlc1FAI3o0gEqdrZMqI3KTP4QaTx+E8pr6bDPq2i4cJb6K6XX0zrXtFZyU2vpiMGC2P8PI8kyw8Y4Jqj1UpL5kRQfUM3R1cwv7YDRtZAftcSNcqH0k0Nbbc6dTqgAd9KUV5DC0AhMz59yvi91JCSGR2bee8Gu+E3OftkAvlxgKJVfvyWHLiov5REqBD2KqufFs+pbYONkG9B3bnid8KMpmzvfFcP4wtG4KFpXkLPgymViJDe4uFXZoBmSUKNREh6Cc+jAEcIBkZPioKbEu+jmfNrsvAf0XqvyxoSpZnv7Mcv+GUDNwPlvp/tTAL3OXpp+XvL7zyNmMYhjXH0jVfVkk4PxrB3Sd6kzhQlPL7Obxy/tIQM6KURlmnioIHUZvRMrWmuK7ZXJfnS9X3PuN+CrLNH5YTA+5+L1odEsNmtOtUmQ+uzt0eR3S5/ie2CdxQ/UGnEY9yGnIpvFzJvk1qqWbFt+F/qRKvY8AeaI1f2YTSlYqCkoc/KdvGWvcQY4pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39850400004)(5660300002)(53546011)(316002)(4326008)(30864003)(38100700002)(52116002)(38350700002)(16576012)(956004)(44832011)(31696002)(186003)(36756003)(83380400001)(8676002)(26005)(86362001)(66476007)(31686004)(478600001)(6486002)(966005)(16526019)(66946007)(66556008)(2616005)(7416002)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U1EzMTdNaWRLOTNIWGJzS283MU40aG1QSlJ2VFhmR3ZZV1p3akJVMDdBNGRT?=
 =?utf-8?B?enpOam9Eb0NodHB2Zm95MHlOQmFSd0NmbHdtRUhhbytOQnp1WXR2anNHdkhm?=
 =?utf-8?B?cjl4ejUweklvSUhab0hocEpUQ24wcmhaYjE3WE1TWHVnSE4rUmN3czhuMkEz?=
 =?utf-8?B?SVZadEx0WFVlTjFqMUg5alVmT3ZBN0QxOHluTy9HSEx5ZFJjeHdTMi9IR1FO?=
 =?utf-8?B?WFNqek1xMm42TTBHWlpyNi9sckVHMG92LytPOEFxQytaSEcwdEowLzRVQTI0?=
 =?utf-8?B?N0svWFEwSDVtbVZhSUlyOXc2cG5WVHFJRzgwV1dRTDlBR0U5bytCdy9RcENS?=
 =?utf-8?B?QmxEM3d5THV2TnVuWnFUTkJnUkFNWXpYNHJSR2VNQWxCS0ZsSlBURm1VK01w?=
 =?utf-8?B?TEZxa0RRMXR5alJIOW1Vak15NXV4c1pseVNRL0EzOGFzSmtBUm5MRUtKd1FW?=
 =?utf-8?B?aUxRUzdzWXViZlFXcVB6RmFTdmx1RDVwZGJ1NGNIUjBhVjRhS21rVkIvUVlp?=
 =?utf-8?B?UVhGRXc3OFg5Rzg5aHJVbWJpa053Rmo3TVViM3ZOWUVET3M1dDF6RnJOUkhE?=
 =?utf-8?B?VDhDL2dITXpMZTBjQjMxQlBteWx1K1YrNVFsck1Md082Ym1GUE4yL2JQZnNZ?=
 =?utf-8?B?NGtqMjlPSTZpY0lBdzk0VUNyZzkvSmRzdXdsQkZESWwvT2hiMjMyTmMzWkpx?=
 =?utf-8?B?N0pETFNKT2REQ0ZyekZWSDFkbkZKVm4xSW1ULzdpRjZ0STRkdGNweFNYUktN?=
 =?utf-8?B?NlZZOHF1REhWV3pwMjJ2RytjWVQyaTJHbHljTVl6c0lCUzR3akdaUDdkeEg0?=
 =?utf-8?B?bGJ2cTBiR2svai9ZUDE1SnY5WjdIV2hMa0FDTE1SWWlJd1VNR1RzVVQ3RE54?=
 =?utf-8?B?bEZkeE1OQ3c2WmI3SU82ditDR2pRa2dlcVc2blBaWTgvM1ExS1UzeVZyNmlJ?=
 =?utf-8?B?ZFBjRERTSjh6ZVZHQnlDRU5sZFNnWEpZRXZSSWg1Rm5tTTJuSVMzSzh2S3Nq?=
 =?utf-8?B?UCtTOUZtNVEvdFk3N3NLS2xPZGVIdEJJUzMvSUhSbWlMaXFzcmZnMzhlaG9s?=
 =?utf-8?B?TWdiUk9GaXgvRkNtb2llUlZHdFJvbFRXeW9RaFQ1MFpEUnljeWJ5WGdraHdX?=
 =?utf-8?B?NlRDWkw2c3kweHRVR2ljZzE3V0ljRGd2Q0hZL0JuajMvaUJacXpMdFNENTJ6?=
 =?utf-8?B?djh0WmdsTHZGdGRQdXlNemJrRXJZK2tERGZseGduTm9GbjZ4MElhTVFwREZ3?=
 =?utf-8?B?bDdiaUJiNWE3L1g3R0FhU3c3RTUyUDFJbTZhNm1kbitDcnhTZFJ5NjBHdnZC?=
 =?utf-8?B?YlNHTDRXQWtrcmZ6OCt3dC84YVBjQ05YY2RYbE1FRXlXbVZqelk5MVdFRjBk?=
 =?utf-8?B?RXpIc0RsbXEvTFpOR2VMUHFWNmZUZTgxcWNFWFVSL1FHbHUzYWhLOHhoRjkz?=
 =?utf-8?B?TGhBd3o3UmhEWjFtWUhzaUpBQU1lcVlialFzcEZ1L3pReS9oL0haU1VhbXhN?=
 =?utf-8?B?QjdRbDJrbHdNQVhnam93SG4rZnduWUxVVm55Vm9naEhJZCt3VnZ1d1hFdWd1?=
 =?utf-8?B?bWg3Y0NGR1hoWGh6dnk4MXY0VW41NEZqSThTL2tRVmlYUGp5T0pETkg2WTB5?=
 =?utf-8?B?Q3hrcXc0ZVVzVmN0ektxNndRbnNtRnpDaDJ0TG1rOWcybnBGc002MVhIdkdv?=
 =?utf-8?B?OG9jdmpzWjRFRWI1NVFacnd5dVBMTjRvbXh2ZHo2cW5RZ0ROVVlDU3A3WGtX?=
 =?utf-8?Q?6k4N4Ha7Hs7eeuNnyCLuGhfm7fb2tyVahNFQGY8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331d9b77-87dd-4101-e002-08d92547d5da
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 21:54:31.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQZgv+FqQyIltcPtvmpdWe7y/O7G1dY/dRwWj0ONZsSQX6AZ6SIbX4hKn1rNcced
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,
Thanks for the patches and trying to address the issues.

I know these patches are in early stages and there is still a discussion
on different ways to address these issues. But I wanted to give a try anyway.

Tried to boot the system with these patches. But system did not come up
after this patch(#4). System fails very early in the boot process. So, I
could'nt collect much logs. It failed both on AMD and Intel machines.
I will try to collect more logs.
Thanks
Babu

On 5/27/21 6:51 PM, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> There are two points in the kernel which write to PKRU in a buggy way:
> 
>  * In switch_fpu_finish(), where having xfeatures[PKRU]=0 will result
>    in PKRU being assigned 'init_pkru_value' instead of 0x0.
>  * In write_pkru(), xfeatures[PKRU]=0 will result in PKRU having the
>    correct value, but the XSAVE buffer will remain stale because
>    xfeatures is not updated.
> 
> Both of them screw up the fact that get_xsave_addr() will return NULL
> for PKRU when it is in the XSAVE "init state".  This went unnoticed
> until now because on Intel hardware XINUSE[PKRU] is never 0 because
> of the kernel policy around 'init_pkru_value'.  AMD hardware, on the
> other hand, can set XINUSE[PKRU]=0 via a normal WRPKRU(0).  The
> handy selftests somewhat accidentally produced a case[2] where
> WRPKRU(0) occurs.
> 
> get_xsave_addr() is a horrible interface[1], especially when used for
> writing state.  It is too easy for callers to be tricked into thinking:
>  1. On a NULL return that they have no work to do
>  2. On a valid pointer return that they *can* safely write state
>     without doing more work like setting an xfeatures bit.
> 
> Wrap get_xsave_addr() with some additional infrastructure.  Ensure
> that callers must declare their intent to read or write to the state.
> Inject the init state into both reads *and* writes.  This ensures
> that writers never have to deal with detritus from previous state.
> 
> The new common xstate infrastructure:
> 
> 	xstatebuf_get_write_ptr()
> and
> 	xfeature_init_space()
> 
> should be quite usable for other xfeatures with trivial updates to
> xfeature_init_space().  My hope is that we can move away from
> all use of get_xsave_addr(), replacing it with things like
> xstate_read_pkru().
> 
> The new BUG_ON()s are not great.  But, they do represent a severe
> violation of expectations and XSAVE state can be security-sensitive
> and these represent a truly dazed-and-confused situation.
> 
> 1. I know, I wrote it.  I'm really sorry.
> 2. https://lore.kernel.org/linux-kselftest/b2e0324a-9125-bb34-9e76-81817df27c48@amd.com/
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Fixes: 0d714dba1626 ("x86/fpu: Update xstate's PKRU value on write_pkru()")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Babu Moger <babu.moger@amd.com>
> Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
> Cc: Ram Pai <linuxram@us.ibm.com>
> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
>  b/arch/x86/include/asm/fpu/internal.h |    8 --
>  b/arch/x86/include/asm/fpu/xstate.h   |  111 +++++++++++++++++++++++++++++++---
>  b/arch/x86/include/asm/processor.h    |    7 ++
>  b/arch/x86/kernel/cpu/common.c        |    6 -
>  b/arch/x86/mm/pkeys.c                 |    6 -
>  5 files changed, 115 insertions(+), 23 deletions(-)
> 
> diff -puN arch/x86/include/asm/fpu/internal.h~write_pkru arch/x86/include/asm/fpu/internal.h
> --- a/arch/x86/include/asm/fpu/internal.h~write_pkru	2021-05-27 16:40:26.903705463 -0700
> +++ b/arch/x86/include/asm/fpu/internal.h	2021-05-27 16:40:26.919705463 -0700
> @@ -564,7 +564,6 @@ static inline void switch_fpu_prepare(st
>  static inline void switch_fpu_finish(struct fpu *new_fpu)
>  {
>  	u32 pkru_val = init_pkru_value;
> -	struct pkru_state *pk;
>  
>  	if (!static_cpu_has(X86_FEATURE_FPU))
>  		return;
> @@ -578,11 +577,8 @@ static inline void switch_fpu_finish(str
>  	 * PKRU state is switched eagerly because it needs to be valid before we
>  	 * return to userland e.g. for a copy_to_user() operation.
>  	 */
> -	if (current->mm) {
> -		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
> -		if (pk)
> -			pkru_val = pk->pkru;
> -	}
> +	if (current->mm)
> +		pkru_val = xstate_read_pkru(&new_fpu->state.xsave);
>  	__write_pkru(pkru_val);
>  
>  	/*
> diff -puN arch/x86/include/asm/fpu/xstate.h~write_pkru arch/x86/include/asm/fpu/xstate.h
> --- a/arch/x86/include/asm/fpu/xstate.h~write_pkru	2021-05-27 16:40:26.906705463 -0700
> +++ b/arch/x86/include/asm/fpu/xstate.h	2021-05-27 16:40:26.919705463 -0700
> @@ -124,27 +124,124 @@ static inline u32 read_pkru(void)
>  	return 0;
>  }
>  
> +static inline void xfeature_mark_non_init(struct xregs_state *xstate,
> +					  int xfeature_nr)
> +{
> +	/*
> +	 * Caller will place data in the @xstate buffer.
> +	 * Mark the xfeature as non-init:
> +	 */
> +	xstate->header.xfeatures |= BIT_ULL(xfeature_nr);
> +}
> +
> +
> +/* Set the contents of @xfeature_nr to the hardware init state */
> +static inline void xfeature_init_space(struct xregs_state *xstate,
> +					     int xfeature_nr)
> +{
> +	void *state = get_xsave_addr(xstate, xfeature_nr);
> +
> +	switch (xfeature_nr) {
> +	case XFEATURE_PKRU:
> +		/* zero the whole state, including reserved bits */
> +		memset(state, 0, sizeof(struct pkru_state));
> +		break;
> +	default:
> +		BUG();
> +	}
> +}
> +
> +/*
> + * Called when it is necessary to write to an XSAVE
> + * component feature.  Guarantees that a future
> + * XRSTOR of the 'xstate' buffer will not consider
> + * @xfeature_nr to be in its init state.
> + *
> + * The returned buffer may contain old state.  The
> + * caller must be prepared to fill the entire buffer.
> + *
> + * Caller must first ensure that @xfeature_nr is
> + * enabled and present in the @xstate buffer.
> + */
> +static inline void *xstatebuf_get_write_ptr(struct xregs_state *xstate,
> +					    int xfeature_nr)
> +{
> +	bool feature_was_init = xstate->header.xfeatures & BIT_ULL(xfeature_nr);
> +
> +	/*
> +	 * xcomp_bv represents whether 'xstate' has space for
> +	 * features.  If not, something is horribly wrong and
> +	 * a write would corrupt memory.  Perhaps xfeature_nr
> +	 * was not enabled.
> +	 */
> +	BUG_ON(!(xstate->header.xcomp_bv & BIT_ULL(xfeature_nr)));
> +
> +	/*
> +	 * Ensure a sane xfeature_nr, including avoiding
> +	 * confusion with XCOMP_BV_COMPACTED_FORMAT.
> +	 */
> +	BUG_ON(xfeature_nr >= XFEATURE_MAX);
> +
> +	/* Prepare xstate for a write to the xfeature: */
> +	xfeature_mark_non_init(xstate, xfeature_nr);
> +
> +	/*
> +	 * If xfeature_nr was in the init state, update the buffer
> +	 * to match the state. Ensures that callers can safely
> +	 * write only a part of the state, they are not forced to
> +	 * write it in its entirety.
> +	 */
> +	if (feature_was_init)
> +		xfeature_init_space(xstate, xfeature_nr);
> +
> +	return get_xsave_addr(xstate, xfeature_nr);
> +}
> +
> +/* Caller must ensure X86_FEATURE_OSPKE is enabled. */
> +static inline void xstate_write_pkru(struct xregs_state *xstate, u32 pkru)
> +{
> +	struct pkru_state *pk;
> +
> +	pk = xstatebuf_get_write_ptr(xstate, XFEATURE_PKRU);
> +	pk->pkru = pkru;
> +}
> +
> +/*
> + * What PKRU value is represented in the 'xstate'?  Note,
> + * this returns the *architecturally* represented value,
> + * not the literal in-memory value.  They may be different.
> + */
> +static inline u32 xstate_read_pkru(struct xregs_state *xstate)
> +{
> +	struct pkru_state *pk;
> +
> +	pk = get_xsave_addr(xstate, XFEATURE_PKRU);
> +	/*
> +	 * If present, pull PKRU out of the XSAVE buffer.
> +	 * Otherwise, use the hardware init value.
> +	 */
> +	if (pk)
> +		return pk->pkru;
> +	else
> +		return PKRU_HW_INIT_VALUE;
> +}
> +
>  /*
>   * Update all of the PKRU state for the current task:
>   * PKRU register and PKRU xstate.
>   */
>  static inline void current_write_pkru(u32 pkru)
>  {
> -	struct pkru_state *pk;
> -
>  	if (!boot_cpu_has(X86_FEATURE_OSPKE))
>  		return;
>  
> -	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
> -
> +	fpregs_lock();
>  	/*
>  	 * The PKRU value in xstate needs to be in sync with the value that is
>  	 * written to the CPU. The FPU restore on return to userland would
>  	 * otherwise load the previous value again.
>  	 */
> -	fpregs_lock();
> -	if (pk)
> -		pk->pkru = pkru;
> +	xstate_write_pkru(&current->thread.fpu.state.xsave, pkru);
>  	__write_pkru(pkru);
>  	fpregs_unlock();
>  }
> diff -puN arch/x86/include/asm/processor.h~write_pkru arch/x86/include/asm/processor.h
> --- a/arch/x86/include/asm/processor.h~write_pkru	2021-05-27 16:40:26.908705463 -0700
> +++ b/arch/x86/include/asm/processor.h	2021-05-27 16:40:26.921705463 -0700
> @@ -854,4 +854,11 @@ enum mds_mitigations {
>  	MDS_MITIGATION_VMWERV,
>  };
>  
> +/*
> + * The XSAVE architecture defines an "init state" for
> + * PKRU.  PKRU is set to this value by XRSTOR when it
> + * tries to restore PKRU but has on value in the buffer.
> + */
> +#define PKRU_HW_INIT_VALUE	0x0
> +
>  #endif /* _ASM_X86_PROCESSOR_H */
> diff -puN arch/x86/kernel/cpu/common.c~write_pkru arch/x86/kernel/cpu/common.c
> --- a/arch/x86/kernel/cpu/common.c~write_pkru	2021-05-27 16:40:26.912705463 -0700
> +++ b/arch/x86/kernel/cpu/common.c	2021-05-27 16:40:26.924705463 -0700
> @@ -466,8 +466,6 @@ static bool pku_disabled;
>  
>  static __always_inline void setup_pku(struct cpuinfo_x86 *c)
>  {
> -	struct pkru_state *pk;
> -
>  	/* check the boot processor, plus compile options for PKU: */
>  	if (!cpu_feature_enabled(X86_FEATURE_PKU))
>  		return;
> @@ -478,9 +476,7 @@ static __always_inline void setup_pku(st
>  		return;
>  
>  	cr4_set_bits(X86_CR4_PKE);
> -	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
> -	if (pk)
> -		pk->pkru = init_pkru_value;
> +	xstate_write_pkru(&current->thread.fpu.state.xsave, init_pkru_value);
>  	/*
>  	 * Seting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
>  	 * cpuid bit to be set.  We need to ensure that we
> diff -puN arch/x86/mm/pkeys.c~write_pkru arch/x86/mm/pkeys.c
> --- a/arch/x86/mm/pkeys.c~write_pkru	2021-05-27 16:40:26.914705463 -0700
> +++ b/arch/x86/mm/pkeys.c	2021-05-27 16:40:26.926705463 -0700
> @@ -155,7 +155,6 @@ static ssize_t init_pkru_read_file(struc
>  static ssize_t init_pkru_write_file(struct file *file,
>  		 const char __user *user_buf, size_t count, loff_t *ppos)
>  {
> -	struct pkru_state *pk;
>  	char buf[32];
>  	ssize_t len;
>  	u32 new_init_pkru;
> @@ -178,10 +177,7 @@ static ssize_t init_pkru_write_file(stru
>  		return -EINVAL;
>  
>  	WRITE_ONCE(init_pkru_value, new_init_pkru);
> -	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
> -	if (!pk)
> -		return -EINVAL;
> -	pk->pkru = new_init_pkru;
> +	xstate_write_pkru(&init_fpstate.xsave, new_init_pkru);
>  	return count;
>  }
>  
> _
> 
