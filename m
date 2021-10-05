Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAE142276A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhJENMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:12:10 -0400
Received: from mail-eopbgr00102.outbound.protection.outlook.com ([40.107.0.102]:2446
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234860AbhJENMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:12:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pcnw20MJEPcJb7jZ4LkXSbt6BqmMVNWJD9IJ1880hd9jZakF2aiKOzun4skz9EO1KbZiK56T8y7f/EurQVeDw5SX2u/22Zwdx0Xtwe9pAmoUxGqg25C6je6p++rMfEqJDfPJI1/t3hYJiJURdLrxnmOsrH0fI4X7eC8xwyUD4/5RLdthEtB/5Yu9ZKn62udz9qnNmcDgUsFuvtnURY4+wKNoUxs8SH9nC2ogzlSXZpeCp3yqA41tB8u3AZWf/s51AAJj/XMv1g1tXyS8bhm/QqKhn+QhjBIPvfdllu4URquczpgslw4+zkk8N43ivcxBSBpIlWsTFBhlDRK1yQmOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzmpBORJ7hR/UXODmfQUi8hZ2xOM1R4Ol3CJ3rTmywY=;
 b=iSVqY8jBZNkUckVvvT8D8SLzcY9g7wsZECl02k8bR8/UEMzJxxABh8EYEdbtk4Ebla3AGBjzwoU/hGh+uzPpfEQiJFrjtJfJgbiRiYSluklSO+pqiUjGX+kbgmEjXSpsSfmV1vHPIqlIiCy2WZkfGe3llbsT6HxKaToHgJUVriLKwgVfKLiUojl5d3OZpZ59v12Jw9qH754cZKrTlj2UP8LgtZon0SWaeUlZLhDAuk6eg2cwmbPefN2orjinMbTsZc/CtmBoXvEpISiYT8dPDAs4JhfwCczJQvRGA/Nw75ScTKPkuSHHqEmH9sN9WFzj0ILlulemeuK5kvcT5y1dmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzmpBORJ7hR/UXODmfQUi8hZ2xOM1R4Ol3CJ3rTmywY=;
 b=MP1UfK5Fp6h7NjI4cMVwmhB2Q30f4b5R6QTJmLEGxcm1j3OADfvHETs1XR3hLHPNtEgcjaHRryxEG9354Qj6ABVLnFeC9YKR9fIqg+HYw6CWX2B2REPHezAmjlDJ1noS8jXahUPACXRLHA+fMXoevV1jE+bV4SrGPytRTdrqY3Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB4625.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:356::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 13:10:17 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::216b:62be:3272:2560]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::216b:62be:3272:2560%6]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 13:10:17 +0000
Message-ID: <cefc9a67-120e-fda6-cb69-af4cabc58a15@kontron.de>
Date:   Tue, 5 Oct 2021 15:10:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 2/8] arm64: dts: imx8mm-kontron: Make sure SOC and DRAM
 supply voltages are correct
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
 <20210930155633.2745201-3-frieder@fris.de> <20211005065358.GZ20743@dragon>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20211005065358.GZ20743@dragon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0164.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::15) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
