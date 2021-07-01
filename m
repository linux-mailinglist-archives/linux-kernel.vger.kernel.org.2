Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D28A3B8E32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 09:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhGAHfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 03:35:12 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com ([40.107.7.99]:30080
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229906AbhGAHfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 03:35:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx4uVF1l78J2vTPRK0VUrFYwoSBFzdNWmaqnv6si4QMkh4vKZEolNN068vRtOk37VvB4+Lpgysz8N5y1JXdZvFULfNh4r8APB1EkCv+63xwyYKLXkZeLd8D94GZInwgJg02oaeSUfeV4dWnGJZCaSQCbG3mQrF/8a1Ioko7n3xbW9SLfBh0EFGfzM/prEFU8EpG4t+uewFbBeTCTNwySVSo1m2KdoTHmIgbAOi1VyGeYwTyg8MYmsgq2RAY9jnNa6VxaMKlgHO34p2mEaL74cqYPyLb41GLkb9LI/Q/oEaoYgfHH7gyyYZQtSXX3GE4SnrPqArvpObGUc0qnAMCUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avXAqk8mqH6OfKGAjmpQfZcbnTCR9pekHNkyPWkhnK8=;
 b=eFW1HYhGKQquRTlTznfGtRf1kuMEC95+PvyIA/ERCh5PuQI5bIlMU0L1aWsQW0beS4uSpbp3R4wpAcqXUFxiN4ctjftpBnRbPhgm13GFwMO/7jnW0wacD/CAxt84Y2NLabP2BZXu43YzZUSxtM3njz9OhEDHCeYiAX+IWdlRXM5yicYP6AXc5GTbUHozAkOoV8OLrDNawreC+QJWtX/5fL3etS65SSIfMpMx64Y4h6OmAbVhpFgF3NtV6jkeNA4kX0IXeM+VAxpLblU3CZbRQn2J2U3YYewl7M78bMMobVklM1w4e4ZGmkYP/k3erVoinV32N64MYd+NgV69inai0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avXAqk8mqH6OfKGAjmpQfZcbnTCR9pekHNkyPWkhnK8=;
 b=oEOxG7kxB9JKJdhODMbWwstwaWxTwmuLvJ2+B7VNU+yBAC+KwBnW/X0zZFgT4VWjdNa4scLxG5TN+0FRiVOgJVK71CRgdxgu7JyqSkf1LmUr+Gy2nY8DRJ+GPxz202HagK0E0cLOmTTMKYtj+n0+QRQPK2N6AX6fZ0QIvRPurro=
Authentication-Results: amarulasolutions.com; dkim=none (message not signed)
 header.d=none;amarulasolutions.com; dmarc=none action=none
 header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Thu, 1 Jul
 2021 07:32:38 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1133:8761:6cc9:9703%5]) with mapi id 15.20.4287.023; Thu, 1 Jul 2021
 07:32:38 +0000
Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
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
Message-ID: <a760483d-4607-1e48-6695-df64b3c4bbf2@kontron.de>
Date:   Thu, 1 Jul 2021 09:32:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <fc7fd710-a834-8273-62e7-6a151de03036@kontron.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [46.142.166.227]
X-ClientProxiedBy: PR0P264CA0066.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::30) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.32] (46.142.166.227) by PR0P264CA0066.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Thu, 1 Jul 2021 07:32:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0116d57c-51c1-46cf-decd-08d93c6266af
X-MS-TrafficTypeDiagnostic: AM0PR10MB3012:
X-Microsoft-Antispam-PRVS: <AM0PR10MB3012895684275AB3DD6F46B1E9009@AM0PR10MB3012.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyKB/1ie6p9nDQC6yzn6o65WYkAJCe3MwNGLFF7XlVbl0XYgP6H1Gm0dLAEre/+e1Jv+ffXQbV8WIkfBiuOPSKry7IWB9ewpFtlJB8SPsDd9oBixIwSxPS1VRVb5AgnIXgQP8RYf+SXxJqsgW8Dt6s7vUbsm6v7VyLAGXUpMVkTkb8YNZSaoyJQlGGBKh/yciVxhp7AyvFIzwFE/nLhUsd9UhgIBNcB5LHScCyz9aGl4zxmIbDHyqh+re9JxpExjyIJyuAaaKxePcwbE91gLoAMtJDdSN+VyAgPYtRHTVBvci148b2s2Ik67lnCdMPLSWdbZ6x3fP7WvMpav4u3Ska/YkIv9LqsjU/6lsqxIqS2hJWgMFZss8Ny8AN1S9WDMPYkANmsHINd3AfrbXBFpvVCcPHCvL7wjv2Yi4DV5W4RI5g36piNHdTo4PcH2JTmxnqEgd4A1GVwS5EuKzs5aDdMmOSvtJ8uKcjSGoerWWDjQeaA2sPvElMUTHbgTfiQYxHqRpLTMUEA66kQKq086Cs26AlEOY0tw3HmVbTWp/hUo1v6zt6jFa0Gxd9zyalvWFl3Z2K2TrcX39igpmaS3uC4DvTL03FctpeqxQ2IwuQYgR6FgPo+L4jMPUe0R2tclWUsSdpCyynSh3oHDCKkW8vgJ6FJ1abx2lWB5rhXYJ8Qr2SH4/lubnvlN8tcqiFX3ZcuC+qtvzcCBhvM5CXr8RQtfEk7TRW8rKSe1Y6SAVlA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(136003)(396003)(366004)(26005)(8676002)(66556008)(66476007)(2906002)(66946007)(478600001)(44832011)(38100700002)(83380400001)(7416002)(16576012)(4326008)(36756003)(316002)(186003)(31686004)(16526019)(54906003)(8936002)(110136005)(86362001)(956004)(2616005)(5660300002)(53546011)(6486002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjNWMXBFamhPbXRqWVRGelBZZ0Z5c2NBTDh0UDNiUWpJcU9mOEJISURxQk5u?=
 =?utf-8?B?NDBDMXdTRE0rNzQ0SGdqbGxYbmlMTktTSkozTm9WSjFnNkxtSzdlbTIyK1dD?=
 =?utf-8?B?azhKZmI1RHhzWTJ6UnU3Tlg2N2xobnc1d0lwTlpGVFBlNE1qSmhSZGY0OHlD?=
 =?utf-8?B?ZjdHNlAwdTM5ZG9OZUVpTHJ2Z2FaOWRJZXBwRHNBVUVnS3JVZHh1bWtoRHpR?=
 =?utf-8?B?Q0s4YXZDLzU5OWxSSlBoZXlXMTdzMW10TE5nMnFqQVlXaFZzZkh0R3krcmJv?=
 =?utf-8?B?elpZY2NZVlRZcmk2clNxeS91S3NVTHVhSzNVZkJaNTBYejA5NExVN0ZPTTlv?=
 =?utf-8?B?UWtvOW94STM3S0U2M2kzOTJVQUhnYUp3TGU0aW92NFFKN2xuQ2o1QjR6Qkkr?=
 =?utf-8?B?TXQ1V0Rqcmc3eS83TzhEUmg0emdPZXhFYTh6UytuZVBNblFrK3EvbmZta2Zt?=
 =?utf-8?B?ZVFQcmZrQUdvN2YvWnJlRlZ6RXRzdDNSUENzcDVXRkNXK3FnWE1qZzdmNzJB?=
 =?utf-8?B?QUVLYWlqWndHaFhGcWUrcENJQ3pCU2N1TU9wUkYySklJTXprMmQvMnhuSjVs?=
 =?utf-8?B?SFFFVGowRHNjODI4emZpd25aKzBOaWtiYXFUMkp0azBtQWxlbWJ6V2FuSnRv?=
 =?utf-8?B?cEZRaXVNK0xEdFJCSEZnUWQ1bE11MkRlejlJVzIwR3hwa2VFaXdBWFFBeFAx?=
 =?utf-8?B?ak9lbnIwZ2tTZy9USHB3TzIvTXFuaVBpTG0zT0RhbDBHNnZkQVdRS092bUlp?=
 =?utf-8?B?OG9BUXJMcU5ZTGp4bW1adkptaGwxNVNxSDdBaEZlakxFZlNyL21KNHVqaDNx?=
 =?utf-8?B?cFc2NHdod2ZTVTgxanhnSElqSlJzN0RvQ1VBb1BiTWlXU3dSREZhK2EwV2Z4?=
 =?utf-8?B?RGJBSmpuVnFBTXNUeDgvdGtFNlVzUm0zSUlrUWpheHhKdUJ6WGVCbHlEYnlp?=
 =?utf-8?B?VWVkVEJsWXZDTGR1NlR3SXMrSlYxQmZGMEcvM0UxMm9NTlFYdXMzMG92NkR3?=
 =?utf-8?B?R3FPODlvK3RySjVrKzZvSVlERlA5OFArUG5qbjNiYzdWUHlaeXlmL3VtS3JT?=
 =?utf-8?B?VUdqZTVwM05WamVaVmpvRWRzTlFKSmNvQlRkWnc0V2RqUzg1UnF5dktOOWti?=
 =?utf-8?B?WGorQ2JPaU5mSkxnSmRGWVlrNVVoTXcrMHB5dW1LR0dVMGxGSHR1MFRCdzMz?=
 =?utf-8?B?VnRXSGZoWnFmNkFmM3ZoYTRuSEpzWE1CeFBGaXY1VnBJck9NZTBTZzFoTFF5?=
 =?utf-8?B?YVhPV2FRODhYNDNTNVhCZURHQURoSXAvRXdXSWVzUDRZNDFac1NZZFhKLzFr?=
 =?utf-8?B?TEppOXZMQmp5elJuellDZ09NZzFaeWU3d1d4S0NRZGxxanZvZEEwRldLbHpD?=
 =?utf-8?B?bmpJdlhrYk9YN2s0Sk1UZTB1VW04VUpmQVh3T1FNb0R1eVJXNDBCRFF2cG1R?=
 =?utf-8?B?Myt3QUV6cWNyUDRYcjVUMnNOMmk0bnRPekNTek05dXJBd3VlZTBKeGl2R1l6?=
 =?utf-8?B?Tk1yeS9ubXQxSlZUbXJWVFdESzZPRkNMUDVBQ0hna2JVUU5OeWNEbUUrMVJm?=
 =?utf-8?B?N2xqcWZ1NzZYWjRHVVpodjltV1hxaUloeFo0K2JsTEJzSFFvWGtYQjVmODNv?=
 =?utf-8?B?ako0dnhYV3NGZXVMdHJzWWpaa3dmeC82eUdyUm1CdEYrNDgxUlg5SXl5L1hp?=
 =?utf-8?B?Y3RobU5KNXNNWkJ6Szk3MWhMZVpHZGlsanBOdEdTNmttNzFHWEwyclZ2NTlj?=
 =?utf-8?Q?nrz2uOxC6fRZYZEq7rEvFD5Een4XI9L/7n8i32U?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0116d57c-51c1-46cf-decd-08d93c6266af
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 07:32:37.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxUI/U9DfGJljldzL6v01ioYR/2T/DCB/Y4trzw7mS4YZzESiwj7CGl/MhoJfVrvFAu9o9YyebNCvdxf/LFnhHS5Ix+hNtkrYpRZ7k9v4cY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3012
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.06.21 19:20, Frieder Schrempf wrote:
> On 30.06.21 18:28, Marek Vasut wrote:
>> On 6/30/21 4:46 PM, Frieder Schrempf wrote:
>>> On 30.06.21 14:09, Adam Ford wrote:
>>>> On Wed, Jun 30, 2021 at 4:34 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>>>>
>>>>>> Subject: Re: [PATCH V8 0/4] soc: imx: add i.MX BLK-CTL support
>>>>>>
>>>>>> On Tue, Jun 29, 2021 at 1:56 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>>
>>>>>>> V8:
>>>>>>> Revert one change in v7, force goto disable_clk for handshake when
>>>>>>> power on in patch 3 One minor update to use if{} else {}, not if{};
>>>>>>> if{}; in patch 3 Typo Hankshake->Handshake
>>>>>>>
>>>>>> I am using ATF, branch lf_v2.4, from the NXP code aurora repo with U-Boot
>>>>>> v2021.07-rc5
>>>>>>
>>>>>> I applied this patch against linux-next, I applied the pgc patches [1], and the
>>>>>> suggested power-domains to the otg1 and otg2 nodes.
>>>>>> I am able to boot the device and use USB, but with this applied, I cannot wake
>>>>>> from sleep.  If I revert this, the system wakes from sleep again.
>>>>>
>>>>> I just tried linux-next without this patch on iMX8MM EVK, suspend/resume
>>>>> not work. Per my last test, it works before. Not sure what changed in kernel.
>>>>>
>>>>> Which kernel are you using, any commit or git repo? I could try on imx8mm
>>>>> evk and debug the issue you see.
>>>>
>>>> I used kernel-next,
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>>> commit 889bab4c367a0ef58208fd80fafa74bb6e2dca26 (tag: next-20210621)
>>>>
>>>> I then applied the GPCv2 patch that Marek sent.  You were CC'd on the
>>>> e-mail from Marek, but I can forward the patch to you if you can't
>>>> find it.
>>>> I tested his patch and I was able to suspend-to-RAM and resume.
>>>> Once I was comfortable that it worked, I then applied your patch
>>>> series for the blk-ctl.
>>>> With the blk-ctl series applied, the suspend-resume stopped working.
>>>
>>> Same here. I tested with linux-next-20210629 and as soon as I add the BLK-CTL driver and devicetree nodes, the resume after suspend causes a lockup each time.
>>
>> btw do you have etnaviv enabled ?
> 
> yes, but I can try without and see if it's related.

It looks like the issue is not GPU-related. It appears once I add the pgc_dispmix, pgc_mipi and dispmix_blk_ctl nodes to the dt (even without any users, so lcdif and dsim are disabled). Once I remove the three nodes the issue is gone.
