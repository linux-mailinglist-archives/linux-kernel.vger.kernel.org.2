Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF3F37169E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhECO2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:28:08 -0400
Received: from mail-db8eur05on2133.outbound.protection.outlook.com ([40.107.20.133]:47040
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229697AbhECO2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:28:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDbXMc4QaatA+bROo/jZY1Vb3BiSlPyC6rsC7S0hwCYw5WwJ5euzWhA5qGTyKiF8YJ0KE/7aX6x0dwUeRsC/nCYcskeD2b93IX8soslXZNSy64kar9pUKmW7n44qv08zfPJh0XU+UT3dlu2pwvIzDcnDh5Xam3vVEcX+afpLgtLFbSAPRL2hU7sOHBCEOpeqTKwHrfCIVVY5V8wSBX2wFPsFqbUV45HMnZ98pVCfDdlprnyV2pvxdHBEyrdOrrijNa5SOe2jVud65i0sxgcVHvcox9P7imrpgXS4m5SSd1N/tzLv9HaLtdUHVWKXhu/yUoozYt60ngOuE7/pyaLdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPT2rUtJHU0XM51ZFLjueYvGOPZA+Jrpe/d3EMMTBzA=;
 b=oW/DJNeLSnufHHsVrPJMLt3VWXjddAaw2sQRA/4ZeiUsNmXw/UiarOthdQng/ITGYtBmoeoFNcj5U8dcyyUgW2+mI4wNNGYQs76FvvnTZh/kaaady3cPwJXkWLYlSOv8QFbtILkfyvlCstwzGCwKCDUCtpxOi6JaiJ/sEVb9DX7wBUoIha6WMG+wkOQpZo7Uf6Trot9fXFmv2LzK2RaA72ktd0zf62xulbqZZAQidxhBjMbgxacL3047cdg9x6P6OrRkbu7hjafkiB3hL8vniZGIxv0l6lXyCnvMzq0dFlJs22niscD7rUdpMiogjAV9/HWzQCvEn5iejvLdVcwDcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPT2rUtJHU0XM51ZFLjueYvGOPZA+Jrpe/d3EMMTBzA=;
 b=I7ZZMnXfjp0lNCZNTcs7+bW+NeIt0h4MqIIbF+EPJqKhlLGo9YoG5LmHU+9A8Vs4ekjeAPvPzeA4TZQC+XfOFDyzjTp3tc5yoms5RScHp1EuOSy4l6udfjX2f8kiQCCX3G2iwinpa4Ud4iUfp2mLOFz/wbL0MKFegO/smSnR2Ak=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB2578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:12a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Mon, 3 May
 2021 14:27:07 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 14:27:07 +0000
Subject: Re: [PATCH 08/16] dt-bindings: imx: gpcv2: add support for optional
 resets
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com
References: <20210429073050.21039-1-peng.fan@oss.nxp.com>
 <20210429073050.21039-9-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <b8f26561-e69a-0d23-f369-be3b183c9c0e@kontron.de>
Date:   Mon, 3 May 2021 16:27:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429073050.21039-9-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.134.29]
X-ClientProxiedBy: AM6PR08CA0016.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::28) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (109.250.134.29) by AM6PR08CA0016.eurprd08.prod.outlook.com (2603:10a6:20b:b2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 14:27:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb78a54a-b4ff-4145-db9a-08d90e3f87f7
X-MS-TrafficTypeDiagnostic: AM0PR10MB2578:
X-Microsoft-Antispam-PRVS: <AM0PR10MB2578E1CDE1B794C35E77DBCCE95B9@AM0PR10MB2578.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80036lTspmYFuS//bteRr3CHs8xpVY1cAxwK8G9ndAtqYjbPpkf+V6AW/IFKkCHMLekYKB8i3+cujkE+FLKFiWu5Qv6aXoHHzUp8AzRQMrEiv50mIYq08716zq8BFq0OZcyX8u6rWsSfSkiLwmTWQ5AqECiqDs8WzVIIB0961rWnoJp5cs8m9PQpAZ6DvtVbpnT+ZaoBo/cDLZL4dvnZG7uZVi9AdWC4FciRcBD4fB68w6Q/spB7RN6JJFuzqzM5HPHkUBOOOcBM3Z3Od43DJgE/MePBsp5nebRlUj5E7dYZ89tsefOdrltldqBAbUoS91fIa4tvMoPnRYKsjazPNrsQWNuN9i4lrU+0SWhBURINYTYo/sH/UD+dvX6GP8bGsw6jY0bznGY+T1nrDJ37f/sotjAgTpTjHI1Dg9QEBvXsh9xF/iZfa4/ILDLXZzp2MM36P5G3yfroOjQ6T+M9buiaLtEL9aWFnByixPBcSmu6bHkhy4NIRcTkm5fuRfQyYVBGlEdvpSsNpbs20hP6g4M5GhNVc80DkPjMYiFLlz9ZgCUCi48yykAreyUykPF9D/Foh0zJaxeoxqXkPLZCvyiaS0PJ2CNRAzczazZTf2WLS+l55hh60kgFxQyQXDqSej+gd+pQ/pu66cyIU+sdx0iGy8T8Ia9bDcPYNDiqel7H6xG/GcaJllolUmASNHv/JQm38lowxVHdzBhhednInOOUDW5vTgS/cssA8MRc4uc+DyV12/8lnelVWqBMs8aDPag+oHLbKhMzlOrrvzsw0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39850400004)(366004)(2906002)(186003)(26005)(16526019)(31696002)(7416002)(6486002)(53546011)(31686004)(8676002)(66556008)(966005)(66476007)(478600001)(38100700002)(86362001)(4326008)(44832011)(2616005)(36756003)(956004)(16576012)(5660300002)(8936002)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TEFoZG05ZExyemZFcFhNRng1YU5tOGU0RjhScjNINWtYSUc2WndXbEczMmtP?=
 =?utf-8?B?cU5Da0F0cXU3am5wQmpRTWNSUlMvM2JMTFpjWDJ0U2U3SmZuMUtvcXRHczQz?=
 =?utf-8?B?VDk2VmY5U2htakZEUnpraGxuRStxYm40b29mSU9UamRldmZuQWQ5ZDl4WFhR?=
 =?utf-8?B?MGgrb2pCZnJKQXBuYS9XT3FEYmVUMHJwd3RQWG9hQ0FqSUR1bTkrV2J5N3pI?=
 =?utf-8?B?eUlZUHpjaldJS2lRalQ4V3NTNExwbzdnNG1hNFZKRVMyZS9oRmhjVjNKVjUw?=
 =?utf-8?B?TzJGNGZLTC9mY2EvdnhNZ1FKdTQyZDlzVDRCVFI5Mm1mQ0Urc244VGdyUFpC?=
 =?utf-8?B?Rjk1alRneERSTzJRNjdpMXJ1S3o4aVRFbGNxQy9oM2oyUVBMaW9ZMG8wb2Rz?=
 =?utf-8?B?MlpnR1pXTUkzL3lBT1hIV0Rhdm9tZ0FFNWU2S05nbDlVdVhSS1VVTFpCL1VF?=
 =?utf-8?B?MTA1M2RDa2F4dkV3ZHd0MldVaEpJSC9MMU83WVdtYlhCUkdKOG5OVkZ0SHUr?=
 =?utf-8?B?ZzRONmlaL2VSblhaQWMwTzA4ekI3MjliUGh1WjZDV1ZxZ2FSamp3Wnp6OVZo?=
 =?utf-8?B?OHpEOTVpd0tFNHlxRUp3Zk8zRS8xUWM0akFpa2xwdktwOEI5UG9RR1RXYjBF?=
 =?utf-8?B?clpIeXByeUMweHl6dEtGbVFsYmtIbFdVUEx0SVVmZEdDVzVRbllGOE0zQnpC?=
 =?utf-8?B?WVpVOThwUEx0NWxhbkFleHRaRno2Y2JkRjdZZGQvaFFKaFIxaXo0YzZGMEkv?=
 =?utf-8?B?Z3I4WjhLQWIvZittTUw0TzFacE12WVZIK2J1MTBlT0JxVm40ZDNmOHZlQ1dp?=
 =?utf-8?B?aGp4Ymx6NVNmQjNMZTJsRnN1d0ZoTklGZWR4UWNadG9pZzF3cFVDMVN1bU94?=
 =?utf-8?B?cVE5MFg1VmZNODB0Tkplbnh2UTdYMFBYazFKMUUzNFZLR2Q5akIrL3kvdS81?=
 =?utf-8?B?MFBJV1IwazRGMVpjd256V0pNZVh5UVFoUDFIWDVCWUFWWG5uaGpHS3llVEtC?=
 =?utf-8?B?WThNeWt3WW15cTZlSVZxcC8vREsvRjBiWDJ2dVJwWHoveE9WM2EzeWxIMSsy?=
 =?utf-8?B?M2phMVFzMW9DTlVEc2ZPRkpuTVBKeVdOeG1XYU5WL2FmYlhSK21BVjlIZnRV?=
 =?utf-8?B?VFl2RWJHdXhrSDRRdmd6LzZuSnI4L1k5NElHdk5QeGN0dk5DK0tWYUpxRmIz?=
 =?utf-8?B?Z0ZzVG0vbENqVEFKN3VWaHE5RVczM1B5Y1NsTkw5MWNJNEcwODhPVU1CazYw?=
 =?utf-8?B?czRFcnFsTzJNejdPczhwS0dFQTlQRVVZTm1MSzRHYzRzYTZYUmxmZkZHRHNC?=
 =?utf-8?B?S2s1a1JLY1pvbGFrR0F1UFUyNyt2YWc5SmlDQVEwQUdXcmNuRHJaTUFLbTgw?=
 =?utf-8?B?MEhkaCtsbzY2TVh2bHFEWC9zcEJaU0dyR01KSjZuSGlqK0hVaWZ5L1hlSGJX?=
 =?utf-8?B?Y0JIeTUrMi9Hb3plR2QzZTJwbDNQa1YvZnZQZFFPM3NRL0dhaUVOZmNHT01i?=
 =?utf-8?B?Rmpqa29OQ2hwMm14dGdzWHNIclNuNmpOdkxQWGFBMkU1T3UyREx2TXRUcGdP?=
 =?utf-8?B?OFZIL2Npc0F5Vmd4d2taWktzajdzcnFYNzRVblZVU3E2RmIzM1VzdW5QcHhM?=
 =?utf-8?B?RU9Nc1c1SmdKb1pKdVVJV0VZNWhIWEVJVDNob2sxT2Jqa3JKeGkyaXRJdzZT?=
 =?utf-8?B?YzFCczlUY3ZTYTFPeEZha1p1RG8rZk9BeFpwV3d4TDl1ejByRjZ1ZHlnSGpr?=
 =?utf-8?Q?ewYOMt3+EN8hDl+hFWP1rfUOpW+5Jrp6yZHHMFU?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eb78a54a-b4ff-4145-db9a-08d90e3f87f7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 14:27:07.8650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7VQqCINrGZ5V/vve35FE8gSXWHG8q0a7urg6FaJq05NIcDDrmpkpXrC4In+DpJKZWpnfU17UeKGiqNYToBYeyi2m1FhgCoGZYkdQlP6Fp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2578
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.21 09:30, Peng Fan (OSS) wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> For some domains the resets of the devices in the domain are not
> automatically triggered. Add an optional resets property to allow
> the GPC driver to trigger those resets explicitly.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Rob has approved this if it includes a proper explanation on why the 
resets are not defined. See: 
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201105174434.1817539-9-l.stach@pengutronix.de/#24147743.

Can you add an explanation to the bindings in the next version?

> ---
>   Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> index a96e6dbf1858..4330c73a2c30 100644
> --- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> @@ -66,6 +66,13 @@ properties:
>   
>             power-supply: true
>   
> +          resets:
> +            description: |
> +              A number of phandles to resets that need to be asserted during
> +              power-up sequencing of the domain.
> +            minItems: 1
> +            maxItems: 4
> +
>           required:
>             - '#power-domain-cells'
>             - reg
> 
