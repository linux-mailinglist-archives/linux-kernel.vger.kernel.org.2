Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B3639DE74
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhFGORy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFGORx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:17:53 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DD7C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 07:15:52 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g142so5836321ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuNOwZfNMKgDqyZEslbLVQ4ckoEZsVVYvZ4kkvz7Ayk=;
        b=175Az1+gbdCGPk2q817imWwk0+PcD+/w0zW/awReT4yWlE7aK8YHT/VbFrx0KcraOM
         Uo32NIQzkysX4ZY3k7Br12TjFLXa7IWyzESIPPq63OHdWxgDkHuP/sP10RdLuPZapsyg
         pf8YLCkt8Kxf3U6Xv83/jor79VuO/4RpD/aUs6/H9j5yn+hQPYYwz5lOB3bBk7mD3y5s
         99Ou0rDYhK8lFifPOdkjHlXLNR8/MFEK3sDM+ibRJJkmdDNBCzL9wVcCCfOPqVgk8qIg
         FvlSocmD6sCTtUHAuqEmx0gRo1GI0/QLNY/5sEum/shlqscl3S+wLZI+6YWbcVnZmZyI
         AI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuNOwZfNMKgDqyZEslbLVQ4ckoEZsVVYvZ4kkvz7Ayk=;
        b=asqdzngkJSaoSjV2tQIv1IHrNvtmsaThYul9DOlerV2d1bJ76G4oSm4+MRTYGMq+0u
         HArAjzG3H8ywBlBnr1x+7cJxRwjodrl7PW1BeQL+MKmeBpj6P2kLqp7X/a0/e78ke0ot
         tJbi9mhwNvA8THZiXlnA82FbAsz6k4O0mXpXFb4M9kfJPpK0nFTTArdN6N0m19I2sVus
         hajdKhbpa8xKB4+dEqTzyH1dusG3tdCUALvFB9yG1lbOl+n77LNf60pwsEWTITvv+f6E
         nFC+MwnoCVTTtQlMb3ROcDGmx+imPDbew35LGyyUuLX4WWXzhaUxAcfbBl1gWCLLdRZ0
         65iw==
X-Gm-Message-State: AOAM533kxlV4V1SEsJQVrW+SNgQNNeFLEVPxE87Ct+c7fYuLFdFOiJly
        an5FErc5x4HdSH/Lf2NXxivhTBZdej5oT0xiixc2Rg==
X-Google-Smtp-Source: ABdhPJxCEjDwRKocJ+MS4sV1pJrDfa8g4djXIhFVM1qC/8wOSpVeKSoaP1BvbRFLolJZ1sG5z7lZYJf7ncyGtWgD3rM=
X-Received: by 2002:a25:8804:: with SMTP id c4mr24571525ybl.469.1623075351742;
 Mon, 07 Jun 2021 07:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622648507.git.mchehab+huawei@kernel.org> <832058f088a30e44cf25a81f1d4b9b4e0ed0904f.1622648507.git.mchehab+huawei@kernel.org>
In-Reply-To: <832058f088a30e44cf25a81f1d4b9b4e0ed0904f.1622648507.git.mchehab+huawei@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Jun 2021 16:15:41 +0200
Message-ID: <CAMpxmJWnG14ECT6jHxsT3NQ8smZGCWQRgWVOGZHmoGdYs_pG9w@mail.gmail.com>
Subject: Re: [PATCH 10/12] MAINTAINERS: update ti,omap-gpio.yaml reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 5:43 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Changeset bc3aca5393c4 ("dt-bindings: gpio: omap: Convert to json-schema")
> renamed: Documentation/devicetree/bindings/gpio/gpio-omap.txt
> to: Documentation/devicetree/bindings/gpio/ti,omap-gpio.yaml.
>
> Update its cross-reference accordingly.
>
> Fixes: bc3aca5393c4 ("dt-bindings: gpio: omap: Convert to json-schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 644572ab4b2d..7d65784df8c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13412,7 +13412,7 @@ M:      Santosh Shilimkar <ssantosh@kernel.org>
>  M:     Kevin Hilman <khilman@kernel.org>
>  L:     linux-omap@vger.kernel.org
>  S:     Maintained
> -F:     Documentation/devicetree/bindings/gpio/gpio-omap.txt
> +F:     Documentation/devicetree/bindings/gpio/ti,omap-gpio.yaml
>  F:     drivers/gpio/gpio-omap.c
>
>  OMAP HARDWARE SPINLOCK SUPPORT
> --
> 2.31.1
>

Applied, thanks!

Bartosz
