Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4740357F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350974AbhIHHc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:32:26 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48555 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351110AbhIHHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:32:03 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id A7EA55C009C;
        Wed,  8 Sep 2021 03:30:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 08 Sep 2021 03:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ru8zIgLJoL4TPYjDkOzs2YebZto
        s1J1iJcYKL6jnhvs=; b=nDHTPZ2a4eAV+TnO81h0Pt/y89FajN12VxhBvz6abKe
        Sx/MJL8L5ZR9aQwG3hGlqVRIYAPLYabHrYalmC7PR6c47HgXentlRfeMy0dyZcg0
        CW5URjGpGZyTwC4PURnb2LXrh897sLRipvFcoyZmeIvMUIBuIewJEPIap3mKPFmV
        +hLagmcuTaI01hGeZpG8fYs71kNCjdCTmqgXjpBkcNeso2lvFGwR1ao3dUgQP2m0
        MWk5QOYzD7wg1xifMzh43RfFxn0CT91pSrJe/FI84f+DHwD3vNPbXwJeggponavY
        FeMCs1+O1LfC1UZrcT/VXOevNHWFfWd74D9Gtt5hptA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ru8zIg
        LJoL4TPYjDkOzs2YebZtos1J1iJcYKL6jnhvs=; b=N20mCIkKOEWodAPL3o91v2
        MKbyfHUvRPiXj3HaU+rKTeroihiVvBoq13rt2hfCz7h0I1yEPfK6XMp507bsRyYx
        4Zm+kdfCJd/znK00BTOa1TxumRTzgbalqBfTi30bhzUx04UVtlCcRuTE9IVZzSCX
        5ptr7Ldd+GAqhdKCHr+PBJVsHu+n2p33fT0zuQTwUVEPXfH8z8dRWC54elqwlOiv
        ik1FtHPcFtj5V10vfjzuwI528Su4zNlg9YTOqo9EQ0nXv++dXF64DBRNDXpW9naT
        07ZP7WYglFOwGmYznUFpeYWbRm2f6zH6F4bpnMu5Zp51YOrA7YZVPQg5KBuQ2e2Q
        ==
X-ME-Sender: <xms:rmY4YfeYhxuhnaIvyreVthYXfSP6T2GT9eiknb8NVQwZQ2AV8EQOQQ>
    <xme:rmY4YVMn1Ak3iXDMpfi770QoDKoJljDZbJEDwZIqSR-PcY-fVv9j7W3DNSMparDN3
    WRpJ0mn5Edh5mySRkI>
X-ME-Received: <xmr:rmY4YYiojfwsPQcHsplADeq9EVvRSyyZtTQUPvIo27M3-DlvTMBzBpc8-2-v2MlZ_yLDrnCX-WSE6h95J_xeXfns9K4A_ntDS-vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:rmY4YQ9e_l8sZIACq8n7JMuuj_epOwB5B6xNnkN4nlzcUIrAb-pdsQ>
    <xmx:rmY4YbtK51sPsn4q6pJjxfdwSFuhd6r_G98Fs5osR0RyNKQzdexi8Q>
    <xmx:rmY4YfFv6X3f6IBeCBz9ckwMuywncEJFkKVUCIuZciIse2m3CTc01w>
    <xmx:r2Y4YRDDl9DQ7LVi4Mu5KCaY-6fAp4Pk8ZTP0Vf7SlOQKnb5yhIjXw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 03:30:53 -0400 (EDT)
Date:   Wed, 8 Sep 2021 09:30:52 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Emilio =?utf-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi: clk-mod0: Make use of the helper function
 devm_platform_ioremap_resource()
Message-ID: <20210908073052.7so5p7igld4dz5sz@gilmour>
References: <20210907085151.4509-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hrlvsziplbud4bok"
Content-Disposition: inline
In-Reply-To: <20210907085151.4509-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hrlvsziplbud4bok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 07, 2021 at 04:51:50PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied, thanks
Maxime

--hrlvsziplbud4bok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYThmrAAKCRDj7w1vZxhR
xSzxAP9re+B83qmtdOIWYJcWt1DQuMDdgHzC4qi4OI4ER3/qoAD/c4ejWLc0lX3J
OUolC8acE0TQyvY3KBs/4fQFWeKK4gw=
=ht/i
-----END PGP SIGNATURE-----

--hrlvsziplbud4bok--
