Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B1B30E071
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhBCRCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhBCRBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:01:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBABC061786;
        Wed,  3 Feb 2021 09:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=vCNwp1ztrRhufQxOnTaXRLMCznhFcCHyduDiVrgniXE=; b=FrIu5Kfl+rUWUTdqbFSWD4eTMp
        yW5uwfQk9GZiKIm17vaaTWmVzys8w4S+meiEjimFh8bS/+fV7NyEWxD6KiQ7G2cdr3TPL4IvKP5cQ
        rjmDKmTomlcw7g725P3js+N8U4rVxL0BrPfII84LdfuP0zgIeFr4GdAVWpuxCBAzLt/rLhv5jUldD
        LgV/1wAtAGegjm/CtvzL5mj1PIDLHQIDLosdXWvEJ9NnRL2RGYhmmmzhNZ3chq3m0S+os1bWZcJ7y
        b2YiItFbC3MjWBz1IDSpd+gS9hIxySzNCrHBs55QGnJeV0Nx7ABxpD07Ct0HYUfkBiPBRxaYA1wb6
        /d1fzPQw==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7LWI-0006vd-Tu; Wed, 03 Feb 2021 17:00:47 +0000
Subject: Re: [PATCH] doc: devicetree: bindings: usb: Change descibe to
 describe in usbmisc-imx.txt
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210203153414.17044-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <75f8cfc4-3911-a5df-f45f-ed3653ddcd0a@infradead.org>
Date:   Wed, 3 Feb 2021 09:00:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210203153414.17044-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 7:34 AM, Bhaskar Chowdhury wrote:
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

