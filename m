Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E8E33C153
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhCOQMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:12:51 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:45439 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230405AbhCOQMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:12:24 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 2678032D7;
        Mon, 15 Mar 2021 12:12:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 15 Mar 2021 12:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=WNHtvP7BKPSirxSpzTWIe4zHI5+
        AJMQZQRuLDzKPABY=; b=T84ECQkg5SvFVLww+BtElw9yRPpbIfvWSQovK8WoWPt
        EkSbkYjo5YJ5HFpqxYxNsEuA3/0FmZ4icG72TVPQ4k3vPYz2h8zk3EMoEoJq7Qgu
        2o5foXqpXsBsdng5SSjM3aRQQ79Ol+DHUuNVHbSPiXzQ0WceUwfFy1itl5z4PrNq
        9w41jJbHRV1ylu4DGHk86vr08hvvlmbiIVNSFKqKQg+4TFc2u8PJRlvjkkIjFULf
        0Z7PlCv3W5mLY/h4kETsiiJJHyr43fteH2arqBGPpRJcGkafOazvd+VrfCgZxqJ6
        8MZbFRwqd3vOBpxKjhe5nomxdI3KWu6370mMFcQB/Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WNHtvP
        7BKPSirxSpzTWIe4zHI5+AJMQZQRuLDzKPABY=; b=YgTxdVJdmEMw7pumTzqsvE
        8hWruC4u92L2hudcXF8No24CLQehXaHl11VXyUX1khHiGpO+AJ7yp+9UhxoUkEoU
        Iy2caGvkRVtM+nerFygQI853ZLYOdGQmCOQxMJFVF64qtYDbsheGFd74vbpWQv9G
        MtQJF5gcbzme/9A+f7af1JyzJsN9pUt1gbLGU3AgtM+BtGUdHWadrWHGySl2wADG
        78UvcmSlSZXQPgfYhXWejL7+NpQEeA4JNZdg1m6GdtVZIWJeUZWMIxxOOXeWegWD
        GVMGgxp3T+f4KRHOoJwWjFkRDkIRSflWGAHb4+lb2eynEaIldcJ2MTdXB2os4mig
        ==
X-ME-Sender: <xms:ZYdPYG1HYkFTI16PoKCZXgmHyd1vqn7Y4k5kXS1xgxB-o9MhBWmdoA>
    <xme:ZYdPYJFzdslplzQcEmQAXXuvnXJ5viM_42DclKTdeFIpqf059ycUDpJju0JFhLYpB
    HDkWzt5RAUGzeYCdfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ZYdPYO7ST3JKDRRLRtMSuG7U-5OKijBN21Yytrm82kvfJ2zjZpmG6w>
    <xmx:ZYdPYH0Pyn_UlIBhlmqhNdsppXH27kKx335d7RD7zVq-qgtaBESzbA>
    <xmx:ZYdPYJGqctxa_ZJwVlz8heHQi6Nubn-F2BnHcgxcd7lKNjgO1W297A>
    <xmx:ZodPYCP4MVeFUnlz9hR37wH3JtU_3LK5JWKmZv18UkUh9WJ7BznBCA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 77570240057;
        Mon, 15 Mar 2021 12:12:21 -0400 (EDT)
Date:   Mon, 15 Mar 2021 17:12:20 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v7 2/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <20210315161220.sxjkam7bqli5fk5y@gilmour>
References: <cover.1615713499.git.wilken.gottwalt@posteo.net>
 <bfd2b97307c2321b15c09683f4bd5e1fcc792f13.1615713499.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ugceib25g7u7yjue"
Content-Disposition: inline
In-Reply-To: <bfd2b97307c2321b15c09683f4bd5e1fcc792f13.1615713499.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ugceib25g7u7yjue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 14, 2021 at 10:31:13AM +0100, Wilken Gottwalt wrote:
> Adds the sun6i_hwspinlock driver for the hardware spinlock unit found in
> most of the sun6i compatible SoCs.
>=20
> This unit provides at least 32 spinlocks in hardware. The implementation
> supports 32, 64, 128 or 256 32bit registers. A lock can be taken by
> reading a register and released by writing a 0 to it. This driver
> supports all 4 spinlock setups, but for now only the first setup (32
> locks) seem to exist in available devices. This spinlock unit is shared
> between all ARM cores and the embedded companion core. All of them can
> take/release a lock with a single cycle operation. It can be used to
> sync access to devices shared by the ARM cores and the companion core.
>=20
> There are two ways to check if a lock is taken. The first way is to read
> a lock. If a 0 is returned, the lock was free and is taken now. If an 1
> is returned, the caller has to try again. Which means the lock is taken.
> The second way is to read a 32bit wide status register where every bit
> represents one of the 32 first locks. According to the datasheets this
> status register supports only the 32 first locks. This is the reason the
> first way (lock read/write) approach is used to be able to cover all 256
> locks in future devices. The driver also reports the amount of supported
> locks via debugfs.
>=20
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--ugceib25g7u7yjue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYE+HZAAKCRDj7w1vZxhR
xZCyAQCtg7NjcMB1RU9JypyxATYhgusZFieipCV1Sd853uzIMQEA2egEjSyiW/Uh
tMaNWeYMgwAqR1MqyO98rUGEbJaOHAk=
=RdjY
-----END PGP SIGNATURE-----

--ugceib25g7u7yjue--
