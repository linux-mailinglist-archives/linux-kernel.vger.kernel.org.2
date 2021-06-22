Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51F73AFD7D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFVHDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVHDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:03:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281FAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:00:48 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a21so3493740ljj.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=8uB2W+0iSYgQ4pTL1g6pWR0NWFjt+BXADvBX4pMDVn8=;
        b=iYxBfk5mMSUNGYr6pf9jdnwBzC/HaOFj21ZL5y/BRiXPqJXQFHNyNS8fEdSaTow1uO
         y6gpdb9+Ej0l5HDufcinLv7frUGfHGKL9av5Vj4uk9IqalAcHPND9Azu/GO+JY9J8sZ8
         1utMAskWZNbPFjCeDHM3EBc+OPp8DJ83j+4oO1VnWW15+l3SruK1023BD3QjWcSf0Vww
         90dG6628udKTgGpOnzSYlBDV8NkLdUWh7ER0Aw8Bf/S9n8V6Z/ytiFnl4yuK+jXLSiGh
         kRODKD9NRX5jOnoc57daDcHuODeTluP3kb7ldnyfxMMRrod5M3+hF0OL5M5EP0NI0Scf
         xRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=8uB2W+0iSYgQ4pTL1g6pWR0NWFjt+BXADvBX4pMDVn8=;
        b=PpHqziFqicNpJ1qKVF0EKf61wI//L0h0ZM8sBOAtWxubmZxncRqI+S9HdzwKZ66xZZ
         /dJg1AtpVZUDWaDAPbroKEGZJdssNupj6VYIqXo5IQO24hoacGm4anW6xtv8S1r1JO6h
         Xbb8kDQ+8Km0jCok0Ndlu8VD4JTfqa1Ys3fRUSz7x8oU5vsDR9wQwXxFFBgPEobQSCUw
         7Lbpk6HfRJCXyqC1Y6jLBNM7zjxBfFU77Ix+8fGjQrfb8TCdX7vR53zcGx920e/IBIaw
         l7vZxDpO4//vHqjIXJqGTlGBTu621Ylo3YUB9Z7H7CFlxEqBpINs1HjMLXPsb+RicVyX
         tz1w==
X-Gm-Message-State: AOAM532rlZ/8YkWvfkoVvLmsb28hhp7l1H6ruwOL0JqeoU8bTlaAewW6
        TfM1RrxYmVm5mBDf9t9lljI=
X-Google-Smtp-Source: ABdhPJwNdrhQOfRxKwlt69rv1LLhEtWfzlVijV4G41UDgnYQgpk5xh8QdH1ckw5ZhUBDdtB00YTYEA==
X-Received: by 2002:a05:651c:543:: with SMTP id q3mr1916342ljp.432.1624345246446;
        Tue, 22 Jun 2021 00:00:46 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id bn23sm2457632ljb.48.2021.06.22.00.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 00:00:46 -0700 (PDT)
Date:   Tue, 22 Jun 2021 10:00:42 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v4 09/17] drm/uAPI: Add "active color range" drm
 property as feedback for userspace
Message-ID: <20210622100042.4041624a@eldfell>
In-Reply-To: <20210618091116.14428-10-wse@tuxedocomputers.com>
References: <20210618091116.14428-1-wse@tuxedocomputers.com>
        <20210618091116.14428-10-wse@tuxedocomputers.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/RcB.Nk0Zn=HnVnpEEXCRGdK"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RcB.Nk0Zn=HnVnpEEXCRGdK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Jun 2021 11:11:08 +0200
Werner Sembach <wse@tuxedocomputers.com> wrote:

