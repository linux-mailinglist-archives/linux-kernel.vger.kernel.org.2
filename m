Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02842458AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbhKVJGa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Nov 2021 04:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhKVJG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:06:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D13C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:03:21 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mp5EK-0003l5-Mh; Mon, 22 Nov 2021 10:03:16 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mp5EK-000584-31; Mon, 22 Nov 2021 10:03:16 +0100
Message-ID: <44f6cc1f52e75cbbb8aebb0d4648c94ae479ef43.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/3] phy: amlogic: phy-meson-gxl-usb2: fix shared
 reset controller use
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>, khilman@baylibre.com
Cc:     balbi@kernel.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Mon, 22 Nov 2021 10:03:16 +0100
In-Reply-To: <20211112162827.128319-2-aouledameur@baylibre.com>
References: <20211112162827.128319-1-aouledameur@baylibre.com>
         <20211112162827.128319-2-aouledameur@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amjad,

On Fri, 2021-11-12 at 17:28 +0100, Amjad Ouled-Ameur wrote:
> Use reset_control_rearm() call if an error occurs in case
> phy_meson_gxl_usb2_init() fails after reset() has been called ; or in case
> phy_meson_gxl_usb2_exit() is called i.e the resource is no longer used
> and the reset line may be triggered again by other devices.
> 
> reset_control_rearm() keeps use of triggered_count sane in the reset
> framework. Therefore, use of reset_control_reset() on shared reset line
> should be balanced with reset_control_rearm().
> 
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/phy/amlogic/phy-meson-gxl-usb2.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/amlogic/phy-meson-gxl-usb2.c b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
> index 2b3c0d730f20..9a9c769ecabc 100644
> --- a/drivers/phy/amlogic/phy-meson-gxl-usb2.c
> +++ b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
> @@ -110,8 +110,10 @@ static int phy_meson_gxl_usb2_init(struct phy *phy)
>  	int ret;
>
>  	ret = reset_control_reset(priv->reset);
> -	if (ret)
> +	if (ret) {
> +		reset_control_rearm(priv->reset);

I don't understand this. If reset_control_reset() returns an error for a
shared reset, it should have either
- returned before incrementing triggered_count, or
- incremented triggered_count, got a failed reset op, decremented
  triggered_count again

In both cases there should be no need to rearm.


regards
Philipp
