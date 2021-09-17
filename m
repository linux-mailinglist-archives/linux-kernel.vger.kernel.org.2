Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7940F24F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhIQG2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233058AbhIQG2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:28:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A22960FBF;
        Fri, 17 Sep 2021 06:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631860000;
        bh=pMnwYHfKcuoWM8G/rwO1Komn0D0FA1nplQtWRf5fIM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hG45CZUDBpGu6abOksFdgBBJ46DWd5v0kNg18ZH8M5UwRQlKtUbJhwL+/qenNCPTV
         8c1etUcZ55pZjP+/V5kFARM6jVqtDEnIIiV7nlpjjFEysMdOsTtrfvBKeL0izTkzfW
         x4vJnV6vOs6PgbKNqylWqQhzYJunAEnx3DpFkqd0=
Date:   Fri, 17 Sep 2021 08:26:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     rafael@kernel.org, broonie@kernel.org, andy.shevchenko@gmail.com,
        a.hajda@samsung.com, Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Clarify that dev_err_probe() is OK even
 w/out -EPROBE_DEFER
Message-ID: <YUQ1HW0P9e0ENGRE@kroah.com>
References: <20210916161931.1.I32bea713bd6c6fb419a24da73686145742b6c117@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916161931.1.I32bea713bd6c6fb419a24da73686145742b6c117@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 04:19:40PM -0700, Douglas Anderson wrote:
> There is some debate about whether it's deemed acceptable to call
> dev_err_probe() if you know that the error code can never be
> -EPROBE_DEFER. Clarify in the function comments that this is
> OK. Specifically this makes us able to transform code like this:
> 
>   ret = do_something_that_cant_defer();
>   if (ret < 0) {
>     dev_err(dev, "The foo failed to bar (%pe)\n", ERR_PTR(ret));
>     return ret;
>   }
> 
> to code like this:
>   ret = do_something_that_cant_defer();
>   if (ret < 0)
>     return dev_err_probe(dev, ret, "The foo failed to bar\n");
> 
> It is also possible that in the future folks might want a CONFIG
> option to strip out all probe error strings to save space (keeping
> non-probe errors) with the argument that probe errors rarely happen
> after bringup. Having probe errors reported with a consistent function
> would allow that.
> 
> Cc: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/base/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index e65dd803a453..85b8955717fc 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4653,6 +4653,11 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>   *
>   * 	return dev_err_probe(dev, err, ...);
>   *
> + * Note that it is deemed acceptable to use this function for error
> + * prints during probe even if the @err is known to never be -EPROBE_DEFER.
> + * The benefit compared to a normal dev_err() is the standardized format
> + * of the error code and the fact that the error code is returned.
> + *
>   * Returns @err.
>   *
>   */
> -- 
> 2.33.0.464.g1972c5931b-goog
> 

Nice, no objection from me, I'll go queue this up.

greg k-h
