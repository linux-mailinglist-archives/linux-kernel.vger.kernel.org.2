Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAB540FAD1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbhIQOyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:54:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238830AbhIQOxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:53:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D885A60F38;
        Fri, 17 Sep 2021 14:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631890314;
        bh=5bn6TVRH4o0yTXZajjf9gWHcUecjd1FhhFrv4hJWPrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8Cd2RlthxQIf53iqN06nG9Vvq6PphlGUCdSLDX63hUJjngSrPQRGUPHQ1K4QNdZg
         Eg5ginUxgBKUA3hBLe/09GUxXO1AYqXHoZJsRgLfpWUi1aEPGg4Ze0V5XXyuiR660o
         RvQKc87qXIlwdBKFUQzDZkgvkr6rMmUuAoDztowg6zbfAqJgP22Z+JphM4Ja330JZp
         sqOW7KpugOkXvpS/pGuGKN0QySSDlzr9unHt5zPF9tis2Of/G5X78izMxZVYzjHD57
         q2dAzKppd0SjMBwdbrOSnTeF8vq+mjYdw6OGk1C8GnUviqWpR5aF1RRNQtdMWpJnek
         KL2aL9gDyLgrw==
Date:   Fri, 17 Sep 2021 15:51:48 +0100
From:   Will Deacon <will@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: restricted dma: Fix condition for rmem init
Message-ID: <20210917145147.GA10275@willie-the-truck>
References: <20210917131423.2760155-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917131423.2760155-1-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 02:14:23PM +0100, David Brazdil wrote:
> of_dma_set_restricted_buffer fails to handle negative return values from
> of_property_count_elems_of_size, e.g. when the property does not exist.
> This results in an attempt to assign a non-existent reserved memory
> region to the device and a warning being printed. Fix the condition to
> take negative values into account.
> 
> Fixes: f3cfd136aef0 ("of: restricted dma: Don't fail device probe on
> rmem init failure")
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  drivers/of/device.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 5b043ee30824..b0800c260f64 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -85,7 +85,11 @@ of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
>  			break;
>  	}
>  
> -	if (i != count && of_reserved_mem_device_init_by_idx(dev, of_node, i))
> +	/*
> +	 * Attempt to initialize a restricted-dma-pool region if one was found.
> +	 * Note that count can hold a negative error code.
> +	 */
> +	if (i < count && of_reserved_mem_device_init_by_idx(dev, of_node, i))
>  		dev_warn(dev, "failed to initialise \"restricted-dma-pool\" memory node\n");

/me shakes fist at of_property_count_elems_of_size()

Thanks for the fix:

Acked-by: Will Deacon <will@kernel.org>

Will
