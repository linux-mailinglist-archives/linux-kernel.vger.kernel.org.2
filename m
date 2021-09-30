Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6741DE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348055AbhI3QDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 12:03:50 -0400
Received: from mail-db8eur05on2103.outbound.protection.outlook.com ([40.107.20.103]:20800
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347450AbhI3QDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:03:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbfYbW2lu5NFZwiOncKlwNtNwArgR2OBHHmhVQLVeN/mW02wfIew4t9l0KXSvNAz6VJduvYURcWEpZ1bTCLnfV10uufJuR32XVZ+9AZxW5Kr5etyTFzQ4sFeALZSBHHh26s492p7G8diFTJ7e8v1b1u4iM5TWsNQEhj+hJxxXUQkHbrMwX31M71nV/fCDv3E9lXRRE58eI6iqOxBXhZ9Zxz0rDdwIcZ9v6dQhEz0fBnc80OpQu7NtD1t6Uq5PmQDGrzNGBrZHwFU2tNRVspve9GL40Qs0Prn/d3wBHXz3pp7Q+WFxLeWjzsJJhs9K2rJHrxAiIZ6lZlOqRhMwquT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pPNarhp36+OMEPW7e1ZU+UZuqhaKaMABHJFLqEKthFg=;
 b=MiHQBZcgs08zUN/7H8crncvNsIap+d0MZ/IxG0Z45zqZYeseT6Ve/meHmvEmzjlaowUAEDo+pzM7f38euePw1sn/TVOV2NXM7AufRn4b1W1xaZ19JTQrudOmbrWnpL6qXRhoF0zKSoCVfafy5t4nU4b21SSf5RD1wFIw5BXE7TpOnT1WOd49lbIcZVisxKGLxNSVNu3v4YNUG/rD6PmHR9sCZ3oZd2j9X0+RHI1/8dbja3wxO0zyRJpwTH8a/eOtRZtFM1Z+9uQYz3Lg9wq9uzIfiZTZS6o1i84JRJvUhFpj6cKnyWnG2t6QWQZ5SNyZp8KvBw0CC1vD+heH9B1MOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPNarhp36+OMEPW7e1ZU+UZuqhaKaMABHJFLqEKthFg=;
 b=liCIV9tNmgx4Dgrg5vEu4C/mAvPA37HCELhsFRato0+dlY3Z2iOO7Cq4Vr6ykok39hbNjeZJZuDraxI9oH22mLmtrs4TfQWGiVF+3B9mB5vL8OgXp/q9VNCBf1b+2IMsvtSYwoGZVHfFadkqKDcmiXmNO8KRIi8S5rHaqw/ScV4=
Authentication-Results: fris.de; dkim=none (message not signed)
 header.d=none;fris.de; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB2771.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:131::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 16:02:03 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::216b:62be:3272:2560]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::216b:62be:3272:2560%6]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 16:02:03 +0000
Message-ID: <bf6ab1b2-664c-1d1d-18b9-71ced9fbb518@kontron.de>
Date:   Thu, 30 Sep 2021 18:02:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 2/8] arm64: dts: imx8mm-kontron: Make sure SOC and DRAM
 supply voltages are correct
Content-Language: en-US
To:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20210930155633.2745201-1-frieder@fris.de>
 <20210930155633.2745201-3-frieder@fris.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20210930155633.2745201-3-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0139.eurprd05.prod.outlook.com
 (2603:10a6:207:3::17) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
