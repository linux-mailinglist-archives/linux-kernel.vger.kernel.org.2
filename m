Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EAE3CF6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 11:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhGTI3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:29:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46706 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbhGTI0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:26:55 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F96F1FD3E;
        Tue, 20 Jul 2021 09:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626772053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QfevtJ7CO69XvR/FgxUv0tcNBb6dOkmnHZF1Y+3ecPE=;
        b=qPP+VPihQCLt5SbGo30Cs//xoYyzsjBqGVUjA1v7oynKA9Cpsold5dkRVWMNHDcSRlokhM
        LCow4zT5u2rnHLYUO2ZSdDffdy0kluHmt+QDRZjUPkycsfob/l4ri3ItuHoA1M49cw+IO6
        6tZ/1WMRGEGu9BMKvVp4Kr+7n7Rcpac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626772053;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QfevtJ7CO69XvR/FgxUv0tcNBb6dOkmnHZF1Y+3ecPE=;
        b=Cqa4nl1n11cdmVl8DLDjDwA/2gnzCV/ihRUyR8BgzbHvrr18EHskqB+DQPNMIsOG1Ft4ET
        YFTG7BbQu9ai/GAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0403213A2E;
        Tue, 20 Jul 2021 09:07:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id pTTIOVSS9mD+FgAAGKfGzw
        (envelope-from <tzimmermann@suse.de>); Tue, 20 Jul 2021 09:07:32 +0000
Subject: Re: [PATCH -next v2 resend] drm/bochs: Fix missing
 pci_disable_device() on error in bochs_pci_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     kraxel@redhat.com, airlied@linux.ie, daniel@ffwll.ch
References: <20210715132845.2415619-1-yangyingliang@huawei.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <5c3f06d5-509a-0e59-7021-d25180f82de9@suse.de>
Date:   Tue, 20 Jul 2021 11:07:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715132845.2415619-1-yangyingliang@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1tWaCOjUssnJCaas5KXmJJXzgakIpD6xl"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1tWaCOjUssnJCaas5KXmJJXzgakIpD6xl
Content-Type: multipart/mixed; boundary="3UkehBvmd5mFqfwTL1h90To2blVmYbJVN";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Cc: kraxel@redhat.com, airlied@linux.ie, daniel@ffwll.ch
Message-ID: <5c3f06d5-509a-0e59-7021-d25180f82de9@suse.de>
Subject: Re: [PATCH -next v2 resend] drm/bochs: Fix missing
 pci_disable_device() on error in bochs_pci_probe()
References: <20210715132845.2415619-1-yangyingliang@huawei.com>
In-Reply-To: <20210715132845.2415619-1-yangyingliang@huawei.com>

--3UkehBvmd5mFqfwTL1h90To2blVmYbJVN
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 15.07.21 um 15:28 schrieb Yang Yingliang:
> Replace pci_enable_device() with pcim_enable_device(),
> pci_disable_device() will be called in release automatically.
>=20
> v2:
>    use pcim_enable_device()
>=20
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks, I'll merge it into drm-misc-next as v3. I also had to update the =

path to the bochs driver meanwhile.

Best regards
Thomas

> ---
>   drivers/gpu/drm/bochs/bochs_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/=
bochs_drv.c
> index c828cadbabff..8065c9537237 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -118,7 +118,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
>   	if (IS_ERR(dev))
>   		return PTR_ERR(dev);
>  =20
> -	ret =3D pci_enable_device(pdev);
> +	ret =3D pcim_enable_device(pdev);
>   	if (ret)
>   		goto err_free_dev;
>  =20
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--3UkehBvmd5mFqfwTL1h90To2blVmYbJVN--

--1tWaCOjUssnJCaas5KXmJJXzgakIpD6xl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmD2klQFAwAAAAAACgkQlh/E3EQov+Dn
LRAAytKE28XZKTScOgeBjGLyb6I50t+nAoIMtve7Gc22yETMye3+lkQ8ulGWm8OC931jHub2Qz8v
3VsC3q2YuJSdXLPpPRGe59bgtnzSqgvvmEYzGXJ/dB6yhS4DDbks885mZBg5HusB5hvpwyE29lki
67RuwzuQQ1tXmxSSuPmI5kT2BtawUxvP1bbU/44xgmhfUP4YMm53eLV/ELRvyvDjFfSJOxF857hQ
ijfX6xWc3i7zLES4EPIc0sqNj0PPrP2wnuzUf6X65phtbS276Ym7tG9vTuI18YTnk7On9boiFtDr
ZWeTSEmBq4nTi+XRsY3JPRQaGOmzMVx8vjex6iht5Uf835wX1j3F7FOEac9vP+/XFSVv4hAJ2/cy
n2kuvhhLbko1TDgquFTqBI2cYZofEe6kkHqi0SSrIKn7/K7bJehJIBAZcHyqpBB5S6P1BkiusACM
cqgM6NZ5t1OwFm1YFM9Oop4Hj2Kyat6Ucuv6O1sOLCfvWFS16g0jaJBUPfEar58Ly6FFefRvPD5v
+3Ma64SwyLbRkVLxJjPYL2VuqDuVlTyGca8G42iHSi9P8gUTEJ797lWVLtKUi0HFxIPk75G6ctaU
70sbjXHpsnIPS/+c6ekVJKDyDog2VBXAH7ip+tgDDxxYdlU1ssUGG5GqyETK65Y+bGqGTNcl0sJa
rlI=
=Sdka
-----END PGP SIGNATURE-----

--1tWaCOjUssnJCaas5KXmJJXzgakIpD6xl--
