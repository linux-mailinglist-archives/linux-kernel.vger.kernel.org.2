Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495213B8538
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbhF3Osr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:48:47 -0400
Received: from mail-eopbgr60103.outbound.protection.outlook.com ([40.107.6.103]:54559
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235215AbhF3Osl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:48:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Es/ArBhcAPr6fcHnN1NYdr96+w/SeBWL0xDyAd9UcgklAeJnYFjYjVSlte/YMvEIBKpnIwZJ4mdP1aBc4Ro6QGFc+iBNwlorQ7dfJ2xsHjJzCEEPd4GlVA+/g6funyGH/xWhUTXAV1SHWpfZVMl12oItqcv5yDPSXDnrqdNqwAM+/uvhxUFWIVE7YWczLQyFFYsKtIGUk/lKZ3GKaRuFg64VmfKJ9Rx2rRakxorTpC35md7l96N8oApFKXQRouQY4unw1ucX1x1u3SUu9UxzGjmZIzTotnTUcXGo7mGHXZaqvbs3BbH2cZBWKY1J6mV7kJpa8F2VWuhOAwU/djmn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byslURFIMiB2u/+5gcfU9Q8L4s7nkoZtoxF51VwlIvk=;
 b=JdMyi/1aiQlrPRhgmYcocbZF+mml/CXsTLZLcHhvBdYwKTqWgxPpzbJQReIbLeSJyqbycl0m48a1dZ7QTHUcHejllqxLzVmytc6ibqJuS4BqUmfLdht77TT5+lCTXc2wXmtNshulaCWn8PxjbqGG+hDoL/I6gX8jilX/7O/NK/jnXvezoU2CVQMyV33KQ00TxVXyiS1YLlSymOwa/gc5KV1OfLqpQxUCAceJgRJNN6512MlZx1IFwhlKP3OROyZYvpR3Wsz8DS64BacX0JyYQxf/C2KD0M+Qd7wzdWD6H4VWPXRWAZ6gbhs1Ib2zAymmtZtFRUw1mx68T+7UU22TqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byslURFIMiB2u/+5gcfU9Q8L4s7nkoZtoxF51VwlIvk=;
 b=dlB1PXh52KVGMFXck2DjZxK5XBZz3znNt712IOMhHUykwKR9uVBvJzxxD8yruv5U3B6GOgpXaI5xOx+48vYhfYpHa017ngqARAmQCsjW6c2ZRAim3QSCmbP9kvdnvHPOtXUcjkuh1tJoJ11rFQC7Qeo63V3NKA4d2VIWHC5PXJs=
Authentication-Results: amarulasolutions.com; dkim=none (message not signed)
 header.d=none;amarulasolutions.com; dmarc=none action=none
 header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM9PR10MB4839.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:416::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 14:46:09 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703%5]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 14:46:09 +0000
Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
To:     Adam Ford <aford173@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>
References: <20210629072941.7980-1-peng.fan@oss.nxp.com>
 <CAHCN7xJgqRfg1sHNbcpdEFaLHUwhYxe7_r5SEMDqSaCPFXX7UQ@mail.gmail.com>
 <DB6PR0402MB2760B05081D54D775B8949CA88019@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <CAHCN7xL6Rr41fHaaPwi6OA5Du8x09EHcE-bWyiGpz0pVn74jeQ@mail.gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <c6a00f74-6c34-4208-0b17-7fa15835eb3a@kontron.de>
