Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0E2307E89
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 20:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhA1Syx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:54:53 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:35694 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhA1Swa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:52:30 -0500
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 13:52:30 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1611859950;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cYhjD4T5cU6tR2J8D0ws9LBLrJS124YHmYAM+Ck5htA=;
  b=EGZFtWDfJaiNTgejY+todi9nF6jYMWP1DJhRanG/Onu7HwTWfMo2owmn
   bCASw98VzePZz32dFquJ+fnBd5ctfzXRnQmyWDoxmJmOpVMGM768DsW5B
   MauZYNypgEIrUJtum5T1lsLGSxRhEdaXHojg3bA9aOzkH9Te/lB6DAT9h
   Y=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: i90qyIxz6bMtbfp1UUwMN6NB0jR+LmqBAHesHu4RMTkWfTPpB1Y63us6xP1qtTnVB3lN7YCuvL
 VUnlZXJ5HpDFXOYu1nfJWXjZweN88XEf6aTk5b0VhtzpuCKkjjIhjuPPekQ76Zu9EZtNHllczU
 JFMhEKkCxHYKScxlELxTNWDxvSHa4Rr/Aq7FGYvPf6ieUaCW96hX3mV2RmCIJ2Eyms07BS4OKJ
 lRG/HxAOtv3ZyeJVHR9qva3vSmCEWHV+C01MRbqh4R/FFpRTsXV8Jl9hWr4FfYbWMeU+u72+vF
 UaA=
X-SBRS: 5.2
X-MesageID: 36132893
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.79,383,1602561600"; 
   d="scan'208";a="36132893"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=og7cVCSSYMytKJdJaCUODQD3VplVxBp2/nr++TU1U07xF0Is5NAoyIYvmZ2l0fszV/L13spE3ANT96Ae6CG/PJPCgIeojrbIRgw/ZhRiU02YuMnKHtRP/nG7NgZm0bTBwdspgNT9XKsg8pT3p9mu8c0S48fSc/se7qcZKajsN32oTcxtbV8wMpz7IBKZFmSTaLI/ORlzyciLpGDIUHULfqG1ul0bFlxgCzN6NZRcKWab/RmlmiHQYxbILcEqq1FNJE0sMvv9cqxVRDtjN01j2HjEpfMMWW8Uk9cFTiVfLW8AtrfaRkrcNrev4CBgKg+JIdGrj2oP+zTFqXdN9RBx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/95W13XXCa1LP+9pVALWtekmdeSRq1JNgoHMSnCxgVM=;
 b=cdXuYkLgQSmJV9aRTGIjCP4K1IMsglER++UcHtl4pRV45i7wrI6yD/8qvtGWengCOs72ZFteVCm0YHFT0tlCAc3GX7pyvNOEgQi4DF+6l2e1tDCXTR2ElnPmfpJqr7Hs+qE5QK6CGtd/QAMkxArcKCfHa308RcFX2MRcTwMtsBYlFHUrp2vw0wSoA16F6r1+FlEgLJZ3ObgOp6rg0Xk3l3YpdrV/p6Rz7auDwavhRf5zTOx31GYVWveqkW2TFAXk6ky7sY8Cnno1IvOpk4fPsxjyjCWEeQ4/qwn1f9FlalLOLRxEEKjvoUCqgX1VnV2N40AxsnHvNaV3go1TDgO4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/95W13XXCa1LP+9pVALWtekmdeSRq1JNgoHMSnCxgVM=;
 b=aJJHrGxEBeq41RJ0h4ANqY4kX1lvNq6lcwfIi/bYCs/KGGN6bZRJf6gg7mUQ1Zm2DN0SW1pMHsrHz9lEQ/fIdsN77iTC1eyh+Rmhrna4ZraI+fYhbdAtVwDqvKYvo1YBFCYBoItptDBJjF4xLoXb3bxUqfB0HVK2xg44zZkcNSg=
Subject: Re: [PATCH] x86/debug: 'Fix' ptrace dr6 output
To:     Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
        <tdevries@suse.de>
