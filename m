Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9E3315D98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhBJCxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:53:45 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:59320 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233779AbhBJCxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:53:36 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1l9fcW-005Eb7-Sz; Wed, 10 Feb 2021 03:52:48 +0100
Date:   Wed, 10 Feb 2021 03:52:48 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        linux-usb@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bastien Nocera <hadess@hadess.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] usb: misc: usb5744: Add support for USB hub
 controller
Message-ID: <YCNKgAUi5d6LY6zf@lunn.ch>
References: <cover.1612864393.git.michal.simek@xilinx.com>
 <e1e1d47982018ccd5a763f199680babc0df848c8.1612864393.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e1d47982018ccd5a763f199680babc0df848c8.1612864393.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 10:53:20AM +0100, Michal Simek wrote:
> +static int usb5744_i2c_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	/* Trigger gpio reset to the hub. */
> +	ret = usb5744_init_hw(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Send SMBus command to boot hub. */
> +	ret = i2c_smbus_write_word_data(client, 0xAA, swab16(0x5600));

Hi Michal

This is not my area of the kernel. But that swab16() stood out, and
made me wonder about endianness. Will this work correctly on big and
little endian hosts?

       Andrew
