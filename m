Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7247336017F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhDOFMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:12:52 -0400
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:30720
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229499AbhDOFMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:12:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iI3mRZoAMHtu0AvO1wWhy9IDoLXNqc275Eez3qtSXRuauIo5/TDKgmtuP5Ksk87zxHIs1vwldTqOeF09z5bZG3hvJWPHSokHDhXqfNWnBjWQP3aBzUDAhzeFe+jeGk5ujTvXJ9VKLbOvGE96c3Q/mK5wuSAp6nZDswe2UFjzdH3DcdlEQ9Iw31yI1LVHqukFShZcu58M+Q0Mi3QGpqa0en6/j1pTms00IgtAv6tCiggRFhmrYxuKSoCeiCoSFyQ5bUQ2J11/DuT+OENH3/KaG//Dg6sIPUw1y1PIZ2QiVE0/twRuXyuZ86hWQ1iu+TfvZ4ElDkrFR2Xt147AQ57LUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvOLaVvxHFPqtrOzerdBLEJJxpd74HCU6C3bfw3bm4c=;
 b=ncqrtMDbEEmY5DKRhK1HG2CDAKpB8uICUeyx1LG5pfFoY5wXvp6AWnJjbHUYcRsXeH0P5SEn5j0WCoxpCVfruuItBCIRqMhcB+nCaSd1TXkq9Qc3l9MWZSqV0eudmbguU568I4fhrAHIm/ewqVJyBtrOON+SnCjtH40qUWuFQljZDPcXEQiOU2aMcMRlgePT3bFyELgjdntx9h9ydlFk5PKYWqA8jCD8729FD7X2+agZbWlnqWaB44+vHCQ6rfCTQs5AUWyjX3m3zQfTfWqCOmB0sFdMiNnJxlyX7St7GFxHmbZ93UYPXHA08eys4UjehyhT6fFmqnAWWw+EsHeMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvOLaVvxHFPqtrOzerdBLEJJxpd74HCU6C3bfw3bm4c=;
 b=XiXKHzENTv6FMbKOLoMx+uvCsYRFYh9TkdwGdL/VmCzlHnnLMA51haY7hUW6RJQl9tjs3c7HlGuT+yv7Er2PHNitKV2jhKx9k0qDviGM+oDe/OiL4Z2m/GppH0wNo3m7vy30B5rTFktabKtFEaj84fW5PHiZ8jI1t9jbgRlBhu4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR11MB1533.namprd11.prod.outlook.com
 (2603:10b6:301:e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 05:12:25 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 05:12:25 +0000
Subject: Re: [PATCH 2/2] ptrace: is_syscall_success: Add syscall return code
 handling for compat task
To:     Oleg Nesterov <oleg@redhat.com>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210414080245.25476-1-zhe.he@windriver.com>
 <20210414150810.GA19371@redhat.com>
 <e2efffb879914176a2eae8b52a3c5c33@AcuMS.aculab.com>
 <20210414165547.GA22294@redhat.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <8288f70d-4c3e-9b51-0794-369ca73579d8@windriver.com>
Date:   Thu, 15 Apr 2021 13:12:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210414165547.GA22294@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0166.apcprd02.prod.outlook.com
 (2603:1096:201:1f::26) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR02CA0166.apcprd02.prod.outlook.com (2603:1096:201:1f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 05:12:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 194d26e2-edb1-4bd3-615c-08d8ffcd0e36
X-MS-TrafficTypeDiagnostic: MWHPR11MB1533:
X-Microsoft-Antispam-PRVS: <MWHPR11MB1533BAEBE9A5A73DF09D89808F4D9@MWHPR11MB1533.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMfPUE5S5EoEDRS3uJpnp8/32r+dZwJXgLLj/Ht/tt0I4JsDRxcesL4V79I5fCun/LV4Hle00sCEbYMVXbf26+EYIfpiUjuw0p1JfG+C5WGPTAlOkSQHpAUsJm22rgTKam8a1/JSzsGdDfl7ftCcxfGTKbK7fRArMyqznYjfjH8DoPbeF/vHWKlR2WhhCnEGzYfAZbC0wlypfsgcIaE5s7DCJnK86VMJLaibvtp1jiqrEfdDJWts4SzaW1RmNfOd8oCXOBAuSnenHoaYhSNSSfGx8c5QGKmzTuzkD3FjMX8rhnRyJ26pFRDG0wRHoMJBfOekbuKvQXnk67uMjmalSJ8XscqDGfXjWVJQZUrpcx4XdQbQJc1FdK1D1LnFXybte24fy9wrI+G0WPiGUICOrNQFnLtgJwbDyz0cpdPJ9GfvqQrKMy3LlBNZ+4UrJJDpVdg9EEcUIMfCj7FdNlUGtYNueSXU0TLSysX+J97HK+MvvdkRXnTFLMA/QSn9mSYsZ3PTfe2yxdkwFVkQs4IbZsGg5IuziAptAz/9zgwMsedS8xbQwGUBLPu1gnmbyWK/ILeSFvjwBlDdHPnBBaNMgriBgVSH8VJBacwNQk939A8l+TLinBWI9dLjBnCjg/LROhEbOuEr1Peotg6JViYdLjeXhtnkrlBbq+GszQQ5Q30G5D2uv/Ok/HU9ouuc4e13Kk0y8EMsReFhjqF7eu/mErwEPgtyrC45ABHUnFpgXCYMo3VLlFdGGVEo8xMh4Z9t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39850400004)(2616005)(8676002)(6706004)(8936002)(16576012)(31686004)(66476007)(316002)(54906003)(110136005)(86362001)(66946007)(2906002)(66556008)(31696002)(36756003)(956004)(26005)(186003)(6666004)(53546011)(5660300002)(16526019)(478600001)(52116002)(4326008)(38350700002)(38100700002)(6486002)(83380400001)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Tzh4aU5SU0NYcmt4MWxEa1NsSXJtK0dybWtBMTB0Nmw5TTlmVDZlT2hJUXpY?=
 =?utf-8?B?TmlNV2FLb3g4UkZMOE92Y0VhNnVmcWRDM3dLeWhxYmpRb05EaWh2KzNROXRn?=
 =?utf-8?B?bm9LaFF4SythU1hQNGUvWGJoMFBndWo5Q0ZDcDRBQ2dpU0dnQS8ycnpvNjAv?=
 =?utf-8?B?WWR6RUJ0M3RMck9YL0tncHhkSUpSNUlZRE1RdFFSNHk0V2tlMGx2ZEY3Z3Vv?=
 =?utf-8?B?NzJHelpiTVZGK3VMNmdMaVI0T0hBTFdQcFM3UnZTbkptZzdqUHJDL3FQc3p6?=
 =?utf-8?B?aUhqR29sUnltUmwwalBJRVRpQ01VOEtxVWhUQTVwZklVRjlWUzFpT1Zjb2pG?=
 =?utf-8?B?Z0xPL3lEV2F0dUFCNnU1c1N5YWNzZndVOVRoV0pURi93LzhqMEtGTlRYTExw?=
 =?utf-8?B?WFlWd1JOU2tJakhkMFFURm9MQTFDRXRoV1A0U2FWT0daakhDU0R4ZllTWEhQ?=
 =?utf-8?B?SUZaRHlDZmlMazBtLzk4VkhsM1RvU1ovOXpsQ3BCSzZWUjRrUE1aZ0lPeUJM?=
 =?utf-8?B?L2M3NnBGQkt2MjhlUS9YZ0NzQTkraGRLRThjbk5SVFpON1VBSURpaFZ1eEE0?=
 =?utf-8?B?UFNZbytURlp5TThreHVneW14WlFIdWpqZVRGZlpFMmI1Sit6Uk41V0VBZm1o?=
 =?utf-8?B?SU1jWDlYZDR1M0VHMDI5dXJ4cFYvZ1pXOGVMemlrZERVMHVwOTFPbFZZbUlL?=
 =?utf-8?B?d0hyTGMxZlp5NCtGcUt6Y1l5V3BJZEw3Vm5BMGdLcm1mdHR6NmhqZDNMaE9o?=
 =?utf-8?B?emRGYVkyVkt5WkxoUmpoWktZRTNZMXhaUnhjSm93STRYYThZMlNqYUxBUjQz?=
 =?utf-8?B?QzROWjVwUklTM1RXckErdWdlZFRuSnBLTUgvYng3dzJ5YmVPYUFSTEdZci8x?=
 =?utf-8?B?Ni9VZVU3anVMVnRaUUxCTXAzSlR6b2FyM1V2d1djcVZJeVJoa0sxd2dZVC96?=
 =?utf-8?B?MnRCN2gzM2JoZDVyR3pBTW00dG13Wm80WUtheUZSc2JJRTVuVUNmektDOUZH?=
 =?utf-8?B?bW9wbmliT3NXa01oR1ZZcTNvU2ptcG14VklySjdBN2lGUmk3cWE0NUdBSW9w?=
 =?utf-8?B?NGxGd2hkUExsOUpyNENQRUNPald6MjhoMHdwYUR1NDlldU5oeE5qRjVpdWZC?=
 =?utf-8?B?aDR0a0JrbHBsZDl4WStZZXhuNWJjYkY1UDhHVDhVcE5vWTJIR3UzNTBFZTBJ?=
 =?utf-8?B?ckQ4c1J3cTFKNkorNFgvbHg4MXRrVDJ5bEsyT1hOUzZLaVFSSGdYb2dxNTA3?=
 =?utf-8?B?STVGUmxIQUdFQk9lNE8xMDg1aFYrVlN6TXpYQ1ZPSTIyTndYM0VxYUEvWHdy?=
 =?utf-8?B?eVcvL3BnMnhiQ1dnOWFvZHM0R2lpaFl3N2E0dk9WZW5sNUIzYkJjcHdRZVNo?=
 =?utf-8?B?Wmp4U29TUUthaW96Rm81NVpQY1NRM3NSS1RjVHU5N1IvczZuZXlBcmZtQ3hR?=
 =?utf-8?B?T0pHU2dYbE1QY3JUWlZpSkVSM1dGNjg2azFTSWE0dFJBYzFCVWFEWWI3WDVp?=
 =?utf-8?B?bGJHelRYeEszNzRkdWVlZWZpek1HRE1LQ3M5aDR3ekxvODZzRXJhWGdkNWtw?=
 =?utf-8?B?YWZCckZGaGZmdFBRT1hJa21iSm1MRmFVYStoRkg2Y3hWRzV4Mldtd0Q1TDJj?=
 =?utf-8?B?NE5BdjQyd3Rna3BVem5HeWplVjNqRlI4S2FyaWlUejVJeWtjcThHYlQ2d2pB?=
 =?utf-8?B?cDRYU0l4b0h4VWZISkVhenNIOWIyY24wbEZmS2hKWVlRaXFNWnJCdkN0S0Jw?=
 =?utf-8?Q?PUlcIQs9Myd/PFjVZIziwSI6VuvDEwvbPuiPs//?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194d26e2-edb1-4bd3-615c-08d8ffcd0e36
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 05:12:24.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kt38G5UaVII1hDIeAX+w3abEAxRBbMHCookXuSWENKkoMuN/qTD4kgkf4Tosvt2WX4tv698fDqR/d6/9iyaUug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1533
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/21 12:55 AM, Oleg Nesterov wrote:
> On 04/14, David Laight wrote:
>> From: Oleg Nesterov
>>> Sent: 14 April 2021 16:08
>>>
>>> Add audit maintainers...
>>>
>>> On 04/14, He Zhe wrote:
>>>> When 32-bit userspace application is running on 64-bit kernel, the 32-bit
>>>> syscall return code would be changed from u32 to u64 in regs_return_value
>>>> and then changed to s64. Hence the negative return code would be treated
>>>> as a positive number and results in a non-error in, for example, audit
>>>> like below.
>>> Sorry, can understand. At least on x86_64 even the 32-bit syscall returns
>>> long, not u32.
>>>
>>> Hmm. And afaics on x86 is_compat_task() is only defined if !CONFIG_COMPAT,
>>> so this patch looks wrong anyway.
>> And, as with the other patch a x64_64 64bit process can make both types
>> of 32bit system call - so it needs to depend on the system call entry type
>> not any type of the task.
> I don't understand... but iirc is_compat_task() used to check TS_COMPAT and
> this is what we need to detect the 32-bit syscall. But it looks deprecated,
> I think in_compat_syscall() should be used instead.
>
> But this doesn't matter, I still can't understand the problem.

Sorry for not enough clarification.

This was found on an arm64 kernel running with 32-bit user-space application.
The arm64 version of regs_return_value returns unsigned long.

static inline unsigned long regs_return_value(struct pt_regs *regs)
{
        return regs->regs[0];
}

But when the syscall fails, with -13 in my case, the return code has been saved
as a 32 bit long negative number, 0x00000000FFFFFFF3, in regs[0] by the time
regs_return_value gets called in audit_syscall_exit.

Then in audit_syscall_exit, the return value of regs_return_value is changed to
a 64 bit signed long, from when on it is treated as a positive number.

Similarly in is_syscall_success, 0x00000000FFFFFFF3 would be out of error
number range, resulting in a "success".

These two patches are to do the sign extension.

David, thanks, is_compat_syscall should be the right one to use. I didn't notice
the difference between is_compat_syscall and is_compat_task and thought
is_compat_task would be harmless to other architectures.


Zhe

>
> Oleg.
>

