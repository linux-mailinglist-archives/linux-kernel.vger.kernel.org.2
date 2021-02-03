Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05B830E067
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhBCRBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhBCQ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:59:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6FAC061573;
        Wed,  3 Feb 2021 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=TM+PUnveRGOnB3WSF1kKAA+3SmtRSuMXwf3qr/5ZRzc=; b=jd4Y/cv+tPOexRYYEaRvbjdtcl
        1huzRjw19rslJHMWIJZOenQ2SrHqfcA76vmMYNtkF1eT+/61D3oR2Q7EeGRYsP2ZMq1f3jrRHEepd
        o5DAMIEK5uPekSYzGALuJIl8DLnLmNSpe+p0HI6TzhoMZmM1SwUhEjebcA1qCbb/RLfqoiSWbVodo
        /KySHBSoQN7CEEQyTWiwEnYODBUO2IooJenY0wbblDIVw+nU2ayJt/+Lk2lKut7f4EoZIzn1Lg7dP
        qt2oJ4eK8BUtlT/zzev9/tLMzKyvXxKJKvYUOb0wVersbweR9+koGXxBvxoPt965WCeGU5Kqofswz
        IPkquitw==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7LUq-0006UQ-Cg; Wed, 03 Feb 2021 16:59:16 +0000
Subject: Re: [PATCH] doc: devicetree: bindings: usb: Chnage descibe to
 describe in usbmisc-imx.txt
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210203153315.15170-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fcb67f8f-e8bf-95cf-a72e-e4377d92b15e@infradead.org>
Date:   Wed, 3 Feb 2021 08:59:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210203153315.15170-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 7:33 AM, Bhaskar Chowdhury wrote:
> 
> s/descibe/describe/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/devicetree/bindings/usb/usbmisc-imx.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> index b353b9816487..b796836d2ce7 100644
> --- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> +++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> @@ -1,7 +1,7 @@
>  * Freescale i.MX non-core registers
> 
>  Required properties:
> -- #index-cells: Cells used to descibe usb controller index. Should be <1>
> +- #index-cells: Cells used to describe usb controller index. Should be <1>
>  - compatible: Should be one of below:
>  	"fsl,imx6q-usbmisc" for imx6q
>  	"fsl,vf610-usbmisc" for Vybrid vf610
> --
> 2.26.2
> 


-- 
~Randy

