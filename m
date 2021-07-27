Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349C43D7256
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbhG0Jum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:50:42 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:52179 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235950AbhG0Jul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:50:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AC4333200921;
        Tue, 27 Jul 2021 05:50:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 27 Jul 2021 05:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-id:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=J3f2eYP/ypsMclzmndLPiDcKO9gMzTgRakt9f1pTvUg=; b=ioG4IDXG
        Anz/sJRnt6VaB5HnV6qUmyr7uuV29HlVhBu9Xm1yrHhGolhiLHr0rL6bBs2/cD0D
        PBGwhlXBOfL0WFqeWWMAfV2AB+Thcghu9eLnwECGhYbeKJb3H/uOimPRugYECtDB
        WZhdT/dDfue90eJdph0GPlKMLVpbI9pc+9hbME9xeFQOwJ3oSuTdD7prfxZ9VFtI
        kGkuWG+cFOgP3uiIEU3Gtno3YLyfPFXrJG7M2Mc9bdpLQ7/PGgVUlAi+lZfgZi+J
        /2yaGGdF6je0giF60J+FX3r78y1+XMb4cREbu1B8QNNx4fnNk8hAoied0Si/VVCV
        ruFxXZRhrm39LA==
X-ME-Sender: <xms:79b_YEJ94qRyzKucpzPBInJUiCu6PSF7JDx1jSPzf_P2oNClHoy9Nw>
    <xme:79b_YEK9xq02f3Lgq7l61TghPt-oVJC4FnG0aJG3L_ccwlfJEh1jh7yDh0-CLWZP_
    jTxVG9pkkOOALUPI_U>
X-ME-Received: <xmr:79b_YEs54DfL_ExZ015DBzC8ogREg4Uzwa0zlMCP5mjs_EvZMxH1C3XaqJcSQvyvES_fF1LieaU88JflOsxYMT8ZHWEI6HeIpro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeejgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeefffejiefgheevheefvefhteeggfeijeeiveeihfffffdugfefkeelfffhgfeh
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:79b_YBYz-V0dHBW1gpxxJJ3kFnkujo54QJ6dmxVjRq-HoIwl8gS8OQ>
    <xmx:79b_YLZIjE8aWs_gGELOuZbTmBI95FpvpMmNcR1JTyvzpdDaRkvusw>
    <xmx:79b_YNAVvUTw7_kU-ZSHEuHraEBQo9qgd4Uu0xRhSYYUA5cueehqAw>
    <xmx:8Nb_YKl2V6s2ugSLqtHHGf0A8h7XCjq2dAaSKfkmwvPB2Hr_JV7uXQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jul 2021 05:50:36 -0400 (EDT)
Date:   Tue, 27 Jul 2021 19:50:39 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 1/5] nubus: Simplify check in remove callback
In-Reply-To: <20210727080840.3550927-2-u.kleine-koenig@pengutronix.de>
Message-ID: <d74ccd1-116d-9450-5ee4-8d5074998872@linux-m68k.org>
References: <20210727080840.3550927-1-u.kleine-koenig@pengutronix.de> <20210727080840.3550927-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811774-245338131-1627379007=:27"
Content-ID: <7a42c831-acd5-2e2f-28c2-99efc32374e2@nippy.intranet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-245338131-1627379007=:27
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <eb76bb50-e32-3e93-cf95-e39ea524d11f@nippy.intranet>

On Tue, 27 Jul 2021, Uwe Kleine-K=C3=B6nig wrote:

> The driver core only calls a remove callback when the device was
> successfully bound (aka probed) before. So dev->driver is never NULL.
>=20

Are you sure dev->driver is non-NULL for the lifetime of the device?
A quick glance at device_reprobe() makes me wonder about that.

> Apart from that, the compiler might already assume dev->driver being
> non-NULL after to_nubus_driver(dev->driver) was called.
>=20

I don't understand how a compiler can make that assumption. But then, I=20
don't know why compilers do a lot of the things they do...

> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/nubus/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
> index d9d04f27f89b..17fad660032c 100644
> --- a/drivers/nubus/bus.c
> +++ b/drivers/nubus/bus.c
> @@ -33,7 +33,7 @@ static void nubus_device_remove(struct device *dev)
>  {
>  =09struct nubus_driver *ndrv =3D to_nubus_driver(dev->driver);
> =20
> -=09if (dev->driver && ndrv->remove)
> +=09if (ndrv->remove)
>  =09=09ndrv->remove(to_nubus_board(dev));
>  }
> =20
>=20
---1463811774-245338131-1627379007=:27--