Received: from [192.168.10.40] (89.247.44.207) by AM3PR05CA0139.eurprd05.prod.outlook.com (2603:10a6:207:3::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend Transport; Thu, 30 Sep 2021 16:02:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a051a35-580d-4408-e240-08d9842ba4fc
X-MS-TrafficTypeDiagnostic: AM0PR10MB2771:
X-Microsoft-Antispam-PRVS: <AM0PR10MB2771679D35006F3344300B63E9AA9@AM0PR10MB2771.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+HJPfEQumAk0AAhjRr86mCCKNK3Vee0mOTNzbDrQ/Ve8tOjDpizWooJB2qqi2AFlhQmjkVST0itZLD4venlsBuJKAChIMWkoXR2PPG9t/QVz65P6aHrn3u4DisCTZoiWTRSQFfDv2rCuHNRe81CwzcuGR6ZOIjl+mtRvvIFoYkoto5tP3IuGizENDfWPz1jzve/vzQJ5YY54xP5FfCIruwoOctXk+Pv4LwHZ64z/HgUR9zydoB0+xKSjMyylfrsidM8dwolW2laU6e5SSGByGZctWZoZU1opeZi3V+Rq32YrBeTF1mxVJYy7XvuglHBO25Mae1NT4UKSD3lvqCdsjpcw6gsVe5n3csuFp6Z2jdLtqAZeiCs0tkr1Ew7rpDZoI1y9UD3Q3xHDPcdypqhFI+coYzGtKf2QbxuudC1YRra0kldXZ/XNS2qy+39BE2NVx5t51Zkw6RYJCZ9N5zbWQ2BEcN1VjnH5iOVdwhgSA5GVJy8Bm6pgXmZE8NwjdROT44BPmw5l6t3gDsmZO4TIJXFVI3AmQrN0MLgWjNzh+RNJimvcLiCgg0OTaK0GYNg0BIV2G0MtzbgH8j1vYTi2K+ZRJIFCq4sIgL09raZZEP8KN6qqo8zO0C50g9k+fF38/Ih0fa4x4gBF7G1KNxHX4m9ggh0CYlMTY7zyySHbikLSUbjKpLRcwOB8BNKT+fk2YZbYHbRrPsbPYnGhUBZPrXQ+UNVkhCSofU7bgmROcugot9eKAfBiOrETxbspoMnQQ3mRlykkh3RxsMR+qTjGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(38100700002)(36756003)(6486002)(508600001)(2616005)(44832011)(86362001)(31696002)(83380400001)(7416002)(5660300002)(110136005)(31686004)(66946007)(54906003)(16576012)(8676002)(8936002)(4326008)(316002)(186003)(66556008)(66476007)(26005)(53546011)(2906002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFl5WEswY0wrVFpLV0NwUzA3QUJucSt0UG1FT3EyWXlSYXJ1VmJFam5EZTBu?=
 =?utf-8?B?UU43UUVNQWlyUlc3aTVEc1F0R3FLV2VuS1UvVEd5c3ZZZXJ0QmJvdGlFcFpF?=
 =?utf-8?B?MzVsYnBMOEhPV0thcVExeTQyQ0RsN3pPcHVyUVF5anBTdjdmeU5Sd0dVZm1X?=
 =?utf-8?B?VnJxblZtWW0zbm0yb1ZnbG81cmJ3Y2ZtUUo3VG9VdzVSU1gvVXdGaUl0L2ZN?=
 =?utf-8?B?azhGWEFOVk9sOC8xMkFHZ1dCS1pMcEc1YlE0Q2M1RURlSkF4c2dWUGZ5c1pD?=
 =?utf-8?B?dldqcGZwQXhZTUNrSUp2WWxmU2UzblI1OGEwTHFPMS9MbXdlVVMvdjkxQXBu?=
 =?utf-8?B?ZzNxQ0dSa1Noc2t3RlRvSXdNM1N3Y016WUNRNTJsTVlzRWxMM3puTmFBRGVm?=
 =?utf-8?B?dUJuL0oxOStBanR1bHBDdlZmcG1jSWxtWEE1Q015V0t4L3BLSDZCa1VNWDNj?=
 =?utf-8?B?Vi9wVGtQY0JhNkY0RVlPSWtHbGVKTlBCQVpBcko0ZUJqTXNLWS9PakJxcFVh?=
 =?utf-8?B?SHpPQ2F6TURDRTkybndEUnpkRy9kU01CcmtoMGtjN2xKaDB1ckYzenI0ZlNh?=
 =?utf-8?B?VUtBNEdibkJrU3hZckV3b2NoUm4wODRoeGFnZXhNY1Y1dk1wejFkbjdCbzlH?=
 =?utf-8?B?cUxlUG9zVW5WcEUzR3Zhblk2Q29lSTdxM2Z6ODFwbTVCZlRHbDRjU3dzd05u?=
 =?utf-8?B?TlIxK0Qxc29RV3J5RmdXdHYvZXFtN25TdFlJZ1hRemQwUW95SmJnUmNtVnUv?=
 =?utf-8?B?Ymc4WnZmWHE4N0FVS2NzQ1FoeWVZQ0NaeVpudHZZSVF0RzZ6ZnNlZzdJZWsz?=
 =?utf-8?B?VWFrbDdEQTJsWkIrZForbGsrRURabDZHYXNKWE5PTzFNdGtLd3FnbVZ6dCtr?=
 =?utf-8?B?WWhIbXA3L1hyUEUwNDV0akpNZ1B6aGpBWklHRVFZMjdLR094MzZ0YjRpQ1hM?=
 =?utf-8?B?Y1lpT1ZMSFdpRXJ5L1Y2QWhYNTJncjIvNlpkQ2NPbFdFUmd3dkFVc3VUWnNH?=
 =?utf-8?B?QXhRMy9HblBVS0VRWFExNldDUFpZYUp4dXczTktxVitaRDZSTStEejVyMjUx?=
 =?utf-8?B?U0l4NVdSMG9lY0xBb2grV2o3eVZoMmtKbXJlblcwSkNsUzZVcG4xMk9Lc1o4?=
 =?utf-8?B?NzFFMUpNNGdOcytkTzJKKzlJaGxwMVNvODhHTGltRHpCUi9yU3h3OEpRV1dI?=
 =?utf-8?B?NXFMVlM2dDRlQVhobnJNaHFJL1U5cDZwc3NSTEJmSWh4bjRWVi9GK3MvckRp?=
 =?utf-8?B?S21STGJMWUtKNVArOUJ5VTZwT1hIM1hUNGMrd3hmYkYvOVFKRGZxbHdJZmJi?=
 =?utf-8?B?UGc0OXdDVlk3OGlZNjJwNHhQZm5jWlBRT3Y1S3hNOUR1d2wvVDF4QjU2SkNj?=
 =?utf-8?B?VDlXNmFUZGVWb0pxMjA1TGRxOWs1cG5ldkVDSHhDRC9GdE9XdEZyOS9uWmZl?=
 =?utf-8?B?R29sRVpOOFB3Z1hTVzZweXBTcXQxOTBMOVZPWXhDUnlHM0luMGZRR2x3S2Jh?=
 =?utf-8?B?Y05odUppTU9GenFVeUFNelFJMm05SWxBY3l0TkdiSDZrNlEyLzRsS3M4eUxx?=
 =?utf-8?B?aGtxSUtEK2FkVGZwOUxKc0xsU09HbkkxTjZoclpXeHkxNVMyTzNlendGa09P?=
 =?utf-8?B?UUVqM0VoY2ZKL0xUUnVoZDZrM1hncUgrWllXR2Z6Zll6eWpRdWExKzg0Q3di?=
 =?utf-8?B?NW5yTjdscUd6UFVzMkNiTWxCajR0ekpZbWJjQ2hvTjR6KzU1SG5UWEJ4OFRa?=
 =?utf-8?Q?ak3mh4kOMS/ECaqtI//RLeJZJAYhdqFWPiTbfAD?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a051a35-580d-4408-e240-08d9842ba4fc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 16:02:03.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRau9av+sfv70OHyW07JSAd8ZtiH85YFzUhdOkkFSfdWpze+Uo94saVlawRdMUsMAvMLOZzV1+oBNxemg4jrr+WC03xUghXGHFSVUuN3Ru4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2771
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.09.21 17:56, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> VDD_SOC should be 800 mV in suspend and 850 mV in run mode. VDD_DRAM
> should be 950 mV for DDR clock frequencies of 1.5 GHz.
> 
> This information is taken from the datasheet and the uboot-imx code.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

This should also have:

Fixes: 21c4f45b335f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and
baseboards")
Cc: stable@vger.kernel.org

> ---
>  arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> index 03b3516abd64..b12fb7ce6686 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> @@ -92,10 +92,12 @@ regulators {
>  			reg_vdd_soc: BUCK1 {
>  				regulator-name = "buck1";
>  				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <900000>;
> +				regulator-max-microvolt = <850000>;
>  				regulator-boot-on;
>  				regulator-always-on;
>  				regulator-ramp-delay = <3125>;
> +				nxp,dvs-run-voltage = <850000>;
> +				nxp,dvs-standby-voltage = <800000>;
>  			};
>  
>  			reg_vdd_arm: BUCK2 {
> @@ -111,7 +113,7 @@ reg_vdd_arm: BUCK2 {
>  			reg_vdd_dram: BUCK3 {
>  				regulator-name = "buck3";
>  				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <900000>;
> +				regulator-max-microvolt = <950000>;
>  				regulator-boot-on;
>  				regulator-always-on;
>  			};
> 
