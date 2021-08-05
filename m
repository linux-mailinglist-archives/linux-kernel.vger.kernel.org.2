Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64193E0B27
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 02:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbhHEA2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 20:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhHEA23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 20:28:29 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B0DC061765;
        Wed,  4 Aug 2021 17:28:15 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id js7so2069002qvb.4;
        Wed, 04 Aug 2021 17:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85EvoyF8sgX3fo5G/7KMRYWhF+AF9WMLCT8s7y5Motg=;
        b=Rqj/92pIppN0j21zFFv/ZRJElRbvEQvHxNgvayCgArb08CLlDUYohH3nAwEmGwolR8
         a1/i+Tg16I495RwEUvJ6+Fh4QVEPAWvLll26dioN98QTeVIMU5KL5jf7nByc27WOK1Pa
         /MsgAj8PWR5tqe0WZAL+zZqdK/TO7VPtkMhpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85EvoyF8sgX3fo5G/7KMRYWhF+AF9WMLCT8s7y5Motg=;
        b=FXILfTxyuxjCJ+C5o0vjwl+dhqnfuuX68IpDorionIDiyUA4lAc6oFRjIOk1Q45t1V
         8CqzeysMg9CR1XFkNN93Bdqd/rdPM2Iknsx2nTSrhJn5wipB4AA7afoP/lTLyjITYuRk
         3OOdzEzZiw6ARxuk3BoDf621xbS4V8dpNha8l5+aHl6bWeXa/U961zWMkdOGVhhr0VHr
         mG73eaNabFOkqGD6Yd+ImFS6hbFDkukxNA7XyDs0nJtioZtP1FLZ6HbLYEkYIgYjO3bB
         gz3B27gxxPmDECcy0M3vX59bzKrfFa9MneAlq6ydT0Vhm3HXGYQZ+OeBG2EZAl24ZinC
         r5Pg==
X-Gm-Message-State: AOAM531HF6EDyBSHzuiTzve+6K0+M8FOV+Z7nAHPk7wSG37O9mmajH05
        1jV8BXUmKOiAlSGAHJWi4h8SwCNjiZXYqialVnc=
X-Google-Smtp-Source: ABdhPJww7LJdzb06f2Udu9LJKPCc1Py0jjXliEKq33sYs6ve+28Ynzwdc+kNW6i2SKb7dXjGxX4MuK8sqhnyMW6PiLY=
X-Received: by 2002:a05:6214:501d:: with SMTP id jo29mr2305844qvb.43.1628123294137;
 Wed, 04 Aug 2021 17:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210728233755.17963-1-rentao.bupt@gmail.com> <20210728233755.17963-7-rentao.bupt@gmail.com>
In-Reply-To: <20210728233755.17963-7-rentao.bupt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 5 Aug 2021 00:28:02 +0000
Message-ID: <CACPK8XemZkV7nK_b4883DN+dJKhL=tXfqK6=DpHQe=fZRu_ETQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] ARM: dts: aspeed: Add Facebook Fuji (AST2600) BMC
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

On Wed, 28 Jul 2021 at 23:38, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> Add initial version of device tree for Facebook Fuji (AST2600) BMC.

I like to read what kind of platform the BMC is going into if you can
add that detail, but it's not essential.

> +&spi1 {
> +       status = "okay";
> +
> +       /*
> +        * Customize spi1 flash memory size to 32MB (maximum flash size on
> +        * the bus) to save vmalloc space.
> +        */
> +       reg = < 0x1e630000 0xc4
> +               0x30000000 0x2000000 >;

Which driver supports this?

It would be great to see Facebook work to get the SPI NOR driver for
the ast2600 merged to mainline.

I doubt the IBM team will get to this, as we are using eMMC instead.

> +
> +       flash@0 {
> +               status = "okay";
> +               m25p,fast-read;
> +               label = "spi1.0";
> +               spi-max-frequency = <5000000>;
> +
> +               partitions {
> +                       compatible = "fixed-partitions";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +
> +                       flash1@0 {
> +                               reg = <0x0 0x2000000>;
> +                               label = "system-flash";
> +                       };
> +               };
> +       };
> +};

> +&ehci1 {
> +       status = "okay";
> +};

Have you verified that USB works with mainline? I've had reports of it
working on 5.8 but it seems to have regressed as of v5.10.


> +&mdio1 {
> +       status = "okay";
> +
> +       ethphy3: ethernet-phy@13 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <0x0d>;
> +       };
> +};
> +
> +&mac3 {
> +       phy-handle = <&ethphy3>;

status = okay?

You should specify the pinmux too I think, even if the default happens
to work, so that other devices cannot claim the pins.

Cheers,

Joel
