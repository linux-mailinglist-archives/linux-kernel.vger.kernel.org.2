Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A48E3920C0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 21:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhEZTVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 15:21:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52384 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhEZTVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 15:21:31 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 74A841FD29;
        Wed, 26 May 2021 19:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622056798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hqbhriqmCcciHIB7mk5FuXde0piQc0mRXAnLSLPVv6w=;
        b=H/NQ1j7Mbd7Pfu1qFah0SN4EMsw2uS03jnAuR5KmVT/5eR/XUYFgJaCrArw5XXz8PhXLM2
        bPjiljd1xj/+EHCb5J5nMh3tCpqEV5CR5PKJDQ7r4f1YmbQO23LCt3QTPQdjb94se7fEmD
        RpyGH496dbO8ra/Qn/B/R0RGbsxZNZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622056798;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hqbhriqmCcciHIB7mk5FuXde0piQc0mRXAnLSLPVv6w=;
        b=5+X7sEAuKlfnbIyB5qwXUeMsxTdtStWn0d/Znh5waJ0Mu+ZGDPmIpQ7tkaJTj+Z78GPPUH
        7SNjtjpAD+NZYnAw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 3D63511A98;
        Wed, 26 May 2021 19:19:58 +0000 (UTC)
Subject: Re: [PATCH RESEND] drm/hisilicon/kirin: Use the correct HiSilicon
 copyright
To:     Hao Fang <fanghao11@huawei.com>, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Cc:     xinliang.liu@linaro.org, linux-kernel@vger.kernel.org,
        kong.kongxinwei@hisilicon.com, prime.zeng@hisilicon.com,
        tiantao6@hisilicon.com
References: <1621678529-14389-1-git-send-email-fanghao11@huawei.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <eaf3cf6e-15a2-d4e7-ef20-feccbd05f4f8@suse.de>
Date:   Wed, 26 May 2021 21:19:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1621678529-14389-1-git-send-email-fanghao11@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2dEXEAO91CKbftB1NjHLrof9OR84KyGkF"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2dEXEAO91CKbftB1NjHLrof9OR84KyGkF
Content-Type: multipart/mixed; boundary="sRdyYcMUuDjLfe42TPoLhEtJpdwXD0wXa";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Hao Fang <fanghao11@huawei.com>, airlied@linux.ie, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org
Cc: xinliang.liu@linaro.org, linux-kernel@vger.kernel.org,
 kong.kongxinwei@hisilicon.com, prime.zeng@hisilicon.com,
 tiantao6@hisilicon.com
Message-ID: <eaf3cf6e-15a2-d4e7-ef20-feccbd05f4f8@suse.de>
Subject: Re: [PATCH RESEND] drm/hisilicon/kirin: Use the correct HiSilicon
 copyright
References: <1621678529-14389-1-git-send-email-fanghao11@huawei.com>
In-Reply-To: <1621678529-14389-1-git-send-email-fanghao11@huawei.com>

--sRdyYcMUuDjLfe42TPoLhEtJpdwXD0wXa
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 22.05.21 um 12:15 schrieb Hao Fang:
> s/Hisilicon/HiSilicon/.
> It should use capital S, according to
> https://www.hisilicon.com/en.
>=20
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> Acked-by: Tian Tao <tiantao6@hisilicon.com>

Applied to drm-misc-next. Thanks a lot.

Best regards
Thomas

