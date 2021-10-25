Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72DA43913C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhJYIfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:35:33 -0400
Received: from mail-am6eur05on2070.outbound.protection.outlook.com ([40.107.22.70]:56577
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231241AbhJYIfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:35:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEcrfj4hXLAMwsAHUDWRsEwbtIZ+ZxSvdwe+VT+ljAspzMLNFLMUtfzVHUuAUryk39qXPqKruhJXtjcu3bQtaEqEJHaeOTavcz7sUZ5u8iX1ubePgyd+Lwf0iqA6hmp1KcLl9CTgwC8NtQagZ0KfWYCuiec2PpzIx7AYKi8hIBWOGGwmTUKQQv1rnRLIzjBWn09r+tLGdIHiFQ2Wh9kU+G0SHqN+IAqGTnZgd5af71o4+xwdTAI4jhcDrPpMk8V71mwcMrlPcJhsepBS0taXVaAntbtS40GtBK7WR1yW8YGyNZAmdUFP+jbAhD9sAsnEDsRaXExjVoQG2hglC2EBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIFB7ZpfFjM2uGbVvspNPJgx/l+Fxz94Eedd4LwvtKI=;
 b=W8PENQvAUxiIoGkz3WEuFEQnxW8HSXgoHvRqR5lTKYp86uq+jnnUyZszpFA22CuBXg5xtqHuZC9iDsglJCQUtbisSAa6413LQVZXC4B+fediwrk79x+MCID/ezfCeFBC/iQ/7EV4ojBCWF7/5Q7L+5CQyZX1zyssin9Cr8ToWLcbHuT4SVflAkSTq+fw++MSCTr/pZtb05X5bsghoZ3aNBSYLX/VijZtDFgbpMAzl1+juwkTjlPw6PYJS2yXsPIr2Q7YNWsEGRV/czNLIE58AFDPzy7mE8mi5AxZGICwdgmPW9U9lrSbHnMCv8NUBwFs3OOMVyYyigquztcbbmJGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIFB7ZpfFjM2uGbVvspNPJgx/l+Fxz94Eedd4LwvtKI=;
 b=lfS6NYGpOA4zo87wGtS+isIZmqdPtzjp/yGU4t47zzwWCeJV9/zjZIRmo0LZRPujYbteBXGXCFJi6a70jYqjJdSEcw5jM8uMH063ltJ0rXYj6vWKAbqJXqeRq27tMW9Gqe1eYh58TcdRahGZyvJNObIqKnuRc/94W6/9VqH16sg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nextfour.com;
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
 by DB6PR0302MB2790.eurprd03.prod.outlook.com (2603:10a6:4:ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:33:08 +0000
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::78b9:c389:1d86:b28e]) by DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::78b9:c389:1d86:b28e%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 08:33:08 +0000
Subject: Re: [PATCH 15/23] x86/fpu: Add sanity checks for XFD
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
 <20211021225527.10184-16-chang.seok.bae@intel.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <20d31ed9-be3d-dca6-ceef-ced35f80d131@nextfour.com>
Date:   Mon, 25 Oct 2021 11:33:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211021225527.10184-16-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0701CA0052.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::20) To DBAPR03MB6630.eurprd03.prod.outlook.com
 (2603:10a6:10:194::6)
