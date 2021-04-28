Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4290736D9A1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhD1Odq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235893AbhD1Odp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:33:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CCF561222;
        Wed, 28 Apr 2021 14:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619620378;
        bh=5JZ1l1s4Y2vK/57XPpm7zvUTJ2EPWsEpn8pjV5FYOtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOmvUrV1Dwul6FS9FUsEPT43s8sLrfFLiQ8redKaqVnDIOSKdfDWIxWql6nJRoH2x
         IDkcjnIQx1OeBMpHhB7xZhPKjVGUIJlj5EpVuK1xO94ryxYBOm6cDeCoFVX++ZOw6B
         9iAN5gwZD3RAI+xQPT81xQZC3zBr9eaym1lHvZHo=
Date:   Wed, 28 Apr 2021 16:32:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 091/190] Revert "pinctrl: axp209: Fix NULL pointer
 dereference after allocation"
Message-ID: <YIlyGC5U9X+lgK5n@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-92-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-92-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:26PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 1adc90c7395742827d754a5f02f446818a77c379.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/pinctrl/pinctrl-axp209.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
> index 207cbae3a7bf..58f7149dd39b 100644
> --- a/drivers/pinctrl/pinctrl-axp209.c
> +++ b/drivers/pinctrl/pinctrl-axp209.c
> @@ -365,8 +365,6 @@ static int axp20x_build_funcs_groups(struct platform_device *pdev)
>  		pctl->funcs[i].groups = devm_kcalloc(&pdev->dev,
>  						     npins, sizeof(char *),
>  						     GFP_KERNEL);
> -		if (!pctl->funcs[i].groups)
> -			return -ENOMEM;
>  		for (pin = 0; pin < npins; pin++)
>  			pctl->funcs[i].groups[pin] = pctl->desc->pins[pin].name;
>  	}
> -- 
> 2.31.1
> 

This change looks correct, dropping the revert from my tree.

greg k-h
