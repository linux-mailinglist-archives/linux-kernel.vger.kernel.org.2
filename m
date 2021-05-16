Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BD2381E13
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 12:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhEPKbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 06:31:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:51288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhEPKbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 06:31:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 743F5B19E;
        Sun, 16 May 2021 10:30:34 +0000 (UTC)
Subject: Re: [PATCH v2] drm/rockchip: remove existing generic drivers to take
 over the device
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20210516074833.451643-1-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <ef974dd8-5619-35b7-74de-4e270033a3c3@suse.de>
Date:   Sun, 16 May 2021 12:30:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210516074833.451643-1-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CgsAfYMijZeSUxsTEVcfK6QxtTFVXoV5Y"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CgsAfYMijZeSUxsTEVcfK6QxtTFVXoV5Y
Content-Type: multipart/mixed; boundary="eFIA3Z1QtOvjCQCEJlVTMcjzxEoaPtTlo";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@linux.ie>, =?UTF-8?Q?Heiko_St=c3=bcbner?=
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Message-ID: <ef974dd8-5619-35b7-74de-4e270033a3c3@suse.de>
Subject: Re: [PATCH v2] drm/rockchip: remove existing generic drivers to take
 over the device
References: <20210516074833.451643-1-javierm@redhat.com>
In-Reply-To: <20210516074833.451643-1-javierm@redhat.com>

--eFIA3Z1QtOvjCQCEJlVTMcjzxEoaPtTlo
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 16.05.21 um 09:48 schrieb Javier Martinez Canillas:
> There are drivers that register framebuffer devices very early in the b=
oot
> process and make use of the existing framebuffer as setup by the firmwa=
re.
>=20
> If one of those drivers has registered a fbdev, then the fallback fbdev=20
of
> the DRM driver won't be bound to the framebuffer console. To avoid that=
,
> remove any existing generic driver and take over the graphics device.
>=20
> By doing that, the fb mapped to the console is switched correctly from =
the
> early fbdev to the one registered by the rockchip DRM driver:
>=20
>      [   40.752420] fb0: switching to rockchip-drm-fb from EFI VGA
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Ping me if no one else merges the patch.

Best regards
Thomas

> ---
>=20
> Changes in v2:
> - Move drm_aperture_remove_framebuffers() call to .bind callback (tzimm=
ermann).
> - Adapt subject line, commit message, etc accordingly.
>=20
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/=
drm/rockchip/rockchip_drm_drv.c
> index 212bd87c0c4..b730b8d5d94 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -16,6 +16,7 @@
>   #include <linux/console.h>
>   #include <linux/iommu.h>
>  =20
> +#include <drm/drm_aperture.h>
>   #include <drm/drm_drv.h>
>   #include <drm/drm_fb_helper.h>
>   #include <drm/drm_gem_cma_helper.h>
> @@ -114,6 +115,15 @@ static int rockchip_drm_bind(struct device *dev)
>   	struct rockchip_drm_private *private;
>   	int ret;
>  =20
> +	/* Remove existing drivers that may own the framebuffer memory. */
> +	ret =3D drm_aperture_remove_framebuffers(false, "rockchip-drm-fb");
> +	if (ret) {
> +		DRM_DEV_ERROR(dev,
> +			      "Failed to remove existing framebuffers - %d.\n",
> +			      ret);
> +		return ret;
> +	}
> +
>   	drm_dev =3D drm_dev_alloc(&rockchip_drm_driver, dev);
>   	if (IS_ERR(drm_dev))
>   		return PTR_ERR(drm_dev);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--eFIA3Z1QtOvjCQCEJlVTMcjzxEoaPtTlo--

--CgsAfYMijZeSUxsTEVcfK6QxtTFVXoV5Y
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmCg9EgFAwAAAAAACgkQlh/E3EQov+Cp
Qg/9HN4te27mlOT2TDrylnxgpX3owAC7vklx3in4qv98txGEXqyu/9Cm2i/4gZhcmlKHVstRt6a9
2frl4GDI3pnwJKQDhq9z81Ylc2hpH+Cb1TePDsl/wyLKRbG5bJtJ1kspkcFSk9azjtS97Iv8WW/8
ZDpTsyyTCtKU4vNIKIkHriDZQ8Yc3nSZV3eCcueYxzvRoGw/Q776Rn3UQryabzUTQLf+L6qYRS4n
BaFo2sx1xndVn9cuo+fX0lOG+jHj0wuMLWQ+VInLYxpoNF1GaYf22DE00h8OTozckcbDfVyaYjou
LJnsBbqWy4MvjFXQ6FomefoiATUbkOw1hVIs6k4IRWYX860v93XBTzVl75gMlBpmPzfnd1O5WlzC
4WOfcnLYG/0I64P8cG+vFEmcmOt4XNJUrrft82hYMR7Dx/38aQcP39n0YnkE5FEarkKaadicnSx/
0hC9o6iQCe8uc3KxBNONHuqRIoToQAGd7L9YB+3TV54pzKc1hOP0ciRBu76G+A70bRn2CPzAoMop
JVSjOmci6VMxz5JBhLG9zl81jrBvzRO0dPjZBy+zhIQNmVGIxQUFROfeBv0U6LZsURFuD9s6JfZz
bjLc+P92rB7Tu/YGQlwuyCt7+00TCMbMoJBEd03F9IaNUi4JYWaXt6f7+MuxKfUR5DAY3iICHgTz
Nq4=
=1U/I
-----END PGP SIGNATURE-----

--CgsAfYMijZeSUxsTEVcfK6QxtTFVXoV5Y--
