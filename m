Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADA445E0B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 19:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350174AbhKYSw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:52:27 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:55726
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344775AbhKYSuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:50:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7jftGt+Os8LRK5jzj+VMp8EjFoAsKjq3bo0USp3ostsWd/Nk52FeUsfRx/IQPb1726xc/g/dqRwgxqj9sQU7z3Wx57lOQ72NrghijwlVooyq2WYOHoVWukd7Cx/qcJBjsuVUISw0Ti3pVOwEBLBqgFDDcb+ajg8T+qgjrtqaDphoe2yBOpqYmEP7T7iBX/AG/j/I0QWclE9c5hkulQ/8VGBrDtVJKrD/BQ1e1kl/9c8D3HCuhvybg8qHvCSavc4jyW3TQTVbs9CSeKV0MGtG5tIpqBqIXXgDl/+pvXSvY3SU940yKTJGu3owb8jo3RsOLDs0eLa8JLLIFZVbl/YDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GejZnSoQB+TQzq2r2X4pvZ6qfJcxpvAakhehHjhC8iQ=;
 b=f2xB8iUcDbH36YjIzVjnPGs/g4VBCnCQ2g5KYSQTs+e+dmJwSEi53hx9NMfq9b7Y9Dm8pk5FkOrNpEjFX7mrCEQwZdb2v4JzAGbqd2ngbSGBdlPU10aQ0/87Pj6r+gLplC7X8STKACTODBZuuymW+91OjbMXU1Y7K+YkzaWk72UahZPrQxlaYnHhPf8nGfEWc9wdnkZZjuUFc9bpGCN3/1WiIjOupZ0ienwAlzbFat5gQLhFvwj8wd62b2w8Rh0L0+nBeE2QV/qGEH9EBTovEN25F73H2NInir/qgs087jsZFtzY2ju1PxawS6lLJsSJbAT9D5jj7GXzSnIAyjNabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GejZnSoQB+TQzq2r2X4pvZ6qfJcxpvAakhehHjhC8iQ=;
 b=GUmBYswJZxeuedPnzoaMWtC4pYlI8DvKkZsuI6GHv/x42GAHysAecNL+ZV0Vy92AZYAfCgwlIFHe9/r5Awh2+Jw9CwfNNzPFJgyZuIul4GcBIu7EKJpA4xzx0BcLU6+KEfzezUfwfMKCFRyOzD9uzp1Yh0RWrZ6XxM2lgF3iifg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DBBPR08MB4663.eurprd08.prod.outlook.com (2603:10a6:10:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Thu, 25 Nov
 2021 18:47:10 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::a9fd:7c7f:72a5:feda]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::a9fd:7c7f:72a5:feda%6]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 18:47:09 +0000
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rk356x: Add HDMI audio nodes
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211125100836.423808-1-frattaroli.nicolas@gmail.com>
 <20211125100836.423808-2-frattaroli.nicolas@gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Message-ID: <00cc6513-ce63-6e92-fdda-ca4f92f6d630@wolfvision.net>
Date:   Thu, 25 Nov 2021 19:47:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211125100836.423808-2-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0026.eurprd09.prod.outlook.com
 (2603:10a6:802:1::15) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
