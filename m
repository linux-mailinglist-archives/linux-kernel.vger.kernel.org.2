Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA3E41E949
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 10:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352687AbhJAJBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 05:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhJAJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 05:01:20 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE076C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 01:59:35 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:5c32:c2e7:df7:3731])
        by michel.telenet-ops.be with bizsmtp
        id 0YzX2600c1ZoSwU06YzXAW; Fri, 01 Oct 2021 10:59:32 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mWEOB-000yoR-7U; Fri, 01 Oct 2021 10:59:31 +0200
Date:   Fri, 1 Oct 2021 10:59:31 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Shixin <liushixin2@huawei.com>, linux-usb@vger.kernel.org,
        =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH fix] Revert "USB: bcma: Add a check for devm_gpiod_get"
In-Reply-To: <20210831065419.18371-1-zajec5@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110011054560.233543@ramsan.of.borg>
References: <20210831065419.18371-1-zajec5@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-341794510-1633078771=:233543"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-341794510-1633078771=:233543
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

 	Hi Rafał,

On Tue, 31 Aug 2021, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
>
> This reverts commit f3de5d857bb2362b00e2a8d4bc886cd49dcb66db.
>
> That commit broke USB on all routers that have USB always powered on and
> don't require toggling any GPIO. It's a majority of devices actually.
>
> The original code worked and seemed safe: vcc GPIO is optional and
> bcma_hci_platform_power_gpio() takes care of checking the pointer before
> using it.
>
> This revert fixes:
> [   10.801127] bcma_hcd: probe of bcma0:11 failed with error -2
>
> Cc: Chuhong Yuan <hslester96@gmail.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Thanks for your patch, which is being backported to stable.

> --- a/drivers/usb/host/bcma-hcd.c
> +++ b/drivers/usb/host/bcma-hcd.c
> @@ -406,12 +406,9 @@ static int bcma_hcd_probe(struct bcma_device *core)
> 		return -ENOMEM;
> 	usb_dev->core = core;
>
> -	if (core->dev.of_node) {
> +	if (core->dev.of_node)
> 		usb_dev->gpio_desc = devm_gpiod_get(&core->dev, "vcc",
> 						    GPIOD_OUT_HIGH);


> -		if (IS_ERR(usb_dev->gpio_desc))
> -			return PTR_ERR(usb_dev->gpio_desc);
> -	}

This means real errors and probe deferral are no longer handled.
What about using devm_gpiod_get_optional() instead?
After that, the check in bcma_hci_platform_power_gpio() can be removed,
as gpiod_set_value() handles NULL pointers fine.

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
--8323329-341794510-1633078771=:233543--
