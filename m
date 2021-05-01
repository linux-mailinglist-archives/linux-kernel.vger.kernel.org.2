Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB06F370725
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 14:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhEAMOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 08:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhEAMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 08:14:37 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8270C06138B
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 05:13:47 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a36so1294910ljq.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CRiIei4iU9eOLt+6VGICqdff4yVs7VnZIcLiYMXSOVg=;
        b=NmP4LrlfqgqiXwoaAwml0at2WV7mraCZbNWddlk2q8oVvLaaM2j2605TzOqQ0VpkSc
         84zavwow6Bc+rZ/+pp2zIe+o/KUolwWY9HQSpVHZqcu5TWm2sMaI3T9ZbkkK6TleHuz5
         9ZiqpJQ+NGPLbImFS6DByNVCoCYAT1hFulLMBGuTmSfkEmkVasPg07OoguODib13kIZQ
         Q4TAzL/B9P3mhNNZSBhu869XzyUur3wKoBkv8xKfbmypHrEEm0D48lH2yhYx2WSBfwyv
         LgWwjECwAIF7vpGKJb0dn07j9XxaT5XJgLzDDblA+ucT+Msy2fER1Y4gzpqwoEBFTe21
         OXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CRiIei4iU9eOLt+6VGICqdff4yVs7VnZIcLiYMXSOVg=;
        b=YLS1LiXsTZFHwr/FOt4SfflVKfGdTanSQ2YzGChaqN62TnE2UugoMFfe+To0R4Z2L+
         6Yzf1t3mVyBkk3zuuPKtMvmKhelh0/KcrJDtLC/WxGJHR41hrrbX+l4e9lPSE6NiFNi1
         RhprgQ+v7JDM71L/KF3hvUc2Hs/sIIOyLJo/6v9fOkDwcxLTlQttpHjCsdYSnWIbK29N
         3UyLfibaBIFwjASXP+BT677wIIH+y686o9a5a9sw1iNN4e/qNafd9yuM+lnu8Z1dnfOs
         or/vZsZCDSeuAhcTMrH9eXn7kA5XfFf18Srr/+L+2WUvEleAQbTEAmQtljRuS5lJBo7P
         ZAbA==
X-Gm-Message-State: AOAM533rEKa1v/gH7uK+/t5SKxTh/kQAj/81QxCsSfhRDsmh/q1rbJ3Y
        42PdWPKJmbk+hII71ndcWwJkcuvolIPwv7wLABVQiQ==
X-Google-Smtp-Source: ABdhPJwEvZiVUzjL5fiCUWcltqWrkyBzoejxaPSLl+jQo2XqeGW/AGSuOCc28BFe9PZw7LiIvB9x5RqEvOhmPwnPW1M=
X-Received: by 2002:a05:651c:1316:: with SMTP id u22mr184428lja.438.1619871226159;
 Sat, 01 May 2021 05:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210426095426.118356-1-tsbogend@alpha.franken.de> <20210426095426.118356-2-tsbogend@alpha.franken.de>
In-Reply-To: <20210426095426.118356-2-tsbogend@alpha.franken.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 May 2021 14:13:35 +0200
Message-ID: <CACRpkda7n3VL-EpwdXDxt47azFo8Wkp67-urUy7--3D6TJs7iA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: gpio: Add devicetree binding for IDT
 79RC32434 GPIO controller
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:54 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:

> Add YAML devicetree binding for IDT 79RC32434 GPIO controller
>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
> Changes in v4:
>  - renamed to idt,32434-gpio this time for real

Overall looks good to me.

> +required:
(...)
> +  - ngpios

Is there a *technical* reason why this is required?

Can't the driver just default to 32 gpios when not specified?

> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - interrupts

Why can't interrupt support be made optional?

It is fine if the driver errors out if not provided, but
for the bindings this feels optional.

Or does the thing break unless you handle the IRQs?

Yours,
Linus Walleij
