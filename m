Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397CD42EF02
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbhJOKqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:46:48 -0400
Received: from mail-vi1eur05on2113.outbound.protection.outlook.com ([40.107.21.113]:7840
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229690AbhJOKqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:46:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nztkHAYZv8lIywMD5IXopAUUN45B/g1S7r6s6y3ly0/n7DkvXK1/nFxwQ3eTS8PhRoCCszF4TFVckPKs6Ij88CM4rq/6Mhc+iu3jfpoYmmEW//IQM7KsQu2U8kEurrl7UlzOW9XRqf4Ghbf9aAXVHEbdYeFVdtS/apfCsg+5zqfZeCDWebgnDONo8dvE/oJy0vT7N6dYy31viAPI3GLKzLNaYGEbbA3ryQVt2VG5hRkxBLfqxPY0f832PO1mQSPt0eDgfWReh5ZqkOFG/2tm/jX2Hw3X69dVeSE9a2S7pyup6V8t3yOYfFeyi+b7YxwrF7yv9D1SD9Pbs6nV3BmBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+bYhPKuK7rII+f0jRiMiPb5D57nY+dtk3nlfA6QF88=;
 b=CWLvOdEXjCPofD7XhGHZlpCiAiDL6UoVghAYXvhVxMh/9pDw6Qeml7wzi83DS/omBWJLlWmSMuod1yWG60adR3zh6wdm3QgsxKsVZDmwaztZFukN7kJr8SQpGS/8tArukYVtpeb3xISxyH5tRPPEWtJUjPob7MCAYw16vW3ECBQnOFFDMsfzC00Q9UuxMJFvrYpvoW5nPuJ8euc+0FJ7bImZieibGkt6tNZ7YPAl4ni6XKl4+MtRyB6BME0VK0QkpuVw0LeI3qaHSQf7r7yh4Wg0jq+Dl5u3CHZUa7R6FfFV1bxG2Xe3Y+trXfRfe4c5Ulz0sOKCermnA10oSY0qkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+bYhPKuK7rII+f0jRiMiPb5D57nY+dtk3nlfA6QF88=;
 b=R/cIwIPPR1IR3ugpsDKqouEeVxXr/lR99eaHZ5vJ997NXB69QnQ+OVZWHuSSY6Y6bHhz9pjokcZ9cKkCbYTg6+6v3lgyzqsguQJv7tO+ChhgE8q2X8d6ez6e30suobHw4RMW0Fn8M7d4U9aFfAjEnhItk08nhhMCBKy3l674TUg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 10:44:37 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96d:7b11:1f16:a316]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96d:7b11:1f16:a316%4]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 10:44:37 +0000
Message-ID: <60331b5d-89e3-0dd7-c936-84808dcefc0c@kontron.de>
Date:   Fri, 15 Oct 2021 12:44:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 1/8] arm64: dts: imx8mm-kontron: Add support for ultra
 high speed modes on SD card
Content-Language: en-US
To:     Shawn Guo <shawnguo@kernel.org>, Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20210930155633.2745201-1-frieder@fris.de>
 <20210930155633.2745201-2-frieder@fris.de> <20211005064556.GX20743@dragon>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20211005064556.GX20743@dragon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::19) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
