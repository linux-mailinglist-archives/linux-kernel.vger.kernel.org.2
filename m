Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C19A37A198
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhEKITi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:19:38 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:57427 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230157AbhEKITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:19:37 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 40025580E43;
        Tue, 11 May 2021 04:18:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 11 May 2021 04:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=W3psH/2qgATwtINm37wUxNWcRwQ
        rHkL1ZPkquwyesfk=; b=n7N2rQXFXg1fjlMT0vhGhUG/nS1KRz1suiGnqUh7UBB
        jrN8jx39VE3aoo9xssTLcayDcvTxja1ZrIWKjUWci8gaZp489iYLbVQ3qKH7WDNt
        hR/WB1KETo2D4SxbkhSZ9IQ9Vw5SLiUWqyjBRVvye4m9owZ+wG1ZH0aqep492quq
        jTm5WMsYMvdlhI2XUlDgUsxqAS60y7q6LL18Gh9G3bonVV3JUMAyRmdvKdxeOxKf
        GrNiOqc7ELFd6staIPI8rdmLDATLxo4K33DfzZHt70WYAIlafKvW5oKZibY/3YiU
        5WP2SrZeCj7u/SllC+MOnvfNd8RsitRtMmLYvs7sR1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=W3psH/
        2qgATwtINm37wUxNWcRwQrHkL1ZPkquwyesfk=; b=Gw24brRJ/8OYpN+talOvn2
        GYkZJjFL+Zdhe1/+Xej9W5BFVFVsPRQNpGtcuB1kKr1XPvrc8TruuFKnDxTBsqwx
        RFvOTHKMKsZBCDQcT89cD+AzEz8GZwo0aDlERcDOUiHDf3Y9PHc1mSTqpIyo01Hi
        x872EUdNXkyEGojaXh0kSPbso9RiyKIwAfTcJDhw1dLns17W1XukzoaOqCImWKuV
        iMwm4aK93WgTus9UaIAYMLZ4uzfbGpa5vI6RzePDck4VKuNVIuqBCxJU3LZnbjUu
        +5jQGilyxfxDjab5GPMFfN1rcz76yvj31sBZe8yO4z15GP/4dd8QtI7lnwT+90vQ
        ==
X-ME-Sender: <xms:0j2aYJG0Qb30edIe3sYX8-AN26rA-rn_Fj_4OUWh56l9n57dVYCVnQ>
    <xme:0j2aYOVD1hiqp1hygbJGI6zyJzppIE6U2xOoh7c6g-U1HeqOVVtmzefUH4iciiu6w
    jpdFDOtrFzdbpSrgLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehtddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:0j2aYLL-tjgckFbHWAybgrug0nA1oVwWXEJdSeci_-RJxCvEFRE6Uw>
    <xmx:0j2aYPHJufuaH8Ck-i6-nMQ94iQypBu8UeMkAP2iq9cVysz8luPAPQ>
    <xmx:0j2aYPVF-X3cOl2Y9Jrb4yMLb-m9QQXbZwGRoxmEDskoY0fZmalhHg>
    <xmx:1D2aYLr3yjQRA0Ff7s2_Q4n2QuxCkbHAGvk4q5goZ7KrXjPpgBtF7A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 11 May 2021 04:18:26 -0400 (EDT)
Date:   Tue, 11 May 2021 10:18:23 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Chukun Pan <amadeus@jmu.edu.cn>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: h5: Add NanoPi R1S H5 support
Message-ID: <20210511081823.mmcrliomwtetcirx@gilmour>
References: <20210503142905.21468-1-amadeus@jmu.edu.cn>
 <CA+G9fYsRZswjeDZj1hiGDu5HZ+jYCVsOOL6MAzEb=LVfQ1_NpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6z5yg7iwrnly6v2y"
Content-Disposition: inline
In-Reply-To: <CA+G9fYsRZswjeDZj1hiGDu5HZ+jYCVsOOL6MAzEb=LVfQ1_NpA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6z5yg7iwrnly6v2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 11, 2021 at 10:51:28AM +0530, Naresh Kamboju wrote:
> On Mon, 3 May 2021 at 20:09, Chukun Pan <amadeus@jmu.edu.cn> wrote:
> >
> > The NanoPi R1S H5 is a open source board made by FriendlyElec.
> > It has the following features:
> >
> > - Allwinner H5, Quad-core Cortex-A53
> > - 512MB DDR3 RAM
> > - 10/100/1000M Ethernet x 2
> > - RTL8189ETV WiFi 802.11b/g/n
> > - USB 2.0 host port (A)
> > - MicroSD Slot
> > - Serial Debug Port
> > - 5V 2A DC power-supply
> >
> > Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
>=20
> Linux next tag next-20210511 arm64 build failed due to this error.
>=20
> Error: /builds/linux/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h=
5.dts:35.15-16
> syntax error
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [/builds/linux/scripts/Makefile.lib:365:
> arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dtb] Error 1
> make[3]: Target '__build' not remade because of errors.
>=20
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>=20
> #regzb introduced: 7c9dbeda744f ("arm64: dts: allwinner: h5: Add
> NanoPi R1S H5 support")

Thanks, I dropped the patch.
Chukun, please resend it once it's fixed

Maxime

--6z5yg7iwrnly6v2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYJo9zwAKCRDj7w1vZxhR
xe67AQCUYlXoGcwJHLhh68hRF0ylL5Pt4GTchOLKtWcp6i7AkQEA7TgGLlf2l4S6
htRJVKBQZSxCAzqukoXw9M0lRZRnzAA=
=ToBG
-----END PGP SIGNATURE-----

--6z5yg7iwrnly6v2y--
