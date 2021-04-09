Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0689359D86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhDILg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDILg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:36:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B077C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 04:36:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f8so6155682edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 04:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nbNDR2eeqYjmngGUidbBGsBnskKnh+qdgD+L7bANBho=;
        b=TDEtFMFECqYYEkbrn8wSm5i6Ikz03xw2/mqFipa0+CYEjaqZw1gB9GAlEAwUTI0PHX
         k8UASCtbBqqCR1KL9BmB9ocVEl0g2pmE8jMPIrzx5LPHvPI+J5/ARMUH1H7DXFyGh1q1
         /lXErXoYtChtHH49yU9UpDj3uzQzei0bhHlWhR5OKJYCcSEgwNytoQZzu/GowUa/eHUw
         ipSv+bFy7dabT+EIagFDp5oXXpPW0jqt/2WPAas+Mtor3+hABudWpYh83YSvKk7sQLz1
         sMLXltn+B24bu0bmn/Xa/jl3J2s5s4ndiRd0dNHkGn+Tk8zCH8K4g5jNXL2pkZRcZVVh
         rtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nbNDR2eeqYjmngGUidbBGsBnskKnh+qdgD+L7bANBho=;
        b=FHfmPRmGjK4ORJO9gwnMKqcpGTrubTIg36CUaoOcgUXtee6nQB1oyDLyTXGwRHQVK9
         GTJ++fBzi0Av63dZh8PesEwE9Ap02KrxHUtfcZhVND6NPtRNPPdGr9Xevf68gHdR4ElJ
         upuCarh8lfwvUm8lZz6dIgf167I5UZLyYGDv7s4MsFdTyurngqwE3a0OsCJEW44x1pTC
         9xNeCyv0OrWxuXr8KfoFRyEaG8Mr58kuzJqSWprQM0dlY7ShhvLmOAXb+I/Omm/THoK7
         /6RCy2ntaMZEwfCI+4Bz7eN4smLFw7T1SN9/sPJMwHCTkzBbU/W6q8a7TU23E93X2LTc
         F6ZQ==
X-Gm-Message-State: AOAM530LZUtauc54eCI9Na6VoMzG5zlVCDFdeKW/WaUdMAs5zgMWKfa/
        4+nvexuhiNRXqL3/Ga3mT4Q=
X-Google-Smtp-Source: ABdhPJzAEdFg9M01x+B9sb2EXJPJlPExD56rRkoRp40+evoDlBF+5iWif7MNkywO77h+uHiThocPcA==
X-Received: by 2002:a05:6402:42d1:: with SMTP id i17mr16562036edc.131.1617968171075;
        Fri, 09 Apr 2021 04:36:11 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id ml13sm646313ejb.7.2021.04.09.04.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:36:09 -0700 (PDT)
Date:   Fri, 9 Apr 2021 13:36:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Xuezhi zhang <llyz108@163.com>
Cc:     sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        Xuezhi Zhang <zhangxuezhi1@yulong.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panel: panel-dsi-cm: convert sysfs snprintf to
 sysfs_emit
Message-ID: <YHA8TShmlkso9DOK@orome.fritz.box>
References: <20210408085257.2396-1-llyz108@163.com>
 <YG8BnO1pVhDKCS3F@orome.fritz.box>
 <20210408230726.00006836@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FMGdGfsk9tUj0kAs"
Content-Disposition: inline
In-Reply-To: <20210408230726.00006836@163.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FMGdGfsk9tUj0kAs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 08, 2021 at 11:08:49PM +0800, Xuezhi zhang wrote:
> On Thu, 8 Apr 2021 15:14:04 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Thu, Apr 08, 2021 at 08:52:57AM +0000, Carlis wrote:
> > > From: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> > >=20
> > > Fix the following coccicheck warning:
> > > drivers/gpu/drm//panel/panel-dsi-cm.c:271:8-16:=20
> > > WARNING: use scnprintf or sprintf
> > > drivers/gpu/drm//panel/panel-dsi-cm.c:251:8-16:=20
> > > WARNING: use scnprintf or sprintf
> > >=20
> > > Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> > > ---
> > > v2: change snprint to snprintf in subject.
> > > ---
> > >  drivers/gpu/drm/panel/panel-dsi-cm.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-) =20
> >=20
> > Nit: I suspect you might've just resent this from some private email
> > address, but it's kind of hard to tell because you haven't been using
> > at least the same name in both email addresses.
> >=20
> > However, if you're forwarding this patch on behalf of somebody else
> > you need to add your own Signed-off-by: line.
> >=20
> > Reviewed-by: Thierry Reding <treding@nvidia.com>
>=20
> Hi,
>    the email address of llyz108@163.com is my private email address,
>    and zhangxuezhi@yulng.com is my company email address, and Carlis is=
=20
>    my English name ,Xuezhi Zhang is my Chinese name, i will use the
>    Chinese name to send the emails and patchs in the future.
>=20
> thanks,

It's not a big deal, I'm just mentioning it because it can confuse
people. Yes, using the same name in either case is usually a good way to
make people realize what's going on.

Thierry

--FMGdGfsk9tUj0kAs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwPE0ACgkQ3SOs138+
s6Ezbg//XvQs5S0EFdrKnRAfWYfb3dPxQzzIN2c5Dd2BwlzHZ554z8l4qB5pog2n
uv2d7VyGyIAdb6mhoboqsTnyM1MSz2VQZmtSvoN4HFIArIUc/VT+BkasLqFVOg6f
S8i9/CpDZTAahETq+4AA4VwjDZhLIiwdTvvo5+jZaZRkXR5hTRy+0Loxi3EANnQG
I/blQG0Fj4DIy+BsoSUGMUn4faVlBlJ4m8sQcxWsK3Ip0gtES0l5peP9HxEEoT59
uINpX7Rh+NGRoJSaEaxx0eFgYVNDyfKA6PPID8YwT0uPicAuQWobe0Dc4owCZm4p
0w1ZQzryV3H17Sz8Zs82teaf4a3EWWTCjcG2w8LozKiSTFoIKZQfXJ0qXqMDCTFR
ZhkqBnEJAb1/kZ12CrTQ3QpfcV8tiL1+j+jAQMdq1Qa6WEkyrmVVXZYYmqGtTXLw
J6kxseewZKwjjsbWsxHC8WPkYOYrpdBxNmYb/zPMTxxn8anb+1WiKsSddouC6Mrr
sKjJaMmMJjUabXgxwPoRUv4w3ppM4K2BQ6mKS8CNx2J0WlNHAOH2X1ISg/6RXUZ4
LtrWa5FHEGA2Q3uq+Ja2KLpHxdExIt1RPGDBmUBHWqmoD+sk6RgDDybhUIk2xTlH
R1iW0ns1GKE9EfaY8fNq08xH31ia6mho5/ZyHy8UFvJeCAAiz74=
=ZLrJ
-----END PGP SIGNATURE-----

--FMGdGfsk9tUj0kAs--