Received: from [192.168.10.40] (88.130.78.70) by AS9PR06CA0164.eurprd06.prod.outlook.com (2603:10a6:20b:45c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Tue, 5 Oct 2021 13:10:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dd56d0b-0409-41bf-7121-08d9880179c0
X-MS-TrafficTypeDiagnostic: AM8PR10MB4625:
X-Microsoft-Antispam-PRVS: <AM8PR10MB46253C95DFF2B37AB3547710E9AF9@AM8PR10MB4625.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCk7Gaxb4cLNZPCSZzW0EpxT3fEfQ3W5Rnd9uKQq7/BrrNZgfAsnrDxGefeXJ7GXbvrVwv2Ftwlrpj7M2jZihMZyyrQyJUhTntsP732YDmQRWJ5UqqLbFVqq/Ok/pjLvd31/B7Z+c4RC0X8AxQ0yPeiIK1LHyRmT2dlhhGxJk2JS7gvwXqEvSLepZaKD4GjflvJDWQ4dES6K8RaY6nU5KqQmuU3DfYllwYhSVMKZ5dC9MqsoHKJ7okEkzaMoRwVtn82LWVqfj4VUN4q6BY35VA0Krd/Kg2SgRtKl9sQtqevytNFWsBvYtmTzyAJv6/j5QX/Z3+eXx8EQvRNVL0k9237KtU0s5wkz5YqavX/VuE5U/G0m75UadVyjUpFqJbcmUZh7TP2eHJ7YHSTp8b/WxmCklSv6FxzX9S/Ux/qmTXRRcGgNGALBkxFsSipah5kfAh6LOOQ0SlIC9o5KXIxpAU1pdGbI7fR8jIchE7pGL51EOp2RYcVqsNi/EVNmnfLtz/ZlwR2tbNsN4EbTBTbOimYU9GEti/xUcXRhwTBajC7MI506M7qOh54U9oNNAmMm1I01LV0dnwod/ZwUrXefcgn139JB30zbgSoYHoYMP6hhxMw+VYCjAodz/lpB0OMoyp+3yXQV3TRRuzXivcWhySeilvCBYac4+Lqt+hiQpyGppA9UccbPuKqP0xb6E0QmxBS8Cnt8B4/pO1r9Fo/DwDSxTn62KDuvH0amY+xrzS9yy30pj+nT5ZCsWvk71LVD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(7416002)(956004)(83380400001)(66946007)(66556008)(38100700002)(44832011)(4326008)(66476007)(2616005)(26005)(5660300002)(86362001)(53546011)(508600001)(2906002)(8676002)(36756003)(8936002)(316002)(31696002)(6486002)(54906003)(110136005)(16576012)(31686004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mks5Y1M2N2Q0bnpxLzBFd2ZsUnI3SS9WbThIUHBvS2NSdnQ1MmpYaTMvaU1j?=
 =?utf-8?B?L2I2N3dIMUV0SXBRbUFNeVFBUFl6Q2NvUUl2K2h1UDdBSzFadHlicnNxSllD?=
 =?utf-8?B?ODFVd0pnQVFOc0xTNUNBTm9UMENFenBQN2s5dEdSQjJnc1dvMEpNSFBIV0E4?=
 =?utf-8?B?dFV5YU9ERHZTRkxhcEJ5SkJyYi9wUVM4VERMckxMcE11RENMd2hiZm9WOHMx?=
 =?utf-8?B?UHNFRGZ0VCtxTWFld2U0UXBnMHlpQ2Q2R3NvUmk0Wk9FTldpdk04R1BFWjZi?=
 =?utf-8?B?U1RpWHhQeW1CK293NS9EQzExNnN2amtwMzNJbFNWRUU5K3QxZnJLMkNzL3Yy?=
 =?utf-8?B?Z2RoeE01aEtuNmFYY0hiYkgrRkpzLzJQUnJUWnZTcExLaUJyS0tTbWlPSGRD?=
 =?utf-8?B?dTVwd29KQTE2S21rNUNMd0x3OG9EMUJyUGVmSDFiUUQ0UWNZeG1ZdlB4SXA1?=
 =?utf-8?B?Z01jMndyL2dsQ3pUTzJ3V3UzYjZUWFlDMUg3bEZVS3VGRmFzN3lWRDRUb0Iv?=
 =?utf-8?B?eFcwTnFHcTVWa1Zsc1ZOL1c4R0JmUGM1MHNKaVYrL1MwL2ZBbHg1ZUliK3JL?=
 =?utf-8?B?VUZXbnVqeHVZd0I5cmQvRE4vdlh2SXJ0YXRpQ05QMlJiYjRMeWZwRDhFTGp5?=
 =?utf-8?B?N0ZGb3YzQnNlWjlXUDdEaU8rcnUxRzQwVWpUeE1CdXVxT0ZTWlNRbnluQ2xY?=
 =?utf-8?B?aTRxT1NreTVYR1hXa1QxTVRFVUg2S044ZWEvUTVXOTNCRjRTK0dNeVIwQnlF?=
 =?utf-8?B?Z3pMMFVpeHNWTDNkVHVUMkRoMGdDSDIwYTh4UVo5ZTc0UWJTdUZYWUgzOUNp?=
 =?utf-8?B?SXF4dGxyb3ZRMHlVZFcwOGF6S3ZaeG4yV1NBVEpsSjd5ZDNCZTF5UG1rRk1K?=
 =?utf-8?B?K1NDVUxCN2FXVFVwaDh6QTBwSEpjT0hnVnd1bWh4a1U3NUFueWRBc1ExeHQ1?=
 =?utf-8?B?Z0s4Zkg5c0tEYjQ1RitVK1hFbkE5alhYM0ZxbGJXaEFYTGEwVnAxQWJCZ3Vz?=
 =?utf-8?B?VHNUNnBaM1lUaTdIYWwzdldtRC84QXluR1ZHS0tIVkRTZmRlNnM5bUdRb3Zk?=
 =?utf-8?B?Q0VBRTZZVElMQ3lwblREVzY3Y1JKYkJ0MFBNZC93SzJlaldZM3NtRkI0aDBD?=
 =?utf-8?B?QlFiNFRUQjBBTmlJaGdlL2s2UFhyeG1GVnFSWmF0T1dOTmNxczhkczNkTUhl?=
 =?utf-8?B?djFrVGZhaGhQYXJpMFRoellySGVCR2dVbHQ0UHU0THZNdFhNSkp5eFpnVTdS?=
 =?utf-8?B?amJibFpJc1MrcjRDYWhrcDdlMHJLS1h6N1A4bU1lVUVRaU5OYWtZTjJpQ1B1?=
 =?utf-8?B?SEhLMzV0U1NaYS9JTlFPYzdEckpHNGJabGROZkpjcWtqSFRHeVpQZHNaMGJy?=
 =?utf-8?B?TzhYUk1FMERiS1FKQ28yWURBNmZBdThmMmZlOW5qTXMrZkpzcGZzbU1YcStQ?=
 =?utf-8?B?dDJPa09oclpKMHIrZ2gvYlkvd3Z4ZnRJbVg0VGFRb2tiZjNhSXZ2eHlNRGcx?=
 =?utf-8?B?WkMvUFBPWHp1OFdxWUhTVy8zaG9EVmkwUjAySDZPamVDdDNRZm5tbkZwZjFT?=
 =?utf-8?B?SGNsU01mamdIWlFtS0ZXRjFNeFoyUkNUS1ZsK0ZjRGNjSVI5RHYzQ0JYS1p2?=
 =?utf-8?B?YVduVHdEZVJHZ2xJaEJmRnhwMjNtSHREM0NoTlBVSFlKcjg2TFVkaEFYcTdT?=
 =?utf-8?B?ajNJbHJGbnB4N1c2dW8vN29iNGpLSHN5cjNwZWlxYitiSFRtejFwWDd0ZlJr?=
 =?utf-8?Q?ZrCybKQzgdj/KFzLByyZMXJj0jxD+Vm+89qVfPP?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd56d0b-0409-41bf-7121-08d9880179c0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 13:10:17.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKPvxi4AejtwRW/2SBd4S2UcauaqXNiTYCjMxPUy4srEYP/rJsZ14oYzSK+Jg2GYDGeFLvhCjV2akiNuFsRrLhazVNmaS6R9lJvF1znX+sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4625
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.10.21 08:53, Shawn Guo wrote:
> On Thu, Sep 30, 2021 at 05:56:25PM +0200, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> VDD_SOC should be 800 mV in suspend and 850 mV in run mode. VDD_DRAM
>> should be 950 mV for DDR clock frequencies of 1.5 GHz.
>>
>> This information is taken from the datasheet and the uboot-imx code.
> 
> I'm wondering where the existing settings were coming from?

Good question, but I can't really retrace now how I actually determined
the values back then. Seems like I had failed to validate them properly.

> 
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>> index 03b3516abd64..b12fb7ce6686 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>> @@ -92,10 +92,12 @@ regulators {
>>  			reg_vdd_soc: BUCK1 {
>>  				regulator-name = "buck1";
>>  				regulator-min-microvolt = <800000>;
>> -				regulator-max-microvolt = <900000>;
>> +				regulator-max-microvolt = <850000>;
>>  				regulator-boot-on;
>>  				regulator-always-on;
>>  				regulator-ramp-delay = <3125>;
>> +				nxp,dvs-run-voltage = <850000>;
>> +				nxp,dvs-standby-voltage = <800000>;
>>  			};
>>  
>>  			reg_vdd_arm: BUCK2 {
>> @@ -111,7 +113,7 @@ reg_vdd_arm: BUCK2 {
>>  			reg_vdd_dram: BUCK3 {
>>  				regulator-name = "buck3";
>>  				regulator-min-microvolt = <850000>;
>> -				regulator-max-microvolt = <900000>;
>> +				regulator-max-microvolt = <950000>;
>>  				regulator-boot-on;
>>  				regulator-always-on;
>>  			};
>> -- 
>> 2.33.0
>>
