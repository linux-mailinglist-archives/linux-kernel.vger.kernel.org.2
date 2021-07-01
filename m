Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD813B8FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbhGAJfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:35:06 -0400
Received: from foss.arm.com ([217.140.110.172]:49386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235180AbhGAJfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:35:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23C79D6E;
        Thu,  1 Jul 2021 02:32:35 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBB5F3F5A1;
        Thu,  1 Jul 2021 02:32:33 -0700 (PDT)
Subject: Re: [PATCH 1/4] arm64: dts: rockchip: helios64: fixup USB setup
To:     Dennis Gilmore <dgilmore@redhat.com>,
        linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210701004043.18585-1-dgilmore@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3fd0bb29-239f-50d7-cf4b-c057bcccf885@arm.com>
Date:   Thu, 1 Jul 2021 10:32:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701004043.18585-1-dgilmore@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-01 01:40, Dennis Gilmore wrote:
> Without the usbdrd_dwc3_1 node defined u-boot will throw an error and
> reset the system. All other rk3399 systems use this format

This doesn't make much sense - the usbdrd_dwc3_1 label is defined in 
rk3399.dtsi either way, and the compiled DTBs before and after are 
identical :/

If U-Boot is doing something funny with labels and symbols to give 
itself some kind of fragile dependency, that probably wants to be fixed 
in U-Boot.

Robin.

> Signed-off-by: Dennis Gilmore <dgilmore@redhat.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> index 738cfd21df3e..aeedf098f67c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
> @@ -490,9 +490,9 @@ &uart2 {
>   
>   &usbdrd3_1 {
>   	status = "okay";
> +};
>   
> -	usb@fe900000 {
> -		dr_mode = "host";
> -		status = "okay";
> -	};
> +&usbdrd_dwc3_1 {
> +	dr_mode = "host";
> +	status = "okay";
>   };
> 
