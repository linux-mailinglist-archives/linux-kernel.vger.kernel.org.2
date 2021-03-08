Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFE8330915
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhCHH6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:58:51 -0500
Received: from mail-eopbgr130134.outbound.protection.outlook.com ([40.107.13.134]:18275
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232777AbhCHH6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:58:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkzXLUUAjTx8nXqwQY3Ov8JPJj5pHoQMz4sRmoqSJpTgxdTpiiEkhs878lbyQdl3mrniR7jD5saYdpeCbFGxVsRCQBqT0xIsw3C7Eu3zPg13pJbZcCcyLRegXG1dgamwpXirnQk59J+ceU4JnDoHN2E2dbXiONK5Fw1EePkN1t2eXU1qlYpwbj7PmZk5kKmCEPWITrfx9owh7qWFq+X09jQVyXsi1SeT7koLZZracuDCShvse4nZCRWxoB7KoAFzo5Mkh1RWBRQ9MJ4OdC+7C5rzDC3FhiCF/QTrCioUUXAuKmQEMzZpPHoDjbF30aiCrTZKniRKc2og7SHiNixI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCqn7xZlenr6vb1RIZHITD/wcrObs7D3uATyo7Djtdo=;
 b=mtFhb2mOAgMil0qmFX1Q/LXiAI4HNN/p+Y1eHy0J7kkwby/Nqvl+UvQhr1WaZ4kXIPxz0ntM3PWnfAmLFvwYpylu9504YGATzpMy0JrNnXQC8SS5vL4+jOTNjAdpL8/31vSiubAxgQd6H5AxDHMMCtSreU/Rp2+4mqKPnL5G0dapm7fgUlLkOMfvz8T4Rcza1oNrYFAU+F/pLLzypRsGP9y/EuAvJ0XmE9MxjlXoSw9K0iQQwxVAYA7pkwvVbClDPcs/ABmK64hHagdBwPDd+pcPlViMq3MyHbVcQXkOr0LWhq7NEKs1eXUUbgLq2mNTe95EhrSEQEGGrFpCwtXYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCqn7xZlenr6vb1RIZHITD/wcrObs7D3uATyo7Djtdo=;
 b=sr+t7z3LM9x29YjpeTJC8slkKIqU9DSqbiABX14xtwjjHetXPuCUaoDVBgP/56iNB8FzQJo4ZWlq9BunUHjbR8k6cdZekwwOd5I4+tTWChD6/pCExDQcH0ivtJoAl3nDQubo+N+sCNwkrjiTWzKORfgfzUXI8msj0RFEYhNpVyg=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM0PR07MB3876.eurprd07.prod.outlook.com (2603:10a6:208:44::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9; Mon, 8 Mar
 2021 07:58:43 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f%3]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 07:58:43 +0000
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
 <20210127110944.41813-3-alexander.sverdlin@nokia.com>
 <20210307172650.uztx3sk5abybbp3f@e107158-lin.cambridge.arm.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <0c122390-6e76-f773-86e9-8c085f4384f2@nokia.com>
Date:   Mon, 8 Mar 2021 08:58:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210307172650.uztx3sk5abybbp3f@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.168]
X-ClientProxiedBy: AM0PR10CA0051.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::31) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.168) by AM0PR10CA0051.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 07:58:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d3d579f-04d8-4c77-5178-08d8e207fd7f
X-MS-TrafficTypeDiagnostic: AM0PR07MB3876:
X-Microsoft-Antispam-PRVS: <AM0PR07MB387624683AFD52DCB472849B88939@AM0PR07MB3876.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SYAMHm0IY89zUUmqvZMTy4FkaLnETkXf9dTzNIw2VSwKTipMFKHATQT4yuE/bRVGWOcjdbZVcoXXl5+s4p+T0SLj2O2MlYbn4rMU5R4G9eStfni4fxFeeFjb70Pc+lRXfwURQjyRvB0wLxaL9LRep8etpXor5H8dmSZVfFIukNqvNzdEaQQSYolsZO8dt1b/kT88ZpAB94VF0iSRxvNuiSUxE7jKqGrPFJDCZMQ8r+79TUthGmraxE2J3FXG7eLXmvmX/RsAPcXYcB8FahiinzUrXGSEvWRmYM5Berv7Uv5rf5ma2SeyQE6vab8nGnAUC7btiYHx4hi1ojTdznQSYq31VSFwWnx+nJDMgnMn07RWdemoWPoBkkqkBdJgsQoKWSnDZGZ50Q1NBJtjWPqTXz5Fxp+dJUej81KUhOBVRE6w+Yl+2DZkS2e+q4OL4pz5SRZznzabYiTpcGnGyNUjU0xgWk9U6aX6GsimSbXJhV2qciPq276HVD6ERBldHy8dAEbnM/ffyQyHSAVHJHI7lso8/y/2fsEUcD+nznwIPUjtuTGvk7D7QwrO8xEwRrAvlYnP7dPAbhvOs9M8TJdO26a0K5n0rX9a8FTVgsO8rw7zj6nnz9uNHk3Vymso0OQnUlc/N+IiMpr3+pPNVDz+GJ2hG6ulsQUcHPTi4zZ/Yo1tT2+o+uySWRW3houQCmF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(4326008)(26005)(186003)(6506007)(53546011)(478600001)(36756003)(16526019)(31686004)(2906002)(2616005)(6916009)(956004)(8676002)(5660300002)(66556008)(6512007)(52116002)(66946007)(83380400001)(66476007)(86362001)(8936002)(44832011)(6486002)(6666004)(54906003)(316002)(966005)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Mno4UkZ5VXBSdlNjRFNyNnRON05JYjFXWEE2eTRjdmhYOVVkOFVtbHNFWE1a?=
 =?utf-8?B?RzI2NWI0NXQvVFVVb1I0TzRmMkdrOTJmSEU1dEprOUpJL0lQcGpjdlpxblBZ?=
 =?utf-8?B?d2NrU25QenlIdHZaWklMb1JLZm1GM3lMVFlJaGltTU9sU3BRT0JnVTBsckpD?=
 =?utf-8?B?YTRLYkt3MzVpN3M2UFVQdHVOMytBRUhpVEZra2FSNGRnQVBaZHBMMDd0T2R1?=
 =?utf-8?B?SmJ6MSs2RUJNMkd2SE9qQ1dIbE9mbEFOZUQ4KzJ4azdjU0VqNG1GaVQzcjBL?=
 =?utf-8?B?OXNxRzl2aVVtUXl3ZDA3TjZsa29LQytCUy96QnVNczBDaU56amRRNFZTb2Ns?=
 =?utf-8?B?OEFYUmNVNDkyVkppQlBvY2xhcThKMDJTaUJYcWtDWmJ4QXNVL3ZIRUF5T0kw?=
 =?utf-8?B?a3QyMEYyeGF1QTloLzBvQjhUVCs1NVkvbEFWZThIbGxpcGNnSGtIQ2h2U0Zh?=
 =?utf-8?B?dXJ1ZEcvUnRUK2lKZWpQWWVZU3gzU21zWS9ycllDMzNwQldrblpURmlTUm9x?=
 =?utf-8?B?a1JNbHRaZXU2STRDNFVwV2d3ZmlUR0ZLZVZGR3VDYlY4OExKQjAvMjZyRGlt?=
 =?utf-8?B?OFZTSDkxeWMvS1hWdmRHNTBLTUtZUnFrVHdydkl2Ryt2SVE1UlR6RjFsV0Fa?=
 =?utf-8?B?SmtNVEw1RWFOSnZhQXYwSjFqRVBhSXdOMmFpTit3WFQ3VzZkUlFTbzdlclU5?=
 =?utf-8?B?NHBBOG1hT3V2MmM3YTU0YmRTdXhEakFUcmFvYmxiQXpZUEtTRmJoUmo0NVB5?=
 =?utf-8?B?Tm00d3VORE9weW9nSytwQS82YWYrTzZodllHZkczRjErRVE1RTRwNUFQU0Ey?=
 =?utf-8?B?dkRNV2tHWEk3RkFiVjVFbktuU05LTktaS2l0ZE1jUEJKek9JTWxJS00wcXR5?=
 =?utf-8?B?M2FaUFZ2QXlVTkVUNlFXMzcvYWhJS3NmdTJOY0JTeTJJZk1rQW5TUXhwZjZU?=
 =?utf-8?B?TnVhQ081TklLSGVoSXlxWXNZaEZlZW15bnRBdHVEY2ZTQkxyeFlTZmdPV2Ex?=
 =?utf-8?B?WjBmYjRVV0xaL1d2ZS9zQ3g0OTJTc1h0K0FFUHM3WUp6MWhsMmU3ZHhjSEcx?=
 =?utf-8?B?MjFNWTJ5bHhTbmY2aEtMcEFNWk9yQlRyQjA2RmhsNFR5d0VHS28xS25vU0tG?=
 =?utf-8?B?MFExZnU5eGcxcnltK0FFeUlBTzFSVTZEMGtocDQxMDNhWkR3c0t6Y0M1Rkty?=
 =?utf-8?B?bTlaQ0xmU1B3R09wdW5NbGJUZHVSaHdxQ2JpUE5PTFZzbnR2RDQ1Y3FyWGU3?=
 =?utf-8?B?SkJrclJnUXZ0VnNXditYNDBZWVdGRFBVMk1keU40M3hSR0lTVWQ1RmwwU1VY?=
 =?utf-8?B?SWJHZUJEYzFlSUZRc1c0blFoSUtDcElXNTJQeTNKeFRTMmRiMkhFR2tJaSt4?=
 =?utf-8?B?NFBMWkh3SE5QNEk2MitnQllWME9GWmViOWhpVVJWYWhZWG80Z21lOTNmd3FY?=
 =?utf-8?B?UTBobk02a3l6eUszK1lGQjBFbUxMSnI0a1BkWTBCYnh5eURvNTJoTGpxbm9m?=
 =?utf-8?B?N3YvbW9OVUVZSDdjUkhxT2N5UkZjMm1yRUZsbDhLeFBnZjc3Y0dRbERwcFpQ?=
 =?utf-8?B?R1I3R3ljQXdFcFg0bHM0UkFPbllQbm1qWVlCOWFqVEJudGRrYmdaLzZSd3Ez?=
 =?utf-8?B?Yi9WanllOUlkdDVjNzhyV1ZOTEJ6ZDlPYnVjWGNEMEcvYUQrZENKT1dYUTZ5?=
 =?utf-8?B?OU5lTlBDN2lnaVNaK1RVcFUxSjIrcmIyRW5uNjhUWDR0V3NvNnRPcWFQVFhu?=
 =?utf-8?Q?Q1xjIj1Z3x+ka2ZuTfIhQ+GUlZMz/SD3CsYq5eC?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3d579f-04d8-4c77-5178-08d8e207fd7f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 07:58:42.7927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ogyKeBxZ74rDGljd3H9tts8cf0Otdbfulk3h6aKXN/ZCvx07tKVWXBLP+1yIPFinXBnKXUtU7Olhra/ULwzcYUrv/w/W7eDe8H9EDDV1L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB3876
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 07/03/2021 18:26, Qais Yousef wrote:
> I tried on 5.12-rc2 and 5.11 but couldn't reproduce the problem using your
> instructions on the other email. But most likely because I'm hitting another
> problem that could be masking it. I'm not sure it is related or just randomly
> happened to hit it.
> 
> Did you see something similar?

