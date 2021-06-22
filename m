Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1855B3AFDE7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFVHcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhFVHcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:32:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0752CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:30:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f30so34425907lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=Sv8DdLTv1kY+QXwSsZTiRnv68zLQuIFoSj5TZbvWCS8=;
        b=jAULjniH6ZqqojOc/QNDiCaJCpB3oN/gJegKGvTHE0+OhiKxhn/pAVo1ipEua4O4i/
         VV1/dvrvAF6xpwPBVJ1q7TPgHKgSaClc6a0KW0GjBc03APM3daY8RqU3J/Kqxs2dbjnB
         sw1H+ASk3urfcCQz9Ra6O+nqIk1dunByytEZbdgBllDE0/ffko5QWf+Mh6dKHQp8wXWb
         7544JHLsCdzKkFNmPyyPgoUZuU9OXCjG80IBJCi8zj5+Nzax/NyJYkVAGAImjaVWlBVb
         JO/VDFWKItI0D+CBFf4bupjX/MrqdR1FRhcQSGynK6js90+b1gw/UxszgCxPNbgHKqLH
         Pfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=Sv8DdLTv1kY+QXwSsZTiRnv68zLQuIFoSj5TZbvWCS8=;
        b=uTyw7bTNxWa6i1lfVE976HDkSgtoeJYOij+22FcGT/cMgTbkOXWE8v6fjJ/D1X77LZ
         n5jsC+d6E369NXMSxZIKdfXzRVYiGI9I6FHRKLNGtYsOkNbA5lv18ulVIa0Wp19orkGk
         yTvrK8IYgdWxf2WKnjqccf7N+Xbd1AgteOmqrztbq74RixmP4FLOzkGMVOvKaq3BgJFL
         rHpDlgI7CzngjvxFzeNXR+NbnNrSGXlzc2PbxZXxcmyahwkQsebg4kgT5l4rse3YguI4
         gXeyBy6RFb6Ctmf2QwBdjv4QyTa1h6IILXXIe7g7H51dzJmV4qYz6SJegJgfcSdiEu4s
         3QKg==
X-Gm-Message-State: AOAM532IpkeDi0KD4Q9oZ8q0TeYgbYuVvYBD9bxEAqWujRqBYLivofTu
        5u463NMuZRz7TBCBt8y+hxo=
X-Google-Smtp-Source: ABdhPJyxleQq5z6Eu705vZIzav8X4uaCPaSh4tUtxKJ/MuVlb/+y6Xt//iEA40whMERPJVHdYepsLA==
X-Received: by 2002:ac2:4109:: with SMTP id b9mr1785198lfi.566.1624346999327;
        Tue, 22 Jun 2021 00:29:59 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id j16sm2401462ljh.66.2021.06.22.00.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 00:29:59 -0700 (PDT)
Date:   Tue, 22 Jun 2021 10:29:55 +0300
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
Subject: Re: [PATCH v4 17/17] drm/amd/display: Add handling for new
 "Broadcast RGB" property
Message-ID: <20210622102955.1e0488b1@eldfell>
In-Reply-To: <20210618091116.14428-18-wse@tuxedocomputers.com>
References: <20210618091116.14428-1-wse@tuxedocomputers.com>
        <20210618091116.14428-18-wse@tuxedocomputers.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/c3Ac5T5eA2BEPFgV0t7N7F/"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c3Ac5T5eA2BEPFgV0t7N7F/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Jun 2021 11:11:16 +0200
Werner Sembach <wse@tuxedocomputers.com> wrote:

