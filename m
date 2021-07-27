Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AD93D7E20
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhG0S4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:56:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:25806 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhG0S4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:56:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="212231560"
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="212231560"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 11:56:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="434836123"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 27 Jul 2021 11:56:10 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 27 Jul 2021 11:56:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 27 Jul 2021 11:56:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 27 Jul 2021 11:56:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQNEQBbgjdmQ/pTzY0wiJsDvFGBgy2ckTKfoxE/v5w5TTSYPVyBNoiGtXWWHnxbLxlASpHaucY8MzfupgONG5NfdrNoP3yBYFVqYNzwZ/ooRPQZuvBAPE2EkqwMksx6bW0EIbspZ+7fxkLffHqZ87GxStPp5a3toXLNXGmfeHZEZAWWFkCXZNa6xqaGJFxqvFW6y2JgGHeq2Stu54ZhOET1i0MH/k0NaadVVUEnNiOKfdgeBSUNZfyNe3fr3l+WyKovuVtneHhBkA+wP4X46PoAfiPKZTb8NONAv5V9bW8YdRgpTq7NoXIzPVQTZQw7GYox0ruSsn3j6OMeOgjoQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWmWk2xdeR6MIIXoG+hySOkkoOR7D1gGTmSHpccEubA=;
 b=ZWP7wGYMF1ut9w4ussJM7Qe17v5oP7Dicp9fubi4zk9ZwRLEKiTlwjPOYtZCUW0ri3hQ7nTvHBG6MNbQzz/27xRxPygkC/Ab75B9wsMQ2PQ+2AQMGTyVWA2NcfqmaeY9cUvCaPLGjRVrlIguBscWeF97uUDGn0e3aXLPC+DkwpjUtBF4SjWLa/WkTuNOS+q/bQgV2yZv1AtsVirCRmgweBwG2fYR3kJnhgo5Q8yT/8rXIltnZsynzUCW4vF/LOJ5Jm5E9Byu1PkHfN9PlYnVbmlvHuG4S/t/kRtkTAcIYPPNaqXBM7S3Nq8O4SH5O0lXiJUZrNt6tIMG4bNhXeLChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWmWk2xdeR6MIIXoG+hySOkkoOR7D1gGTmSHpccEubA=;
 b=qXsqS/flCbdI6cv/dpChf0KnHaE3Ku1oxW5sV7dA58IrzxWFIKQT6yiqEip/U739Co9YdobTQDHKn+rPr18s6HoVzR+qkp9C7UK91fArK/02KXHD+0QCONCJArxJ2HXmpaTGFVcnnQWWtpwH9X/yZrhRZcyi8Rj9lmusEW381ls=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 27 Jul
 2021 18:56:08 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::202f:e602:3983:e631]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::202f:e602:3983:e631%8]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 18:56:08 +0000
