Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0CC393AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 03:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhE1BSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 21:18:50 -0400
Received: from mail-eopbgr130049.outbound.protection.outlook.com ([40.107.13.49]:37601
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233887AbhE1BSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 21:18:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIefpSA9g9/PUC7/oRnWL046Fn3TYUtUfneHdCuC+MeX5D+qEXXMlHa/HgOMoZ9QadXWhXdmdMNITDhJmGUJwrVVEEq6M/dDIY15pl3Vz2wbVPlk2D92b7Kg9RFgkdEFsSGI2UYgih1tYRawY/1XNc9eg2qody4I7KpaOXgESMl91fGMng50OyRv2mJrfWlQ1A1RQFyRO8Z7AJskTg6uOl1WGJOVcc2x2nQNyw7DrpF+/vTgBGrZzHkDiLJ33C1UOy/S7isaU0cEsa3VDmgRSPVBha5PWAJ680ara1boq3V4JstgFN30UmGGShISEBr2K4zdRDHeij1MHgjV6JFnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74NuFYviUa6SKUYUa6Iz6rqCK5k4uZwSkfIWJ2refNw=;
 b=VQI8PfUJRCVMiv6ePK1gSoPn9cVUQizgP+JNvMmNlJoWrQUjv+x7qvrDGJbjl8jxCEbDy77DLSjHZ+tnCQMZL3bFu94JkmLTsNDzzX0WrDRG2XsZrDJFYi+BkgYkKEIT95fOaJbhZf21G7WVLnlAd+Ki/71M4Vkd7/Q7VskTggR8T/pnTnfQaZYsCxGUcBKWHp1f/CY+3unolXN0WUmZ9CNd5gnGknuwd/FLAPuZhd7phk2zKyfP9QYimEnzZkyiVv0h9C6LpDD5zG4VhgM/gpJAdUj4D/deKtqFXsFx6EgethIXuk5WG3f1hNqXWeItMMJ0y4RBeuCrxce+OgzP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74NuFYviUa6SKUYUa6Iz6rqCK5k4uZwSkfIWJ2refNw=;
 b=XEG4uhbmpbFWGXeaKEZdNtNSlXI0gL2ijgjN8wm7xAB7NBQQb5FZOGnL5HJ3spA0b/usVaWq1Siqu+ICMtNZv2z0yVFFJIhkjFR31f2rrRrQr87x4DNK42x8zmnjz1C4puSaNX6ub0L6AWyst7VncLsh0jtAzWdwka5LFPsuPAk=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nextfour.com;
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
 by DB8PR03MB5497.eurprd03.prod.outlook.com (2603:10a6:10:106::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Fri, 28 May
 2021 01:17:11 +0000
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::593:3329:e104:239]) by DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::593:3329:e104:239%5]) with mapi id 15.20.4173.021; Fri, 28 May 2021
 01:17:11 +0000
Subject: Re: [PATCH 4/5] x86/pkeys: replace PKRU modification infrastructure
To:     Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, luto@kernel.org, shuah@kernel.org,
        babu.moger@amd.com, dave.kleikamp@oracle.com, linuxram@us.ibm.com,
        bauerman@linux.ibm.com, bigeasy@linutronix.de
References: <20210527235109.B2A9F45F@viggo.jf.intel.com>
 <20210527235118.88C9831B@viggo.jf.intel.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <efc820ef-17a0-4b62-754a-449a51dddc54@nextfour.com>