[...]

> 	[    0.000000] [<c1b01a38>] (ftrace_bug) from [<c046316c>] (ftrace_process_locs+0x2b0/0x518)
> 	[    0.000000]  r7:c3817ac4 r6:c38040c0 r5:00000a3c r4:000134e4
> 	[    0.000000] [<c0462ebc>] (ftrace_process_locs) from [<c2b25240>] (ftrace_init+0xc8/0x174)
> 	[    0.000000]  r10:c2ffa000 r9:c2be8a78 r8:c2c5d1fc r7:c2c0c208 r6:00000001 r5:c2d0908c
> 	[    0.000000]  r4:c362f518
> 	[    0.000000] [<c2b25178>] (ftrace_init) from [<c2b00e14>] (start_kernel+0x2f4/0x5b8)
> 	[    0.000000]  r9:c2be8a78 r8:dbfffec0 r7:00000000 r6:c36385cc r5:c2d08f00 r4:c2ffa000
> 	[    0.000000] [<c2b00b20>] (start_kernel) from [<00000000>] (0x0)

This means, FTRACE has more problems with your kernel/compiler/platform, I've addressed similar issue
in the past, but my patch should be long merged:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1817963.html

Could it be the same problem as here:
https://www.spinics.net/lists/arm-kernel/msg854022.html

