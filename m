Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FF140F744
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbhIQMKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:10:47 -0400
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:42300
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237218AbhIQMKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:10:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQVcWqwY012JnXwNgn8kUCCOlkCdSHcqwZRGmdPESkr5AWiwKAsecAYwcU2au4PZGBpMALs0QjrRwHcXm9fCvoeGVkLhH1Z7Lq6pChCo9gXsmmMMQdDY0cpu6mqiatinMecHQ0QkfErZpJoBg5xfD1VUSgem/tYBr9QqfLlRxi1YORoHSPJkvLSTH6ZeBde16FpjomZSDLEm/gZpFuvKW3amVEWj4MzNhrxw6YfxNvduiybc0BqEdY6AFBHK3ohH9/Eek43UkNJw88Bi7yPYDDLT5+cisXr5Lft9O06aVP/D1/mqtlhIKUPNx4b4liHU+ZVFgYikHNoJxQEfH9/6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SQhy4bwhKhDdbMG2T+EYjhRb76Un272fpVe1OEKKa2w=;
 b=XSKUxSsIABhOjZ8s+p26PimM4KXpyhngq4tI+fXINJfnrnYP2Du8+3TFrEEoqqP/dqvR7TLWFpUOMOMBVQ0Nmj0Le5uUOAvHQ6q5WehYTP05ZpilWTdVXsKmTLid12l42ZBSaGIFGXO7NQzc8RfG9zhTZojm3WFqz+YbzDxsKp7ok4ejZ1gQqSnxsu14Msi2LiN9zMzeNHQHmZ0T4zwP9/obuNqeC9SHl+l62Lq4inaE1q2H8KRMpeApFrDpdspwkuX9OoI2gepBhr+F8Z6/JVs7mozPI5F40FDUahfCIMwzFNVq9HpvoKqJI0DTmwWehv18btG6g8MIM7XOLQxD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQhy4bwhKhDdbMG2T+EYjhRb76Un272fpVe1OEKKa2w=;
 b=fxT3KRTsd/6L5kNVdOqEtIxvpT2w/zlbk1DawZEOpBY84MXmAHx7E2hbPCMky/vy7DNv6cPp8pGfCHCzE6Ww52Tgwc1ZXByNNAl/mF93vC7x88/EVB49Pzbkf/QP0B0CnIApUYbLr34yRCQ2IJ6MV/FN9tXWEhuhlXOxJ8KhTmQ=
Authentication-Results: rock-chips.com; dkim=none (message not signed)
 header.d=none;rock-chips.com; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB6PR0801MB1944.eurprd08.prod.outlook.com (2603:10a6:4:73::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 12:09:19 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::452b:e508:9c57:a6e3]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::452b:e508:9c57:a6e3%7]) with mapi id 15.20.4523.017; Fri, 17 Sep 2021
 12:09:19 +0000
Subject: Re: [PATCH] arm64: dts: rockchip: move aliases to rk356x dtsi
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>
References: <20210917110528.24454-1-michael.riesch@wolfvision.net>
 <2397289.mVTDCA6dLn@diego>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
