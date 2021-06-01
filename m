Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8198397244
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 13:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhFAL0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 07:26:43 -0400
Received: from mail-am6eur05on2136.outbound.protection.outlook.com ([40.107.22.136]:5026
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230288AbhFAL0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 07:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jule7a7EjMFcckm/eNfRIbQg2Hz4ihl3VK4KvRkko5gBIIfPZ3+QFz01nJH6WfU29/v0z1uPu4exUdoK7L0wNzNo1FAaBGBwD1euFqFn4LJruAufWX4InBVT489vnG4m99f573jW6LrqGz/ylPzPjyyvpZNOcFDhgZfF5lmpM1pxp/DBVLHVkb8t1UxCepHcnvwunOwYVJ2M7bD28KWNJ++PkWvAxW2S3Fc3DGCeBU0weyj2QzXf0lC59fb/UIBVJW3UtzG1iRfFIffdeC6Dg9EO4gQdQZhQG96/vlk9c5mN5utsk6+rVXMiaeEDNHM11j4hBsUhxPnvhLSXiTaJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfsfKrjx1eTZYodNwwO2DMUAie+6sRuJtMQ0TLUCa+I=;
 b=KcD7cxa//7lT/5CIxI6Pyal2/4VxYRuUQuDhEIO5jc/9cpFCwOLwUisZUnLmS7kF86wkBqgk0CPnYuRTPBhLoc+CTNYa4HjMrHM/S///KAha8GpA4kiNS7a8GML9gMS4G+dEqnH+vwm5+0HIHDxqadxYeFSqluu+fzwryRzNNPEQshezhFpPkr4c3qD0P9IUZ64KkKjo72/txPyJfjDCduXcgHJb70L82zi6q0ZpkrC1tKSLtwlF22xXWyDItdeu4Mfg6bF7QC4MHxtKgsTT4RiBH6zWGyQgjd7Vrxs/xJDhlwz168WaIjqGfv7Wa39E6QT9GgbfeN/uulNGT4XA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfsfKrjx1eTZYodNwwO2DMUAie+6sRuJtMQ0TLUCa+I=;
 b=VBhhB8srOgdwLjVA5ulQzVnNSXarQhIVcHf0BkzYG3OqEPYWEJRMYiOiQcYNMlsnt0cak85sEztY51zk1so7epR4S1CbKW2uDxZGNdPT4h030/wN7GQ8KXS8CwazSnUl/HKdDJP/6u4B+59VsJEtJUk5LWkbrV7qyQv14sPC0ts=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM9PR10MB4402.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Tue, 1 Jun
 2021 11:24:59 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::888d:190b:b3b5:1ad2]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::888d:190b:b3b5:1ad2%3]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 11:24:59 +0000
Subject: Re: [PATCH] ARM: imx: only enable pinctrl as needed
To:     Arnd Bergmann <arnd@arndb.de>, Esben Haabendal <esben@geanix.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <be1c35eb997959b4939b304ef26664dfb9cd2275.1621941451.git.esben@geanix.com>
 <CAK8P3a1HGJpYnmhGb_eZzrv0ZopOJ-JuC6hyNP8V87C1Po9ruw@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <ca33f2de-2f49-cb5e-2d1b-96627c4db2c2@prevas.dk>
