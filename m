Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7712630C2F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhBBPFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbhBBPDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:03:44 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E17C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 07:03:04 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id s23so13794330pgh.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 07:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gHcmmOyo9J/1y5Rdo4Ts6qg7/7o0qlrb6EBUxbtMg4s=;
        b=SIa3p/CcI+VKbTyKJqBwFjxcWNpyON9h18FvN+zyXY0sqSMue4TgRBfUYnAoAwqvg7
         n48y7MMsKup7sWY/GgbCBDS6N2dYPFlOe8lbf5QcDjiuChhxQg9lH+Gx5Sg0du+2OSCI
         xF+uWk/Lc1C7AMxJxsT9mnRk686+g7L8+3BW3i0zPHw5qEZ1MYmnFsLzIm0vHSTSqN2C
         hTkl0eBsxcBmFWYuBXI3HSqVPGDyldF2J9D75amttV3eWqlqNt9xPW1b/V9XkGSrqcR1
         CM5s6Ydlw9yXQSEgZbAgHbogsNf31UM55CCOQJivxDdnXGiq86fWIsMTawhzNWwwIDnF
         HXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gHcmmOyo9J/1y5Rdo4Ts6qg7/7o0qlrb6EBUxbtMg4s=;
        b=YMdV36zDzXh6uluaGx587w2Kva2r+RtLDWthy4gZry8ygWjfAe7Qm7CJTwH90CotJ9
         CBPbZ4StA8J2FxK+dLJXFQLda8Y4sBHW1+8mma3FbIPWrqKTPQO8xQVZ++A9Yene4Zxi
         4A7InQ0fhKkjMFsBwMvYZ7FDhQTtSvIPU4wbWYlxLaYgWgghWGn4zezTQyBDrhlhnDX6
         NKdgMot2Dj8waUbCG7Gwd9U7/v9F7RgkE9kEV/kgvyJ2w23gEPhyzk5qXeZvT/sXrcEN
         PgtMqmWr784s59c6d/TLcWtre6StKMqbPZmOmbHvwJR8fkMwi4wWRyu002E4xQRVWRyp
         GE4Q==
X-Gm-Message-State: AOAM531wtQQjIbyOz1pf2TClO8oUDuFwt/7H/vvlf0p5Wnbnn6hWHoSV
        NcxRAU98S8QwJKVh24cyBofrhA==
X-Google-Smtp-Source: ABdhPJwb7zYd/I7zvBZDR5xhMXDkmNss8xNch40Jjsbc7ss9mKVfWOQQ6g3zMd/eNZJEijsUFDCMUA==
X-Received: by 2002:aa7:946c:0:b029:1ce:3f04:3f67 with SMTP id t12-20020aa7946c0000b02901ce3f043f67mr7740185pfq.6.1612278183601;
        Tue, 02 Feb 2021 07:03:03 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id a141sm22569495pfa.189.2021.02.02.07.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 07:03:02 -0800 (PST)
Date:   Tue, 2 Feb 2021 07:02:52 -0800
From:   Benson Leung <bleung@google.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        bleung@chromium.org, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Return void in typec_partner_set_pd_revision
Message-ID: <YBlpnMKzGBcP5Ybi@google.com>
References: <20210202095512.761214-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7r6jZMwHZonCx4Zv"
Content-Disposition: inline
In-Reply-To: <20210202095512.761214-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7r6jZMwHZonCx4Zv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Tue, Feb 02, 2021 at 05:55:12PM +0800, Kyle Tso wrote:
> typec_partner_set_pd_revision doesn't need any return value.
>=20
> Fixes: 29b01295a829 ("usb: typec: Add typec_partner_set_pd_revision")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Review tags for <bleung@chromium.org>
Thanks for the quick fix!

Thanks,
Benson

> ---
>  drivers/usb/typec/class.c | 10 ++--------
>  include/linux/usb/typec.h |  2 +-
>  2 files changed, 3 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index b6ceab3dc16b..a7d1bc83c2d4 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -755,15 +755,11 @@ EXPORT_SYMBOL_GPL(typec_partner_set_identity);
>   *
>   * This routine is used to report that the PD revision of the port partn=
er has
>   * become available.
> - *
> - * Returns 0 on success or negative error number on failure.
>   */
> -int typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_=
revision)
> +void typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd=
_revision)
>  {
> -	int ret;
> -
>  	if (partner->pd_revision =3D=3D pd_revision)
> -		return 0;
> +		return;
> =20
>  	partner->pd_revision =3D pd_revision;
>  	sysfs_notify(&partner->dev.kobj, NULL, "usb_power_delivery_revision");
> @@ -773,8 +769,6 @@ int typec_partner_set_pd_revision(struct typec_partne=
r *partner, u16 pd_revision
>  			     "supports_usb_power_delivery");
>  	}
>  	kobject_uevent(&partner->dev.kobj, KOBJ_CHANGE);
> -
> -	return 0;
>  }
>  EXPORT_SYMBOL_GPL(typec_partner_set_pd_revision);
> =20
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 4946eca742d5..a94df82ab62f 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -126,7 +126,7 @@ struct typec_altmode_desc {
>  	enum typec_port_data	roles;
>  };
> =20
> -int typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_=
revision);
> +void typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd=
_revision);
>  int typec_partner_set_num_altmodes(struct typec_partner *partner, int nu=
m_altmodes);
>  struct typec_altmode
>  *typec_partner_register_altmode(struct typec_partner *partner,
> --=20
> 2.30.0.365.g02bc693789-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--7r6jZMwHZonCx4Zv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYBlpnAAKCRBzbaomhzOw
wlUhAQD3g3YhqSUtdbQu/l5TFNuGxAPFbI0sVVIGDuMJSS7kFAD/U6d/2sW52+KO
XmMbGeusvrFrfv9rdDguO7mLET+72w0=
=ZyUg
-----END PGP SIGNATURE-----

--7r6jZMwHZonCx4Zv--
