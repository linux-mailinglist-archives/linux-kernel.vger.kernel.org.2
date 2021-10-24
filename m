Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DB3438C36
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhJXV4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhJXV4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:56:04 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0FEC061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:53:43 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id o26so9642236ljj.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XTUIqto/oxCHUKEctW3fxwyrTpyEEyiqeWbHydY//aY=;
        b=rPomx7SGz7pofYeRDGLqDkcQRSZlQbdpBhMMrKQWf5IrCOVLV6wGd9MMUK5rxk8H65
         eMJbMl098dYYF5dFimnOC9XGelOmpfE9WkoNyIHOCVmFoVag72GWBlr5cFHneYY9HLSu
         ckdKi5JSuavVPV5MQI2GMijZdnB1JgOgMgZSCwTpycbXJnxiQ402WcOU3OSSCGBBg4qW
         mc2LzkOvduj85x5KxYrCoY6PE3J1XhEmEi5JKHAv/0uwMqIAKO9G7pYn1vfZYecRUY3X
         DHpDG5PFFL4iEQzShwAeffP3Epz7vD38JhLDw+jSI372kFcEVZrxJnaKndHbi7OGPk8j
         yZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTUIqto/oxCHUKEctW3fxwyrTpyEEyiqeWbHydY//aY=;
        b=ot2IQypmsMu3pLOLi3Jh55NXXpS8sVE5XR/SR0Z+fNhvi4AR4oS4v3u8CyFgPw7z99
         UNlYJYUD8bZPwMtEOzbSaqkpPhrL0j4vNYH591R9rYU7Co0AooHWxJezRSdcR4FU3Av7
         spTwiEjDFC/lVEZCQAenIiiFF0gWNGj6TzKyQDkwCXhJgsETqAvFXYj+7My/nijmXLeX
         9bB4kEanAKLsfEhJIKtkcIKZl4hZXarm4DRf5HLb3C8dBCGe1urgwiJ+kWCh0Ay4waxt
         Nr5WIQnlEDUFgpCikm3t+8uMIOt5WxLj9OWT+4y8hczBNr8uFXxbJNP44afXcNr6INMk
         662w==
X-Gm-Message-State: AOAM531izz4hbJ4vPGG1TFA+zBENHIPUfK4nF4pQ+CkVgxWBqPlO65M8
        9dbKR7Vrlpv7xX1adjfh3E5pr5AWe+rgd2hU5+OqjRFhxeTeJg==
X-Google-Smtp-Source: ABdhPJzEiyGNQYYwxf6GSF8eoY/NkxKZS5lTOKOd6kRvE1b3p3ngJbGT3Kl1pCfiIERJpHBFhh9yeI8E2RrphqMSBuw=
X-Received: by 2002:a05:651c:a05:: with SMTP id k5mr14869914ljq.288.1635112421650;
 Sun, 24 Oct 2021 14:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634630485.git.mchehab+huawei@kernel.org> <56737d183299294c840c8308c1427c3385d88a1e.1634630486.git.mchehab+huawei@kernel.org>
In-Reply-To: <56737d183299294c840c8308c1427c3385d88a1e.1634630486.git.mchehab+huawei@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Oct 2021 23:53:30 +0200
Message-ID: <CACRpkdb3Qz4KUrniinYSgQYKH-ueMB60o9KWChmbPOg-5gk+JA@mail.gmail.com>
Subject: Re: [PATCH v3 06/23] MAINTAINERS: update faraday,ftrtc010.yaml reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 10:04 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:

> Changeset 8df65d4adca6 ("dt-bindings: convert rtc/faraday,ftrtc01 to yaml")
> renamed: Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
> to: Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml.
>
> Update its cross-reference accordingly.
>
> Fixes: 8df65d4adca6 ("dt-bindings: convert rtc/faraday,ftrtc01 to yaml")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
