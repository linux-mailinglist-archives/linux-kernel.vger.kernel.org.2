Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5344F39B486
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFDIDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:03:23 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:46734 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFDIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:03:16 -0400
Received: by mail-lf1-f47.google.com with SMTP id i9so12690967lfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8RCi1M3O4ld6apAZMvKosIl9PGcIJils8EaE1SIdw+M=;
        b=ZROsLJZojaK+8cIJXW+yJiIedhocgLH0CPfglNdBVbMbH3NEK283DWRExuqn1nCbjR
         CLOnPVlgm2C1fWhDm3w55zM0lsOosjqBKFw6502UR0YOsdsmn2sLKngvmMbziaCbLBW9
         jQlrHnadopQHaDyJ+XPGvtIWfAMFp2kKlG8hFiPAm397uWQtmrnAFWhqq6I8FyvVEigk
         Tcf7iWSV0QjB/XfTnELHEG09gVmhDqp6uMeNdzvg1eVZVOPDRgSu+eYVUiu1cDG1/AVH
         +X2QWyXNseUvQBo/rwAQHqyXbhNswQrh4H9rU8BzYr/GSdlT/ip3Bv8TIGmJrEhY3ZEu
         Q/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8RCi1M3O4ld6apAZMvKosIl9PGcIJils8EaE1SIdw+M=;
        b=gDU8plFj7s9plYo1CbEmvAoIjS7AA1O0yUPosBa0aAvqEqyjXDqe2TB6QPDaZyvJHX
         I9O6mGLH0daPbc5MIwI7G5TBZSIxn+gKjIuaNLK2S96PAmFo4pp6AZ3/q/NRIYm4q6B/
         CyeryAirlRkddx1iOhqPk6qqry5SwWh0oGL4ZuN8sTpmymwOGf47K195/mRVgTsoXBMA
         BoHZbWmBepunQDndTsquarsK4WDyY6iMakWD8BWKRgtT2I0h03KqgNSOE/sktRdckags
         TL9CDhqqdxE3QEDVnD8kyUrOAbias4euC9Z64Lb61sgQ+kO2ZnpfVRly9ga4oFGLqp8d
         sPuQ==
X-Gm-Message-State: AOAM533q5ymloD8AItxg3/UdrLW3LdplHMTKdyp1oyvrY6M6z+UwGVN5
        /23SAEK7GzqE1hxHOONuiG44Ih6tFaweWQlWZWdLiA==
X-Google-Smtp-Source: ABdhPJyLrDDoW78D5UpyZglYbPa7oduwWRh5tpBbor/T+yc/T2P/d9w4kpTi6SaEt+Xp/wQXSqGZWPjyAG4vD/DR0YQ=
X-Received: by 2002:a05:6512:3241:: with SMTP id c1mr2038487lfr.29.1622793629670;
 Fri, 04 Jun 2021 01:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210602120329.2444672-1-j.neuschaefer@gmx.net> <20210602120329.2444672-2-j.neuschaefer@gmx.net>
In-Reply-To: <20210602120329.2444672-2-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 10:00:18 +0200
Message-ID: <CACRpkdaC8jzzE=9TSs-eRy3j3fk3=k_xhgjPXw7DW=rK=Csx0g@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: arm/npcm: Add binding for global control
 registers (GCR)
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 2:04 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> A nuvoton,*-gcr node is present in nuvoton-common-npcm7xx.dtsi and will
> be added to nuvoton-wpcm450.dtsi. It is necessary for the NPCM7xx and
> WPCM450 pinctrl drivers, and may later be used to retrieve SoC model and
> version information.
>
> This patch adds a binding to describe this node.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

(...)

> +    gcr: gcr@800000 {
> +      compatible =3D "nuvoton,npcm750-gcr", "syscon", "simple-mfd";
> +      reg =3D <0x800000 0x1000>;
> +    };

gcr looks a bit idiomatic, isn't

syscon:  syscon@... better?

Nitpicky though and looks good to me either way:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