> Add a new general drm property "active color range" which can be used by
> graphic drivers to report the used color range back to userspace.
>=20
> There was no way to check which color range got actually used on a given
> monitor. To surely predict this, one must know the exact capabilities of
> the monitor and what the default behaviour of the used driver is. This
> property helps eliminating the guessing at this point.
>=20
> In the future, automatic color calibration for screens might also depend =
on
> this information being available.
>=20
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 59 +++++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h     | 27 +++++++++++++++
>  2 files changed, 86 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 684d7abdf0eb..818de58d972f 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -897,6 +897,12 @@ static const struct drm_prop_enum_list drm_active_co=
lor_format_enum_list[] =3D {
>  	{ DRM_COLOR_FORMAT_YCRCB420, "ycbcr420" },
>  };
> =20
> +static const struct drm_prop_enum_list drm_active_color_range_enum_list[=
] =3D {
> +	{ DRM_MODE_COLOR_RANGE_UNSET, "Unknown" },
> +	{ DRM_MODE_COLOR_RANGE_FULL, "Full" },
> +	{ DRM_MODE_COLOR_RANGE_LIMITED_16_235, "Limited 16:235" },

Doesn't "limited" mean different numbers on RGB vs. Y vs. CbCr? I have
a vague recollection that at least one of them was different from the
others.

Documenting DRM_MODE_COLOR_RANGE_UNSET as "unspecified/default" while
the string for it is "Unknown" seems inconsistent to me. I would
recommend to avoid the word "default" because "reset to defaults" might
become a thing one day, and that probably is not the same default as
here.

Is there actually a case for "unknown"? How can it be not known? Or
does it mean "not applicable"?

Otherwise looks good to me.


Thanks,
pq


> +};
> +
>  DRM_ENUM_NAME_FN(drm_get_dp_subconnector_name,
>  		 drm_dp_subconnector_enum_list)
> =20
> @@ -1221,6 +1227,14 @@ static const struct drm_prop_enum_list dp_colorspa=
ces[] =3D {
>   *	drm_connector_attach_active_color_format_property() to install this
>   *	property.
>   *
> + * active color range:
> + *	This read-only property tells userspace the color range actually used=
 by
> + *	the hardware display engine on "the cable" on a connector. The chosen
> + *	value depends on hardware capabilities of the monitor and the used co=
lor
> + *	format. Drivers shall use
> + *	drm_connector_attach_active_color_range_property() to install this
> + *	property.
> + *
>   * Connectors also have one standardized atomic property:
>   *
>   * CRTC_ID:
> @@ -2264,6 +2278,51 @@ void drm_connector_set_active_color_format_propert=
y(struct drm_connector *connec
>  }
>  EXPORT_SYMBOL(drm_connector_set_active_color_format_property);
> =20
> +/**
> + * drm_connector_attach_active_color_range_property - attach "active col=
or range" property
> + * @connector: connector to attach active color range property on.
> + *
> + * This is used to check the applied color range on a connector.
> + *
> + * Returns:
> + * Zero on success, negative errno on failure.
> + */
> +int drm_connector_attach_active_color_range_property(struct drm_connecto=
r *connector)
> +{
> +	struct drm_device *dev =3D connector->dev;
> +	struct drm_property *prop;
> +
> +	if (!connector->active_color_range_property) {
> +		prop =3D drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE, "activ=
e color range",
> +						drm_active_color_range_enum_list,
> +						ARRAY_SIZE(drm_active_color_range_enum_list));
> +		if (!prop)
> +			return -ENOMEM;
> +
> +		connector->active_color_range_property =3D prop;
> +		drm_object_attach_property(&connector->base, prop, DRM_MODE_COLOR_RANG=
E_UNSET);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_connector_attach_active_color_range_property);
> +
> +/**
> + * drm_connector_set_active_color_range_property - sets the active color=
 range property for a
> + * connector
> + * @connector: drm connector
> + * @active_color_range: color range for the connector currently active o=
n "the cable"
> + *
> + * Should be used by atomic drivers to update the active color range ove=
r a connector.
> + */
> +void drm_connector_set_active_color_range_property(struct drm_connector =
*connector,
> +						   enum drm_mode_color_range active_color_range)
> +{
> +	drm_object_property_set_value(&connector->base, connector->active_color=
_range_property,
> +				      active_color_range);
> +}
> +EXPORT_SYMBOL(drm_connector_set_active_color_range_property);
> +
>  /**
>   * drm_connector_attach_hdr_output_metadata_property - attach "HDR_OUTPU=
T_METADA" property
>   * @connector: connector to attach the property on.
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 8a5197f14e87..9fb7119b7a02 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -648,6 +648,24 @@ struct drm_tv_connector_state {
>  	unsigned int hue;
>  };
> =20
> +/**
> + * enum drm_mode_color_range - color_range info for &drm_connector
> + *
> + * This enum is used to represent full or limited color range on the dis=
play
> + * connector signal.
> + *
> + * @DRM_MODE_COLOR_RANGE_UNSET:		Color range is unspecified/default.
> + * @DRM_MODE_COLOR_RANGE_FULL:		Color range is full range, 0-255 for
> + *					8-Bit color depth.
> + * DRM_MODE_COLOR_RANGE_LIMITED_16_235:	Color range is limited range, 16=
-235 for
> + *					8-Bit color depth.
> + */
> +enum drm_mode_color_range {
> +	DRM_MODE_COLOR_RANGE_UNSET,
> +	DRM_MODE_COLOR_RANGE_FULL,
> +	DRM_MODE_COLOR_RANGE_LIMITED_16_235,
> +};
> +
>  /**
>   * struct drm_connector_state - mutable connector state
>   */
> @@ -1392,6 +1410,12 @@ struct drm_connector {
>  	 */
>  	struct drm_property *active_color_format_property;
> =20
> +	/**
> +	 * @active_color_range_property: Default connector property for the
> +	 * active color range to be driven out of the connector.
> +	 */
> +	struct drm_property *active_color_range_property;
> +
>  #define DRM_CONNECTOR_POLL_HPD (1 << 0)
>  #define DRM_CONNECTOR_POLL_CONNECT (1 << 1)
>  #define DRM_CONNECTOR_POLL_DISCONNECT (1 << 2)
> @@ -1719,6 +1743,9 @@ void drm_connector_set_active_bpc_property(struct d=
rm_connector *connector, int
>  int drm_connector_attach_active_color_format_property(struct drm_connect=
or *connector);
>  void drm_connector_set_active_color_format_property(struct drm_connector=
 *connector,
>  						    u32 active_color_format);
> +int drm_connector_attach_active_color_range_property(struct drm_connecto=
r *connector);
> +void drm_connector_set_active_color_range_property(struct drm_connector =
*connector,
> +						   enum drm_mode_color_range active_color_range);
> =20
>  /**
>   * struct drm_tile_group - Tile group metadata


--Sig_/RcB.Nk0Zn=HnVnpEEXCRGdK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmDRipoACgkQI1/ltBGq
qqdYLRAApBOAb0ECllm5vp+4XsKkiT0b+WEnY4miGKEBtffDvHsJ2XTEFhs8V6Fg
/SO2heTKOynAbX9QgySLM2PFGYOpnU9g04owCt+E1iVVSevQlLNVZXJFcPvFCrrS
oxbpZTpzpVHAWT/WakJYVQAk/fsXLl8YNujMwDqK3SfHJ9GVKNHgBTBMrrpQuPEu
d39Om9Blvms3heuK/9JL6P0sWwTm46kBU2CqN6d+QUcV7h57Ug6Mx1l2l9jypNv2
yxK3ADKjCF5r6gePGt3Ni14neh6DfJvtskFdCAz7StarFbzAZeytepXd9H+6TskG
NzaOV1Fqvt5gccz2QH0XvNVOi2WhFk2dRPbYHn/FebwdgwpJrGLiG2ybt4IsWGL/
JbzN6nGhNHqJdoXnlIADRPbMgS17XGLva6+qOPHRGjzDfRB3VSvHS/gTO/zpWSdy
i7WrpMJtoAPbgS5p94p3pQtV0EbKWuHxDmlt/wkM+Y4dLE9wRbDtOtp8UsqPgIrt
pWHFyBLv4Gp/ytc5bd7cCcFt5S2tFX/U3QHYIhGmbxYnKckbrzeBEXL+oBhnAjYm
BeCsGpUlOqtwJQTpjrUY6iyGKwgnxIdls6cz4PoQ+Q6pm/N9u3FCIqpcRxa1y0DU
jRtYcaxZtfjkcKazyZrbTlNFwMJ9RT3prW7x11OMd2TEJC+FkZE=
=fi5a
-----END PGP SIGNATURE-----

--Sig_/RcB.Nk0Zn=HnVnpEEXCRGdK--
