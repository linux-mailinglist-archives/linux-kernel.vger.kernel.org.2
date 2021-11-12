Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E78444E97B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhKLPHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:07:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233894AbhKLPHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:07:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA04560F46;
        Fri, 12 Nov 2021 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636729457;
        bh=FAEIBNvTn1zOktswvkkmGfx7OY/1WlaJ4Jzc0VA/5nE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NvPSueUATMmrk/gAEfB0p73VbNnEgOhM7PCDN+ojQgPbcnIRvFtVtLCxA0ZXRxDWb
         nBJqPugXQfMltZW4EOHiuITw4VpfimezaoZV5eUT4M6PI5tjWqui/mfYzjQOq7/tAi
         Vhj8oLvNus2mTSfPPUg49+ldqVNllbG2ccFFYLQPXOtr6tZVnm526SBYYOeyyy48cG
         UW89ARuWUpbL4X1qwkQhO5GSxwl9PT1B6YyBnkdKUGDgeboxKaIuHPbHUB77Nlr7zU
         5iwHCJUK8kZxhU+MluN/lHHWbDOUWpwuux+sw2vOK5x2E36vDYwK+ngKeRz5CgSu8q
         9pE/4fTJ71qVw==
Date:   Fri, 12 Nov 2021 09:04:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] of/irq: Don't ignore interrupt-controller when
 interrupt-map failed
Message-ID: <20211112150415.GA1401861@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112143644.434995-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 02:36:44PM +0000, Marc Zyngier wrote:
> Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
> to an interrupt controller"), the irq code favors using an interrupt-map
> over a interrupt-controller property if both are available, while the
> earlier behaviour was to ignore the interrupt-map altogether.
> 
> However, we now end-up with the opposite behaviour, which is to
> ignore the interrupt-controller property even if the interrupt-map
> fails to match its input. This new behaviour breaks the AmigaOne
> X1000 machine, which ships with an extremely "creative" (read:
> broken) device tree.
> 
> Fix this by allowing the interrupt-controller property to be selected
> when interrupt-map fails to match anything.
> 
> Fixes: 041284181226 ("of/irq: Allow matching of an interrupt-map local to an interrupt controller")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

I'm not qualified to review this, but since 041284181226 was merged
via my tree along with the rest of the Apple stuff, let me know if
you'd like me to merge this.

I see Rob has a comment, so if you want to take care merging it
yourself, that's certainly fine with me.

> ---
>  drivers/of/irq.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 32be5a03951f..508fb1717de3 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -161,9 +161,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>  		 * if it is then we are done, unless there is an
>  		 * interrupt-map which takes precedence.
>  		 */
> +		bool intc = of_property_read_bool(ipar, "interrupt-controller");
> +
>  		imap = of_get_property(ipar, "interrupt-map", &imaplen);
> -		if (imap == NULL &&
> -		    of_property_read_bool(ipar, "interrupt-controller")) {
> +		if (imap == NULL && intc) {
>  			pr_debug(" -> got it !\n");
>  			return 0;
>  		}
> @@ -244,8 +245,14 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>  
>  			pr_debug(" -> imaplen=%d\n", imaplen);
>  		}
> -		if (!match)
> +		if (!match) {
> +			if (intc) {
> +				pr_debug("%pOF interrupt-map failed, using interrupt-controller\n", ipar);
> +				return 0;
> +			}
> +
>  			goto fail;
> +		}
>  
>  		/*
>  		 * Successfully parsed an interrrupt-map translation; copy new
> -- 
> 2.30.2
> 