> ---
>   drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c    | 2 +-
>   drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h    | 2 +-
>   drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h | 2 +-
>   drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 2 +-
>   drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 2 +-
>   drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h | 2 +-
>   6 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu=
/drm/hisilicon/kirin/dw_drm_dsi.c
> index 00e87c2..9b565a0 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
> @@ -3,7 +3,7 @@
>    * DesignWare MIPI DSI Host Controller v1.02 driver
>    *
>    * Copyright (c) 2016 Linaro Limited.
> - * Copyright (c) 2014-2016 Hisilicon Limited.
> + * Copyright (c) 2014-2016 HiSilicon Limited.
>    *
>    * Author:
>    *	Xinliang Liu <z.liuxinliang@hisilicon.com>
> diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h b/drivers/gpu=
/drm/hisilicon/kirin/dw_dsi_reg.h
> index 19e81ff..d79fc03 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h
> +++ b/drivers/gpu/drm/hisilicon/kirin/dw_dsi_reg.h
> @@ -1,7 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
>   /*
>    * Copyright (c) 2016 Linaro Limited.
> - * Copyright (c) 2014-2016 Hisilicon Limited.
> + * Copyright (c) 2014-2016 HiSilicon Limited.
>    */
>  =20
>   #ifndef __DW_DSI_REG_H__
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h b/drivers/=
gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> index e2ac098..be9e789 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_ade_reg.h
> @@ -1,7 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
>   /*
>    * Copyright (c) 2016 Linaro Limited.
> - * Copyright (c) 2014-2016 Hisilicon Limited.
> + * Copyright (c) 2014-2016 HiSilicon Limited.
>    */
>  =20
>   #ifndef __KIRIN_ADE_REG_H__
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/=
gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> index 6dcf9ec..1ab9462 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -3,7 +3,7 @@
>    * Hisilicon Hi6220 SoC ADE(Advanced Display Engine)'s crtc&plane dri=
ver
>    *
>    * Copyright (c) 2016 Linaro Limited.
> - * Copyright (c) 2014-2016 Hisilicon Limited.
> + * Copyright (c) 2014-2016 HiSilicon Limited.
>    *
>    * Author:
>    *	Xinliang Liu <z.liuxinliang@hisilicon.com>
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/=
gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> index 4349da3..e590e19 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> @@ -3,7 +3,7 @@
>    * Hisilicon Kirin SoCs drm master driver
>    *
>    * Copyright (c) 2016 Linaro Limited.
> - * Copyright (c) 2014-2016 Hisilicon Limited.
> + * Copyright (c) 2014-2016 HiSilicon Limited.
>    *
>    * Author:
>    *	Xinliang Liu <z.liuxinliang@hisilicon.com>
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/=
gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> index 386d137..db0dc7b 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
> @@ -1,7 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
>   /*
>    * Copyright (c) 2016 Linaro Limited.
> - * Copyright (c) 2014-2016 Hisilicon Limited.
> + * Copyright (c) 2014-2016 HiSilicon Limited.
>    */
>  =20
>   #ifndef __KIRIN_DRM_DRV_H__
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--sRdyYcMUuDjLfe42TPoLhEtJpdwXD0wXa--

--2dEXEAO91CKbftB1NjHLrof9OR84KyGkF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmCun10FAwAAAAAACgkQlh/E3EQov+DE
4hAAw9jaAQtmGnJcUZboDUwjz599vqNZPLNwpLXv9ZF62dkgn8b7knmQw/wjUw3kfmcBNcK4Xdm0
wLSuo2GcOny/R1Q+IgHNLbk4ja1m9lCODb0oScN3WlWwarCsapETJGi+KEnBayG3+wMyrMCfD6Xx
WEd6NyG6hRO9Y5wtxYfpm+LFEJQ1zXHOR7DQV5ZSUc+p7vktA4adJ/nbmVHWN+59mhftBWgqJgLa
nFueUU1JC/Uc6YJ8duN10yz4JJSUJWkzv88A1w8gDGi/ef9NyrAfspmERk1l1qOjhP2+59fTKLwQ
W6RClQZ+JV+8x2VX+pYoxOrq14RERXgVryCCL3PeDoPfjYqYWTBbXEWp95VVA+umvIw4IXJsawlP
mb81LBu4xF4uFe8ktCL+RBkWurXqCKTuszqMols/Y4OQEH13DkKsKhVyvpQ5eprRh2xb4vvFSoyr
ZjqlHPbu6GWq12tLFyVph7zvRp90Ez2ZMDozCFTv1P8Rn8aiCDgDEYkoODVnn3h/vT4UJBv+9k55
JtjxRba1y/XS1TCaD+9bYz8Gcp3ohsp7yalx7VH94emFnuz+9elsk8SiBHcCKr05z2gwxQjF/fjN
LMm4dsmXIS1sBIwu7zaj9j6Mg/O/WatSJ27bzhA1Hr8/9POA0A7CFoV/wxfr3Evz4EMlPDM8GgUi
i2c=
=B125
-----END PGP SIGNATURE-----

--2dEXEAO91CKbftB1NjHLrof9OR84KyGkF--
