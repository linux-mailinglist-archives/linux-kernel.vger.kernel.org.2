Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E7937506E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhEFH5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:57:02 -0400
Received: from mail-db8eur05on2108.outbound.protection.outlook.com ([40.107.20.108]:31201
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233541AbhEFH5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:57:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZYH8/z/jmSkLeeXm+un6LdxViza8E6vpzbg+6X01CFZKzSLyq0M63Y4eHzjI0REQ+ZWy/RV5+3ANqcq5Ih640m5u5B26NHoi5+07aJp3ZGvLv6FVJwJ2LWxrmah9MtI6KqYiqWA2D/r0Vtw7XoDZjy99cy7Dz3KDawtaULhBxOJ7wMf0sfmGyUgR/lZLTX15DdYGn1w5/Kb7/6+TLJpqtSblJas4OvEgJjRkgjfSSHxzVSIP1RSmTfxSQfMtQbRRoOVfdFreSPMfG+j5h8Ra4p9BWla8P+YAxJb7RDegF8OBlCBFRXClmWWeDOM7BBNDf4QTsVTxXWGneb+7gRfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0zlepqYuFTwvZvyrwE9NHxmih06TvMEqseP1KVP028=;
 b=NB+i1ptXmKhbZZRNWKWx43/19St4CDSvRxjodW71v2jVKGHv5U91dwkcHmYKQbzP6EIw1MEPCx5m5nPuplTXY8B2lUR673gmzdY25Leey021iICn72GXplW4HgrqB4L4AGf+Ta4TIQlIXPRhGBBtKyPWAroHdoU1cp/xOAc81t9RTp87bRYOlQC91/9NOfP5Fw+iu2Akoip+gXYDAvsFF1cUfnubhugl41o3tf/nsOof0AtaVTtAdpfRu5y4haQfP3KGkFw62paX05nPIn9TPoFfxapxvZ+DzNmnK9+hLhwbKz3WwW2NqD8AaZw0sYtbSNayFWMz2jYIXZOnGvjKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0zlepqYuFTwvZvyrwE9NHxmih06TvMEqseP1KVP028=;
 b=REwXTCwLlrJLBizzrZtUg0S0RsC/XPO0jcQbnIFGHZhPoGUaCT35CCgmgQGBij39j7gsgib3j4+eySTT7UgPc3yXNB20bEXE118IWud8O6xhrUYwRUj7i8uujuaEi4ldocCeEvrcFTyaJX5Nz7pvfmaJeyMxcKVSbc8bIFZ6SYM=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM9PR10MB4481.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 07:56:01 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 07:56:01 +0000
Subject: Re: [PATCH V2 3/4] soc: imx: Add generic blk-ctl driver
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "marex@denx.de" <marex@denx.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
 <20210430052746.10815-4-peng.fan@oss.nxp.com>
 <46b64f2f-4dfd-88d6-77ea-68bc844eee7e@kontron.de>
 <DB6PR0402MB2760169AE87307F2AF46D860885A9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <682fe745-1091-fcb8-eed6-82b501f3481c@kontron.de>
Date:   Thu, 6 May 2021 09:55:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <DB6PR0402MB2760169AE87307F2AF46D860885A9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.244.180.42]
X-ClientProxiedBy: PR0P264CA0053.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::17) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (89.244.180.42) by PR0P264CA0053.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 07:55:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ae831ad-01cf-41b9-291a-08d9106463f3
X-MS-TrafficTypeDiagnostic: AM9PR10MB4481:
X-Microsoft-Antispam-PRVS: <AM9PR10MB4481421FA7D1A044BA2342F6E9589@AM9PR10MB4481.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxnLrlI2YX9fVDwKs6pw9Xb1+SVYy04aq4tOFEcgEoqsdehVgHxYHgtZK3L6ZalDcWdcBDyIFkx6ybUJOS3lThjmhYKdcB0D1+PjKFr/YQU52yKZYKJg5NHhYk4usQRPYAkjutSxhmi+WgVLWBb7RTOoqD2d9p89hxjBhkBdOjxOSlGBk6IXEnrqNPZMV7nDZfkzKXmjHL3yyJfp/NbL2QcCoZM1XpCrMpWuhQRJpYrgiLzcbekWLcoeAshfQ4UXo1LNwLLRvdaQT1r6WBVaKC2Tjh55sr/2LXOp4wf1U6leRWbNP2CbJCPO84cPp6rclZM41BSEh8jzZyXUx4WP8C0Fc2IM8N40lw0NmduLtWBeVE2QPpYGriuUtz8pW5LWoexhs439CPPLmFQtUblU98YNuTNYLqsNwspByRA3cTFhLSjVeHVoux+MZMtuWaliG77t1GCpwg4G+ZjY6IAte2dzcodGvKuDAZCqwjTOYWhkh2Ym5/JFBkvBmdTMQzFIupPXV6CSTo3+3oCGEx7R9+BN7aSK1iRvuj2K7CIHpZgGL4XhXYCQfUVPaRz+V1kSUNtH+xtfPTL+xnBnSBm40BEAZcGLTPCnkjx+pETvuhT4vDkxWl11YGovgxzFp41cgf+782QqqVdgk2IaOJFYtOl908HKG6x4u8B1hUUP0LlN0Slcrm+RRHw6ielNFEOf1KPQ8Szvz7K5Krh9b1I7Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39850400004)(346002)(396003)(16576012)(66556008)(5660300002)(6486002)(2906002)(31686004)(7416002)(2616005)(956004)(86362001)(54906003)(110136005)(66476007)(316002)(83380400001)(478600001)(66946007)(38100700002)(8676002)(44832011)(26005)(53546011)(8936002)(31696002)(36756003)(186003)(16526019)(4326008)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OUVFUWRpd1pTek1jRW1GdzhPNGE4S3VrcFhJV3MxcTV4QWVGdndGRmphMC9z?=
 =?utf-8?B?WGViT3dsUUpxUG5TbUNjd2FGK3hEbkJZc3VVNndQSDhSRWVYOUdBVkxKSGRG?=
 =?utf-8?B?QnY4QmdpQ1phU0JSWmg5MWc3Zm1Nd1FtdTdXaGtiUyszai9MdE1mL1pIdVVF?=
 =?utf-8?B?VzBnMmJuSU1FcG9GUmE3eEJEV2c2ZnNNVTBTcTR2VFBxNE5vc2RRbVd5RnVQ?=
 =?utf-8?B?S3RxSWZQV0NZcHNabEQwc0N1ZTVRS2RDVWFyd21QU3ZjUTkxWHExaTEvMHZB?=
 =?utf-8?B?Vk9tSU5MU1Y3bnd1T3h4Tm5KTndIOTlBQVA2R1ltTXlIWWprb3hSazkzaFFN?=
 =?utf-8?B?YTJsaGxxc0xRc05KUVJCck5GK0FUYkRjeSsrcmhidjA1cVlTaU5YcGUxUXN6?=
 =?utf-8?B?NUxOdXZucTU2YVZjNExnclg1ZE4xb2pCaVlwUEcranZBVlgzTHNreWN5cXJ6?=
 =?utf-8?B?RUU2dzhUOW4vaE85dE16Y1JVcllFY21iK1VEVjRVazIxQTdYN0U1QzZZZHRX?=
 =?utf-8?B?VEFrM3A5VUVrMkIyWDZsbmE4ZUthTkROeXd2RkhUSmpZRUlpaS84ZXFVQXpz?=
 =?utf-8?B?cC9ad1ZPelhFYTY1eEtRSzh5ZmNoNzdEK25ta0lCcm1sN3pRcFZXQW1SM1R4?=
 =?utf-8?B?OXdSbVdLcjRZUzhiSUlsUVQveEMzaDFiekg5czhaZWpqaTR5NTg0WTdyUFJo?=
 =?utf-8?B?QmxsRFJTYVZWajgveDJYenJlR3R1UTVPMlBodU8rbVhEVkZFeUdkeVlqRkFo?=
 =?utf-8?B?THYyWnhmOEEzbXliYWw4Z1FJcTZjNnB5enRodHpKaG5ENnZzWUE1RmFWeExv?=
 =?utf-8?B?VUFQRHBITkhvdm9yWDdUcjJWMzJNY0N1TWhxVEVOQ2p1ZncvMDVMQ2I0bFM1?=
 =?utf-8?B?T3cwbFlxN3JiVzVtd1dNR3d2enRyWkZoY3Bsc1h0Q2VleHM0NEJrQjc1eEYw?=
 =?utf-8?B?eTBCTjNHNnhxeXF5VDhhalZaUHZIZ3V6OU1QVzVRQi92Q2l3WXdyR2dQRDlq?=
 =?utf-8?B?aTZpRlVFb21uVGwwOGtOZGJlSksxQUdhbE9GSlZxTktrcDA2RitTSTNuMWRu?=
 =?utf-8?B?aWU5VjdQZWZSbGJHUEF1Tk9ROGdMUnpiMDlqQlJJSlBSelRZWUYvcVJ5VTBl?=
 =?utf-8?B?NW1QaHUwYVZYQ2QrbE9McmE3L085VmtLbDJKTDdnejdOcHlpVzlnS3FoM2cy?=
 =?utf-8?B?OGx1R3Y0WUQ2TTQxVVNLT0VXZDJiRXVscHB4M1MrelRhMVU0dnlwWUJacTUz?=
 =?utf-8?B?RGZSajJYTE5CcjhqTDkxMHdvZEFCK2lYUlNoMGdJeGs0TkViWG1BY0FVbllE?=
 =?utf-8?B?b0dOcmNna1kzN3F2RVpYdGNmbXhQcnNkVExiblBqdStJR1lPb2gyQjlDUmdI?=
 =?utf-8?B?MHVJNTZRbExORU80dzVTbHN3ZFJvbTAzOGpjTERNbmhTZFZIY204dVVVMko3?=
 =?utf-8?B?dm10alVCU1hqRmg4a1N5U3QvV0llditaY0hySWRjQnF2emQ0QlNBVGZTeGZY?=
 =?utf-8?B?VkQwOFVNdkFXY2trRnVEZnNoS0E0S3RLUk9TYXppTlk2UVhvSWVoVlZvejJO?=
 =?utf-8?B?SXowTnl4VzhseTRnQmx6UnIwcDVxcUliMXlFVkEwc0dIeVJudHJZcUFncXVB?=
 =?utf-8?B?b1dLc2pmcVNUTjBRRDUwZGxCTGpZcklBV1h5SVBVRmNxVlFhMGZHQmM3VE01?=
 =?utf-8?B?V2N5OTZKWUxSeE4zNm8zWHNwVTJxSWRBRGt1VHpPalhPMEtDTzdMNVJnb2ZH?=
 =?utf-8?Q?dsfTRbrKeG3flaVv6Ucr6OUuCMMMhBjL3fUzxX0?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae831ad-01cf-41b9-291a-08d9106463f3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 07:56:01.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWhYWKnqW1BNIV05pKOuiQuHQzMTgJfKGTduRF6b41PpbgXA9cIbzqFzBCM3uDDlXtDYYXej7UBRjgY0qlBXmdfygS74Vo7STQNedWAXcj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4481
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.21 13:22, Peng Fan (OSS) wrote:
>> Subject: Re: [PATCH V2 3/4] soc: imx: Add generic blk-ctl driver
>>
>> On 30.04.21 07:27, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> The i.MX8MM introduces an IP named BLK_CTL and usually is comprised of
>>> some GPRs.
>>>
>>> The GPRs has some clock bits and reset bits, but here we take it as
>>> virtual PDs, because of the clock and power domain A/B lock issue when
>>> taking it as a clock controller.
>>>
>>> For some bits, it might be good to also make it as a reset controller,
>>> but to i.MX8MM, we not add that support for now.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>   drivers/soc/imx/Makefile  |   2 +-
>>>   drivers/soc/imx/blk-ctl.c | 303
>> ++++++++++++++++++++++++++++++++++++++
>>>   drivers/soc/imx/blk-ctl.h |  76 ++++++++++
>>>   3 files changed, 380 insertions(+), 1 deletion(-)
>>>   create mode 100644 drivers/soc/imx/blk-ctl.c
>>>   create mode 100644 drivers/soc/imx/blk-ctl.h
[...]
>>> +
>>> +static int imx_blk_ctl_attach_pd(struct device *dev, struct device **devs,
>> char **pd_names,
>>> +				 u32 num_pds)
>>> +{
>>> +	int i, ret;
>>> +
>>> +	if (!pd_names)
>>> +		return 0;
>>> +
>>> +	if (dev->pm_domain) {
>>> +		devs[0] = dev;
>>> +		pm_runtime_enable(dev);
>>> +		return 0;
>>> +	}
>>> +
>>> +	for (i = 0; i < num_pds; i++) {
>>> +		devs[i] = dev_pm_domain_attach_by_name(dev, pd_names[i]);
>>> +		if (IS_ERR_OR_NULL(devs[i])) {
>>> +			ret = PTR_ERR(devs[i]) ? : -ENODATA;
>>> +			goto detach_pm;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +detach_pm:
>>> +	for (i--; i >= 0; i--)
>>> +		dev_pm_domain_detach(devs[i], false);
>>
>> It looks like you should add pm_runtime_disable() in this error path to not
>> leave the pm_runtime_enable() unmatched.
> 
> I might need to remove pm runtime, since no the ops callback here does nothing.

Anyway, my comment is nonsense as you return success right after pm_runtime_enable().
