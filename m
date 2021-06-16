Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978833AA76C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 01:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhFPX2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 19:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbhFPX15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 19:27:57 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0593DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 16:25:50 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id u30so1274480qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 16:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RGJwIcw/q576ovQRK45c7NVrN5akX6pFlIi1oJ6UC88=;
        b=yjHZdxA08MjiNwf3szPMWYI5SnU3h4eq7AuZyqyZ4L8dFPhdE534qLX8N+JLsJUs7w
         7hCAlcZpbuZY9G5bdPZcN+4xvOfUCUxWsy7gVpqj7nX18fh1ZBUZiTqiBTbdtdGQt76T
         itcYc29QtJbbpxc6Cqd8CrBkpEZqfUp0D/04uEy0t3Q+Jxe03DPSgCQdENuhbwEMlaQg
         Cp1Ry0k4skrj+gmZKCRmhjj7bJBvnB+dY0l022ApSjZap6Wh6zwnly9lfi5IeEJy1gty
         esyzofFT/9tmSIfqydJqPzOnDZsTfT++Yl1b10PnHc0w3yRohyCwZ9NGD0wx4evWx65X
         anXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RGJwIcw/q576ovQRK45c7NVrN5akX6pFlIi1oJ6UC88=;
        b=iHof8tJ9rESs3wWncQkCA44AY8ecKwYGuFnUFESwE0IkGXBUR7sGd+ODmdruD4Jhcu
         vGjqi7zlupR7h3PyDuRHhbfyrBGu0wB7ORnTE2SlnGHvzKTip26kpSYriaGJf17M74i+
         J0f+fQx0ETJ63gLzBTIue0VGjdNffehK+7lxv/s3HGrVbfSuhg21IG+ZSNp/nasP2Wk6
         iOF/KY05ghfxXARlpW+79eGM38GOOPYWodwOEqMi9QWquCd5yCtWqgG0x8rHU582Sn9a
         zdPcxRDMfYXoo5o1r2bnBuriX94tUG9+q5yUd3IActamODCeU2ILhT/687AgifCTLLQd
         ZA/A==
X-Gm-Message-State: AOAM530pcRJPPiQwa/nr3HLeatTcfV812dR+JGtMHR9cRmqRBS5uK5HZ
        5rx2sFRtJjx2X0NNS6H+KwceQvcpcvw8IFaRPrzKdQ==
X-Google-Smtp-Source: ABdhPJxGQ1/XO8SoqXVyvmyDnP28vr9eEwL7k3SCLhbXZsEofN9Hot475ONHXu3cj4L4OmUvpTx6WZlSOo012aKCc04=
X-Received: by 2002:a37:a041:: with SMTP id j62mr831796qke.155.1623885949130;
 Wed, 16 Jun 2021 16:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210616190759.2832033-1-mw@semihalf.com> <20210616190759.2832033-5-mw@semihalf.com>
 <YMpVhxxPxB/HKOn2@lunn.ch>
In-Reply-To: <YMpVhxxPxB/HKOn2@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 17 Jun 2021 01:25:38 +0200
Message-ID: <CAPv3WKdo_JeMRL-GtkYv7G3MUnXmyG_oJtA+=WY72-J_0jokRA@mail.gmail.com>
Subject: Re: [net-next: PATCH v2 4/7] net: mvmdio: simplify clock handling
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>, upstream@semihalf.com,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Jon Nettleton <jon@solid-run.com>,
        Tomasz Nowicki <tn@semihalf.com>, rjw@rjwysocki.net,
        lenb@kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 16 cze 2021 o 21:48 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> > +     dev->clks[0].id =3D "core";
> > +     dev->clks[1].id =3D "mg";
> > +     dev->clks[2].id =3D "mg_core";
> > +     dev->clks[3].id =3D "axi";
> > +     ret =3D devm_clk_bulk_get_optional(&pdev->dev, MVMDIO_CLOCK_COUNT=
,
> > +                                      dev->clks);
>
> Kirkwood:
>
>                 mdio: mdio-bus@72004 {
>                         compatible =3D "marvell,orion-mdio";
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         reg =3D <0x72004 0x84>;
>                         interrupts =3D <46>;
>                         clocks =3D <&gate_clk 0>;
>                         status =3D "disabled";
>
> Does this work? There is no clock-names in DT.
>

Neither are the clocks in Armada 7k8k / CN913x:

                CP11X_LABEL(mdio): mdio@12a200 {
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        compatible =3D "marvell,orion-mdio";
                        reg =3D <0x12a200 0x10>;
                        clocks =3D <&CP11X_LABEL(clk) 1 9>,
<&CP11X_LABEL(clk) 1 5>,
                                 <&CP11X_LABEL(clk) 1 6>,
<&CP11X_LABEL(clk) 1 18>;
                        status =3D "disabled";
                };

Apparently I misread the code and got convinced that contrary to
devm_clk_get_optional(), the devm_clk_get_bulk_optional() obtains the
clocks directly by index, not name (on the tested boards, the same
clocks are enabled by the other interfaces, so the problems

I will drop this patch. Thank you for spotting the issue.

Best regards,
Marcin
