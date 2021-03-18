Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BCB340C84
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhCRSJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbhCRSJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:09:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CE8C06174A;
        Thu, 18 Mar 2021 11:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=tNPxUnGftRpagH2OZ6eFkvX23OEU1dEHYoHHt3Um+6E=; b=o/laOTbAAXP7yew+2Zcv2Vsy/3
        je7CEMSrkBD9eei2m6FwB+44rpjpp6epNUYU+TSIjEIAgMEXXqLMgpuPs+v+N7F5yaAYjAhm0wJrs
        MqUfeJxgDf5w375tBjFk7UHYPBpUyMUkxJ0qPGQOts1oKlda2xtZGIIRWUihW49T3/CXNpKEaESWI
        nZIiIBi+QYpDGQ1wC9wV//g8+HpYx6hy3GKEoNCWLpnpOSnZdfYQBgsb5Z1aee2HgBPPX4+iGYglg
        TtBOVVQYgY2U7Hq8OLEUZb5WTl85QYCdQTvfudF25TcOS8TMyu03g5j6iXfV+Dgx7GwMEfT3QSChr
        tRy/MF/Q==;
Received: from [2601:1c0:6280:3f0::9757]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMx5D-003KSi-1I; Thu, 18 Mar 2021 18:09:22 +0000
Subject: Re: [PATCH] ARM: boot: dts: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210318095237.28436-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d4a480e9-de13-b697-e624-1b2aa944c381@infradead.org>
Date:   Thu, 18 Mar 2021 11:09:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318095237.28436-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 2:52 AM, Bhaskar Chowdhury wrote:
> 
> s/conlicts/conflicts/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/arm/boot/dts/sama5d3.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index 7c979652f330..d1841bffe3c5 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -709,7 +709,7 @@ pinctrl_mmc0_dat4_7: mmc0_dat4_7 {
>  						atmel,pins =
>  							<AT91_PIOD 5 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PD5 periph A MCI0_DA4 with pullup, conflicts with TIOA0, PWMH2 */
>  							 AT91_PIOD 6 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PD6 periph A MCI0_DA5 with pullup, conflicts with TIOB0, PWML2 */
> -							 AT91_PIOD 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PD7 periph A MCI0_DA6 with pullup, conlicts with TCLK0, PWMH3 */
> +							 AT91_PIOD 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PD7 periph A MCI0_DA6 with pullup, conflicts with TCLK0, PWMH3 */
>  							 AT91_PIOD 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PD8 periph A MCI0_DA7 with pullup, conflicts with PWML3 */
>  					};
>  				};
> --
> 2.26.2
> 


-- 
~Randy

