Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884F840359E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350520AbhIHHkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:40:02 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41679 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350174AbhIHHj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:39:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EC2725C017C;
        Wed,  8 Sep 2021 03:38:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Sep 2021 03:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=eY9e3KHvImSnOcly/mgefvGxXsz
        urR1QnYbyWlk8BAY=; b=j1RHEjTfDs+LIMAvs3Pp3IzH2wEoHTLg5+DUD+C62fn
        14aMV8JawnsUQ3xCq7aT8hAhlfaTDFhwxgiUiICNbVW5XDx8QW5szCGNIx5Pd6mz
        rQDP4FBGdpHQu2FQD2y4v2gr1bA74RrVTwNTlW3ZcjPaLl5qw08edKmqpxhgaWOF
        w/pHbMPQSt6TguBqOuKnNREqWThURw2ujIJ0rjSdBnQS0yIZdFhPIZcO0lHAXw0H
        bW1y5AJzHlZGeDhekYlL/9rnwdjByfXmcYuTEQJWdt9b89WUevtIR2UEkdiqQUs5
        pFrb1sB80RKajzm6MceshNVgvaQhEvFh9vtBGscOlWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=eY9e3K
        HvImSnOcly/mgefvGxXszurR1QnYbyWlk8BAY=; b=lTd07EADpZlJ7Is8FFCQnL
        nUPcT0Tvks52flu/YVXIJqQGIAMln2w57XoPfRqlkAk6Sz7ORtz7xF85mMRhdmwW
        vkyzGJ+r4ocUieaVeMMGBdeMDtXdNe16sAumqjQ+JTBGNnjd+krPrza9LxtKcAzi
        TTcRSxF0oHMdbeF+ciV7V663u+mSPLeYUG+BB8Z+qz+juwHe0tFR6VAmdbDRDyg1
        AJucffZPTYnwwXo9BQolYMxXLJzDa/8AWked30UwH8XcJvazoBOtTa9HlWCEvtiJ
        p/sqvoNEWCHU1tYmFPeIaZDL/OdKKfycjmEc1uMBhpUoj41x+ATJCGai3S8tot7g
        ==
X-ME-Sender: <xms:iWg4YYilmkPWFJGzWo0sYCFpwWJkPWJ5uhOta5GvN4DI9iml-_aG9A>
    <xme:iWg4YRDH5or7LcxGr4lzUEGYt_V_SeLwug_2T18qDToIF4yuDKYxdK_Yf7R-NmLOu
    _mW8tSkWxW_Aq85ffs>
X-ME-Received: <xmr:iWg4YQF6O9XbcWJaEHAoCIuviB4vl5GXaj-__xP8EZq1ytNJyHm3o2YnEGPqvHceAeBpLU4lRzaL0jBM2HaOGQfWA3Fs9_Nn-Rkk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:iWg4YZREv9XRVbEQEQ5tr4rQjOK_lN5AFebI4EprTXwYURHPDwH5Bg>
    <xmx:iWg4YVzvwKaCmQL_cXPJJDaf79aZLxA32eCY4gyFFEfghOJDnaWDFg>
    <xmx:iWg4YX4u6UgZpqxdzJselJLNKEIH7Kr_MTnGKLn8ZOYGGqhBPimYYw>
    <xmx:i2g4YXuZveOxAObP646JkT6YYt2JY9iDHhWWD-zk3JCNOaL_aMMQjw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 03:38:49 -0400 (EDT)
Date:   Wed, 8 Sep 2021 09:38:48 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: sunxi_sram: Make use of the helper function
 devm_platform_ioremap_resource()
Message-ID: <20210908073848.prn2exktfcozputt@gilmour>
References: <20210908071716.772-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rssfxldbfmegsqom"
Content-Disposition: inline
In-Reply-To: <20210908071716.772-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rssfxldbfmegsqom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 08, 2021 at 03:17:15PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied, thanks
Maxime

--rssfxldbfmegsqom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYThoiAAKCRDj7w1vZxhR
xdi6AQCw/YNF5oM5VY6/a/WeE0h2X2pWXX17mFDcWOVv0suIeQD9F3YnP67aw83e
sphwY0wv9TCVqtO5WcizO0kJ1kCOYAc=
=Gcia
-----END PGP SIGNATURE-----

--rssfxldbfmegsqom--
