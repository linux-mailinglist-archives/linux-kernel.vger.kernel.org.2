Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2CF3DFED5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 12:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbhHDKDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 06:03:50 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:37637
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236909AbhHDKDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 06:03:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcYZaxYKDxO6EQDvlRYGRpLkZumwkMXnvQqfFusEtRchfFRzYWV92BQbCAwsbAbkeSVT0NEKJWasE91Wsg9nj0t0bshTX/AHgz13EncGezCRjwZR3BwYLPyPG2GPX8GlsGKG0ekScRUOsqse9nQyARdTFocXlMNGBJp/vPjoyPUJADR89G3jC2wnA8CuwVKwrsFdKiqnuNH+KLmFcFkBnXJyT7tAk8NgHPpeM86TZXegcYp+Bo6BtX6rIVs0SaMGMgGwO34zhFu9IeIj1rt9LchpOYO45K73ZrsQSg+zO4Izy/ev7b4bmD1EV2MNTLxk7VpaBNRj9l2+TTOd4o81gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8sqSpoqr1vXJNn3JPGLXjTBqRIoi2ouFNEbkOWcgc8=;
 b=JnFmZcNs9BHVzOVQ6+rSzAL+FfaNt17aK21AUaononVZ+C/0IM0jfxCm+xtkmxWKrX6qvQROplslChqrdn2khH/jzfaXDbdmkS74rVx3qwwOTtdTIjs/5EfnBmZPQsjWcH/S+LxVM5R6zNaecjbI0Oe50oWsoSrfMeSLH0TbODsX/mIR9C628Z8/WNnQCut7BffIJC5uWgGnfK31VNodBJoT21aloZDrBj8RsLf/FwrhlfuW0viP7fnQfCfSQqxazA+IWX2QHJ+D3IzuPn9G7j0c5fktNCbR36RV/qdYCnaK/ggj8AKLwbvxgaZ4k+v8wiGmIInryX+RZHCRZ5h3XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8sqSpoqr1vXJNn3JPGLXjTBqRIoi2ouFNEbkOWcgc8=;
 b=e3ssH+PFSGQJ12E3sc6IvNRWOx0XDnSH0gBdXGDpaBaJh75xYzS9zcqoC00pPg0G77MvEWS2dm9sEvG0nZnS2qYfMgkup7GH2TIGxeJ/Ys/jvRkBnvdCSSdgxkfbFVLr6oHwyp0x4dg61LGuLM4drCUVCA8FKjpi1lRZjeB4ntg=
