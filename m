Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC6D40357D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350835AbhIHHcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:32:00 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37901 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350882AbhIHHbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:31:53 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EBA685C0165;
        Wed,  8 Sep 2021 03:30:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 08 Sep 2021 03:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=AhjSdcZzJVpHUApECjOtLx6zfhV
        0eSPz14tr71nfvVs=; b=RyR0TcSeGGrQRWEe0fTfn5W+MtKgJteZNwHaO5OFpUr
        VawG0t2MKJTqqMdHqmvQ0RJAEqo6SNPnT5qbBVEihVielpTVNoq1nCW+YOWUxdcw
        XKWGymge93J/0u/zt8JkMz0HEzPCoC4n3Bh9L2fJHZmAHYUXUzha+0R45CyOu8zm
        Et6zWVTvJekbHRhMlxwSVacb1x/P/VmceFxJJs/DF2/czlMwQZN8G/o2PNCcqBV0
        skUx6ROLiwbCEjMGxg04EiWFjmrCPc/wO5BZIhudNBTUb60XrYX9V9YoRYHB46N6
        kt4K1fpSNVS8ncF4CEdfJf2BAr2T+ocz7ZrQYqbbcgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=AhjSdc
        ZzJVpHUApECjOtLx6zfhV0eSPz14tr71nfvVs=; b=YQMOAs2KZ6zT89+XgTVo6t
        8zEOdHRfMiKQrsTgID0xYSVKgtOwawkFd7ZTwy8538kjUh6kj5dxsS2JYTLQ6S3c
        iUdySX5LNnTfxz8gQa4Yn2j89yh5uv0EAE9fSwGIVK4KoF+Ffa/Gik5aNDVUr4+z
        gOhiRSPTZo+0R5xIME/gBa680/0qeERuGQ5gZ3xYBNA/swQ2k/hhc6NX5jTt+Pr0
        zZcurUoV9FkNaI1Pn2gOL5uJsFsabA84yi6oIgL2pwdrdcqG9HBCa2L3cEgVvqQJ
        0BvZst31ZHExFv0f3BN4iLiqbrqPWbYRFS1r9GVJUZNhUb3xFWeOf1bWR/PsKOUg
        ==
X-ME-Sender: <xms:pWY4YcZ4etunSOspUmf7IdswZO9ETqRPR2oaSRmu7PkcK5SJnH7CKg>
    <xme:pWY4YXZsJc5IUnFM3eswVj_8JNcZZOETjyiNlIZSu2RR3XxdbAOu_wKbBm_I_iqvb
    jYKkUvjwBdEIDNVpgU>
X-ME-Received: <xmr:pWY4YW-Kia15yVYsnDn66BVyOcWVzlIfv8iCCsXcajoHTvlP8V6kuBXCULQ-tn5A-BSmzQNkj22-sri91Pzbs6iPLsQzDX7TuwCr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:pWY4YWoXJ5siC8W1mZtgUtgrinU1BJ59IFrmgEbU5wb1fABoeX3QZg>
    <xmx:pWY4YXr4qezkaVdYWIqann5lfjzM_u3eEw8rprlGXfm7aEzhV6e7kA>
    <xmx:pWY4YUQE-9bNdOjh8lbYOt8U3DCHqJTEsMZIQPGgTQy0ixnHlP_5og>
    <xmx:pWY4YTIAO_qwmwLZ1jzdKqvhUV0yTEFhH-EwI_p49frUkscJZruKeA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 03:30:45 -0400 (EDT)
Date:   Wed, 8 Sep 2021 09:30:44 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun50i-a64: Make use of the helper
 function devm_platform_ioremap_resource()
Message-ID: <20210908073044.wbrss2cjxm2gqfj3@gilmour>
References: <20210907085158.4560-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wrbi6ufuz7auyo3k"
Content-Disposition: inline
In-Reply-To: <20210907085158.4560-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wrbi6ufuz7auyo3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 07, 2021 at 04:51:58PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied, thanks
Maxime

--wrbi6ufuz7auyo3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYThmpAAKCRDj7w1vZxhR
xesdAQCGrggdGJPK8Pu+XaUzJ/lAuI3tRHvC60hGXaPEPqMeDQD/bsiBwkeITkcz
p72/YsXZ4f3XIlpkv/Zr4Zjz/NB4CAY=
=BkCI
-----END PGP SIGNATURE-----

--wrbi6ufuz7auyo3k--
