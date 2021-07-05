Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477803BBB70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhGEKrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:47:52 -0400
Received: from mail-db8eur05on2106.outbound.protection.outlook.com ([40.107.20.106]:26337
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230168AbhGEKrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:47:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCPTjA4pGaaijdUe/ct0nJvXDWH6ueQwebUdReUIWu6RCarPdsq8ohbgcv7Nwk30ePmUYdmly5mJFGT+UbM7cJ8N3ONU1AJK9I8pTY02o7DsQnIeQL+1/tugnC6exH/9lMSxmjWa93zpd/gLk3MqO5FQovgZ0qDqjozD2GiqDffnd1sY5bdl8UnSkNafU9LKWaqBQ7ghaHT83sDhyvbQG79V4Qn5/0aMtuEY9iz9yTRuX0b9efnQyVTkK55hXph1UqpZpLm21wFRN05l/OrpHLZVQuJARabi5AZK1y3JLHUA8J6aT0lHbQnOLVAenetY5n0Q1h/mJ8hDbxDPOyWFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAT8/X+cRgkUIReqcnp01adQVY1YOC3nk6omANJAo2A=;
 b=nMz4AIk3VNrcgCeHqJA+ei/Bk86g/EMt16WBckWDPclap/9B/kt1VK8uyox75Fsi+1a189iNdcej8MVs41PUy+CvyRibUMM1QctYw7+AvU0dBj7Epd3fvDOkfMZ9krTgSQifyv3XpiozrljYBijRrNp53FECPH5Ml8xXCpyCsucUapw8oAUReXhZ1DmJrL/HwU9nknL4TNSP1VwT5YKSIzPPzs5cgXbwtTTJ3XKGIPTYtLCMOAP8M2S68RgByR31DgY53t1/N1FYSt32y4hAsectfGLbPGGnJom0F9Dp/Pwz3NF2RzSQi7cX688BdsKgTq1F2lVHeW3S0pohPODarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAT8/X+cRgkUIReqcnp01adQVY1YOC3nk6omANJAo2A=;
 b=jA7ogbWUJuBNTW0mDtZcapGAxNoW5DctTRMndSuxz1MPSZJETmBrxCMi1lHEYlspJCakYSN5rh8juTK80JkfEgX5SG+xW16ovqSzYkAWVwxPEbH+Jk1mrPD+gPrbUycUWhFBzpHkRXzlUHIw3wkkP23tN9QtrIvpkEv1v/dkp2Q=
Authentication-Results: amarulasolutions.com; dkim=none (message not signed)
 header.d=none;amarulasolutions.com; dmarc=none action=none
 header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3601.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 10:45:12 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 10:45:12 +0000
Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
To:     Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@denx.de>,
        Adam Ford <aford173@gmail.com>,
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
 <c6a00f74-6c34-4208-0b17-7fa15835eb3a@kontron.de>
 <181ac373-7701-361e-6364-6fc74b2d71fe@denx.de>
 <fc7fd710-a834-8273-62e7-6a151de03036@kontron.de>
 <a760483d-4607-1e48-6695-df64b3c4bbf2@kontron.de>
 <DB6PR0402MB2760EEED61EC337A2C51629C881F9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <aa64627d-4ced-5970-bb0b-5e91c8ac7268@kontron.de>
Date:   Mon, 5 Jul 2021 12:45:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <DB6PR0402MB2760EEED61EC337A2C51629C881F9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [77.246.119.226]
X-ClientProxiedBy: AM4PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:205::33)
 To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.103.171] (77.246.119.226) by AM4PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:205::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Mon, 5 Jul 2021 10:45:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4bf1e5a-6964-4916-cccd-08d93fa1f767
