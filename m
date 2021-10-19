Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2050C432E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 08:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhJSGtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 02:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbhJSGtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:49:19 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF2AC06161C;
        Mon, 18 Oct 2021 23:47:07 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id m13so11710421qvk.1;
        Mon, 18 Oct 2021 23:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VwIYfW0Zf+mAEKNLwqvojyl/bgvNRKJ4LTxr8Eay+V8=;
        b=gUB404x1RJbgSLd2YiaVb360stI1E0MKIQ2XbtSHStIxqT6CgbZgLuMMBYkSJXU1Nh
         n0USHhTy2FDU/9kbIDBMUvjyQz7zliTZfgCNlsQ7+U5G6Y7dbWvChZXou0qUyA6JKV7f
         PU8l6fK8eiS6RbQlKfze7kNYSBhiYdq9o4L4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwIYfW0Zf+mAEKNLwqvojyl/bgvNRKJ4LTxr8Eay+V8=;
        b=y7y3CD5AU+Xa7chKPTWlN5/8+/LvDSQKyzVtYDkqJxccXDfXn04fDGSb0kYkiAwaMX
         erbMgzeADBqMNbZ69Kk+pVG7fLFCYGtCKhH/UW2HZ+28dQABDf9SC1i9SZcUwJnq1B7/
         GwD6aTLZoE17aihVrsi5Gas0YeISD+TQ68Bxt9OZIKohYEk3o9c8ebx+Bn8Nil7y0tDw
         OcXorL5oJROgf/GUGJA6DhAvdIuWcg8OoNC3z2ya46fHa7VR0Fx2iXetSwuS4bYNOhrq
         vUgK6ejPQJAg2zCOLey0zxm1smhZDqCfcVim3j3QVngNLcdnVNI9q/mX+PiWMoQeYYp/
         7hgg==
X-Gm-Message-State: AOAM5315klYE2UKvsJP9I6O3N2Nbadl9EW4tQ9DQa33quO63RhXvR5HT
        rUHrMR4XqDEGq3QANAdsPrF2qVPtATkZpJkJ5jI=
X-Google-Smtp-Source: ABdhPJwfxf183iO7OxBAtX1Zjk+UiHTT4DnVJqYwnqDIC90ALBhdq8pg720sirxT55vW2dHwHUbK1bCBrs264CwpSFA=
X-Received: by 2002:a05:6214:4eb:: with SMTP id cl11mr29935905qvb.43.1634626026343;
 Mon, 18 Oct 2021 23:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211019060155.945-1-quan@os.amperecomputing.com> <20211019060155.945-4-quan@os.amperecomputing.com>
In-Reply-To: <20211019060155.945-4-quan@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 19 Oct 2021 06:46:54 +0000
Message-ID: <CACPK8Xc_+HU3=rZtORUw+hu2SFbOm3ZYHkUnrrKpBcTUAfHeQw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: aspeed: mtjade: Add uefi partition
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 at 06:02, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>
> Add SPI NOR partition for uefi.
>
> Signed-off-by: Thang Q. Nguyen <thang@os.amperecomputing.com>
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
> v2:
>   + Introdued in v2
>
>  arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> index 723c7063c223..4c3c3f1a12ea 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> @@ -374,6 +374,15 @@ flash@0 {
>                 m25p,fast-read;
>                 label = "pnor";
>                 /* spi-max-frequency = <100000000>; */
> +               partitions {
> +                       compatible = "fixed-partitions";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       uefi@400000 {
> +                               reg = <0x400000 0x1C00000>;
> +                               label = "pnor-uefi";
> +                       };
> +               };
>         };
>  };
>
> --
> 2.28.0
>
