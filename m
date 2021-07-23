Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44463D3C82
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhGWO6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbhGWO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:57:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB28FC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 08:38:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r26so2759113lfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5fKS0W78jBgl+mIxB7Xm3uGD8b8IxeNIeStjZ0bgIs=;
        b=evLuO9t2y1KdY+CTSGy4BwPos3Vq4zxanoA1hWD9X7Hbicscye1STEqtbg/Sdvkv5C
         djdQvdh6R9hwgJYEyJMx+uTqi7m8c6OBtGwK0GWXoRd8tfJZw7matlNo2DPmpuF2aHUk
         DN6Z9qin5+4zvK0UJ6/hqgdLKyYnQrMPO9Daag/g/7r+D+GsVOh0HnaYoZLoYeYKpOG9
         WsapjxStnD2hyGkzN7Sa3W1CQKpfV8ZxnTwEst9FtevCwZ/8WqwAd2q9p23pIbW6kVAW
         6JD8VsZ6+32CqGkL6EpMhj6/Ker1hspQRoepWg0g46AoC9zoYnxJU/lufv155kTTjuab
         uofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5fKS0W78jBgl+mIxB7Xm3uGD8b8IxeNIeStjZ0bgIs=;
        b=bI9ZklQjE2wAbENDemM7Kd8U1SirKNG2vl+cCuKKoHn/Nq5iYonCTex0OsCW8Xw52H
         C4+RSZwJT7P547wKwwaU9Ma2vRQ0mX60ha6HfOzADF8PkX63pbyhvwh54pBxTCH9MpAO
         h20RaJt8riyCzrwZZRCD3g9bO3OjfX/LhC33DPBMvflbs1k6UEdOp/JpJlnPqsZ0jqu2
         cFgrlVaBeYWV4s9tBaZk4X7LVCfHe5C9hdsbjIWBsokD7KVn5CRvALusIn48bM2kKYgc
         LIykawD/DofkZ4mexdjNlzRCMj03SOeY8dn2QdOOXCesMnPOYOboZ0SjA0I1bzl6Oi/G
         oglg==
X-Gm-Message-State: AOAM530rs2L8JQ5F0D+m9UlJokH7Ti4/hUeManpGgUAqt5/VQwnvrQft
        mj/W/Q7tzMsCQrBZVxdlmuiTGVXW3ixOkCj+YEyl6w==
X-Google-Smtp-Source: ABdhPJydD4EvUxZjN8jfbePd6NexZtDbTJWMSw9gG1tEl0IrnQUz8uu1ccPNLmvpaMBm4zlx+ZGvhjPSF5bNqDsr5T0=
X-Received: by 2002:ac2:5e71:: with SMTP id a17mr3344716lfr.465.1627054710287;
 Fri, 23 Jul 2021 08:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210627185628.691435-1-iskren.chernev@gmail.com>
In-Reply-To: <20210627185628.691435-1-iskren.chernev@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Jul 2021 17:38:19 +0200
Message-ID: <CACRpkdZa1apQtmwxMeFxA=Mh2DNV_ggX8JtO8AoZ5eR0pWHEEw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add Pinctrl for SM4250/6115
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 8:56 PM Iskren Chernev <iskren.chernev@gmail.com> wrote:

> This patch adds support for the TLMM block on QCom SM4250 and SM6115, codename
> bengal. The code is taken from OnePlus repo [1]. The two platforms are
> identical so there is only one compat string.
>
> [1]: https://github.com/OnePlusOSS/android_kernel_oneplus_sm4250
>
> v1: https://lkml.org/lkml/2021/6/22/1163
> v2: https://lkml.org/lkml/2021/6/25/28
> v3: https://lkml.org/lkml/2021/6/25/72
> v4: https://lkml.org/lkml/2021/6/25/351

I wanted to apply this v5 version but it doesn't apply cleanly on v5.14-rc1
and I am worried about making mistakes.

Can you collect the final review tags, rebase this on a clean
v5.14-rc1 and resend as v6?

Thanks!
Linus Walleij
