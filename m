Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E73F40355E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349979AbhIHHak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:30:40 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39431 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347394AbhIHHaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:30:23 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id AFA805C0062;
        Wed,  8 Sep 2021 03:29:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 08 Sep 2021 03:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=JyIY7LLLKDpX9pnjriGKO930fsO
        S2X5CNjbT+mGzV6Q=; b=nmLinrYTPILobrMFeFbt2GAObqE2CzGlZU/znITYXLC
        IqSAjz7deM36ZT+hcv0+24vY1s37mSIItSQFdIgQD1MQPRcbnIvUa5aNVdp0y/RP
        vDD6vfBo3VmPJUR5w/e+1zUugifz0try0Y744/nJ/8seHPz0bSaFlT2Wa+z9qGaD
        AwvkWsqRYLAKpMZ1leIMiCYq/nm+03GGNvFpGmwsOE6z3OMSHpV6SMIlS5yX7wxB
        bGC4c2aCiSsIo0b8aDlKPyxFwVdLjhXjzDJPhfyh11viSmoltcAJAeTY8rhnY9FT
        YOvDr1fIGIdfNa4XxgcNVPveVOFyXKGFEssxZexr7qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JyIY7L
        LLKDpX9pnjriGKO930fsOS2X5CNjbT+mGzV6Q=; b=eyBuzq1Y2EAjrwsEanYLzo
        8J5Rgprmy3l2hbxg54ebqGUtEBC3hLRwHuvyRjGq7JhaA2fybJWmadFmPeKYgTar
        gYzNfXhpCMJo/Wx2acMJKY9dy4Ep/zRbJveELbwT094R+dMQ652YrFwL5mKJuyti
        TzleXt4XdyJizw6N/cC9StEKDYU8nNThWIlA6WxsWj9iLQCJP7T1JYR6CDTukeBH
        Ep8sdXj5TFasH8BeaeGFZ4HZyKXKCZVdiOAeIGvAvhPR6QtdVtdQY0UjX8v+M+vp
        AyC2JYqMZYuzLltQEbWhIGVTWxoU8V3VRLWxJiwEnc0XwlZMFbtc8tQBO2Ls05uQ
        ==
X-ME-Sender: <xms:SmY4YQGq5gAHUT7_SasaEqtK_XUzO0QZo6y61JKj02se9vWaeusIOQ>
    <xme:SmY4YZVk1X2QFp7StYyB17sS-bcU_LfRDjSmr_tfLa3C-5_ZQQ8PPau3t245sFQuA
    HdekRW-mRWpFV8L3YA>
X-ME-Received: <xmr:SmY4YaIJ9jI-r5O7R8cMYX1BONE-G3b9dqVOmRTwEeAWVx6_71YXxxHvkrGQ_n5trFkG2moNl11WRHrHszHidtHtUyi_ji-Nh8eK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SmY4YSESpWGja5_Z1K-Cl3TwnVCQsUDULnlYQYHwA9_dcLAqyvP6RQ>
    <xmx:SmY4YWUiQnJHIFQfYvWozS_qozYpkXuSuPAQJL43eIpZFhYBlBbrDg>
    <xmx:SmY4YVP_Ed1prV7nj3S0UIqOrSMr0nqs4TrhAnhbkIWr6XLtgrBXxw>
    <xmx:S2Y4YaqeojFTXYfwvl72WwzH8AdJxpFEXohnPf6x6mSunFP7vc-E5Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 03:29:14 -0400 (EDT)
Date:   Wed, 8 Sep 2021 09:29:13 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Emilio =?utf-8?B?TMOzcGV6?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi: sun6i-apb0-gates: Make use of the helper
 function devm_platform_ioremap_resource()
Message-ID: <20210908072913.wrskonjex6yiabci@gilmour>
References: <20210907085305.5019-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="raqwvug4epguxb3u"
Content-Disposition: inline
In-Reply-To: <20210907085305.5019-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--raqwvug4epguxb3u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 07, 2021 at 04:53:04PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied, thanks
Maxime

--raqwvug4epguxb3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYThmSQAKCRDj7w1vZxhR
xZd0AQDV2Q2V1XRXmVkuTmYjd4tcJGwBS9YiOgmhk5o+nsAzlQD8DvbYRM+ZuIPj
sOg+jq5PHd0OXs5HfOADqXMkylpi1wo=
=uAYf
-----END PGP SIGNATURE-----

--raqwvug4epguxb3u--