Seems that the size check deserves something line BUILD_BUG_ON() with FTRACE...

>> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
>> index 9a79ef6..fa867a5 100644
>> --- a/arch/arm/kernel/ftrace.c
>> +++ b/arch/arm/kernel/ftrace.c
>> @@ -70,6 +70,19 @@ int ftrace_arch_code_modify_post_process(void)
>>  
>>  static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
>>  {
>> +	s32 offset = addr - pc;
>> +	s32 blim = 0xfe000008;
>> +	s32 flim = 0x02000004;
> 
> This look like magic numbers to me..

These magic numbers are most probably the reason for your FTRACE to resign...
Those are backward- and forward-branch limits. I didn't find the matching DEFINEs
in the kernel, but I would be happy to learn them. I can also put some comments,
but I actually thought the purpose would be obvious from the code...

>> +
>> +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
>> +		blim = 0xff000004;
>> +		flim = 0x01000002;
> 
> .. ditto ..
> 
>> +	}
>> +
>> +	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
>> +	    (offset < blim || offset > flim))
>> +		return 0;
> 
> .. I could have missed something, but wouldn't something like below be clearer?
> Only compile tested. I think abs() will do the right thing here given the
> passed types. I admit I don't understand why you have the '4' and '8' at the
> lowest nibble..

