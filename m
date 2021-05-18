Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55676387B74
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbhEROnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:43:20 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59471 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234454AbhEROnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:43:18 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 94D685C0078;
        Tue, 18 May 2021 10:42:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 18 May 2021 10:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=YgUnKWPLXtTSoYCrHJ7uD62GR8D
        CqNUmpuXjd/mwDI4=; b=D9+cnkyj+vegtUQEWXpO6E4Wgy9XmPwpTIS9PElobBn
        VF/ABDg2vXEsbWhvaHAmvI/g74e8XEPJQGmzOf0Zm0Am2/ckKB+Jd5/vSJlGK3c4
        yiY2lY9Q0SgrfcRxGT8dQQW2XTWLT6VxhHflH0llane6qNvaPARGdelQBn+3ciab
        pNs/quVwRci4lWOJHOZSGBfrBUX0ChIAE6PliREE+jhaN47gVgKeqjzZpRDAWOrd
        v6dXjArwc6Ih2Efyl9q1yGim0cyVMnR4sv2bZmE+iHfPxTKeVnzLz14dq8SCpK3+
        C3fbgBA37Z2U1mr3CWgrKQ0Z0e2mS5ecJTYsLVHJnIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=YgUnKW
        PLXtTSoYCrHJ7uD62GR8DCqNUmpuXjd/mwDI4=; b=wAOQQdv+tVRVQwuFkv7WXK
        DfxtfjYLLLrSOaUdEO1kT7orRY/oC/LHg+dfIbzzVFFm2L8pd0VpXspZGnDrtizg
        av/j1YYqM0KX/+Oc1h0S6fLPrxWL4ywZ0UaIiew2Wdc4UeLHeXdL7S6/Gh2QIx4k
        qvdwt27iKtrRrJSeWD/XqzUKsbW/MoJtBmKeKvAj3VCUPPa1IObchuCGvvL78UGO
        T3W8sVrKP8mQ5tReFj8FxupTB2VXVa4utseeVKBF2m6Ulx9rcy9Duim6l9QhQbUp
        DZW/MLfSX96OTtqSTf9rx2yC3TSQavPBYW2wJZYsLz8oWKRo+z/jslY4QZbPj9nw
        ==
X-ME-Sender: <xms:N9KjYJlJfsB2T-H10x1AwG1wV2OK4PLtoDCMxez740WmUF5-ctFvPQ>
    <xme:N9KjYE3o5jrX7NG1RX3iJOjdxDbKv-77gCKwbfbWFBVBsbga42_VDqTqI8joE03ds
    2yQBqZ3QjVuX23_Zx8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeijedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:N9KjYPpuYm1iOnYGcTTl9mhDv9q6ebMPFa9iaaYQAjk99pfVTXlk5g>
    <xmx:N9KjYJlI-WFQGat_P8Fvz8APiCrBJCpZhNLwCPx4LsxvK02ndm-5jw>
    <xmx:N9KjYH0jrYUcToU6QLNpP8fAxgrCEnxc-daF7haTD6M0uOEKoR0oAQ>
    <xmx:ONKjYH-mwp75cclVayJIuh1FcHhsFFto6uNIrdij2s_k8pbVvUhIUw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 18 May 2021 10:41:59 -0400 (EDT)
Date:   Tue, 18 May 2021 16:41:57 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ARM: dts: sun8i: v3s: add pwm controller to v3s
 dts
Message-ID: <20210518144157.27ahl5d6oo6ij2br@gilmour>
References: <20210513203527.2072090-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ohu52cazgyohwcuf"
Content-Disposition: inline
In-Reply-To: <20210513203527.2072090-1-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ohu52cazgyohwcuf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 13, 2021 at 10:35:25PM +0200, Tobias Schramm wrote:
> This patchset adds the pwm controller to the Allwinner V3s dts. The PWM
> controller is compatible with the one found in the Allwinner A20.
>=20
> This is v2 of this patchset.

Applied both, thanks
Maxime

--ohu52cazgyohwcuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKPSNQAKCRDj7w1vZxhR
xbY2AQDxrdAuccSfqaGj2NNOhoDEnXZ5EszygOkWwGpLuPi7dgD/ZhbZ8PR6DHgp
w/aINtgVz4zBL6EcN3eH7lrytRWGTA0=
=dHGb
-----END PGP SIGNATURE-----

--ohu52cazgyohwcuf--
