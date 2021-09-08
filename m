Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C4340356A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350346AbhIHHbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:31:19 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52155 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350345AbhIHHbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:31:14 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EF9735C0062;
        Wed,  8 Sep 2021 03:30:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 08 Sep 2021 03:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=b7y9saj5kGHmJfNK19eut4/7GV1
        ZeaQ2fktuAROazNw=; b=1PEiHEMu/lrx6rJFofmQYF0TgyS4LtwqpgwevBnwiFR
        jGTm2vkYtBmq0JYBpjGXdB/E12swBMAJRHPxv818Qqa5HnQ77Uoc9HSQbdcqAdxa
        /JT5NXFL/MSx5u9uH9cZ+PnZVLoGpyLvAYAn3a4NGw4WDuhpvax2JnxgFgSuaAe7
        bOT3RT9joGhflUJGCPDJrSkROwrSo39RbClJf0LmjIsumlmgBzqhhyedX2qPr1xU
        r3KVVtU5i9jTUQT9huS+CiKFUOsQTFLM1tXibpY/jfcR7XMlrFsQUQzuqsM3NtzE
        oxWvnIrjVMSz14bri3nWgBwndkML++FI0mUDYBmAIrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=b7y9sa
        j5kGHmJfNK19eut4/7GV1ZeaQ2fktuAROazNw=; b=ahd7kntbEpeDXw2lWRSCRe
        SeM+SUNuHu03rEKctaw5q5liGXfFgUORvr0CSWNZD+KDtCBUnN1JOhk7SI14U4Vr
        7IisIurObgWzYHl1o1Ui8FegjQC7iP8EZlfbnOw9FPr+Woj50A7q+KpOC/izs4GX
        lQBRn+BffEoV83plKlRikxtD7M4BUac2sA0Nysb3Q8pG7M/41YegXEgNZh13btWV
        zS/1iWPbYbJLFE64+varbszf0S4K5+KderLkEC+DjZe2Fu98QMCrg0HAVpCKt6We
        6fFzu+WJEby/RcibuorsteIFA4rvA3yonTr0ANiBOJnP1phmwDAmRaC8XEtWga9Q
        ==
X-ME-Sender: <xms:fGY4YebZp-Jip95RTx8MbWC3wAFioEKlKR_4J8TXtq7paL1Go1WS8Q>
    <xme:fGY4YRaHOutStKaBVSsX3q65UkCpz5k9pWuGaXbqqZBn1tlTpPZ7gTx24gSOKW1ie
    YBYjTzxxroTfdgykrk>
X-ME-Received: <xmr:fGY4YY-g8VCSXc_QnAM-8djTNhiQRVN3Ibv5a8YGsLZzLbTwco3fBnJ-ouU6rMMoLYnk3vinScrT1JzNYBQmbM0E27jsZpiDuMuV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:fGY4YQpD2dfFmfMrXyyv7sJMUXAw5pnZaUI4bIBgM9mbQk9NQ3GxIw>
    <xmx:fGY4YZpLOM9XEa1GWihnGelJMfojOjtrdAo47tJ6jN6dMChgFaVgrg>
    <xmx:fGY4YeQow40F4xatP62gQh2nF4x5QSqen3unyOAHtRFkB6PPlKf3jQ>
    <xmx:fmY4YdICTJdtFz7CfOpHdGJ0gOEwtGQLMMIEDaG2Mfawt0LmRO1rgg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 03:30:04 -0400 (EDT)
Date:   Wed, 8 Sep 2021 09:30:03 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun8i-r40: Make use of the helper
 function devm_platform_ioremap_resource()
Message-ID: <20210908073003.4clznohf77bawp5k@gilmour>
References: <20210907085228.4764-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pih5hnc7rw427asp"
Content-Disposition: inline
In-Reply-To: <20210907085228.4764-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pih5hnc7rw427asp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 07, 2021 at 04:52:27PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied, thanks
Maxime

--pih5hnc7rw427asp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYThmewAKCRDj7w1vZxhR
xds8AP0b63EeG06NbkDlpLUqW1fcCNwBEOeTx6fo605FRjSmxgD/aYLc70zSyfFN
KGwJkGvunx8j3mb7OhY5DBbQPR33dwo=
=MUIS
-----END PGP SIGNATURE-----

--pih5hnc7rw427asp--
