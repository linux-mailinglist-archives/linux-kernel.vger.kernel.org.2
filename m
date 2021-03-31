Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2824A34FA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhCaHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbhCaHhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:37:23 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47560C061574;
        Wed, 31 Mar 2021 00:37:23 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o5so18512183qkb.0;
        Wed, 31 Mar 2021 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmFGanOh+5/h5bQyI1kuE96WZuZNuPL1Dl6Uzo04jXA=;
        b=TaEDR9R0vl6FMDZ1ycwhFCUSydbcAllH2shzMvcHkb6u95KoLKY4V9zmhJtbdLq3AO
         iqAH7Mm1kLuMZa+WNoLfPvTuLbn5JlDwhxairj+uGxVpxseQ6pTxo0NyDruD5MtYGagu
         kTboJU0ZZ+LdJHfdZOz+gf4M8L16olkIclrAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmFGanOh+5/h5bQyI1kuE96WZuZNuPL1Dl6Uzo04jXA=;
        b=ku/1OQ0ZXS6QB3hcYojqZYeEjcSaua0OGQ2U9gn1FIlH9KH8rY7rqzWFtOT55Q63FT
         n6ngOWVJx6iX9+tDNdTODVYR0stzDKVdAx+WCuLOzo8TMrv22q+IZIQyLKLOeuyeF7bI
         cEvDR3ka/xxiBDH6Vtnbi5bK0Tb7DcPDyxhWwnKi0d6y7SZhQcepuK351pDYXwtqzQvd
         4bZLGjRuzfXF/x+opTYWHbMYHuMGZOY0EFwu6gkaCwntMkGduotBiH7Ybb0sgwoYwUJJ
         Riiq7l3FSDwTIlUoymGYEyXROE46dPydwo4CZSMiKWqS14+BSi5DrTk+wDdrlEZDNhMO
         wr+A==
X-Gm-Message-State: AOAM533+oh+SPP7Of7mbRiL3NJg61wywiKaksSgKyaQOjRkXpqZMyGZB
        otBzsFkLPzUu8aetkCXxQ20KcqtehJ0zHUaoVAc=
X-Google-Smtp-Source: ABdhPJz8aL8nt1uu7ZKbEwhzxgPa69OpID3oHVL1idTbMH8oB07t6+ULpCPtoNxSwZxsNs2v353f5Wm/jdDIekqkuSU=
X-Received: by 2002:a05:620a:c11:: with SMTP id l17mr1884039qki.487.1617176242365;
 Wed, 31 Mar 2021 00:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210330020808.830-1-Nichole_Wang@wistron.com>
In-Reply-To: <20210330020808.830-1-Nichole_Wang@wistron.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 31 Mar 2021 07:37:09 +0000
Message-ID: <CACPK8Xfb=U2SH20bxbc4vSM+U6gy8rkCJgHi2UFELrdfSGGO8w@mail.gmail.com>
Subject: Re: [PATCH linux dev-5.2 v1] ARM-dts-aspeed-Add-Mihawk-GPIO-Line-Names
To:     Nichole Wang <Nichole_Wang@wistron.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        small84206@gmail.com, Ben Pai <Ben_Pai@wistron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 at 02:09, Nichole Wang <Nichole_Wang@wistron.com> wrote:
>
> Name the GPIOs to help userspace work with them. The names describe the
> functionality the lines provide, not the net or ball name. This makes it
> easier to share userspace code across different systems and makes the
> use of the lines more obvious.
>
> Signed-off-by: Nichole Wang <Nichole_Wang@wistron.com>

Thanks for the patch. The syntax is good, and I will assume the
information is correct. I will apply it to the tree.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel



> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts | 33 +++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
> index 577c211..15c1f0a 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
> @@ -383,6 +383,39 @@
>         };
>  };
>
> +&gpio {
> +       gpio-line-names =
> +       /*A0-A7*/       "","cfam-reset","","","","","","",
> +       /*B0-B7*/       "","","","","","","","",
> +       /*C0-C7*/       "","","","","","","","",
> +       /*D0-D7*/       "fsi-enable","","","","","","","",
> +       /*E0-E7*/       "","","","","","fsi-mux","fsi-clock","fsi-data",
> +       /*F0-F7*/       "","id-button","","","","","air-water","",
> +       /*G0-G7*/       "","","","","","","","",
> +       /*H0-H7*/       "","","","","","","","",
> +       /*I0-I7*/       "","","","","","","","",
> +       /*J0-J7*/       "","","checkstop","","","","","",
> +       /*K0-K7*/       "","","","","","","","",
> +       /*L0-L7*/       "","","","","","","","",
> +       /*M0-M7*/       "","","","","","","","",
> +       /*N0-N7*/       "","","","","","","","",
> +       /*O0-O7*/       "","","","","","","","",
> +       /*P0-P7*/       "","","","","","","","",
> +       /*Q0-Q7*/       "","","","","","","","",
> +       /*R0-R7*/       "","","fsi-trans","","","","","",
> +       /*S0-S7*/       "","","","","","","","",
> +       /*T0-T7*/       "","","","","","","","",
> +       /*U0-U7*/       "","","","","","","","",
> +       /*V0-V7*/       "","","","","","","","",
> +       /*W0-W7*/       "","","","","","","","",
> +       /*X0-X7*/       "","","","","","","","",
> +       /*Y0-Y7*/       "","","","","","","","",
> +       /*Z0-Z7*/       "presence-ps1","","presence-ps0","","","","","",
> +       /*AA0-AA7*/     "led-front-fault","power-button","led-front-id","","","","","",
> +       /*AB0-AB7*/     "","","","","","","","",
> +       /*AC0-AC7*/     "","","","","","","","";
> +};
> +
>  &fmc {
>         status = "okay";
>         flash@0 {
> --
> 2.7.4
>
>
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------
> This email contains confidential or legally privileged information and is for the sole use of its intended recipient.
> Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited.
> If you are not the intended recipient, you may reply to the sender and should delete this e-mail immediately.
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------
>
