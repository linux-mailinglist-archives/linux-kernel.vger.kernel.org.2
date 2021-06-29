Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E003B6C99
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 04:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhF2CmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 22:42:01 -0400
Received: from mail-vi1eur05on2067.outbound.protection.outlook.com ([40.107.21.67]:25089
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231682AbhF2Cl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 22:41:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyZ4xXYXIXksNzoKt9hbUbEgeh2MkuaFft5LzVqiwSFItBZzMux+a4bRmI0BzeXfGbLWdO8eCjbLhP4yOnaG9mY5iystEKqbDjqe5BMh6l7aTWCqp4ZGTyVevkE6EYsJbNNntoWmQBiUoDPGQjdRRsLa0gPDtFtka1ONuzi1DyGW4rPH9U+/4s55Pd6xmMnI8tKyON5HErY1qgWETMoAwt+EqAvG2LjM/1JPVHuQZ8gdvOh9SAbavdSF2494WinQHcAdqKGq3xPMgPyr6Y/eRX9URKLmVrkLmUH/jJmpkmTes+73RCxHNGNHAmJu771M3JUItR40l8la1nofF1Snyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dR+DZY0I1PgKRr95p1HkR14vPc3ZSIT+5m5oGnlks4=;
 b=QN6YBPnsMKPyXGEBZul84xeim1mf4pLflRyEEm2XLM4wk48IycH1sbPuj4+tTuRrbLiAepqwRZWwqYjEW8eQDk1AG7gZZb5TeLCIpRdRn8XuX8s8hjuUHVwF9RhTdHF1arFmRXQx6dVfyy5gyUg3BWVCHLVhliH3U3qyQz9VlDeCkBY+h+w2ngOk/BmUX/1V2rXSKkuorfBWZDqhWM9oLhYjXi2buzpgQ96MnSBknG/t0uc4/5T0uxtImEn6ro/qf9SJ+7C556JYTzHTHUOiJoxLG83Ash4rPdeXcF+wqvbDbexn61pbNzAhp0XFVCbAMgxZuc+Ihdz9PyMtfWXnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dR+DZY0I1PgKRr95p1HkR14vPc3ZSIT+5m5oGnlks4=;
 b=ch4oCqhhqTfhXa4JhKIYUsQHDHRiSIZpSOcFr9q1v0NJB3XlA2TyFujtyrVayiNZcafCkGkytyXwAK8PIGeJMKRfewsIrQ206piXGLnglXerGL/NtzaC0GTfi0h3qfeoOJVoZDXr2ETftFLz/0gUAOTv/ucjYYnBlonr1Aiqo7c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5658.eurprd04.prod.outlook.com (2603:10a6:10:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Tue, 29 Jun
 2021 02:39:30 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 02:39:29 +0000
Subject: Re: [EXT] regression due to soc_device_match not handling defer (Was:
 [PATCH v4 4/4] soc: imx8m: change to use platform driver)
To:     Lucas Stach <l.stach@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
        Dominique MARTINET <dominique.martinet@atmark-techno.com>,
        "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201120101112.31819-4-alice.guo@nxp.com>
 <YGGZJjAxA1IO+/VU@atmark-techno.com>
 <AM6PR04MB60536EF0DEEE6EB64CF29390E27D9@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <YHeWnuDQo76rYoz5@atmark-techno.com>
 <DB6PR0402MB27607D28703D8C3E614E2F2A884D9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <b8ce9abd075a65272bdbe6142c9cd877fa25c701.camel@pengutronix.de>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Message-ID: <3f6cffc5-7600-25c9-d5f0-5891355c402e@oss.nxp.com>
Date:   Tue, 29 Jun 2021 10:39:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <b8ce9abd075a65272bdbe6142c9cd877fa25c701.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR0601CA0004.apcprd06.prod.outlook.com (2603:1096:3::14)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.193.102.59] (119.31.174.71) by SG2PR0601CA0004.apcprd06.prod.outlook.com (2603:1096:3::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 02:39:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd93e85e-88e4-4d98-641c-08d93aa71e9e
X-MS-TrafficTypeDiagnostic: DB8PR04MB5658:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB56589F7A289DF3F82CEB4DEFC9029@DB8PR04MB5658.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZhRy9Jd89CjGv4rBNxQHxWS+7xgIbbdDtuXw1vzR6BDjW4T+VAY1W9PVuxvihO9KM9Ge3e83JaQCmp0f5oOsCcluBXAgyymLz+HPgHbB0dynw888X4ismhBWq+qdCNTjIrUuRLKPmtE1i0bUwIVCFR3Rz1T8j5O4iqdJKIPGmPnM3QRuabpG/v/A2rbNApgrF8QyNoZu60mHDQV9E7EgtGPvPzXYGcMEY5fk5UxMiKKl9KbtLv2IwhKAREP575KwDasYxvYBK1TMsbAvxwD7NJqYlAZhaXMk7N+BRZVRY6G+Pfrh+QVeRy4QqPc2FJjS8JphbWd15MXdXPMFwNcze1P4rpAQiOszXCgEHwAkg8R5fUdMKtyhjUK8Y/928imZutxMp7OFsw5CGDB6qmU0q7Q9gtpr4/rO/kW7Ek2bCDj/wevUc0/RSWse7vEi9t+qoZ5/3kjqiErU4XtWiKHcbbyrF3U97fIx34MUlthaymFqnw3LUYhc8edq0YW7dL+C2jXUefR06uO/B/iStAAsTo+murGUxGI90/E8KFHFM9TgOMIu1Pjj8s4wJqVnq19gj52aiQgGZzsXI31EnHqIwcn3QuCmGxsOAU6Gn64l5FVBv74lz15QRVA0izPvskAd40z9RcpP+zgghjZ83qiR/Ts8vvt68+zQvR09fAOTHcpoSzvDD3e94LbyioA4D+poIAEmo3nzAJQZh94w/IcpaplJPKOlmv/Z4R1KsmCqMasIaRESOXdGpMkaaX68YBz/K5y/lyvLaE+9SuvSP0hbFwNG3LvVucWafS4w//GiyfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(478600001)(66476007)(31686004)(31696002)(66556008)(4326008)(5660300002)(6636002)(66946007)(86362001)(2616005)(316002)(16576012)(2906002)(38100700002)(38350700002)(110136005)(54906003)(8936002)(53546011)(8676002)(186003)(16526019)(52116002)(6486002)(6666004)(26005)(956004)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFI5d2M0MzNGamxOcXJaY2hhbjlDa3hqNHlITFgrZG1HazNTbUtIK1l5dHB6?=
 =?utf-8?B?TjR6c2xkUkx2MytwM1FVQmVuM0FkQlNVY0ZteUJ5NERQSWMzaUhHMVJHd0hN?=
 =?utf-8?B?TTFvTWRmbXdjWEY3ZmJxSjBkdFpCVE4yMG1JUjhmOVRzRzRIN01ZbGdleUJy?=
 =?utf-8?B?a0h5QzdPUGZIRDBIZzNwWVJEb2FQZGNXVkUvSC9BbVE4Ky9DZUR6NTVMM3BP?=
 =?utf-8?B?NFNOM1lRMjNmTmJ4K3N4cWJ2dXNoVThzdlFQcWRKUjRGWS9tT0tCanpETllZ?=
 =?utf-8?B?ZHN3dWNHWnh1V3JRRHZxTzBtYWRpSU8yVzl3aXRlRHg3U1hINXlRUEMxcmg3?=
 =?utf-8?B?d0lRQkVLamlCZGRJdzJxSWFVcVFHTlh2RTBsTUQ0ZDdUN2w0TngxQUNuaWZB?=
 =?utf-8?B?KzVYNWxwaXpMaHV6K2dxdEFrNm5pcWpyUGNsZGt2LzhwT2xPYkhOU3hSVUM5?=
 =?utf-8?B?Nktkc0NnNnlERkpWdkN3RU5LOVdnNkQvdU5nR3lNOVI4a29kY0Jpd0ZlcTha?=
 =?utf-8?B?L2J6cjdoQnk3Wk9CUW1uM3hySnlTU3dIOWUyYXkyNDFhdWttS0NNMXdNMWJq?=
 =?utf-8?B?ajYrR3NCbjVjeDB1cEpOZnV3cmJYNE4zb0wrczRpYjFYTjV6dWtmTGdrdERz?=
 =?utf-8?B?QjNCZlRwY1lQdGFsTkRzM3hjazFjeUtZVFNBQ2RzNjR6U0pGT2ZQdTVxRDBw?=
 =?utf-8?B?N0V5dHdoOUhrTWtzM1FYcEZWMlBTZFBZNXIzTnpVR3BzTUlqdTdqNWd1VlJw?=
 =?utf-8?B?NUtxVHA0ZkZZTzd1ZmEyZTlqalN5dmJaWTlLY09PUUpZVExYbWplOGh0dG5V?=
 =?utf-8?B?RlZwb0hVdzJLTm5xOCs5WGJJQ1pZbk9rNzVpU0d3a2JVK3JBVWNjSkp1Y1pR?=
 =?utf-8?B?VXBTZGdFOERmenNoWXgrajNSNUJHODJ5cU8rbFZQNGR0QkZTOUovUCt6ZFdM?=
 =?utf-8?B?d0VNQVZlbWd3SXNBMGFka25BOUlETFFRTVp3VDh3bXNpbC9yS1FTOHpNMy9a?=
 =?utf-8?B?ZmdONWdFTlNUQjE3UU44anVXZzhUOUpJakdkT2lSRnNldGxCeUJmdjZrakY3?=
 =?utf-8?B?clVpMjhsRjVISmx1c2V2WExvanJlSzNiQWxCREVOK2hiTk5CaWlJQkN2THRH?=
 =?utf-8?B?U3I2NXA3bXFVRDltN2ZOVVk4cSswWEZaVVBUYVU0bTlsejVKUm42R0E4THdO?=
 =?utf-8?B?UzByWHJuVUUyQXJsQWZUcmFTeWZoREZWaHJKUEplTWhneDVTeEFyME1CTEtu?=
 =?utf-8?B?d2J6QnhVMzdISFhKbi90dHNVTEQzcml3dk1qZGVYY1l6T1VRZkNKK0YrM3Fy?=
 =?utf-8?B?aE02UzZzbUFqSTlueDBMMDE3QUxid2RZcCtRMlJHL0dhMVZWMnRwaDFLcGdJ?=
 =?utf-8?B?WW9qekZYdkM4WS91dFVSWjZ6Y0RiNlg2bkNlWlptT1BZNXpIVkZVMGNuRjZH?=
 =?utf-8?B?MGs3YTlQTXBSQTZlWUIrTEFqTkVVbis2eFlGOVU1c0hCay9SbnI2ZFd5dUtQ?=
 =?utf-8?B?anhpdHorbGx1NmVLaHlib0dRcE53YWkxK3l1ZC92Zy9mbGpGYzNyNnYvVURk?=
 =?utf-8?B?MnNSSVU0VVI0RFdrYjZZTTdyTXNkV3lNa05HV0xIcEZGd0VobUUveFhralRH?=
 =?utf-8?B?RmR5b1lsTzRCaXl0WWZVc2pmSVRTRlN0allERUNNSkZzYUxzSE5VTXVRMnUw?=
 =?utf-8?B?U0diS0FQVk0xckloS2tad0QrWllUNGNGalUwaWZVbGhGU0FOTyt0clZGUG9W?=
 =?utf-8?Q?PV5iQTrpam+gbwdxB/v+yshD0LwEVCJvyIseazh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd93e85e-88e4-4d98-641c-08d93aa71e9e
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 02:39:29.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqZFT8l/menmGO1mm3qxegrwCtbamnCAl5oXgZht3wXNAQByRsIu3LC4DrWOBEpyqohFrqqQSg5axqEwhYRb0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5658
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On 2021/6/24 18:36, Lucas Stach wrote:
> Hi all,
> 
> Am Donnerstag, dem 15.04.2021 um 01:33 +0000 schrieb Peng Fan:
>>> (Was: [PATCH v4 4/4] soc: imx8m: change to use platform driver)
>>>
>>> Alice Guo (OSS) wrote on Tue, Mar 30, 2021 at 02:41:23AM +0000:
>>>> Thanks for reporting this issue, I'll check and add a fix to handle defer probe.
>>>
>>> I haven't seen any follow up on this, have you had a chance to take a look?
>>
>> We are trying to find a proper solution for this.
>>
>> The proper method might be make soc_device_match return probe defer,
>> and take early soc attr into consideration, but I am not sure this would win
>> maintainer's vote.
>>
>>> If this won't make it for 5.12 (in a couple of week probably?) would it make
>>> sense to revert 7d981405d0fd ("soc: imx8m: change to use platform
>>> driver") for now?
>>
>> Please no. We are targeting android GKI, make driver as modules.
>> And reverting to original method will also break kexec.
>>
>> I am on IRC #linux-imx, we could take more if you would like to.
> 
> It seems this stalled. This regression totally breaks the kernel boot
> on all i.MX8M devices including the CAAM. 5.13 is about to be released,
> as the second upstream kernel release after 5.12 without a fix for this
> issue. What's the plan here?
> 
> If there is no good solution small enough to be ported to the stable
> kernels in sight, I think the only sensible option here is to revert
> this change.

I not have time to touch this, maybe you could submit a revert for this.

Thanks,
Peng.

> 
> Regards,
> Lucas
> 
