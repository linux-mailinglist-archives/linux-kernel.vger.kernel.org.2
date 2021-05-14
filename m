Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A209380975
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhENM0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232354AbhENM0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:26:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63F6261285;
        Fri, 14 May 2021 12:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620995123;
        bh=nGDwE35C18UoKa4fmYoRbQeMCmVI6QFhhfBDHADfbnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNwEXETObatwCh+yJfmmelZ3UmseQYJSyn6G5LQwjcpxlYHqNrJWQUAs8g6xugGdn
         ZzoKzs0I6eZ9y/dIGA/UzdN4ZsceFPWivZAQQA5C6R1228cFzMF2Mt/IyT7Zy49ctg
         Jc3QGuYWpVsOwKuJdAROazDtf4SwcjPE6YopLm6EASzCfiAudqjhnAWaTTeyLQWGlz
         +ixDFTm2PPzBofrTS/NtsdRAo52/gv1RsEAmnh6+bK+teAxIGXnGcwWWjZ2yTRXR1X
         IulX+AqrdY+87JjshE4YN6J9DhYGhKc29KlcmHK+l3VrRMpkyI6PzJSaNHt39WufWV
         NasR86s28kjlg==
Date:   Fri, 14 May 2021 13:24:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: soc-core: use DEVICE_ATTR_RO macro
Message-ID: <20210514122442.GA6516@sirena.org.uk>
References: <20210514081100.16196-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20210514081100.16196-1-yuehaibing@huawei.com>
X-Cookie: Necessity is a mother.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 14, 2021 at 04:11:00PM +0800, YueHaibing wrote:

> -static ssize_t pmdown_time_set(struct device *dev,
> -			       struct device_attribute *attr,
> -			       const char *buf, size_t count)
> +static ssize_t pmdown_time_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)

This unrelated formatting change should be in a separate patch.

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCebAkACgkQJNaLcl1U
h9C8Zwf/WCXNNLFDpGJITMlCXC5ESa2WDBxBO9T3AlyWzM2KLbeZb0bblG26X9/5
vwxONIeyznOd43vSciX167g1x1UlRiinVJ1EQomVHYpBjL8scHVldqYHULopuxaB
kJWV0SAecg0EkTSdCmZN7xN0foloT5dhKVuFFelQceJwL1iqjIQMk43rw7wpP89C
ztVG4huaxnRoT9LTUuU+q1j/mzcVhTtW54LnP5safV9+YfnNbFweHzmTJ9L0wH4I
dutENtL9zwaUFLwZzKXJmdYc3irr1+JF29o0tIGYKdKhRM0fGYLHJ21c0Un5+sSu
YMxkM4pgDHOlOQoEhhPCXk6NtBsR4A==
=dk20
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