X-MS-TrafficTypeDiagnostic: AM0PR10MB3601:
X-Microsoft-Antispam-PRVS: <AM0PR10MB3601FEBDABDDCD8A948699A6E91C9@AM0PR10MB3601.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yffN5BiwKVGv8+dqjGyoWp9Esx4v1mkWCN7FvjEtisyK7JHuM8sD2ViN++o1m+zCTbDOpYp/Ha+zha/iFWEyGAtM2XkjUZj+zGa/FbtAp7DYvGcBsKWGaX+Qn7vPFlaeKgVjhkF/k/OuvUnfvV+kgqcFewJsiBU1E/Y16FAmVDuPLV8exoSc8DugthINpfY3LBaYuGY/6q12N7Dmy0VHzyhz9UMkBy67FqVhrKIpdIXNIigQ5wcBvRmPzcBNOO2uEN8QfvyoOmV8Dn2ucThxfgfOHDEOYeq80Lj8BWJCjsFP+3Ex8BLrZ4cu56vIogCwsl0KELQNRcG+o9O7lDzOTQ4HZCaAKG+yJNeXtplE9v4TukbIX2UtE1xI0p3pWoB6/o1nbU8xSzXFgj2xQG2z3IB8IcWPC5xoXonug9Ibih6QtUe4w4zZ1t/2AWa1etcp4SjnoCHWIFrpvkqzIDkyLKlNvN4BNG+U0JTRkF+aIF2MbCELEBTAEFxcAJN1uqMkGbE6rgtec/V6bHS5ibbbnkeMDvtOnyHSmDr1uWoIxnyHj0hMvrvidMlbspIXg4RgrWI0oLoNQitIdIVPGSTmxm7ulrj3anKRYyV1ZEvT66K2oRcwGcRmvhCCN+3sDYiKn1NY23MDl5VvubvT1YCw0lJgoeKoxXH3vbG5y3hxpzxDaGTOhEpeJEtrN/GLg7TOgMEIVRg8bYcBAIQRq9igzYWCjUPxvpsriz7OxqKb93x08/Kc7gShipQewzYYD2ncJnGmNrEEed9aIVarj5xjEp93yy2qyRUYMbocRtCPazuWTsQdkLIT2rIZOwv6wZ/F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(396003)(366004)(136003)(376002)(16576012)(83380400001)(45080400002)(6486002)(16526019)(110136005)(8676002)(4326008)(478600001)(36756003)(316002)(186003)(38100700002)(8936002)(44832011)(26005)(7416002)(86362001)(2906002)(31696002)(66946007)(956004)(5660300002)(31686004)(53546011)(66556008)(54906003)(66476007)(2616005)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkdqZjZsYlpGdDlDekhqdnNJVTJRQS95QVZSbXRQUmVjbEFpenBNRFV6b3pU?=
 =?utf-8?B?ZVVKa1BieXNCTG1ma0xKS0dwY21iRUlKNmsxUEFNYXNzT2xNWTgrTG93TVBR?=
 =?utf-8?B?Yk9oTGV0NHpyenlRWkVxUW9TOEFLVjhWcWxSa1laMWNxa1NEM3RkUHU1a2Fh?=
 =?utf-8?B?Y3Y0MnY3NG9kVlJGZ0F5YnFYZXdiU1FxRytrQVFIbUw1eG1uNzhCQjNncVNG?=
 =?utf-8?B?b2dDTDZZNUR2OWtINHFrWWllQVZyK1FvdVRmNHBkeDhaRnUyYkNRTG1Fdk1h?=
 =?utf-8?B?YnZBTGtZbVcwbDQvbjh5MG8raHZmaHpqQzBkTUNiV1ZtNG15UVNucVFFeEpt?=
 =?utf-8?B?Q0JmTWprKzFYNjJnSlNJanlhbXpmNHpsSlBPMGF4NHR5NUhja3VmQVh4OE9a?=
 =?utf-8?B?d1R2SGxQTnM0UTE2ZWtXeTF0NEJvbW9GNy96SklhSDVGT3l1SEFXT1cvcjBS?=
 =?utf-8?B?dmJ0YVo4dUVES1V4b291REFtMEVsRG1HQnZLVEVaTVNzVWh2SFVyMC93WnEz?=
 =?utf-8?B?Z1hmRklZQ0Fpck44R29IanowNlZ6N01ZMFhDMklmN1JQdzJPUFNoU0lJU3U3?=
 =?utf-8?B?OVBSU3l3SVJqaEdCSFkwWHZxOG9jUU80NDk1M0Z5WnQ1akYyQmxkWjR4c0g1?=
 =?utf-8?B?a0FLbWRUMUxtaXdoN2JuaE1kM2ZpdDEzVWpCWDJndFFHekdCM2FiV0JoS1JU?=
 =?utf-8?B?NFliZExlcWhiYXFDdkREaGpCMXJob254cmlCMGdJWUJycDFob0NLdmFCcUtx?=
 =?utf-8?B?NXozZXZPd3VNNHpNNGs0amJ2aEZuYyt3QXFUb1Q2TU15bTN5WktNdFFqSHho?=
 =?utf-8?B?RGpMZHdZaC9pK0lnYk1tZmYxV1NyOUlNNzFmT3BCV2ViUUs3Y2d0QU1TWVJ6?=
 =?utf-8?B?WWFBYS9xcDF2a2NMOUZ4MDhyRXJUb1plMzRQL01oZjYrQTZrL0d5L3ViVUhJ?=
 =?utf-8?B?ajBzVHdpa3ROc2xaVHQzZ1VZeWdaWm5hYU8xZ0k5ZXY0ek4xYnVkQ0lkelNC?=
 =?utf-8?B?VUFDbTlhTUJtaG9uRnU0VkZiTlViWVFHMEc5dVAzS2Z3OXVxeTJJb0RtNDlj?=
 =?utf-8?B?dS9SMDU2L0hkdVFvSTBVc1h5bENMRUdqU0JmNE5mUkYrVFBZU0FHZit5enQ2?=
 =?utf-8?B?bE4wUjRMVG1NS2hzVDdVRkNvYStFRDYwTUFDWWVUQ2VJdHdJNkJMbFh0ZW1r?=
 =?utf-8?B?ZG1zUUdQZWM1Z1FYVUtUb1ZuejBiWlUvNy9raTB1ZjMyeTZTYjBkZ0hmRi84?=
 =?utf-8?B?WWhLMlFKcUx6ZldVUitXVG8wVUtsWW1HUStmQVpycjZudkhUMjRZSEMvMjNJ?=
 =?utf-8?B?K1F0QkJPUmR5Z1B3dWJHZmlOZnRrQlN0ZUFBVW85TmluWFp5WlJJbVArOUUr?=
 =?utf-8?B?OHU3OU1wTFhiSTcyYXFkc0l5alBEMVBLSTl2UXVSMEd0aHphOU9CQ1VXK2cz?=
 =?utf-8?B?M3BLRHlManpjZEd5cVI0amFSckptY3FoSjZBL1Q4dVllY1NyaUVOYjZNMTYx?=
 =?utf-8?B?SWw0YW5tUm9tV0lCWVMwQXJUZzBrODRLaGRuUU9TTE9KaldobVBuWEMybzBl?=
 =?utf-8?B?Ykx6MEUxVllBdjM0d0c4OURXZHVxY1BJSCtDY0p6SlpiM21yU1YyVktVMjJa?=
 =?utf-8?B?MHhORDlibmVuRmIvckNHSFpjY2FLd1hJWVpuUVpLYis5Z0NyQ0xMSDlZWGFY?=
 =?utf-8?B?YVAxWjcxV3JuT0RLUmV6d0ZtaElCMkswMU1ORkFsZUJvSjFzcHJ5TE5zUEx3?=
 =?utf-8?Q?aE9Y6kMBamULHW5xA0l3PXeodRS2M7sjTYq/5jd?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bf1e5a-6964-4916-cccd-08d93fa1f767
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 10:45:12.3834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBIsonCW8QRfELrT9rz3CFRWYUamnV03wB8Hp5kq9PWZQoA8gwEM7RLl2k0L39BZaEkERI42tMKm0Y7+WaJ/AOxxxIaKlecHFm2QN7li9Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3601
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.21 05:24, Peng Fan wrote:
> All,
> 
>> Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
>>
>> On 30.06.21 19:20, Frieder Schrempf wrote:
>>> On 30.06.21 18:28, Marek Vasut wrote:
>>>> On 6/30/21 4:46 PM, Frieder Schrempf wrote:
>>>>> On 30.06.21 14:09, Adam Ford wrote:
>>>>>> On Wed, Jun 30, 2021 at 4:34 AM Peng Fan (OSS)
>> <peng.fan@oss.nxp.com> wrote:
>>>>>>>
>>>>>>>> Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
>>>>>>>>
>>>>>>>> On Tue, Jun 29, 2021 at 1:56 AM Peng Fan (OSS)
>>>>>>>> <peng.fan@oss.nxp.com>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>>>>
>>>>>>>>> V8:
>>>>>>>>> Revert one change in v7, force goto disable_clk for handshake
>>>>>>>>> when power on in patch 3 One minor update to use if{} else {},
>>>>>>>>> not if{}; if{}; in patch 3 Typo Hankshake->Handshake
>>>>>>>>>
>>>>>>>> I am using ATF, branch lf_v2.4, from the NXP code aurora repo
>>>>>>>> with U-Boot
>>>>>>>> v2021.07-rc5
>>>>>>>>
>>>>>>>> I applied this patch against linux-next, I applied the pgc
>>>>>>>> patches [1], and the suggested power-domains to the otg1 and otg2
>> nodes.
>>>>>>>> I am able to boot the device and use USB, but with this applied,
>>>>>>>> I cannot wake from sleep.  If I revert this, the system wakes from
>> sleep again.
>>>>>>>
>>>>>>> I just tried linux-next without this patch on iMX8MM EVK,
>>>>>>> suspend/resume not work. Per my last test, it works before. Not sure
>> what changed in kernel.
>>>>>>>
>>>>>>> Which kernel are you using, any commit or git repo? I could try on
>>>>>>> imx8mm evk and debug the issue you see.
>>>>>>
>>>>>> I used kernel-next,
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>>>>> commit 889bab4c367a0ef58208fd80fafa74bb6e2dca26 (tag:
>>>>>> next-20210621)
>>>>>>
>>>>>> I then applied the GPCv2 patch that Marek sent.  You were CC'd on
>>>>>> the e-mail from Marek, but I can forward the patch to you if you
>>>>>> can't find it.
>>>>>> I tested his patch and I was able to suspend-to-RAM and resume.
>>>>>> Once I was comfortable that it worked, I then applied your patch
>>>>>> series for the blk-ctl.
>>>>>> With the blk-ctl series applied, the suspend-resume stopped working.
>>>>>
>>>>> Same here. I tested with linux-next-20210629 and as soon as I add the
>> BLK-CTL driver and devicetree nodes, the resume after suspend causes a
>> lockup each time.
>>>>
>>>> btw do you have etnaviv enabled ?
>>>
>>> yes, but I can try without and see if it's related.
>>
>> It looks like the issue is not GPU-related. It appears once I add the
>> pgc_dispmix, pgc_mipi and dispmix_blk_ctl nodes to the dt (even without any
>> users, so lcdif and dsim are disabled). Once I remove the three nodes the
>> issue is gone.
> 
> 
> I have an updated code here:
> https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FMrVan%2Flinux%2Ftree%2Flinux-next-master-628-blk-ctl-test&amp;data=04%7C01%7Cfrieder.schrempf%40kontron.de%7C1ff517847da04f73218f08d93d08effc%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C637607930865259413%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=p5xGgid7lnfEpGK5TbljHrn0B1b0oF%2FO39G81UyXhyY%3D&amp;reserved=0
> 
> Only have blk-ctl,gpc,pd update. Please help test with applying your
> local patches with some peripherals enabled.
> 
> I tested the upper code with suspend/resume with uart wakeup,
> it not hang anymore.

Sorry, but in my case I can't boot this version at all. It always locks up at boot.
