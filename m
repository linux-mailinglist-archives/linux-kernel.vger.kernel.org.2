Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DF741101C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhITHcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:32:53 -0400
Received: from mail-db8eur05on2123.outbound.protection.outlook.com ([40.107.20.123]:34049
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234126AbhITHcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:32:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXKciV98ZnEO/oJXrDc2TyS9nSjINXG16BCKxgHabiQE7y448lmyUj0GaJaSbZ4xPFPV1cS8txU1lxvasqwyBMdf5buWnKF1bSqwBO2JQTXExrWFTUrmXADz+16ej5uwQlQVfSBwYxtHJVJKCDLjkPjMGNY7nQFhaSNINGvyMW9HzJR1emt1R4FtvZzEn8V4ZWswnfXXOGXksEFd1wcs0soSbR/TkLjHPBjboBDR8NQEQJdVAwtAMKG1vpZ9F8wS9em1piYQIB4xdtLnOPo6akzGOquL+7qAlYtqtBPaCqCSiH018mfwZyJvBKNJdUfjgUZ4eyTgqkta0IU/ohOLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PePAk5sQENvzq68vKnZKvvuL2y94mD/Z0DnPUvLnaV8=;
 b=OZGBAaurzIZ+U46KZhI1ZWviTGEpBPQJHJpb5dP+7pzdX92w62Wbenkw3ST7b1hc9V/mQe9HqNdTM74DxAbfASpldmhA2YeJsMYP0Z04IojomteYD2Qd6Mp/yR4Q7OBoJB9oelS9uq+Kg9z52ext8j+Wud271DTQByByaKaSpeCIcQugriq42EqM122vIdsypdn+d2X5KWQpycozYss4dx9Y17my4ZUoAt21E66ysQW8Vq9lfdEXx/GpVzEmxOrw3yRWP9nGUmnqHn+L4oNghQPvBmGio942qJQJxF/8osE27LOtJdPt8gwzRE/c7lle6lisYjZ8Vn2wgfn/O37Xtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PePAk5sQENvzq68vKnZKvvuL2y94mD/Z0DnPUvLnaV8=;
 b=OPntb2VlhP7sv0RkClar6oDKRxt8DAhQFXT3nTPf6eEW2MMcpOUK/9+DAFLEaL6maGsa/PG8BXkkMgwKPf4d8vh7JwMe3ZLyJsCTtqmG6KDSPwU852VykyU+3ruyRQZiTWXly/2JqiTdRwQHC+qN8rwrAfXSzvnfYdG5aYpgVTA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3585.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:154::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 07:31:23 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e51f:c969:4825:8fc5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e51f:c969:4825:8fc5%7]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 07:31:23 +0000
Message-ID: <d618c505-43e6-01a7-4d2a-847dad33b43e@kontron.de>
Date:   Mon, 20 Sep 2021 09:31:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] arm64: dts: imx8mm-kontron-n801x-som: do not allow to
 switch off buck2
Content-Language: en-US
To:     Heiko Thiery <heiko.thiery@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     devicetree@vger.kernel.org,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20210915120325.20248-1-heiko.thiery@gmail.com>
 <7e7ee4244ababc0a46e0875222c7e37d@walle.cc>
 <898fd5e0-2073-3689-89b6-2c5071773786@kontron.de>
 <CAEyMn7ZbJr0_2Phc2rW7sDYQu4AABWPZ1F7xDgaS5U7ha7iqzA@mail.gmail.com>
 <9bcf7b749dca57d42aa2e7afd88b5a26f3eeff2a.camel@pengutronix.de>
 <CAEyMn7aa=-UKvUz4pWOWZJbPh7TTgzmDpmNKOTYM5g0G54xU2Q@mail.gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAEyMn7aa=-UKvUz4pWOWZJbPh7TTgzmDpmNKOTYM5g0G54xU2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P192CA0014.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::19) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.31.128] (80.147.118.32) by PR3P192CA0014.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 07:31:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb59f24c-bb30-43bf-2f71-08d97c08a5a3