Received: from [192.168.10.35] (89.247.32.72) by AM6P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 10:44:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eb153a7-0a2a-432b-c046-08d98fc8c891
X-MS-TrafficTypeDiagnostic: AM0PR10MB3681:
X-Microsoft-Antispam-PRVS: <AM0PR10MB3681D10D1A89E34840C8001EE9B99@AM0PR10MB3681.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j254JMEOQ/jz4VZW4oKRFtizc4twTq41w3wVLjPawA27C8BUp+CrpSxHxiL3TKp46t44UsF1yZHaQazECuYZC3bRdzx6CiKg4L2h0JNcf6YQmsty5L+veNcqLQO6gQ2Y3L84C76ku7JjWAeMtELuwi+RWknQ9eXYurDlLa86QY21ODxmZroZ6NnG9gPnZ6lYklDHtNwzbD5Z7GEarHNK0bR9KogHhuLqWfyFpQtDXAl3IaezvEsjZ8el+s8ILawqXaZdthmikfw8QrkvPaeaArG/O28RvzLFZdkemtVUDxZx/T2Z0hleM6rRK7xnERkai6fDwY3YRVBkmSzjp5KBeNuxgtJQSmlZqs59YzzR0M2CdR/H6GzrcOrbRn0nW//Lyf2QZgXT32I3kMM1o6WhHpIFzu9EsgZcFfpfOMq0GNO9S9lh2tHosnwfFGdfwsP2jv0ednq8t0ofTuCX1GMVwjSbYqSnRips9Dsae3CCajB1fh1JXxoy/maMiNQfgRXNdUKt4tdjrnGc16DRGXwZOOQQAqxg0I2TaQTeUlZTTBe8/5YEpD5zkjIAZ7n/AbrDDKfnj6i2n3THj92Sqan5ErjXHTllXajp3rUFBrLpkB23sFCa9xHKg86uoiwEopCG1CMI16pfSgPAz0TTg1rbWC6NHn88IkpXV/MY9zc6fpTxPbisgt6qxLc8we8YIw0TEep3S1V5kaFmKh8wn2P8s33mFkGp2H9m4Zop+TCM1+3yaqMuHTQfYtw1kToze66n9qEaf/k7QYsUly6VjCs1DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(5660300002)(86362001)(66946007)(38100700002)(83380400001)(8676002)(31696002)(66556008)(2616005)(316002)(66476007)(956004)(110136005)(186003)(16576012)(2906002)(36756003)(31686004)(6486002)(44832011)(26005)(508600001)(8936002)(53546011)(7416002)(4326008)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW4rem9QdU9BZk15N1pTU3Y5ZDVVQ0lyVkxtN1d5VVNFTUM3M2VmanBicWRB?=
 =?utf-8?B?WUxJWlB1b3pHdGdleHRrbXlSZUJZTEREbU92N3RmMk1kQUpidlhvY2xtVlE2?=
 =?utf-8?B?VTgwaldheHdzekJRQkJJWGkwNzVuWkt2bENZYndnMmRTQklqcXFURGJvVGt4?=
 =?utf-8?B?b2owUlFLQ0IxM0ZQNXUzRldmQnFua3hkZHVSVFN0LzM1VDRPWk1Fa3BLNEhX?=
 =?utf-8?B?UEZvRnorWG9vak9CQUlPY3NRVlB1bERkaGhYbG9GcE1GSWgyNzA4YzFTdTJX?=
 =?utf-8?B?Y0R2RS96TzRqMXNicVBTdjV3d0UzeThCZGUxUUZEa3VLMkxDR0Npb3RVZTVp?=
 =?utf-8?B?Z3R3Q0RMRExjZm9SZmhhRDU1bGhJbTlDeVpxOGtaUXVWd0FhMUhjbmNRNnNE?=
 =?utf-8?B?YzVPdTJrK1RMSzRaYlZuRVRSeVZEUG5PK2JlQ0dhTXNMaDdQdUFocXB3cWVY?=
 =?utf-8?B?V2hSVk55dTJYY3piaGtEc1gvbU9TdkVETGxmZGlzYVJDekdUMHNNQTY0cjFC?=
 =?utf-8?B?dElCWDcxOXppVmx0eElLVkQ3clhPUGUwNHBud3VmYzlRSTB3LzdpdDA4Z0M3?=
 =?utf-8?B?UExPdmNpYURZNmd4VjF5ZithRDRkVUNxajlnYXlWZkhFTVQwQkI3TS9WY211?=
 =?utf-8?B?K0xwYU5EMHpRZS9Pbk9EWkQ4a1RqYm85YUtxSk80a2QvL2p4ejFsVmpsT3Iy?=
 =?utf-8?B?bTJ0OStTRUFKemVrMGhpSFk1dFE5QjdlcVpyeTk0ZlVjSW5Md2FGaTMrR0Jr?=
 =?utf-8?B?QXZFR3M3RHlLRm9KeUN0NVd4dUErSnYySXFPYVEzbXRvbjdUdHlHWm56ek1i?=
 =?utf-8?B?a2t6WStKa1VkYmlLaXNoSUtKMllWa1BUdG13K1V1aVVQWUJNUUlIQ2RaMWtK?=
 =?utf-8?B?SEJoaHQ5WnpLV3pzZzF2TFZ4Zk4wU2dCK0FrRkt1aXJZalNTUkx4eU42dU9w?=
 =?utf-8?B?Wmp1SVo3U2phWTVueW4xemJKSkFiM0o3aWtjUWgwWDduOWtGVUc0dEdsU055?=
 =?utf-8?B?L01tN0xaM1dFWlhDUUFKeGRMWG5JZEtPeFM2SEtBVDFiY0RCdkVtUVh2aUtv?=
 =?utf-8?B?VUZLRUQxL0JKY2N1ZHZnemJ3MCtTRWczaTU4b1V1a3dwaTJpcU00QlhXVXlN?=
 =?utf-8?B?RkdvOCtmSXZ2OVVROU1rTlluTC9lMTkvb3BDWjVJdDFuODkvc0V3SmRyVXFi?=
 =?utf-8?B?WThwWVQvWUdWVUEwZG53T0ZUdWVYUlpFNHNyWm96am9CNnRjL1B5NWJxVGdY?=
 =?utf-8?B?T1d2R3JqazJoOHpGQ01vcC8vajRMbGVoVnlib0pjN21wUjVHdStuSzQvcThR?=
 =?utf-8?B?dDFvUmQxYkJZS2hxd0pGRFFqaFIraTZHMkNvMVpFM05IZS9CRnk1SWVmd3F6?=
 =?utf-8?B?aXFWbHVRdVp1SnlCTnNkQW9XZXhOL09FdHllSUQyVlZUSWZwaHNKQnlqS3BM?=
 =?utf-8?B?ZGJDZitVbW1UVnA1QlAxcGQzUDgwbUVLMnBKYjFrNFpPTGpOaGFvbk5EVTlB?=
 =?utf-8?B?d0J6VVk1TllNRHZSSFZGT3JGSFpYRnFqa0JZWTFpVXNYdGQ4L2VJUlhETUhF?=
 =?utf-8?B?Wk5WbWZPTE9tU2x4cVNJanlKNWc1b1JGU2JDdHI0U3cvUzNSYzhzTW5BRnlQ?=
 =?utf-8?B?ai8zWUZaU20rdVBBdUdXdTFPVkppQzBiUTdWS2RhYUozenBFMjljUkpzeVpN?=
 =?utf-8?B?b0IwMEJ3WkNYUWl3YnM4VXVDUUNTb3AvOFNsZ2NXNnQ5WVV4Uk1pQWtKN3Rq?=
 =?utf-8?Q?Groq/+QwA89AJnJ1NLLsB5oT8fJkazjkXC0+dfZ?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb153a7-0a2a-432b-c046-08d98fc8c891
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 10:44:37.2021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nioh6GYIR0HKsQVaNU0phSgQhxYU5JgsZKUGVXG1cPqcKzmQgiL2S7+prXpTjhPeMCJ2UbtCSUpWLYXnZq4ofEqyS4PrWMDg8jS2wc7LYJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3681
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.10.21 08:45, Shawn Guo wrote:
> On Thu, Sep 30, 2021 at 05:56:24PM +0200, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> In order to use ultra high speed modes (UHS) on the SD card slot, we
>> add matching pinctrls and fix the voltage switching for LDO5 of the
>> PMIC, by providing the SD_VSEL pin as GPIO to the PMIC driver.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>  .../dts/freescale/imx8mm-kontron-n801x-s.dts  | 28 ++++++++++++++++++-
>>  .../freescale/imx8mm-kontron-n801x-som.dtsi   |  2 ++
>>  2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
>> index d17abb515835..62ba3bd08a0c 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
>> @@ -189,8 +189,10 @@ usbnet: usbether@1 {
>>  };
>>  
>>  &usdhc2 {
>> -	pinctrl-names = "default";
>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>>  	pinctrl-0 = <&pinctrl_usdhc2>;
>> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
>> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
>>  	vmmc-supply = <&reg_vdd_3v3>;
>>  	vqmmc-supply = <&reg_nvcc_sd>;
>>  	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
>> @@ -319,4 +321,28 @@ MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
>>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>>  		>;
>>  	};
>> +
>> +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> 
> Did you run dtbs_check on it?

Thanks for the reminder. I ran the check now and will fix up the node
names in v2.

> 
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x194
>> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d4
>> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d4
>> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
>> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
>> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
>> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>> +		>;
>> +	};
>> +
>> +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
>> +		fsl,pins = <
>> +			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK			0x196
>> +			MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD			0x1d6
>> +			MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x1d6
>> +			MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
>> +			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
>> +			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
>> +			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>> +		>;
>> +	};
>>  };
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>> index d0456daefda8..03b3516abd64 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>> @@ -86,6 +86,7 @@ pca9450: pmic@25 {
>>  		pinctrl-0 = <&pinctrl_pmic>;
>>  		interrupt-parent = <&gpio1>;
>>  		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +		sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
>>  
>>  		regulators {
>>  			reg_vdd_soc: BUCK1 {
>> @@ -225,6 +226,7 @@ MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x400001c3
>>  	pinctrl_pmic: pmicgrp {
>>  		fsl,pins = <
>>  			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x141
>> +			MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4		0x141
>>  		>;
>>  	};
>>  
>> -- 
>> 2.33.0
>>