Message-ID: <4574b70a-3979-f04b-221b-5cadfbfcd07d@wolfvision.net>
Date:   Fri, 17 Sep 2021 14:09:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <2397289.mVTDCA6dLn@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0701CA0060.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::22) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.125] (91.118.163.37) by VI1PR0701CA0060.eurprd07.prod.outlook.com (2603:10a6:800:5f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.5 via Frontend Transport; Fri, 17 Sep 2021 12:09:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97262512-3b3b-4f41-73f8-08d979d3fa1b
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1944:
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1944E45B0C06C886FE0BA904F2DD9@DB6PR0801MB1944.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pan6AQVDKe5uxl3C39Na8DggcQewojkqoX3N2aURmXZ6l2/cfZbJIGPoqphdHuGw+ym8f0or9125aVyMFsitOSECgumc8/Y2apz9eKGmcUDKAEaTcChYAodY0baph+eian+g9BH6mQ4J07/86hjJgtYum/z55H1qwBMEB255J2gF9PyhjwioPehCrG5ei1Zht3NeWBjyU0B/qA+Mp+mGDQT0nAF5ZkcMYcPg2cI+RHXi4rU0j4oGDQr1mvAg9986YKziLvDoKEDSM3FMYWcmb0fTQTzTwTmcCtRaoYMjAoUMOx+vuxH3mAvPU0ciXZTSUKqA50ecVUS5UdJj5bZsykWLqSYgECWmZ/FIMuppEExLOVS5Z8QQYa9vAkWWQxhlWpnTJ8eTndBZrlH6TcP4QTLLMIta4f06poUTqbD+FrWh4Snx6hNjCYxZ19zNTbg8CT2uD+4MNJnHl7fsOiQi7HWickquYxDBafkF4LnKyJEFRjSgcOgbxQ+rjKe70DAuHpwf2ZpTHZTjVL/67c8rM6ScVvwcMleGgZYZh0oVTsHvS4Daidt7CgJgV4P16haQ+3IDnrvtBwmITd2hZYPiMuG2K3kPvsmrsA8KFG7zCMhcurgMj4IHvohPdKYfAwwj35xyhRLgR8HBnsyxf0iNsJXqfnv5YWgUaW7DVWj0ZaS3/it6mpfn00Haripd3crewaquxLuCCuvMwkxu2UBln8e6oEvrUeZlHR4Kpo0nHxUEVM+3XYoaVMjhr88YuJq3wgtWB41HUHS3q+y96NEt0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39840400004)(136003)(396003)(5660300002)(38100700002)(2906002)(8676002)(4326008)(66574015)(38350700002)(66476007)(66556008)(8936002)(44832011)(36756003)(31696002)(83380400001)(86362001)(186003)(26005)(31686004)(16576012)(478600001)(54906003)(316002)(2616005)(956004)(6486002)(53546011)(52116002)(36916002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDc2Njl2VkM2UGpwb3JQMTZIQXVERjU1TDBVTG5sSVdVWmNSME5NMktyWURW?=
 =?utf-8?B?cDVuYnJtTkROejR5WVpDR3IyTUxON3RVc2I5Qncxb00xdXZkeC9ScFJsL1dM?=
 =?utf-8?B?WGhWTVBGakJrWlVyMjZZc1FwR1lpY3IyNDJWYWd2SmUzZ2lqRnBvczVQVVBq?=
 =?utf-8?B?aThyU3IwVkVOZnZIWjV6alUyRVFDT3l3amo4S3hQekR6aHk5U0lJQ0ZqQTlp?=
 =?utf-8?B?K2cyajdVSXNkTG9td01MVjFtOHBrczlScm90ZnF6YjJiTmRwWks1SGt5c1Ev?=
 =?utf-8?B?aHgxK1hvbG5aUitwZUIzZGVUdjkxc2JMcVp5eFA1dks2NWNjeWVhTHlHMkdo?=
 =?utf-8?B?bkVFd3FwNGwzUENuZi9YNDRlNDdkYVZ0Ni82c0tDS1VJQ1JITUoraXpHcGFw?=
 =?utf-8?B?cWJIZm5FdGdtV3FrS3lhSjUxS3V4VFdlSFZBbGdGUjdvM1hKTndKclFMREo1?=
 =?utf-8?B?cWtQU0JtZUUyMyt6MXNtZHJiVmIxQkxzZzVkZzl4TytHSjVibkRMeE9GdUk4?=
 =?utf-8?B?VDVGb0xDTXdrbDArekx3ajNOT3JlSllVRmZKWklIMnJkeHVETXA0Q0NmcTlK?=
 =?utf-8?B?aVdXVEtEVU00Q1F5TzFlckt0eVVrK1Y4WDJ5QndHVmxQcWkwVHhMY0c0SnB2?=
 =?utf-8?B?SmxYTWlLUkIybXdBa3hrdlF0NVF5b08wRjUyNHVTOGRtOS90ck5rV2xlc2Fw?=
 =?utf-8?B?aWJQM0MvNjJMR0ZORUtsUDR2V2d3by85b0YzQkJudzR3OHhIbERubEFYdU82?=
 =?utf-8?B?aU1LV3BQOGtWb09jRjNCY2tlb0htQjRvYWE4TjQ3WS9VMVpnL1pvRUN0SDVw?=
 =?utf-8?B?dit5NFRwazZlR0dGQUZUS1Z6VzhFcW1PNGVHQUNoeEtHWXFLUThyV3F1b0Zs?=
 =?utf-8?B?QkJwZDJ5TVBhOUh3UlY0VVZHRFpTNHlOWGovZUV5eUV3SUZ3MFJIZno2R1Vv?=
 =?utf-8?B?Y2RPZ0tGRjZvdHY2cGFpOEhhTzA1SmNXaHFNNzVyeVdLdm9zV2RGenlGdE5t?=
 =?utf-8?B?ZFZ4Z0hDQ1JRcWVONzZpVjRScVZJcnV2TGFKVkJraTQxT0trb2JtL24yUXlz?=
 =?utf-8?B?anQ4U0dqUXBVUDJoN05UbHBCMlBLNWN4VzBZVEswbzV4dXdVV3AwbWcvV29j?=
 =?utf-8?B?MWtGcVhPMjhVaXh3YTdFMWJ6Y0R6WENaUW1KVi85ZlBkMVBrN0pSN3BraVZU?=
 =?utf-8?B?a29nUDk3L2p4YkppTHpDQ2h5UlJ1UUdOM2Jsem12RHphVHB4ZlpDYTFZcjUy?=
 =?utf-8?B?RUgrVklIaXNMNjl5ZGpFNm9sQW9iQlgvbFF5eGFRbktIMUh6Z2hNTWNZTTZo?=
 =?utf-8?B?bFRXMnlvSzBna0xxUTNsaEpHRjJsKzZObzJIM25hMEdIZlo2aEZmUnVkc25l?=
 =?utf-8?B?UVljYlhmcVJseGoxdkl3OEkrSUtjdndVL1FLZ2I3UTQ2aU55eW01cTMrbWp5?=
 =?utf-8?B?STJHSzI3a2ZlWjlQeERVTW5uY0JBUFVhanRhK1BOUzBWU0lvREVQcUQrRGpr?=
 =?utf-8?B?T25RNTJtR1czNmRJSVEzbDBoRi9iazZyQzZtZTdTUUUyRGNoc2Z2RVE3RnFX?=
 =?utf-8?B?MGxaREo5NjI5RTA1c1AzQk5MdktVK0x5UnhjeC9uM2JjN0NFR3lHb0t0U242?=
 =?utf-8?B?ekhpUTZ3amZ4Qk9mQ2NsT1dlTWM0Uk00cW03T2ZyRVE0dDZwQVlIZVpZQnJu?=
 =?utf-8?B?RTU0TTRuOUVFSnllcGc5YWEvUTRHZHBjSnVHaXhsS1dKNGROMzU5ZWZRU1pC?=
 =?utf-8?Q?aahbMW+eUvz72Td/jKyfZgeg4NX4FxcGodA5uge?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 97262512-3b3b-4f41-73f8-08d979d3fa1b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 12:09:19.1798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bC1xJBgUzIV6n/i6HBFx4/1RZfymePPbfrjRpj9kWylnspI9HNCQALbXK3qt4qB6qh25nR8vWMCxoeIvSj2QfeYHddWjhoSmNdN99PGlIj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 9/17/21 2:01 PM, Heiko Stübner wrote:
> Hi Michael,
> 
> Am Freitag, 17. September 2021, 13:05:28 CEST schrieb Michael Riesch:
>> In order to ensure deterministic probe order over different boards,
>> move the aliases of on-SoC components to the corresponding dtsi
>> files.
> 
> please read the git history on the other Rockchip SoCs. We just moved
> the aliases on them _to_ the board-files, as requested by
> arm-soc maintainers ;-)

