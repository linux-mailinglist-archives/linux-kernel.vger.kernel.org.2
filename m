Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0E38FD64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhEYJHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:07:04 -0400
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:50603
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231448AbhEYJHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:07:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO2z6z5tWIV2hTQzwwefQ7v1LOgB7e63lMEdqx53MGEFtbEWDNw0dm8wHBh7jWYET7bpaZYpX5Flbpv9FOdKUywOPewluKGK5d/4eD4m7lJmcYkV34pjkX4fGkZIpB4FGzfDwyed7VMJwxy13WqoML55g6cXcoc0s93OiyE0QZ+qTyvf/nMcsEHEonsnLmjo/Hm+KNyPyHMZJ8n+MahzwBH/VTWqWsCbC0O55KQcrnlI6hdR9sLTT3XVZzEHNwuD6msHHdZggRrjQzliwg1By091ycOeV+Zr9BokEOV8yAByTPXDS1hOL3E/zwJ87XyFjEiUbrqr4e0RvYYG6Zdzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJBcYO43ZW0FzlRZH+uUuniL45DhmLwUsiMJH6UrFFg=;
 b=coW5YOxHKFFt5L6WbJBeUsKQgDL0dEIoeVdkn7ELEQiej+neFO5OpTSwiYS7aRSHMT6XiyO1WZ3zGoTs4CS2SJTwHC3AlN+nBElpEkwWkzDoAfqcr9XWyLqXY1CHvOo6+KFLO0O3UnhrNJ112pHRP5H/vW51rgqwHByUh+Cj+BRBcRFN6QsAXM7SHj705buoJ1Q3gs9cZ5hbY+SIki8DNKAMhvUbwDZdYgrHAi1QoHEB2cD2rFdHSMxBIVaKt1OaMryxpFmtbg738o8kD2BQ/4Q/p7V0FxhQwNgZ4JAQJMBWl4L901+qvFp/MCuX7s3G+yhL7+Rc3aqpxtJKHVC9Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJBcYO43ZW0FzlRZH+uUuniL45DhmLwUsiMJH6UrFFg=;
 b=Oe/R0yPDwo2+E0XMtRl1FpIPGgN/Z15mDPfX07TzQfhdV1Oh6MrfK5WAvs+twRzD/k4kz2xQ8qdp2AaXjZ0oIUWpRnxUNySjx6UHSoMc+Ic0kBIJCRqvRgIjsNLzp2X388H7l0ZOmKOrW8cqGGYEAglPHEpcxbguaoIwgZscFXg=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR04MB3015.eurprd04.prod.outlook.com (2603:10a6:6:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 09:05:28 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 09:05:28 +0000
Subject: Re: [PATCH V6 0/4] soc: imx: add i.MX BLK-CTL support
To:     Adam Ford <aford173@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20210522134249.15322-1-peng.fan@oss.nxp.com>
 <CAHCN7xKU=o8J5==VbjVY8E6iRXEXP7jvGP-TWKp+9BZfZaA4Dw@mail.gmail.com>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Message-ID: <7f6bf036-1956-5d68-987e-d89de570056a@oss.nxp.com>
Date:   Tue, 25 May 2021 17:05:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <CAHCN7xKU=o8J5==VbjVY8E6iRXEXP7jvGP-TWKp+9BZfZaA4Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.193.102.178] (119.31.174.71) by SG2PR01CA0140.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend Transport; Tue, 25 May 2021 09:05:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1db2a7e0-1461-490c-f1e5-08d91f5c3d81
X-MS-TrafficTypeDiagnostic: DB6PR04MB3015:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB301575765C89915F28964545C9259@DB6PR04MB3015.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWkulxVJKaonr5lAiItLMXSYjt0mjNLx08dk0BnXTW4/rbAA+fUclFmapUftCi9CAXdJwQd4DUY66QjOC/G2xeAWD1tpEN8KtFBgxfeFi8gIIGovdOqnMxZ4rjoFRlNt/TMrCIWU0U8ru/k1e1i/NHnMpd8VqWBgrkXIzMfvFj1fddROSMn8Sd+6Dq+rnpLej4tEj9m0FD976VLUU103TK6f7rJBXZjUMBLZmlPGDA6L2KFeuoAyDE986Zdik9GDoOXSZsYlErVumcIJQpuo6xjyDcXoKfkDwKmFQvO47wmuAMjV0r2ohBZOEcdgP1enXOk2eC4elBvbbrS8WsGan3Xfk2v1IcYwSFpojD7MkM0ks6PYrHdvZrDiX5FO+7vlUfhzL7qDSvTVWvsYAd2nSncrGVukkPFYMxbaeNuBkdGVLjTlfv6uROlV3Fl2HSaPcCLLU12Khd/Hi3JMncH8BzUhTTCBizhnft8oY75cSMsEkYRiX3ckfMyYCEjS4HAQ5D/mGziUN7amdTf8WVUAxVwWJTpob3a9ziFyQnYgGG3rdLXt/Qkb7HUwwjSfbO//HTJY1ERf07k3wD7qrnHnWLmIfN2kX0KVnIJw+jWaP4nQnB8DQxfZSb5G85Cq2FxY8W6FoEAQTDeXt1PDYUKo0viYcBAnBtUTzgEAodeE2kZuCtbn6JMEgXRn4mY2OOv7KhtswHTGoHGubsDbt5a7exGwIaslgdAi3HprKSpHrnIgGK0ac+UNXn8j2bUPDODfjOvvQKpWBLOCqpCknD+KBtWprXjrGWsMMftV4eLdRGJErUPY4SsVewkxUUAh+o1y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(6916009)(53546011)(316002)(6666004)(4326008)(26005)(8936002)(966005)(66556008)(86362001)(83380400001)(6486002)(5660300002)(66946007)(16576012)(8676002)(52116002)(956004)(478600001)(31686004)(54906003)(2906002)(2616005)(66476007)(7416002)(38100700002)(38350700002)(16526019)(31696002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aFp5SDhlTXFuQW93c3d6OVM3dkdrN2FudlJSQUsvM2dhdXNoWnVxMG1ZTktx?=
 =?utf-8?B?aDJxMEFxalJ6cFUrVXNpTmZ6SU9wZjhkQ0gxb2oyRDZmTHZDR1dKZEZwdTEz?=
 =?utf-8?B?UWF2OG1XL0h4N3pXSysrR3h1OUlTaGk1MmdaeUJKcXlRWkl1ekM0RVhZakxT?=
 =?utf-8?B?WGJXRHJ1ejFzdE00c3dTbC9JMGc5NVlvY2Y3elRHVjJiTnJuYUp4WFJzTE81?=
 =?utf-8?B?Y0lkMHY1RWh0SkJFQUM3RkFpNnFOQ2d0bWN6WnVTM3hvSzB5M2JMZHZQZGk3?=
 =?utf-8?B?eTRSR2VLeW1TNmR0TmpDK1AyS0RlbGZIYk9GNjJXUEtmVzljelFHTjJWaDdQ?=
 =?utf-8?B?dk0yMU0wRDhkeWJNdHNVcU9mSFVybmpSdDNoS0pVWTZVUy9xZzRveVRORnUy?=
 =?utf-8?B?VFRqblljMHZETC93RE1MZWFHT0VBSFZHcFd4ZkV3dlNQdXUwUGN4eHVRbndw?=
 =?utf-8?B?MGFLRU5BMHNsQ2tnT3h3bTNVOFBHQjVXamlCbVRPdGEzZTB3Rk90Q1BTTEpX?=
 =?utf-8?B?bnVxYXQ4VUFHTGhBaTRqNFlKV0VsSEFvSHdWV0ZIMTRZbCtBWndUVWR3TENH?=
 =?utf-8?B?MmhXa2xMMGVWZExrMGdyK2gzYUppblpZUW1uQmVrbFVoU3ZRd1RnYlVpdG5H?=
 =?utf-8?B?eEZwRzlEM2NONUhORFlrVlZmTms2bE5ZQmErSzZSK2dWVE1sajF4TkNPbmtN?=
 =?utf-8?B?d05nMHI5MUIxSE1vQmtlR3QxNzYyTkN5WWFjNHhXb0drYzZ4SWlobmJ6YzZn?=
 =?utf-8?B?cEhQQXpwbTlzTlg5WHRLcmt6UmdvT2tHS2F2eTBhWS9oZXByeXo3STlwUzJp?=
 =?utf-8?B?ZmhBRncvTWZtQWJza1hpK01zWktwazFHQmQ5M3NBVW1mYVQrcG16S2FhdGJw?=
 =?utf-8?B?YkJKNHJTbVA0NUZMNEJwZXFsbDN3eUljMXZBakpHV0tKdk9LSkFaRU5QUlZa?=
 =?utf-8?B?MnJGZVFzY1pDUHNlSFVnWW8yOWFYcEZkVXdQNnIwcjdrTEhnQ1VudVozUnBG?=
 =?utf-8?B?dTdPQXJQQTNhTjRoUWhVdzlnakk5N05WWjhvUW9WQVhSMHZYOGZsTUpnSWho?=
 =?utf-8?B?VEpQT3FnNDBhZCsvQitNb3JzVXlubVpQR0JybXY5OHVuZ1h0NjJvZllGL1hs?=
 =?utf-8?B?K0w5UUlpTjc5cncwWWdXM092WjE1allqd0RwQlVzZWU1NzF2S2pZY2RLdnlW?=
 =?utf-8?B?eGFONi9nZjdTSlZHMjFPUFgvMEFYbFRnYzkvcThKYTIxRzBuRjlFb3RCd1Vr?=
 =?utf-8?B?c1FEdnRMWGtFd1RqYmtzWTk3WVcxZFY0cms0RldVUnV0U0xqQUZPWW8wVGVE?=
 =?utf-8?B?OUZEZzZJTVFtZmFVR2FuVlF6RExXQkpuR3ZVQ2IyR1JORTlHbTF3MWNuWjZX?=
 =?utf-8?B?N3I4M0dTTklpTzUwM0loSDZhako1VzdPR0JvT25yQ21jdm5RTnM1NFdYU1Vk?=
 =?utf-8?B?eTU1bis1TjhNVVFNeEFaTHUwTVRlbU9jcmduMWxlWlRhQWdFT1dzQXVObyty?=
 =?utf-8?B?VnZ6UGp2RFFpbEFXZWthd2NpdU1CK1JhZjBDQnA2STIwTC8yVFlDUzJoSmZI?=
 =?utf-8?B?TExVNW1Fc1hmZWxzRlM1QWFJMEUzMFJZVXNzKzBxL25adk9zR3YwN3hiQUwx?=
 =?utf-8?B?RjR4bU9STkV3SDh4YUVydmo5WjFNQXhPS2NXdVdTV3lyZU11K2F3aHpkRHhx?=
 =?utf-8?B?Qmx2QkduWm9JNC82ZlpwZGo1R0NyaXZBRll6SExvRDMwd1hxYW1Ca2lwMkRO?=
 =?utf-8?Q?W0ArHSp32NBRterk/VnCHxpO4zq6psBzwtFnH/H?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db2a7e0-1461-490c-f1e5-08d91f5c3d81
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 09:05:28.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7shJO4+U1gkqngCHjboK9EjUkW3OVfKVq5T0stsuEiENRdz7HPj0UqtwS+QlOZX0UI0Ryr1zBUBE7EwvaMt6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3015
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/25 3:29, Adam Ford wrote:
> On Sat, May 22, 2021 at 8:10 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> V6:
>>   Thanks for Adam's report on V5.
>>   Resolve the error message dump, it is the child device reuse
>>   the parent device node and matches the parent driver.
>>   Filled the remove function for child device.
>>   A diff dts file for upstream:
>>   https://gist.github.com/MrVan/d73888d8273c43ea4a3b28fa668ca1d0
> 
> Since Shawn has merged the pgc portion [1], can you post the device
> tree to the mailing list, so he can pull that in too? Without the DT,
> the PGC's won't do anything.
> If you want me to do it, can I do it, but you've done all the work.

