Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96B63CBA4F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 18:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbhGPQKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 12:10:16 -0400
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:21888
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231739AbhGPQKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:10:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFBdQb53kjGD+Eoq2WrkbfqzjznnqlkYI5SoIrT0F2EZoTi5WB95bAWIPmCNUMkeuOKnu/IGKAUJ6sbpTZQmdVy7gDJxGhWlUOD98Pmnj36cXlxNvUPgMqP8zLm1tau9wX3p/dpILBG1OIn9JcqehKr8jg67z32F6FhGRP3lV4hcvVpiz8M3m6EM8RlT64L883eAEmaBVo9nSHwz9Edrrpq3oCscQBFttL7XU73JxcWOhOqOD6KR83PG74NoyAJ9tYyehvplSDzGQKWG1tAnhRLmBUJgU6nxHoYB9Td6OB4jMT0qY39wz7lZwl0Cqld0gdf48YAsyzV04JT6M6EWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKbRHk1AHzduk3tsPLKN9exgeelL3ehMjtzVM4qv/0g=;
 b=mjRPZO8Olr5UdWkQIPc9z8Ckq3SKh6F7EB3KfKy9QqJDAQAYL8zLJCna8v6Mj62yCFH7mhpZ0xD3y8tsUm5N+U9PZZNyaXrHCad2uVyyvlQq2/TlFMRu6B+IG59t7IM1Qq6p5c76w7QYTnJhdJcFw0bTrYKDOQoER9pEyyyZhRowMghrILDVDWJ0QAcyS5VLP8WtEToPqcy+VL+EoYOnysbYWdzBBp3IZWayny9j2hZnUsFHgoBqHOrQot4YYuchH/50XCLuD30B5E/S5ItNWd8IR3Xy2vlijkzp/LfjRWf8E8/6qAklmfpY5wr/N91Dd7hSP/sAUOD9h1+nKEzvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKbRHk1AHzduk3tsPLKN9exgeelL3ehMjtzVM4qv/0g=;
 b=ioTvDDe7ibhkhqRK06A5q9zBKNxzop9EkIBffk7akDRhuB6U52fPNwSlZ1IGd2U+yvTkNNdfJb1/cSwdbTxT+skepFBWldW5NEbJga+w2to0yB2ha4BFh3aWkRCS2gr6qPFMonWI3eAKHshkJkVbVF67oTjWqCYHnKUU69C4bpA=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7327.eurprd04.prod.outlook.com (2603:10a6:800:1ac::15)
 by VI1PR04MB5293.eurprd04.prod.outlook.com (2603:10a6:803:5f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Fri, 16 Jul
 2021 16:07:12 +0000
Received: from VE1PR04MB7327.eurprd04.prod.outlook.com
 ([fe80::dc6e:3840:cd62:ff3]) by VE1PR04MB7327.eurprd04.prod.outlook.com
 ([fe80::dc6e:3840:cd62:ff3%7]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 16:07:11 +0000
Subject: Re: [PATCH v2] arm64: dts: imx8mp: Add dsp node
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, qiangqing.zhang@nxp.com, ping.bai@nxp.com,
        alice.guo@nxp.com, jun.li@nxp.com, peng.fan@nxp.com,
        thunder.leizhen@huawei.com, yibin.gong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
References: <20210716124719.926483-1-daniel.baluta@oss.nxp.com>
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
Message-ID: <6f57dc56-d31a-1475-7db1-55ac6aa7b10c@nxp.com>
Date:   Fri, 16 Jul 2021 19:07:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210716124719.926483-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0192.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::29) To VE1PR04MB7327.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.7] (188.25.202.88) by AM0PR02CA0192.eurprd02.prod.outlook.com (2603:10a6:20b:28e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 16:07:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf930cc0-b84b-41be-bc0f-08d94873c51b
X-MS-TrafficTypeDiagnostic: VI1PR04MB5293:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB529306D08A940F133CB2BE668C119@VI1PR04MB5293.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8j0m4dSeC8hiXl/yBu7znFTqrkDgYnyf1EBUidZG2DzqtpG2EpHyEmz7GGHIUEWtKCS1wd0eclSc1/GcRgTelTyEtie27NPFaKE8t5+5djmyRO2VQUiEpvanWEb9YiPGBAvAmNW3Sk2AJ7aHk5YU3klQ6iuquLoPZmeCMHGEK/w1NntcMmadMZFx0YrSSVNT3RqCPAfLLoCVzITz4OCCb5y3hiNsMMO4zge3l3kW7CFdMlyPtUrFbLtNSJQ0rd8StwPmNeaAHqfWjPtiX8aeQdFcwvfgtLLVIvaPxMYld2TU1TXdAAM0dkq51RgHpnPFYtZ2SjfWH/uFZnvLw1DphB2MMetLaY3BjW4JA5PPGH7CElo8ogtYq3ciGQSHAJ/8gQgFhcZ+v6y3CT+ODJKa13yCb2yVrej53HtkReXZo0A32+BVHIc2RLTZPOojhEkpOnYKJYUgHSbTkD5Lm0Vk2upNHQ2UAl8eLLv1mGqK0oqMstFSynnUpYrY0TOG9Q3esIdYObZmXIW4mRRzVU3YlnhRqrB7Dt73IDwhBokW7XF08VchnlWY9AgO20MFCTNtf+myVipXsxQ07QNbi0cdC8cH8mbsK2cDlmv1gIAzhjt7P8jlQaSSlzuSsF/SvQaEXBPecWQgfnRegjXwXjPk8iCtnma662LtGw5TMiIZERdN306Xp4HGg0mhT2SdG4r+WVALvZvh/nB4SaFFRS7MK+zRM74tf+ouEXJgj9qnJh9ZHvcCzz9seOqOA+T3pWdGtPr8hIoJQXvEIGC1DJz09b2oeFGkuG/CYWPIdqFCO86UGfGfgq8psEmlDadF0MkIARLVH6pQNuUvSgq6VcQDTuoCGlGJ9/MTn3CA22SJQt8zfNGDjV5huIUNMig0UsTD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7327.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39840400004)(376002)(136003)(186003)(16576012)(316002)(31686004)(2616005)(53546011)(83380400001)(36756003)(956004)(26005)(52116002)(86362001)(5660300002)(2906002)(8676002)(38100700002)(66476007)(6486002)(66946007)(31696002)(44832011)(8936002)(38350700002)(66556008)(966005)(478600001)(4326008)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjBrcWxsNzd3cUY0eEpURHB5TVJialRsVGoyQnZ3bXpFMXYzcGJoZmVhOG9t?=
 =?utf-8?B?VXRNZzdFaDVaL01LZlF2MGpzUDdpekNubk5ua0trSW1ZNCt0UnZ6ZVRVRHpD?=
 =?utf-8?B?dHpoczdoblZYU21NWk4yVHZ5eEpGTUdvZEdLb0pSTkJSSlV2bTE5cGtDWXRE?=
 =?utf-8?B?blV1aCtQdUZjd3JZdU9ZazFMNFhqK0s1eUROMy9VMmNUaDRHb0ltYklycW5n?=
 =?utf-8?B?OUFoUE54U2JkbHhDWmVscnExcVVDK0ZhUklOeWNCUFp3V3IvN1RpQU04TWR0?=
 =?utf-8?B?QjFiMWJ6SzkvQW9yaVQzTDZmNHFvTVVJY1hycW5HRmM2VDlJb0dvYks1VWlP?=
 =?utf-8?B?SEZXK1gzUEMxaDFxc0YvT2Z1c0NhU3h5cnUra2NqWjZrQU1lOUw4Z2JFK2o4?=
 =?utf-8?B?cUlweFo1MHpadUxPdkpsRUhvYVlzbTdhNW1XekVIZk5ZcmpKeEJDamJ6OWMx?=
 =?utf-8?B?akN5MjB6SVNOR2xWL3RSVDFxcjlXNXBKR0VBTE5ZZVB5UTdPYjhUMVBxa0dD?=
 =?utf-8?B?VmkzUFkyb3ZnRktVdHR0L3lxamJQUHlhUTMrdnR4TnFyWkVzS25leno5b1Vw?=
 =?utf-8?B?aDZFZGc3L0xEUkJFaThKaGc3TVBOVGREYytSRWpxTzYvek0wTzRIZ3JKK0V0?=
 =?utf-8?B?KzdhN3dHT2syV245ekdXZHJWUnhBd1RCNWFKMTk1SkhRQjJPdkNrdWhYa0xP?=
 =?utf-8?B?eXhmd3pLY2VXM0RVVENpSTA3ZDkwbEF3K2FENTFHZDV4L3hKTllLNytUMzBN?=
 =?utf-8?B?NTdhTmRKeGhUNmt6NC9EVGtZeGNXNzh0d2Z1NDJjRVNpbUh1ZllUbXJySTUx?=
 =?utf-8?B?VE5WUDhHeUtlc0xQdy9Da3BaVE9ONDBpdDI3UWVzZnA4VWpDTlFFcnRwUFhC?=
 =?utf-8?B?Vk5FblJiN24xR0VBcFpuUmQrUUZ5ajdJWXJNM2c1SnFZSllWc3BaOG5VV09G?=
 =?utf-8?B?cjRFNkJLWXc2ejUxaFBIaUFTbHhUc2ZWQ3FPbzAwUUJReUw2RUxENlRXMDBn?=
 =?utf-8?B?Nmt5RHREblZPTkNieGwyKytVNDg0RGY4VlNXcE0xRlZZMEtOZlE4MEh0eWJT?=
 =?utf-8?B?Mi9DRWhNVkdEZG4vd0ZycExNVWVsbWhmaXFLMXFMZS9oUDNsWmEwMUFCUXFY?=
 =?utf-8?B?M2pHUnBzVjF3WjAyek1MV29xeGJEM0trU0R1VkhKaUxqMTNSRmF1c2VEV2RX?=
 =?utf-8?B?cFJndDA1NHoxODJMM3pCUjMzZWdKeUNQQ2wwbTNGcnVRUnVOS0JFcEltaWRi?=
 =?utf-8?B?cmFBaXE3VTJMdkpIQVhYaFZHYVdzdWtNcFl5aVBwNFlicXRCSzdhYUJHZjNV?=
 =?utf-8?B?dWZrRVdVQnZkZW5wSXI1Yjl0WG5meHVqYUQzRHJBcU9CWnlaR1d1R3pxTVhO?=
 =?utf-8?B?a1BPdFY3Mkh1VFdGOUp5dG9Pckt0bkJSZFY2SkdqZUdoVWRRNjlVajc3Zk1E?=
 =?utf-8?B?dk42OS9KZ0pWdDdqd3hZTXREQUxTREFnaXo3UDlsUnVBb3pJSDlQNGtTZmNx?=
 =?utf-8?B?VWFkVk1SZm41TUtqRmpFckp1KzIrbkovVGJZZ2ZCNXRWTFp4ZjMrQUxpTU5Y?=
 =?utf-8?B?SUZTZVgyTE5hVG5nbmFUWklNZU5CMXo5V2dnYU8xc0RZNXN1SkJNUllncEFi?=
 =?utf-8?B?aFFhdi93azFaMmlmS0JmU1V6RjZWOUduOCtiSisyN3RnUDN6UFEzV3A0YjRj?=
 =?utf-8?B?NU5sLy92YTBhWjZ6SlhtWU15MEZCRTlwRjhScnV4dE83eTlOV21BRmlabHBY?=
 =?utf-8?Q?ERgkzrjFXk9ccR9lPDKG7PZIPVX3BsHbJycR6er?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf930cc0-b84b-41be-bc0f-08d94873c51b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7327.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 16:07:11.8857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwzemNfWQkrrkpdxUdP3dkGpxWqc89Ba99wJSyHKFGDH3wUtb+3+4ASrC4ZEtGIvyuEE89GORDTTttxNPcYXYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5293
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/16/2021 3:47 PM, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> i.MX8 MPlus SoC integrates Cadence HIFI4 DSP. This core runs either a
> custom firmware or the open source SOF firmware [1]
> 
> DSP device is handled by SOF OF driver found in
> sound/soc/sof/sof-of-dev.c
> 
> Notice that the DSP node makes use of:
> 	- dsp_reserved, a reserved memory region for various Audio
> 	  resources (e.g firmware loading, audio buffers, etc).
> 	- Messaging Unit (mu2) for passing notifications betweem ARM
> 	  core and DSP.
> 
> [1] https://thesofproject.github.io/latest/platforms/index.html
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia
> ---
> Changes since v1:
> 	* mark MU2 node as disabled, because mu2 clock support is not yet upstream.
> 
>   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 29 +++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 9f7c7f587d38..fb0ac85c8473 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -135,6 +135,17 @@ clk_ext4: clock-ext4 {
>   		clock-output-names = "clk_ext4";
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		dsp_reserved: dsp@92400000 {
> +			reg = <0 0x92400000 0 0x2000000>;
> +			no-map;
> +		};
> +	};
> +
>   	pmu {
>   		compatible = "arm,cortex-a53-pmu";
>   		interrupts = <GIC_PPI 7
> @@ -698,6 +709,14 @@ mu: mailbox@30aa0000 {
>   				#mbox-cells = <2>;
>   			};
>   
> +			mu2: mailbox@30e60000 {
> +				compatible = "fsl,imx8mp-mu", "fsl,imx6sx-mu";
> +				reg = <0x30e60000 0x10000>;
> +				interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +				#mbox-cells = <2>;
> +				status = "disabled";
> +			};
> +
>   			i2c5: i2c@30ad0000 {
>   				compatible = "fsl,imx8mp-i2c", "fsl,imx21-i2c";
>   				#address-cells = <1>;
> @@ -938,5 +957,15 @@ usb_dwc3_1: usb@38200000 {
>   				snps,dis-u2-freeclk-exists-quirk;
>   			};
>   		};
> +		dsp: dsp@3b6e8000 {
> +			compatible = "fsl,imx8mp-dsp";
> +			reg = <0x3b6e8000 0x88000>;
> +			mbox-names = "txdb0", "txdb1",
> +				"rxdb0", "rxdb1";
> +			mboxes = <&mu2 2 0>, <&mu2 2 1>,
> +				<&mu2 3 0>, <&mu2 3 1>;
> +			memory-region = <&dsp_reserved>;
> +			status = "disabled";
> +		};
>   	};
>   };
> 
