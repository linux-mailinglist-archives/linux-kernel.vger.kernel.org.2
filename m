Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8A535798D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 03:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhDHB1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 21:27:38 -0400
Received: from mail-db8eur05on2064.outbound.protection.outlook.com ([40.107.20.64]:29473
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229544AbhDHB1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 21:27:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eANHvPmn2KNdnm5P7IYEGMcHQTdc7rMKP2X5CR2n+s4z7q4ufYZrk92+P0tJPt1HWHgFFrbDTHxizhjB8XX/Xk/8DrllQmyIXTvQYO9VM73Fj+vNupVJbqBOjunCvUUsg9WHdEfyGH+2V6El7ZddZ2GKbUiErncTgRMTW9CQodh4pp2xicOT6nDG8O9mdvvwhkH6Uc0wHb/2gSwShSJbbhRiJPfx3THoiBxUzTfMSTCCkJI8CM6INSpb6nZSh/hphJyRVUhkmZwl8m34YOEOjj0fOaVTMa7BOKsF+/fDTEnMZk6+nigrHZosP+zH2QNRWFQhl9YWrN/pXZX8qMyfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m4zX9uhIG4AvmUbOhTL745mni6PckS3XkSjmDtxxRQ=;
 b=jxjD+f55jrAjv4njPHe4iYGaTlc/gzEl841UDcLK5e0JQIAAWhGOAPcObhPsOY0REW4ETPd+XCQ1m3E94FSN3Ios+Hhc05d3rRIZsL1CLU0/KtQ6rdv+AEVWFXRDwPACCDTvHQQuDinZN+/EDlAbvajXwJBBv0LXc02qBNh9ZEBbVmL7a8wAo3bTL4F1zq4o6LgfEb3YRuUUzO+O7cGBqgj2uuz+wd+mj/rGQGYvhlLX63uwRREnXOo6pUI/hRfRDO7T2Iis62ST6au883alqIX9aQx23Foih3DN001schgFnQlqEKSsQBXnJmUnUqka3VhlT/+2f2R8Aji0yxM+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m4zX9uhIG4AvmUbOhTL745mni6PckS3XkSjmDtxxRQ=;
 b=afSwyVkq7eqclGHuS98fSfFm3I+RYTov5fUy1hnZzdOIu0ufxHXjdor0Hp0pjRB8ZNQd5pNH36pwnPJnPS03UqUKBvgq9qWzEWDwrd0rW7fCV3Ap/hGl2npZdm8uqyaFJaTw2ry90He9Z/SyW2PDkOv8ItuGkurmCNC1hQAA1Oc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (10.172.251.142) by
 DB7PR04MB4938.eurprd04.prod.outlook.com (20.176.235.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29; Thu, 8 Apr 2021 01:27:21 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c57a:6964:f72c:21cf]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c57a:6964:f72c:21cf%11]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 01:27:21 +0000
Subject: Re: [PATCH v1 0/7] imx-gpcv2 improvements
To:     Lucas Stach <l.stach@pengutronix.de>,
        Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, krzk@kernel.org, peng.fan@nxp.com,
        aisheng.dong@nxp.com, qiangqing.zhang@nxp.com, alice.guo@nxp.com,
        aford173@gmail.com, agx@sigxcpu.org, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210407212122.626137-1-adrien.grassein@gmail.com>
 <542d469459083fa31e37ca7feb14480831a0445f.camel@pengutronix.de>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Message-ID: <bc59b75b-d5b7-fe0f-6cba-d184cab204d3@oss.nxp.com>