Received: from [IPv6:2a05:1141:1c9:7c00:2971:328c:3026:3149] (2a05:1141:1c9:7c00:2971:328c:3026:3149) by VI1PR0902CA0026.eurprd09.prod.outlook.com (2603:10a6:802:1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 18:47:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82175b0f-7e42-43aa-9768-08d9b043fc9a
X-MS-TrafficTypeDiagnostic: DBBPR08MB4663:
X-Microsoft-Antispam-PRVS: <DBBPR08MB4663547394A6CDD54A47BAAFF2629@DBBPR08MB4663.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYPwKiHY3JMlX/dZDhu5QdcRkmod/JDSJvh43mn051fMPJtsYxNP5xx5VTggaytVkTfjWjbFbCOJ82/nPZoKpwQ5lAwiind0GwGdPsr4xNTvYDgtIMRkaA8c33CAHoSjJTb5Tfp7zgbjb1VnpbovfJOZCeN84X1MFrQ9QF3TVlzQfcAWS8ZOiQWqWW2ZcgUzpeoxQBTRnn5CpvAZqdTB2495kX896wd4E1JBpvcWQj07uOy07EiUWcn9y/40whBzP6LlOnqb98QG1nYJLDDmEpaYWhcva7AW2INV3oY0DBKrrPZX4dPMYSXDkfGr9HNKkrJ9t+xEZ5u6xS39bVEpBo6DBPFZBNiA4rZ5iIS6zIJ/XSscBDfNfX9O7JLO4On37azq75MWPU5xlufE3g+pC6VBl8JqtQfcoH8hAhi7J5jxrFruZJ5tCnSHehg5x+FgPlmAqe33jlIsXqp+c/3/TSCwmWMIQvRTe/geGKdFbsdQn7laY8gDb7mgcBXjxPcSlEQ7+p9bbdHhG6FEw+N8Ypve/4U86WgJh9v2OZczwovoh+H4XfqEnQZmo99MnOWjPdnfsTmLTADVBDA4fxnBy3z7itLDWxUrx1dbp1fMsBsaMtfdrmJE0yqOcz2WkK/MulOZPqeqfbUWQ6jl3a9SXOBH/AWRRul2SxLQVmeJDXvmlb3r/MKGrhCC9aQcD8Hz8V4fW1jXGoOIge7KvEbcd7Mcv8gD5p5l5yQmFGP3Iyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(39840400004)(136003)(396003)(66476007)(66556008)(8676002)(83380400001)(36756003)(508600001)(86362001)(31696002)(5660300002)(186003)(66946007)(110136005)(38100700002)(31686004)(4326008)(2906002)(316002)(6486002)(2616005)(52116002)(44832011)(53546011)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk96aEZpaGVkOFl6aFRJL1RHTDZ4TUttOE9BSzNTV052TGxzOUJlY1JaTWth?=
 =?utf-8?B?YUdzYldpTWhFMDZhNEZMbHJISEhmRllpU2F1SUNnM0RzR04vREpqN2wzY0cx?=
 =?utf-8?B?VTlJb014M1k0ZkpwcE5EVFpqbktzTENCSThjTnZCRklFN3RBenJwTUw0ZGQw?=
 =?utf-8?B?V3VRUklOaTYxTnBjY1FWOVl6ZTIzU2xISlpsb3Vhbm4rUGJLYWVkRjl5QmJ2?=
 =?utf-8?B?OFZWNmNhdTJQZFNpMHR3aEhqajZ0UW1QQU0xU0M0RzJnYlM1STlkVmtvMHky?=
 =?utf-8?B?QjY1dnpqcHlTK0tpZ2RWaG15NjBKTEhwSklIWmdIRkdncWhVN0VEQzJuYU15?=
 =?utf-8?B?b1h0UndZdjJTL0I3ZFlKZ0hUV1RCYnFraUZqdFlqcS9kVWI4QmxHSklvdEVN?=
 =?utf-8?B?Vm43a1h1ZkExeURLd0RHdGs2OUNnbzFwRGM1UExBRVVxYVhvazB0NTdVRG9P?=
 =?utf-8?B?eDNnNTlRNG1GOTJxMEE0dncwbm9YMVp1MnZRbXR1cWtYZGJSSEpWVk1BMTJP?=
 =?utf-8?B?bjNsR0VmRjBhai90ZHdlTUU2OTgvZjlhUkdJb0RSbGVDUFRka05sQ21iME9Q?=
 =?utf-8?B?MnBsRW93YzVCRG9hQndPcVI5d1oyanBsYjFjSXV2NUo1dlpVV3gyS0QrclI2?=
 =?utf-8?B?YjlWVVJVQ3Brcjl2RGpWSlRDS0VVVlpJMUtqaUgyWDdPdno3dno5U2NjcjRZ?=
 =?utf-8?B?UkFvWUFTZHhiMzJYZUNuelJ1bTI3YlRWYmEyMGdSTlBYZm9JR0FKTTA5Vnpq?=
 =?utf-8?B?eG9Nak9JaGFtWHZaNldPTVJudDFyd05CeXF4YkJXYUpLek0xOEZqaEsyOXE5?=
 =?utf-8?B?ZGhWOWZRcmppeHdwb3ViNmxYTU5LWU4zTWNKT0c3RERJUDFoc21rL2w5QVdl?=
 =?utf-8?B?NnRJcnZ3bVM0TWdlZUVJSUVxS1F6RVlZa1Brc0g2SnBnRG0rdHMzQlEvUUY1?=
 =?utf-8?B?NzdSMVY1YXFzeDZZU1M3UlRDQmpGWGJlNE1MTm5wa21kN2NPZ1RvNktSR2NZ?=
 =?utf-8?B?VVVGUjRMa3RrY09FaitiVU5PMi9Qb05Wb2FrTUJJNW5SckthdW4rMDlVNGZq?=
 =?utf-8?B?akpyUlM2QjZBRnJ6NU0wVjRXMjV1ZEZwY05Yd3lZRG0vRkxWR1dWMTJVOXlB?=
 =?utf-8?B?eVNyYzRJRjZTRUU4aEEyU2RYUE11SUhTSVV3SStjdEhoVExFUGxQc1FGL1hI?=
 =?utf-8?B?alNLUGdFV296OSswa0lYclpNQkh3cjIrVFl1MGNBcFFJaHU0dnZnN3hJWlZ3?=
 =?utf-8?B?TTJsR1ZMSTZOamRiMTRRVnBsNUdqcmlxWlMwakhWOXZEWGd3MldnMHFlT0lh?=
 =?utf-8?B?L3FsZGUvTWlYTzhHSFp3TVJPYjJhSCs4ekdFd2YwOThScklGQi9NSzBhV3I3?=
 =?utf-8?B?V1BXYlNoQi9nNFJNNE1zelJFY0M1SlVRbDh3TlBVRVBNZHIycW41ejFaSUhY?=
 =?utf-8?B?ZWV1Y0xMM1llR0grWEVNblFSTGVzUUw5K1VidlJtVWJhejR6SjA2RVRUeDVX?=
 =?utf-8?B?ZWdTTVRKR3pPNDh1N0dKWE42YWVVZDl3cjdQQ2QyWTl2NkdhMHRJb3duMlFl?=
 =?utf-8?B?dmd6MzNhbVFJdFpVejI0K0M1L1JvZlB2Smp6b0lNaWcrTDFoM0lqOWNlVnRY?=
 =?utf-8?B?T3JkS2VHakZiWlhSZ29zS0Z6SW5URTZyeUFGQ1FBUHhDZ1NlTEg0Ykh6MC9a?=
 =?utf-8?B?ZmxOczI5WmNUakF6aC9DeWFTVFZ4WjJBZEtXcFhZMDVBUXFJbDgwei9YNmpE?=
 =?utf-8?B?QjlkTXNnWm93b2xVNi9EMi9OT1Exbml6eGhGTzNHU0NJZGRyMUpDK2g3Rmo2?=
 =?utf-8?B?cFhYTTc4TFFEVXUvRll1aFZXVXBxMDduaHk2ODQ4ZjBVbWNjZXIwTjdhU29h?=
 =?utf-8?B?ejJvTVoveE9ON3doOEQzcUl6Y3lLWG5TK2pLMXkybnAzYmtHZWhFSlh6SnFk?=
 =?utf-8?B?V0N4ckNVaDllUnVYNDZpV2lDM0dYUnJFMHdJUXg2UElkR09wSU1SSm1TRVhz?=
 =?utf-8?B?TXFUVm9EMkZxbjUzRlNGaDdVc3MrdjVaVXpHandzWFRaZUFhNFlBMEQ3aHZW?=
 =?utf-8?B?OTdRVlJ6NC8xZW50NUtPUXg2Q2YwYTE1MEwrUE95U2ZjMGQxOHlOSzRjVHhJ?=
 =?utf-8?B?aEFYVzlCZ2I1YkhqbDdSZW0rVXoyd2JyTTRIRFgvZkR5MjhYdUFsT3VuT1lT?=
 =?utf-8?B?QTgvalZwYnFoUzl1bVJlaDhUczU2cGkyYWpsMXRnRVFTRXlVWDh3RndGYnhK?=
 =?utf-8?B?MWhHVVFNUWZCclZTNmdkOXlUa0o2Z3pyK3VEZFdmLzl6dVduTHZMbit4TVhl?=
 =?utf-8?B?MWxsZjZGb0JGU0k3NEpqalpBdklGcldxak5WTERrR1dWbFdGUU82QT09?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 82175b0f-7e42-43aa-9768-08d9b043fc9a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 18:47:09.9071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GjIgVgfx5/B14JprQTQH9nzeAZxUym8IhrlmVVhYztUwqF1i+zMdDMvPdv+XTLOns4Is4X6lzX+rylUPvEfApAHeYnad61dJix6KBwf49E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4663
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nicolas,

On 11/25/21 11:08 AM, Nicolas Frattaroli wrote:
> This adds the i2s0 node and an hdmi-sound sound device to the
> rk356x device tree. On the rk356[68], the i2s0 controller is
> connected to HDMI audio.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk356x.dtsi | 32 ++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 3c09cf6d4c37..ad4053402eef 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -614,6 +614,21 @@ hdmi_in_vp2: endpoint@2 {
>   		};
>   	};
>   
> +	hdmi_sound: hdmi-sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,mclk-fs = <256>;
> +		simple-audio-card,name = "hdmi-sound";
> +		status = "disabled";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s0_8ch>;
> +		};
> +		simple-audio-card,codec {
> +			sound-dai = <&hdmi>;
> +		};
> +	};
> +
>   	qos_gpu: qos@fe128000 {
>   		compatible = "rockchip,rk3568-qos", "syscon";
>   		reg = <0x0 0xfe128000 0x0 0x20>;
> @@ -789,6 +804,23 @@ spdif: spdif@fe460000 {
>   		status = "disabled";
>   	};
>   
> +	i2s0_8ch: i2s@fe400000 {
> +		compatible = "rockchip,rk3568-i2s-tdm";
> +		reg = <0x0 0xfe400000 0x0 0x1000>;
> +		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> +		assigned-clocks = <&cru CLK_I2S0_8CH_TX_SRC>, <&cru CLK_I2S0_8CH_RX_SRC>;
> +		assigned-clock-rates = <1188000000>, <1188000000>;
> +		clocks = <&cru MCLK_I2S0_8CH_TX>, <&cru MCLK_I2S0_8CH_RX>, <&cru HCLK_I2S0_8CH>;
> +		clock-names = "mclk_tx", "mclk_rx", "hclk";
> +		dmas = <&dmac1 0>;
> +		dma-names = "tx";
> +		resets = <&cru SRST_M_I2S0_8CH_TX>, <&cru SRST_M_I2S0_8CH_RX>;
> +		reset-names = "tx-m", "rx-m";
> +		rockchip,grf = <&grf>;
> +		#sound-dai-cells = <0>;
> +		status = "disabled";
> +	};
> +
>   	i2s1_8ch: i2s@fe410000 {
>   		compatible = "rockchip,rk3568-i2s-tdm";
>   		reg = <0x0 0xfe410000 0x0 0x1000>;
> 

on a RK3568 EVB1 with corresponding dts changes:

Tested-by: Michael Riesch <michael.riesch@wolfvision.net>

Thanks and best regards,
Michael