MIME-Version: 1.0
Received: from [10.10.10.148] (194.215.55.162) by HE1PR0701CA0052.eurprd07.prod.outlook.com (2603:10a6:3:9e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.11 via Frontend Transport; Mon, 25 Oct 2021 08:33:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6fa597a-2663-46c7-723c-08d99792127b
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2790:
X-Microsoft-Antispam-PRVS: <DB6PR0302MB27905B28B37A774DAD61CC0283839@DB6PR0302MB2790.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:264;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbnUgg36fYvNz8rzia/bcUHSJT57zqUmSLQEGG5KiUhTuh77ZcSmqUnGz4Fa4lG4XSiEFQNfuiF8gLVaDbAJTA6zzWNsIJHHFhbYXl8fvd5FNUv5f2KYc0/PDKPXsbar6G7Xu4isLj5sCZkTMKhhSka/hgscqo5QLwJXFlrTngefNkYtPwt9Q6H5Q8O+1DOIY4w1lE7b6HAj3iNyH0EXuDIk9JOIjmmyCJWEOD8/wu+LXXgbCetH2lUvQKE5TQ9TKqxPGr+JwySduBwxSE8l7Sily1Bjn6vXzZLlwzU2pxTNJB+PS4QQ8Jipo4ZoemG319MKmHZh4Wq4CgIdVAbtAkLXPya2Mt4sfNseEZXOMh46gP42mHMXkgJD0q+mQtCM6crTvcJI43g1DYik0TKbiPacYGBlGvevdOlgQrlnaewiarO0P7dWK+LV6G57NhRH+xIE/pFVy2pL6wsHzpBs+ki5i+S16c/ZrnnaPV1tnJhm1BYKhlNIbn9agXt00hELUXtRdcmy+iMacNH+JfHwFblvbDmmNHKAbCC4rBGCGVAq5CbeV+kRAzDRiX0Zniv0AFhltjqibiWvMKHQ2KpHd2Xo2zaq5XXq1dYooPdqIDRCUFPgq5l2RZ4vq1tz6gM82jvrxhiRf/M0H/22lnVjtjCIzmx0PBcTSHuG8GC/s0RScrb1NdjZmDBDZ22yMtIgnGgrPCGyE0pCZwIjqKWGNL5rSmmulnUtNNpPXzURPEZYYLSel7DVoEwBTgFXc6xR3pVvSRZlVPC0UT75chtghQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR03MB6630.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(396003)(346002)(39830400003)(31696002)(66946007)(316002)(6486002)(4326008)(52116002)(38350700002)(36756003)(38100700002)(956004)(26005)(2616005)(186003)(31686004)(8676002)(508600001)(16576012)(5660300002)(2906002)(83380400001)(66556008)(86362001)(8936002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmkxcXU4cW9FYTRUekQrNGJqKzZYNzUwRkZoc0c0eDF6aElxTmtzYXo4R2JQ?=
 =?utf-8?B?WXh6WG02Q1ZXM0hJaml0VHZMT2dKTVd5V0FWYTdkK1d2ZEJNcVBGZFJsWURK?=
 =?utf-8?B?MlhrN3hrd2pMV0ZOdTFLRHhDUG9pOUhtWmlsd0JSR1duN2RYalFYY0ZsaDgz?=
 =?utf-8?B?YWlxQXFEeGpQcHlOM1ZWU1hBWDk5eTQwWXZEOE4zSG5CdXJCeUljcjlNNkNV?=
 =?utf-8?B?WGVmbkpnU0J2b2U0bUtDZHpOeEpBRStwVDgvb0drZDBQejhXOTJ0VHE2bUM2?=
 =?utf-8?B?WVFDK2lXdElqVUl5MHQ0dnh4aXltVEw3OTg2UVYxdk5KM2FnamE0cy9jSzQz?=
 =?utf-8?B?U0hrbzNKNDZEVHQycERtd2tkZlNWK3NOcmRFT0FhMUc4blRVZVh1cVFYLy91?=
 =?utf-8?B?ckRxNGYwOHZKQVRHckVpaDJIeWthTzlyb2VyUzV6V3VNTDd5OW85YXJpYUJz?=
 =?utf-8?B?Q0x0emFUZGdmZnlmRnN2ODB3eUt4ZnRlRCtEVC85N0IrbWRPTFdPSkxubmNB?=
 =?utf-8?B?Y3NkR1JIeUxxMmY0ZW1ZVXl2S2xpQllRQldBdVFOWG5sYUJndG9FN2FzTkJn?=
 =?utf-8?B?MDJ2TWZLRUtwWldEMmtaM0tmeVR1TG1PLzI3TWhhd1M2MC9aUmtSbHFFVkdD?=
 =?utf-8?B?clhzQXYvWFo3TXlndWRuKzJ4NXFhZko3NVNvbVF4OG5OM0tOc2dONTlHU3Ix?=
 =?utf-8?B?S1M2M1FYR2p6Z1BPU2JzRUNLQno1UVdyMkZLblVGdUlFOEtQVHh6bzNGUEh0?=
 =?utf-8?B?VmhNQlVXdFh2em1zbXdmT2hTU1kxa0tROTE3YU02MmlTcDVVMDFyQm5YenNY?=
 =?utf-8?B?SFBzbklLcHF6U2Zrc3cwSXNmZ1hsNnhZOEJZQ0tmb1lyOFFTQXlac2tVeUMz?=
 =?utf-8?B?TzI0dkg2OUx1V0g1a1hIM2Q4UzdZbkVVdklOWGpQRy9BLzFNWW45V3NrR2V6?=
 =?utf-8?B?QysxSXpzZUxXRHBHWHhVM0Y4Nk5aQTlZekhJb24zWUcwUW5WeFcwaHpCenR5?=
 =?utf-8?B?RkJQUFJRQXJBVTY3WFpOdkVyeWxHQ3N6dC9jZWpiMW9LclVWd09LdUdQYXQx?=
 =?utf-8?B?L21LTlNLS3FTcE9aYmVMMHpEZkF0ZDViS2owdHdDWlNvTU1LdmtZYmFOMEJY?=
 =?utf-8?B?cFVHajRKZExxQVNtU2M4eHh5UVA3RytTenQzUjRBOTFGWXFPKy8vMDJmSEo0?=
 =?utf-8?B?MlpWMUF6U0RINkkxZ3ZzYzhXQlA2QjBEU00yTzRqWDcybG03bnpTQ3lKOEUv?=
 =?utf-8?B?NUc1dUtrbExNY1Z4Z2U3dmlLUUVGckpsaWxDNHIwbTRsdnRUY0VBNWpsSklx?=
 =?utf-8?B?eDhCVlhsSWVlRzg5Ri9JeFlqaEtJdGowYVFZdks3cXo5eWh2RU9JU3NTeVpG?=
 =?utf-8?B?NVFlWDlaYnUzcElVSDhrQi9JcnJRbXphR2ZEajhyNlRuOEJSNS83VWx0bVor?=
 =?utf-8?B?SVRuNTNZNXlsSmEwOXFlbGhFT3FSNVNCb2twVCtZWVk5dEJjdDZ3RjdpaXNS?=
 =?utf-8?B?cXdRV3g0V0svU3pULzNWc1VKQUlGRDN0UHgyLzY5MHB4K3Y5QjFJODNqMU9o?=
 =?utf-8?B?ejZQbWQ4WFZ4aWJXdUJCRzVuc3drbTZyTVJmeTNYT2RGNk1sOHAydldZZ3I2?=
 =?utf-8?B?bDBRQ3Z2Zk4xVjg2REV5OHV5RUt1dU9VbXYrZXlKUFFTaThqRWhCcGNWSEdh?=
 =?utf-8?B?aFlCYktjS0MrRkU5dWRWQnBTekRuV21yMDl0aHgvRHJPQk1rSnFOYkNEZks1?=
 =?utf-8?B?dzhvZDRuSEhBclVLeitBSHlodllialg4enpBRjBHcStkb1VGYnhtUXRKdDRj?=
 =?utf-8?B?WUthWStScE9tMjdJNmZ6SWdEM1pzbUxCQW9ZUE84ZmJSNHk3bFJIUDBJVHU2?=
 =?utf-8?B?TTRJd3hWcldaN29ZQi95amlaOFVkejVpQnZ4MmZYUW9Tb1czRFJJOFZ4K1h3?=
 =?utf-8?B?NTJpRk5HcXg4aTA1K1JaRTBjaE5TYUluQlhGRzNxV0xJR3NEL21JL1ZYeGw2?=
 =?utf-8?B?RUI0eFpMK3hsdVVEelRZWm14eSt1RnFQd1I4TFF5SE42MXQ5NGxtNUdrY0Fm?=
 =?utf-8?B?SEtKVGRteGdRc0VHYkdSVlorUWRIYXpCTkNJeVNzTkpJQU9weERkZGJoVXVV?=
 =?utf-8?B?MXFpZllOZmNNMVlsTDdxaVFIVDBDVDZySW5sQlFBdCt6cUFRS2MxNDlYRWx2?=
 =?utf-8?B?RDBZdnFpWFNINThreWIwNElhZWtDT2JYZStYT2kxWjVUK2VqRHVvd28xV1o0?=
 =?utf-8?B?KzFQeW5adzBwbnNuZ0drallTaEh3PT0=?=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fa597a-2663-46c7-723c-08d99792127b
X-MS-Exchange-CrossTenant-AuthSource: DBAPR03MB6630.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:33:08.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/XM5UPBfKhveJBwD44eoeLGG/lgFt5Euffi2MDWbCNmWmQb8/ig4f7bculqqAKzVHv7NJZVYnpYcyGy418Lh4xYPa5Qn1EFLEIUzQe/7Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2790
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.10.2021 1.55, Chang S. Bae wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Add debug functionality to ensure that the XFD MSR is up to date for XSAVE*
> and XRSTOR* operations.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---
> Changes from the tglx tree:
> * Rename the xstate ops validation helper. (Dave Hansen)
> * Update code comments. (Dave Hansen)
> ---
>  arch/x86/kernel/fpu/core.c   |  9 +++---
>  arch/x86/kernel/fpu/signal.c |  6 ++--
>  arch/x86/kernel/fpu/xstate.c | 55 ++++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/fpu/xstate.h | 34 +++++++++++++++++++---
>  4 files changed, 92 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index e92c9d79441c..f4b02ed47034 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -166,7 +166,7 @@ void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
>  		 */
>  		mask = fpu_kernel_cfg.max_features & mask;
>  
> -		os_xrstor(&fpstate->regs.xsave, mask);
> +		os_xrstor(fpstate, mask);
>  	} else {
>  		if (use_fxsr())
>  			fxrstor(&fpstate->regs.fxsave);
> @@ -537,7 +537,7 @@ void fpu__drop(struct fpu *fpu)
>  static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
>  {
>  	if (use_xsave())
> -		os_xrstor(&init_fpstate.regs.xsave, features_mask);
> +		os_xrstor(&init_fpstate, features_mask);
>  	else if (use_fxsr())
>  		fxrstor(&init_fpstate.regs.fxsave);
>  	else
> @@ -594,9 +594,8 @@ void fpu__clear_user_states(struct fpu *fpu)
>  	 * corresponding registers.
>  	 */
>  	if (xfeatures_mask_supervisor() &&
> -	    !fpregs_state_valid(fpu, smp_processor_id())) {
> -		os_xrstor(&fpu->fpstate->regs.xsave, xfeatures_mask_supervisor());
> -	}
> +	    !fpregs_state_valid(fpu, smp_processor_id()))
> +		os_xrstor_supervisor(fpu->fpstate);
>  
>  	/* Reset user states in registers. */
>  	restore_fpregs_from_init_fpstate(XFEATURE_MASK_USER_RESTORE);
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index d128eb581ffc..a937980fd02b 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -261,7 +261,7 @@ static int __restore_fpregs_from_user(void __user *buf, u64 ufeatures,
>  			ret = fxrstor_from_user_sigframe(buf);
>  
>  		if (!ret && unlikely(init_bv))
> -			os_xrstor(&init_fpstate.regs.xsave, init_bv);
> +			os_xrstor(&init_fpstate, init_bv);
>  		return ret;
>  	} else if (use_fxsr()) {
>  		return fxrstor_from_user_sigframe(buf);
> @@ -322,7 +322,7 @@ static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
>  	 * been restored from a user buffer directly.
>  	 */
>  	if (test_thread_flag(TIF_NEED_FPU_LOAD) && xfeatures_mask_supervisor())
> -		os_xrstor(&fpu->fpstate->regs.xsave, xfeatures_mask_supervisor());
> +		os_xrstor_supervisor(fpu->fpstate);
>  
>  	fpregs_mark_activate();
>  	fpregs_unlock();
> @@ -432,7 +432,7 @@ static bool __fpu_restore_sig(void __user *buf, void __user *buf_fx,
>  		u64 mask = user_xfeatures | xfeatures_mask_supervisor();
>  
>  		fpregs->xsave.header.xfeatures &= mask;
> -		success = !os_xrstor_safe(&fpregs->xsave,
> +		success = !os_xrstor_safe(fpu->fpstate,
>  					  fpu_kernel_cfg.max_features);
>  	} else {
>  		success = !fxrstor_safe(&fpregs->fxsave);
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index c178aa91abb3..c2cbe14aaa00 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1301,6 +1301,61 @@ EXPORT_SYMBOL_GPL(fpstate_clear_xstate_component);
>  #endif
>  
>  #ifdef CONFIG_X86_64
> +
> +#ifdef CONFIG_X86_DEBUG_FPU
> +/*
> + * Ensure that a subsequent XSAVE* or XRSTOR* instruction with RFBM=@mask
> + * can safely operate on the @fpstate buffer.
> + */
> +static bool xstate_op_valid(struct fpstate *fpstate, u64 mask, bool rstor)
> +{
> +	u64 xfd = __this_cpu_read(xfd_state);
> +
> +	if (fpstate->xfd == xfd)
> +		return true;
> +
> +	/* For current's fpstate the XFD state must be correct. */
> +	if (fpstate->xfd == current->thread.fpu.fpstate->xfd)
> +		return false;
> +
Should this return true or is the comment confusing?


> +	/*
> +	 * XRSTOR(S) from init_fpstate are always correct as it will just
> +	 * bring all components into init state and not read from the
> +	 * buffer. XSAVE(S) raises #PF after init.
> +	 */
> +	if (fpstate == &init_fpstate)
> +		return rstor;
> +
> +	/*
> +	 * XSAVE(S): clone(), fpu_swap_kvm_fpu()
> +	 * XRSTORS(S): fpu_swap_kvm_fpu()
> +	 */
> +
> +	/*
> +	 * No XSAVE/XRSTOR instructions (except XSAVE itself) touch
> +	 * the buffer area for XFD-disabled state components.
> +	 */
> +	mask &= ~xfd;
> +
> +	/*
> +	 * Remove features which are valid in fpstate. They
> +	 * have space allocated in fpstate.
> +	 */
> +	mask &= ~fpstate->xfeatures;
> +
> +	/*
> +	 * Any remaining state components in 'mask' might be written
> +	 * by XSAVE/XRSTOR. Fail validation it found.
> +	 */
> +	return !mask;
> +}
> +
> +void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor)
> +{
> +	WARN_ON_ONCE(!xstate_op_valid(fpstate, mask, rstor));
> +}
> +#endif /* CONFIG_X86_DEBUG_FPU */
> +
>  static int validate_sigaltstack(unsigned int usize)
>  {
>  	struct task_struct *thread, *leader = current->group_leader;
> diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
> index 32a4dee4de3b..29024244965b 100644
> --- a/arch/x86/kernel/fpu/xstate.h
> +++ b/arch/x86/kernel/fpu/xstate.h
> @@ -130,6 +130,12 @@ static inline u64 xfeatures_mask_independent(void)
>  		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
>  		     : "memory")
>  
> +#if defined(CONFIG_X86_64) && defined(CONFIG_X86_DEBUG_FPU)
> +extern void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor);
> +#else
> +static inline void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor) { }
> +#endif
> +
>  /*
>   * Save processor xstate to xsave area.
>   *
> @@ -144,6 +150,7 @@ static inline void os_xsave(struct fpstate *fpstate)
>  	int err;
>  
>  	WARN_ON_FPU(!alternatives_patched);
> +	xfd_validate_state(fpstate, mask, false);
>  
>  	XSTATE_XSAVE(&fpstate->regs.xsave, lmask, hmask, err);
>  
> @@ -156,12 +163,23 @@ static inline void os_xsave(struct fpstate *fpstate)
>   *
>   * Uses XRSTORS when XSAVES is used, XRSTOR otherwise.
>   */
> -static inline void os_xrstor(struct xregs_state *xstate, u64 mask)
> +static inline void os_xrstor(struct fpstate *fpstate, u64 mask)
> +{
> +	u32 lmask = mask;
> +	u32 hmask = mask >> 32;
> +
> +	xfd_validate_state(fpstate, mask, true);
> +	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
> +}
> +
> +/* Restore of supervisor state. Does not require XFD */
> +static inline void os_xrstor_supervisor(struct fpstate *fpstate)
>  {
> +	u64 mask = xfeatures_mask_supervisor();
>  	u32 lmask = mask;
>  	u32 hmask = mask >> 32;
>  
> -	XSTATE_XRESTORE(xstate, lmask, hmask);
> +	XSTATE_XRESTORE(&fpstate->regs.xsave, lmask, hmask);
>  }
>  
>  /*
> @@ -184,11 +202,14 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
>  	 * internally, e.g. PKRU. That's user space ABI and also required
>  	 * to allow the signal handler to modify PKRU.
>  	 */
> -	u64 mask = current->thread.fpu.fpstate->user_xfeatures;
> +	struct fpstate *fpstate = current->thread.fpu.fpstate;
> +	u64 mask = fpstate->user_xfeatures;
>  	u32 lmask = mask;
>  	u32 hmask = mask >> 32;
>  	int err;
>  
> +	xfd_validate_state(fpstate, mask, false);
> +
>  	stac();
>  	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
>  	clac();
> @@ -206,6 +227,8 @@ static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64
>  	u32 hmask = mask >> 32;
>  	int err;
>  
> +	xfd_validate_state(current->thread.fpu.fpstate, mask, true);
> +
>  	stac();
>  	XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
>  	clac();
> @@ -217,12 +240,15 @@ static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64
>   * Restore xstate from kernel space xsave area, return an error code instead of
>   * an exception.
>   */
> -static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
> +static inline int os_xrstor_safe(struct fpstate *fpstate, u64 mask)
>  {
> +	struct xregs_state *xstate = &fpstate->regs.xsave;
>  	u32 lmask = mask;
>  	u32 hmask = mask >> 32;
>  	int err;
>  
> +	/* Must enforce XFD update here */
> +
>  	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
>  		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
>  	else

