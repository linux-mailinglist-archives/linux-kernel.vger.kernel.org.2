Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0D2431229
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhJRIc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhJRIcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:32:25 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65331C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:30:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l5so7528571lja.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=z1awnEc2beXWWlZZTUBgu2/GsLPV4vC4cPtFeCgNmh4=;
        b=QbKdrr4KKCWhf3Cdl9eqbH6uWRl5tMMtwzwaEEP1oJQ1WLRZucID1Qxjnx+jL6SI4n
         f2LhTdjpxiKPuI5beEewCzN79DkG/Unw5lYaJrIJ2OMCg6v/inEmJs4ad1RsXMwkS693
         ZUpA/Y4E9eoMhZmjzIWo8ej8gi+tEohLN5CgodBclmEOc93TDTwxpbsJnGyqStbjIZbb
         /w7jfyaa2Mupnxw69gGSuExaxGcq9fuDkOmwnU+l9UE/IPTB+Ar5ZkAPbZGNTvSoMSY/
         M5Cutv0vpEFmROIiq+4i5DLBt0tRwLI8b4zn4PAisrKh5PCOLpe/U82OrhugfFt0/D4U
         oVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=z1awnEc2beXWWlZZTUBgu2/GsLPV4vC4cPtFeCgNmh4=;
        b=49Sh6+Y9NfbyIe3lmNlamVt/UVAdqO0jqjrReEz0epL34ut4X12XWIR3640JCTZLc4
         KMOAEhHnfznqMsMRJheXNDrhv/l+bqBVjYnkoetzq381/SJ8A9y+7CAW4OE84aVImp/3
         zKmHrsa4FMNpKlNY7DRv3JK8bNiW/KO3cnT0vvThE75E5LVc4aUfOXpVAy3Dgt7qjjpZ
         Mt4ThpllNXO1sCSi/yUt+QmKDYn0I9I7BuUvLcxDV483C/qD+vXBzQUw8tVbE/9+9TPI
         keJNterkdyS6T2iQtHvJBkwU0XlV1xPwwxfIFUi1GMbu/MaIAdwlU9kX+knQejbLKhgC
         qtsA==
X-Gm-Message-State: AOAM530aLMF0KIPytMkh0gOKm0skpY40VFNvN/+IRZ/wJyiOJM2BYu5e
        zJUk15A/5XaB/QAFkOqHWrE=
X-Google-Smtp-Source: ABdhPJwNH4qOH0kDtzJE/IZ+54t8vj5AfMzGE7z9Nifmkrq0UCeMUHcGDTL0oYJo7euiy32FgTRwPw==
X-Received: by 2002:a2e:155a:: with SMTP id 26mr32290272ljv.156.1634545812637;
        Mon, 18 Oct 2021 01:30:12 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id s13sm1339125lfs.65.2021.10.18.01.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:30:12 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:30:09 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Cc:     rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        contact@emersion.fr, leandro.ribeiro@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH 6/6] drm: vkms: Refactor the plane composer to accept
 new formats
Message-ID: <20211018113009.5519457c@eldfell>
In-Reply-To: <20211005201637.58563-7-igormtorrente@gmail.com>
References: <20211005201637.58563-1-igormtorrente@gmail.com>
        <20211005201637.58563-7-igormtorrente@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+vqPe=9wM.aybGqtvR0dpQr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+vqPe=9wM.aybGqtvR0dpQr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  5 Oct 2021 17:16:37 -0300
Igor Matheus Andrade Torrente <igormtorrente@gmail.com> wrote:

> Currently the blend function only accepts XRGB_8888 and ARGB_8888
> as a color input.
>=20
> This patch refactors all the functions related to the plane composition
> to overcome this limitation.
>=20
> Now the blend function receives a format handler to each plane and a
> blend function pointer. It will take two ARGB_1616161616 pixels, one
> for each handler, and will use the blend function to calculate and
> store the final color in the output buffer.
>=20
> These format handlers will receive the `vkms_composer` and a pair of
> coordinates. And they should return the respective pixel in the
> ARGB_16161616 format.
>=20
> The blend function will receive two ARGB_16161616 pixels, x, y, and
> the vkms_composer of the output buffer. The method should perform the
> blend operation and store output to the format aforementioned
> ARGB_16161616.

Hi,

here are some drive-by comments which you are free to take or leave.

