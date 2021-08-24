Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CFA3F576B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 06:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhHXExK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 00:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhHXExJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 00:53:09 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355F5C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 21:52:26 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id e14so21814986qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 21:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yq1+yUuzy73wmTqQz582kZA2h/Vz+BygSw30/pNdJ98=;
        b=jK5R/1J6FGwa7V2HDP+dXM6DehJp7486SAVwEyNuLuzgvf+sUdjX/wWc+Bf2BgAy8q
         wgdW3wlF0ucp00hRnzrnw2rUIeY3lexLJMLtcoMq7eJg5AT8W5UvOj03nQaqgwALNixa
         7+wLEGad9gskiyOBs9z/0F8hP572nFkcRbbLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yq1+yUuzy73wmTqQz582kZA2h/Vz+BygSw30/pNdJ98=;
        b=HWYcLFw4G+Fjr6RpTtjTF5lYUdsxFuiFT1mpWHCa6Vv7mcgnYY2azKgcPqu/isvbnG
         7rxdwKvg8c3Ooxfp34lR8LBBDPW+XrWOJmG68IB+58zBSxDSMKC0gUDFlgaAJ7ztwUkN
         1jcTJuY7oR1aUNyYP5GagPU1eSHtRx1ZHksRDtyM4mlf5a+JVVn/K6FISgvYm+dqg2lN
         VUKOp8ub8MY+RgYg6UucVoWoemIyblne7wQL2Vvqq6aRrS9nDWOYOzUkR09meM9lGBJ6
         6CK2WAIlKL5hnET859UKzN1kanHLc8gowjk9BHfWKyBfeye9GdF34uk6no+FT026nsl8
         JEMQ==
X-Gm-Message-State: AOAM531oQuVWf5LZkmn4YeTrIL0M4k/rQ6ahB/xBBMMPESnW3hxU/6ro
        kQKxeEZzYFbnlbn4DJV2SaxHHrzFSlyffZLd8iI=
X-Google-Smtp-Source: ABdhPJyx48VNVn8ol4dHMHg/fYDo3nox3UD2s0gnTQTNfkARsC33l5P49m6oxctyuUZfRLtV/EdKCXG0diG20/iqz0w=
X-Received: by 2002:a37:a094:: with SMTP id j142mr25021107qke.465.1629780745130;
 Mon, 23 Aug 2021 21:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210823130043.1087204-1-yangyingliang@huawei.com>
In-Reply-To: <20210823130043.1087204-1-yangyingliang@huawei.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 24 Aug 2021 04:52:13 +0000
Message-ID: <CACPK8XeUJV2cCaCu+xnX-pGkHVxV9vp3LPj8dJbJbi8SC4Bazw@mail.gmail.com>
Subject: Re: [PATCH -next] soc: aspeed-lpc-ctrl: Fix missing
 clk_disable_unprepare() on error in aspeed_lpc_ctrl_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 at 12:55, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Fix the missing clk_disable_unprepare() before return
> from aspeed_lpc_ctrl_probe() in the error handling case.
>
> Fixes: 2f9b25fa6682 ("soc: aspeed: Re-enable FWH2AHB on AST2600")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> index 6893c5ec3259..f4c989584d6b 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> @@ -312,7 +312,8 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>                 lpc_ctrl->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2600-scu");
>                 if (IS_ERR(lpc_ctrl->scu)) {
>                         dev_err(dev, "couldn't find scu\n");
> -                       return PTR_ERR(lpc_ctrl->scu);
> +                       rc = PTR_ERR(lpc_ctrl->scu);
> +                       goto err;

Thanks for the patch. Alternatively, we could move this code above the
devm_clk_get/clk_prepare_enable. I would prefer that option, if you
want to send a v2.

Cheers,

Joel
