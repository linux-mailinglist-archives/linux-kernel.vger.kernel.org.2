Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC93442B08A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 01:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbhJLXsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 19:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236321AbhJLXsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 19:48:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F735C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:45:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y12so2580213eda.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9QIQ7pA6on+PhPbmC46MmFbUXQiDnzNiglml743kow=;
        b=k2m1G+XqaO6GS9hxIV80tHPHDWpZY4uwLvDS+MT4diT5j6QCboVs3PDEau/U8LUwTW
         A6XepDfgCu5N08ZkIPJxerRz+/JGwOB2tjrirHQZ3McM1QnSir2qAoARulRpYgOvuqCM
         O1LwpUCr4ooefYltNCvn2LBwWK6OoU+Dw5EIMOUCXR5H6r2e9L/NbA5dpgYyPEcklvTD
         Q4+Ohi0pI+jnB/Cv6F8uJAUzLDC0me96Wc2TLjhAGe5/KN5CJWGvdEfx0Mi6eGwBQEJT
         yAzytTfNKk35T700tp2dqkUaZ4Aw9sg11TI+STxlLKa9a0Gae0rkumMyw6d65TYkP+KA
         PZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9QIQ7pA6on+PhPbmC46MmFbUXQiDnzNiglml743kow=;
        b=bVHoyyrIvYw2ccPmXMl6QmSGWz8rUqLRNXIHXEIMU3SG5DquVCUoeZyMMDUJCoFurl
         Dm7Pvj+QsZN43U2hu7z5Wkrt5liIlPTyTqPmRQezCnAUKh/jiUgStvDbQ28kSYB5xon7
         8PUlJvs/zdAMY0MfuAEa/5SvwS5ktjlJqLePXQagDd89tsFpeECkOEJv1NSQDfQYXpg/
         T5mIac3t6iPHMlen4bj+eQHeot3JrS7f+buV45HLZZVwA34XuNFN/Zs+PiQEdRclPMrm
         YPuDKN0MZ4rgi1J8TPz1Y0OoYx26bvWLrNWEP4C+fBxeVYvhmnkyV5hdI95gx5n2ULU5
         jwdg==
X-Gm-Message-State: AOAM533vEo5OvsBmKvQAocLAy1QkKC/INxPLYkSYXx8WxdX+lOw88j0v
        F76MKH2ellyfo2H6jwJPyaZ0F+Dj5Ak2sz6opg1ZD6EI1Yw=
X-Google-Smtp-Source: ABdhPJwCFUpePR+Sp++Rs+7vC3g8AGn9zz5QRwj1VvVdaDdZ2qI0vgrM9Ktl6M/kclmNKHUDk8LFA+Gd/VjkqPSuWbc=
X-Received: by 2002:a05:6402:34f:: with SMTP id r15mr2991976edw.111.1634082358220;
 Tue, 12 Oct 2021 16:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211008092656.421-1-caihuoqing@baidu.com>
In-Reply-To: <20211008092656.421-1-caihuoqing@baidu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Oct 2021 01:45:47 +0200
Message-ID: <CACRpkdY0uM4BNapd7XNUhZ5U0sGdP3hu5Tr+dM1jigg5vQ+KDw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] iio: light: cm3605: Make use of the helper
 function dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 11:27 AM Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v2->v3:
>         *Handle platform_get_irq() that returns -EPROBE_DEFER.
>         *Handle the lack of availability of an IIO channel
>          by converting an -ENODEV to an -EPROBE_DEFER.

This looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