OK, I was not aware of this. Some SoC families (e.g., Freescale IMX)
have those aliases in the dtsi and I was not sure what the desired
approach was. Thanks for the clarification.

Best regards,
Michael
> 
> Heiko
> 
> 
>>
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 6 ------
>>  arch/arm64/boot/dts/rockchip/rk3566.dtsi           | 4 ++++
>>  arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts   | 7 -------
>>  arch/arm64/boot/dts/rockchip/rk3568.dtsi           | 5 +++++
>>  arch/arm64/boot/dts/rockchip/rk356x.dtsi           | 2 ++
>>  5 files changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
>> index a244f7b87e38..156bbb8aa4c4 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
>> @@ -10,12 +10,6 @@
>>  	model = "Pine64 RK3566 Quartz64-A Board";
>>  	compatible = "pine64,quartz64-a", "rockchip,rk3566";
>>  
>> -	aliases {
>> -		ethernet0 = &gmac1;
>> -		mmc0 = &sdmmc0;
>> -		mmc1 = &sdhci;
>> -	};
>> -
>>  	chosen: chosen {
>>  		stdout-path = "serial2:1500000n8";
>>  	};
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
>> index 3839eef5e4f7..c1b3841caa77 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
>> @@ -4,6 +4,10 @@
>>  
>>  / {
>>  	compatible = "rockchip,rk3566";
>> +
>> +	aliases {
>> +		ethernet0 = &gmac1;
>> +	};
>>  };
>>  
>>  &power {
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
>> index 184e2aa2416a..218f85af730c 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
>> @@ -13,13 +13,6 @@
>>  	model = "Rockchip RK3568 EVB1 DDR4 V10 Board";
>>  	compatible = "rockchip,rk3568-evb1-v10", "rockchip,rk3568";
>>  
>> -	aliases {
>> -		ethernet0 = &gmac0;
>> -		ethernet1 = &gmac1;
>> -		mmc0 = &sdmmc0;
>> -		mmc1 = &sdhci;
>> -	};
>> -
>>  	chosen: chosen {
>>  		stdout-path = "serial2:1500000n8";
>>  	};
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> index 2fd313a295f8..dd0e800cf752 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
>> @@ -8,6 +8,11 @@
>>  / {
>>  	compatible = "rockchip,rk3568";
>>  
>> +	aliases {
>> +		ethernet0 = &gmac0;
>> +		ethernet1 = &gmac1;
>> +	};
>> +
>>  	qos_pcie3x1: qos@fe190080 {
>>  		compatible = "rockchip,rk3568-qos", "syscon";
>>  		reg = <0x0 0xfe190080 0x0 0x20>;
>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> index e42fbac6147b..bb0540d3008c 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
>> @@ -29,6 +29,8 @@
>>  		i2c3 = &i2c3;
>>  		i2c4 = &i2c4;
>>  		i2c5 = &i2c5;
>> +		mmc0 = &sdmmc0;
>> +		mmc1 = &sdhci;
>>  		serial0 = &uart0;
>>  		serial1 = &uart1;
>>  		serial2 = &uart2;
>>
> 
> 
> 
> 
