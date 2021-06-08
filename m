Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B98339F590
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhFHLvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231751AbhFHLvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:51:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 392D96139A;
        Tue,  8 Jun 2021 11:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623152988;
        bh=SPVQkohvTqDM+QVrSw6JVqDCoe1Ro44Yw3kYDdtNkOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJRZwKeWk7K6mulYmlYZfbisD2v1YcBurfVmCCZaEUsW8tWz/xP8wfakgzJ4P1HYU
         93CjtIahDb0Pg7KVPloqITw/4JC6Bi8BDeEM9QZsFHkvaRWlRwSonvIuoZSydlVC59
         S1DHMgD2bfmtdp4sGvWMDq870m9AcwStIaP8hVOCHzYgRSAtAwtOHquQa+31dU/Vhw
         D80dgyApn9p9q4ElCZ3tz9fjrFaCwE6hW2bKAVBZYJzHJvJzkj21YUYDUqgOgb19H7
         xYZr2XF8vp6KHXHFmuFKhYvIevcs/a+1YK2q762kbNRcE3EuLEtjmnxdsLBBU9Mfkz
         sNzzSndq16qEg==
Date:   Tue, 8 Jun 2021 19:49:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 0/9] ARM: dts: fixes for Protonic boards
Message-ID: <20210608114941.GA29138@dragon>
References: <20210518082850.26048-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518082850.26048-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 10:28:41AM +0200, Oleksij Rempel wrote:
> This patch series provide different fixes for Protonic boards.
> 
> Oleksij Rempel (6):
>   ARM: dts: imx6dl-prtvt7: add TSC2046 touchscreen node
>   ARM: dts: imx6dl-prtvt7: Remove backlight enable gpio
>   ARM: dts: imx6dl-prtvt7: fix PWM cell count for the backlight node.
>   ARM: dts: imx6dl-plym2m: remove touchscreen-size-* properties
>   ARM: dts: imx6dl: enable touchscreen debounce filter on PLYM2M and
>     PRTVT7 boards
>   ARM: dts: imx6qdl-vicut1: add interrupt-counter nodes
> 
> Robin van der Gracht (3):
>   ARM: dts: imx6dl-prtvt7: Enable the VPU
>   ARM: dts: imx6dl-prtvt7: The sgtl5000 uses i2s not ac97
>   ARM: dts: imx6dl-prtvt7: Remove unused 'sound-dai-cells' from ssi1
>     node

Applied all, thanks.
