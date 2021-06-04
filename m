Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4D39B46F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhFDH7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhFDH7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:59:15 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831B5C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 00:57:29 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w33so12739164lfu.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWNZl0ucUIFZHgJOXmZoNpmqFeVWv1dfIUYGYZtyZq8=;
        b=YD41o4Wr7a/idp56ZpEObm2CwwqDUbY6drvE+mOzLOoa03PV9n0xEWRiLqclW/FBmq
         OwgpJOvtMM2iQWxnV9Wq37NdNjn1GOCUkjL11lWt5DL1f4+9NeQ85sBrigTlrl5I1FMJ
         Or/dIdmWn1Y1NGbgwGrOsKdr5fjhmRe8VzNurNXxGb6B1GJ3G+06SiJEmD4xYeJw2Adq
         wjAY+P4e6ZXgaDLFUm3Azmey6S8C5JKflGOGxt7ZTqN+AegnhOCEpSaWlTXoHFBBli+P
         8MKJQyqtV9hy57lnpE6PIFu2pVsxCqYyIeGKdHGGnV9EOwAs9DjquQUBRDJ/d0ik0pVl
         G3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWNZl0ucUIFZHgJOXmZoNpmqFeVWv1dfIUYGYZtyZq8=;
        b=PR+k0jSNY21Ar4TspOKaTVBroMI1tTF1PexntaG6lhUrcVPJVHX5o/+MFMpQkr/Gut
         A12Z16REO0hIOjTkJuJiqD0iaJYwe+E3Jh1SfL/W6BfngypBI1YJeonZn9iDmCjg6xsq
         VHdJSUd4VMoWoLWcvQXn+9apETHJpeycbj7nHM87UKtBndFzWlEDsbB7Xts0eJzqWDL+
         J5TUllZodl1njr4bdXiGNyes2dQb0LCQoye53cgZ7nb/iLdA1qLH4AaxWZilfR0kt013
         3Llws6Xul9e+avsgPdJ+qcUh9XFWCzhqL19YmRuJkdX8DFCKOfvXUxqhPZ57srJk2dwA
         Vx0A==
X-Gm-Message-State: AOAM530ujl0SiOE+d39oxTzR7eFZUuXVWu8e9fCJnrF6hdMKcc2AyRgs
        colu49oRiKh+ZIlMmuTa15IxG0f92mTNlhjeDfGIIA==
X-Google-Smtp-Source: ABdhPJx0ULxCX6SCAwwI3mb1mIE7P0r4Xk0r6A4r9Zloif3dr7zKdVFKCOGnzSehgzMNGf1y0g/gZKGgh4W6IkPtmu8=
X-Received: by 2002:a19:f616:: with SMTP id x22mr1894859lfe.291.1622793447872;
 Fri, 04 Jun 2021 00:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210601142605.3613605-1-yangyingliang@huawei.com>
In-Reply-To: <20210601142605.3613605-1-yangyingliang@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 09:57:16 +0200
Message-ID: <CACRpkdZQjfCsPYGFz7S_Nc=1oBqPnznhfnXTUsNYe1WNQJCR4g@mail.gmail.com>
Subject: Re: [PATCH -next] iio: frequency: adf4350: disable reg and clk on
 error in adf4350_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 4:21 PM Yang Yingliang <yangyingliang@huawei.com> wrote:

> Disable reg and clk when devm_gpiod_get_optional() fails in adf4350_probe().
>
> Fixes:4a89d2f47ccd ("iio: adf4350: Convert to use GPIO descriptor")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