X-MS-TrafficTypeDiagnostic: AM0PR10MB3585:
X-Microsoft-Antispam-PRVS: <AM0PR10MB358513DC647E2F40A9A5C188E9A09@AM0PR10MB3585.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVZx6a14wNgQabylhhhQNmKhz99dkxe1Qv0aymhyAui4Fv/6bULz0KGbJXXzzAZi6ypGLwcMf+TMWPj8IjEqb7lBlTwyhXzqx4LGT9Hm8XX/pI1BSK2Eyro1wmxvO3WxFjjwjET6j2HhagzOtJ1x1uwXCR1Gpp4Jx7jo76MXIZNMyE09MDM1b5J+ckEF6PJLUiVRJD+MIMDLqGyLMSxp/Fwd0+Zg/Z8/JblQjprv+b1otKsamjvDYqvybaAWIx4oQHjrsD7YfB2PDwnoOKJ0kmIpHhKPCvWU92d8hAZg/sz4hZaT8MAnPt2i+ImoXZOApe8TeGWs+jQ65CwOfBe223YDpz6anlTQ1SoMMBvvFWZxYp/WQalg6I68Dj6u67sTySAT5836/UxH5O792JMnfMe6Gc7yTjwQgLZw31sND4vivjzmBiMCpHRLRzXaoSccqjcnwB+XEEhqsUxX4R/dbM2ynI8TJkSmP19h1mCXB+yUarmh6oHktlClLaXt/sQJ1woTsg4O+yWZqfN4fkAv3ILkc/0EWUU/Pz+P8bKO9upm6WkhZDw7JRFfW+H7ZNaB7I3pxs3wTlHupO+fKQWhqtV2ryJDKVyCbUIr5HJQ1S2uOIVTPueK97erntRgVMRimNL9nmpgh8fw444Vvf9OtEs7LoXWpJwh/BqasJhd0fDJDdG6OXWM5dUuS6md1ztlCDR9aUaU1xOHyBN9CHj2wsUP0GCm/07LRzvsXaQF09STcP6EVJr0rtGJMcggSMV2ltOEqsfp6nUA5gxXd2Dev1HMcHctsLenEILtaaWX+5RtMC3az+sSSgblDMPCbwOLeDhTfnmvr2TB8xG+sTsFbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(26005)(4326008)(6486002)(66946007)(36756003)(83380400001)(7416002)(31696002)(956004)(53546011)(16576012)(8936002)(38100700002)(508600001)(66476007)(110136005)(86362001)(45080400002)(966005)(316002)(8676002)(44832011)(2906002)(5660300002)(2616005)(54906003)(31686004)(186003)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3BPTVNKWTVCbHhmbEtBZ29Ba2M1RXlRVUtJSGhTbUh0QWJsTVV1UkFuWlc0?=
 =?utf-8?B?R3dMNDBFcERUTXNYd0pkMUVFN1VYMXR0YzRTbDMzM21zSW94UjJTdlY2Q2Vs?=
 =?utf-8?B?cUE4eW1HZ01SaG5qODdUQ25VeHZXV3ZST1MwYS84enhIbG9BNzZyUGF5RmRK?=
 =?utf-8?B?L3JkWC9XenpmQTZNR05pdER4UDZ2SE5pR1F4Uyt5YXdtZVBtWTdURkpHZTVL?=
 =?utf-8?B?aHlsenl0eElPTGxtMmFhNFZvS0ZyYlRzT2YxUUJTQVBFc3JCQ2VwTVBvcUxz?=
 =?utf-8?B?QjdFZ2J6NTJqQ2pzTFMyRGJjUWlqUkdHL3ZtT0dPTFZGZFFuZkE3VzJwWmxF?=
 =?utf-8?B?dDZlWUx4VStGQVNkYkNSWFRqVy96ZHRGZTNtZExENTkvNlhEOU9yNkYvczJh?=
 =?utf-8?B?bUp0czgzZDhYbTVQM0J4TENPSXVXNnNwWVhPTHIxWUorNnZwcG0rYlVLMC9v?=
 =?utf-8?B?U1NNMjR2clZBb2dlZXZybUtXdkY5aFovTGRzVzRKZE10bDgxVTY5Tm8yd00v?=
 =?utf-8?B?a0pXYll6NEtubmYwa2tRb1BiR0tJNGxCZFZ3RW8xZWVjdExnd1ByanN6VjVM?=
 =?utf-8?B?YXV1cjI2bHRhZGJMTEp2MUgyVHRZbTY1cDRHWUlEL1VwWmxIeXMyVTBCWTI1?=
 =?utf-8?B?NkFtVUpUeFcyRDN3L29xblhLMW9ZWEo4bVBMb29XbC9wOG1nWkQ4MHE4SFV0?=
 =?utf-8?B?aTZ2dGhWSzIzelJjTTdIM0FIOFFOSVJMZWc1b3Y2SlhtcWUwdHI1emRaSGF5?=
 =?utf-8?B?VmtUVkk2M2Y0bVRjNlVYdjdjMjNuUy82NUMzR2Y2RnI5a2M2VVdrL3c5NE44?=
 =?utf-8?B?dGpPdE9qaUhxYjhQODZ1aGhvdUpOaTNFZjFUSkptVnlwL2srSjhrNlZwQ2Va?=
 =?utf-8?B?N3JmV1J5MXFHN3BzM3FScU1FbnNMb3Qrcys1U1Q2RnQ4aHdRU1lGWGJ2cmNS?=
 =?utf-8?B?U3hNTlBRVFhSY2V4NUpGOFBTMlQyd3Yzb21qWUpOa3ZyRGhzb21hZGQzOGYv?=
 =?utf-8?B?c2tIVDg2VUU3cUN5VkJzWEwzeEMyTm1jVlBGTFd0U2dKam5LRmNhVC9EbWpj?=
 =?utf-8?B?MWFVSHJCWENSYlhhQ2NKUm9jUFZvOFB1ZlBLSG9RUHl3eCtqbnZmOEo1b3VG?=
 =?utf-8?B?dURSV01LZW5nSURMRzJSU2dMeTlFdE9aM3RIRG14dHZFM3NYTlhHRlpmeU9S?=
 =?utf-8?B?RHZHay9JZW1CbFkvVzlkNm9Dc05HdVVVZ1pkSFJuUUZhNUZwLzluV2k3aHlR?=
 =?utf-8?B?ZWo2Ujl3cEdkWWE1UmtHSzdUcWs3NjVBdk8vbkNLSmV2dkRiSk5hNE0ySkJn?=
 =?utf-8?B?bktvanNyRnFYdkNicUhkWEltcWgwUmxsN3I5aENNV25uMTdVakswYW5qOGZK?=
 =?utf-8?B?VmxsZTNESVowb3Y0d2wyb3liK2RmamJ4ZnFKSXBUWmpYT1FJaDB3MGdVem5M?=
 =?utf-8?B?THRweU5CMUxLZ1JQekczTEU4WFEzVzZGMlBXbFFROWJzMlhmaXAxTTNlaTE1?=
 =?utf-8?B?ejRUZnNpM0JWR3dMU3RyMTVyejZOTkhVd3V4c2VwcGtqQitjOVNvYmpjZCtm?=
 =?utf-8?B?cmc1NkVSNTcvdVVxQVlLL0xTMlU5UVM3UmZqdzhJQVFvQWJuVngvRjQ0aWZu?=
 =?utf-8?B?aExRT28yYTd5WGp2RUNBQ0N4V2NRTVRIOEFwYm4yTmVqTFkxa0plSWNEbWlo?=
 =?utf-8?B?ZFNaT0crT3VnWmIxMHFsVVpEcHRFQTR1TzhJdk9GSjBONEwwaHR3bzE3VzZx?=
 =?utf-8?Q?zDKxzfvuvln/WdGIaXv4XUqUKm8StteMzui7+vH?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cb59f24c-bb30-43bf-2f71-08d97c08a5a3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 07:31:23.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWuk4tLKlYjua6dhiCugDAwR+zla9ZiumekEvvB4IVGXnZQJN/xTwRvw+ljQzvRcNYXMlOqjlQHfkJg6rtlM0yIqnH34H5kS+1RNNZb2Chk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3585
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.09.21 18:10, Heiko Thiery wrote:
> Hi Lucas,
> 
> Am Fr., 17. Sept. 2021 um 13:44 Uhr schrieb Lucas Stach
> <l.stach@pengutronix.de>:
>>
>> Am Freitag, dem 17.09.2021 um 09:28 +0200 schrieb Heiko Thiery:
>>> Hi Frieder,
>>>
>>> Am Mi., 15. Sept. 2021 um 14:09 Uhr schrieb Frieder Schrempf
>>> <frieder.schrempf@kontron.de>:
>>>>
>>>> On 15.09.21 14:05, Michael Walle wrote:
>>>>> Am 2021-09-15 14:03, schrieb Heiko Thiery:
>>>>>> The buck2 output of the PMIC is the VDD core voltage of the cpu.
>>>>>> Switching off this will poweroff the CPU. Add the 'regulator-always-on'
>>>>>> property to avoid this.
>>>>>
>>>>> Mh, have this ever worked? Is there a commit which introduced a regression?
>>>>
>>>> Yes, this did work before, even without 'regulator-always-on'. I
>>>> currently don't understand why this is needed. The regulator is
>>>> referenced in the CPU nodes as 'cpu-supply'. This should be enough to
>>>> not disable it as long as the CPU is up.
>>>
>>> I rechecked that with 5.11, 5.10 and 5.9 and I see on all of them the
>>> same issue:
>>>
>>> [ 31.716031] vdd-5v: disabling
>>> [ 31.719032] rst-usb-eth2: disabling
>>> [ 31.722553] buck2: disabling
>>>
>>> While on that I tried to compare with other boards and see that they
>>> also have the cpu-voltage marked as "regulator-always-on". The only
>>> exception in dts/freescale is in imx8mq-librem5-devkit.dts [1] that
>>> has not set this property.
>>>
>>> I agree with you and don't understand why this is happening. Has
>>> anyone else an explanation?
>>>
>>> [1] https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Farch%2Farm64%2Fboot%2Fdts%2Ffreescale%2Fimx8mq-librem5-devkit.dts%23L319&amp;data=04%7C01%7Cfrieder.schrempf%40kontron.de%7Cce9d266ad78a4d06721008d979f5aeed%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C637674918380815550%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=PsTKX4MXGwvvP6WxmQ1OWc8e32YI6Nsu%2FEkcNR4V8is%3D&amp;reserved=0
>>>
>> Maybe your kernel config is missing the cpufreq driver, so you don't
>> have a consumer of the regulator?
>>
>> Marking the regulator as always-on seems like the right thing to do,
>> you don't want to depend on a consumer showing up to make sure that
>> your CPU voltage isn't cut...
> 
> shouldn't it be that the node cpu-supply here is a consumer of the
> referenced voltage?

Yes, but as Michael and Lucas noted, the consumer is only active if the
cpufreq driver is loaded and we don't want to depend on this. In my
config I always had this compiled into the kernel so I didn't notice
that the always-on property is missing.

I'm not sure if shutting down the regulator is allowed to save power in
suspend, but that's something we could tackle later, for now:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Thanks Heiko for investigating and Michael and Lucas for helping!