Subject: Re: [PATCH] x86/intel_rdt: use __this_cpu_read in pseudo_lock_fn()
To:     Hui Su <suhui@zeku.com>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <20210723023342.3015-1-suhui@zeku.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <ddb942f0-4c34-4e10-7d46-526d411f5ebd@intel.com>
Date:   Tue, 27 Jul 2021 11:56:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <20210723023342.3015-1-suhui@zeku.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0306.namprd04.prod.outlook.com
 (2603:10b6:303:82::11) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.219] (71.238.111.198) by MW4PR04CA0306.namprd04.prod.outlook.com (2603:10b6:303:82::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29 via Frontend Transport; Tue, 27 Jul 2021 18:56:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c2b8ea-db3d-479e-ec57-08d95130318e
X-MS-TrafficTypeDiagnostic: BN9PR11MB5243:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR11MB52431753461D9A696CCDD36EF8E99@BN9PR11MB5243.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HaXnZb5SUUYO7tKJUqilyCBG9dhiHKivGw8YUFWTjw0OjpDW3gn/H/NHRjmmNYTzLWD2N0C4R7G3rxi5X08KO+M2BBY9uBC6F3I7KYzSP/ZsZrKU1hOB6FUDYpyaPmYjQzxyUVPgF+QBzqBuVCZ4Qnnee84baHZ6RWyfGqAAUDRsFSScbFJfekX2Z6VwHV3hsYqb1QvcPvqIILWvHbCFn/gTdipjmB0gCM6ab4MONPsMebPyNzQGO+CWzfV+O6wvfJlrEVeFWwta3YmpF8979UFD7KLTLR1QzAw3kv4jRzW0z7RNoFUXHX9cTNbXcf3JBymxhRm8+G9HTzgANB2I/SgAKmUYIgjm5ADd7OpnaGRWQnOnUnWdGHm4LVsxetRFsFMIhPmiO/WQk/+lQxSIq7N+cmpDPm/Wjdqm3ntaZ4Zmz/UWIZgBMRwFqgbiZkXD+na8Z9pxnFOkUyxMRpSVs8HikBPcfxfwCzO3q1qYD5/LlYV902ZnhkDtpAxjP4YY4iB55XAtg1pilTQWtpMBpRD/ef0A3jic+zn6IhdbwwiLjPC674NU8wzc/w8RX1nzUx/6ksHwPFaeUdBVHQEcwzDH2vYeNkhGuelpaAQdChwPuNKJkYxxQ8d1CV2S/pXunclJ4gLyOMxsOdJ9VE4S8Be6WtIJ+QINkDKRGLx9TZyN9507rspQdVY0J5QHbZMp/xi3JPFlq2w8v9JHGo57EJB/3fcThEvLCeHzSWfD70g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(8936002)(31696002)(316002)(2906002)(956004)(44832011)(6666004)(16576012)(66946007)(31686004)(66476007)(66556008)(186003)(508600001)(83380400001)(26005)(86362001)(53546011)(2616005)(38100700002)(36756003)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGZKdE5LRTlLYXZabitPTE05cENaTVNwUml5ZnBPN2FUMDdSS1lvQVVCYkNk?=
 =?utf-8?B?OW5PRUlsMThIRW9KUXRub2U0ellEVHJZY21MUm53eC8rNVRXVTJVeFNOS2Ez?=
 =?utf-8?B?dVRqVGQydlFMbUZzTnMvSmkwOWpFRklsSU5Ma1l0bG4wUlQxVTVHellaUUpa?=
 =?utf-8?B?dGttTFI3cHIxNGRDcnJWQ3I4SFFFL2o1d25vdVlMbkllYnhWbDlnUzF4NUlR?=
 =?utf-8?B?OWY3WURJaVpDNTFNN0k1b2w1ZE5KblR2UzVyMkNsUzlJUlRBdFhBMnZhRGwv?=
 =?utf-8?B?THM4NzE5NG9mNHdRR0VNVjBndFFPYXVqcE5SYzBKNGRaaldwSjd1Y1NtQmRW?=
 =?utf-8?B?QXRoQ1V2c1BmZllNUTZqZXNHYXQ0d3g2MlBpSEhHenJrN2VibFZySmNXSldI?=
 =?utf-8?B?QytYN2JIR2NGQzF2NUg0b2VnNWljWksyQVdnU01qOTNCWWRqeVk3cGFLYUpa?=
 =?utf-8?B?RHBKZHIydEVySmFNbzBkc2tadXBycVA0NzlISXlYaVZXcUNyVzlDS1U3MlVE?=
 =?utf-8?B?Z0EvbUphblozOC91Zjd3NFhTMkxrRTZORzgvQlFaTWlOeHIrLzFvMU42ZlZP?=
 =?utf-8?B?ME1iYzJONVpiZXNBUm9sWTFUT0toQ1J3bXFPZDlZdnAwdzVIWjRHNDFYajcz?=
 =?utf-8?B?aVRzOVY1dm1CcUg5aGNlS3hnYkdxdjNyQmdWMnludjNUMEpEeVNFZDlhSXQy?=
 =?utf-8?B?bUZ1b1V6ZEE1cGdMUi9TOEd6TlhEdGY1RHNQT2FONzBkaDJjUGxacVBMdFNT?=
 =?utf-8?B?MGNXcmdpL21jU01KUkU2V3dFK0FrZGdyWVB4MmZsbklEbjhPM3p6cFBUK1pn?=
 =?utf-8?B?VzZRVVE4YmJzVWtKcWxQUjRqVkF1L3lkZnBHTDFZa1dhYmhhNUxQSDVyRFEy?=
 =?utf-8?B?UWdVcG94bHJZaTRSOVNTVG50Y05Wc0xRaEJkRDBPczlkMmlJc1ZhMHQ1Ymll?=
 =?utf-8?B?ejY5QVR0UlcwSjFHNncxYWdFNmpwcGp5aEtmNjFpMEw5b1VnK1Mwc0wrZmlp?=
 =?utf-8?B?N2pqdUx1RVA0bDFsWk55d1NtT09OOUZnTkRRVFBVaWczRkpMNjEwNFJHUzRC?=
 =?utf-8?B?V253NXljR0RhOFRaT2ZpSmJxaFB4Yzc0UWtjZ3JzT1kxR2t0SGlzbTVJelhZ?=
 =?utf-8?B?aGFGNWtOVWM0VUxVRlRvS2cyS21UQlNsMzBQL1YrNEpFTXY1aDBSbzR1L1E0?=
 =?utf-8?B?UXVEYks5aDF2cHZSMmN3Z045bHIwMGwzd1paYmNndlFNYW9qWTVUZU5zZ3Nl?=
 =?utf-8?B?UG1uck1OS0dtWk9CQ3VHZDJvOVlEMlBkLzBRVWNnVllUUit2T2ZXWTNLd0Fn?=
 =?utf-8?B?V2xGUHNHRWNUUWJjclVTZkJobUlabElXdzhkZHNOb0l3bFk4cVJJeUhvZmYw?=
 =?utf-8?B?MmkyS0lzZ1A0MzN0cjY2cG5ycUdiQ3pVbXVOeE4ydUg4c0xKWURGcEpCTm5T?=
 =?utf-8?B?a0lYbDRMMk9XRFdXZXljKzZlbldLek1hdFU5c29FeE5WN1NjOUNZa045cjUz?=
 =?utf-8?B?THFWT2ltUmtaS21zUExXRnFISWhZZzAxWTFpVGJ2dk51WlNMRk5ORHN0Q1Jh?=
 =?utf-8?B?MXQ5YUFOR0VvT0N4VmdZZGY1UlJ6SFZJWlNSQ3hKdGRNdTMvOE5HeWV1N2Q3?=
 =?utf-8?B?dThxdkkzRk5TSWFsT0ttUTVNTXRPTWlUVUVSVHJwbDc1MHAzb1BiYW15WGxH?=
 =?utf-8?B?dWpvRGZ4MktkODZVdG81STFYeWk1amRZUU1PdTZ6ODlTaGlYMWlwRWxnS3ZX?=
 =?utf-8?Q?AKVtodMvwptAJ/sF5gSaRYzlDPwwvrZrD+qeVpx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c2b8ea-db3d-479e-ec57-08d95130318e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 18:56:08.2431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3QlEKITpK3hsZroisRPMdhqJzNd+QM+YyR3ieqphbXf3Rg20t5v0U9C8EC3ulyPW7M6FkuuctYArqE10iHxSID8ysF6wELy2C4Msdy7V4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/22/2021 7:33 PM, Hui Su wrote:
> The code is executed with interrupts disabled,
> so it's safe to use __this_cpu_read().

True ... but could you please elaborate what the issue is with using 
this_cpu_read()? It too is safe to use when interrupts are disabled.

> 
> Signed-off-by: Hui Su <suhui@zeku.com>
> ---
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 2207916cae65..f0cc0a89333b 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -464,8 +464,8 @@ static int pseudo_lock_fn(void *_rdtgrp)
>   	 * cache.
>   	 */
>   	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
> -	closid_p = this_cpu_read(pqr_state.cur_closid);
> -	rmid_p = this_cpu_read(pqr_state.cur_rmid);
> +	closid_p = __this_cpu_read(pqr_state.cur_closid);
> +	rmid_p = __this_cpu_read(pqr_state.cur_rmid);
>   	mem_r = plr->kmem;
>   	size = plr->size;
>   	line_size = plr->line_size;
> 

Reinette
