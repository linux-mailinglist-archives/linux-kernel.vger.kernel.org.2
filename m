Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBCB387A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349752AbhERODO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:03:14 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:53471 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243387AbhERODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:03:12 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 86CF2580878;
        Tue, 18 May 2021 10:01:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 18 May 2021 10:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=tumDBNM0tP3GJxTwoYkjqGN4sQX
        Y/e1OyHHo1mpv+50=; b=crUA9va//nADA9a/kKFlyx3pIILpAZsM6hi2VbMQmPp
        F4ZcV4nDi/3KHbm57RIS3qlUbOdevIOWzClUaMp4bgBAoZJH2cSp7bvu6C6XbNzI
        OJtqUr/Z8uOqmuBcNoPm3S0bJdilgjwXxnm4Rm/IVZzAOXJ/lceZs6vcYZ4VyW1K
        9icDU33aOet4Y3ATdk7xtOMomKAKytsSiO2VfwXqGud5BOuNrjZMJV4u2ZCxPiWl
        axelen0hiPtDUtPxIT4UVgotASi+4EEkPqBrpEwCY1/tc2CLTfpb7sPMoU7ZsHBJ
        FQ1gNvBYtrnoTzT9xKbBtxW5QY324vesQ5VkUBV6elQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=tumDBN
        M0tP3GJxTwoYkjqGN4sQXY/e1OyHHo1mpv+50=; b=SqRPrDx8sWUxvxvTv4v1aw
        qd+OJBjyZRMLgaLrMpxWm5CV38E1BryXbdx7ci3z3tfAyc4AfVYFLObE0zXyqniw
        s/nqh2WjGexUmug9PqGCXgCm1++0R5WfILM2b7zTWgKIFFy3kjWJft1o+ttuuz+a
        q3u+ZWJ/48eXo+xhiVaHliyt/d8kZc8rw8vLWayUzBkqSCwnoaLyRTLKWL9gTPdb
        GcRU+AB4E4SYCyWOZ/SXLc4InrgBtvCHs4V/pErprdE7/rOUmg3Zm6bSzqk5oc0s
        Ngv+WY+6iXa4B0nfv1JH7r75Y7tXO86f9kSk8n6lqU0wS68iLa4fWJ9Bjugl7a9g
        ==
X-ME-Sender: <xms:z8ijYLux5nESSG4Xenzh773L8unz2ZArZ1SKnUStpFVDMmZrxFL6VQ>
    <xme:z8ijYMfKQQ3_RXyzZ4fqdw9K59eSeNCaK53M2-TQMag2kgQsKSiyuwxQE4izJ8xZL
    gr9mocTgsdSnUePavs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeijedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeelkeeghefhuddtleejgfeljeffhe
    ffgfeijefhgfeufefhtdevteegheeiheegudenucfkphepledtrdekledrieekrdejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:z8ijYOx4BjoVWQ1stc1KEWTVLPkH6vFUOhEpD7VDEZK9pEwXA4bKxA>
    <xmx:z8ijYKPw2OsJJ0cgHh8O7_JhiDSCvAqX7RuHkRkLseMsSnoAK_Y_QQ>
    <xmx:z8ijYL-rGMDqIDAZoH3CvrflrQPKB_ybKOCoWmCrHRUSrnzOoIGRYQ>
    <xmx:0cijYHR0NUvNk0yLiI_gPh_efkpIpPpUQt48Kj4jVYdearqeQvnoDg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 18 May 2021 10:01:51 -0400 (EDT)
Date:   Tue, 18 May 2021 16:01:49 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chukun Pan <amadeus@jmu.edu.cn>
Cc:     devicetree@vger.kernel.org, jernej.skrabec@siol.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, lkft-triage@lists.linaro.org,
        naresh.kamboju@linaro.org, regressions@lists.linux.dev,
        robh+dt@kernel.org, wens@csie.org
Subject: Re: [PATCH v2 0/2] Add support for NanoPi R1S H5
Message-ID: <20210518140149.4lpvvmfvufebchac@gilmour>
References: <20210511081823.mmcrliomwtetcirx@gilmour>
 <20210516163523.9484-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gtpoixaleejdo5hb"
Content-Disposition: inline
In-Reply-To: <20210516163523.9484-1-amadeus@jmu.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gtpoixaleejdo5hb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 17, 2021 at 12:35:21AM +0800, Chukun Pan wrote:
> I'm very sorry for the compilation error caused by the patches I sent
> before, now fixed it.
>=20
> Changes from v2:
> * Added missing header file in the dts.
> * Collected acked-by.

Applied both, thanks

--gtpoixaleejdo5hb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYKPIzAAKCRDj7w1vZxhR
xV+3AP9VuZsCtFhqKzMzQGVpSmuZ2Zv/k2K98GmhWljqdsig7QEA9txlhHi18QuC
462F4G4kKbTw0ht3kaAP/fYHNiCKHww=
=/9M9
-----END PGP SIGNATURE-----

--gtpoixaleejdo5hb--
