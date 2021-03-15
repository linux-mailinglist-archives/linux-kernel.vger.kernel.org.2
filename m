Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AFF33AC2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 08:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCOHYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 03:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhCOHYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:24:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD03E64E61;
        Mon, 15 Mar 2021 07:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615793075;
        bh=bPgb6yp7ZSbsjfmG0toGXsrGC81m0xd6Hwvf92I5lQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUirYRY7evorBRjo6TqKpbhwLGoEgD8AgM9VtUN5wUaWR7TJf+qz/+UxXRYeGNMEf
         nBTO6JPklIvqrqYIgHe1/3MPAP2EXvA5UMPMADzh3JDLHfc6quppRl0dpMA4QTcfMi
         qWeaiW2J8snFkZJdqopW8WOltMmoBTp5qmdhLRvZ7zmKNE6N4Kt0FWDwmIc65AqmC/
         fWPBSifh0I8XFbpfZYwGj1xEb6a0U+2e6MsJui0BIEMoKaofeGx8XtqcZmFFde0fTn
         ugIO+3K3AKZF5o48nKW6y6EzYbZYcGdh6oM7ePmcYycifFzrxBxpC12DWA4A9OxJz3
         y0N1BINnET0+w==
Date:   Mon, 15 Mar 2021 15:24:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        krzk@kernel.org, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Subject: Re: [PATCH 2/3] arm64: dts: imx8mq-librem5-r3: Mark buck3 as always
 on
Message-ID: <20210315072429.GQ11246@dragon>
References: <20210311120259.3310499-1-martin.kepplinger@puri.sm>
 <20210311120259.3310499-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311120259.3310499-3-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 01:02:58PM +0100, Martin Kepplinger wrote:
> From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> 
> Commit 66d3f246d79f ("arm64: dts: librem5: Don't mark buck3 as always on")

I cannot find this commit.

Shawn

> removed always-on marking from GPU regulator, which is great for power
> saving - however it introduces additional i2c0 traffic which can be deadly
> for devices from the Dogwood batch.
> 
> To workaround the i2c0 shutdown issue on Dogwood, this commit marks
> buck3 as always-on again - but only for Dogwood (r3).
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
> index 0d38327043f8..cd3c3edd48fa 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
> @@ -28,6 +28,10 @@ &bq25895 {
>  	ti,termination-current = <144000>;  /* uA */
>  };
>  
> +&buck3_reg {
> +	regulator-always-on;
> +};
> +
>  &proximity {
>  	proximity-near-level = <25>;
>  };
> -- 
> 2.30.1
> 
