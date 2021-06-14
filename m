Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFC43A6A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhFNPdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:33:49 -0400
Received: from phobos.denx.de ([85.214.62.61]:53400 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233006AbhFNPdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:33:45 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CB1EA80092;
        Mon, 14 Jun 2021 17:31:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1623684701;
        bh=2zsTdzLnk3mr73F5DDvsWLQnRMS0S22JOptzazjSdWw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I0NyTalDlAmd/mkvpVcDJuHYNLerHSicRF5AcMK8ytVbbzjoFM4R/ilk9J/j9lZ1p
         vVTdo/yr10sakfIgEHkbWKfWs9pRWORUpStEUj2WZYRlgvDRXRHRTB/Ljy/YjIRG+Q
         F4jwC49nzPGF9dIe6kaWO732JP8pJxdAPJ7QMRp20ZTf6xv1G1O2pGsnVzRrj+d7I4
         TMa683P8+XLwpWCcT+mOWsTXf9cFo6gWtvK9D29a4pYlKd+Yr4lC6CS3hmCmLs/AkI
         ttF/ZNFiQDLyhziKN60G3uroUbLB5fm0s45pCZDq1WghgKvGRIvf8Uca0eBxKJgcp4
         vzGu8orK+OQoQ==
Subject: Re: [PATCH] MAINTAINERS: Add maintainers for DHCOM i.MX6 and
 DHCOM/DHCOR STM32MP1
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kernel@dh-electronics.com,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre TORGUE <alexandre.torgue@st.com>
References: <20210524115853.6413-1-cniedermaier@dh-electronics.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <a6229fe4-7409-deac-6c59-93a715dc4d45@denx.de>
Date:   Mon, 14 Jun 2021 17:31:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210524115853.6413-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 1:58 PM, Christoph Niedermaier wrote:
> Add maintainers for DH electronics DHCOM i.MX6
> and DHCOM/DHCOR STM32MP1 boards.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kernel@dh-electronics.com
> To: linux-kernel@vger.kernel.org
> ---
>   MAINTAINERS | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 07f0414bc2a5..c3836d34e844 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5320,6 +5320,19 @@ F:	include/net/devlink.h
>   F:	include/uapi/linux/devlink.h
>   F:	net/core/devlink.c
>   
> +DH ELECTRONICS IMX6 DHCOM BOARD SUPPORT
> +M:	Christoph Niedermaier <cniedermaier@dh-electronics.com>
> +L:	kernel@dh-electronics.com
> +S:	Maintained
> +F:	arch/arm/boot/dts/imx6*-dhcom-*
> +
> +DH ELECTRONICS STM32MP1 DHCOM/DHCOR BOARD SUPPORT
> +M:	Marek Vasut <marex@denx.de>
> +L:	kernel@dh-electronics.com
> +S:	Maintained
> +F:	arch/arm/boot/dts/stm32mp1*-dhcom-*
> +F:	arch/arm/boot/dts/stm32mp1*-dhcor-*
> +
>   DIALOG SEMICONDUCTOR DRIVERS
>   M:	Support Opensource <support.opensource@diasemi.com>
>   S:	Supported

Reviewed-by: Marek Vasut <marex@denx.de>