CC:     <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <YBMAbQGACujjfz+i@hirez.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <3ae6318c-b7b5-5174-af6e-c7f7241e9a47@citrix.com>
Date:   Thu, 28 Jan 2021 18:45:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <YBMAbQGACujjfz+i@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: LO4P123CA0319.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::18) To BYAPR03MB4728.namprd03.prod.outlook.com
 (2603:10b6:a03:13a::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcfc3956-6a3e-4256-e48f-08d8c3bcebad
X-MS-TrafficTypeDiagnostic: BYAPR03MB4453:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4453ABA0CB41F62436499836BABA9@BYAPR03MB4453.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imXpP8N5+d0R3gJ6QcQMr6MlrrhJDciDkVYSn1ZD6Z+ydkomkoVOFXAqNtWyT7t6bEDj2IXiijWPZtmeKB9DfwAO8YPGVEC0K6JDi+tbNmW+imy+G9TZb+MwpCxPaljasLakFNkVtsyRvkKVeO67GuWzmPyd8Sl+RCCOIpufQ+WwneQDmwLKQ8GVLaciw9PdNC3nIpHpvODgnAJPO/WO/6J6o6tDQ3pVusDFjCeMGL+iPvI1AssTZZj8M0YydEKtfwGbWX/uy+4TXoqJqV5pzZHiICM4tbri3aQsubmJMePAptbviNOLq7AVAoGWXBii5wHTk+HSlknMCp16577CdJSKBLRRIDyq9tNPK9dSAFtMVmGn9ydgXVq8+ZbaUW32j5sdQ7Ins0BKkZY4M5LRwAF79W/dbYrpdCdOBaKBU64HjyjOO4VMIGTGRPmu8ozce0siYm8njrqnnIc7aSIIoqFbUtvItoABfNhxxaSI/KT8DbrQRlXSz6ajFmub+XBGw+qBuX4Hux/XbYYj4BypFY3egyx6Z8hkqrZQMwgsnpBh7kBmq20r3SiyAHsexcNG9LQEQ5OLXNraKnA6huuDPwDOPFWhnLpH6K2GKqVqXuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4728.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(83380400001)(478600001)(26005)(2906002)(31686004)(16576012)(86362001)(956004)(6666004)(8676002)(316002)(31696002)(6486002)(36756003)(16526019)(4326008)(5660300002)(186003)(66556008)(53546011)(2616005)(66946007)(66476007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VytUTjVaU0hmbnZnb25rdTlIcEd1NlVtN1I5Z0Q2VnJ6OGgvRTdlaW53TlNy?=
 =?utf-8?B?ZmY1SGhSa3FIL29oYVpHdCswWkRBckRud2h1NiszNC9mYldYVFF4ejFMZGpB?=
 =?utf-8?B?eVBMci9qQkM2V1E0a2Zad1J0d3JQYm9aektSZkZOZ1V0U3lSV3RUWDJLS3R2?=
 =?utf-8?B?TERBOVB0Vld5SkFEUGtsNVM4SzlRaUpPYnc3WndFd0tiaFZqdnNDMVVMZDFn?=
 =?utf-8?B?bmI1ZU1UdUk1TjI3TDhmOFEvNVdTcFJodFNwNWZkazdtMUJYMHNtUDF3Nm5h?=
 =?utf-8?B?SWJuUjBURjhrcm0xV1JjZ2J4b3JnVm5mWks1U2U2c2VkWVViOU1UN0RrVlp1?=
 =?utf-8?B?STVCbzBiUjlQN0JLUktsMVBFellZRFZOOXN2ckZuR3N0WTh1Q1VBeXhlY3I5?=
 =?utf-8?B?ZklrSThjNXJYK3hIcXc3cVIxb0JHVGorZ0daUnJlQmJsc0FiZmxFKytrNHpG?=
 =?utf-8?B?VFNXamdSTlFEb3ZTbk95ZXVuOGZyb1ZYakVhcjk1T1JXTHRiNGhZUU9XNEUr?=
 =?utf-8?B?eTZYV3YvclJMQi9lQjAydWhtMUpETmdybTNiL1NIM2g1VzhUUHV4OW9zZEVl?=
 =?utf-8?B?a1NFbFVWNWlOY2RHVFUvL2xEWDNHckpxekxleC9pR2o1T0FnNnNEWitHa1k4?=
 =?utf-8?B?bE82WHNWTlJLWVNCZWl4clJGR3crQW9rZzF5WFZuTHRRdEJKdGNmb3BCdmNW?=
 =?utf-8?B?bzJ0anRpK2tib0pKakJFMCtHcFVHeWhyZ1BPVGIxd0U0cGJmT2dPN1dWK1FZ?=
 =?utf-8?B?SjR3eXVUUkNuZjNqTDFmbHNYOU4zMldMdjVHM0U2VXhXT2RrOUZ2RUJVNDZx?=
 =?utf-8?B?cEorMkZRRVZoZE40SDNTT2ZSWncxRjFKSWYyL21QSmtzMWdrTHI1cXNTdXVG?=
 =?utf-8?B?MXdlQkpGb1Bmb2VNT1Jmazh1SHZpOWJSMjBxOG9acXlSL25CN0w5VkluN0x1?=
 =?utf-8?B?K3F4V0k2TnlxcHpHUEJBSCtvSVBHdTgrS1dqTi9nQ1d4TVJwZTA3d0w5dnFs?=
 =?utf-8?B?bHY2dE1PSGtvbjFJK21DNUlFbHJxdU9IRml1RGozOGlTTWl4ZlNIZnFSMURw?=
 =?utf-8?B?dTB6b3RYaVZaQ3EvTUwvOGQ3a2l1NlJQQUZaWVU3dU5tTGxXZmZabU9tb0RZ?=
 =?utf-8?B?NGtFdnhiTnpyZ0hGU3RNZDdZZVZDeWlkQXpOOFRyNFRVR0VIbU0yc2RKaytZ?=
 =?utf-8?B?b2R3dmJObUJHZVZjK1ZEWUVvcTBNeXJtTitLdmRpaENmZExpbGt2MW5oeUg0?=
 =?utf-8?B?eXI3TWF1dDExTUljV2owSHFjemZTRzFjR05JV0VEa1RNai8zUjQ1bnZ6UFQz?=
 =?utf-8?B?Q2FQdFltRTRaWnBqdmNVUUdERkU5czdzbWcrZG9QY2FFMDlISzVZUFl5OUxJ?=
 =?utf-8?B?YysyYmdadC9yRnJnNE1jZDY3a2o0M28rekxLZVZJNWhWT0V0UmQyamIrVDhM?=
 =?utf-8?B?MGIvamxyT2ErRVVYWU9YSVVWZm81TWd6RllVdjRnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfc3956-6a3e-4256-e48f-08d8c3bcebad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4728.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 18:45:44.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KokDk2YSD5NXnq2t/W6S26Vzbe2X/89SLAq122ur6jIO+5muIYhwNR0uGL7hGC18iGKq9uvTeCIe4tFs/CtGQVTKseeejYTIDdTcc4FWf5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4453
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2021 18:20, Peter Zijlstra wrote:
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -496,9 +496,32 @@ static int hw_breakpoint_handler(struct
>  	dr6_p = (unsigned long *)ERR_PTR(args->err);
>  	dr6 = *dr6_p;
>  
> -	/* If it's a single step, TRAP bits are random */
> -	if (dr6 & DR_STEP)
> +	/*
> +	 * If DR_STEP is set, TRAP bits might also be set, but we must not
> +	 * process them since another exception (without DR_STEP) will follow.

:) How lucky are you feeling?

Data breakpoints will in principle merge with DR_STEP (as will all other
#DB's with trap semantics), other than the many errata about breakpoints
not being recognised correctly.

Under VT-x because there is a still unfixed vmexit microcode bug which
loses all breakpoint information if DR_STEP is set.  %dr6 handling works
fine when #DB isn't intercepted, but then you get to keep the pipeline
livelock vulnerability as a consequence.

Instruction breakpoints on the following instruction will be delivered
as a second #DB, because fault style #DBs are raised at a separate
position in the instruction execution cycle.

~Andrew
