Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7FD3DC595
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 12:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhGaKc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 06:32:58 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42399 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232182AbhGaKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 06:32:56 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9226B5C007D;
        Sat, 31 Jul 2021 06:32:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 31 Jul 2021 06:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-id:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=d+NXTrGFKDqrfs1qtW7ghetxFZrLoqbnkx+91xB+FPY=; b=kfb4Bn9I
        UGMUGIuUQiUE6eCVdUVz+qzAFr9WUIABrED/3xZYAnGOhyTMeqBvRNpSHMAmm2/r
        YX/rWGut3o2XKx6k2wTNEI80xV50/wSUULTZnfhP5q15XXZc7v1xHgV6Gr59i3om
        LSGGT7oV3NzZ+CKbIAKxkE0r11EQvWbwTQBdOezZQicpkMmNKc3J82v/1zFu5NqA
        mq9UOjw3MzQ8vGh6AhTQ7moBGXxvfEnhhpj0k/I0AXil/DuTDpGSJQjHWdUToIQo
        hbNBDqhd0nCwCilXew4dadSGFzDStTkBPw14t0IaqxJz2heq25Xapxo75oIx7Fwp
        OR4DM5XdNWC0jw==
X-ME-Sender: <xms:0SYFYaCLpWwoA2MPrgF7M7kszWVlqPXOAHDHxKSpfiYWmf4dmV-7Aw>
    <xme:0SYFYUhPZL1fqJEkeFM3Lon4mLrKSGyyK42pqiK9vG5AV-lPyq1K5hRdrVBJmijgp
    Ksi3HzPuisJvW-yifM>
X-ME-Received: <xmr:0SYFYdnJsEBYG6T-nxYgFz8ABEd5bdmvLmrI262hCxugd1oRAFi2o13ueT0YsaNiEYM2H0OYNzzNM1Wo4io0zna20pXuN7coJkE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrheejgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcuvfhh
    rghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtth
    gvrhhnpeefffejiefgheevheefvefhteeggfeijeeiveeihfffffdugfefkeelfffhgfeh
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfth
    hhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:0SYFYYxTjucRqWX59AoG2xRyq3Gn-GkHBKTV09rTsdN6CWzcdkPc2A>
    <xmx:0SYFYfQe_R_o-jz_CeH1Xr_Ag9vTbR7GXtcx999uEjFGUlYNMO0pOA>
    <xmx:0SYFYTYCbKq_nggfqDej27VwFums2UoCGaUkoTxgxOk-0fLefOQIyA>
    <xmx:0iYFYaeW6Rde0H7iv5uckiZc2QimONFVfnCfc4pSV40dRQfGHFBImg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Jul 2021 06:32:47 -0400 (EDT)
Date:   Sat, 31 Jul 2021 20:32:38 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/5] nubus: Simplify check in remove callback
In-Reply-To: <20210727114220.7drjl6xvvlwetaod@pengutronix.de>
Message-ID: <4b44c8a4-7d2b-83d-60fa-2d4e4f8284db@linux-m68k.org>
References: <20210727080840.3550927-1-u.kleine-koenig@pengutronix.de> <20210727080840.3550927-2-u.kleine-koenig@pengutronix.de> <d74ccd1-116d-9450-5ee4-8d5074998872@linux-m68k.org> <20210727114220.7drjl6xvvlwetaod@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463811774-1671877625-1627726966=:27"
Content-ID: <e042cd98-5938-63df-9034-7720ee545436@nippy.intranet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-1671877625-1627726966=:27
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <8cd094c5-f4b-ada3-cacd-f77e4f8772f@nippy.intranet>

On Tue, 27 Jul 2021, Uwe Kleine-K=C3=B6nig wrote:

> On Tue, Jul 27, 2021 at 07:50:39PM +1000, Finn Thain wrote:
> > On Tue, 27 Jul 2021, Uwe Kleine-K=C3=B6nig wrote:
> >=20
> > > The driver core only calls a remove callback when the device was=20
> > > successfully bound (aka probed) before. So dev->driver is never=20
> > > NULL.
> >=20
> > Are you sure dev->driver is non-NULL for the lifetime of the device? A=
=20
> > quick glance at device_reprobe() makes me wonder about that.
>=20
> Not for the lifetime of the device, but as long as a driver is bound to=
=20
> the device. device_reprobe() calls device_driver_detach() after which=20
> the driver is considered unbound and dev->driver is assigned NULL. (via=
=20
> device_driver_detach -> device_release_driver_internal ->=20
> __device_release_driver)
>=20

Are you saying that this situation does not presently apply to nubus,=20
zorro or superhyway? Or are you saying that the remove callback will never=
=20
be called in this situation?

Perhaps the device_reprobe() API should be documented accordingly, so that=
=20
a missing NULL check can be added if need be. Perhaps it is better to just=
=20
leave this pattern as is (i.e. keep the NULL check).
---1463811774-1671877625-1627726966=:27--