Date:   Fri, 28 May 2021 04:17:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210527235118.88C9831B@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [91.145.109.188]
X-ClientProxiedBy: HE1PR0902CA0004.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::14) To DBAPR03MB6630.eurprd03.prod.outlook.com
 (2603:10a6:10:194::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.121] (91.145.109.188) by HE1PR0902CA0004.eurprd09.prod.outlook.com (2603:10a6:3:e5::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 01:17:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab5acaa4-08d1-49dc-4667-08d921765193
X-MS-TrafficTypeDiagnostic: DB8PR03MB5497:
X-Microsoft-Antispam-PRVS: <DB8PR03MB54978631E7443DD0BFF5756C83229@DB8PR03MB5497.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjOOp2Ri0sXjC0QWEWcyPPrydOQ5f5mSRqrtG9c7wqvCquHtZiTXpldZFWc5BR0twYSDRwfr3i0wWQdTt4TTIE3jCuqxmEhMV4CjXtpf3Hf5PlZ4rAbxUEHUfTnUTfkR1O9YpZhDEWEzcDiISvz+RV35TVSRKX7bMrOLI/m6j8eOVHBHe+qKA+9wBa0eq4hD+7teWqEvnhT7EN84pj/6XS/3pzPUc7mIoth8hoOHRxzac3vczROIzN8ka6e8PZxqt4xBkkxcy6RLb0IgjFQgyKk+9iNF8hEcKhgFPId8pS8Zbg/KPUnt2tgK7AJ5cj56o6g8QoqPg9p/5MHJXuyEqkIqzz1tii1iuqcdD9ylaN1/Oumvwi8P4jQ3GXN8tt5mW+H3Ui8kynbPqhQmtSGEwK5ffU85RKyIZQ8lFLE5HAQbr5X+wahW+LPSyjynF8cmi9/RFBThb3tzcuhxRjUVKnmHOQnJOxqWUmzzuMVKSfKXcBL+bEBxvF10gqs3XrjBn6UDLxR4eNFN+vyitOEERyg1Y2vO+O3KmSw8411nkOSB9qWPoL6xHUXKQpjg+KPxEwmN2ZOGmPG009IOiGupLMzZUQiolLrhoQYu+6TN/5Y4OpT6Avjljw8vbeiWGenZQD/b+uvBDa3iTFpbYOojfLKwpr0yrf8mCHW6Ny9hzAiiodlKYWD5bC5I9fHk9VtNwiH/oRTIvekrlYCaJCSePYoDutiKdS8adLo33Wh8bOGutC3wagiSb2/qA2jR21z/ERqsY/BAEyIxBUvbKIIrnEyfm9AfBNZhJtbqkywr7ViqrlHcqjKUAuo8ex2FMIcWruLeuNh9Tr+izQKyy8UDhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR03MB6630.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(396003)(376002)(366004)(346002)(86362001)(66556008)(8936002)(66476007)(16576012)(316002)(66946007)(956004)(52116002)(6486002)(31686004)(16526019)(2616005)(83380400001)(478600001)(966005)(4326008)(186003)(2906002)(31696002)(7416002)(8676002)(38100700002)(26005)(30864003)(5660300002)(38350700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SCtqVjJQblQyY1FyR3B1STZsK3AyL1FwVW1pNDZGeFVVREpLei9HVzdZa0Fq?=
 =?utf-8?B?SW1Kdlk2dFl3VmM0dWhDSzROUlZSdm5nazJTckxYMW0vaXFaMXB3dFMzdk1r?=
 =?utf-8?B?S2F1SUdZN2lBZVI3REplN1kxY01hM2hLZlBSNS9kbkxxQm9UdHV5ZytTTzFN?=
 =?utf-8?B?TEtXdnpaMzY5a2hTYzdNYkVhMDJjZlRNbVFkMC9XUWFJUGVqazdKSDNzM0Vn?=
 =?utf-8?B?MWpJZzZHc0FOZS8zVklSZ0l2K0FQUHhBR2pZYjZVZEpRZ0lxaWcvRXBDUmtM?=
 =?utf-8?B?SFR4ME9DMWhZTW5FbEVOTW5Sc1ZxK2I0dWVBMlpoR2FjT2pqTWpBWk9xVHFM?=
 =?utf-8?B?c2l4Z0JPNjFkK1R3am5qeUZsTmhUei9TRmFmQVk3eC9sRG5KL3dKVnQ2Qldy?=
 =?utf-8?B?NVhDMk9WRjcvSjJOYm9wbzl4UERiZmVhVGQzRlY4b1M4SUtDVUdsaldnVmti?=
 =?utf-8?B?RWNBUFZacWZUUlJsOFJMUmlSSnd4RU1xU0Z0WmZWdzdBRGhWRE85QVo1TVl5?=
 =?utf-8?B?SGY1Vjd6R1VwdnZQT2xwUzFnYW11VGdMVFNkaERaM3NTOFhjcjRIMWRUdjN2?=
 =?utf-8?B?MHVJK1hyOWtUYmNMWTNDRUE2b051aE5ZbHJXNnhEUGFxK0lqQmlXcUtqcmd1?=
 =?utf-8?B?NTlQWGowTTRJd2NGdHNzdmNVMDJDWDdGcEVCaXRTbk1HejhETitFNzZCMWpY?=
 =?utf-8?B?R0ppVTNtVm1DNUtSM0F4cjBMdDkrK2FON0kzZ3h5dTIrNVY0eGlZU2hxWHVi?=
 =?utf-8?B?dDZUN3FNWWdlQmV0UEZwWVZlSTVLb2ozWHFMcW9PZkE0TDE1SjNxUFRFa1VX?=
 =?utf-8?B?OHowUnVKY3VZcUdSZW5XQlMrU1V5bTdVeUVpdDJBcjFQL2lJR2E1M3BVSloz?=
 =?utf-8?B?SXE1Rk13T3Vyc2xUb2h6VGdPcGlRMFcrZVVORy9xS1JmZVQ2aUE2TEQ5Q3h0?=
 =?utf-8?B?Qjg2RWZET2tETlpWSTNXM0liL3UxVFBWMVJVUmpuTVFrdEcwdFBYaHJWcjBM?=
 =?utf-8?B?U1VRNUdRcXlOQWllRmNxQk55U0tudDErU2JrWjExdUc3MGVXZzVUK2gybHha?=
 =?utf-8?B?TllKRklySmZXa3l0YStBT2RQVXdGRThYL0xZRHh2S3VYUk5FbDVRNk0wTTU2?=
 =?utf-8?B?dGp1WDljQWRDUEFnVEVLa0ZsQlVkRm9pKzAzSWNVd1JWdmtMaG1Dd0xnTGlu?=
 =?utf-8?B?aXk3VWFUMDNzRjdWSG5aQUZmRzRCUTcxY002dm1yeVkwNXFOaTRWMDA0Zmg3?=
 =?utf-8?B?MjE4T0VjYmQxMEY2UVN6VWkvaGlQcXY5cDZteVIvdnQyZi9hUmdTaExMcm9Z?=
 =?utf-8?B?VlNqanVvNG9qVjBiZkpFWVYya1lhYzJDaUJramdwMUVSUE5LSnJURVppK3Fr?=
 =?utf-8?B?M2RXVEZqTDN6SHlkNjFqQU9TUXlUbys5djNUNmsySmVrZFhCbXgvNndCbnlV?=
 =?utf-8?B?SHF0M20vbHBVRElkUDcrcXpKZ1lLK0ovZk1EUzlrKzVPclVzMHFtemIzKy9P?=
 =?utf-8?B?SHVNbzMrQWFtVnFCZjZrYUp4SzF1YTFTd2R1Uzh6cnMrMk0wVjh2dVZEenVS?=
 =?utf-8?B?NEJaMlV0MFA4NnUxTzU3UE8yY0F0OG5ZRU1TUmxTNzhPSEFxR2lzMEI1Z0Jk?=
 =?utf-8?B?UXMrMWxsMDFIZFRDT0xBYnY0K0huMytVRVY2K2Y3ejV5TnpDb1NFL2FTZEpL?=
 =?utf-8?B?b1lkZHhjd0FINjZHMmlDcDQxZmNtRTlqbUF3N2xhTlQvU251YjIyT2Y5YXky?=
 =?utf-8?Q?5ohYQEPLH3QgcEEMjg3D/gUkNIPttMQ6WKnY7p3?=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5acaa4-08d1-49dc-4667-08d921765193
X-MS-Exchange-CrossTenant-AuthSource: DBAPR03MB6630.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 01:17:11.0031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0r8Mba/1fXRd31O6SWT5l0JXhJ5ff8wHrAGO2jbaZcHlNqX1frjBnWZsN44m5ssIIbmzTx10C3FXCDsl4DSHIKMRU3bgwH6PrMAXbg6pVtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5497
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.5.2021 2.51, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> There are two points in the kernel which write to PKRU in a buggy way:
>
>   * In switch_fpu_finish(), where having xfeatures[PKRU]=0 will result
>     in PKRU being assigned 'init_pkru_value' instead of 0x0.
>   * In write_pkru(), xfeatures[PKRU]=0 will result in PKRU having the
>     correct value, but the XSAVE buffer will remain stale because
>     xfeatures is not updated.
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
>   1. On a NULL return that they have no work to do
>   2. On a valid pointer return that they *can* safely write state
>      without doing more work like setting an xfeatures bit.
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
>   b/arch/x86/include/asm/fpu/internal.h |    8 --
>   b/arch/x86/include/asm/fpu/xstate.h   |  111 +++++++++++++++++++++++++++++++---
>   b/arch/x86/include/asm/processor.h    |    7 ++
>   b/arch/x86/kernel/cpu/common.c        |    6 -
>   b/arch/x86/mm/pkeys.c                 |    6 -
>   5 files changed, 115 insertions(+), 23 deletions(-)
>
> diff -puN arch/x86/include/asm/fpu/internal.h~write_pkru arch/x86/include/asm/fpu/internal.h
> --- a/arch/x86/include/asm/fpu/internal.h~write_pkru	2021-05-27 16:40:26.903705463 -0700
> +++ b/arch/x86/include/asm/fpu/internal.h	2021-05-27 16:40:26.919705463 -0700
> @@ -564,7 +564,6 @@ static inline void switch_fpu_prepare(st
>   static inline void switch_fpu_finish(struct fpu *new_fpu)
>   {
>   	u32 pkru_val = init_pkru_value;
> -	struct pkru_state *pk;
>   
>   	if (!static_cpu_has(X86_FEATURE_FPU))
>   		return;
> @@ -578,11 +577,8 @@ static inline void switch_fpu_finish(str
>   	 * PKRU state is switched eagerly because it needs to be valid before we
>   	 * return to userland e.g. for a copy_to_user() operation.
>   	 */
> -	if (current->mm) {
> -		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
> -		if (pk)
> -			pkru_val = pk->pkru;
> -	}
> +	if (current->mm)
> +		pkru_val = xstate_read_pkru(&new_fpu->state.xsave);
>   	__write_pkru(pkru_val);
>   
>   	/*
> diff -puN arch/x86/include/asm/fpu/xstate.h~write_pkru arch/x86/include/asm/fpu/xstate.h
> --- a/arch/x86/include/asm/fpu/xstate.h~write_pkru	2021-05-27 16:40:26.906705463 -0700
> +++ b/arch/x86/include/asm/fpu/xstate.h	2021-05-27 16:40:26.919705463 -0700
> @@ -124,27 +124,124 @@ static inline u32 read_pkru(void)
>   	return 0;
>   }
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
Maybe

bool feature_was_init = !(xstate->header.xfeatures & BIT_ULL(xfeature_nr));


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
>   /*
>    * Update all of the PKRU state for the current task:
>    * PKRU register and PKRU xstate.
>    */
>   static inline void current_write_pkru(u32 pkru)
>   {
> -	struct pkru_state *pk;
> -
>   	if (!boot_cpu_has(X86_FEATURE_OSPKE))
>   		return;
>   
> -	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
> -
> +	fpregs_lock();
>   	/*
>   	 * The PKRU value in xstate needs to be in sync with the value that is
>   	 * written to the CPU. The FPU restore on return to userland would
>   	 * otherwise load the previous value again.
>   	 */
> -	fpregs_lock();
> -	if (pk)
> -		pk->pkru = pkru;
> +	xstate_write_pkru(&current->thread.fpu.state.xsave, pkru);
>   	__write_pkru(pkru);
>   	fpregs_unlock();
>   }
> diff -puN arch/x86/include/asm/processor.h~write_pkru arch/x86/include/asm/processor.h
> --- a/arch/x86/include/asm/processor.h~write_pkru	2021-05-27 16:40:26.908705463 -0700
> +++ b/arch/x86/include/asm/processor.h	2021-05-27 16:40:26.921705463 -0700
> @@ -854,4 +854,11 @@ enum mds_mitigations {
>   	MDS_MITIGATION_VMWERV,
>   };
>   
> +/*
> + * The XSAVE architecture defines an "init state" for
> + * PKRU.  PKRU is set to this value by XRSTOR when it
> + * tries to restore PKRU but has on value in the buffer.
> + */
> +#define PKRU_HW_INIT_VALUE	0x0
> +
>   #endif /* _ASM_X86_PROCESSOR_H */
> diff -puN arch/x86/kernel/cpu/common.c~write_pkru arch/x86/kernel/cpu/common.c
> --- a/arch/x86/kernel/cpu/common.c~write_pkru	2021-05-27 16:40:26.912705463 -0700
> +++ b/arch/x86/kernel/cpu/common.c	2021-05-27 16:40:26.924705463 -0700
> @@ -466,8 +466,6 @@ static bool pku_disabled;
>   
>   static __always_inline void setup_pku(struct cpuinfo_x86 *c)
>   {
> -	struct pkru_state *pk;
> -
>   	/* check the boot processor, plus compile options for PKU: */
>   	if (!cpu_feature_enabled(X86_FEATURE_PKU))
>   		return;
> @@ -478,9 +476,7 @@ static __always_inline void setup_pku(st
>   		return;
>   
>   	cr4_set_bits(X86_CR4_PKE);
> -	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
> -	if (pk)
> -		pk->pkru = init_pkru_value;
> +	xstate_write_pkru(&current->thread.fpu.state.xsave, init_pkru_value);
>   	/*
>   	 * Seting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
>   	 * cpuid bit to be set.  We need to ensure that we
> diff -puN arch/x86/mm/pkeys.c~write_pkru arch/x86/mm/pkeys.c
> --- a/arch/x86/mm/pkeys.c~write_pkru	2021-05-27 16:40:26.914705463 -0700
> +++ b/arch/x86/mm/pkeys.c	2021-05-27 16:40:26.926705463 -0700
> @@ -155,7 +155,6 @@ static ssize_t init_pkru_read_file(struc
>   static ssize_t init_pkru_write_file(struct file *file,
>   		 const char __user *user_buf, size_t count, loff_t *ppos)
>   {
> -	struct pkru_state *pk;
>   	char buf[32];
>   	ssize_t len;
>   	u32 new_init_pkru;
> @@ -178,10 +177,7 @@ static ssize_t init_pkru_write_file(stru
>   		return -EINVAL;
>   
>   	WRITE_ONCE(init_pkru_value, new_init_pkru);
> -	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
> -	if (!pk)
> -		return -EINVAL;
> -	pk->pkru = new_init_pkru;
> +	xstate_write_pkru(&init_fpstate.xsave, new_init_pkru);
>   	return count;
>   }
>   
> _

