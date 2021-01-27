Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B78F3058BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhA0KrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:47:13 -0500
Received: from mail-eopbgr80114.outbound.protection.outlook.com ([40.107.8.114]:64742
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236130AbhA0KpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:45:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTPptpDAiIj3mpAbp7hlxrbaXUZYtwnpafnU9zgxsu7ZIKgJ9incXHGOTP26/GJi/3BGbJGHjzcKNRD0cJRGlNsKQEzDILKTaUWzRZ33V9i2X3QhYUPEFNRfnmv0ZtApzuM1gkG5Kvjtv8FB0EAkQbN1amDa/aE0sp+q6lHrdyPI7kRtDmA9Bbj5t89tDm1xik2fHRQ8xgSXkpY/hdpoLkSPUVVDhBKAC4BoEuHOiNjveIrJlqqJkKwEsLPjvlC28ugJxEiT7EBNAlIgJ3ZVQL8ZdYas9T7P7yHcYLca0vjDlnBpaI9r9yOftzZivAnHZjnwKmg8o/Jgu3edPtP5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03sxbIybWFtHLUodK10tqa3BG06FZ7lFnrdo24gZFfg=;
 b=mmYvFT4mf3t3Qxpk8iqGNzZROQ1rd5wBgqIBq7nREvU38+E+yEEFz3Wcsodt8MpgmMcCbocVXjnN70EUXmANFYVpwZos1jCPzrURwLS6yFwZWqkGYkPow9DP9NVExSJM8Hv8YY+hsdbrI/p8dOvm3sOuKkrU9+jtpZ+lfCmgzQB0//ykyaPGYS5R4PL2311cLMnnYcwFs9hNLBi2rQcghju7J5AFHDejdZB2SJNP8JVY1Tj+C6NAYIPlzFs10oq4nJj64Whes67JEeAJP7u+TFQrWxhNEj4X7TngquYvTSzD/ZX07Z6tZJ5dekCjOy2mbX1zxDZhmZ4BW8nuBkb0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03sxbIybWFtHLUodK10tqa3BG06FZ7lFnrdo24gZFfg=;
 b=c8DAowrf07RoWmgZKPmMNGQLxnxYgr95m7n/S6v6ZwDN2soMCwEsoq9Hp3zZGWuCHQc4WMI8gP4jHvvQGfiL8GtEhdrPRoaZKI+V111rqLiiMsClDfXnUvo1sqZeIHIkTlHK9sfY1DHpwSMOycZUpSP3XGQGnv6oIj7T5U66LMg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nokia.com;
Received: from (2603:10a6:208:6e::15) by
 AM0PR07MB5713.eurprd07.prod.outlook.com (2603:10a6:208:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.6; Wed, 27 Jan
 2021 10:44:15 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::e965:2884:260b:b29a]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::e965:2884:260b:b29a%3]) with mapi id 15.20.3805.015; Wed, 27 Jan 2021
 10:44:15 +0000
Subject: Re: [PATCH v6 0/2] ARM: Implement MODULE_PLT support in FTRACE
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>
References: <20200217140955.211661-1-alexander.sverdlin@nokia.com>
 <48289cbf-9108-2807-7143-c3ae625bd940@gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <19e02972-c2e2-0e5f-b9c7-9f750110db77@nokia.com>
