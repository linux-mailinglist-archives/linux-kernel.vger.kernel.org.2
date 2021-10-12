Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834E9429B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 04:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhJLCtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 22:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhJLCtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 22:49:22 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2258BC061570;
        Mon, 11 Oct 2021 19:47:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t9so80015908lfd.1;
        Mon, 11 Oct 2021 19:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9O4Co6QBwLVOkBI0LJyrQRb8YZ+pNiYDkLLMY/zEjBE=;
        b=BPWH55iRUxci7MR/86u3p9ZBkTXEiXRs1966jxUBGPt2ZpQBJ6vcQ6djbwnokaj3Xy
         7FakdsnV5ugQuv+YXKBYlCwk8p6QMKe6PKP2iWoYi1anPw3TLAyTb9dKdPhR2891pqjn
         M3gX5JnXK4Y2SPlncSrRAl++Bp5eAuMJVqeD5nF9pJtW256stWh/agix4RBq/tPp5O+M
         qp5l7csNZ6ZfWORQXstkHUKGrYZ+Q9FlAgN3vscsTL7gq+pFcpoKb9mNqkNxw/Djin4d
         tDESlUHAqL8w9eVxuadpbwJvHPt0LzdPOgMDfh6QmYbQ3L6OoJzssneGsstfMiI0F6pQ
         g6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9O4Co6QBwLVOkBI0LJyrQRb8YZ+pNiYDkLLMY/zEjBE=;
        b=0Gv2GazC90fm6B8GzGqYpEUxJUVo69TgOJGXFKarolWa+8X5McK577KMFjRV57lZeX
         4oNYeyzTyAywoDkXURbulxA11Vb/kTGbIIvLp+c+CndrBdB6kG58nuCbBNckV3lGLYbD
         Sw03YvoO/oiHMddVvSm/C6NqB0L4WJDGC3j5AkUBeQ6gCIURtAhZY1dEIZzPP/hSXF/r
         uTD9ToQ7bCM5NVU/xoERE+wW5LNLoUo10kLvHj7YTF6ZG7kmso6EJ8O5NmE2YUT+ZoLW
         uysYxqb86ghzv2hgU46s8tTvblAxh7PQgBo7HGIJKL16tOf2DqzptWecQl5KQRyDwpMU
         eTAQ==
X-Gm-Message-State: AOAM532jgwPM1gTMXpBTvPgTv+5658qsS47HrqeACXu975kupm0D/iC8
        56zqKc29qwXl6zQ9B+dCLw7SS+qdd1eDoy7RRK0=
X-Google-Smtp-Source: ABdhPJwL4hjIpyRx3qZJw+omSMkewzzTqEhB8DRkSJ7/FNh1tjRo/86P8DJiEw9D9gEUPczClE18Z9uuXFKUH8TOrBY=
X-Received: by 2002:a2e:9e50:: with SMTP id g16mr20606392ljk.183.1634006836365;
 Mon, 11 Oct 2021 19:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <1633668612-25524-1-git-send-email-u0084500@gmail.com>
 <1633668612-25524-3-git-send-email-u0084500@gmail.com> <YWA+ykStTEyzRbEy@sirena.org.uk>
In-Reply-To: <YWA+ykStTEyzRbEy@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 12 Oct 2021 10:47:05 +0800
Message-ID: <CADiBU3-X5n3b-ZUCFf48C=5oD6RC1E9MD+M6demMLoHzZ3CEBA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: rt9120: Add rt9210 audio amplifier support
To:     Mark Brown <broonie@kernel.org>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, allen lin <allen_lin@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Oct 08, 2021 at 12:50:12PM +0800, cy_huang wrote:
>
> > +static const struct snd_kcontrol_new rt9120_snd_controls[] =3D {
> > +     SOC_SINGLE_TLV("MS Volume", RT9120_REG_MSVOL, 0, 2047, 1, digital=
_gain),
> > +     SOC_SINGLE("SPK Gain", RT9120_REG_SPKGAIN, 0, 7, 0),
>
> Volume controls should end in Volume even if they don't have TLV
> information so applications know how to render them.  I'll fix
> this up as I apply.

It's not linear mapping analog gain and cannot use the TLV as you said.
Mappling table is listed like as below
0 -> 6dB
1 -> 8dB
2 -> 10dB
3 -> 12dB
4 -> 13dB
5 -> 14dB
6 -> 15dB
7 -> 16dB

Do I just need to change it to 'SPK Gain Volume' to present this control it=
em?
Or is there any table mapping for the nonlinear TLV information?
