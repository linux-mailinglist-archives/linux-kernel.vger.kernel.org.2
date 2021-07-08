Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4843BF9B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhGHMIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhGHMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:08:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF14C061574;
        Thu,  8 Jul 2021 05:05:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n14so14714544lfu.8;
        Thu, 08 Jul 2021 05:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RD1/6/jmD47YttIqk+9t+pHrc67BCgSGhpOheow4sIY=;
        b=lAzrJcdoxD0YH80j6oxSekIGmPClzY0t1lkujYsp7F2vb15XXHlYcTE8rQ5se9REvI
         a2NhbxUVftdUvnUqRzlxiGGP7vng+qbasFpAUVsWGWCygdS7wjLUb+r65eezCgr3MQ9u
         Wn/bnKT6OS+ZRZ0Y9Ei3h3NgfhaFBmAvnGppSxqifoiB3cW3hF/Gwpqqw2GmQq/Vi3in
         +Qz0ZwD19oQNg/DVAHeJ/9peTwApsOoTYVSq6+knveRYD5RbtS7/NpE8BtADkQzVCxm8
         iU6n3rxbi2Rq8RPyCmNQLpKnI1r8KEWg9rOaNaOjc76Tu6vykJTOJjyE251zraqyagdy
         +91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RD1/6/jmD47YttIqk+9t+pHrc67BCgSGhpOheow4sIY=;
        b=iV2ZnQ2K9zd93b6BmHXJVii4OpiVI176C7XU5KL6bw78rQ/p7vgAisz2XFRb4nozHF
         NTeHwfUaaAdm/tQ5lozKTwcja9jJp4DaoyFh25kcWJMworwj3Hs9d+J3AFmjC/qxzwmy
         11r0sf5uZhsaXevknccQKfSzSzGslNJ5rwpedGSZT3cx1rVLdUOgr+N0ejqy1VrqtdyA
         d3EXXE8IHX0wxWwzy5yev2Tj3bzFlt5AYxslpxVFbjB7tXQboMEl7ra0Q3wGbZFtGgXX
         +ZXax7fnTJDoCdNjVxZnneDJvyMWhR1FasabtCllIRkAtQ5KOw93YlEHCpVUhwSmUezd
         U9UA==
X-Gm-Message-State: AOAM531wek7bTOiqWvsWsk0OMjWh4CBAceJ417BJ+yKQuIBurp1+uMXV
        nLCqrnmbEsD65+NMPT+VlM3ryZgL0a3Nx6qZE6E=
X-Google-Smtp-Source: ABdhPJx6SX0r8fvbnYfayHEqpfIeV3JLezQLgvKici5Q8Gb9bx2Ia8CwMfE4+PnaZ8ESbmhzhnw/Z/VPC2vzAOIbEYU=
X-Received: by 2002:a05:651c:481:: with SMTP id s1mr10736951ljc.444.1625745954768;
 Thu, 08 Jul 2021 05:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210706114028.132-1-alistair@alistair23.me> <CAOMZO5CEeBWEaRWXpfgjR+q0QnpPmoyGN+ShjCHNzoSqk_iW0Q@mail.gmail.com>
 <CAKmqyKPLWft8kUR9A2V1fjpaD8dmpbT9=Lc-NY76wkgenLE93Q@mail.gmail.com>
In-Reply-To: <CAKmqyKPLWft8kUR9A2V1fjpaD8dmpbT9=Lc-NY76wkgenLE93Q@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 8 Jul 2021 09:05:43 -0300
Message-ID: <CAOMZO5C=CcJDg9BQMVd8UU7fryW9TqMvvnJCuC3cq-7rzTi=eQ@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: imx7d-remarkable2: Add WiFi support
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

On Thu, Jul 8, 2021 at 6:16 AM Alistair Francis <alistair23@gmail.com> wrote:

> I'm not sure I follow, we do the same thing here with:
>
> &clks {
>     assigned-clocks = <&clks IMX7D_CLKO2_ROOT_SRC>,
>               <&clks IMX7D_CLKO2_ROOT_DIV>;
>     assigned-clock-parents = <&clks IMX7D_CKIL>;
>     assigned-clock-rates = <0>, <32768>;
> };

Ah, got it. This was not in the patch context, so that's why I got confused.

Now I see it as part of the original file, so it looks good to me, thanks:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
