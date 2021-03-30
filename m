Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD8D34EB89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhC3PG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232344AbhC3PGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:06:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 985F361953;
        Tue, 30 Mar 2021 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617116808;
        bh=r66imObL2AqveAcJejt2ZwUD/4qqEVlJOoFJNxYlWHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZWEsJEvXZjJDQ+9CRPzaWyvgUNERG7xuNV2eilCCoI+JrahPQFkpdAehE/gCVJT7
         /KbhpBmcbJLcUegEcrIG8WttT3c5ix+3ThSiqx68Z6vVoQSj0sJJOZHhz6+GptEWhA
         hdLi/TgeLigVAEJI4RC/OJ/q3fGRPuRupblC+vRUdyoZ70Qm117PcQwNFgmqy49NkJ
         UtewoQCjz2l0OyNryMxzwkSzvixBEufOjhh2Y4FJDDeqZqUDPdcvnibIagZCzc+W/+
         ycyuAwBmI6zkt8pIPAW1edzSPcqe8fI6xBZXl3fgw2pfZPu/nDoDKdOerCNo0znJoI
         z9KFA/D8eEOoA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lRFxW-0002VE-69; Tue, 30 Mar 2021 17:07:10 +0200
Date:   Tue, 30 Mar 2021 17:07:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 5/7] USB: serial: xr: add support for XR21B1411
Message-ID: <YGM+nqOCC4CcX1hU@hovoldconsulting.com>
References: <cover.1616571453.git.mchehab+huawei@kernel.org>
 <b53d8889ed0f47c8ae12a8c65df7a970819e72fd.1616571453.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b53d8889ed0f47c8ae12a8c65df7a970819e72fd.1616571453.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 08:41:09AM +0100, Mauro Carvalho Chehab wrote:
> There's nothing special on this device: it has just one port.
> 
> The only difference is that it uses a different register set.

Not quite true. First, it uses 12-bit registers, which the driver isn't
updated for. Similarly, it used 12-bit register *addresses* which
likewise the driver isn't updated for and the upper bits are simply
discarded.

This device also doesn't support CS5 and CS6 which would need to be
handled.

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/usb/serial/xr_serial.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
> index 058624d15505..b1044dd3e994 100644
> --- a/drivers/usb/serial/xr_serial.c
> +++ b/drivers/usb/serial/xr_serial.c
> @@ -99,6 +99,7 @@ struct xr_txrx_clk_mask {
>  #define VIA_CDC_REGISTER		-1
>  
>  enum xr_model {
> +	XR21B1411,
>  	XR21V141X,
>  	XR21B142X,
>  	MAX_XR_MODELS
> @@ -132,6 +133,30 @@ enum xr_hal_type {
>  };
>  
>  static const int xr_hal_table[MAX_XR_MODELS][MAX_XR_HAL_TYPE] = {
> +	[XR21B1411] = {
> +		[REG_ENABLE] =				0xc00,
> +		[REG_FORMAT] =				VIA_CDC_REGISTER,
> +		[REG_FLOW_CTRL] =			0xc06,
> +		[REG_XON_CHAR] =			0xc07,
> +		[REG_XOFF_CHAR] =			0xc08,
> +		[REG_TX_BREAK] =			0xc0a,
> +		[REG_RS485_DELAY] =			0xc0b,
> +		[REG_GPIO_MODE] =			0xc0c,
> +		[REG_GPIO_DIR] =			0xc0d,
> +		[REG_GPIO_SET] =			0xc0e,
> +		[REG_GPIO_CLR] =			0xc0f,
> +		[REG_GPIO_STATUS] =			0xc10,
> +		[REG_GPIO_INT_MASK] =			0xc11,
> +		[REG_CUSTOMIZED_INT] =			0xc12,
> +		[REG_GPIO_PULL_UP_ENABLE] =		0xc14,
> +		[REG_GPIO_PULL_DOWN_ENABLE] =		0xc15,
> +		[REG_LOOPBACK] =			0xc16,
> +		[REG_LOW_LATENCY] =			0xcc2,
> +		[REG_CUSTOM_DRIVER] =			0x20d,
> +
> +		[REQ_SET] =				0,
> +		[REQ_GET] =				1,
> +	},
>  	[XR21V141X] = {
>  		[REG_ENABLE] =				0x03,
>  		[REG_FORMAT] =				0x0b,

Johan
