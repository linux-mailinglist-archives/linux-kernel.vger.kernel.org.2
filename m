Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9171D40032B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbhICQWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:22:34 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44005 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349624AbhICQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:22:33 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4DF875C0045;
        Fri,  3 Sep 2021 12:21:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 03 Sep 2021 12:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=BhFvsBDYgdIUZQDlF11XLS4+MMn
        v4O04RCaT0WttSd4=; b=HsIX9f5NkEbmCKEPbfhN+LdlMO6z9n2Pa0V40f9A32n
        BBW4lRiuKQQTHjyNvap51KUe3l16b4tINHArQFiZT3DlcAmkgc11TwJfyGQTmdMl
        ihPO4/ykEBW2ZwWQau7bqPPYgpJrv0VwivmOsY6QUzxv7dTYZ5n9cW2yHyV0xfv2
        YP1Nc2DNm78gjuyqUOkFhPvAIAT80SaeTDojhXYXOje1v9BK5Z66PyVpbXuPPXhS
        jLPO26oJInedczad+rP++9beOMdYXVplKQETSAjeeMG8AVqUJaI/qWcfYqbHP7l3
        +3/W60SRw72PphcaiJneUYakAn7V24LE5pD0X6/VB4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=BhFvsB
        DYgdIUZQDlF11XLS4+MMnv4O04RCaT0WttSd4=; b=ujWnbVJ6NHWzrx1TsMOUWU
        729x2AyfCtyhJhF245qk63ODbU/W/X8yxDxfWcdePRjlWDQH+ZG/sYT3RM0A/xvT
        vq4z/yabbVEjfMxIN2iGXu73vNCAmkVPbPv1pNtqf7AYN3oKXQJDR4f00CmTuiTR
        ZyZ8POmGdGg0xTwfvEeAFaj5cl3L18oYcoQXVZkFcvMxlgiQqlXDTC0bK9LLMAzU
        /KZLEJQYCj/J0ntkntVYwGPqY0kSiGxm/G6qLWyGvv8w5sM3ki1qWFYvZ6cQLy6P
        +xhva4Q/aIzkrEz00CYeYRcO8ZOLdxuvTuYzG/k7eVbo2sgjEjp8rtMlcn4m5S1Q
        ==
X-ME-Sender: <xms:iksyYefmkB7u4rzd_gkmxA7U1M_rakzkfIfX4GkSUJCqN5n4phQcag>
    <xme:iksyYYP2D6qiKy30iwnKpmnYG_C-Q8VAsS9BHz3Y1Q6BJ517KVsjW1u85gESOZ7kU
    86vI80OLAXg8cPnYxw>
X-ME-Received: <xmr:iksyYfj_aZKcy5KL5ZnM8PIir5MGfkD_Jc3ZQJJezdlhRiacJy6cyoUcO4_yZsnDo2sxPpNGZFzug93k-vQSE1MnDzyAwOlYzRwH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepveevfeffudeviedtgeethffhteeuffetfeffvdehvedvheetteehvdelfffg
    jedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:iksyYb84nuB71ckXuxD9MTjSLIerzysz8gwRVTxb4VP9HUTk_3gL6Q>
    <xmx:iksyYauHsfjGmyi2rUHf2h9bJ2JbJpjUBtW6yNmuCyMJdYeti6zuIg>
    <xmx:iksyYSECBUCsWOzjWU0oMCbeOmCavpboycLM_nxFuLSE4BydfiWydg>
    <xmx:i0syYejTsdAYVQIzcEQUDpVdlgt945NYbRQ7N1vZNgounDSAQR-d7g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Sep 2021 12:21:30 -0400 (EDT)
Date:   Fri, 3 Sep 2021 18:21:27 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: allwinner: h5: align operating-points
 table name with dtschema
Message-ID: <20210903162127.zql7fbrhwyblujhw@gilmour>
References: <20210820081645.83796-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kfy4x7ot25dote7l"
Content-Disposition: inline
In-Reply-To: <20210820081645.83796-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kfy4x7ot25dote7l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 20, 2021 at 10:16:44AM +0200, Krzysztof Kozlowski wrote:
> Align the name of operating-points node to dtschema to fix warnings like:
>=20
>   arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dt.yaml:
>     cpu-opp-table: $nodename:0: 'cpu-opp-table' does not match '^opp-tabl=
e(-[a-z0-9]+)?$'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

I already sent those patches a few weeks ago:
https://lore.kernel.org/linux-arm-kernel/20210721140424.725744-43-maxime@ce=
rno.tech/
https://lore.kernel.org/linux-arm-kernel/20210721140424.725744-48-maxime@ce=
rno.tech/
https://lore.kernel.org/linux-arm-kernel/20210721140424.725744-50-maxime@ce=
rno.tech/

I sent a v2 last week, and will merge them soon

Thanks!
Maxime

--kfy4x7ot25dote7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYTJLhwAKCRDj7w1vZxhR
xe3aAP4sPVBAWRhV7R3IOPEjEn5XORabXHjGBK03SzIzEJv47gD+O4r/P8gHB7Qt
K9RVKxf1fu61axMjWkFhgJ0Xr3QuVA0=
=qXpc
-----END PGP SIGNATURE-----

--kfy4x7ot25dote7l--
