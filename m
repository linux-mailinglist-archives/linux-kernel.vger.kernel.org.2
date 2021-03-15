Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6232033C143
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhCOQKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:10:11 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:46647 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230063AbhCOQJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:09:41 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 553B638A7;
        Mon, 15 Mar 2021 12:09:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 Mar 2021 12:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=2iij3/Auk5Z1TMqg8+CIBIIxIR0
        J53jMgRD4AZNwPGY=; b=fiHswGhBDbPRXKTAjKKgQvzB0qeXI2K8P3M89MdSf4+
        GcwqGWfLkjIJ1J+SKjYzhxs4HFx1D97gIkuQRUst2j77pK5gFxRcipV3Mj3hlYQK
        jgI33+BzAME8gNyQCwTmRm7lPzabNV48rcPmrzldvQVdKRdqGJNBKv3Ws+4EZa7/
        z3LMPTGja/dXfUnqGlX+Qmbz+BZ+FcEimcH5UWpGiXXyQgCL416rFj5JII8Fd9jS
        x73Y6xlRDzSJYXvzzvqTEloJLPipbHX4lqes5+0b9xhpv2jWcksDrurdcWi7XSvH
        /2mty+AZt4P5bDhzVn5Q2Tk3fNfwB77/000DGRgwsAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2iij3/
        Auk5Z1TMqg8+CIBIIxIR0J53jMgRD4AZNwPGY=; b=PwJOJToiCc0A638aHrb2k4
        UmQwfZsYHBRRlSiAkYmNGWuUguaKXEaztpcC3O5Qwgh2lOntMjGc1DPb22VLii8u
        Vfr8Xhw+amgg12Z2uC8i8TuK9yKwe77nxWTalPMiIZrsOB3Kt63hdYETGFIlT8AH
        t4I7pZcho7pczdA93z3aIF81/gLyH4Jsr6rMSFO5rOYQmbsIQ/cUlqaMcl+jaZ0X
        gVOj9kvN6IhKTtLv6SF0PNBtAORQDODah6XCMHfGvdI92w6Y/SI8Udp5xLNSuRtX
        Se8EPV2h/HjGY0nDhRlPH2ilOU37G9xx70AojJxV8Lx/warZDkeUZHDYxQmntveQ
        ==
X-ME-Sender: <xms:woZPYCmpJxLUZkSHh0DJhacKE3bQrG96KTq1qwgQmRF9mziq1Z0zzA>
    <xme:woZPYBTUe45Ae4fwAnsy3FZuHWnu3FdbJlqt1-pIsfCuX9qKkKYX-21aFZ3OUVMoP
    gMZ0-uLMZRww0adDl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:woZPYOBMMfoGD52YjhcFJnIt0Q-kqeKZkSrb_4p2ktdlU1ANMmJi9w>
    <xmx:woZPYAR_Wdlr3NeaRBxVVcS4rm0WbOmIxAGj7d576ZAgEfYbyly9rQ>
    <xmx:woZPYEooSu1q8A0J_FRGWna02wBqGp63tz4ZHAwe0_VnQ5jaa9YWdQ>
    <xmx:w4ZPYALSCKDqCAiC48qBgeZm5qNV9NTgv5S1Rlz48hMorXjoSN_Iww>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6854F24005C;
        Mon, 15 Mar 2021 12:09:38 -0400 (EDT)
Date:   Mon, 15 Mar 2021 17:09:36 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v7 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
Message-ID: <20210315160936.etqsexfcok4e2jf6@gilmour>
References: <cover.1615713499.git.wilken.gottwalt@posteo.net>
 <b7a1f5532e0ae474473858055fd9bbabff9e1449.1615713499.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jtfvroiiyfq6xc6b"
Content-Disposition: inline
In-Reply-To: <b7a1f5532e0ae474473858055fd9bbabff9e1449.1615713499.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jtfvroiiyfq6xc6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 14, 2021 at 10:30:49AM +0100, Wilken Gottwalt wrote:
> Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
> compatible series SoCs.
>=20
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--jtfvroiiyfq6xc6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYE+GwAAKCRDj7w1vZxhR
xUoGAQCCy+MU1jfBheBrxCH772jjnXNoTkHOmUwyXw5xFzn/bAEAujvJBT5XjnXP
vx3G/8vy7FAvOuhYEF3/gm844WT8two=
=/0o2
-----END PGP SIGNATURE-----

--jtfvroiiyfq6xc6b--
