Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E60458BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbhKVJ4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhKVJz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:55:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:52:52 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f18so78116454lfv.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=0w/LnY0STHnB2Im29hCTGRwW1KiHs5I0NxK3AR1/Fd0=;
        b=CjPaSI41KniqzPwtCQOwgDpiROyauuRHZVUWFmhm2GfTPEAfNaYvg6El2NRRi0Am6p
         Hh+99QzN5Zc4s3fQd4ocewltC6QUzO7SdGgslmsiC2kv75UK7monW3CbXP0i1fEV8oEt
         vlaMsc040ZLB7GwnYrY85rSuZGADzJiLWvhgm+M3Uz3EZcTp11yjWwwqgky/h7Wc+Err
         NUU8wBk9jWL9Qv0pVCf9JEqAxCU3jFMONOChClNSs4kIEWmgRUj4b+v3OZ9s0GlYhp1X
         +pkWMG0muyehUFJR9ED2mXAoYzoRvi0O6gCRhgpkSSIODxgrjeJjxtwRLkSIpP/ibEij
         ClOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=0w/LnY0STHnB2Im29hCTGRwW1KiHs5I0NxK3AR1/Fd0=;
        b=ogcGcVCxH4s8I0F4k3y78NAn51qveZHAYvNOs6zFAwo+VSC0ZWY2olrdYn/3JE2MFL
         YtojoruDFaB7OYT5Vu/E3jEVt4/e6wSTDjzPp06RvS1U9LsdA1obm0DT49ZQIyvOSjTN
         JIhCr5TbVE3M1dk5UPklwHis2TdzV+Zo9VGrL7rmyxgI8oBZX5xwH5zys9k/szTT7+ZH
         4WWigPbwUqqHyJf6O7vRVW1lutN5A1fQJ34iFnbR9ul8wFtSZdEDvveVthc3jpIANGXt
         t+6jOcQZAXpbDuxONd55NhwzccBBycYT6yFho5sighk6F+98xUtTlMXa5mmGIxcLRYc6
         Rkpg==
X-Gm-Message-State: AOAM532wWEnO9ldmF8BnhHgGaKgDczU6szNlLGRscTLgtEFfIEM84AJT
        42ZH7MA60iZoIEPUHsXrzao=
X-Google-Smtp-Source: ABdhPJwSCQvMFr9/p8AQRvZcd+vn/y5d/vLXMMkKmeN+kN+BMxyK/R9P874Vu/Mup00DPbOtixO+ug==
X-Received: by 2002:ac2:5cd7:: with SMTP id f23mr55583076lfq.153.1637574770965;
        Mon, 22 Nov 2021 01:52:50 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id f10sm907482lfu.122.2021.11.22.01.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 01:52:50 -0800 (PST)
Date:   Mon, 22 Nov 2021 11:52:47 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/format-helper: Add
 drm_fb_xrgb8888_to_xrgb2101010_dstclip()
Message-ID: <20211122115247.257f30fa@eldfell>
In-Reply-To: <20211117145829.204360-3-marcan@marcan.st>
References: <20211117145829.204360-1-marcan@marcan.st>
        <20211117145829.204360-3-marcan@marcan.st>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eeC4l4N88GUSbcvOmvSRbh=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eeC4l4N88GUSbcvOmvSRbh=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Nov 2021 23:58:28 +0900
Hector Martin <marcan@marcan.st> wrote:

> Add XRGB8888 emulation support for devices that can only do XRGB2101010.
>=20
> This is chiefly useful for simpledrm on Apple devices where the
> bootloader-provided framebuffer is 10-bit, which already works fine with
> simplefb. This is required to make simpledrm support this too.
>=20
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/gpu/drm/drm_format_helper.c | 64 +++++++++++++++++++++++++++++
>  include/drm/drm_format_helper.h     |  4 ++
>  2 files changed, 68 insertions(+)

Hi Hector,

I'm curious, since the bootloader seems to always set up a 10-bit mode,
is there a reason for it that you can guess? Is the monitor in WCG or
even HDR mode?


Thanks,
pq

--Sig_/eeC4l4N88GUSbcvOmvSRbh=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmGbaG8ACgkQI1/ltBGq
qqdRYQ//bM6tFPM2B6NM5OF0Pg8dajkciv+81+kA7QV1w7FrexCQS6acTPg9vtyX
J8EySl2TIx9XnBy5BQhp92iUWFuv2lex4/knF+7ZMKtrwAz4Oq33OgD8XKJ75gaq
AOYJCByth0q6Em/KG6DNCSE8yPyKGGQx5OAqTaRVqXTegsDHq9HtNJL300guTyPq
9YLkjrpp2j8WiysutvcpnfY4WvCqNdI5/TY9FynD3e3QkEEBnH9tGPv7HXIHQToV
J2kesFkXNF8nRYkGdaR05lEgfXsuWwLRZvH7IcAyKJr5dIDVY4dnUu/XhTBWr27X
mzyHxNi0/ZrSS5o+atrMVKqSPWdhvek0ce5ASx3FSN0nKNPIp3F+QKOKvocqOUxx
s3UOvwcgvHtB51h0RZBZwm/cAoSRvRraxgCHFkYL4Zb349YiYrcFpLxAEhK6Ujpt
6R70BAyVbtpDsWwIbBNk2T+uhNhafO6TegcWNp9cySSaowtqQn+BLSGpp6t92PAB
xqLrfOXRKjVGg9YmvINUP9bgy/HlhR4Mg6lT9AYe83vnoL+I4GvS98uWdibqigWt
cTXlQcVYKesq55GJ43YLhbbyjcj5P8ODXWmZoTQuYizh1a90VFj+eKQ2gzrnK8Kd
rVAkvy63wmFPgDLZPfSjP9WKAMUN7Z91x+kNa+SVw7toojTuKVQ=
=8F6L
-----END PGP SIGNATURE-----

--Sig_/eeC4l4N88GUSbcvOmvSRbh=--
