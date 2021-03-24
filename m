Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1733473B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhCXIcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:32:15 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:50979 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233692AbhCXIbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:31:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id DBE19F61;
        Wed, 24 Mar 2021 04:31:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 24 Mar 2021 04:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=YWzCakH/LUe5+V2WZEYSbDkGhoC
        pPYo+6Tk6C4iv9/8=; b=VhCYgkAOyFUf04xiJEJlIZIxcJWUW/WH/qo6qDuFyWp
        OuIoILTOTlM/g3Q08tvsgukrhsh4pwKiPQ0dmBlkQJ9Tj4HK5QVBQHHyd4Z6mMQj
        bfqRyBobZhj3vSffQGUWGrG40to+DoAL2X1kw7xnUDY1oybczzxoTizbHQOz3a2o
        yiGIFt13WGap38ensKj3Ynkc6wluSndQstSqgXUAiExUVVTkYdryQMGKXzZ+E0WQ
        6B9Ez4Eg17EKBPoPrRgPktByGNfQQa/YP8aOfSw207HBafJsgXUJdCf0aN91PDrA
        3jUAxAR01NdgTfum8v3luCQ9WH7ev/YTAG8wiq9dwug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=YWzCak
        H/LUe5+V2WZEYSbDkGhoCpPYo+6Tk6C4iv9/8=; b=VRoSlbTLBH26aGP4opYF6R
        ifkE2GUINjg7el1gT+AsIYFmbSfIxB8M22emR/vY6/FttqOt6nkmS42qBHgfgNe6
        0Hc+VxUCTI5E/dzes5Bvkxukd2MLoeBTlXJv6gNoqNZWQ67bInwBAJcPcCjjSeR4
        w5g4Ni6Bx6WYNCpH4YhHfe3PbM1nJEhJlduTALcI+fONyW01KExWWNaSZvKNJcEu
        mC764yenYWMxMVMQD4Ozs3GhurjkAlAtMhGSiJiVLhgLGpm3O24l+dv8NT9zV74v
        cBssBM2PZkAuZfXwTVg9GTafZFW5H36H7AQlot+Vp+yBu5VB1Sryj0ASulpdHWwQ
        ==
X-ME-Sender: <xms:7vhaYM9vYn5pqaEZ_vKyA6Z_6SSILxzU8T3NlLfFxEI6XEEl0zNZGg>
    <xme:7vhaYEuxJx2b9dQ9C37-YPbGYiUzsJyDz40FtJ8hG4VBxrApiIdBo0Uewe9EkZTR1
    1HcS8qAoqNjsoKS8n8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegjedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:7vhaYCA3tIW4IWBz6LBgrLEQKMse2V9Hrcusu-FZG3qyGZkQH6n02A>
    <xmx:7vhaYMekpa053HJpvUVMCxAexVS52CWPTT6lwDriwlgj3D8pR6164w>
    <xmx:7vhaYBO3SXfR58ylpjCVp9qemvl0hlbrU8vsdA3TCn_FrY0NenzljA>
    <xmx:8PhaYCE0KILfus6itejyuhLXRhSV8cZUhRlwSFWggqII9bpUC2iVxJXj4Cc>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F0F1240423;
        Wed, 24 Mar 2021 04:31:41 -0400 (EDT)
Date:   Wed, 24 Mar 2021 09:31:39 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm/rockchip: Remove unused variable
Message-ID: <20210324083139.fucyespm3utmr3mg@gilmour>
References: <20210319152920.262035-1-maxime@cerno.tech>
 <YFU/6Hm1CuVL8MlO@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xd7ljjvtuupcqacd"
Content-Disposition: inline
In-Reply-To: <YFU/6Hm1CuVL8MlO@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xd7ljjvtuupcqacd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 20, 2021 at 02:20:56AM +0200, Laurent Pinchart wrote:
> Hi Maxime,
>=20
> Thank you for the patch.
>=20
> On Fri, Mar 19, 2021 at 04:29:20PM +0100, Maxime Ripard wrote:
> > Commit 977697e20b3d ("drm/atomic: Pass the full state to planes atomic
> > disable and update") added the old_state variable instead of what used
> > to be a parameter, but it also removed the sole user of that variable in
> > the vop_plane_atomic_update function leading to an usused variable.
> > Remove it.
> >=20
> > Fixes: 977697e20b3d ("drm/atomic: Pass the full state to planes atomic =
disable and update")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Applie,d thanks for your review

Maxime

--xd7ljjvtuupcqacd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYFr46wAKCRDj7w1vZxhR
xVikAQCSOjvdI1bAIpWTP3P5MFsU2LgHwd2ZK+wt3h9SnDa4igD+K8wTroNrL4RS
VKTCTGcbi7CFwpxBriTqNK0lEijZiA0=
=N1Kf
-----END PGP SIGNATURE-----

--xd7ljjvtuupcqacd--