> This commit implements the "Broadcast RGB" drm property for the AMD GPU
> driver.
>=20
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++++-----
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 ++++
>  2 files changed, 21 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9ffd2f9d3d75..c5dbf948a47a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5252,7 +5252,8 @@ get_aspect_ratio(const struct drm_display_mode *mod=
e_in)
>  }
> =20
>  static enum dc_color_space
> -get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing)
> +get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
> +		       enum drm_mode_color_range preferred_color_range)
>  {
>  	enum dc_color_space color_space =3D COLOR_SPACE_SRGB;
> =20
> @@ -5267,13 +5268,17 @@ get_output_color_space(const struct dc_crtc_timin=
g *dc_crtc_timing)
>  		 * respectively
>  		 */
>  		if (dc_crtc_timing->pix_clk_100hz > 270300) {
> -			if (dc_crtc_timing->flags.Y_ONLY)
> +			if (dc_crtc_timing->flags.Y_ONLY
> +					|| preferred_color_range =3D=3D
> +						DRM_MODE_COLOR_RANGE_LIMITED_16_235)
>  				color_space =3D
>  					COLOR_SPACE_YCBCR709_LIMITED;
>  			else
>  				color_space =3D COLOR_SPACE_YCBCR709;

Hi,

does this mean that amdgpu would be using a property named "Broadcast
RGB" to control the range of YCbCr too?

That is surprising. If this is truly wanted, then the documentation of
"Broadcast RGB" must say that it applies to YCbCr too.

Does amdgpu do the same as intel wrt. to the question about whose
responsibility it is to make the pixels at the connector to match the
set range?


Thanks,
pq

>  		} else {
> -			if (dc_crtc_timing->flags.Y_ONLY)
> +			if (dc_crtc_timing->flags.Y_ONLY
> +					|| preferred_color_range =3D=3D
> +						DRM_MODE_COLOR_RANGE_LIMITED_16_235)
>  				color_space =3D
>  					COLOR_SPACE_YCBCR601_LIMITED;
>  			else
> @@ -5283,7 +5288,10 @@ get_output_color_space(const struct dc_crtc_timing=
 *dc_crtc_timing)
>  	}
>  	break;
>  	case PIXEL_ENCODING_RGB:
> -		color_space =3D COLOR_SPACE_SRGB;
> +		if (preferred_color_range =3D=3D DRM_MODE_COLOR_RANGE_LIMITED_16_235)
> +			color_space =3D COLOR_SPACE_SRGB_LIMITED;
> +		else
> +			color_space =3D COLOR_SPACE_SRGB;
>  		break;
> =20
>  	default:
> @@ -5429,7 +5437,10 @@ static void fill_stream_properties_from_drm_displa=
y_mode(
> =20
>  	timing_out->aspect_ratio =3D get_aspect_ratio(mode_in);
> =20
> -	stream->output_color_space =3D get_output_color_space(timing_out);
> +	stream->output_color_space =3D get_output_color_space(timing_out,
> +							    connector_state ?
> +							    connector_state->preferred_color_range :
> +							    DRM_MODE_COLOR_RANGE_UNSET);
> =20
>  	stream->out_transfer_func->type =3D TF_TYPE_PREDEFINED;
>  	stream->out_transfer_func->tf =3D TRANSFER_FUNCTION_SRGB;
> @@ -7780,6 +7791,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_=
display_manager *dm,
>  		drm_connector_attach_active_bpc_property(&aconnector->base, 8, 16);
>  		drm_connector_attach_preferred_color_format_property(&aconnector->base=
);
>  		drm_connector_attach_active_color_format_property(&aconnector->base);
> +		drm_connector_attach_preferred_color_range_property(&aconnector->base);
>  		drm_connector_attach_active_color_range_property(&aconnector->base);
>  	}
> =20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 2563788ba95a..80e1389fd0ec 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -421,6 +421,10 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_m=
gr *mgr,
>  	if (connector->active_color_format_property)
>  		drm_connector_attach_active_color_format_property(&aconnector->base);
> =20
> +	connector->preferred_color_range_property =3D master->base.preferred_co=
lor_range_property;
> +	if (connector->preferred_color_range_property)
> +		drm_connector_attach_preferred_color_range_property(&aconnector->base);
> +
>  	connector->active_color_range_property =3D master->base.active_color_ra=
nge_property;
>  	if (connector->active_color_range_property)
>  		drm_connector_attach_active_color_range_property(&aconnector->base);


--Sig_/c3Ac5T5eA2BEPFgV0t7N7F/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmDRkXMACgkQI1/ltBGq
qqfhCA//RdPwONXlGKN0tquJBHVdI25v6rSIH4cX/Nmg4W4i5jwQBeGgRInN/tBA
tCAVLGzlT0wB9nxvOD4sKkFaStwoQVyWKx7BJYcYCBshdU96LP3Th8LPR9DK36Tr
c0/fwpZy7scUj8/pear58shSiC9jhGovJW1xvI7JPu4DcTdWEBr8+odAxb3/FDQr
tW9qeMAx8tCNTXryO3N3Rj270+Uqg52qJd357ADJ6uDGcc2kkbwyMCWI0maY/znO
xlZaQIA6NDBNJv4SCmT8VQ68mT3uHYt7gz4r+LgIkNhsUIP4eJtIuqiGHoDwvGUc
FBqfYWC2/8hOyYsZfsKl69fxwUN5hqnyG666YPCHT2hTAI7bKsW8bHcu9fyjIqM3
2onCUAmUU5RzO5OR0B3KW5g4SWuJ+EC40EilHLD8hNET212N2S78U4bLeX6vo1dv
Mx3A/ULl6clOfdxODhOdLcY7VQGpSDYEeQCktNo9qvf9DKHZDVX5qDgewFBAPzUK
ga4bhxH50sIXpP0HjuZmyCIKqoewc0MPpmSSP/36L2CqI0um2Lw9n1XNamI/8ymj
z4bhI0GVz5ru7mi7SDpZPZNj9429yGonnZtZw9GMwK1YFDD0kfnaQOd8JVIPFC9V
8HlTV/y7F4HStNFTsGNQxpoXLGio8+Cmdz2Fh+7JUIDz2IhTrlI=
=c5Cf
-----END PGP SIGNATURE-----

--Sig_/c3Ac5T5eA2BEPFgV0t7N7F/--
