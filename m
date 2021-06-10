Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E193A2BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFJMwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:52:37 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:59159 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhFJMwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:52:36 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id CC96758081C;
        Thu, 10 Jun 2021 08:50:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 10 Jun 2021 08:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ABjQvZPhefKPvkmDBxKwIOrIqqn
        COuBM9y1z5h8KUQY=; b=ycp4+TgpTtbR5jT9KMPRYE4sBcEj+FBsxS9nTdsfZOj
        cSpPiUDTS3gWa357nXgCF9El9lT0DIQep8X0Udsdd09VASnSbBJSyT1c43fmdSmw
        Av52R1leCDt16LbTIGCkJCIuhd4yVmmSbzM0sPTrWLMG3WoOVidq1cWIX4LclG3W
        nZL2/B6jNbJt+gn21EmEUUw60j/aCBNfhhjV+b9oRazSYavvicwLdPCloMhjJODP
        VTjT3xkbCZ1W+YkWlNQEHH7GyTH7hXYu5az31JP33koYpX9z4/0gQ3fmrshBFQ13
        B2jgq6QPmy8I1BTQbvIVkUx8froL9X+n41F6yaJTqog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ABjQvZ
        PhefKPvkmDBxKwIOrIqqnCOuBM9y1z5h8KUQY=; b=oA90QSMA/V8RORuzFb8DJ0
        VzsmPr8HwvQBdZQTPPfB4ERXIQu6yhJbgQpEVn92RU5XFaP5nCuZI4SM2uRsihqL
        t2yYW87VTdIhPnGJ6j5QG8F0+ASTOycLJL4+i7ZDwdDm/7RqezIBOE2uKTONtU9r
        SsUjsnen3mRp0gmYbKg2pn17lMSKhAcTgifrDuNbS0vJzlp5RFFmpdfzAl1A4yXX
        RDM9UWvwVbfWRpSb8Jr/rPlRaUnC92Rmx3ttym0Krzzsrf+MPJ0rg63GcPsxz2dQ
        yMyM99ii5cfP4FemJHPR3DeQSozy5bplK+rAEMohXQ4Vata1mTggpZdPDVGIHB5w
        ==
X-ME-Sender: <xms:ngrCYD8XED4n7-WHBO8_U_CHweXsVEjYZkS9Hp-CDzP9pi1UCV5yLg>
    <xme:ngrCYPubxjkWdsuNKcCzQJSe1vf8bReEJc3UJOg242fN9psTxLF8azDY5jJtjA4Q9
    zX0H--JeqP1CgKqzD8>
X-ME-Received: <xmr:ngrCYBBEeHYpDamyMyCr_wVUnuyG4wlbgvFVCh94lmB9f8AJq7Ubm0jFW0DZ3UBpNXKm_cO-_v1MBUDXZU6QbIsdbzYgQaZlkBFq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedufedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ngrCYPfG_mFeRT1rQHnEaoFY77IJBmnCRuxNSNEeBO_G-n1k9JlZkA>
    <xmx:ngrCYINlNHr9QQ2MgOhbrCclkuIWUO1jJo1ZOytb49Tr2aI5yOKsCg>
    <xmx:ngrCYBmHLcvzL2-8mibihrvayc0G3UKH6Pjm5XETrD5x4mh9sGRccA>
    <xmx:nwrCYPm5xwdU3mEaFLKdJc8ReO3UwGIX6sOZOgvLf_itfBkrPN1BVQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jun 2021 08:50:38 -0400 (EDT)
Date:   Thu, 10 Jun 2021 14:50:36 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 4/7] drm/i915/display: Add handling for new "active
 bpc" property
Message-ID: <20210610125036.33fpnaoz4xpiqslw@gilmour>
References: <20210608174320.37429-1-wse@tuxedocomputers.com>
 <20210608174320.37429-5-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2vxklm2zenejnoep"
Content-Disposition: inline
In-Reply-To: <20210608174320.37429-5-wse@tuxedocomputers.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2vxklm2zenejnoep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jun 08, 2021 at 07:43:17PM +0200, Werner Sembach wrote:
> This commits implements the "active bpc" drm property for the Intel GPU d=
river.
>=20
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 14 ++++++++++++++
>  drivers/gpu/drm/i915/display/intel_dp.c      |  8 ++++++--
>  drivers/gpu/drm/i915/display/intel_dp_mst.c  |  4 +++-
>  drivers/gpu/drm/i915/display/intel_hdmi.c    |  4 +++-
>  4 files changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index 64e9107d70f7..50c11b8770a7 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -10388,6 +10388,9 @@ static int intel_atomic_commit(struct drm_device =
*dev,
>  {
>  	struct intel_atomic_state *state =3D to_intel_atomic_state(_state);
>  	struct drm_i915_private *dev_priv =3D to_i915(dev);
> +	struct drm_connector *connector;
> +	struct drm_connector_state *new_conn_state;
> +	int i;
>  	int ret =3D 0;
> =20
>  	state->wakeref =3D intel_runtime_pm_get(&dev_priv->runtime_pm);
> @@ -10456,6 +10459,17 @@ static int intel_atomic_commit(struct drm_device=
 *dev,
>  	intel_shared_dpll_swap_state(state);
>  	intel_atomic_track_fbs(state);
> =20
> +	/* Extract information from crtc to communicate it to userspace as conn=
ector properties */
> +	for_each_new_connector_in_state(&state->base, connector, new_conn_state=
, i) {
> +		struct intel_crtc *crtc =3D to_intel_crtc(new_conn_state->crtc);
> +		if (crtc) {
> +			struct intel_crtc_state *new_crtc_state =3D intel_atomic_get_new_crtc=
_state(state, crtc);
> +			new_conn_state->active_bpc =3D new_crtc_state->pipe_bpp / 3;
> +		}
> +		else
> +			new_conn_state->active_bpc =3D 0;
> +	}
> +

This seems fairly intrusive, but also commit / commit_tail might not be
the best place to put this, we want to support it at the connector
level.

Indeed, this will cause some issue if your HDMI output is a bridge for
example, where the commit will be in an entirely different driver that
has no dependency on the HDMI controller one.

I think it would be best to do that assignment in atomic_check. That
way, if the userspace does a commit with DRM_MODE_ATOMIC_TEST_ONLY it
would know what the output state would have been like.

Also, all of your patches don't follow the kernel coding style. Make
sure you fix the issues reported by checkpatch --strict

Maxime

--2vxklm2zenejnoep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYMIKnAAKCRDj7w1vZxhR
xb2ZAP9gRrPlS38/OW7s4dafkzTuRrBhOtSTdnrrw47FyKHLEgEA3XSy04q8E3/r
yUuRKuVjbjdNwEqthkGS3cF45iKZxQA=
=ikPa
-----END PGP SIGNATURE-----

--2vxklm2zenejnoep--