Some PGC node will take blk-ctl as parent power domain, such
as VPU-G2/G1/H1 and PGC MIPI, so need to wait blk-ctl patchset merged.

The blk-ctl patchset, I think it should be the final one.

I 'll post the dts patch soon.

Thanks,
Peng.

> 
> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/log/?h=for-next
> 
> thanks
> 
> adam
> 
>>
>> V5:
>>   Rework the blk-ctl driver to let sub-PGC use blk-ctl as parent power
>>   domain to fix the potential handshake issue.
>>   I still keep R-b/A-b tag for Patch 1,2,4, since very minor changes
>>   I only drop R-b tag for Patch 3, since it has big change.
>>   An example, the pgc_mipi not take pgc_dispmix as parent:
>>
>>          pgc_dispmix: power-domain@10 {
>>                  #power-domain-cells = <0>;
>>                  reg = <IMX8MM_POWER_DOMAIN_DISPMIX>;
>>                  clocks = <&clk IMX8MM_CLK_DISP_ROOT>,
>>                           <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
>>                           <&clk IMX8MM_CLK_DISP_APB_ROOT>;
>>          };
>>
>>          pgc_mipi: power-domain@11 {
>>                  #power-domain-cells = <0>;
>>                  reg = <IMX8MM_POWER_DOMAIN_MIPI>;
>>                  power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_BUS>;
>>          };
>>
>>          dispmix_blk_ctl: clock-controller@32e28000 {
>>                  compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
>>                  reg = <0x32e28000 0x100>;
>>                  #power-domain-cells = <1>;
>>                  power-domains = <&pgc_dispmix>, <&pgc_mipi>;
>>                  power-domain-names = "dispmix", "mipi";
>>                  clocks = <&clk IMX8MM_CLK_DISP_ROOT>, <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
>>                           <&clk IMX8MM_CLK_DISP_APB_ROOT>;
>>          };
>>
>> V4:
>>   Add R-b tag
>>   Typo fix
>>   Update the power domain macro names Per Abel and Frieder
>>
>> V3:
>>   Add explaination for not listing items in patch 2 commit log Per Rob.
>>   Addressed comments from Lucas and Frieder on patch [3,4].
>>   A few comments from Jacky was ignored, because following gpcv2
>>   coding style.
>>
>> V2:
>>   Fix yaml check failure.
>>
>> Previously there is an effort from Abel that take BLK-CTL as clock
>> provider, but it turns out that there is A/B lock issue and we are
>> not able resolve that.
>>
>> Per discuss with Lucas and Jacky, we made an agreement that take BLK-CTL
>> as a power domain provider and use GPC's domain as parent, the consumer
>> node take BLK-CTL as power domain input.
>>
>> This patchset has been tested on i.MX8MM EVK board, but one hack
>> is not included in the patchset is that the DISPMIX BLK-CTL
>> MIPI_M/S_RESET not implemented. Per Lucas, we will finally have a MIPI
>> DPHY driver, so fine to leave it.
>>
>> Thanks for Lucas's suggestion, Frieder Schrempf for collecting
>> all the patches, Abel's previous BLK-CTL work, Jacky Bai on help
>> debug issues.
>>
>>
>> Peng Fan (4):
>>    dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
>>    Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
>>    soc: imx: Add generic blk-ctl driver
>>    soc: imx: Add blk-ctl driver for i.MX8MM
>>
>>   .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     |  66 ++++
>>   drivers/soc/imx/Makefile                      |   2 +-
>>   drivers/soc/imx/blk-ctl-imx8mm.c              | 139 ++++++++
>>   drivers/soc/imx/blk-ctl.c                     | 334 ++++++++++++++++++
>>   drivers/soc/imx/blk-ctl.h                     |  85 +++++
>>   include/dt-bindings/power/imx8mm-power.h      |  13 +
>>   6 files changed, 638 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
>>   create mode 100644 drivers/soc/imx/blk-ctl-imx8mm.c
>>   create mode 100644 drivers/soc/imx/blk-ctl.c
>>   create mode 100644 drivers/soc/imx/blk-ctl.h
>>
>> --
>> 2.30.0
>>
