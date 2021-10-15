Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE7E42E661
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 04:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhJOCK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 22:10:58 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25136 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhJOCK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 22:10:57 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HVqQl0D1Fz1DHNt;
        Fri, 15 Oct 2021 10:07:11 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 15 Oct 2021 10:08:50 +0800
Message-ID: <6168E2B2.1070209@hisilicon.com>
Date:   Fri, 15 Oct 2021 10:08:50 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <xuwei5@hisilicon.com>
Subject: Re: [PATCH] arm64: dts: hisilicon: align operating-points table name
 with dtschema
References: <20210820081522.83512-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210820081522.83512-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2021/8/20 16:15, Krzysztof Kozlowski wrote:
> Align the name of operating-points node to dtschema to fix warnings like:
> 
>   cpu_opp_table: $nodename:0: 'cpu_opp_table' does not match '^opp-table(-[a-z0-9]+)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied to the HiSilicon arm64 dt tree.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 4 ++--
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 2d5c1a348716..19a979779bdb 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -210,7 +210,7 @@ A73_L2: l2-cache1 {
>  		};
>  	};
>  
> -	cluster0_opp: opp_table0 {
> +	cluster0_opp: opp-table-0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> @@ -245,7 +245,7 @@ opp04 {
>  		};
>  	};
>  
> -	cluster1_opp: opp_table1 {
> +	cluster1_opp: opp-table-1 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index dde9371dc545..3f2134779115 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -193,7 +193,7 @@ CLUSTER1_L2: l2-cache1 {
>  		};
>  	};
>  
> -	cpu_opp_table: cpu_opp_table {
> +	cpu_opp_table: opp-table-0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
>  
> 
