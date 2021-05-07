Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FB137614E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbhEGHlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:41:11 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46633 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231179AbhEGHlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:41:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E6275C0152;
        Fri,  7 May 2021 03:40:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 07 May 2021 03:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=vxtgl2McAVV4Jw7lpe9Bngye+Ah
        xY0xlZbs/obgITSg=; b=El0NYRpJvovz0M9RiRT0k1edhyFQYetbKH3ck9vKvp5
        PXhJT1RRFJ7VrtteF8FmUAMeog07mmet+i1Kovv2qZ2ONgjdFC2LiI2wBlqAIKKX
        yrjTEhj8sDeh39arEcZlObzed2RpOclikFBSSl3N68HnfIVMABiVECXWpFdE0ved
        VJzRg7+nPjjbi1S5PPMwTZckUXv8k4o6J6EmAKgnC8BJKlZJ0AJ+ZDHBIY4K0pPS
        LOTKu/4DHWBHYVfmiLyaZctqDZOV0JFj3Yg2SExEoUF65tCEnD+OqgbBuK9KPUeC
        xhdcl6/P99iSH/a9e4w5VafYQXTNdSlFS1d9JVjpEAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vxtgl2
        McAVV4Jw7lpe9Bngye+AhxY0xlZbs/obgITSg=; b=CQYVX4z7e+Tf3JnrdZCu6A
        hx/xik+iWENDo3LdsIBs9GnxavQmqnaO2B04suaoHYo4Vt5+qeGnq7citw0TZ1eS
        i5bwUr5Fd5HDSlMR13/34NYY9BJcFfThHkDd0U30l7fKfHEOE/lQ3ay/NJZguPp2
        /djQCTUQOxFrH5kgff1XRiLEbefyn97Cjq9XLUVluc3NePoI42kzJwkzLRNVJUS6
        eh5JjAwBEA2xzwdz9zHJ2EJngbf3gdQa8b6uFEppa/jSZMluoIrwImapF0KlxNUE
        HwRxc8S7cLGCkmAkoB50VgU44RKFEt46qgglTLBtjkIw+/aUAbm398IuJUvV4L9w
        ==
X-ME-Sender: <xms:2O6UYJj7DBFgHbr9q1awWOedcks6me9PoxAIVnDunIAU2PxFdzqXGg>
    <xme:2O6UYODLp_QipCJwUWPDKcbBJYvEyogYBeq545SbZs1GpJ_nNIjKgkfD1RhGwflwo
    OJGhCxSQX9xuY-HlSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeguddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:2O6UYJFmfRYze-CWtiH5YWLv4nIsr7-hLU35R8NApW23N5zGRAh5aw>
    <xmx:2O6UYORdGs5zYHEHgeZExHf_rZ7UEEydju48akN6f8nZJrif4k8Tjw>
    <xmx:2O6UYGyWCPQ2pHCPbuEqk5InyOP204SXKKYUlmeQkz5kVdqDCTHNjQ>
    <xmx:2u6UYNqpzEL057eT3nnNty6CWv-Sxi8mtMTuWOAq56i4fibxsGgsDw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri,  7 May 2021 03:40:08 -0400 (EDT)
Date:   Fri, 7 May 2021 09:40:05 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: arm: Add NanoPi R1S H5
Message-ID: <20210507074005.5ketudguwwotb565@gilmour>
References: <20210503143202.21795-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bqg4xlznz6dubgdk"
Content-Disposition: inline
In-Reply-To: <20210503143202.21795-1-amadeus@jmu.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bqg4xlznz6dubgdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 03, 2021 at 10:32:02PM +0800, Chukun Pan wrote:
> Add the bindings for NanoPi R1S H5 board.
>=20
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Queued both for 5.14, thanks!
Maxime

--bqg4xlznz6dubgdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYJTu1QAKCRDj7w1vZxhR
xQU8AQC5vNRplJCV9ITr25E1YS+GAOC9mHQlf3Qym2xPcDm5VwD/bGE8CxUnXyUJ
xC7PCminS+6oMkRvtqVKP+YTz7TTgAY=
=95jW
-----END PGP SIGNATURE-----

--bqg4xlznz6dubgdk--