To find more efficient ways to do this, you might want research Pixman
library. It's MIT licensed.

IIRC, the elementary operations there operate on pixel lines (pointer +
length), not individual pixels (image, x, y). Input conversion function
reads and converts a whole line a time. Blending function blends two
lines and writes the output into back one of the lines. Output
conversion function takes a line and converts it into destination
buffer. That way the elementary operations do not need to take stride
into account, and blending does not need to deal with varying memory
alignment FWIW. The inner loops involve much less function calls and
state, probably.

Pixman may not do exactly this, but it does something very similar.
Pixman also has multiple different levels of optimisations, which may
not be necessary for VKMS.

It's a trade-off between speed and temporary memory consumed. You need
temporary buffers for two lines, but not more (not a whole image in
full intermediate precision). Further optimisation could determine
whether to process whole image rows as lines, or split a row into
multiple lines to stay within CPU cache size.

Since it seems you are blending multiple planes into a single
destination which is assumed to be opaque, you might also be able to do
the multiple blends without convert-writing and read-converting to/from
the destination between every plane. I think that might be possible to
architect on top of the per-line operations still.

> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 275 ++++++++++++++-------------
>  drivers/gpu/drm/vkms/vkms_formats.h  | 125 ++++++++++++
>  2 files changed, 271 insertions(+), 129 deletions(-)
>  create mode 100644 drivers/gpu/drm/vkms/vkms_formats.h

...

> +
> +u64 ARGB8888_to_ARGB16161616(struct vkms_composer *composer, int x, int =
y)
> +{
> +	u8 *pixel_addr =3D packed_pixels_addr(composer, x, y);
> +
> +	/*
> +	 * Organizes the channels in their respective positions and converts
> +	 * the 8 bits channel to 16.
> +	 * The 257 is the "conversion ratio". This number is obtained by the
> +	 * (2^16 - 1) / (2^8 - 1) division. Which, in this case, tries to get
> +	 * the best color value in a color space with more possibilities.

Pixel format, not color space.

> +	 * And a similar idea applies to others RGB color conversions.
> +	 */
> +	return ((u64)pixel_addr[3] * 257) << 48 |
> +	       ((u64)pixel_addr[2] * 257) << 32 |
> +	       ((u64)pixel_addr[1] * 257) << 16 |
> +	       ((u64)pixel_addr[0] * 257);

I wonder if the compiler is smart enough to choose between "mul 257"
and "(v << 8) | v" operations... but that's probably totally drowning
under the overhead of per (x,y) looping.

> +}
> +
> +u64 XRGB8888_to_ARGB16161616(struct vkms_composer *composer, int x, int =
y)
> +{
> +	u8 *pixel_addr =3D packed_pixels_addr(composer, x, y);
> +
> +	/*
> +	 * The same as the ARGB8888 but with the alpha channel as the
> +	 * maximum value as possible.
> +	 */
> +	return 0xffffllu << 48 |
> +	       ((u64)pixel_addr[2] * 257) << 32 |
> +	       ((u64)pixel_addr[1] * 257) << 16 |
> +	       ((u64)pixel_addr[0] * 257);
> +}
> +
> +u64 get_ARGB16161616(struct vkms_composer *composer, int x, int y)
> +{
> +	__le64 *pixel_addr =3D packed_pixels_addr(composer, x, y);
> +
> +	/*
> +	 * Because the format byte order is in little-endian and this code
> +	 * needs to run on big-endian machines too, we need modify
> +	 * the byte order from little-endian to the CPU native byte order.
> +	 */
> +	return le64_to_cpu(*pixel_addr);
> +}
> +
> +/*
> + * The following functions are used as blend operations. But unlike the
> + * `alpha_blend`, these functions take an ARGB16161616 pixel from the
> + * source, convert it to a specific format, and store it in the destinat=
ion.
> + *
> + * They are used in the `compose_active_planes` and `write_wb_buffer` to
> + * copy and convert one pixel from/to the output buffer to/from
> + * another buffer (e.g. writeback buffer, primary plane buffer).
> + */
> +
> +void convert_to_ARGB8888(u64 argb_src1, u64 argb_src2, int x, int y,
> +			 struct vkms_composer *dst_composer)
> +{
> +	u8 *pixel_addr =3D packed_pixels_addr(dst_composer, x, y);
> +
> +	/*
> +	 * This sequence below is important because the format's byte order is
> +	 * in little-endian. In the case of the ARGB8888 the memory is
> +	 * organized this way:
> +	 *
> +	 * | Addr     | =3D blue channel
> +	 * | Addr + 1 | =3D green channel
> +	 * | Addr + 2 | =3D Red channel
> +	 * | Addr + 3 | =3D Alpha channel
> +	 */
> +	pixel_addr[0] =3D DIV_ROUND_UP(argb_src1 & 0xffffllu, 257);
> +	pixel_addr[1] =3D DIV_ROUND_UP((argb_src1 & (0xffffllu << 16)) >> 16, 2=
57);
> +	pixel_addr[2] =3D DIV_ROUND_UP((argb_src1 & (0xffffllu << 32)) >> 32, 2=
57);
> +	pixel_addr[3] =3D DIV_ROUND_UP((argb_src1 & (0xffffllu << 48)) >> 48, 2=
57);

This could be potentially expensive if the compiler ends up using an
actual div instruction.

Btw. this would be shorter to write as

	(argb_src1 >> 16) & 0xffff

etc.

Thanks,
pq

> +}
> +
> +void convert_to_XRGB8888(u64 argb_src1, u64 argb_src2, int x, int y,
> +			 struct vkms_composer *dst_composer)
> +{
> +	u8 *pixel_addr =3D packed_pixels_addr(dst_composer, x, y);
> +
> +	pixel_addr[0] =3D DIV_ROUND_UP(argb_src1 & 0xffffllu, 257);
> +	pixel_addr[1] =3D DIV_ROUND_UP((argb_src1 & (0xffffllu << 16)) >> 16, 2=
57);
> +	pixel_addr[2] =3D DIV_ROUND_UP((argb_src1 & (0xffffllu << 32)) >> 32, 2=
57);
> +	pixel_addr[3] =3D 0xff;
> +}
> +
> +void convert_to_ARGB16161616(u64 argb_src1, u64 argb_src2, int x, int y,
> +			     struct vkms_composer *dst_composer)
> +{
> +	__le64 *pixel_addr =3D packed_pixels_addr(dst_composer, x, y);
> +
> +	*pixel_addr =3D cpu_to_le64(argb_src1);
> +}
> +
> +#endif /* _VKMS_FORMATS_H_ */


