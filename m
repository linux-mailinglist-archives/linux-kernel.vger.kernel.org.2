Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617033AE30A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 08:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFUGUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 02:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhFUGU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:20:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 877C76100B;
        Mon, 21 Jun 2021 06:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624256294;
        bh=YFZygVbRLxrAS2J28Fh5EQZmQgGwcUaOw0GMfbFbMUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iqmDwOxrZLPQoYJ27yefzt4i0apxEJoiWDl6okQepYJuyM0oq1k2774163AhJOkNj
         8TgJomOdjyk26J04eN6i16uJu2Mx/dhyh05IC0npJecRMjSDJek7JVHkuQ4nWMWdeX
         oYgac/cSufdvyDR6nvg9QpjaUKxYuOUtBtzGqgRHguqBpvYgv85cfuRxcMmCRCsaDa
         D6zhTII9kWmSxbxK3ZOhfyfkp0Kpo03ba0JPUYrkj/i50k7bQkf8ENcByZ9nNFP614
         znf44JUyZFdoY5jOmF1N3Ewy2xzAocWYDvDEwEIwTeA42W3U2CE9Xr5s0RtbfYWAyv
         wsJvUTexufetw==
Date:   Mon, 21 Jun 2021 11:48:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     robh+dt@kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kishon@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] phy: amlogic: Add a new driver for the HDMI TX PHY
 on Meson8/8b/8m2
Message-ID: <YNAvItt8BQH1QmQT@vkoul-mobl>
References: <20210604190338.2248295-1-martin.blumenstingl@googlemail.com>
 <20210604190338.2248295-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604190338.2248295-3-martin.blumenstingl@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-06-21, 21:03, Martin Blumenstingl wrote:
> Amlogic Meson8/8b/8m2 have a built-in HDMI PHY in the HHI register
> region. Unfortunately only few register bits are documented. For
> HHI_HDMI_PHY_CNTL0 the magic numbers are taken from the 3.10 vendor
> kernel.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/phy/amlogic/Kconfig              |  11 ++
>  drivers/phy/amlogic/Makefile             |   1 +
>  drivers/phy/amlogic/phy-meson8-hdmi-tx.c | 150 +++++++++++++++++++++++
>  3 files changed, 162 insertions(+)
>  create mode 100644 drivers/phy/amlogic/phy-meson8-hdmi-tx.c
> 
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index db5d0cd757e3..e6c3a2a8b769 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -2,6 +2,17 @@
>  #
>  # Phy drivers for Amlogic platforms
>  #
> +config PHY_MESON8_HDMI_TX
> +	tristate "Meson8, Meson8b and Meson8m2 HDMI TX PHY driver"
> +	default ARCH_MESON
> +	depends on (ARCH_MESON && ARM) || COMPILE_TEST

depends on ARM seems redundant..

> + * Meson8, Meson8b and Meson8m2 HDMI TX PHY.
> + *
> + * Copyright (C) 2020 Martin Blumenstingl <martin.blumenstingl@googlemail.com>

2021..
-- 
~Vinod