Yes, the limits are not symmetrical. These "magic numbers" have been checked many
times by me, but I admit I'm not expert in ARM assembly. I'm however still quite
sure about them.

> 	diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> 	index fa867a57100f..b44aee87c53a 100644
> 	--- a/arch/arm/kernel/ftrace.c
> 	+++ b/arch/arm/kernel/ftrace.c
> 	@@ -70,17 +70,13 @@ int ftrace_arch_code_modify_post_process(void)
> 
> 	 static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
> 	 {
> 	-       s32 offset = addr - pc;
> 	-       s32 blim = 0xfe000008;
> 	-       s32 flim = 0x02000004;
> 	+       u32 offset = abs(addr - pc);
> 	+       u32 range = 0x02000000; /* +-32MiB */
> 
> 	-       if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> 	-               blim = 0xff000004;
> 	-               flim = 0x01000002;
> 	-       }
> 	+       if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
> 	+               range = 0x01000000; /* +-16MiB */
> 
> 	-       if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
> 	-           (offset < blim || offset > flim))
> 	+       if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) && offset > range)
> 			return 0;

See above, the limits are not symmetrical.

> 		return arm_gen_branch_link(pc, addr);
> 
> In case CONFIG_ARM_MODULE_PLTS is not enabled what would happen? Is it
> impossible to hit this corner case or we could fail one way or another? IOW,
> should this check be always compiled in?

I didn't want to modify the original behavior and the limits are again checked
in either ARM or THUMB implementations of __arm_gen_branch() (there you will
again find a nice set of "magic numbers". 

>> +
>>  	return arm_gen_branch_link(pc, addr);
>>  }
>>  
>> @@ -124,10 +137,22 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>>  {
>>  	unsigned long new, old;
>>  	unsigned long ip = rec->ip;
>> +	unsigned long aaddr = adjust_address(rec, addr);
>>  
>>  	old = ftrace_nop_replace(rec);
>>  
>> -	new = ftrace_call_replace(ip, adjust_address(rec, addr));
>> +	new = ftrace_call_replace(ip, aaddr);
>> +
>> +#ifdef CONFIG_ARM_MODULE_PLTS
>> +	if (!new) {
>> +		struct module *mod = rec->arch.mod;
>> +
>> +		if (mod) {
> 
> What would happen if !new and !mod?

I believe, that's exactly what happens in the dump you experience with your kernel.
This is not covered by this patch, this patch covers the issue with modules in vmalloc area.

>> +			aaddr = get_module_plt(mod, ip, aaddr);
>> +			new = ftrace_call_replace(ip, aaddr);
> 
> I assume we're guaranteed to have a sensible value returned in 'new' here?

Otherwise you'd see the dump you see :)
It relies on the already existing error handling.

>> +		}
>> +	}
>> +#endif

-- 
Best regards,
Alexander Sverdlin.
