Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA24358453
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhDHNNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDHNNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:13:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384B1C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:13:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w3so2973140ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KXkPh24Hwqh6mTV/RDgcTljwHVMEkhnZM2etNRFV8Hk=;
        b=J0XwKAeygTg3yKHLKu/SCPwKPyRpLSZ82umOn5OMnDOwn/xkoygTyXE1AtL/KUjEeL
         mDHUFaYznayZEWTncOeUGTKZm6PhHd8/A4fe//bCp7N56hgS8SWkhyA1g1egZxq6F/ia
         Yp2/OlXNS/3ApbWwtbO9JA7ZMr2L4tKFwW78R3rbgrhkCcqXlGjiwaxWT4dRuudoVZvH
         qE+wym3/w2kljqsl9r1dkLrQNEoZTeWLBoActU3zvsqKLcvhoEfTw7JHsy8+sEaDDbl8
         45GCt05P56xM2SKKCWGQJxAR2+3SVVUw5c0p3jC+RVwyvLUUYjfL/IW5RScb7V79qXVN
         dKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KXkPh24Hwqh6mTV/RDgcTljwHVMEkhnZM2etNRFV8Hk=;
        b=SxMFUdy9MRNq6SYPuyIhd1Y4C4jTFl/9jo/CkNGnk2V87mD6ouPKIys1MpxwxNRdN0
         ZdxQm3o4/QMyO26hmkCoFY9EwGB31QtvVYoH4U/mX8AV0e6B2Wzm9vsDevv29WuZnudO
         3VJv5L3Yxi1YG5W6BpwnK+L3PrBzhTFi3RNyk6l58OxN9Jv5Vo0b0NOV0fbDsIv68Pv7
         KN3dhjTD8lbgItziz8+KMIgoPL92J6FzJ0yNimskRCQfyE0CX7hbGtVusndVdF3b0WdL
         XD+u/YEmg3i6qE/hupEfgnfKHTlCq8Ewxl+5WmfXv98mznXoAZQELx5aui8l2tFWB4Uh
         A2NQ==
X-Gm-Message-State: AOAM530pcL+eUmSp3SFPt3RVbh970QGWTIw55H/zLLUO47mVyvp+Ubog
        NZCOyBUrdfr3dh5WHCRAF0c=
X-Google-Smtp-Source: ABdhPJy1fJViw0AYFh8pvEWm8aKOUNwMhXAzU2iqbXeSUTcIKv4ETrk1db9sxO2LV2y06KbCFzkZ7A==
X-Received: by 2002:a17:906:46c8:: with SMTP id k8mr8063042ejs.389.1617887611011;
        Thu, 08 Apr 2021 06:13:31 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id g25sm17049325edp.95.2021.04.08.06.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:13:29 -0700 (PDT)
Date:   Thu, 8 Apr 2021 15:14:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Carlis <llyz108@163.com>
Cc:     sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        Xuezhi Zhang <zhangxuezhi1@yulong.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/panel: panel-dsi-cm: convert sysfs snprintf to
 sysfs_emit
Message-ID: <YG8BnO1pVhDKCS3F@orome.fritz.box>
References: <20210408085257.2396-1-llyz108@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2bcb+exNMFQwtjzu"
Content-Disposition: inline
In-Reply-To: <20210408085257.2396-1-llyz108@163.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2bcb+exNMFQwtjzu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 08, 2021 at 08:52:57AM +0000, Carlis wrote:
> From: Xuezhi Zhang <zhangxuezhi1@yulong.com>
>=20
> Fix the following coccicheck warning:
> drivers/gpu/drm//panel/panel-dsi-cm.c:271:8-16:=20
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm//panel/panel-dsi-cm.c:251:8-16:=20
> WARNING: use scnprintf or sprintf
>=20
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> ---
> v2: change snprint to snprintf in subject.
> ---
>  drivers/gpu/drm/panel/panel-dsi-cm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Nit: I suspect you might've just resent this from some private email
address, but it's kind of hard to tell because you haven't been using
at least the same name in both email addresses.

However, if you're forwarding this patch on behalf of somebody else you
need to add your own Signed-off-by: line.

Reviewed-by: Thierry Reding <treding@nvidia.com>

--2bcb+exNMFQwtjzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBvAZwACgkQ3SOs138+
s6EXcxAAqJo4eElRQWDWZdgX/WmNo+QgaatLvhDo9ASmYl8sY3Q469PvWVmv2kKp
FUrP2RMOHaRZBu944WQPo09aI9m9EQKKacffyJix5/zZWF6W+HkV5ES3f8/s9s6g
b9DuffTspwaTu8dJsN46bgL1YBR2GIyg5trx185AtO5cy9pwE4s+t6YX74h1wz3N
6UtuhBQ9L2tpK1H23WrHoelp2de53sreS8CzTlLc3j8ysWOio3Pydqo8gnw5+FvX
rkN9WRiCNQryAPIghFcJ5Cmfx2rvEevrcn9zD2OpYv4e+b0RCgz89K54bFsxCx7e
sVkbWWMZueybr9dCYBPglWH+PCq8bocQziPhWxoCRvKyUXR6AQJj7R/80pZdUIEO
2bo5lIWCUxiHLWyO+xKNt56WlauWqLpNr/+d2LQOhr1NDe6tvQ/X8PJGjSdm6U13
n5dfM45voGp6zNdaLO/HWHT9KeznEp2sgwi1SkFhReo/iZRTsa80HJ9bj7yeSiUt
GXeC21u+6CqTZc65WhX6nNH/d+oKvIn2Zt6EQtIKLdYEylWaJDzNO8BcheI4J0x/
awTPZMpzczLdZna8qNQCJf/+CX+dCRBxw/AZlrZoaUosX+ucTeRQs8uLRAqWeFaV
NRFpURCRVYlowM0zwwT6vAVHrPrPkS6HxR6mhTVARvX+nxUua6s=
=GbDC
-----END PGP SIGNATURE-----

--2bcb+exNMFQwtjzu--
