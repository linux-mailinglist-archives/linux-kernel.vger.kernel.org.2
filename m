Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990FB3082BA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhA2AxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:53:04 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:43181 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231313AbhA2Awn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:52:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 81DB0127B;
        Thu, 28 Jan 2021 19:51:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 28 Jan 2021 19:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=RtCyCp
        UTmt3aHviKZpCYT1mnioeuZph6lQNXYjni5oI=; b=GrYp49JmvRUso8IZm5gqic
        t3bMcNvM87jCEqSaFT7vmEkim2bD+q+aDYsD1mJJfacKuWt/IzFc/MQmmC5Op8Fu
        aCz4P9tOUQShAwkRZtJpaYwguK+KG/bU7+bNX+/InTYwn8mYNRQFjL4otmc5li8X
        5k5zImUwMcqv5441uQkQoVCiPWi5lsEyuxbbcuhZn0HSUOvvTlHaLfTNR4zGzKSH
        YO4CHF+oxXWkbT0jVWE6TFcktBGlcxuPq1XIfftTgUx1eZ2KawuhWzdOGOprMura
        rLBJxe0lPlOLFIJTUI932j14PTwh+jcnYTwg9rTQ1Lk/kRcDnFN+1Iv2wJiekiSw
        ==
X-ME-Sender: <xms:F1wTYHUz33wWIPEIN_ysfruCqjogkpBmvvDR5AQjDx1rN7rHlX1cjw>
    <xme:F1wTYPkiFuHGjHGtGuAOA7qsJrjtUVWiZ7yeqYM5tnXcAY6CAqc8wGfQXivJJQ5VG
    sWJZ91I47pYsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedugddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgvkhcu
    ofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepteevffei
    gffhkefhgfegfeffhfegveeikeettdfhheevieehieeitddugeefteffnecukfhppeelud
    drieegrddujedtrdekleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrd
    gtohhm
X-ME-Proxy: <xmx:F1wTYDbyxNz793PSQbcKfzlp4HMu-twub1Oz8hm8lBVtJZGfklCZ1w>
    <xmx:F1wTYCURI1Q32fjbRtZjB4jYvpEgm24a92NxPfL2iotQpmhXgtHYVA>
    <xmx:F1wTYBlPtXTTCs6oyLjpdAuHazWRQHOQ7oNwUlN0Z9icKbFWvSsILQ>
    <xmx:GFwTYEvJU2qZeXUyhlE1Yga8jAPIx6zPL5v_gkUIqGE7fWJqMc7Vdw>
Received: from mail-itl (ip5b40aa59.dynamic.kabel-deutschland.de [91.64.170.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id 91FAB24005B;
        Thu, 28 Jan 2021 19:51:34 -0500 (EST)
Date:   Fri, 29 Jan 2021 01:51:29 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Michael D Labriola <michael.d.labriola@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: Problems starting Xen domU after latest stable update
Message-ID: <20210129005129.GA2452@mail-itl>
References: <2nft2kipqg.fsf@aragorn.infrastructure.cah>
 <983b87d6-edb8-21ea-7d6f-f653f5c0d048@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <983b87d6-edb8-21ea-7d6f-f653f5c0d048@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Problems starting Xen domU after latest stable update

On Thu, Jan 28, 2021 at 07:03:00PM -0500, Boris Ostrovsky wrote:
>=20
> On 1/28/21 6:52 PM, Michael D Labriola wrote:
> > Hey, everyone.  I've run into problems starting up my Xen domUs as of
> > the latest batch of stable updates.  Whenever I try to create one, I
> > get a bunch of block device errors like this:
> >
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:una=
ble to add device with path /local/domain/0/backend/vbd/4/51712
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:una=
ble to add device with path /local/domain/0/backend/vbd/4/51728
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:una=
ble to add device with path /local/domain/0/backend/vbd/4/51744
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:una=
ble to add device with path /local/domain/0/backend/vbd/4/51760
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:una=
ble to add device with path /local/domain/0/backend/vbd/4/51776
> > libxl: error: libxl_create.c:1452:domcreate_launch_dm: Domain 4:unable =
to add disk devices
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:una=
ble to remove device with path /local/domain/0/backend/vbd/4/51712
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:una=
ble to remove device with path /local/domain/0/backend/vbd/4/51728
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:una=
ble to remove device with path /local/domain/0/backend/vbd/4/51744
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:una=
ble to remove device with path /local/domain/0/backend/vbd/4/51760
> > libxl: error: libxl_device.c:1105:device_backend_callback: Domain 4:una=
ble to remove device with path /local/domain/0/backend/vbd/4/51776
> > libxl: error: libxl_domain.c:1290:devices_destroy_cb: Domain 4:libxl__d=
evices_destroy failed
> > libxl: error: libxl_domain.c:1177:libxl__destroy_domid: Domain 4:Non-ex=
istant domain
> > libxl: error: libxl_domain.c:1131:domain_destroy_callback: Domain 4:Una=
ble to destroy guest
> > libxl: error: libxl_domain.c:1058:domain_destroy_cb: Domain 4:Destructi=
on of domain failed
> >
> > I'm using Xen 4.13.1 on the box I've been testing with.
> >
> > I bisected down to this commit, and reverting it does indeed fix my
> > problem.  Well, this commit upstream and it's cherry-picked variants
> > on linux-5.4.y and linux-5.10.y.
>=20
>=20
> You most likely need 5f46400f7a6a4fad635d5a79e2aa5a04a30ffea1. It hit Lin=
us tree a few hours ago.

I can confirm this fixes the same issue for me (too?), thanks!
Shouldn't this patch have Cc: stable?


--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmATXBIACgkQ24/THMrX
1yxEYAf+NaYF9uWKBJr4xcdeujrzMrOqTPasB/fVcYAOqYKy1g9cCrP4fKz4VSkh
BTAzpN3+//kubixrfgBHtqQNHmNWou8eQFc9uiBOhhfPuYCrqQHqH3W7qp7K5Xac
VP9x46T+T8FU2wJs8WQQQqdFI2ZRFxC//B+Ga34vaOZuIE3gRV/4p8PpsYrfPe7l
ro3JEjZKA0X0abFsirqj+FWlIzAes1KLRGa7LFFgSSonKFkyuvYXuB58dd73J+27
yEDm7sHzO1sVtRnz/becgAkrIR2hJ3oHX4Ke9jadwTkyKhQx1oiNsnuuO2D8eplV
8z/OaKi1eXORDy6mt3YH/5trNkBRBA==
=jfpi
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
