Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F77931DF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 20:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhBQTWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 14:22:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:48034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232032AbhBQTWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 14:22:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A3C7AC97;
        Wed, 17 Feb 2021 19:21:27 +0000 (UTC)
Subject: Re: [PATCH v2 02/11] drm/qxl: more fence wait rework
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-3-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <11f0d3e5-8823-212f-0f4e-83a639a1d476@suse.de>
Date:   Wed, 17 Feb 2021 20:21:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217123213.2199186-3-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="85GU1GqhvOPcBOU6e0aBenn292yxkgXpN"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--85GU1GqhvOPcBOU6e0aBenn292yxkgXpN
Content-Type: multipart/mixed; boundary="ZvZdUBN6pYzhnlreMlZRRvWzo4M0IYBF9";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <spice-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Message-ID: <11f0d3e5-8823-212f-0f4e-83a639a1d476@suse.de>
Subject: Re: [PATCH v2 02/11] drm/qxl: more fence wait rework
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-3-kraxel@redhat.com>
In-Reply-To: <20210217123213.2199186-3-kraxel@redhat.com>

--ZvZdUBN6pYzhnlreMlZRRvWzo4M0IYBF9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 17.02.21 um 13:32 schrieb Gerd Hoffmann:
> Move qxl_io_notify_oom() call into wait condition.
> That way the driver will call it again if one call
> wasn't enough.
>=20
> Also allows to remove the extra dma_fence_is_signaled()
> check and the goto.
>=20
> Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/qxl/qxl_release.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qx=
l_release.c
> index 6ed673d75f9f..579c6de10c8e 100644
> --- a/drivers/gpu/drm/qxl/qxl_release.c
> +++ b/drivers/gpu/drm/qxl/qxl_release.c
> @@ -62,16 +62,12 @@ static long qxl_fence_wait(struct dma_fence *fence,=
 bool intr,
>  =20
>   	qdev =3D container_of(fence->lock, struct qxl_device, release_lock);=

>  =20
> -	if (dma_fence_is_signaled(fence))
> -		goto signaled;
> -
> -	qxl_io_notify_oom(qdev);
>   	if (!wait_event_timeout(qdev->release_event,
> -				dma_fence_is_signaled(fence),
> +				(dma_fence_is_signaled(fence) ||
> +				 (qxl_io_notify_oom(qdev), 0)),
>   				timeout))
>   		return 0;
>  =20
> -signaled:
>   	cur =3D jiffies;
>   	if (time_after(cur, end))
>   		return 0;
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--ZvZdUBN6pYzhnlreMlZRRvWzo4M0IYBF9--

--85GU1GqhvOPcBOU6e0aBenn292yxkgXpN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAtbLYFAwAAAAAACgkQlh/E3EQov+Dn
hA//SQHbXUJsbtp0KvlZ1STFVXxrBy4T7K2vJFVCkFS5KxHjl/ewgKFx1YSSHayz0p+QFON+7eC/
F/pdyiv3ydbHfs60QJ1D68i1NeG9hs7XKId5m8wZFxGTXgBXmiBZ1r+VEzkH6QX5gwTC98+E2Mdy
NZUE0gVtsq8iMnDyzu9BuFnQVHduz8xNSaIwuZRORyDvptIw87+JIOiOEE3y8YtU6Q38itW3DF/k
RIgd8+ZQ86mrtZKsyi3KUX14c2sj2G5haGXwYGXWnWbNJQ/2HeHrLDiT450FgPYde7epPJnACx+e
/a2txg0G476R4Lh4CVLvf0UdSvaaUoWJW2+rVbMBGHM+NgREOvvo8uYA8iCKw36GZn5suagsJoTY
U1QolQA2aPjl7EFNeNFf/0M+gJ1WRd2367Stt3rcQcQ5ZOlR4KilWg7xQZ3ZFCGX2O5Tlh2yNYdX
VWWQWOr8Te5FktOWLVjNN5Vw8QnuRdnGnQGqDIJQSXYgQq2k5CFQW9yLHTj5X7+K+JBaBSudWUGQ
HzJnqS114c4F/Baiwe8NUi4yl0tf38VBefHIhUD0CEfJw+QwiqGG2z4Eeu0zz9zxlH+4eXGA+NIc
ZUJEbw22lzJ3FdInNML0CDZFa4cYsPVaTATziPeAVDl9nqWCos3b0Dq/8un4ga3yRG25YQZAUVyu
4B0=
=J1s4
-----END PGP SIGNATURE-----

--85GU1GqhvOPcBOU6e0aBenn292yxkgXpN--