Date:   Tue, 1 Jun 2021 13:24:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CAK8P3a1HGJpYnmhGb_eZzrv0ZopOJ-JuC6hyNP8V87C1Po9ruw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.208.74.47]
X-ClientProxiedBy: AS8PR04CA0032.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::7) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (80.208.74.47) by AS8PR04CA0032.eurprd04.prod.outlook.com (2603:10a6:20b:312::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 1 Jun 2021 11:24:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88f90fb2-dd69-4a8d-3a37-08d924efe3da
X-MS-TrafficTypeDiagnostic: AM9PR10MB4402:
X-Microsoft-Antispam-PRVS: <AM9PR10MB4402AB8CA466E48D1F72223B933E9@AM9PR10MB4402.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qaButEtTjhw7XPvY/d0sU/jO8bkKGCUsIzd9/pxESeUm0Ke57u3T78oil2nbQ9mvSZIzz6a6Lbc7oTPz56zEncfgU5wUfYg9468YCh2z4xURZYRyUtoiNlWCcuyfZMV+VFu3mJLvTx3j/f/ONkO1ZbwgbmNglPjGHNBi09g8f4bQRHQk8GAYKmFT/jC/cfXAzijqniM+DRMHuvAKQxU8PxDqWoYYnR4TQCeSYDKKseXsNhj1F4a4EqLXliDoZPy0iplPgN7WPM2jnb3Goo0CwxCAQid+jISwNrIgiOuwoQ/WYfz4GRWw7O79QYsTTlsklE7Lmpss4LA22MACZ+9WZ1SDUfLv84jUCM0Ru1tYVI1BPx7kk3EFHOw3GC7HiqkKT0nXsJDLVKGAe+Hurc9Min7zEsTBdTX0D76kcqzdeIWtLTJMr+N/Ypb79lihic2pPJ3LhVava9LKoVV8PRriiVILzLWfOpuEhhzlgG6Dl4hJfAH56LWku0GHf+wbPZLg2QAl/mEOB2YkaAkHd6nwLhwQFKsK6yngb/za7GEsWomPxU6oZKCYhISsjdQC/TAJUgEQ8LlhPr8ZwHr2yn/ppbVsKAVdjmrNeX0dpu5M7brt6t84nPQpx8urq+vPyWYfLy9bVbAHROsXtyXGYtdK4CA2gIJZss2nQskpBtfTmQWuvlZG6eYHe1qs+6kSvS7Qt3azrRIIh2D+T1eHHB7U3DCKOlaCMmkW4YmAEBe0F8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(39850400004)(376002)(53546011)(7416002)(54906003)(8936002)(4326008)(66476007)(66556008)(478600001)(2906002)(8976002)(110136005)(36756003)(5660300002)(86362001)(8676002)(66946007)(16576012)(316002)(38350700002)(52116002)(2616005)(31686004)(44832011)(26005)(83380400001)(956004)(38100700002)(6486002)(16526019)(186003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dm5zYVpnRlROOVZNVlZTc1BEQ0U4TllqTUlTRDAwSzErdzN5Wk9UWXZmaVdi?=
 =?utf-8?B?TTVka2loUStXSjlEVWFJZEd5L1dlQjlVMFJpTDJoVGEvSldDSFFPZi83OUZy?=
 =?utf-8?B?S2Z5aGVldVNPSlZjdkNmNTc4OGtCSTRTOXF3NkxObk04N2JITUlQVjk5cmlY?=
 =?utf-8?B?b0lveS91dkhKSHl3bldvWGFFZDFCY0ZZcEJCVis3dTAxcUx6Q2x2cDA0b0ww?=
 =?utf-8?B?b0REeHdnWUJNanNNOERacDdPeDBTSStFSFpScExFdDlzUHB6NGZnV0tVcjVO?=
 =?utf-8?B?bGhrN2hXMnB3eEEyS09nQ1Y2eUNrb0dtNG1Fak03S1ZOUzJsdGVDakpFNVZ2?=
 =?utf-8?B?bzhzMWJOKzEyb0RWcE14aFNyTmJCVnBEOWl4eEI4bmdXNEdCT1R6V1dGbmFG?=
 =?utf-8?B?NjVFL2ZyZjZKOTBQaEVJb0hhNmJ3ZUtzNS9RbnFxTGcycVRYQlZYeWdVZ24z?=
 =?utf-8?B?VDIzaG9kUk9jdlpPY0dZQjlqWGN1bm5xbEZZcHlYWWF6cjJGd3J4ODZZaHox?=
 =?utf-8?B?d1JEVXFoYUlWcXkwNnFYMWVUUWxYTDRqTG5sY3ZpZFJvU0hWdktrOGtFUmtC?=
 =?utf-8?B?Z1F1MldWUlhtblJjeGpKci9YanZyd24xUzluNnRYV1JRT3pxRVcxcGJhMFc5?=
 =?utf-8?B?RE53V2xmdDhnWjZCWHBIdWxjTlBOR2VCd1orUVRwTGRFdmZxb3lUVXgzQldW?=
 =?utf-8?B?WDVBRExhMy9oZVpzQWtkdXh6Y3NCQUx2L1FaVkJwcVVhVmUyRTVNc3U5ODJv?=
 =?utf-8?B?WWF3WkEySEFzdlplTjhhVFd3WjY4b2FUT2hBcnR5MVZZWkNEK1ZEQTlPRUxs?=
 =?utf-8?B?R3duNk8xL2hTdHMwU3pNaWw2bnBRYS9FaHB2OVFPeFdtZWhmOEZwOXNvcW9x?=
 =?utf-8?B?M2h5YnJWYnQyR1VxdHVva3pJZHBsT0w5NkxDcW5KRGdRNUxRYmJzdzVsZW1E?=
 =?utf-8?B?N0JJK2tBK3NLNUhMWG5hai81RmdVZ25jbFE5eEx3Nko0ZEx0NUZUc1o5VkFz?=
 =?utf-8?B?RWthS0NlR2ZOTVliZlRLUXE5aUVwVkVnbEZuWG1Pa2lPL0M5Uk1mUm1VNzE4?=
 =?utf-8?B?ai90MlBCanJjOURpSklsYnN1UllYSnl3U0Zmc2NseXFOZ3lSbUVMeHk0ejM2?=
 =?utf-8?B?RGZXSmtwSkFZR3NqcjNoTmNqTURuc1QzT21DMGQreDNxRTJ0U253RnNlVlZt?=
 =?utf-8?B?U1lCbXB5cFlGRy8rNFJ0RnhFVy9PcS9WR1h2WE9BZytYTGp4akZSajdVaE5w?=
 =?utf-8?B?TG04Nmt3OTN3T2VJWkx2c1lKUDJWSXR4ZzF6RzNzNWVZNDFIOUVCOG9PSHMx?=
 =?utf-8?B?ZkV6cm40eXd5YlFxWXJEcjNhdmdzdVE0RzJjdHNYMHQxUERZV0xqazl2L0ZQ?=
 =?utf-8?B?d1VCK3V6Z2UyalR2cyt5QU1EODJjbC9aZDFNaGxNdWMrRFZYdzl3N2dJaEJx?=
 =?utf-8?B?SkcrVVZMVk1OZzRsM2M1c2o0aEV1V1V5MEV4bHRJMHQvMW1aUE5jQ3pSTXV1?=
 =?utf-8?B?VGVCeXc3QWVxclI3bWkwSzZaQVM4NlVRZlpRRStmb0NGMjViWkVGenlxaG50?=
 =?utf-8?B?T0E1L3pmUWVPSkVpVjJoNjh5eFNIMDhhazdSMUpjbkdJM2JNcU9zRmcvTjdQ?=
 =?utf-8?B?aERJb2g4MTBuaXJXWFRXSzl3MGE3Z1Bwd0o3V0ZFVmpzN2Z5WGhIM1FHcS9u?=
 =?utf-8?B?eEp5Mm5DQkR3Ym56S09pMUJVWWVmT3lVaExaL1RrdXd5aEI0S3k5YnllV3RC?=
 =?utf-8?Q?580UFJcfjDoxz+JtV2cu9YNe9DHLIDOhoshzz6l?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f90fb2-dd69-4a8d-3a37-08d924efe3da
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 11:24:58.9658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3WLy83yBNU+sabBKC62w8/SjHIL7QCJRtKVhOIiGemWYXXICMh1hC/mqT/+jxYhrd8+5Scs56j3HY3VgvCk0WYSnCIoTPQUZ53TtjSKA6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4402
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2021 09.53, Arnd Bergmann wrote:
> On Tue, May 25, 2021 at 1:22 PM Esben Haabendal <esben@geanix.com> wrote:
>>
>> As not all mach-imx platforms has support for run-time changes of pin
>> configurations (such as LS1021A), a more selective approach to enabling
>> pinctrl infrastructure makes sense, so that an e.g. an LS1021A only kernel
>> could be built without pinctrl support.
>>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
> 
> I think it would be even better to leave all these drivers to be
> user-configurable. The symbols are currently defined as e.g.
> 
> config PINCTRL_IMX51
>         bool "IMX51 pinctrl driver"
>         depends on SOC_IMX51
>         select PINCTRL_IMX
>         help
>           Say Y here to enable the imx51 pinctrl driver
> 
> which could be changed to
> 
> config PINCTRL_IMX51
>         bool "IMX51 pinctrl driver" if COMPILE_TEST && !SOC_IMX51
>         depends on OF
>         default SOC_IMX51
>         select PINCTRL_IMX
>         help
>           Say Y here to enable the imx51 pinctrl driver
> 
> Today, having it configurable is pointless because you can't turn it off
> when SOC_IMX51 is set, and you can't turn it on when SOC_IMX51
> is disabled.

But if you want to allow turning it off when SOC_IMX51 is set, don't you
want this to be

config PINCTRL_IMX51
        bool "IMX51 pinctrl driver"
        depends on OF
        depends on COMPILE_TEST || SOC_IMX51
        default SOC_IMX51
        select PINCTRL_IMX
        help
          Say Y here to enable the imx51 pinctrl driver

(otherwise, the !SOC_IMX51 condition on the prompt means it's not a
visible and thus changeable item).

But I think all the COMPILE_TEST would be better done later; it's not
immediately clear what "depends on" one would have to add in lieu of
SOC_${soc}.

> The second version allows turning off PINCTRL completely though, 

I'm not really sure what "second version" you're talking about here. If
you refer to Esben's original patch, that is indeed the whole goal -
getting rid of the pinctrl core code and anything else which is under
#ifdef CONFIG_PINCTRL which is useless on ls1021a (and its absence does
not make the board unbootable).

Rasmus
