Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EEE324C12
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbhBYI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:29:34 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:42249 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235901AbhBYI3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:29:23 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 963C62C0;
        Thu, 25 Feb 2021 03:28:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 25 Feb 2021 03:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Y9Gv6iZZQ2bb0yIwpCDfsgvAtPi
        Vd7qD5mlt0Bt0XeI=; b=iUj8SrA8pMuMSHzXqNfpdkRTv5LHEHrqNsUWJWPG92y
        n5XX3wQPuxLyDYZe6diiXkxlpBNS7atD8ZlfLQ2imGuvYd9vjCHN+4356r85Ajb3
        gIUtl3IHiUyTuiy9p763tQUV/N1s3GzXChAittz3oQ3Bt+O9MHzWREOpEmgcUO8C
        PD7vWGsUUTjC5zp9oMutEEOUavv+kz7eMxplejGD8HohJCUw7E4Ix3B8634plLv2
        hCMnnfz6cYtNOvc7VHtpJ1nYeHqTJr8tcDYtlXlO+VTXxK/Dc5n4HZiccohenDF/
        NSYHx/EpU0OKFgCmB8wt7xV1YNvU6N7PmjmqDlnG69Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Y9Gv6i
        ZZQ2bb0yIwpCDfsgvAtPiVd7qD5mlt0Bt0XeI=; b=DiUUdZr5pBX9Vde/BYmOxx
        +/ETiGbxbC/CblLDUmjZy8mfjTRN4+AiZk5Tx+opWp08we7QNZMs2w+8sxQpWQ8e
        R+GVvzewIdzUVvVVE8tIGqv4VC8cPblVa6SQdXFW4l0qTW9R1B+Q2bytCE3B92B6
        FPDdR/ZFsUMwNRUDCzzeCZvKeeofB+gKxsB7nWTJoAFpQ7U4uyNN4t5Z9cHV6G/F
        pCnnxAqQtOEAMbfWJ+5cDmKXuCrTTh6k2Jc9DmA1LLrv9HoytvNwnfeMd6dZi8Fg
        gY35vtcHs/Biv4iOnRYEXL44oawDk1ywo+IPrO79sa5YJ4lDTAOdRJBz4c02+XwA
        ==
X-ME-Sender: <xms:r183YDya3pr2fDcU8f1LWuHWaePm4yGPCxour8BSw8XOE1laBpw4fw>
    <xme:r183YLSvn27zl5KP7GrNN_B9gR19cFPUPJEs8Urd3vd06On39SjJOVGbGLnBCOVhd
    1zzwufSFViNigttRq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeekgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:r183YNXfKZunF6ifUUEBA_9I_mLbW3AoHGkdVL-LTC8PzZhRiBcsvQ>
    <xmx:r183YNgXLQPMiHwx-yI-Oxy2U5zGaZyF17Rj9gT6i2GW_A5Su1RqhQ>
    <xmx:r183YFD7AmVyaBHAZ-8WF9L0ZbsafLJGz2FRY773L_YjWDVViN_8hg>
    <xmx:sl83YJ6QDgf3_lrjxK0dkem5mx8a7y-5E3XdS9htJRKRaeePkoc9WVaM0i0>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D1A281080068;
        Thu, 25 Feb 2021 03:28:30 -0500 (EST)
Date:   Thu, 25 Feb 2021 09:28:28 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Martin Cerveny <m.cerveny@computer.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 0/2] Add support for Topwise A721 tablet
Message-ID: <20210225082828.orqttturwbt6ckov@gilmour>
References: <20210224105240.47754-1-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mddrviwckt3hjn4y"
Content-Disposition: inline
In-Reply-To: <20210224105240.47754-1-dev@pascalroeleven.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mddrviwckt3hjn4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 24, 2021 at 11:52:38AM +0100, Pascal Roeleven wrote:
> On request I'm resending the last two patches from the Topwise A721 tablet
> series from a year ago as they weren't picked up. The other patches are
> already merged, so I didn't resend them.
>=20
> Changes from v4:
> * Reorder nodes alphabetically
>=20
> Changes from v3:
> * Fix DT validation warnings
> * Remove leftover labels
>=20
> Changes from v2:
> * Collected acked-by.


Queued for 5.13, thanks!
Maxime

--mddrviwckt3hjn4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYDdfrAAKCRDj7w1vZxhR
xXolAQCEdwE59axZzlSV9vxCO+BA65ZY6hptY7stXyvrttkM8gD/YcZtMXvHoayg
T/Vbe+6f7Wg1eadL4IzRckWcMm1S9wg=
=lnHG
-----END PGP SIGNATURE-----

--mddrviwckt3hjn4y--
