Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3440852D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbhIMHRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:17:38 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55857 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237572AbhIMHRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:17:37 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F40E15C0097;
        Mon, 13 Sep 2021 03:16:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 13 Sep 2021 03:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=3Drb7itOQtyw+8s9nG9D2KLbtAr
        Lqp9QKHVCPoN3x3A=; b=mYAG2WcF6g3Yv7iRc7KceuWZ19gRlxvRKeZgvSSyeID
        ixcN5YsrrTD+VtTtPdqb3Bbbu2N2AWFvQM8Oz1PyPdixl3X2qpnTKL06A/tbUazV
        VrKboC92L4TG2EuEhLZWLduOclvRb2UCUEEVcR9fQwMlBTK93MxskZ135ALo1sDo
        m6MAaPX3zIEeCn3+7zcfq9O3arLxjtucHQwwztVeJxyXNNqNIZDpvnOzzo6r7rQD
        4APljjdZWK5Oo3tK/48L4eGFKL3Pa3tAcuxXqltNr6AMTPYNQsKIZPyKZMJjwGlh
        BZV3401Mz4MILWv1wNamD3gPo0KsNoKv8lbH1ZPm6cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3Drb7i
        tOQtyw+8s9nG9D2KLbtArLqp9QKHVCPoN3x3A=; b=Ucg5mGrJhezteg3puAz0dG
        hQZq7wK7gP1GCFBBznu1HopA7bPziLir1FhWysl4pJRpfX9ZKAB3VWdgW85hN0x/
        OwAmlKIDtJYZAawK1OagfmQ0G54SC6dCgF2T0XSMjOThA6Ys1ehSE4MMYIdkW3QY
        FAxG7z+4cyKpM4GmlCjqlHuMeseH47RWc3WDLNogxH0z8yjADMaCuSChY1BdzL7q
        QhRD+pypdkJVDa3YeJDgE9+L63XynGjE8OU2LUCaRg+WZGBo3ZOJNtaWLPdp0loE
        vpZYoP6C5xww/qXNX7NJxqSSVU+75oX42nSDOoJFJLQq4emRNYuPtvYHK0LVqU4g
        ==
X-ME-Sender: <xms:w_o-Yd2T3CHYzWblX8iyWy91BMnnTbump3-8aMaMi1eI62ZCk-Hb_w>
    <xme:w_o-YUGfddWEMzaVcrcmwNa4qiQEwSVBdfSjGwxPz0TAnnUSHc8Dg_rV3uvn6oo3z
    buP5BhhCqkxIQFH4Nk>
X-ME-Received: <xmr:w_o-Yd6MdbU94rsMSV6Kc6zwAjjdsiQT54MXO3nzz4y1TaXsvgjnKzW8CEHgeJ-kqyQiTBd0VO0kZhM3MpCN89yl9HRbyDVBX9aY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:w_o-Ya3aJ4WUWBZzb8IDr8gVmnORINowJBFGcF-oXAvPM60-rVBMBg>
    <xmx:w_o-YQFOL1pcttYo2bSC_b410zWT2A4qibl1IORsWJvl2-20YYyItg>
    <xmx:w_o-Yb-4Cy7MIlxSvEXx8css486FPG5Cy2ZCN0upCgZJKewKkfJ8RA>
    <xmx:xPo-YeZoOUpvltYs1EpCmZBzjDZjr3RsugB5FfEXVMENSaUIb53NxA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Sep 2021 03:16:19 -0400 (EDT)
Date:   Mon, 13 Sep 2021 09:16:17 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: dts: sun8i: r40: Add I2S nodes
Message-ID: <20210913071617.i6lkibxh4ylnfkem@gilmour>
References: <20210912072914.398419-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zkuatqnldjiqikz5"
Content-Disposition: inline
In-Reply-To: <20210912072914.398419-1-jernej.skrabec@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zkuatqnldjiqikz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 12, 2021 at 09:29:12AM +0200, Jernej Skrabec wrote:
> Allwinner R40 has 3 I2S controllers, compatible to those in H3.
>=20
> Patch 1 adds R40/H3 compatible pair to DT bindings.
> Patch 2 adds I2S nodes to R40 DT.
>=20
> Please take a look.
>=20
> Best regards,
> Jernej

Applied, thanks
Maxime

--zkuatqnldjiqikz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYT76wQAKCRDj7w1vZxhR
xZsJAQDeEDPcZDmfMJalBcC7nUafBRgdZvuSCYixP+VuD4aS0AEAzQFuhhZPW67l
kpEcVV3B0CGdnUzkW5jo2Zlfq6bSeAo=
=6FwN
-----END PGP SIGNATURE-----

--zkuatqnldjiqikz5--
