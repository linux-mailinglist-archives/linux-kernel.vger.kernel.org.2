Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36132A47B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhCBKiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:38:11 -0500
Received: from mail-eopbgr50106.outbound.protection.outlook.com ([40.107.5.106]:37638
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1575281AbhCBKSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:18:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehIV/66ElNso3LldO0DmAcwmHN5dO/08Ks/px6hgREwgN9rCRSqRuq4DdgLjTXzQpI2tJ/QSNXH8OBDIGfRRUURrCt0nrBr+NFB/6frvG0BjiH+a3/CODbY1QuUzU+h1yHRI1tu4cFM++9K5sADUtV9Pqg2qY6491GEIvJ8dXHCChgYWZNAT1GDufQ6MeSxX9xP5bvGg0ex/SYlxaOaEFbQX8gxhqGlF/fpR8O7z90fQ+z9TuVfmpacmCkyDX3yWQ36kQF4kWQp4yt0rTuNoJwhg844Oj5VWbJajBKzU6Vum+sLYDOF26ormzfon8O0YEVaLRz7HrgrIblNJzoj0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX3EXHNLBQWVPPArmym0lRdXl1HHUZ4YWk23lkGFRKQ=;
 b=NIoBWh9xKUD6LNjkZv4J+jIqeirryWYwm2PStMZ8t5FK45N5awD79FRIl/yRt0/lDYlBOWyyOXaJanQYLnQx7/CaMLaxXuzrtoBjbi4u1gH7D43/60vdOVmwDMP68ih1VspOnl2Y3xPD2q9Dm2EAwhkjqOa7gD4GPjxiC2hF/OxjMHY04YOc2E0hIvI5f0pmUy59dogCky5KF5G2LtrQNm5V3Yz7IsCnUcHltJJ9c4BUxXwI3pgSk37ZhW+Uf0nQQgDK78MUvQycDQdJgfrtXCOjcv90HAsDG8IkIuZ/NH1AQKzg10F53u1NrDqBY0YSwIGua8r7y0hdnTC9pbJz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX3EXHNLBQWVPPArmym0lRdXl1HHUZ4YWk23lkGFRKQ=;
 b=N0wvGr2/AtwUGhpe1tbcDPZwyD1ZAWkdvJ0xQd29bgJvWSW1e5GyAHzlQHxq8oHgcwWYukpG0lTkaVnlc850HddfWh9dd358aBiVV0K9O0AuFQS5mCdn/GMX4Cp1EDRT0dVDKKjnX/89qplYgoRIB+fUm0ioMGZIJHvtbsWTS08=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM4PR0701MB2209.eurprd07.prod.outlook.com (2603:10a6:200:45::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9; Tue, 2 Mar
 2021 10:00:54 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f%3]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 10:00:54 +0000
Subject: Re: [PATCH v7 0/2] ARM: Implement MODULE_PLT support in FTRACE
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
 <a5c1e655-cdbc-18d5-55fd-c1690c31acbe@gmail.com>
 <CAMj1kXGEP3BNW6aLDaHFq2FCer-e8VXPU3c8xiojNXSqgzdw_g@mail.gmail.com>
 <CACRpkdZby96WZtO7FEHc1YJ0RfyCi2u_q1PsfJQP6yLGX1Nmrg@mail.gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <950ee6f5-13f2-8a07-6956-6921df4fc435@nokia.com>
Date:   Tue, 2 Mar 2021 11:00:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CACRpkdZby96WZtO7FEHc1YJ0RfyCi2u_q1PsfJQP6yLGX1Nmrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.167]
X-ClientProxiedBy: AM0PR01CA0136.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::41) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.167) by AM0PR01CA0136.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Tue, 2 Mar 2021 10:00:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 374b52f9-f6d4-49d1-f2a1-08d8dd62116a
X-MS-TrafficTypeDiagnostic: AM4PR0701MB2209:
X-Microsoft-Antispam-PRVS: <AM4PR0701MB2209FA531FCE4554157471C088999@AM4PR0701MB2209.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MCu7ArU+OxxkYIzheD4y6kIuBWGoF8n6EPfsq0YRe4Z51yis2WOPIVdTvMSzp7bJLmjzoTwV3WkO+xFkHlybLQ0+m/2ZFofDpnKy5H0YYBXsTzE6LNBn134nxqTntbuTo6lJnshTM2lb49QMep+dGbdIEf//nB23ImwMAd0r2MSM0xUgnBsPXRej/ClESuN4rh2JEqGMR5zYIUHyr45jXUM1HLhlYozgeB3bFatOwZ2r0FwdN0u26G7RXzUVmyl89AuCCkQhmZHX7JUOi+0ozE7VmlE1WaOnzQEW4NYKn2L9ZUkAx3Vll/gCnDzv3hsA8sryrrM2QgGwzEp7Fto3gb/S0mPVXgwwlsTYyyw2ua4mqVHnt9vxAyvlmiEwSQluEb8eJfoOEz9kD8EPCuX1hIVbAaHWaN8374emQesL/ERUcZyHIaYs7nVqH1vPFmTQWzkIdz6At0dAVauuyeselRiudvqgIcxscVpr9ifP6gYaGtDkwrvBwmr7ckEkHva2zoC9Ax4x/RYWFinjZvKXdeGV1g4+WSdhIHLAcr3jfvi68zWTxcsHUGHi+DTAHsC7ICDBkXlLdXR8uOoYFcmnmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(6506007)(8936002)(53546011)(956004)(6512007)(31686004)(8676002)(2616005)(44832011)(6486002)(52116002)(186003)(2906002)(16526019)(26005)(66476007)(66556008)(31696002)(54906003)(110136005)(66946007)(478600001)(4326008)(316002)(5660300002)(36756003)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZnZ4K211TUNQNWNCQ3B3aHZTZC91QW5Bd1BleE55S0w5WENJWW9qZDUyNlph?=
 =?utf-8?B?NWlTeFZESTZZUUVwdnNBWkZ3UHBCeThoODdkTmlNUW1YakdpMnVCaDBFWmRr?=
 =?utf-8?B?K3c2Ull0N2U1UjI2V3BaZkRYeHN3VWFSdWsybHI3R0FNYngxOUFJSkRNMlJY?=
 =?utf-8?B?UGlTVnQxcHBNd0RlZDlZeEVnV3loa0lCaXk1UW9iU0JLUFdPTjEvQXRobDBZ?=
 =?utf-8?B?U0VzV3EyQ0xwc0R2cGxVL1htTzFLNUhwNjlXSkdQQTNTdkJ1WHJhb2hYMmZO?=
 =?utf-8?B?ZU5SYk8vSTJFRXUvaTJveGlINFk5M1E5TThjZDhTaGNBSGdBSHV1MC9PK04w?=
 =?utf-8?B?OXBmUmVOTVNUbFp5WUdSZ3RQdUNlU2xkV2JJbWpreFh4bE5VS2R5Ykh5M29q?=
 =?utf-8?B?N0V4QXQ1aWdrazZwbUg2cXBrQlFYYm1qUk9Cczc0SzZQcTJVMVB0VnE4UmVh?=
 =?utf-8?B?V3hlY25rZTZCRW5WR2ZSTWRoNnRyZ0o3Yk1Xc3k4cm4wdmF2bWlJRmdQVW1T?=
 =?utf-8?B?dGNScWNqblJ3NVVQSE1oUjkzS0YveFJybUoyajl4U04wMEoyK2dFN2NNZnQ5?=
 =?utf-8?B?V3F0dkRPcERKKzlsVWh6cU1weisrb0tkMW9kWmhmUDYzSFBaZWk3YU12Z3dD?=
 =?utf-8?B?N015dzB4TlRISFh4TnA4dGd0ZDk0NUNnZE9XYVZkTEVYMnRoSlFoREdGcHdt?=
 =?utf-8?B?NlNMdEFCNGpyTVRud2RUeitYY0NqWW44NituQ0xDSVJLL3daMnhiUTZUZnJm?=
 =?utf-8?B?c0xJa0tBdVlvVFpEaFhYc1IvZDd3dGZJcGh3SUdZdnZrMThscVF4T2NHMVh0?=
 =?utf-8?B?Q3pLdExvc0UvOWNGVCt1ai93ZHA1UksxclNFb2NydEFIWEV0MjR5Zm9GdXhs?=
 =?utf-8?B?eDdhSHN1OElPcStvU05IdGdkQW9JaUwxNmErWGdEbklEeGlETmFUVTBiM091?=
 =?utf-8?B?dWJDNlIyVkwydVpoclk2S1JSbjVwMDNKRzVMaU9XYjlzc3A2ZG9oeXQzSEc4?=
 =?utf-8?B?U2hWYk9McENPOXdrcWFndjJWT1FrTzU0Vy9ta0loQkxBUm0zSnNsdU5HZnZ5?=
 =?utf-8?B?d3dlZFdqOFpnYTlKZlFHRlZCUCt4UVljUmZna1hHdnJWWVVYbFJYSWNYdjRE?=
 =?utf-8?B?Q3I5Ym1ZVHNacTNrZ0lmRzRnTC93a2RxZnlnaVVzdy9oWEkrMUc1cGJoQlp1?=
 =?utf-8?B?UFlJNzlRUlNjOE9vZTJOdGV2QUxRb3k0di9ZTmk4UDZmcG1LQ0VXVzJjanYx?=
 =?utf-8?B?alRrSlpMZDB0T0FXNGRaTjdxL2JLd3M2aWw5MklPZTFwSHUzY0tSbTgzdHR3?=
 =?utf-8?B?VGZiU1RDZlVHckRhUDA4cmtlVVRRekVIeW91U09CRDZoY2R0ZmhPd3VjOVJ5?=
 =?utf-8?B?TXF1QUNzQkYzRDZVV0drcnFPUlc2aHdPakJqNlZWN21qemxrZ29LZzZqdHpB?=
 =?utf-8?B?QzJsV1dMRENwWjVGVEFxOGlocnlaWUthZWllSFpDNFBCakMyaklVU04rdU1H?=
 =?utf-8?B?VG9EdjBLbEhNNFFJcVVwNEV1Y0Zlc1l4ejk5T1hpbXdJQ05KeWpaUStEUlBU?=
 =?utf-8?B?eHpJRUtKRWJrdkt6UHExVDRacDZYSnRheGlZN0tpc1p6V1pGMzFCd1Z1Uzgz?=
 =?utf-8?B?S3UxRDljUGlVU0R5RWY5ek9KTjlVeFpoUjRzNGowa0JjYlNuYmhJVjZTWUUr?=
 =?utf-8?B?MG43VE5WTXBFWHFwTytBaE54OW9DV1d1c3pvdS94ZG94d3AwQ3JweVJGeDlJ?=
 =?utf-8?Q?LEbEatWrsqHYT3goi3ypngY61Vh7ndF8EP9msMF?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374b52f9-f6d4-49d1-f2a1-08d8dd62116a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 10:00:54.3909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rus3UMy4Kcnj3oZhHV9bQAv1980gESKOokYYtwsniqygvAXrmpsQDT7vG38PCUx+yELnsukZ2XWEhib6dHMp9fmFMS7XVv5kADT5/WRgvww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0701MB2209
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On 02/03/2021 09:29, Linus Walleij wrote:
>>>> FTRACE's function tracer currently doesn't always work on ARM with
>>>> MODULE_PLT option enabled. If the module is loaded too far, FTRACE's

