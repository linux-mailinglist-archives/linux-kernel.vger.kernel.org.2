Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CB73607A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhDOKv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhDOKvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:51:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69042C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 03:51:27 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lWzan-0006nD-JK; Thu, 15 Apr 2021 12:51:25 +0200
Subject: Re: [PATCH 10/13] dt-bindings: mfd: add vref_ddr-supply to st,stpmic1
 yaml
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>, arnd@arndb.de,
        robh+dt@kernel.org, Marek Vasut <marex@denx.de>,
        jagan@amarulasolutions.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kuba@kernel.org
References: <20210415101037.1465-1-alexandre.torgue@foss.st.com>
 <20210415101037.1465-11-alexandre.torgue@foss.st.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <9fc27672-765b-9bd3-bb0a-d9159cb7d502@pengutronix.de>
Date:   Thu, 15 Apr 2021 12:51:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210415101037.1465-11-alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15.04.21 12:10, Alexandre Torgue wrote:
> Add vref_ddr-supply to the STPMIC1 regulators supplies pattern
> list.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> index 305123e74a58..ffc32d209496 100644
> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> @@ -184,7 +184,7 @@ properties:
>          additionalProperties: false
>  
>      patternProperties:
> -      "^(buck[1-4]|ldo[1-6]|boost|pwr_sw[1-2])-supply$":
> +      "^(buck[1-4]|ldo[1-6]|boost|vref_ddr|pwr_sw[1-2])-supply$":

IIRC, vref-ddr was a hack because a change in the regulator core broke
the STM32MP1 boards. I believe vref-ddr should be removed altogether
instead. It's supplied from BUCK2IN, which is already in the binding,
so it's redundant.

Cheers,
Ahmad

>          description: STPMIC1 voltage regulators supplies
>  
>        "^(buck[1-4]|ldo[1-6]|boost|vref_ddr|pwr_sw[1-2])$":
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
