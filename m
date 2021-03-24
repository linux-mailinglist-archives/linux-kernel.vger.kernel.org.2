Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4F347BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhCXPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbhCXPOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:14:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC89C061763;
        Wed, 24 Mar 2021 08:14:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g25so13141936wmh.0;
        Wed, 24 Mar 2021 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vjgABm8xHVXIhTgFNyGGl8fWrWAzbbNLflcWKceQnNA=;
        b=ccgkR98ZWcERYLV/CzKzwcs2nvnlp8jwnRIBMEHVYaiEx7btvyBNNCl2umNmTD1UHQ
         JWgc/bErkLKOwPFvbGSzZ1dJdEkqGtltI08GzIM1cd3zUnoc5A1j9rH5TATCOfcUI+H/
         IeY3xS0PK9z4C6ucUOlDXE4t4sxDRmZGTJuPNk4lWXQzraG50chCiguSYX70q+RadCjr
         wJnu1y2Xx4MVz1e+AJr7UJidUTrakZIMDtTf2VyzcjAnLFESp7iR+8gPpWmOhIeDur+V
         cq2H/K8RJTd1V9MkHxLMXE+VdE1+wxyrzcNxS1GkjOXWbXPh7pk/GbPHbi3B1SNGks56
         Ga1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vjgABm8xHVXIhTgFNyGGl8fWrWAzbbNLflcWKceQnNA=;
        b=JZt8sN43f/YwsUfMU6hCzL3leSqh2qC5SkaUrQ9V2GXg+IVARgxdAkUOfeEdI4rQQL
         WV7NTfGBdQHcDDUe7idENIQS0vi5fSp2JhENOYOnoTwp5x2X9Xco8ErTyoo0rp6oxqUw
         gyTuTOyOWU13XHxn9zVHxz5INSjShoiNY/cPjnAvZHc9aYSZ5LCThbvl5CQyfyD0SlH1
         +S9PdbpZwajawxqZdk7vqSOuf4szKoRin7ww43T0ckBxyttjk+lUlssA2Lf10BJnkIRW
         ZjGXrrhgwAORT+pfbm6cn0zmWulaoEqJm6PkdFsg73NxxTd3hrWBX6QY9GyxTZS2n5+V
         IKaQ==
X-Gm-Message-State: AOAM533o1y144z0V78pFHc/nI9jnymL20gfe+SyeHRBAj6xCebHktKWd
        4xpDzMGdoAcfTjGd26Jald0=
X-Google-Smtp-Source: ABdhPJyOvj1GeY/MtJ72u5NFtRr76OvRZgU6wn3YvkmCUvRWkKpYuEWGPhaiiuhVtZEXft9guX4iMQ==
X-Received: by 2002:a1c:1f94:: with SMTP id f142mr3460945wmf.180.1616598878302;
        Wed, 24 Mar 2021 08:14:38 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f126sm2840936wmf.17.2021.03.24.08.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:14:37 -0700 (PDT)
Date:   Wed, 24 Mar 2021 16:14:57 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] drm/tegra: dc: Don't set PLL clock to 0Hz
Message-ID: <YFtXcTyLrBJShWac@orome.fritz.box>
References: <20210302131506.11790-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7irehgoz3UdKwUP2"
Content-Disposition: inline
In-Reply-To: <20210302131506.11790-1-digetx@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7irehgoz3UdKwUP2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 02, 2021 at 04:15:06PM +0300, Dmitry Osipenko wrote:
> RGB output doesn't allow to change parent clock rate of the display and
> PCLK rate is set to 0Hz in this case. The tegra_dc_commit_state() shall
> not set the display clock to 0Hz since this change propagates to the
> parent clock. The DISP clock is defined as a NODIV clock by the tegra-clk
> driver and all NODIV clocks use the CLK_SET_RATE_PARENT flag.
>=20
> This bug stayed unnoticed because by default PLLP is used as the parent
> clock for the display controller and PLLP silently skips the erroneous 0Hz
> rate changes because it always has active child clocks that don't permit
> rate changes. The PLLP isn't acceptable for some devices that we want to
> upstream (like Samsung Galaxy Tab and ASUS TF700T) due to a display panel
> clock rate requirements that can't be fulfilled by using PLLP and then the
> bug pops up in this case since parent clock is set to 0Hz, killing the
> display output.
>=20
> Don't touch DC clock if pclk=3D0 in order to fix the problem.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

Thierry

--7irehgoz3UdKwUP2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBbV3EACgkQ3SOs138+
s6E1XRAAp4wJgbqgYTYH9FLgeuJ25xmXJbnsEMINM4Cro0mcWnXPCUpZ1TKcCiCa
pxwtGihRgbOU8u1beBuSxK+U6VAmI2Tf/hMUPd0lsr+iyoBK4dF/WnDbswvsyD+h
cA+3B7C8hrAjPEDRvCoJy2AOuqAIaDt76H/NmYcIHXTE3vkqrqyGs27XVos4YJF6
MEuU7BMcnWQsnHmbx9Y0E6gb5mEvAy8uKSeMEOqYb2b0uMdOuN+VYkCH2IlK/tR9
GPOnbaexCpgr1KlaRQ9KQN9agtyVvq+7tZevHVblh9/VOz4IaEWcC8rMM2nNc46O
qibUiITW2qjn2hQdIxezlBVP5TvQdkk1ofNkGGpHi/bnUV8Agn8ptJn09RIExv9f
eQFXbYYRpdSNj+CaXH5OoJA8mlIHKOlyDXdI+xPdn81npecwPMfjfUqcxuaLNPTY
ySvb0qGJAM+6OVLJarR+3VN9jlJe0aNP7zrTS3LI7vxhMNq2tsUb7NrHA6fRFpBz
atgr7fvabtizdkxoMq/ln1LLnGRclB1MtOoIAzetNhuRCGv2YU1MOqr2L0XDLVk8
8cUXSH+YKRs86SYhGYji1K9g2AwWBDUGSv2hYDpYWMyDlcqcs5tGpoWTalPa7yr5
Nv3ayMVv3kjpHpKU2UywwBXAlEzn7/YdYzdrokRLXFf8i7F/29I=
=xaGH
-----END PGP SIGNATURE-----

--7irehgoz3UdKwUP2--