Date:   Wed, 30 Jun 2021 16:46:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAHCN7xL6Rr41fHaaPwi6OA5Du8x09EHcE-bWyiGpz0pVn74jeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.244.188.134]
X-ClientProxiedBy: PR0P264CA0234.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::30) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.32] (89.244.188.134) by PR0P264CA0234.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 14:46:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da8708fd-ec96-4903-6cd5-08d93bd5cc9a
X-MS-TrafficTypeDiagnostic: AM9PR10MB4839:
X-Microsoft-Antispam-PRVS: <AM9PR10MB4839A46A74FBFC196B3FF397E9019@AM9PR10MB4839.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cozSMEyhXevyvubGcbOvILAC5M8zlCpKbP8wPDRsNTbcIlJof2JVKvgn7a1Q6OzUPIUiG1TYoqQdlw1qpQesPDS87bsN7774bOPTJ2HHiCI4yzOoe1bZikWRn3KVTUdLvT9tk+X2HGj+CzN4JV2lQCTAJCnzB154S8TcR8oCJ7jRFGN3ORC388rDvk0gOOC8jNYomFVGhZgZ6aFHzl4JBi57iDfRtpErLAKkChyYKT8uvOkaZQELGhIib9dbuhqpTekgTIe3sYNCSLRzs4hiUGDYgG7ch1Nw9FdZ4mIF/JxmYTXsPhp6j2O5r13AtvDM5/51DqIVOBEYi/MYQB0zzl7mJvnUVukZq9721TsDyJpxX43KxyGKFizKnAa1lEQLRVTeedcWCXL+x+51BQdfvyqgU5g0kX2LBd2jdnEwkEnf7+2kHKNy2PUggiPfIa6oEoj+1zeQ+LCzSBPqxhWd3nJU9ZXTVnl5ZPU6eqmkvJT9ZXb9ov/VmZqm1Mbn+afi2h2ARSsQWg5rh2shvCN/jNDDrdCvSoLDg/9+2l3v2rffFCOTvVIBjmNGhGlu+UuAlWNOZsG+R2OtfnS4xFfgrLwUqg6owD+D1Xx6PcZrSa5BiICS9S88TqKq/hvPmX0JsDXqXTodWAhg2AZqigH4L+YgwSHw/DxFJqCSN0aKv2wFUWklN9BgsCDhVQMP0zf3ZZh1ALDcu8Wk8AsxrXQQJ55U3k1S3lV8OKTo1w46pZ6RCIaeggsMN/Ibmebhbkdz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39850400004)(8936002)(316002)(86362001)(26005)(31686004)(186003)(54906003)(83380400001)(38100700002)(16576012)(4326008)(110136005)(6486002)(53546011)(478600001)(44832011)(36756003)(66556008)(956004)(66946007)(7416002)(66476007)(5660300002)(8676002)(31696002)(16526019)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N29wdVRmb24wWEsyWFRQczVNelpmbVNyVWR0L3hmY1hML1pLME1XTDh0Y0Ix?=
 =?utf-8?B?UnVMTUFsUzVQM3loYzVXalhoakRqM0ZSWTA2WWNkcjBUeittNXlTR2VTMHMx?=
 =?utf-8?B?UCtlYzZjbzNFYjQvZXpyNmRrWTAvMGhXQjkwajd4UW5EdE1udUJ0WkkyWE0z?=
 =?utf-8?B?UjZIaFdRajFKSUVINlNyQS8vTmZXMEZ6Tm90bzNOZ2NFNzdSTm10ZEVyYVU4?=
 =?utf-8?B?ek1aQS93dkdKT1RHSWZqZFA0UVYxa1JoaHUwY0VIWnp3eEhlRnEwK3YvdDh3?=
 =?utf-8?B?ak5DV0QxSTVkajNxYW1zVkIwRVRZaU1kZ2FPWUg2VFVrVDFNWjRtRExFUEpV?=
 =?utf-8?B?UEYybTFsWVdZQm80VjZiaEZxc0hiU3Vxa2J5WkNpQXB2M3M2Qzcyd1BQZjFP?=
 =?utf-8?B?bFpEZW9yWkRHa1RWalZEUExlaWhaM1I1TFIrWDZTNWt6eE54Mmw0ZVJVc3cw?=
 =?utf-8?B?UlovZVRna3pOaXgwMWlWRUh1VkNvWlNTcE1NWjQ5a2RtV2ZEdGFnOFFkNnVX?=
 =?utf-8?B?ZWNTMjVWSWNTb1VCUThMd00xdzhhMnd4TU9XalJSN3RpYzNVWS8zcGFtNkxm?=
 =?utf-8?B?UlRZN1lzOGtwQXlqZ21wYS9OZm9tSllVWDd4VnR1bzBRRGRFcUVDVFYzMUZT?=
 =?utf-8?B?b1RqTnE5c2ZsRXQ1U0d3Q3ZNOURHLzRUWndzemtoU28vSElWUGdTMlVvRWVh?=
 =?utf-8?B?cXVmeElBblBPSEZJOWZLRDd1SXNOZE9YNzU2bmwyM01NNmVEa3RaM2NpOE1M?=
 =?utf-8?B?ODlSQ3E5TFpEVk9jaWdaTnFFMVZmMmYxbzFHWW9ZQXZuSzU4VkpiUWVoend6?=
 =?utf-8?B?YUxieDMrQUtqbGVJYU1ITmNWOHRCd0xrQW4ramcxcVA5aEFOTjB5ODQxUjZB?=
 =?utf-8?B?R0xPS3JkdGJTdko5aDFUNE1EanNpSTFaYk9admFvb2NwNm84WmFyQUUrOGEy?=
 =?utf-8?B?dVQ2QnBaUFZpRDhxUnIwcXNqUjlFckZabys4NXBHVVZZei9NRW9MdXZBVTNr?=
 =?utf-8?B?QzdQRitxeGlMZmE0bk5TaDVCUXE4VU5nU3RnTnBRZU53Z1V5MGlxdzVVMnUr?=
 =?utf-8?B?OEZyNzdCWnlRM1o4RmFUb0tHUlBYb2hrTHVUanc1dmtMVXptZmJsczJ0dWJw?=
 =?utf-8?B?NldjQklJaVUzOVF3MHdwczhwdnhPWG5rYU5LWWZ2dzBsT1FiTENkMkt3ZUZD?=
 =?utf-8?B?ek5lQ0xyL05qSWtXSmxDZ1pnSGFQUkZFMEQrclJFc2JqQ2ZhWC9MRlBGZzJT?=
 =?utf-8?B?VUJjZUxPdWZuRis1OUJTcHRkVW9ML3R1c1hHbnUzZ3Zyb2pBYTV0b1ZpMEZQ?=
 =?utf-8?B?dFcwckY2ZDdXOWU1bk9QeVNvT05QV0Z6WVpEa1FmS1B4NDBzZU5Hd3p2Wm1P?=
 =?utf-8?B?dkZFYXhqakF3ZTJOelNxRkRFdi95Ym1nVDJYakhUN0pWaWhNcUphVHBiMCtG?=
 =?utf-8?B?dkUrRzRrd012cElPRDZiY2VRaEtqMld4dnE3ejl6RnpoamxOL1Bwb00rQU1C?=
 =?utf-8?B?SlVSbG14cXVFVXdhZG9relZEMDI2RzduMzNSbmUxa1BIc1I4aW9zdmxQby9L?=
 =?utf-8?B?WFUrdGdiS1p5WUN2bENSTFhoU2tYdFlZRGdZeU9rUmpaMndzbERWR0FISC9L?=
 =?utf-8?B?N2VlSlg2MmpEalZIdXNrMUJBNnBzL2xHbG5mc2NEQ3plVjhnbWlWU3NEZkxY?=
 =?utf-8?B?WWJWNW10KzBLUXZhaWlNV2VEcUJVK1FJMlBLeEFBR2M1YmkvZlV6WGZLcEl0?=
 =?utf-8?Q?VFXgNUHK2jO7weXqzSPR+r//p805XDPfDq0jJqN?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: da8708fd-ec96-4903-6cd5-08d93bd5cc9a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 14:46:09.7970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQyfGwK5vT9SCjF7K3jmel4anacY5vTvNnJbiCQ64mkbolVGkZtxKI5wso7Q0WsyqmF+8U4I1xFPAag9A31BvsiYWdae+J1buYoztPXwy3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4839
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.06.21 14:09, Adam Ford wrote:
> On Wed, Jun 30, 2021 at 4:34 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>
>>> Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
>>>
>>> On Tue, Jun 29, 2021 at 1:56 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
>>> wrote:
>>>>
>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>
>>>> V8:
>>>> Revert one change in v7, force goto disable_clk for handshake when
>>>> power on in patch 3 One minor update to use if{} else {}, not if{};
>>>> if{}; in patch 3 Typo Hankshake->Handshake
>>>>
>>> I am using ATF, branch lf_v2.4, from the NXP code aurora repo with U-Boot
>>> v2021.07-rc5
>>>
>>> I applied this patch against linux-next, I applied the pgc patches [1], and the
>>> suggested power-domains to the otg1 and otg2 nodes.
>>> I am able to boot the device and use USB, but with this applied, I cannot wake
>>> from sleep.  If I revert this, the system wakes from sleep again.
>>
>> I just tried linux-next without this patch on iMX8MM EVK, suspend/resume
>> not work. Per my last test, it works before. Not sure what changed in kernel.
>>
>> Which kernel are you using, any commit or git repo? I could try on imx8mm
>> evk and debug the issue you see.
> 
> I used kernel-next,
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> commit 889bab4c367a0ef58208fd80fafa74bb6e2dca26 (tag: next-20210621)
> 
> I then applied the GPCv2 patch that Marek sent.  You were CC'd on the
> e-mail from Marek, but I can forward the patch to you if you can't
> find it.
> I tested his patch and I was able to suspend-to-RAM and resume.
> Once I was comfortable that it worked, I then applied your patch
> series for the blk-ctl.
> With the blk-ctl series applied, the suspend-resume stopped working.

Same here. I tested with linux-next-20210629 and as soon as I add the BLK-CTL driver and devicetree nodes, the resume after suspend causes a lockup each time.
