Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE84733B078
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhCOK62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:58:28 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:36581 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhCOK56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:57:58 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 10534580A01;
        Mon, 15 Mar 2021 06:57:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 15 Mar 2021 06:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=wWPFpRcTbfUYJw3V5FoYwoWbKzf
        lwHa42zjUJms/VmI=; b=pbJBTPv4p0yeEFUkBNifdfshAIOAdrYaZL75tDdfKDt
        cIIMLneFpizIPChw3WvW+QLZf5BGTPXOOTwp5JiOCbGGXkcJWgZi6Ejx2UPZLqMM
        1pN4z58pTF9B+8z3IgPt649WTrNq5h0dfeXpIimuLogyaceNPDikacWBZCYUt4AU
        LF69/1Fsq8gfFs6+FE7Jz657dqJYK0cmMb+5jw3xjnJ5u8YJZSXRZUY2GrwWsivn
        wPljXL2Eugy39v7k43dj0ZJtVU5RjFRp2ZTSNSUDthAYNzY38qqMLMz4LE72MoUx
        SSczUIryZbwoIcnhl5VI6A9JZ3CVA3mz4cg+Rvm7EuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wWPFpR
        cTbfUYJw3V5FoYwoWbKzflwHa42zjUJms/VmI=; b=EbedVMcoQgT0EC8Rx6pRxj
        D+89meVLJg1e8Y+/P5luMXQhQ4JywX7EdeiixpqRwFzgqN2aozz8d1XQ8kezWmnA
        JqZQmBNNO0lCOqo/xcz7cCEXU0PrKD98B2dmjBwtzt0YFJkjy04YQ6JCfrsS6STQ
        f0Jy6LkbUuQRzQ5DHpMV0VKQak75fm4JCj13irDpDtmI9W9OrkDFKrQjYHF3mhv9
        ZIxP5mrNKBdnLfOiNmw1io+P2flxtjz7Rt5d3WJVNvK9e9Gxg7p8h1dteK1p5UW9
        SAymVVPd8wSV/MmrnSNoKJxcp+LPn7AOdfinx+v6jb1UYMk86CdTR8YnW6jbOqNQ
        ==
X-ME-Sender: <xms:tD1PYDN5Y0rznMPIxN2oNbBt8fmQfZ1IR37fJKFDWh3Ntr7wpVtRzQ>
    <xme:tD1PYN-IOEj9eyCvkKPhHHkUHxnXwTQWx9uQmdaS2LXe2xhybspK2SNpcD7yDiNrW
    SUW1xHOULkD8GoAHyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:tD1PYCT5_hEv5UUnGV2wAf1Xcj_AvPuWbfQRL-ODhCWqZqwUhoQzRA>
    <xmx:tD1PYHvYeedGqIS5IdDjK3s1uCwcxJrIoMuG9rXO8zyWPX8K1Ysh2Q>
    <xmx:tD1PYLdyB39y7iytOjoexjASpqY9k2RCHfLrw-qaoBQdS788HL-T0w>
    <xmx:tj1PYKxyrisK2Mu5TskRmhqEWXeLqV3OHeheeE1L4AYDVv-ubpiHtQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 52F6C24005B;
        Mon, 15 Mar 2021 06:57:56 -0400 (EDT)
Date:   Mon, 15 Mar 2021 11:57:53 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: timer: Simplify conditional expressions
Message-ID: <20210315105753.lgkc66nwwvby7dmt@gilmour>
References: <20210315043250.45095-1-samuel@sholland.org>
 <20210315043250.45095-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vfoklvg7svqlei4f"
Content-Disposition: inline
In-Reply-To: <20210315043250.45095-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vfoklvg7svqlei4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 14, 2021 at 11:32:46PM -0500, Samuel Holland wrote:
> The sun4i timer IP block has a variable number of interrupts based on
> the compatible. Use enums to combine the two sections for the existing
> 3-interrupt variants, and to simplify adding new compatible strings.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Thanks!
Maxime

--vfoklvg7svqlei4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYE89sQAKCRDj7w1vZxhR
xZrgAP9GcBp645D4PdV212rKQGYA1TqxEoanGnnxW1cyS9ZQngD/SBxuJ/3pux/J
GPEXi4AEBvbRhe24ia1EPUXKPqo0Yw8=
=xnu4
-----END PGP SIGNATURE-----

--vfoklvg7svqlei4f--
