Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA457410B69
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbhISMDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 08:03:37 -0400
Received: from rosenzweig.io ([138.197.143.207]:46574 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235290AbhISMDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 08:03:33 -0400
Date:   Sun, 19 Sep 2021 07:33:58 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Alexander Graf <graf@amazon.com>
Subject: Re: [RFT PATCH 9/9] usb: typec: tipd: Remove FIXME about testing
 with I2C_FUNC_I2C
Message-ID: <YUcgJlaw+9yrB+tZ@sunset>
References: <20210918120934.28252-1-sven@svenpeter.dev>
 <20210918120934.28252-10-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918120934.28252-10-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

On Sat , Sep 18, 2021 at 02:09:34PM +0200, Sven Peter wrote:
> The Apple i2c bus uses I2C_FUNC_I2C and I've tested this quite
> extensivly in the past days. Remove the FIXME about that testing :-)
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/usb/typec/tipd/core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 26807c050662..3b6878e22ce9 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -673,9 +673,6 @@ static int tps6598x_probe(struct i2c_client *client)
>  	/*
>  	 * Checking can the adapter handle SMBus protocol. If it can not, the
>  	 * driver needs to take care of block reads separately.
> -	 *
> -	 * FIXME: Testing with I2C_FUNC_I2C. regmap-i2c uses I2C protocol
> -	 * unconditionally if the adapter has I2C_FUNC_I2C set.
>  	 */
>  	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		tps->i2c_protocol = true;
> -- 
> 2.25.1
> 
