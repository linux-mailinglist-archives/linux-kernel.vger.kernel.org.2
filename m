Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA225378DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350202AbhEJM4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 08:56:48 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35937 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347305AbhEJMdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:33:53 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A79D65C01A3;
        Mon, 10 May 2021 08:32:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 10 May 2021 08:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=oObO8o2tNMzbSU4/I4bCTlKDZH5
        pBHbBb3SLAsD2hUU=; b=uNauK/jkeEozgJQXiu8ZVVoI/RvcyuA56y2xsTdwWZB
        0v8DOtWRP13qyap6Q6RR9Vz4VmAcBFq57iuBLe3z1gCj81ekbzHkQIhbtZJogYDS
        Z2fDHf3alxt9CluV9lHIwygA3rdk7DiRk74reShtHtHRL4wYc8PyGC6v1yGP7vdG
        EBJI71liWSyjvpIAJ+d/+vIDMafr4cbTUu8ojrzm40+V/bZhsxdLTJTL/xddDQvd
        boXuP+KfT9QnVNBhDWasEpS5ZdhrVAyJzfS3yRe2HdJBK6G0ZBnk0PrKgtb74qLi
        WT/+CXv6HSNIVU+0AD/HnF/3I31QbKBX3q73Qnf1/ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oObO8o
        2tNMzbSU4/I4bCTlKDZH5pBHbBb3SLAsD2hUU=; b=fB5OlocDnX6odU9hjhCqnq
        wx70CnAuo7nLGyY7Lk6OS2TqCtcMhBbbA+jw1j1UGad8hVfojam25x4Y+oyr+pl2
        de3RVnsh8RslC8BVuNHhOyZnbeF6qS7byAteERqinRlLF4UFiUTBY1msA8Ea35Pt
        kWlFcsv1UPRCtNlSdrHq4Uj0ygYXQ/q1va/X8rMVMfCCKXqngQ5NSR4813DWIEsl
        1zRao3qO4C6hdCfBWk5itt1Ce/qVbeKcctdQafQmgDskUD/s0CBxVMIlWj/ynlR4
        KS/QYASKKFSLkBA5df3sOtTaf4iIhVJpT68G56T9MhVT5zIpiLTkpZQDc4ulHIag
        ==
X-ME-Sender: <xms:7ieZYPxsOmzgxIOg1UW9WxXxb-TIgGrR0CKKebhbCWyXNaSvWetzIg>
    <xme:7ieZYHTrENvJlVUF-8DNsQO3bKma1rLxqrofWLq9P2CPWdm9pLu8dY2kpStvtOsIn
    S8I9zxQYoPuzFlzuWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegkedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeelkeeghefhuddtleejgfeljeffhe
    ffgfeijefhgfeufefhtdevteegheeiheegudenucfkphepledtrdekledrieekrdejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:7ieZYJXQDhjUPWKNxD-2PDLoXTfOlvO2bm0WOIcPmhkX6sunJLheAw>
    <xmx:7ieZYJgZ9FEuR095h10UdRnWrelAZTSeyO0vLdbO_CghObjtW0F0fw>
    <xmx:7ieZYBA6UdiTrGlU6Bd1fc_0YyMkmUQmQ3fuJGvNAxnrJE9XJYSPwg>
    <xmx:7yeZYM9r6bT2rLVvsVL0_eZreSOLkm6bBkjB9wAf0VdrfNUPxNbfIQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 10 May 2021 08:32:46 -0400 (EDT)
Date:   Mon, 10 May 2021 14:32:43 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Rajat Asthana <thisisrast7@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Declare drm_send_event_helper static.
Message-ID: <20210510123243.hmwar3swmrewskjs@gilmour>
References: <20210509134252.488157-1-thisisrast7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3bqrf5xpqv6etbos"
Content-Disposition: inline
In-Reply-To: <20210509134252.488157-1-thisisrast7@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3bqrf5xpqv6etbos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 09, 2021 at 07:12:52PM +0530, Rajat Asthana wrote:
> From: Rajat <thisisrast7@gmail.com>
>=20
> Declare drm_send_event_helper as static to fix sparse warning:
>=20
> > warning: symbol 'drm_send_event_helper' was not declared.
> > Should it be static?
>=20
> Signed-off-by: Rajat <thisisrast7@gmail.com>

Both the Author and Signed-off-by should have your full name

Thanks!
Maxime

--3bqrf5xpqv6etbos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYJkn6wAKCRDj7w1vZxhR
xRQ9APwPHSZPts1UIAqgRY/CgRs0O1YGQqMv21YRhb6knJ94AQEApfOc+eTQ6ucz
4XbQebw6e4QiW/7mvxkW4JeIn7pKdws=
=7fcP
-----END PGP SIGNATURE-----

--3bqrf5xpqv6etbos--
