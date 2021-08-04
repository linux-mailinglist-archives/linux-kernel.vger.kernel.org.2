Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE33E0845
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhHDSuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:50:09 -0400
Received: from mail-eopbgr150081.outbound.protection.outlook.com ([40.107.15.81]:45692
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239199AbhHDSuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:50:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPDTmwMOYuBV8s3I7y+ziKW+DMwFLoBOylNVS7zCsHDmnvL+/GPxh9/oqxLfcrF/mjt6cBymiPGjG7yCuki2q9xpgiM44TfQOxuszirrQvlqOiEKSYXnMl0tZ0oEoAtKpIzUIspxtNWaquNsjfh6hiGgVM0cTswz3XC2waPH+Aj7gHqPg7Y78OdBaqej8apr0VZ7dpbdY4ASsZXIEhnslF9JOCKIUOuQxxvS+yd12a0Ko34obnSTy0c0gPEX40J2KTm2eBummyNa9JzXcPb3Wpeg1GYNS7IVh25OJjhCMekgfbe+glEfvPDvBXVvj+99tQB8uifexV0a2X7XbQETcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVdVaa59cR50AwvJZaU+PhsaR4OOqpP4RWh3NTJ1p10=;
 b=ae8C2bHkdC4lVWImxVIkSqJ6n1/+uz04ryYC9Vq1zRIqfGiZRe8ryovSGOfEmvv+2JRjjZxapXuuGVC9dOjnQb2dTwUzgThU2h6wB1ej+MgnC9MgIcKbxD1yhxfhtSui+U/dqx6i0Q9haty897QE+AiEb3oAZsMBicQ7E6UJTmvS90XjbAB5G0+BbhnNJQe6ChO17ElsMgBIuNtE4DC2eQe0IP2Lc+1GQWz5fUp2GxdLxaj+V/8lP6sqGJ8Wl6C7x8Nd1s5mBIuRGdVpFfmUtfQWYn21Mr9AmO7/j4CWTs1QFTXYdhHlmAQz3RrT5TqK7bger3JDcIgLGFfYQqX1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVdVaa59cR50AwvJZaU+PhsaR4OOqpP4RWh3NTJ1p10=;
 b=qMsq+ocqF6uu+VXabJ/sFNqpgZREYF+56zQOPhkLNoY/Avl8oVZDA4LF8/E0o3ZTc5TNv2pMRfEBf3LQaloRu9d29StvcTLRUYlP53BIAaP+XAaA4fnTnvYTjIZKx8SFpzctl8H7T8S210E6ldpuM/0tX/lfrF9ni4snfqEHsGw=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB7PR08MB3547.eurprd08.prod.outlook.com (2603:10a6:10:4f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 4 Aug
 2021 18:49:48 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 18:49:48 +0000
Subject: Re: [PATCH v2 7/7] arm64: dts: rockchip: rk3568-evb1-v10: add node
 for sd card
To:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Simon Xue <xxm@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>
References: <20210804130625.15449-1-michael.riesch@wolfvision.net>
 <20210804130625.15449-8-michael.riesch@wolfvision.net>
 <aa16ee55-e1de-adc8-51f0-8ceed136b911@gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
Message-ID: <68c6c548-ff07-da79-f75c-afb6a9846932@wolfvision.net>
Date:   Wed, 4 Aug 2021 20:49:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <aa16ee55-e1de-adc8-51f0-8ceed136b911@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::21) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a05:1141:1c9:7c00:ad8b:c078:f634:d22a] (2a05:1141:1c9:7c00:ad8b:c078:f634:d22a) by ZR0P278CA0034.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 18:49:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 681d99fd-524f-46b8-1fcc-08d95778a25f
X-MS-TrafficTypeDiagnostic: DB7PR08MB3547:
X-Microsoft-Antispam-PRVS: <DB7PR08MB35472ED9D4CF086710F5DDA7F2F19@DB7PR08MB3547.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rg/PU/vDuOGwCvgjnQD3/UfzVLL660FdiH3/PwSJYLEj9oReXGbejSxLANU6ahWtLjOy5/PwRGVFZu2KonxCqM87824IeofT6mONnNJNAnJgvoDjdKIW2gDaLfdfUR7Rtkgfm85Xw2SrpNR2j2JnlsBRfGb4FNlnihThvGwBHjHQWeDT1bGH9mopgO3StMPhXgOyiWgEpq7wiGUi+mzXmd7X+6m7qLLHIiyPuMtPfn25dRFAmdxwjjdhHJlwC7X3SWU5EHPBFMh/OypR1febI0H+UJtwLdHPKGW+w+JGHtkoGLtb7G64HNC8NccKD14ZNvr74F0imDqo3tMgYwUaxJZbVY4+jcPcx83AG3OdrZKqiDFvWzqTaa2P32w++FzLCbyVCM/SMUrKqYjh+NZCZRHbJt7IEn+fq2GnIIC6/qfAHKqUuP8EZl4njDsRx5a9mzevFXDG0rSHDwX+AHZO+2udXEANYrkHUG6i6yc76niaJjsO3qtCbgTDN2LPYOM3BbTxtlyuyuEYwzaXrNuWoT5NVqM8jtLkkfLuntTAUQE/uiM3FALFI1KuyUtgfjZ2KViBS9u5KHDIPv/i8kfo8EKtFLG754CaSkmjv7jftUndHttTwIxgCi+LMid39+PvCfmsmYeWglmvQOZbe1wTric7UjesnVJLe2P2mzISe80bOke6JlwXt+n8CHOCtgIpJ3NpPjbROzyL77PlUGQj4xDwO1Bv7jZqTGdc2mkMKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39830400003)(396003)(376002)(4326008)(478600001)(316002)(83380400001)(2906002)(52116002)(36916002)(54906003)(186003)(53546011)(8936002)(86362001)(38100700002)(36756003)(44832011)(66476007)(2616005)(66946007)(31686004)(66556008)(31696002)(8676002)(5660300002)(6486002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d29RcktzNXNDbnJJSW1ZM1JvSmxSeVNxeVVzYjZ3Q3cwWjB1Z1BSODlza3Ur?=
 =?utf-8?B?NWFTeTl6emdld2VBdFFaNmdMS2kzcy9uTVNXc0tZbDZPV0lSVXhtdDc3QmQ0?=
 =?utf-8?B?WWNHbUhpZXFUMDBvNnd6cm5qUC9aVVU2cjFPZm56SEJ0b3paeDRZWVV6Z0sv?=
 =?utf-8?B?NkhyUVNwWHU5MWJ3TzFLYmRCa3Awdkw2RjBJSW9Yb1BPazNrNGZFU09kclBC?=
 =?utf-8?B?QlF1akU0Rzk0eitudERSMW4zYUR1T2NGMXBVK1NVS0VCaDI3UC9PZlA0THRs?=
 =?utf-8?B?NXR4VWtoOEwvbVBaZGx4T1BSZzhzLzFvR1lmeDZDejRJdWRXdktrcWloWlNP?=
 =?utf-8?B?K3l2NUpPeXoxNEd6YzJJUUNwM0wyY1FrK1FCWTFDaHFKa0JyL0FUR0dlRkFa?=
 =?utf-8?B?anp3TW1Ld2pJYWtRS0pDcklVY0hDeWdnMit4bDN4U0RFa0J2eENZSGtNSkRS?=
 =?utf-8?B?WElwK1lVV3VidjMzWEZUd0hTazBkMDdaalp2K1JUS1ViUWZ3aDQ1eEJJeCtQ?=
 =?utf-8?B?b3F6TWNLT0V5S1BBUldvVXBzSkdaeGVVa0hJR0NNdUR5QU9MNlBJTUJweGpI?=
 =?utf-8?B?blhURHRxOXFreXZlQXRVWmdHdVpRMVcyVXhUSXVyUFdMbzZXQUZyOFJ0Q3dX?=
 =?utf-8?B?UUZrK2g4ZzRyay9ZTnhBMnUvbTBQaEhrR0tEY1lJdlhaRGd2bjJVbzlQbEJy?=
 =?utf-8?B?dmpiR0xScUtQVzhZNXJQQzJxMzUrWitoMXhHQm9BSzF4NVlPMlZzaDlMK1ZP?=
 =?utf-8?B?cSthQVdPUWl3VGdIQVh0blQ3aC9BSG1GZkMvRFlJMzkzYXBxQlo0dW5IVTZU?=
 =?utf-8?B?UWxleVp5M0xRMzBJWWF1aDIxS3I4UTRaQUJzMVRTRmw0VjZhcWZPa09aakJ6?=
 =?utf-8?B?ZGc0T3RBcFhmUnVHQlE0MzB2WXJLT1ZSdjJKd1dvQzdhU3ZiQmVBblJhazYv?=
 =?utf-8?B?QmNvYmRUaEZuVExlZlo0b2hOYyt1VVBRWExReWFHUjZZeEphbzQxWTV2Ty90?=
 =?utf-8?B?eEZxVVo5TjliTUNvb3AvNFdOL1ZKNUlLN09XdkFQZmxDeHppMlVCZzE4b0x1?=
 =?utf-8?B?bWdUZ2RQQzVhMzVLdGRsZHF3Wmt4Q2hlanBEZ2dvZHpBRUZTQ3g5QWd3ckQ2?=
 =?utf-8?B?QlVXS21XYUZEM2Z0VGlpU3gxalRDbk0yc3czbHVLcnVzbk9qUC9leVhBQjZv?=
 =?utf-8?B?Wjh2WHpHVzZsa1JvREdHVTQwcE91VjdFZFMweWVoeHVrc0lnRVBOSHRRSFpO?=
 =?utf-8?B?MWVaOFJwS2h4OEd5S2QxdlFUV01zS0JkWDh3OUMxRmhPOGFOQjRubDM5NDJP?=
 =?utf-8?B?TjFPS20vdFlXKytPVnJBczg1UTE1Nm1kbFhOaXM2cC9uR09FR2tINFdqZXEv?=
 =?utf-8?B?eG9CRlVMNm9JVzRBenRja3N2LzdFYWJOZmFjM1dKbWJPT2t3eG9PcGs4SWxF?=
 =?utf-8?B?Szh2SFBCd2YxV29Vd2oxVlRCMVhHLzRpUWNwRDBwT0VaS0pkUno0UzJSbGxB?=
 =?utf-8?B?QndEcnFoa0RBVTBDU3FoM1dYaXgwaFE2Qkdxblowakh1dFVXWmdpNUxRaVB0?=
 =?utf-8?B?dzRvTGdsOE1sdnhtazU0K1U0SHdNV2ZRSlJCcHJyZG1lNUJXTXU3eHEzbjlR?=
 =?utf-8?B?RkFYM3F0OS9XdlRwcFEvNEFFTHJYUHVGd1haUkxwV0FWNGJqV0hGeTlGeEtL?=
 =?utf-8?B?UHNUSkFsc0tnN2ptR1RVWm9DUUFXRndqa0hqcDk2aUswVHpqQWJRMmNjbHdF?=
 =?utf-8?B?OWlnVlQ1azZkelY2Nll2SFBFWEVIQzRib0dTNGlsMHJPM1FudEdRaEJFTjRC?=
 =?utf-8?B?WVZXR2tVTmRtUW9zZEpjeW94dzl4T3lBVGhxb0lzUFM4NHAwQXRzUXZGMm8v?=
 =?utf-8?Q?8HHtLkXpIQI7F?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 681d99fd-524f-46b8-1fcc-08d95778a25f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 18:49:48.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNHSe9G0d71GNXNO1UAeurtji8WBzKLftbmKcfW6CQEhkZ86PzfgaUhWoaj7ULdoE15ztRDnQzqcnDyZVektiELy3XIf6QK6Lals7BJPUic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3547
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Thanks for your comments, I'll try to implement the requested changes
and prepare a v3 tomorrow.

On 8/4/21 4:30 PM, Johan Jonker wrote:
> Hi Michael,
> 
> Could you add a commit message to all patches in this serie?

Well the short commit message (i.e., the subject line) pretty much wraps
it all up in my opinion, hence no need for an extended commit message.
Is there anything in particular you would like to see or have explained
that requires an extended message? I would like to refrain from adding
an extended commit message just for the sake of having one.

> On 8/4/21 3:06 PM, Michael Riesch wrote:
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>> v2:
>> - rename alias to match convention
>>
>>  arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
>> index ed96f27c64a3..c4da6436059d 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
>> @@ -17,6 +17,7 @@
>>  		ethernet0 = &gmac0;
>>  		ethernet1 = &gmac1;
> 
>>  		mmc0 = &sdhci;
>> +		mmc1 = &sdmmc0;
> 
> mmc aliases are sort on reg address based on availability without number
> gap.
> 
> 	sdmmc0: mmc@fe2b0000 {}
> 	sdhci: mmc@fe310000 {}

I'll turn these around.

>>  	};
>>  
>>  	chosen: chosen {
>> @@ -353,6 +354,20 @@
>>  	status = "okay";
>>  };
>>  
>> +&sdmmc0 {
>> +	bus-width = <4>;
>> +	cap-sd-highspeed;
>> +	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
>> +	disable-wp;
> 
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> 
> pinctrl-names below pinctrl-0 like the rest of rk356x.dtsi

OK!

>> +	sd-uhs-sdr104;
> 
>> +	supports-sd;
> 
> Check mmc-controller.yaml, rockchip-dw-mshc.yaml and
> synopsys-dw-mshc-common.yaml for properties.

I am afraid I don't quite follow. What exactly should I check? I am
pretty sure that the properties I used are described in the mentioned
yaml files.

Regards, Michael

> 
>> +	vmmc-supply = <&vcc3v3_sd>;
>> +	vqmmc-supply = <&vccio_sd>;
>> +	status = "okay";
>> +};
>> +
>>  &uart2 {
>>  	status = "okay";
>>  };
>>
