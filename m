Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CE73CD516
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbhGSMHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbhGSMHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:07:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7598BC061574;
        Mon, 19 Jul 2021 05:05:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h1so9512779plf.6;
        Mon, 19 Jul 2021 05:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BOHLfhVl4IX0jBgxq0tnyQp2G2EwOVwQ6QtIbNjmVL4=;
        b=BwBOE9uM1AY+Uh+eIMJgcSjFDrxGQiYieHqE8DHsDxmjfTTLSEJhMBRJ0Na6LOjCTx
         ynnbyDPNdbL5i/xGIauqPd6AKgFtjisEzf/km17aZPQSrYI9yxzF8aLYB54afng34ZZd
         EVna5SzPnhPbukw+rG6HIZ2mzZULX90AFnJ2kFTRRRoMDb92UlMDzz1csUhhG7KjRVvH
         R44ZzSqbg187NzBCz5oG+SRc25G7x9G+Q6bZSNUR80VwKc3C9lGOfAyXE/luKXx+xbNW
         T1QdFWiEQWE2I7QkQ5V+da6d8bOa74aaSjRKSiG+mItXjZ9UwNGhGFugX6vS18MS+wTy
         LfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BOHLfhVl4IX0jBgxq0tnyQp2G2EwOVwQ6QtIbNjmVL4=;
        b=gn9KSH/QVYdlOCCHB/xnI7QySCQokYxEmyvYT8pwRuGYskdfzEj+BAL46Atm/iAoJs
         lSvYmfjSXWH9V1TF1Y9cTH5lECC6wxd4mKGRkA3xEKseELIR7nEpfB4plGljSHntJcZB
         C6bgcoqu0oKK2U1vAEeGwR3cBLaTuELCLBX4M/Cv5sU5jwrWKyYjCFGTSB4irVD9x51x
         p0BpxjKJjqKRXAgBRU1HmIl0WaIZ7mI+RnAicDQmn7YkOz1O0qgdpPNSabWUuZnjKgKf
         6fCad5Hrnw7WXxaD+q9LLKvkeAYxzvK4E4uDZKtklrsfqq1k02PT6dHWwthc6Roa2R3a
         hqvg==
X-Gm-Message-State: AOAM5322uX/+GYoexcIJiUgEuyEU8BRcHIFLikISpz3N4Q56JBEYrAfV
        xBxt3SKUwxAZAnq5untKfqnQBnlTT/Nhn/WTVkg=
X-Google-Smtp-Source: ABdhPJxwcacipucz4PoseENZgZjBWKi1SW7dWOKNKkP4F/S4fGWnSOCuFP9GvjxQ6z7ZIZbfaIdloSyeopenMQXRneo=
X-Received: by 2002:a17:90b:3647:: with SMTP id nh7mr24796132pjb.228.1626698866913;
 Mon, 19 Jul 2021 05:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210624224909.6350-1-pali@kernel.org> <20210717123829.5201-1-pali@kernel.org>
 <20210717123829.5201-2-pali@kernel.org>
In-Reply-To: <20210717123829.5201-2-pali@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Jul 2021 15:47:07 +0300
Message-ID: <CAHp75VeCC3cYu3RZPxuRN4iaM+vxp2rX+E4z+ZxzRGM8oHaMkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] math64: New DIV_U64_ROUND_CLOSEST helper
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 3:39 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Provide DIV_U64_ROUND_CLOSEST helper which uses div_u64 to perform
> division rounded to the closest integer using unsigned 64bit
> dividend and unsigned 32bit divisor.

...

> +/*
> + * DIV_U64_ROUND_CLOSEST - unsigned 64bit divide with 32bit divisor roun=
ded to nearest integer

> + * @dividend: unsigned 64bit dividend

Here you insist users to provide a u64 (or compatible) type.

> + * @divisor: unsigned 32bit divisor
> + *
> + * Divide unsigned 64bit dividend by unsigned 32bit divisor
> + * and round to closest integer.
> + *
> + * Return: dividend / divisor rounded to nearest integer
> + */
> +#define DIV_U64_ROUND_CLOSEST(dividend, divisor)       \

> +       ({ u32 _tmp =3D (divisor); div_u64((u64)(dividend) + _tmp / 2, _t=
mp); })

Here is the casting to u64. Why? (Yes, I have read v1 discussion and I
just want to continue it here).

--=20
With Best Regards,
Andy Shevchenko
