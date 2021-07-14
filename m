Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4863C7AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 03:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbhGNBPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 21:15:05 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33625 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237198AbhGNBPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:15:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 922075C01A3;
        Tue, 13 Jul 2021 21:12:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 13 Jul 2021 21:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=EsgNCm
        QMp0sVxZo1hnQjnHJ7usJKDbWwUiB8a7dFg/k=; b=YE4H9V3yEq6ZVue1ho6gt9
        Y/Ewm5PRZazkDeXYptHAy9Sb8FZcDSFggs/ZE2kLiM1R73iloLqQVrvKWF/9vAi+
        aoYWf+T82uXlnYWLuPL5+CwCc49EGEYe+OGRJVoZKOVzE6dOOb9KibwhPAZOkRnP
        SUKjEK/ygMtA1wBBUaIy/qe/vr4AhFcEx2H66P5dtFyTd63yXagN9aHkOI/KOnbq
        SBD4XseVpkvHEKIqxjc2cOHf9W+0pAAn8FUql/r1G+/vaUD1C+zzBQEiPms69/vI
        w2atrxDp3xOtX1owEZwnRusQWUKVR6JN3j4K2Srh7ot3zpwKXzax+N4eO+Swx+cg
        ==
X-ME-Sender: <xms:7TnuYEEjNLP6vO3QYTEUcecLnCo2abzQzst-gtU2zUbWPamocR-njQ>
    <xme:7TnuYNWEwUqszRN7RG3XDe_K5sriWZ6WCp6BnZgsG1svoG2VGS1unxVuarvLLJ8er
    MoRUrj8qq0y26-Ifxw>
X-ME-Received: <xmr:7TnuYOJEedPfRS5vmAHqA5mTzo0eqKEjN1rVkbaghMZ_mE2uMiYuqnaP4sfk3Pvy935GkngDkPGsl1DQgu7NffU1xuZoydw8-2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffujgfkfhggtgesmhdtreertd
    dtjeenucfhrhhomhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhm
    ieekkhdrohhrgheqnecuggftrfgrthhtvghrnhepfeffjeeigfehveehfeevhfetgefgie
    ejieeviefhffffudfgfeekleffhffghedvnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:7TnuYGHMwL9R99BXWPwwZp-jfRDxNpvxtOPR0cgzDktTmy13ZCHt4A>
    <xmx:7TnuYKXvZaDdgTNGQiTPgcl0wL6YxrZ_Pf6PUXeX1AyWZUdShuJiaw>
    <xmx:7TnuYJPjt2O_wJKobSvd4ejWJhSUJCvDstBLdeeViEWBB2zv9QuMHw>
    <xmx:7TnuYFCd_8F_TJikT_OH9IbeIxkkMec8vxMI7A9RlUFqGuPU9ccuvA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jul 2021 21:12:11 -0400 (EDT)
Date:   Wed, 14 Jul 2021 11:12:05 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] bus: Make remove callback return void
In-Reply-To: <20210713193522.1770306-6-u.kleine-koenig@pengutronix.de>
Message-ID: <1a4ba24-8bab-47b8-b25d-cc31ce16ca1f@linux-m68k.org>
References: <20210713193522.1770306-1-u.kleine-koenig@pengutronix.de> <20210713193522.1770306-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811774-790401653-1626225063=:6"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-790401653-1626225063=:6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 13 Jul 2021, Uwe Kleine-K=C3=B6nig wrote:

> The driver core ignores the return value of this callback because there
> is only little it can do when a device disappears.
>=20
> This is the final bit of a long lasting cleanup quest where several
> buses were converted to also return void from their remove callback.
> Additionally some resource leaks were fixed that were caused by drivers
> returning an error code in the expectation that the driver won't go
> away.
>=20
> With struct bus_type::remove returning void it's prevented that newly
> implemented buses return an ignored error code and so don't anticipate
> wrong expectations for driver authors.
>=20

=2E..

> diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
> index ad3d17c42e23..d9d04f27f89b 100644
> --- a/drivers/nubus/bus.c
> +++ b/drivers/nubus/bus.c
> @@ -29,14 +29,12 @@ static int nubus_device_probe(struct device *dev)
>  =09return err;
>  }
> =20
> -static int nubus_device_remove(struct device *dev)
> +static void nubus_device_remove(struct device *dev)
>  {
>  =09struct nubus_driver *ndrv =3D to_nubus_driver(dev->driver);
> -=09int err =3D -ENODEV;
> =20
>  =09if (dev->driver && ndrv->remove)
> -=09=09err =3D ndrv->remove(to_nubus_board(dev));
> -=09return err;
> +=09=09ndrv->remove(to_nubus_board(dev));
>  }
> =20
>  struct bus_type nubus_bus_type =3D {

Acked-by: Finn Thain <fthain@linux-m68k.org>
---1463811774-790401653-1626225063=:6--