Date:   Wed, 27 Jan 2021 11:43:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <48289cbf-9108-2807-7143-c3ae625bd940@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.167]
X-ClientProxiedBy: AM0PR02CA0118.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::15) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.167) by AM0PR02CA0118.eurprd02.prod.outlook.com (2603:10a6:20b:28c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Wed, 27 Jan 2021 10:44:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 798ee174-c672-4e11-939a-08d8c2b07daf
X-MS-TrafficTypeDiagnostic: AM0PR07MB5713:
X-Microsoft-Antispam-PRVS: <AM0PR07MB5713F426C70AAF6A1FC83C8688BB0@AM0PR07MB5713.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3hZ84tu12fBoG99U0ULpKxNveuJcw+zN8hGHiA3u46oWvDReyK7Y1AbpqszCdxFKiz9FrdZ/L7ujWGmpxaLXOk7A+AJzJPX9U/RftKX4YBwyijxEDi7Z6Z2YmQY17fMej69g8rhwW5qoOyRYFB7uEYIy3vkQUg6WbqxnSie4mR3iBtzLA0XkFn0a6Pl6sAbY8jf6L0L6A1mvM8Al79ZQvK9hRqmqgwjhXeHJosdPmnv7zprOZkqWvu4YZQhFTXjtNU9q6lHiDOcnnPgMGFrQL/eZsZnp+95Qol1Ugp36HC0HVHEJXV9ut+k29WJP7CoZXZeg49IfYZiSVX3aLw8nh0ANVuG3iwzry/vjdCbN59jsunI9yk4KZ62M4/RppL3TcVxbTpJ8jNEqy+sVDrxNF3KzwZukFrPORmlaI4F2ZSutWJ0dkYQbBcVLd6BDTgHo2hbhAZko9ErDgmTWkP9L94Oi/hpvmDAyWGCMLWecHkmYkHBMP8TfrVKQ2ILEjyaknVfCcFlLpt7z31a1Lv8EWqOpHUI+LqamFjGTKPgA6em8R43Wb5q75Rifgfaj5TbctB97mHIwqnx+tseBUbyO8DP+U6Xo+vA8jgpHEVbFug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(2906002)(16526019)(54906003)(956004)(31696002)(5660300002)(2616005)(6512007)(186003)(86362001)(66556008)(44832011)(83380400001)(8936002)(36756003)(26005)(6486002)(316002)(53546011)(52116002)(6666004)(66946007)(478600001)(6506007)(31686004)(8676002)(66476007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZUNMTVNXajQ2L2RZMkpuRmlxei9WVWF1V1FmNkh3NlVPRUxPemRnc1pVenBV?=
 =?utf-8?B?SHFVSGhvRDJ2SXBTZktwSldiMkQ5bjhSUDdObmZRK3RWclo3YlAwUTV1cVNl?=
 =?utf-8?B?VzJ4UGtIUUhsMHlwYmpQeDRGWkd2OVBieWRyZEE3NVlQZ01FTWY5NE1zaXJK?=
 =?utf-8?B?ZURZYXc0SnlMaTNEckdnejhhL3NEZmlZd09NVWRuY0NYaHl1SG5MUU40cFRs?=
 =?utf-8?B?dkUvWTRtQlFadndMcUtGcGx5RXpFOEhPbVVRMWhnRDdSRnV6M1hmaWdJRk5i?=
 =?utf-8?B?UXcvVmt6RSt3bHlGK1lrRWpOR1NjWjc3ZEV0V2xmYVFVNTFXdFhCd1M1OFZx?=
 =?utf-8?B?K0lzUU1iODdxTnYrck5JRTZYbldra29lNzVCWkZXeXBXVFNNc1VFbVpjWXE5?=
 =?utf-8?B?eWdOc24vMzRka1M5UW9qM0xHbTNLUE4vc1E3amFpNU5kcjNsZXJEY0tQU0pR?=
 =?utf-8?B?VG05QlBaU2t4dWE2VGRKL09LMUlseWdyZ2VDYjFGUUxXZFZNbmpsRDVhR0xn?=
 =?utf-8?B?QWtpbzFjbjZiVG04U2xQeVl4dGNLdEdPN2RnMXJIL2pTbkI3YVJ3U0I2V2My?=
 =?utf-8?B?dFdiOUwrNVZsZUJOZ04vZ0pjL3U1TUI3Y1FuSUxqdXVScFd1cE5QRW1uSWRL?=
 =?utf-8?B?YzF4bERXOGtidjgyL0VpTEkwc0RnKzI4d3ZrWlhRVWF5UmdyNFo2UWtPUldo?=
 =?utf-8?B?VXpERnhDby9RakNHdjJrNEgxM2w2Q1BNTnZTeDZycyt3MDI4NlZCd0ZHYkpL?=
 =?utf-8?B?S3EwcVVDTk8rT0ZxdHh5NXl4Y2NsbjdGZkFtZGlnVGRib2ZtcllQc3djUkRN?=
 =?utf-8?B?SnBJcDRwMTl0am41dlJFb3NLSTBuNFpqcG5jUkpObXZtZkZaQTJMSWJGTnRZ?=
 =?utf-8?B?YWhic1ZSQmhpTGlJNU9ySDJSYlFPOE0xUmtrQUVkSXFhSTdVYnZsUHBCZURK?=
 =?utf-8?B?cnRkeFdXdGF5RkppVHhqSkxFTFI0NnFlUktSeXJwQVhreWx1SlYzUmxnaGJY?=
 =?utf-8?B?ZllFanJ0VnRCMXdqZElQR0NFOGVkWUg0dTZsZjFHcklRckg4c29vM0tyWUl1?=
 =?utf-8?B?VVYvdW1RZHpGSldsdUYvVTBWejFpRHRrOHlMT1pxNjQ1SUxzT0RTbUxZQ3NQ?=
 =?utf-8?B?ZUJaNUkzdDNLMW90eFlOQkNMQ25vTWFNd3hyQ0RpQ05henF0ZXNieVNmN2dW?=
 =?utf-8?B?aVZmNnRhMVpPbW95UG5aSytOTmFuaG11akZDVVlTS29nYmNaV0NQS1pvZEh5?=
 =?utf-8?B?dC9VVXJaZmhLNGNXNDlUSkJIaFdJcFZZNDEvdUFYVVNLMWtnUHBwckpYUFF4?=
 =?utf-8?B?d0tFZ2VQckRvVGdLd1R5MjArdmxqT1ZSQ0lGY29TYzJhK3ZTUGJWOXJ1cVFx?=
 =?utf-8?B?cGtlV3NjWXRkZWhiejR6ZmE1MFFOR3VTZllrMHFTRlora2VzM2taREFISGJO?=
 =?utf-8?Q?l6mDxqAh?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798ee174-c672-4e11-939a-08d8c2b07daf
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 10:44:15.3265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bt2cCiP6Fdue9PizosWYMljRC5DwtaEWwNvBENtz6bVnjE8P0+z9nkaUtphgs4a8zb9hIs9Spr9FZcFw0z2OGuGx/eYHkiLUuqBdx94nsIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB5713
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Florian,

On 27/01/2021 05:48, Florian Fainelli wrote:
>> FTRACE's function tracer currently doesn't always work on ARM with
>> MODULE_PLT option enabled. If the module is loaded too far, FTRACE's
>> code modifier cannot cope with introduced veneers and turns the
>> function tracer off globally.
>>
>> ARM64 already has a solution for the problem, refer to the following
>> patches:
>>
>> arm64: ftrace: emit ftrace-mod.o contents through code
>> arm64: module-plts: factor out PLT generation code for ftrace
>> arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels
>> arm64: ftrace: fix building without CONFIG_MODULES
>> arm64: ftrace: add support for far branches to dynamic ftrace
>> arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()
>>
>> But the presented ARM variant has just a half of the footprint in terms of
>> the changed LoCs. It also retains the code validation-before-modification
>> instead of switching it off.
> We have been using those patches and I was wondering what happened after
> this version since they did not show up upstream nor in Russell's patch
> tracker? Would you be willing to resubmit them?

it's a pity, but nobody ever showed any interest to take them to fix real problem
in FTRACE. A grain of salt would be to remind, that no-one also replied that
the series helped him or a Tested-by: tag. This would probably wake more
interest from maintainers side.

Of course I can re-send them because I personally re-base them regularly.

-- 
Best regards,
Alexander Sverdlin.