Date:   Thu, 8 Apr 2021 09:27:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <542d469459083fa31e37ca7feb14480831a0445f.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.193.102.190] (119.31.174.71) by HK2PR03CA0064.apcprd03.prod.outlook.com (2603:1096:202:17::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Thu, 8 Apr 2021 01:27:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd241915-2801-4b47-abcd-08d8fa2d7467
X-MS-TrafficTypeDiagnostic: DB7PR04MB4938:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4938826A3584D1C14CA93E38C9749@DB7PR04MB4938.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RD8vGDbPz+iat05i69z5Yf5hUXB6Qp00qpBBEZk8Lf4oykNOrzrnAO8fuuSA3/jqzICphpzQqRHjf+fMvecadPbMBQnsz0QrwivCDoi/cs63Yu7nwsD4pyoLxkiJqi1Ml4TFSUN4xWIQaFwpE0RzqG8kIIFhf5oqzTbso0wgpEIx0MEBFHKkOSyU6X4+nbUV6v/NLkPMOS6GbmOweBVVO5oFrtyDF1JDPhbe//kRNPACeY4Kkz5gGqGZyR4SJjq+zy8LJlaQl6OKfGipVxlbB4vP6LCxyj68bXVCfqio3W2qednAeu+uJ3TCnamRU3/T0y5U0wwqARLqXRskv3sb0aAKWSpo6mmnh35SZcmsLPfG96VognSkHbewPf22R5JWOhaUU5c02ULZ1Ggv3TbP3meUPCl8pYnanOTXknqZJcCVlKQY3cIe33mjml9e1ewH/T8Pls2wcgtz0MAAcaulq4MSx5pRo9z97eHZBtwrue6h8mO1XroPrIGQmsPsMB9AilWiydNJgrimyK+64xOalv0Qt+PXVThAeLdcjlfLNuwxFRmIY4xd1GY8ef8k1xz1e/r/xAOCS1f+Jd5SkpH9gRHcL3ulPXZzVKLtArxTWammwUxFDI210N094XUVY+3RkW8v9EdDcc2abdESGDQcxXVyo1deseWfThHRhI5PwrWxW4RJ8u6AP5rPVEYIglFN9l3KyZ0MdFyN/R22M1X2zYS0vtM2eoPIvBUllaQWOAP7iYbgsLCs3+H37khsUFKjfdtusPrPEUnp6DhLSqDQwtMfeAYCGc0NLT2EwuN+a0vCXIMiq4T4WGZ2vfJkSrRuX5j9svWPNxHs0UWKp3k3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(66476007)(2616005)(956004)(38350700001)(966005)(6666004)(83380400001)(2906002)(478600001)(52116002)(66946007)(8936002)(4326008)(110136005)(5660300002)(186003)(8676002)(16526019)(316002)(31686004)(16576012)(6486002)(7416002)(31696002)(53546011)(86362001)(38100700001)(66556008)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ODFzNTRvZ0YxOGRSb0hSU0VPYVFuUFVMQXYvbWlGMCs1eTJqWXlrZjFxdEl6?=
 =?utf-8?B?VWkxODRPZXBFNU52WjlnN2Z3T0NWeW1yWXI1UnZPblZnejRUOUdHR3ExSmJ4?=
 =?utf-8?B?cTNkcTI4UlNlZ3RYOUdLRjRlM2NuL0llZTl4UXpKeno1d094ZEwyVFJNbXFm?=
 =?utf-8?B?bmNpUDR0Mk45M1JDUnJHYkxBQm8zTThRQ0lEaXFFSDMrSXp2NkRvVDJrdE9M?=
 =?utf-8?B?NkpkSk8yemVtL3VHc0c3WjliWEhjQXFtSjEvSUFmY2ZyRlNrOVl4WjRtVTAw?=
 =?utf-8?B?YXN5d2UrYWt5MGlEM0ZsZ0gyTC9UMlRBbE9iVUNVYVFadTh1S0xOK0k3SkE2?=
 =?utf-8?B?dEI5c0pkVWZzcnpnU2dvREVoaEhZSjl1R0VkR2M3ZVZTWHMrbGNHam9EcmZW?=
 =?utf-8?B?YVF1WDBISnNvSjg2VFhERlZCWE4rdGZSWjJSWEtOMlg3ZmpsUnVqdEc0K215?=
 =?utf-8?B?VTJIR25Qb0x0L0QraERxM2JjS3lUQmpETlVJU0ZzMkhhbUlFcG1iUmMrbnlv?=
 =?utf-8?B?Rk85aGx4L0JsMTQxYVp3bjJYbDBDcmlja202MzJrQ3NJZHVNQXBIRHpQWWoy?=
 =?utf-8?B?Mi9oQUF5OEJNMVBvRXNndWVWOGJZUytpWTNXOENxdFN4UGhsUDlLejVrZDFL?=
 =?utf-8?B?cE1xVTZ0c1M3N2IwcVNuZE04d3ZNZUJ5eXh0cVRzdHIybTh4NDQzbUdnMUd3?=
 =?utf-8?B?MUViRFZMdDg3ZCtEQnMrV1hsWDBhTTVNQllta2QxcVhVdXp1SllqK3RKQXF1?=
 =?utf-8?B?ZnhxNWR3am1JeGxDUXJTUDBZMDZHVVcxbSticEtoRmVxcUhjV2xYSkJVUlg0?=
 =?utf-8?B?U0poaXNWUzgvYUVaQzdQSDFRUisyRzdVa2lvWEtVRDhMeVdvVDhzaEd3ekJE?=
 =?utf-8?B?cnBRczYydlp2b1kxSXdlT1NwT0lhQTVMSWhsbW42RVc5YmRGNEx1MWRqWUo0?=
 =?utf-8?B?RVNvK3lpZTIvcVR1a044TEpyVUlpVW8rTUhkZEZoVEZwa0I1Q2dUeGxjV2U4?=
 =?utf-8?B?WDhMb1RxcDBwUnBTYzdwalhKSTB4dlNjSSt2SHNoZWhzQ1JiNFpWa0xOMkVW?=
 =?utf-8?B?LzRsODI1d1g2eHJtVEx1UzQ4NVJZV2NMQTdlWkpRYTJoMG85VmRidzhudHVI?=
 =?utf-8?B?Tk0yY1l5OVlQbXg4MkhRcENkb0hJQjF2TzdFUjJDME90UW1hVVFvaUp5VEZN?=
 =?utf-8?B?YmtBNXF2TFpMN0FGazFYUVpucjhWbVEwTHBVY1NFNU9udlZ3U3VoT3k5UTZn?=
 =?utf-8?B?N1grRHZPTnpXS2RHOUNCYjdnZFF5Tmw1V1RzLzU5dFMxUXpKQWJtMHdQVTd4?=
 =?utf-8?B?UjdUcXRoRzRuRE9zU0k1RzZWbXFwT3cwYlhUTlRXTW1XdjBoZzRiWlJDMUNU?=
 =?utf-8?B?RlduT0lkV0IyblNPWGViOGwvNElZREM0V2htZmkwODhLM0crdi9wM2ZsdGNn?=
 =?utf-8?B?allQdEhXRzEyRmVKaFc3c2JxVlIvR3V0YXNCSk96cVlDWU96KzRvQUx0cWtF?=
 =?utf-8?B?K1F5em9wMzByb2d5TFJUSFpSYlU1SHpHZlpTMURydkFWOERvd1dZZC93dm45?=
 =?utf-8?B?eC9DbytPVnlDODZyT0tWZkFYYWl6dEpBMXZkTnhJZVNIOHA2K0MyYldYNitu?=
 =?utf-8?B?ZktORlNXYXdra3FwemFXbnhUTlZteFd0ci9IVDAwTEZkejlMTmVJRFh4SUhi?=
 =?utf-8?B?dHhEb3pXTnUzdjNnTFF6aEk1Y3J2VldSN1dacXIrWEJkcG5yUnM5TjRYWVdv?=
 =?utf-8?B?Rm95NFh5TTFhdVlNRndTNVpKb3E4MVBROXUxZ0FKSkZtd1JQVUVOK3VSZm0y?=
 =?utf-8?B?YXA5dzBSK0hJRk9CRTZCdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd241915-2801-4b47-abcd-08d8fa2d7467
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 01:27:20.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YljSwUvnScO3jmLUS9ybpKu48EFiWQkZLb/U0JJNRL5vI32IJIXS1P0WAvm3YwSUdMpbqeb7nZPTA46sUIATA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4938
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On 2021/4/8 6:13, Lucas Stach wrote:
> Hi Adrien,
> 
> I feel like I already mentioned to you some time ago that there is
> already a much more complete patch series to add this functionality on
> the list [1].
> 
> If you want this functionality to go upstream, please help test and
> extend this patch series.
> 
> Regards,
> Lucas
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20201105174434.1817539-1-l.stach@pengutronix.de/

Would you share what's the issue that block this going forward?

Thanks,
Peng.

> 
> Am Mittwoch, dem 07.04.2021 um 23:21 +0200 schrieb Adrien Grassein:
>> Hi,
>>
>> This patch set aims is to add the support of the i.MX8 MM power domains
>> on the mainline kernel.
>>
>> To achieve this, I do several patches
>>    - Check errors when reading or writing registers (concerns i.MX8M base
>>      implementation);
>>    - Fix power up/down sequence. Handshake was not checked and it was
>>      not called at the appropriate time (concerns i.MX8M base
>> implementaions);
>>    - Allow domains without power sequence control like the HSIOMIX of the
>>      i.MX8MM.
>>    - Add some i.MX8MM domains (HSIO and OTGS);
>>    - Introduce quirks. For example, i.MX8MM OTG domains should not be
>>      powered off (seen n the source code of th i.MX ATF). Quirks are
>> easily upgrable for other cases.
>>    - Finally I defined power domains into the imx8mm.dtb file.
>>
>> I know that this kind of patch is rejected by NXP ut the other way
>> (callin ATF directly) was also rejected.
>>
>> I also know that NXP is concerned abou adding hundred lines of codes for
>> each new SOC but it' the way it works on Linux. And the "added code"
>> mainly consist of adding structures, defines and generic methods for
>> regmap.
>>
>> If it's a real problem, maybe we can introduc a new "gpcv3" driver for
>> i.MX8MM, i.MX8MN and i.MX8MP.
>>
>> Thanks,
>>
>> Adrien Grassein (7):
>>    soc: imx: gpcv2: check for errors when r/w registers
>>    soc: imx: gpcv2: Fix power up/down sequence
>>    soc: imx: gpcv2: allow domains without power sequence control
>>    dt-bindings: power: fsl,imx-gpcv2: add definitions for i.MX8MM
>>    soc: imx: gpcv2: add HSIOMIX and USB domains for i.MX8MM
>>    soc: imx: gpcv2: add quirks to domains
>>    arm64: dts: imx8mm: add power-domains
>>
>>   .../bindings/power/fsl,imx-gpcv2.yaml         |   7 +-
>>   arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  35 ++
>>   drivers/soc/imx/gpcv2.c                       | 336 ++++++++++++++----
>>   include/dt-bindings/power/imx8mm-power.h      |  21 ++
>>   4 files changed, 333 insertions(+), 66 deletions(-)
>>   create mode 100644 include/dt-bindings/power/imx8mm-power.h
>>
> 
> 