--Sig_/+vqPe=9wM.aybGqtvR0dpQr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmFtMJEACgkQI1/ltBGq
qqd/RA/9Gap0CrESs0WhwdA8sjtBjoC+jXUbe4H8OkL+AbEah/1SfkLReF8yZCae
p6XL6A3Xj7VvIEvewlKkRb3wKJ97bR5WSEasCIkxg/tB0DnOQN5fYH2tdatw8pHE
A9yCDz7i0kFCWY5ZktXi4diDgwmFkQRK7Brg5Pn2T0ZsrAJ822W0d+XRA9KUC5er
s0lBOJaZc1nc9s4aJiTWEXkX4rWiof6TLshNriGjVtq+z2CZsF5L0nmRbl1226JG
nOatXM9t6+Nl4jDyflgylHsNUbA2OoaZVC4zNeWoOP8WbyndhoRpxQvEzZWWJnhR
kPxM/6iNeRiFYlIWDsqPypDzdenzoSAl5l5Tz3csKpHeXvmYSUvHKAdzKFN5LvWk
OubQVeJTv7UFDaGhc51qBNguW7ut9TRn/MwcdHb5wDW1IG4+DyeZTi1B4GylQDwE
cRygdvVZxrDEgCIoddBLlp0Y2OlmD/Qsc5AmFlDOpXJUi+DBnaq7GL5ZO3D8nZLX
tmWPIUIKHEBT+NxPs+YtxLxP1/ABxdkiDl9paQSm27Z6jddwIho14xeV3CZoYYQZ
K5A6W4Onwel9XKLw5ckLXyrRtdsNcdm+NLcO5pRgKQNU9iUo3nYp9uKwaArR0MoL
vOD8ulX/4NPWYtl9VbQetyAL4UIaSNjg4teMjrbVVLgb7qa2tm4=
=IctX
-----END PGP SIGNATURE-----

--Sig_/+vqPe=9wM.aybGqtvR0dpQr--
