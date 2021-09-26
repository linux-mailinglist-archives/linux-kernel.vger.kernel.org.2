Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9DF4186C5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 08:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhIZGxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 02:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhIZGxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 02:53:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10DCB60EFF;
        Sun, 26 Sep 2021 06:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632639114;
        bh=gVidkyb0TWHeyFaqlS+HQ7fVRPERCbmqPvMjmlYgrI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3FbnnrgrbkQnoP7Czee/vvG5Y0NdqEJza6p8WFDSPIgDNdO6FvCOncS9qtts1eTx
         JcaclcQpOtbZcHMskroBP564psTjCc+EmjDuf6eGgMJxBN6ejsUFPFkOyP/eO2q1zG
         tP0lLHaAqQAoEf5jDmj2jy6k0HcBYbyS8AFAinZ8=
Date:   Sun, 26 Sep 2021 08:51:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Estner <michaelestner@web.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] avoid crashing the kernel
Message-ID: <YVAYgp+XnCkjPigd@kroah.com>
References: <20210925200433.8329-1-michaelestner@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925200433.8329-1-michaelestner@web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 10:04:30PM +0200, Michael Estner wrote:
> To avoid chrashing the kernel I use WARN_ON instead.
> 
> Signed-off-by: Michael Estner <michaelestner@web.de>
> ---
>  drivers/staging/most/i2c/i2c.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Hi,

First off, thanks for the changes, but they need a bit more work.

Your subject line should match the others done for this file, so you
need a "staging: most:" prefix like others.  To see this better, do:
	git log --oneline the_file_i_am_touching.c


Also take a look at the kernel documentation for how to write a good
changelog text.  Your wording above needs some work...

> diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2c.c
> index 7042f10887bb..e1edd892f9fd 100644
> --- a/drivers/staging/most/i2c/i2c.c
> +++ b/drivers/staging/most/i2c/i2c.c
> @@ -68,7 +68,7 @@ static int configure_channel(struct most_interface *most_iface,
>  	struct hdm_i2c *dev = to_hdm(most_iface);
>  	unsigned int delay, pr;
> 
> -	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
> +	WARN_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);

You really aren't changing much here, for systems running with "panic on
warn", right?

To solve this correctly you should either:
	- determine that these are impossible to hit and remove the test
	  entirely
	- determine that these are possible to hit, and turn them into a
	  real test and handle the error properly.

thanks,

greg k-h