First of all:

config ARM_MODULE_PLTS                                                                                                                                                                                             
        bool "Use PLTs to allow module memory to spill over into vmalloc area"                                                                                                                                     


[...]

> Any suggestions on a quick use case that illustrates how the problem
> manifest and how to test it is gone? The errors in patch 2, what do
> I need to configure in to get them? Does it manifest at modprobe?

And then I use this module to test for the problem:

/**********************************************************************
 * Author: Alexander Sverdlin <alexander.sverdlin@nokia.com>
 *
 * Copyright (c) 2018 Nokia
 *
 * SPDX-License-Identifier: GPL-2.0
 *
 * This module is intended to test ARM MODULE_PLT functionality
 **********************************************************************/

#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/module.h>

static int fatmod_init(void)
{
	asm volatile (".rept (6 * 1024 * 1024 / 2)\n\t"
		      "nop\n\t"
		      ".endr");
	return 0;
}
module_init(fatmod_init);

static void __exit fatmod_exit(void)
{
}
module_exit(fatmod_exit);

MODULE_AUTHOR("Alexander Sverdlin <alexander.sverdlin@nokia.com>");
MODULE_DESCRIPTION("ARM MODULE_PLT test module");
MODULE_LICENSE("GPL");

-- 
Best regards,
Alexander Sverdlin.
