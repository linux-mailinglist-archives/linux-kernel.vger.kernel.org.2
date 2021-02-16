Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26E931D331
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 01:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhBPX5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 18:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBPX5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 18:57:19 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6471AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 15:56:39 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id y26so19307538eju.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 15:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v1fsjgbCZ05cc8hXO6K7K4My807oZ/pqrKSLTXR9l0k=;
        b=Ebb3tZWHf3D/y/GYLSLShY3I3CWGIwUk/5/ow2pAR6tezFMm8loD+rWC+9OS4a/Vjm
         W+aOCmNz0gOpNiDwywTiTor/dCT5b0Wrdi5Pg/WqPtPBa4jLK4cOBDL9Oe0MVDvpsww2
         bREp+cc8ozjYLzqxJhfABHIYE7pY+kUF1BuSnPXmyynRdVjwHKWOcekyc+loV9UsBp4C
         uMXMcbxI5K1JgVpLdVrMZJn7lUvQ/prv96OB0TsJhNGIONrryYbaZyHrwLtdaBq5VU23
         z3luqpY1eh46uRbyYjK4la3aX46MK662Tsxq8ALGz0TwtfT826ZxwENQVXr7BupCVUrB
         KE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v1fsjgbCZ05cc8hXO6K7K4My807oZ/pqrKSLTXR9l0k=;
        b=AD3bXAm+/Laf+U8it1+BMuE5i8famLobitmSbVVXqQVozCAB3+j9heZuj6fBVIzi3D
         1fXsA5RMMzPA60tJskuVSK6OR6DiBEPdHdM/hSlgV+TNFygMLtgyQlkR6r1Me4XEqo1n
         VhLlboJHB/7wiaHJT7C8xupJyz0g/iuSnK9szusmUXzVjnA5ys4A6YrDLb2CYY4ovk02
         zOEdZPG9el2zc280WR46pRbAc5Iyi/lopBzTRQxYoicItpLm3tV5R3vlX/l6VEg8/ZG2
         ZK7VZ3VxizpICfxg6+Ix9S1Og+mCXXOJPhpz2x0HJoY6rcIbPLELbiVLqHtk2s0vJFuc
         gfDw==
X-Gm-Message-State: AOAM532ocWybBhmr7durTWGF/JRBeQduInA6eGUkRro2z4PChrqES9D/
        glu4MCMTzCoSK1hokzi2WpGr8l7LZdd7S47IFy4=
X-Google-Smtp-Source: ABdhPJw+4+D8JrYUjZ9ORrd1Am7KSDIt+5zYTVNV8PKpBa1ehjVA6xIHSijjFwwHjNp+wpk5gWPVMWN7uKGEIf0oL70=
X-Received: by 2002:a17:906:6943:: with SMTP id c3mr22439086ejs.133.1613519798150;
 Tue, 16 Feb 2021 15:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20210216060128.126938-1-axel.lin@ingics.com>
In-Reply-To: <20210216060128.126938-1-axel.lin@ingics.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Wed, 17 Feb 2021 00:56:27 +0100
Message-ID: <CABkfQAFO6Xog=Eej1k6iT8BpJWLO9=n6o_YEkBxp4d6uiUv0uQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: pf8x00: Use regulator_map_voltage_ascend for pf8x00_buck7_ops
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 16 f=C3=A9vr. 2021 =C3=A0 07:01, Axel Lin <axel.lin@ingics.com> a =
=C3=A9crit :
>
> The voltages in pf8x00_sw7_voltages are in ascendant order, so use
> regulator_map_voltage_ascend.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/pf8x00-regulator.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8=
x00-regulator.c
> index 9b28bd63208d..5d319fb81288 100644
> --- a/drivers/regulator/pf8x00-regulator.c
> +++ b/drivers/regulator/pf8x00-regulator.c
> @@ -359,6 +359,7 @@ static const struct regulator_ops pf8x00_buck7_ops =
=3D {
>         .disable =3D regulator_disable_regmap,
>         .is_enabled =3D regulator_is_enabled_regmap,
>         .list_voltage =3D regulator_list_voltage_table,
> +       .map_voltage =3D regulator_map_voltage_ascend,
>         .set_voltage_sel =3D regulator_set_voltage_sel_regmap,
>         .get_voltage_sel =3D regulator_get_voltage_sel_regmap,
>         .get_current_limit =3D regulator_get_current_limit_regmap,
> --
> 2.25.1
>

Reviewed-by: Adrien Grassein <adrien.grassein@gmail.com>
