Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1877F34C82D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 10:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhC2IUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 04:20:24 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44119 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232832AbhC2IMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:12:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 276165807E7;
        Mon, 29 Mar 2021 04:12:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Mar 2021 04:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=oqsVx7Wa9B3yL9HqcD5l5oz8SUz
        RLcA2I7HU56LTzCk=; b=GjY7Jcgz1iDDJqrMJX7TE7dg8hs4xL+gJIns2/d0GYN
        Tu8Q64JfeinRu244wd6gRP4/2sFruUqc2Joo8Rn+OY/5o9+XbtPiZJP/CQSgwkeH
        a2LyYQrjOctpd4sfhSkemNYbQwlyw6zH1ZI5O+4NlT7YJKJYjxs7Jtyt+HAJkndU
        rmXh3MDfG1SuIgJlRIMdd1y/1opMPzDrNk9TpM2urYqSJ3cM42Bj9cBkZqxEJ2pT
        W2F+irrpWfwwhCEZI+gss+jfDHPynvAplgMbeGYZzRRmX3wKG3HTO/oIhFAAVoJ5
        yrpWDiaiXd1lgL2Tm1+zdUYile5yXBv5rokcvIe0XTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oqsVx7
        Wa9B3yL9HqcD5l5oz8SUzRLcA2I7HU56LTzCk=; b=OKoiPS7df+NHR9dTJqSc5U
        szrjSfirFd8YXJeVZ+TNqeW41QpaR26yLx+VmxRCTBwgnJMA/hPu/is+Niu1lOvS
        3if1wOtng48/HhduveCnox3WYYNyvjjMv7ardEiVUJzfTH5i4du2NgkSJ8v7zM1S
        aHC2wMvCtObg3vkZuxUSQ497blWcGTItBRgzKKYw0FakGiBY9NsM8FX+SI7tZz2K
        I7Uax1tKwrIxNOTXpEAvdzvOdcNW0T3YeNgEXymwE8vBGpzaQy1LNnBmcn6resXr
        lRQ/DBcIjQzKeszAzF8Kni6WkfCOf+7Pa8sQo69Be4me5yQZWx3qEyQmJj1RN2jQ
        ==
X-ME-Sender: <xms:24thYAr6X_Ta7EhcfenGGbn_wiLPA9uoY3Iy8ryogOyPuWKbiep7NQ>
    <xme:24thYGqOsLxTkPUmx7-0_MPFE6Q19hV-9UBnK2xhn0YI612BInB13XBXZL67J11gf
    qmYiNqwWgQZBicYRtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:24thYFM3OCQDEbyYTF0PEim54NUusJVevjWQF04NrY3psnXYWrUUEw>
    <xmx:24thYH6MCy0RS2AlM2boTE6I5kHydWEjQH0IpEpX33LuezH97Ox4MQ>
    <xmx:24thYP7Jj5K0UHtzjI5u61CrzOUu1l2-XxI4oVcsABpo1TspaVz2eg>
    <xmx:3othYMHINI3lBy9KMK0ysKQ8PRgzauuVZo3S0NxsLHdk3orOUiQJYA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 657CF240057;
        Mon, 29 Mar 2021 04:12:11 -0400 (EDT)
Date:   Mon, 29 Mar 2021 10:12:08 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 11/17] ASoC: sunxi: sun8i-codec: clarify expression
Message-ID: <20210329081208.dptewcdyfmyiph6b@gilmour>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
 <20210326215927.936377-12-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zkapbnitichvusdi"
Content-Disposition: inline
In-Reply-To: <20210326215927.936377-12-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zkapbnitichvusdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 26, 2021 at 04:59:21PM -0500, Pierre-Louis Bossart wrote:
> cppcheck warning:
>=20
> sound/soc/sunxi/sun8i-codec.c:488:28: style: Clarify calculation
> precedence for '%' and '?'. [clarifyCalculation]
>  return sample_rate % 4000 ? 22579200 : 24576000;
>                            ^
>=20
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Thanks!
Maxime

--zkapbnitichvusdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYGGL2AAKCRDj7w1vZxhR
xSEyAQDnB6Zo9u/iq0gHRIh8hjG34eg0RyxBVTAKQ3GY0LiocAD9EIAusS+HWyRH
dhe6wdMSsmoo0o/6HynyBoKaPodJewo=
=9pff
-----END PGP SIGNATURE-----

--zkapbnitichvusdi--
