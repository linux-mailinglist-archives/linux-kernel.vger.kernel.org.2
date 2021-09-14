Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AADB40A8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhINIQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhINIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:16:43 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB30C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:15:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b14so10688386qtb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McFPfgp+89QkBjV+rL8b9/JFaBCL/hN6AdRiaLyQM5Q=;
        b=TDiqiQyd07G7uOdJOlYQxkkipWc8uuxMMgsDLmil0ViNQH11kpnH0kP9421cMyje+8
         +Ys7OS2zIi6FGc7sJQq33n3Z7Zcnf5sQshdhEaKnGe5OZX40beS18RRSFo0mSB+k/oQX
         m6ecVrZjFuBhGJKit8YeNytsIfui2/mdPrCliYKSyMKNOeEeioci34A5GHzdb+jhVdgV
         AqF2/t97GASWT6Ii8qTu21CV0uiAdIzrHLoz2WF8dudVXr8UfzWxmeXVXhb56jtXmRSS
         Jfe6bSt0KxrUgsP5pjnQ73UgaNwpk2VOrSkNGBmyoYsxLFftIFzUcR+2fDPze5x8q2Ju
         HYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McFPfgp+89QkBjV+rL8b9/JFaBCL/hN6AdRiaLyQM5Q=;
        b=LiJUbSfsF6OAObVYlZIsqEdrDSwpWHYhu6/h9PPX9TBv2uKj4oEOTyflvHC4MrOP2B
         KnuM1VHR0x94SLzeh1lb0Z6i/nOlbrQRXzv8Zv2VqRixGdRuTzikxE32YEgEqG9vjTqT
         T4nVe/Rxr4EZCFIl01sF2D7dDQmfQYx4+JCC0sw07rStGDvRlpOEeGjjY34ivXgxNlja
         i660nHu22aVqIInaW3oTWwnhCzOcneLS0F3gf7U5espJppn/i8NcsBNMVRE7AtZoKMEE
         7aJfW6Rmp75j+ygq9fY6adFK6k5rznI1/hj3+9tJl8j87HxvOwQN3r6+ka344c4Psg6w
         Kazg==
X-Gm-Message-State: AOAM533sPYuzxeviK8fR+J9nDPLbhww4RnmLW3b0N9bukTfIsdcGP28J
        KgD3kRzkdp6U945xlaie1TTKacTbKLTZ6KrMGbs=
X-Google-Smtp-Source: ABdhPJxQ2y7T2sJVQXB7MRygHfYxfwfK3HqUmuHPwMx4E6Ku5uphr5nfmF5aLPoPmS5RJHTa9r0G3desrVf520itfQ0=
X-Received: by 2002:a05:622a:102:: with SMTP id u2mr3614591qtw.149.1631607325330;
 Tue, 14 Sep 2021 01:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210819055227.140980-1-liuxiwei@inspur.com>
In-Reply-To: <20210819055227.140980-1-liuxiwei@inspur.com>
From:   George Liu <liuxiwei1013@gmail.com>
Date:   Tue, 14 Sep 2021 16:15:14 +0800
Message-ID: <CANFuQ7A5jLXftmfLn_W93MuDF8heL88BPQRL_rkYk+bj0_Db0w@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: fp5280g2: Enable KCS 3 for MCTP binding
To:     joel@jms.id.au, OpenBMC Maillist <openbmc@lists.ozlabs.org>
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, George Liu <liuxiwei@inspur.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Joel:
do you have any comments at this patch?

Thx -- George Liu

On Thu, Aug 19, 2021 at 1:52 PM George Liu <liuxiwei1013@gmail.com> wrote:
>
> Signed-off-by: George Liu <liuxiwei@inspur.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> index 1752f3250e44..d0c3acbf6c8c 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> @@ -3,6 +3,7 @@
>  #include "aspeed-g5.dtsi"
>  #include <dt-bindings/gpio/aspeed-gpio.h>
>  #include <dt-bindings/leds/leds-pca955x.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>
>  / {
>         model = "FP5280G2 BMC";
> @@ -902,4 +903,10 @@ fan@7 {
>
>  };
>
> +&kcs3 {
> +       status = "okay";
> +       aspeed,lpc-io-reg = <0xca2>;
> +       aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +};
> +
>  #include "ibm-power9-dual.dtsi"
> --
> 2.30.2
>
