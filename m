Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869DC393606
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhE0TO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhE0TOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:14:25 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6351DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:12:52 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id s19so1815544oic.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QXGSbGImUxWSqqDCwtGRWbjagpf0D/bWGU5/oOaVIag=;
        b=NQuVzGr4lZxTqLUx6fuQviusP9O8fMSc9a+7X2tgfag08v0rNSsHf7NczeaAvurXxC
         Wl3u28Bb3Uf1wp3X+Aft0VchoaFJO+zmSzmzXGIfJefEP2Qsp7E8h6VtYDs8NTHBUJWX
         ldJg+eFC5Xt2bn0qVPej4kP71hUM8eMR4vKE6TUzrNQvPjF0GEDLJ8LH1lx/RJ1TFCff
         /lZvWZQOsUKG5LrYiMnon8twGYx5HCs8y5GFQcxGIuJ6NU2tGwUzixYShfjofpoAEnpO
         yrv+Kd9Zsn4xDvoymfqaDWiWg5oCJKqyOSqD/hrZSNQ4c/oH5fdxvkESFzmLlvLnxTds
         YA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QXGSbGImUxWSqqDCwtGRWbjagpf0D/bWGU5/oOaVIag=;
        b=QQC6oZOU63SJ5ycK/MaVBn0miLFHL1zhlQ7cOYrWEqMI94X9EOWnd4v70x2nGvuTIU
         5KzRcVIwYk3cfXnohAPjcV0Adb6axsjQaEgsHlUGL7i/eVHocp7eq5yeJC+0Tcd1hplE
         yVfnUpvytntll1CPwcMs1Gq52TWfu9KpJbc1h2vjobtvOAMyim9wsJy3NtFg65igXgaD
         kRRO1PtYkDsVSG7zMcZ/U6/F4G6XDy6UV1GeVgbgvMvtp3Ie1fJBa+TZrodsdAzoFTIQ
         h9MZXR0dFYkcDm1xThGr/F94eejVXCf+5uK+qz40kURiREPfUWOZWeTYgSeF8SuDTKrN
         iRCw==
X-Gm-Message-State: AOAM5324uqR0N8zX9UV4VBWNC/f1xJfPk8NNAicXKhitNoUpEySENVmZ
        80WmBSNRtKrfyRIwYSIaoRhWKYU6KczAKIJnd88=
X-Google-Smtp-Source: ABdhPJxw1f87l1RFD/rt8eDy8zVIH3ow/fC2hKJuPQuyAozZuR2z5Of/UgI/eFCPEK4HM7C7+tzliTJj0fz3ZcxzGcw=
X-Received: by 2002:a54:4106:: with SMTP id l6mr6856904oic.60.1622142771783;
 Thu, 27 May 2021 12:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210522035148.1586043-1-daniel@0x0f.com>
In-Reply-To: <20210522035148.1586043-1-daniel@0x0f.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Thu, 27 May 2021 21:12:40 +0200
Message-ID: <CABgxDoLm-sR7SobCME8M-4xPXj7NRv+-P=J2M0-80fERCjCPnA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: ARM/MStar/Sigmastar SoCs: Add a link to the
 MStar tree
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mohammed Billoo <mohammed.billoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam. 22 mai 2021 =C3=A0 05:53, Daniel Palmer <daniel@0x0f.com> a =C3=A9c=
rit :
>
> Add a link to the MStar tree on github.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index def1640cc294..3d10dbf3dc01 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2168,6 +2168,7 @@ M:        Daniel Palmer <daniel@thingy.jp>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
>  S:     Maintained
>  W:     http://linux-chenxing.org/
> +T:     git git://github.com/linux-chenxing/linux.git
>  F:     Documentation/devicetree/bindings/arm/mstar/*
>  F:     Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
>  F:     Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
> --
> 2.31.1
>

Hi,

Reviewed-by: Romain Perier <romain.perier@gmail.com>

Regards,
Romain
