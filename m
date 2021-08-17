Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3113EE852
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbhHQIVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbhHQIVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:21:51 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86683C061764;
        Tue, 17 Aug 2021 01:21:17 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id dt3so8873258qvb.6;
        Tue, 17 Aug 2021 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4eUZVG0XpccdWtoJobUI2EmJHkDs8bqZphSP7hFWH1Q=;
        b=BD+21WBpfx3JflwQsN76WK36pG10k24qJf49uOaBukabmoZkC1OSJcSGBE5ArXDN48
         JFfC/ftO1VehIaVW3ADemG5c4GUYGqKndbnxYmwlnyuAhwrNvOxtKp0vdiPM3816BOf2
         yG8X0zariuFOwjuSeL48meiOi1n1lEOLD7UYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4eUZVG0XpccdWtoJobUI2EmJHkDs8bqZphSP7hFWH1Q=;
        b=EmkSy7b82QI9fRiQxvB21ZfwvgsDlnsLZN+QLfV0XynaUdBB7SMrASL2SOJ2EbHwuv
         ISGN8QbxYWqJCBM+wydA6OJ1i6Nr5oMkBbGzaPMsRbCSKtQpjvXmvuqvH1NlQKriuWaA
         +XdWAh2RcxuHMWfMJkSFE5XBKWhVyM6Y9wU+EOAtSDWRbVDg8jTQKt6VbtcXzjWU5u/S
         skvzs8ur1CKoQGSlVzFqXEqwaJ99E1ZpKE1ewlei05XhE3tPKngUjIpdP4+72J1sC20C
         9yBqqwawjeMPrg15FinSgV5+47VHrh/UszDO3KMwqm11CWwjESDdL/Xx8p1926jFCVJV
         BUYA==
X-Gm-Message-State: AOAM530EVoqpK+LZ9KoYdjknFRet3l4xXxWjMMd13GQn9JbeZLOhD+oN
        LKSD/F2sZyuoyUVin6ARdHXbV4oC21ynIpidvQU=
X-Google-Smtp-Source: ABdhPJz9DGxB7h6lDvfpMgEsp1O8RBOgo02XQZaKMDjkzBKVciQFWc8H/pOWw1CBfwgQUgIkuWSEZq9MSp8FXp6V3b0=
X-Received: by 2002:a05:6214:27ee:: with SMTP id jt14mr2172403qvb.61.1629188476683;
 Tue, 17 Aug 2021 01:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210813061900.24539-1-rentao.bupt@gmail.com>
In-Reply-To: <20210813061900.24539-1-rentao.bupt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 17 Aug 2021 08:21:04 +0000
Message-ID: <CACPK8Xei0K2vcEGc3Qr5zcb1SHMgNbJ+4_fVd6u-FiOHt4PxSg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: cloudripper: Add comments for "mdio1"
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 at 06:19, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> Add some comments to explain the purpose of "mdio1" controller: it's
> connected to the MDC/MDIO interface of the on-board management switch.
>
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Thanks, applied.

> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
> index 01ec3ce0a29d..9c6271a17ae8 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
> @@ -96,6 +96,11 @@
>         status = "okay";
>  };
>
> +/*
> + * "mdio1" is connected to the MDC/MDIO interface of the on-board
> + * management switch (whose ports are connected to BMC, Host and front
> + * panel ethernet port).
> + */
>  &mdio1 {
>         status = "okay";
>  };
> --
> 2.17.1
>
