Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07843D78C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhG0Opk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 10:45:40 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:37829 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhG0Opc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627397132; x=1658933132;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zxGFIXNqkxZz4/b5iPvdXFv0dc3fQevhmYiTcgs0RGI=;
  b=CunhGqW+mUlmbFv3D5TO1Wu2xNTgWU7hy2YJ1o/NToJ9xMpwJDi1hYkg
   5sqNNyZePrGQ8HR6meN5Bs9x14/7/2PaaY2mNMSdfnfXS67PKow5Om4cM
   vQyjAIJ/DO22s2U/BVL1cUt8aVuLq3i1xdT+MuQMha00mJ1ZXBcBuq4WQ
   IM/NL5jiSrGSqBcDwZWKMNUsXu8XrAzGxbqBeExeZExb3R33YY4gJuO9P
   Py0oKWWoaAnSEmMdyrcSfPB5LieMU2Q+MlrP2v49Hwqgj4zwqUfqexsq6
   1i2mtOkUZLalmU/Nx/60FoEn5rjJWTvcMzmsIQPY8QzPU7H2mLFpWO5OV
   w==;
IronPort-SDR: nm4pwU5L5A36wt1jUIp9yVXQLq7Py4z3MEIrWtAI48HAKvTb7fx422vtF19/ecHXryrZTLAnD8
 brIyuosOgxMJQ2ywDy1tupxnGbWbGG1T+EH4J3T09xSRdcvql9FOwuXHVJRtNIePCsnMDqdClz
 BKTCTi9SBbxlnoJrfAN1VByh+s/JaoQ6T6VAToVo5VW1QO4GzmUBfLGQz4DxuKSNp2NBbdKTPM
 /s85vNiESzWbX3+nhhFZtuEgXVwEm0Hi/AZT6ovVU26nz10cD6jECsqOrtYGHhi3VbTXFQGp/i
 peosrn3nfHNv5NT77h65Ds/h
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="63755044"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2021 07:45:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 07:45:31 -0700
Received: from [10.171.246.86] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 27 Jul 2021 07:45:29 -0700
Subject: Re: [PATCH v2] ARM: dts: at91: sama5d2_icp: enable digital filter for
 I2C nodes
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
References: <20210727134115.1353494-1-codrin.ciubotariu@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <1444f480-be56-02a8-152e-8b6d0a94a0a9@microchip.com>
Date:   Tue, 27 Jul 2021 16:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727134115.1353494-1-codrin.ciubotariu@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2021 at 15:41, Codrin Ciubotariu wrote:
> SAMA5D2's I2C controller supports digital filter, so let's enable it.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v2:
>   - removed Acked-by tag

And I add it back here ;-) :
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

I queue the patch in at91-dt for 5.15.

Thanks Codrin, best regards,
   Nicolas

> 
>   arch/arm/boot/dts/at91-sama5d2_icp.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
> index bd64721fa23c..1c235fc5f788 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
> @@ -184,6 +184,8 @@ i2c6: i2c@600 {
>   		dmas = <0>, <0>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pinctrl_flx4_default>;
> +		i2c-digital-filter;
> +		i2c-digital-filter-width-ns = <35>;
>   		status = "okay";
>   
>   		mcp16502@5b {
> @@ -307,6 +309,8 @@ regulator-state-mem {
>   &i2c0 { /* mikrobus i2c */
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_mikrobus_i2c>;
> +	i2c-digital-filter;
> +	i2c-digital-filter-width-ns = <35>;
>   	status = "okay";
>   };
>   
> @@ -314,6 +318,8 @@ &i2c1 {
>   	dmas = <0>, <0>;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_i2c1_default>;
> +	i2c-digital-filter;
> +	i2c-digital-filter-width-ns = <35>;
>   	status = "okay";
>   
>   	eeprom@50 {
> 


-- 
Nicolas Ferre
