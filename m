Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B51374C84
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhEFAv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:51:57 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:44673
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229602AbhEFAvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:51:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGx3tX0vIbDTQV+oXyVZykLghtJ96gFK+Z5MbyeDUg2ilW0ZSAyBJSUAuDGjUEFa7x4LnkzH60BhGm0x76GQfKbSgOe88BZLMFMxTRQJhTp84l4GiowmPLi4bpg6XxdHVPjF7EljQ95FJgG6XlzZ/wejWpOlSl6mS/ZBbDQXmQ0uzDgRtiERyz+X9o4fEO6wBMV7jMHJ4TAAe00rgFdxyvIxr5Lslplzr1b2rsed6f/VCHKIk26m2JdaVdqJHLBotJiPxqCTnsxxNzsZUCtBVxtS5f/DSP4p2Gqalfx/d9WWRweVgk92Uy+zqu2bXjAVIvOcjdUyg6uwjdELCXcAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omaXX375HUejaDQ39ZnF6usdE8CEtUpu6870H8qJDBo=;
 b=MaUQHwbSZtk+CKM1jPLq+8vCYvzUqUqHinJxdlEMweyz6amzXJoi16lccn7Il97MizDdr4AbnCnjAsMx7Kha2YaRRBFYMesiy7EMW/kXHg8GEPL0/9EUXc+K27oMO8r+7ndTua1oOZnSN9PcIuKWAeZAUWsAZu86pbCF9usLEfBbZCe/9bCa6UP93CifLkNRLTEGup+jgBVpjFdfwdOCkLbnAxMS6/aakn61rqrGxCJHWaVTJxYo7NYq4pzb85J9v0eMGm+00+5I0Od26IizBEte2ywiaUF8okhGp7dSSpoOUbRx6SW60d/rtSZ1amf9LGw20VLp/3tgByI56MG/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omaXX375HUejaDQ39ZnF6usdE8CEtUpu6870H8qJDBo=;
 b=eb/KDpzcDtFgYlLpwWxMRSZ7XCTbEVj5FA8/rnkwrzNSzq/c/gXXE7EFbe/CYd1Y/TTn37GiEnU+4Ku8kZg9uTz90evHW/cXCt0o0BBIoChMMHo6gBxOymXQBJYQ41ihM3MqhMqBiOlXipCC5o2p3VXc86u+Znsd471lrcW1TlA=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5082.eurprd04.prod.outlook.com (2603:10a6:10:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.44; Thu, 6 May
 2021 00:50:52 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:50:52 +0000
Subject: Re: [PATCH V2 2/4] Documentation: bindings: clk: Add bindings for
 i.MX BLK_CTL
To:     Rob Herring <robh@kernel.org>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
 <20210430052746.10815-3-peng.fan@oss.nxp.com>
 <20210505230859.GA3010875@robh.at.kernel.org>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Message-ID: <4a49f463-3d75-e633-65b9-0f042c2745c0@oss.nxp.com>
Date:   Thu, 6 May 2021 08:50:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210505230859.GA3010875@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [114.219.73.42]
X-ClientProxiedBy: HK0PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:203:b0::29) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.110] (114.219.73.42) by HK0PR03CA0113.apcprd03.prod.outlook.com (2603:1096:203:b0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 00:50:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8350fb1f-bc3e-46f0-54b7-08d91028ff37
X-MS-TrafficTypeDiagnostic: DB7PR04MB5082:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB508264A53057C965A7F9246BC9589@DB7PR04MB5082.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CcxP4YNrm0u8PlOFWsP6J/ms8pHkqCh64+kaeRuPLk/xReQymgvxo+2H9jYO2SoJAKe7pJz62JNImNLhpC131DMo3H1CKIQYw/Wc1mrLSmgW9rVsvfeafGFrUB09IM9aYHdoK5bSCII0CvjzIsl+NBNDkgsZMdpHnfzEEVFnKmnf4G6zxvKVZN3sPdT/rN5JR2t2NEUcDnyxnVZnGZ7Oi5l8BAe5WthSaIXWvcQeW8XaEs8JKIWswrHPewaSWq/ILPeZ4lQm5Z9atA+A4iDxvcgtgA244YoxLtxFfUnnJxpip7xlehy2Ooi5iZJ5Ju4smGgIS92+1NaUadyikFA8KtO0kLc8SYS4BjuKLcLoombTa4U87vCJMvlCYvbYftpO/1ZorTyFepKyB0YcAbH+wyF6EA0YESmGGP/6pdI0f0KzhvTnAkzEglw7eAVGsnMJ0gVvuMBN33AqL4JqifRR6JIUgng4nh/U4c4oFByMDJGIeVDiYZuto90WeX41kJY4kEKaUIqyAWQZEaV3VD38sq6LJ5kh+GmuoEuB4GUNdfSU1td/AN2RFtkQxt7KlmFD8YI1o32WesxiiEht82q38K8P66Uu119Izp+HzTN0a201Js8lu+Rhpaw8dOZBFivYnnN5G4Aa82Nz5O1PuEIr/YnNVqMTYfrUMQsFAQQHXBR49TeP8WGitqAjHOp8IESWGd7Kkp0wSjqzgSJhv5lK48fkaVGzjSsEG/Mt2myRqJGRe/GxaWkJfJhUVrk4hjG1pb45hLN06KvdGlEmUhd3jEkB88EtZ0raB16FULntQ14=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(31686004)(66476007)(66556008)(478600001)(83380400001)(316002)(6666004)(6916009)(16576012)(26005)(86362001)(38100700002)(956004)(7416002)(2616005)(38350700002)(186003)(16526019)(8676002)(4326008)(52116002)(31696002)(966005)(2906002)(53546011)(8936002)(6486002)(66946007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QWFjYWJkUVZibUlyWVdDbmd4UVJqZDJmcjlUQ0pJV09lVFhhWURJaUt3T1pZ?=
 =?utf-8?B?bmR4RzQwRHlTSVhFaW5WaDQrSWhEOGpTdUg5NkhjUzA4Nnk0VWlpaTM4aU5K?=
 =?utf-8?B?U1JSSVNMTFNERXgzM3dMNVBMNzV2SlQ3YUk0T21GTzRZTllPSmhWcS9QZWxx?=
 =?utf-8?B?MGVhSk5WZzBIOVUwLzRlTG55RFpEVHpSZkZZTWtyemxQSlVHc1dIbjQ4NFZU?=
 =?utf-8?B?b3BXek9yWHFIS2hsTmErTHNDaTFBK2pHbjd6b0pEM2E1c1hLT3NpRFNrRm8y?=
 =?utf-8?B?MGNxejlwanI3NW14T000VnBZVk9nTVVPN3d3bVVKbFdsSXZ4em54eDVvZjVB?=
 =?utf-8?B?Z3l2RnRGYWxJV0dxUTFVZWVvL1FqL0wxek9nK2k0SVNzbUhrU0dtMnBEUHZy?=
 =?utf-8?B?Mi9tZStkY1MySWZPeGx2aVlzeEs2VjVvQnhzZWRkZGFWMGhpREJOeGdIZkxz?=
 =?utf-8?B?MkJkdG56anFSU2FUL2R2alZQQnBzYnZNYXJFNThaNUFaMXNyT2NCKy9qVDB1?=
 =?utf-8?B?ckhYaGhVcUV2TmU5QjdRVjdDNVViNGxSNUNyOUJ2Yk9QYVcwMkFwTG52Q1lL?=
 =?utf-8?B?ajJMQXUvVWhPdnJiV0wxTzZDUUpxTXVQblB3ZnE0a0xqOWFaUU5WcEIwdW9O?=
 =?utf-8?B?K242N21iaTlWM1hqZHk3dUVWUlZQSERpTVMyb1NpSEdkcXpMMDlScFlwMjh6?=
 =?utf-8?B?aUxIQ3BaSWZWRGlyRWw4Q0UrYVN3ZGJGY1A0VGsvVmFOcTFsajMyQmcvSXpq?=
 =?utf-8?B?M1owVmFsZGpjeUJtUzJONUZJRWR4RlhYcTVYYWxXaGdBV0pmTURzcmh3VmVB?=
 =?utf-8?B?cXFSVGZUY2pkZGc0REx6a2k5aGlZYVZHc0REMmVzZTcxQ0FPYW9BbkhUdG9H?=
 =?utf-8?B?MlZZOFBNOE1pTEJCbUduR0FUQjdHYi9qVDExRnVMb0crdXFweE9IQkxmYzdh?=
 =?utf-8?B?dks1eXpPNzdlNGpTUVhMdlZuYWcyUmROZVhabHc0ZnJKaHJ2bGRYMXVpTUpy?=
 =?utf-8?B?bVp6Q0lpU1FXd1l4UzRVQkNFT3hzS2pNRE9SbnFFY2RYZEkrOGJRVGVqR1lE?=
 =?utf-8?B?UGpPYVBjMjhnMmFoeU85OW1abVBraUxYUWZkSXI3bTREeEY3d2VlYlNnQ3Nn?=
 =?utf-8?B?OXRPV0hUUGJRR2NuQU0zUlRNRzVLQ3FWZDdLTVFNaFpRZ2EyQk9vMUVYdllw?=
 =?utf-8?B?ZnUzMndKT1pDZm9VcWx1VFkvejQ3bGcwaXJqeFlJRjMzcUc5aklhOHk2NUVx?=
 =?utf-8?B?LzFUc0VpRmFuLzJTUEc5N1ZMUEg3aWhERG1WTk1OOE52dFlKbnRWMVE5NDZi?=
 =?utf-8?B?elBFbDNoVHlBWUpLdEU3MTVyL0VHVGg5dzlFbUN4S0ZvckZqZ1ZYcVlBVEFk?=
 =?utf-8?B?d01pdFBJMk4weS95eCtHTVBRNkpzNzhBRmlRVW5YbjlBQWJYUHlJYjI0SVdj?=
 =?utf-8?B?WmpPclFkeGljUXl6TTRXdTRZT1RDUXQ3a0MwVGIzRjl4TmVqd2xwZFdhQS85?=
 =?utf-8?B?UGR3L2VKeGtnRm0wVk5ZemtMSlN5cGtUTFcrb2diWmgxL2lNNEhOL0JKWUpE?=
 =?utf-8?B?QXIyT2NnK1hxZjFZUC95M3EzaGUwNWQ5Wk92cFR4RmRJZy80R0tZaHRuUlY2?=
 =?utf-8?B?MFNqU2dJQXY2SFVUY2JFWCtOQ0RDNzhIVUZKeC82NVQrSUJRdzZRM1dBL0hM?=
 =?utf-8?B?dFBib0ZYajFId0FYS2E1Uno2RDZodUlPOVhtU0JuNVRIRmFZaW9IVUo5QmRh?=
 =?utf-8?Q?sgBKkUyRMtdOs9a4rPZ1MU+0Xyp1Bk571E5fVMi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8350fb1f-bc3e-46f0-54b7-08d91028ff37
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:50:52.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uV0r3trsZY1Lb23/qceQ3TQUZXBVixe+quZJXUDmyy9RLHhvLyzJlrsus6CbiAOR2Gol4Upf11WqrxzVoWnrqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2021/5/6 7:08, Rob Herring wrote:
> On Fri, Apr 30, 2021 at 01:27:44PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Document the i.MX BLK_CTL with its devicetree properties.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     | 73 +++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
>> new file mode 100644
>> index 000000000000..a491b63de50c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
>> @@ -0,0 +1,73 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/imx/fsl,imx-blk-ctl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NXP i.MX BLK_CTL
>> +
>> +maintainers:
>> +  - Peng Fan <peng.fan@nxp.com>
>> +
>> +description:
>> +  i.MX BLK_CTL is a conglomerate of different GPRs that are
>> +  dedicated to a specific subsystem. It usually contains
>> +  clocks and resets amongst other things. Here we take the clocks
>> +  and resets as virtual PDs, the reason we could not take it as
>> +  clock provider is there is A/B lock issue between power domain
>> +  and clock.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - fsl,imx8mm-dispmix-blk-ctl
>> +          - fsl,imx8mm-vpumix-blk-ctl
>> +      - const: syscon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#power-domain-cells":
>> +    const: 1
>> +
>> +  power-domains:
>> +    minItems: 1
>> +    maxItems: 32
>> +
>> +  power-domain-names:
>> +    minItems: 1
>> +    maxItems: 32
> 
> Please describe why there's a range and we don't enumerate each entry.

Each BLK-CTL have different input power domains, they
have different names. So it is hard to write down each
power domain for each BLK-CTL.

Same to below clocks and clock-names.

Thanks,
Peng.

> 
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 32
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    maxItems: 32
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - power-domains
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/imx8mm-clock.h>
>> +
>> +    dispmix_blk_ctl: blk-ctl@32e28000 {
>> +      compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
>> +      reg = <0x32e28000 0x100>;
>> +      #power-domain-cells = <1>;
>> +      power-domains = <&pgc_dispmix>, <&pgc_mipi>;
>> +      power-domain-names = "dispmix", "mipi";
>> +      clocks = <&clk IMX8MM_CLK_DISP_ROOT>, <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
>> +               <&clk IMX8MM_CLK_DISP_APB_ROOT>;
>> +      clock-names = "disp", "axi", "apb";
>> +    };
>> -- 
>> 2.30.0
>>
