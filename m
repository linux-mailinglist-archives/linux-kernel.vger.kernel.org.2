Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E83A3761B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbhEGIKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:10:49 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45725 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235320AbhEGIKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:10:46 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 41F6058123D;
        Fri,  7 May 2021 04:09:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 May 2021 04:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=W1CZtGGfJPRYLuVe9lYsOpidBYI
        J9lZUWGVXHC3ow7U=; b=AC2k3XX//H84MBeRQqNs8q5xtCxn3+uPKx4tY6/wn3t
        YOjdYSH+avurYGjZJ+R5YL1KkyzlmHDXrFYU7G80gCcC6g8nUEbFazUuhZpw+Hnj
        HNTiYmUZbgzAwYIfLkq2z1B8zfZh1vVfPZBR6Os/C5O+N3u/A29QwlWlAo4XVS7W
        HLM5CS1adsytTjV277ttb2JZQcqNuxwwu89IVVDWqROl6LsyqisUuo+PodZe7NI6
        MX3guHyMP2w35SSVykytK6H44wTpQuPiOCfChdaECthy0XbvwIbLw1XIOU14GP7B
        v/57ldjmIFjDYvfqFm4A7rWMnO5zA8ccuGo/edO0qyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=W1CZtG
        GfJPRYLuVe9lYsOpidBYIJ9lZUWGVXHC3ow7U=; b=Jm75Z1jomnWRHmfILmh/8A
        J/QW11u3AjUI2HWfRknakvz5iKeZ9qqSVftiefND8301nDCQqLnBxp7rtDovQE2p
        XHwfqPF9xYas2JqgU0sR7FuWkU+t1PS0i6qJ1gdkGw026T0bUo1o/FcPreAgpaZ2
        sFYIx3tbbkVlzmvy05pIiZ4ZUA+XivkLBdTTIYUXPLRXF4PIOO7APyWaFv6z7Q+z
        SrkEsxW9smnYUeXHPcWZxvVaAVS7JUYC2stEgg1/FHxg8KiBwq96OW+wMXSR05pU
        uCC8D0uHBzkm4rMkWrqrApTJVxQ9ZcSTRUEtQ2v78Qus++2nIKwLpbDMWn4TCwBQ
        ==
X-ME-Sender: <xms:yPWUYDNI4MxBq0XGSqkSHtzmAoujiluf5SopazEDTZLnUWpwp_zG4w>
    <xme:yPWUYN-rVs0jgH_E43pMgET88_AYW5CWMG79xDFOnmg6r9eiYdGJ0x8T206GmnxXH
    Wy6FF02WmEZ-vn053c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeguddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:yPWUYCTgRRc8_7QL6LopK3Q1hA3rbO81OMd5tXGHzQIRwiKTEyC4jQ>
    <xmx:yPWUYHszNM4ftu2Yy-9Xp9_P0X_xZhnA-1mGlTq-IBBIF0jitXbgaA>
    <xmx:yPWUYLcxIg5binSnUuaWgIg-0Zf6oNWsvj2tpY1mtcyUtV6w_gyeww>
    <xmx:yvWUYP4oeVQW_PYHXszOJ_cJFfazAiSgWkbhvZkCpXjkDX0c5Zt-Og>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri,  7 May 2021 04:09:44 -0400 (EDT)
Date:   Fri, 7 May 2021 10:09:42 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: allwinner: pinephone: Set audio card
 name
Message-ID: <20210507080942.lxysxdbrviv3ys7m@gilmour>
References: <20210430035859.3487-1-samuel@sholland.org>
 <20210430035859.3487-8-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ihzax2lsrfyfzrwp"
Content-Disposition: inline
In-Reply-To: <20210430035859.3487-8-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ihzax2lsrfyfzrwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 29, 2021 at 10:58:59PM -0500, Samuel Holland wrote:
> From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
>=20
> Add the "PinePhone" name to the sound card: this will make
> upstreaming an ALSA UCM config easier as we can use a unique name.
>=20
> It also avoids an issue where the default card name is truncated.
>=20
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> [Samuel: Split out change, updated commit message]
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/ar=
ch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index 51cbfdc12936..02712f85f6bd 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -433,6 +433,7 @@ &reg_rtc_ldo {
> =20
>  &sound {
>  	status =3D "okay";
> +	simple-audio-card,name =3D "PinePhone";
>  	simple-audio-card,aux-devs =3D <&codec_analog>, <&speaker_amp>;
>  	simple-audio-card,widgets =3D "Microphone", "Headset Microphone",
>  				    "Microphone", "Internal Microphone",

Isn't that reported to the userspace? I'm not sure we can just change it
without breaking it.

Maxime

--ihzax2lsrfyfzrwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYJT1xgAKCRDj7w1vZxhR
xSN6AQD3KXo1qhUktSUrwtB6Jar0ZYG1x/hRV26hfMJERuIbsAD9Fu05Zz34S5pC
FTlOdQdVY1o8ms2ebETiDcmOOEJolww=
=Eg+P
-----END PGP SIGNATURE-----

--ihzax2lsrfyfzrwp--
