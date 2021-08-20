Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DE23F2DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240814AbhHTORx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:17:53 -0400
Received: from foss.arm.com ([217.140.110.172]:33220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235032AbhHTORw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:17:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C0E311FB;
        Fri, 20 Aug 2021 07:17:13 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2432C3F66F;
        Fri, 20 Aug 2021 07:17:12 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: rockchip: remove cap-mmc-highspeed property
 from mk808 &mmc0 node
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, paweljarosz3691@gmail.com
References: <20210820131920.1831-1-jbx6244@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bf6cba99-da3b-a6fe-4e4b-f4ea6e3c6e63@arm.com>
Date:   Fri, 20 Aug 2021 15:17:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820131920.1831-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-20 14:19, Johan Jonker wrote:
> On the MK808 only a microSD slot is connected with the SDMMC Host Controller,
> so remove the cap-mmc-highspeed property from the &mmc0 node.

Why, does it do any harm? It's perfectly possible to connect a 
full-sized card to a microSD slot with an adapter. I came across my old 
SDIO WiFi card a while back and tried it that way for a giggle, but 
unfortunately it turned out not to be a chipset supported by any 
upstream driver.

Robin.

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   arch/arm/boot/dts/rk3066a-mk808.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
> index 9790bc63b..b67f5cb51 100644
> --- a/arch/arm/boot/dts/rk3066a-mk808.dts
> +++ b/arch/arm/boot/dts/rk3066a-mk808.dts
> @@ -123,7 +123,6 @@
>   
>   &mmc0 {
>   	bus-width = <4>;
> -	cap-mmc-highspeed;
>   	cap-sd-highspeed;
>   	vmmc-supply = <&vcc_sd>;
>   	status = "okay";
> 
