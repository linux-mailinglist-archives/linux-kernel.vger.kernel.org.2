Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C3840A8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhINH4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:56:47 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:46107 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229477AbhINH4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:56:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 3E6482B01267;
        Tue, 14 Sep 2021 03:55:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 14 Sep 2021 03:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=tv1B24UNRY5R7MO+atvnFCDCyGV
        7pIAhheev5cAuHfs=; b=q2dzYt6kmjOcOq7BBfAvsYuTnW0caGcPFQZui19YRgF
        N4PLjue7QVRICtASimeWF2cA79llRQw7MFiwVloZHiOceTrZblvib7LMEtfRwuXy
        OimCSDAgV2/FvUqmS+tbaSwgGwJoSdKsZhq7zsDzjKpxONcbFnMne8Kq7JRYuLhQ
        +Xxbptz2z9z4HAZq8dUPP0poz9L6hPX8wfXX1C3nMVmzeMtAVbHMWLGxVQ92SWC8
        Sd+EZf6KQGcZwYIz93UODZb4aMOqGkExGwvQBAAFVZbI+3hHfLt/Vj/twoFFUvXO
        xYh6O5X0GWE+C/mVe/5jRUFSCE6H6+dJdPgc0ez1Lug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=tv1B24
        UNRY5R7MO+atvnFCDCyGV7pIAhheev5cAuHfs=; b=pVMGrj1F9OWPohBpq35pUE
        KaJSC/Xzd0GdbaaXvY9FL9dCdEk0rtLeHLzJQZki45dddxRCqu7lL1/dWYgq61Yl
        SVowWkKlwPsROkcQl5XIzp/KweZiHY1iir2eLbDGdlVzoviIwE0P5wTsRzjhZ5oB
        NiY/3LlbNSmdmep8k00KeXeAo3cksCdYXJkaqriZ7iHmxxy3sx6GY/sGGDltZphH
        DxrKLxrOTSE3onmMsrUBlzUwA29IumW/BbY+f0z1pOKDzRdx6r3PqorQpZgA5/VW
        dib83Aa4e1siW7fWwrQo2ZTkQKwK2STRbz/Z9fJzAIYLQR3TXLrwLBEOf80OcNWg
        ==
X-ME-Sender: <xms:bVVAYWpMwTPplY-Jm27Ldg7Pnkz3N5BclGf626BHeWB8wEFwPFXCEA>
    <xme:bVVAYUrholmyylM8SLt1FpebyvpCh5JhJQ9hb1_ffxKzE_tZ-z7yVzQyUvXZCRDa2
    yB6CTBEjd8WqQjtKmk>
X-ME-Received: <xmr:bVVAYbPAWlR_P0rYAfn9W8gnakkhbdzYfX1g7k2AeuOWpcXCwxC1hpGjGLF02yjWvJ46t2ivRDLxbRgngPQoINTdsrKji3Vy2mnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegkedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:bVVAYV5KrJf9LKmElv5qs-5BdwIiew8zYkIn3LfgsVLassAePFs0rg>
    <xmx:bVVAYV7iF65aWq-E9LN1vtuC-v8eYy1TmDLuhwS4fn3c_3UZU95aEw>
    <xmx:bVVAYVhyGknzWKhxj4mybmlGI5jZMJsQW_hJ2yeMIMq-HfSS54Qn7g>
    <xmx:b1VAYURCG4H9PvqdhIw7hePpBhdlhkAL35Y7_jT5ZH19Y8xhl1BS896oPgk>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 03:55:25 -0400 (EDT)
Date:   Tue, 14 Sep 2021 09:55:23 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        bcm-kernel-feedback-list@broadcom.com,
        Emma Anholt <emma@anholt.net>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH v3 0/6] drm/vc4: hdmi: Fix CEC access while disabled
Message-ID: <20210914075523.nit6lznlpasb7pxy@gilmour>
References: <20210819135931.895976-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zf5mccuff24ckjqq"
Content-Disposition: inline
In-Reply-To: <20210819135931.895976-1-maxime@cerno.tech>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zf5mccuff24ckjqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 19, 2021 at 03:59:25PM +0200, Maxime Ripard wrote:
> Hi,
>=20
> This series aims at fixing a complete and silent hang when one tries to u=
se CEC
> while the display output is off.
>=20
> This can be tested with:
>=20
> echo off > /sys/class/drm/card0-HDMI-A-1/status
> cec-ctl --tuner -p 1.0.0.0
> cec-compliance
>=20
> This series addresses it by making sure the HDMI controller is powered up=
 as
> soon as the CEC device is opened by the userspace.

Applied, thanks!
Maxime

--zf5mccuff24ckjqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYUBVawAKCRDj7w1vZxhR
xfMkAQDyXm2NP51QANJCaA1mpIerOh4658ezgQ9dFCJ8t+JeogD8CSj3M1JZelNl
8iwCKziBkPC6f6S2qoUz8RO9VBmvMwc=
=UgoN
-----END PGP SIGNATURE-----

--zf5mccuff24ckjqq--
