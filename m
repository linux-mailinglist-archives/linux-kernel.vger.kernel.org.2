Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3E844E94B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhKLPAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:00:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231553AbhKLPAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:00:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E4786023F;
        Fri, 12 Nov 2021 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636729046;
        bh=HK5VElezVsO+ArdbSXPw+ZjxLAxslirQIKzs9RF1GNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IZ/RTxspKPVsqp+78oDG54VtIGU5AJvN8afg5ZVtzKTWUOa+kW1T7fqdIcBziROo/
         e+I/fkkYx15EX+ifIuqSnBylcbRMPCINPdKNwa9S+vUDSHYh8ve1B7fnkXNVOMtV20
         7uUCLt/Q/GGlxONCUUu7N8ZESpgH+fAm1arfVs7zN4DMSFWxOj8kr0uIZQ1b6+dk8B
         jW4PZ7cwHJd9WR8c/np6gSIFcNtAmJwNIjdoEgL4Y6Vcz+JrgJyoiZ9RbtYjClCf7b
         ay2KMqVj3LxSqAdPLVxLx1Wr9IHfXXhmd8RsfyeeHcLA9jX+o1DYDt6XddmedCF00G
         eTgGfDH69521A==
Received: by mail-ed1-f43.google.com with SMTP id f4so38702538edx.12;
        Fri, 12 Nov 2021 06:57:26 -0800 (PST)
X-Gm-Message-State: AOAM531ClsoD2SlS0EB5aQY/4wOIUEoqTXKQJlC4+GytdQ6Yr4MKrnoZ
        D3gCY2+PzcNS/f+uzrenAxSm8zHVeDQtmxGu7A==
X-Google-Smtp-Source: ABdhPJyWJe8BHRz33TJ4F1ahhx31souP9v5Xukk+K3yJwA77GyyfGY8KyOFx/e90OYkYvWkt5vuPO9j91Vz/A61qKoY=
X-Received: by 2002:a17:907:3f24:: with SMTP id hq36mr20379193ejc.390.1636729044933;
 Fri, 12 Nov 2021 06:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20211112143644.434995-1-maz@kernel.org>
In-Reply-To: <20211112143644.434995-1-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 12 Nov 2021 08:57:13 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+qyER34Q1s3farhX=2=QAic24v1-T0nC+Ln0C5Un81rQ@mail.gmail.com>
Message-ID: <CAL_Jsq+qyER34Q1s3farhX=2=QAic24v1-T0nC+Ln0C5Un81rQ@mail.gmail.com>
Subject: Re: [PATCH] of/irq: Don't ignore interrupt-controller when
 interrupt-map failed
To:     Marc Zyngier <maz@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 8:37 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
> to an interrupt controller"), the irq code favors using an interrupt-map
> over a interrupt-controller property if both are available, while the
> earlier behaviour was to ignore the interrupt-map altogether.
>
> However, we now end-up with the opposite behaviour, which is to
> ignore the interrupt-controller property even if the interrupt-map
> fails to match its input. This new behaviour breaks the AmigaOne
> X1000 machine, which ships with an extremely "creative" (read:
> broken) device tree.
>
> Fix this by allowing the interrupt-controller property to be selected
> when interrupt-map fails to match anything.
>
> Fixes: 041284181226 ("of/irq: Allow matching of an interrupt-map local to an interrupt controller")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/of/irq.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 32be5a03951f..508fb1717de3 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -161,9 +161,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>                  * if it is then we are done, unless there is an
>                  * interrupt-map which takes precedence.
>                  */
> +               bool intc = of_property_read_bool(ipar, "interrupt-controller");
> +
>                 imap = of_get_property(ipar, "interrupt-map", &imaplen);
> -               if (imap == NULL &&
> -                   of_property_read_bool(ipar, "interrupt-controller")) {
> +               if (imap == NULL && intc) {
>                         pr_debug(" -> got it !\n");
>                         return 0;
>                 }
> @@ -244,8 +245,14 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>
>                         pr_debug(" -> imaplen=%d\n", imaplen);
>                 }
> -               if (!match)
> +               if (!match) {
> +                       if (intc) {
> +                               pr_debug("%pOF interrupt-map failed, using interrupt-controller\n", ipar);

Let's make this a WARN for !IS_ENABLED(CONFIG_PASEMI). (whatever the
right kconfig symbol is).

> +                               return 0;
> +                       }
> +
>                         goto fail;
> +               }
>
>                 /*
>                  * Successfully parsed an interrrupt-map translation; copy new
> --
> 2.30.2
>
