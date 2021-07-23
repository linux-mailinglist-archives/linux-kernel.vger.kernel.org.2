Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D12F3D403A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 20:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhGWRkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 13:40:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42210 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGWRkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 13:40:16 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F3E92220AF;
        Fri, 23 Jul 2021 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627064449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Gul0DAeJqM1NXrZMDZHKg4hUtgqjD/tWebVi3Dzyyg=;
        b=Yo64mDD4WMYHTtCWqnfYkYYrjlCmoJi5HNUPfX5+M4hRUbk9CViq7Cgzwu2MocQLpQBbjH
        tOUEDFAqJaxitbmINCPzBKxFAtYxqty535OXogtbG7vpqNpxgC/zbvaaaD/dOVON69UumC
        b5qCZ1BUAT+m5Mi54lFDPbnz0XvDyCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627064449;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Gul0DAeJqM1NXrZMDZHKg4hUtgqjD/tWebVi3Dzyyg=;
        b=GCw/hI4ZvMwBaBDJ4XcHOUCf7CdJy/ybhQUJr7Jqed1C5GSDuWAEudWgo8VYbrvei3ja15
        NPTfTpZl0hzAmxAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AFD3213697;
        Fri, 23 Jul 2021 18:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 6X5cKYAI+2AoXwAAGKfGzw
        (envelope-from <tzimmermann@suse.de>); Fri, 23 Jul 2021 18:20:48 +0000
Subject: Re: [PATCH] drm/hisilicon/hibmc: remove an unused variable
To:     Arnd Bergmann <arnd@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210723091643.1768874-1-arnd@kernel.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <48de3803-e65b-0c4b-1b7a-5bead45ab8ca@suse.de>
Date:   Fri, 23 Jul 2021 20:20:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723091643.1768874-1-arnd@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kJt0P1AE5RsBtsDFPEZmN90oqN9YwBEca"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kJt0P1AE5RsBtsDFPEZmN90oqN9YwBEca
Content-Type: multipart/mixed; boundary="imXddyz52Kw4fTdOcDP6ghLpgOAEnycpP";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Arnd Bergmann <arnd@kernel.org>, Xinliang Liu <xinliang.liu@linaro.org>,
 Tian Tao <tiantao6@hisilicon.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard <maxime@cerno.tech>
Cc: Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Chen Feng <puck.chen@hisilicon.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <48de3803-e65b-0c4b-1b7a-5bead45ab8ca@suse.de>
Subject: Re: [PATCH] drm/hisilicon/hibmc: remove an unused variable
References: <20210723091643.1768874-1-arnd@kernel.org>
In-Reply-To: <20210723091643.1768874-1-arnd@kernel.org>

--imXddyz52Kw4fTdOcDP6ghLpgOAEnycpP
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 23.07.21 um 11:16 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> A recent patch left an unused variable in place that needs to be
> removed:
>=20
> drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c: In function 'hibmc_unl=
oad':
> drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c:252:35: error: unused v=
ariable 'priv' [-Werror=3Dunused-variable]
>    252 |         struct hibmc_drm_private *priv =3D to_hibmc_drm_privat=
e(dev);
>=20
> Fixes: 39a364a19e03 ("drm/hisilicon/hibmc: Convert to Linux IRQ interfa=
ces")

Thanks for the patch. The issue has meanwhile been fixed in drm-misc-next=
=2E

Best regards
Thomas

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--imXddyz52Kw4fTdOcDP6ghLpgOAEnycpP--

--kJt0P1AE5RsBtsDFPEZmN90oqN9YwBEca
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmD7CIAFAwAAAAAACgkQlh/E3EQov+Cf
iA/8CGOqE+CSt02GiMOx9VMghz8C28yz0v20olq9dm6AF4n/xf4fKBn0VY8wxw/lvT01A1+b8GO/
b1D6wBMwg32KeT3GzeEcarTNPpM+lHU/gFVt/b8be+ckLGKJO4xrUYl6X9l+ETEB9Wn1v8URktEZ
7MpLEpyFUdMydtlhNFfss8iE2iN3Cy7aWLg3JzK/tTH5OSnY4mukMhqRQ2LELKNZLvvZbm832+Bo
4/hxW4o17tasmy6M8jA1otC2gjI1PMDiQIKjsZquUrIMei75ELeBPrUZI07wyitWe8h6TPx+ri1h
00mJEW9Ws3Sk0HPv2YZPMFwYKXLSVd1T1uc6CeB4lT0I2BzHggA5oRSdDOtcL6aQNPWpBmckxKgZ
bObFVeAwQt7THQ6dTtlwhgDUfgMjoAcPYwDD2UpIWc4pmNR7fg89stE2gP6dj2A0P1Chdl8A+Dpu
hRlAHKOSkSw3MSK9ntjuxDF8WwxrrEzG+IVbBqw/qTeHTV+e4niUAI57lLMBLnrrE2HPgO6RMLlY
JMYDAOLEyooYJt5XnVHj7DMp99q0ntXsQWPVTlJ3TyDdyQR4nKf6MiscacMOAicra8U26p/wGKC8
jqHWtN1lr00dM2C+LKvmhAuo5hqYRcqH7j+rC7pUDSCA6nC7M7++MIJe3ywrgiBiwGk+pNoNnq+w
nF4=
=kAJL
-----END PGP SIGNATURE-----

--kJt0P1AE5RsBtsDFPEZmN90oqN9YwBEca--
