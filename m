Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7033E1CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhHETej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhHETei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:34:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70059C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:34:23 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id k65so10803422yba.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OjzSuQ/ih9YihuSqr0yJlft2iccfIfOLf5UR1oHtBfw=;
        b=t5jTHcshMRomx+U+mjOZL7JRahGyPOV1eVRgzK93HUhnC6bq1q+yENtT4en1ICJX6K
         Sx6fSQIoFxDXj/HsPMpubiGtMpmdjJIzWryGHXEzu0WBVsIuupkY9XB4UWzUczmbJjn3
         fcDokwwTaMcYiehLr2UczkhHkg6B0+al1ZUKGmg+XPeJiDHOJNmMwWOpPgEVVdsVWyyF
         AuxDAASWOpm3qkW6MkSheo+uPZBnzKhEg1Ug44RNotZwsIi0NUUbS5UKr0/jsYA44ybO
         0P0NmO+kPUHF9Qvcau5eTDS71/X5e/pE71m3KqwcjJmuSvRw1xyng53awCL4tTYiOtb3
         3Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjzSuQ/ih9YihuSqr0yJlft2iccfIfOLf5UR1oHtBfw=;
        b=Zg4DPW4nO38XZtUZUCiLo1tW6xeyY0qdkuzhh9Gheg3y3QpwtCOdxNPeSC6AuRnSDl
         qR/7liUYn/IU/qMPNG2IeIIQ1d1DPtSpFkU+ZCKxms4JwPrbypyD4ZhGo8j6jnj+EOBf
         YqrkHudXJhxN9KyU9nIyb3ocUDHL58rpuBdA6tjh24sNGZyYn9xmJwR+eFDhIDt9CvXG
         wwymmCQ1za6g68J5qxMkNNRbcqSSYwViGprxHpETwoU0du1NTV8YC706fCAH5VlENX8p
         TjPZ2PlFaJy98dmXTe1L8Eqx6hCuKRkwndZDLVqlsbUUp6pF2SuypGldCUUvV1G44Ul0
         e2Gw==
X-Gm-Message-State: AOAM5309eX8X4Ng22E1vI/uwv+RHXI40eb1+NOu/32xGI2LY4W4QO42V
        bD6MDhjQQnSAZ70Ni2uePqgPFJ/5/GwRuRbrSavDyQ==
X-Google-Smtp-Source: ABdhPJzhy9EpxjDKV6CQnSv5zHP0x83zyvNrVobJHJ/xfKzeDYtHGJ/1+KtGYq5yledRXzszY2nUVt3MkIvCAtzNBbQ=
X-Received: by 2002:a25:505:: with SMTP id 5mr8137807ybf.157.1628192062775;
 Thu, 05 Aug 2021 12:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626947923.git.mchehab+huawei@kernel.org> <e6f6fa5cebf94753ad8c4b30103459a8eea4bce0.1626947923.git.mchehab+huawei@kernel.org>
In-Reply-To: <e6f6fa5cebf94753ad8c4b30103459a8eea4bce0.1626947923.git.mchehab+huawei@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 5 Aug 2021 21:34:12 +0200
Message-ID: <CAMpxmJVe40C=69RJ4oKqQXogHBmgjcoRk+ExP1nGsO19WaikwA@mail.gmail.com>
Subject: Re: [PATCH 12/15] MAINTAINERS: update gpio-zynq.yaml reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 12:00 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Changeset 45ca16072b70 ("dt-bindings: gpio: zynq: convert bindings to YAML")
> renamed: Documentation/devicetree/bindings/gpio/gpio-zynq.txt
> to: Documentation/devicetree/bindings/gpio/gpio-zynq.yaml.
>
> Update its cross-reference accordingly.
>
> Fixes: 45ca16072b70 ("dt-bindings: gpio: zynq: convert bindings to YAML")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 76236b2c1d7a..7e1e5385d971 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20382,7 +20382,7 @@ R:      Srinivas Neeli <srinivas.neeli@xilinx.com>
>  R:     Michal Simek <michal.simek@xilinx.com>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/gpio/gpio-xilinx.txt
> -F:     Documentation/devicetree/bindings/gpio/gpio-zynq.txt
> +F:     Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
>  F:     drivers/gpio/gpio-xilinx.c
>  F:     drivers/gpio/gpio-zynq.c
>
> --
> 2.31.1
>

Applied, thanks!

Bart