Authentication-Results: rock-chips.com; dkim=none (message not signed)
 header.d=none;rock-chips.com; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB9PR08MB6537.eurprd08.prod.outlook.com (2603:10a6:10:250::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Wed, 4 Aug
 2021 10:03:27 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 10:03:27 +0000
Subject: Re: [PATCH 5/5] arm64: dts: rockchip: rk3568-evb1-v10: add node for
 sd card
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Simon Xue <xxm@rock-chips.com>
References: <20210803185309.10013-1-michael.riesch@wolfvision.net>
 <20210803185309.10013-6-michael.riesch@wolfvision.net>
 <2936848.7s5MMGUR32@diego>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
Message-ID: <ebddd74f-114f-1da4-8702-387338002551@wolfvision.net>
Date:   Wed, 4 Aug 2021 12:03:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <2936848.7s5MMGUR32@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0211.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::31) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.125] (91.118.163.37) by PR0P264CA0211.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 10:03:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6815e54e-a041-4c22-5bcf-08d9572f1a7f
X-MS-TrafficTypeDiagnostic: DB9PR08MB6537:
X-Microsoft-Antispam-PRVS: <DB9PR08MB653789050ABE7F95F0915567F2F19@DB9PR08MB6537.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iy7sIj01VtQcf+6v8WKYrTSZ+sh8Sm0nKNDbFIFuph9mm9LH5Kuyb8sbVafzJ6HsuW+77B1DncZQD6VvNP5l7pUwXGYTjBlJsqas6NmDgYhDLSO0NlWTEnKD+EdoyLqDrakffGx2U4we+parh1z1zAOsTs+Bk8bhte5fRVmLF6uNE5RjfGf/aAsl4IEx5sg35FnAOF6ArvPKsSATA5FICKUKIcjadEnE0mGTryQTFRRaTnF45AguHHUTv311DBsfEc5t/mSdSWs1rPUCHDZ+9vFhnXpU3vD/3z5XRvsn5gVTLcvrRN3p5VxRwdCkh4wdJoS5Cx+eblc3alUJkPh6IXscmhd/bXDOvqY9/aiDM7tBvDi6ev/c8oZNP2DIpsdl0jmDekXNc2EUyQ1Ox1xstdU6Vd7FrfQ2ev930ZI0vUIYbXzNv1kd82mZ8lsZ4YZODBBXRvoSZNhjHDSrVmw8TLbVK4wV8/QgbMb5aL1u54mQHPB00kp2uaKqZIdt7D1YQVRH+d+Ja6y0x+7uGjOnj4fzVvFdH3dueprtj4rrdxH6bSgBKnGgIclKXWgjMKY5V0wN2u+2vIHdgRiqHq9iQOO0b0WVI6s1amopfb3NedYrqgKEpP68xOtnINFn3jjs6gipvGnJguA/fvAd7iVArfb3wgZOwb5jKL2ZFkghkEZV482LjmAAUcS4IBPDwzCqiERlm+INVBGurfHWRpW+wPTSuGFEGOF2v8eehvk6nR+ycnZL5nQVnGFUlyIAg1N0Hm02PSZ5Xu6YFJyjDohjtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39840400004)(396003)(346002)(53546011)(5660300002)(26005)(6486002)(316002)(8676002)(86362001)(478600001)(36756003)(4326008)(956004)(16576012)(38350700002)(38100700002)(31696002)(31686004)(186003)(66476007)(54906003)(44832011)(52116002)(66946007)(8936002)(7416002)(66556008)(2906002)(36916002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Myt5ZGl3dTJhekNQT1FQYWNJS1RFVFRuaUFEMit4YmNGQ2FGekZQUlBDU3lV?=
 =?utf-8?B?eURJRUplZE13TDJCcDJTTWJPeVREb2I1TzhOajRaUkcvNlNYQ1pvT2Z3Mnl3?=
 =?utf-8?B?YlBzL2p6Q1cvaWcwQmZFczBNWkQxS3Y1ZUxmNmhpVjVCakRibEh5OHNpd0Fm?=
 =?utf-8?B?YldvU2txMTQxUlIveWtsRGNPVElSNUw1c09aRkdjNUVuTHBFYnZLdDRKekRi?=
 =?utf-8?B?MUFjZlVUQS91ZXNZRWtjaVVhQ0J3a3FCMTZlRmt2MEdDMUVIaEQ1eS8yb1d3?=
 =?utf-8?B?YWtTM3ZKYjJNNXVrM3F0N040ckNZYUhDT2tTR081eDVodFlVU2czcDdXcWFm?=
 =?utf-8?B?MHQrTmJsbmVLWEp2VE1kOXQyN2lsTFVnb2IrUHBGYjR5aWUzMlU1VGF1S040?=
 =?utf-8?B?Z2NQTXQzeitjOEo1RXJ4NGNuY3Z3b2hxbGYrVlZ2Myt4eFZLOE9oMDVsZERK?=
 =?utf-8?B?ZUtITmFVUytQMEU4SnNJZWFhRHpSaElTcWlhcXgxU1FGb2lvYWd1Sm1OSUw2?=
 =?utf-8?B?WmllK3Z0QUlYZ09GWXRPVDZwM3hwaGZHMjUvWS9nMEpKK2pEWXdQUkN0RjFY?=
 =?utf-8?B?WnJJNFB6eUgxRVdtZWZJMm5YSlpxcFpYekhYN3pWcXNUTVhUN29qaE9MYWR3?=
 =?utf-8?B?cWNVTVMzV0t3MGk5UjV2ekhhWnhvcWRvOWkyZ0o4QWhuNzZScWpUTDQ2MGFm?=
 =?utf-8?B?WEhVQk5QMS8rYTJaTVB0V05qRXl5THM4L05iZ0dSV2tkSno0ZExqeXVHdy9s?=
 =?utf-8?B?WHpsU0lueUQza1ZIR0xZTUtlWmgwaG4zaG1QTDRJL3d5UHNjMEJTcWI5KzJa?=
 =?utf-8?B?bVJNMU92eEpmWDUvUzZWM29jWUVHSndTdEhQTFZrQzB4OVZYYkhhL1Yxa09O?=
 =?utf-8?B?QjNPUTFHc2p1VTdVZHV3TmNUa1B1WWVIUDlZOXJ6YlhGejVrc1YzVkJKajZ3?=
 =?utf-8?B?RE1jYXZCa2hBNVh5V2grWjd1TVAyMVhVZ1gyNjRrcXpVOUhoTnlrbXdHaUJr?=
 =?utf-8?B?S3FtSUJJcU9GdlJtNGFKSm9rMXJNWFpvVDRtUnVDeVJacXFpTTNPUmlIR3Ax?=
 =?utf-8?B?d0d6YWJwbGR3d0V1Ym0yUFRBcnNlMVRkTlNBVVhqM2RYZTRNREVzOEhRMkRy?=
 =?utf-8?B?emFoVHJDREErZWlHcTJFMStsamNVUXdScFJtdTB2bnN3MlVkeEFYaURMTU55?=
 =?utf-8?B?TEZacVJMWUVLbHB6WlduMVRlQUxEZjRxWVBZRG8zbU9WbFNTNnJVNlBzUmRu?=
 =?utf-8?B?VGJRZ25NcHlxQnZVY1VaQkZEdVpOaVlyU0pKY2h2Zm04VmZiNHM4U1duWVB3?=
 =?utf-8?B?OVJIeW9Wb0JvUGtHaGFaNHJmbklZMkRzN1ZKaWNPWUJ4TnFvN0pGZ0lrcllz?=
 =?utf-8?B?NmJNYlg4YS9BWEsvT3YyeVVoRFFubWtXOG1WOGJoZDhOck5hbFMwTTY0YXlt?=
 =?utf-8?B?TUUvS0pLWEhMOEF4dTI2eUs3Mzl5MCt1cEZacERRbVBVRC84cDRMWVM1Mlc3?=
 =?utf-8?B?bE9acFN3dDl3ejFVSFlBZzM4Nm1VTWhyeXB6akVKSHQ5U1JSRHgyU1VpdWZ2?=
 =?utf-8?B?Z0ZkRDZPbmdsU01uTFI2VmRqd3BoK3lIV05kUUMxUzhGeXFVMm1Kd3d4Z3Bm?=
 =?utf-8?B?em51bXFoUWZ2ZC9DTUwzdXZqYUVKOFNwU3dSNzlsZGZRWEx1czA5dmFwOEk2?=
 =?utf-8?B?WnBCNzlmdWlEYlA3SWFlUlJTMlVZSENsZjdZM1NOWUQ1WjdIK1RtaGlvUVVN?=
 =?utf-8?Q?TP6GEHBD2AB1eMSaUvIQ1utwLHVCUESqDA8vPun?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6815e54e-a041-4c22-5bcf-08d9572f1a7f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 10:03:27.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 368pccXmg4L2UfCPd3yw+SptkTN7hVVPEM5zJS8GMgUCRHo7X0Roem1bsf+OpZ9K7zzlbX+XoneczCz/fSQQRZ/QkVHGxZyb0CWKNe2MnAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6537
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 8/3/21 10:48 PM, Heiko Stübner wrote:
> Am Dienstag, 3. August 2021, 20:53:09 CEST schrieb Michael Riesch:
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
>> index 3ac70a8183c4..b0f5aa8c979c 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
>> @@ -17,6 +17,7 @@
>>  		ethernet0 = &gmac0;
>>  		ethernet1 = &gmac1;
>>  		emmc = &sdhci;
>> +		sd = &sdmmc0;
> 
> same thing as in the previous patch.
> 
> I guess you may want something like
> 
> 	mmc0 = &sdhci;
> 	mmc1 = &sdmmc0;
> 
> maybe?

Thanks for the suggestion, I'll include it in the v2.

Regards, Michael

> 
> 
> Heiko
> 
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
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
>> +	sd-uhs-sdr104;
>> +	supports-sd;
>> +	vmmc-supply = <&vcc3v3_sd>;
>> +	vqmmc-supply = <&vccio_sd>;
>> +	status = "okay";
>> +};
>> +
>>  &uart2 {
>>  	status = "okay";
>>  };
>>
> 
> 
> 
> 
