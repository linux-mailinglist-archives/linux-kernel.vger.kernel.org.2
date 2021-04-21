Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5DB366E83
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243693AbhDUOwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240369AbhDUOwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:52:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8881D613B6;
        Wed, 21 Apr 2021 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619016729;
        bh=KV+Ho0UxpPWM/DJ7vXp8Ca8eQ9iHjx1m52Pvj4SRTTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHvRdsmx9g3QMyv663N5BwhMOXbVYkurwTlbFgvVKKB9UT2X4//bbT0RhohT21j74
         MVHo3ZXyl+CkWhY7Mv+iQEljzUJmYGD3WHYiksDdPXswTJQ9F1ZlGYOeSU+StZ7Fk4
         1SyyrulMrr9revyUAR0g/A/P6S6x2Wrjdaj0qoPkIQ2rbHATxsboa6aNNutMXKq3Cu
         i592eaH5knlXyk+uRET3/amSRoUpLlO2sd2gBKxNRDeDxCTUTQs1f5yvQglmffePo8
         wgHlMWhRPTwAhMtBQxoL1uINWC/9jI5FF1izA2NnudpoL4pbkRIMbaXgVOHw18wnrc
         d32ps7+hnPNtQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZED6-00036M-UM; Wed, 21 Apr 2021 16:52:13 +0200
Date:   Wed, 21 Apr 2021 16:52:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Pho Tran <photranvan0712@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hung.Nguyen@silabs.com,
        Tung.Pham@silabs.com, Pho Tran <pho.tran@silabs.com>
Subject: Re: [PATCH v9] USB: serial: cp210x: Add support for GPIOs on CP2108
Message-ID: <YIA8HD0S6C+x5ZC9@hovoldconsulting.com>
References: <20210408103607.2077-1-photranvan0712@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408103607.2077-1-photranvan0712@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 05:36:07PM +0700, Pho Tran wrote:
> From: Pho Tran <pho.tran@silabs.com>
> 
> Similar to other CP210x devices, GPIO interfaces (gpiochip) should be
> supported for CP2108.
 
> +/*
> + * Quad Port Config definitions
> + * Refer to https://www.silabs.com/documents/public/application-notes/an978-cp210x-usb-to-uart-api-specification.pdf
> + * for more information.
> + * CP210X_VENDOR_SPECIFIC, CP210X_GET_PORTCONFIG call reads these 0x49 bytes
> + * on a CP2108 chip.
> + * CP2108 Quad Port State structure(used in Quad Port Config structure)
> + */
> +struct cp210x_quad_port_state {
> +	__le16 gpio_mode_PB0;
> +	__le16 gpio_mode_PB1;
> +	__le16 gpio_mode_PB2;
> +	__le16 gpio_mode_PB3;
> +	__le16 gpio_mode_PB4;
> +
> +
> +	__le16 gpio_lowpower_PB0;
> +	__le16 gpio_lowpower_PB1;
> +	__le16 gpio_lowpower_PB2;
> +	__le16 gpio_lowpower_PB3;
> +	__le16 gpio_lowpower_PB4;
> +
> +	__le16 gpio_latch_PB0;
> +	__le16 gpio_latch_PB1;
> +	__le16 gpio_latch_PB2;
> +	__le16 gpio_latch_PB3;
> +	__le16 gpio_latch_PB4;
> +};
> +
> +// Cp2108 Quad Port Config structure
> +struct cp210x_quad_port_config {
> +	struct cp210x_quad_port_state reset_state;
> +	struct cp210x_quad_port_state suspend_state;
> +	u8 ipdelay_IFC[4];
> +	u8 enhancedfxn_IFC[4];
> +	u8 enhancedfxn_device;
> +	u8 extclkfreq[4];
> +} __packed;

One more thing; I noticed that the layout of the other port-config
structures do not match the ones used by your library API, which is what
the above pdf documents (e.g. they have additional padding).

Did you verify that the above layout is actually correct? And did you
try changing the pin functions in EEPROM and make sure that your code
handles it as expected?

Is there any corresponding document for the actual device protocol?

Johan
