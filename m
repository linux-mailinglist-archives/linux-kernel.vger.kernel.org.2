Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E854C358458
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhDHNOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhDHNOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:14:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F0DC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:13:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id mh7so2936172ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 06:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ORnP22zy8LvoN6Vu6LgYw2uM6LvPoq/FOOakSRtA/nc=;
        b=KuK/1lB/FSBAtu8ZbhEjVvJQbB6Xng5UiURnhScURFCEOcy+DgdaPqdtt1lzhs/Vgu
         IypVnWVth+wlFQ6/tXt4hXpU55G5FLXt7y5pVRYL9BduuDBnJjiKDx8/6SCNsIGGJLDf
         c6S4sn5pMw7F2SwNCOfLrLH/73Uaq+moVOgDEjV0SECHB2aRbotk7HldVhRGequQRUom
         A8On1kGXIQZt5FsfSf/mMFFPV2lkppv1O5UlqoM8ZOl8unoZXmAKHmInQ70QJqcE/KYN
         kmWyKfajv7UV769vQ/JhHnEnkPAafEukL9Bp1rTmsyrQ5Fd3ClAwMrUdJSkP5TMyxcN6
         LZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ORnP22zy8LvoN6Vu6LgYw2uM6LvPoq/FOOakSRtA/nc=;
        b=koaIqcRJpIftEH2hlMvDBTjKKn7dCfan2QP5qd6O8L33vkEY5sgYAHJUjDicQFfEiW
         iUa6HynkNEeGokRtuHhu4c1TZMD0+G9md20kU/YX81NkIuWNCHO2g9LQSphfXQ6HSGkU
         z9290Vq6cilxnvy2x2QZf1AH9eqnyEY8MWj1YlEZsqIf8sxW9HhccJM0hNVjyAnTx0Sf
         U7zpzjafBtSE6fUlVopIwwkJ/DbXY8kB9JRIuJaXFs5QkFUF/VBjOLw/RM4Bhc4cOmvS
         Owno3bgana/hQfdGrq6FUOt65LMiGrjDyeS3/viKEi2VsEn89dyw6G3cA1GLR1i9zaJw
         lySA==
X-Gm-Message-State: AOAM532WToiiQVdECGKq8I4UgmDENv+99nzlrM2/0j9u+gc+47D+UuZp
        JXZXbxMJInXJFpr5vOX4N+E=
X-Google-Smtp-Source: ABdhPJznXYjOCMyfm018yESs3U9GslqjR0p43VPV8g/LUGhePUpX0KIRm/szFgxKi0Pamq6bndWqHw==
X-Received: by 2002:a17:906:a84e:: with SMTP id dx14mr10525890ejb.332.1617887628411;
        Thu, 08 Apr 2021 06:13:48 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id rk1sm10014019ejb.88.2021.04.08.06.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:13:46 -0700 (PDT)
Date:   Thu, 8 Apr 2021 15:14:21 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Carlis <llyz108@163.com>
Cc:     sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        Xuezhi Zhang <zhangxuezhi1@yulong.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/panel: tpo-td043mtea1: convert sysfs snprintf to
 sysfs_emit
Message-ID: <YG8BrQHbhiaxl9Yo@orome.fritz.box>
References: <20210408083118.557966-1-llyz108@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iW+l5Rq0Obxe6tJ6"
Content-Disposition: inline
In-Reply-To: <20210408083118.557966-1-llyz108@163.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iW+l5Rq0Obxe6tJ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 08, 2021 at 08:31:18AM +0000, Carlis wrote:
> From: Xuezhi Zhang <zhangxuezhi1@yulong.com>
>=20
> Fix the following coccicheck warning:
> drivers/gpu/drm//panel/panel-tpo-td043mtea1.c:217:8-16:=20
> WARNING: use scnprintf or sprintf
> drivers/gpu/drm//panel/panel-tpo-td043mtea1.c:189:8-16:=20
> WARNING: use scnprintf or sprintf
>=20
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> ---
>  drivers/gpu/drm/panel/panel-tpo-td043mtea1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--iW+l5Rq0Obxe6tJ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBvAa0ACgkQ3SOs138+
s6FHrBAAgrJO/HTk7DOFWultZrY/kAAAIYXxpOImF+Rc8zyUMN4hdnoATntvIGeN
s27b6P3IKWoCWZN0X/1a/kpvD0m5T/dgGO0STiwPwv9FcF9vLsHgrKo3wAnTT4v4
LlRfyATP+jRVZcuQDeXmGfoiLb+4y5yJj9u2g020fmUcLeTSLHeFMU0s3rXzlcz/
Vs3R7oGEUnvQ/azSiuGDg7kiX3WqHTDEHCPoiHqXz5RaKv1lJHCR1kOv4q4ZdEri
+6OHGTCuEt5JdYYAlJbtaEcumuAQqVg6YEFwEUWxJtHsVxxecwG6iWSaLHq/E2Ht
Zr+FrfixwG3AcZ7ofnzQ9jI8HWZ72gf/LfPiYBEMRoCzGloE6xIw3SF3CrbiTE1H
kk1zHfXvnkdqwrC5lwRPTPSe7jRqTpR+Kcw4G1Y3Fxu5KtPUMeaov4LQhG8BClU6
0gPEU7p5RaZuzPaAE/kinxlrz8LK8BJn87DD+DkdU8flDSEadq0JZvB/gH+7Oh8H
magjg7Ftva+ervLRUkTLcLgNpySklTa6BhR9tgNfiPV4hTyVLFc4BhqZYBXdeiLT
VbMc697uEeJJVwATCJ+NSaRvHe1XvGW1b+YLBAW6FtxqaaTmJHADW5qEZSbx5WkY
U1dvSvF82rR7gm7SEF5uTcwjaQbm+Xl8HofXCBTPrFV6ugSyPzM=
=tEPk
-----END PGP SIGNATURE-----

--iW+l5Rq0Obxe6tJ6--
