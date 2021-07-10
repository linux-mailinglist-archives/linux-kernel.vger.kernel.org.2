Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF8C3C356C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 18:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhGJQFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 12:05:04 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33889 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230325AbhGJQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 12:05:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EE36E5C0090;
        Sat, 10 Jul 2021 12:02:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 10 Jul 2021 12:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=W
        fQ29mg8W/hFuxqPmmMCBZENXMtT+jgPUvFXTuXU9gY=; b=gL/QYBoA29XHCSnfQ
        qYPC7qZfmIeqg1Cn30VXi7rFIP24S9Q9qQ4AR+OFI8B0A68rMYu8sKWP/3G+7TxR
        aoU4xZD6nFRcWBu5zYhqqnmGcFUIMR/+ECy748F8tbfSiJ+u1v5Z5NrjqSQCfid7
        zNEt3yY6BD1YHg/vVf2b9eMvRm/tcyRZpzTUH1VUqp7JlEFcCF9TOwnDi3qyO5Fn
        cs9oP583I5k7TzSR+zSAZmbcqkC0UcUnjnyV6Xv3RuHycZMPAPAT0LpZZp04jIiA
        o4VBw0TMnmfz+Cm0QbuyNRFPmAgBTfO/X2X7MLcHvbr8GDvZKjzrmbCgBQH7PyAX
        VKjOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=WfQ29mg8W/hFuxqPmmMCBZENXMtT+jgPUvFXTuXU9
        gY=; b=FGwJ6HEkZemLlJFUrMlS0Mg8v/CytSyp8UT4/2Gc/uJLgZZdxjU2SOkYR
        dj/AxtheH9A+ra4GTDHES7rOqHkymhyBJxmOh+WAVRJ+jWFgcd/7PG/Z5Z2Ysm9h
        XfuvOsVisCRsUU/GNW6V8+4bFbHAn/8b7TD2nDW7w1x4+sP6W/2R1/V3xPxqSpd9
        u3E/3p2d/9rhLNTMZm9kuUvRRH09e2a2XZZT59uXlvliSfo/A7gToJSgsPcwGkyP
        Gbmm9u+jGzEOY4n3Xu5lGde8c/aGPhJwy2pZQsBFW5+Pb9UAAbVioixAEu4UMaWY
        XCkXt5hvu2eJ92q4WnrOL+7B9BGAw==
X-ME-Sender: <xms:iMTpYGLNL4rJ0L3bPB3BAuOapMalsZ_DsT65z0kh7tHdHSzjcl_YNg>
    <xme:iMTpYOKaLmP3QYCPK_dP_SRCGmgIU1ksnfOKathSx9f0lo7U1I4o5facVUaLrtMZO
    7Rs3WKWtxU4LxfNhWE>
X-ME-Received: <xmr:iMTpYGtWt9ULg5IB6fKtYAVjShc0EMQ_6jo9wcDqg6osekgayTiEMIyVAAsfu9xbYg4aIatI5qgYPpghkqKEVdVT8O1gGeNyTsZx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtdekgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgedtueeludeigeevkeellefgffeiheeiheeuvdevgeekjedtfeffjeekhfei
    tdejnecuffhomhgrihhnpeguvggsihgrnhdrohhrghdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgv
    segtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:iMTpYLZZO3DxYjtkWjpFr_KtO1H0rH7m0BfZ4AqXOkU6Q9ljwj7Xnw>
    <xmx:iMTpYNZ66t-0LsaK6-4NzlccT-2AufYJdycNdOvsc7dPzeaUXt2eHQ>
    <xmx:iMTpYHAtYVM20u5yMNbywwURCobKK1ePJFtKfqmN8ZkHOBkOZtagfw>
    <xmx:icTpYLOvZDIEpM_TIT6AJY6wbqRVrnZ1v2CnsUm1ZRMf5P5PH53a7Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jul 2021 12:02:15 -0400 (EDT)
Date:   Sat, 10 Jul 2021 18:02:13 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Vagrant Cascadian <vagrant@reproducible-builds.org>,
        "B.R. Oake" <broake@mailfence.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix ethernet phy-mode
Message-ID: <20210710160213.nursu2vc3ef53nbo@gilmour>
References: <20210524122111.416885-1-carnil@debian.org>
 <20210524123506.cuwwtqgtejquuq5e@gilmour>
 <YOmcI191mbxXCrp1@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YOmcI191mbxXCrp1@eldamar.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Salvatore,

On Sat, Jul 10, 2021 at 03:09:55PM +0200, Salvatore Bonaccorso wrote:
> Hi Maxime,
>=20
> On Mon, May 24, 2021 at 02:35:06PM +0200, Maxime Ripard wrote:
> > On Mon, May 24, 2021 at 02:21:11PM +0200, Salvatore Bonaccorso wrote:
> > > Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
> > > config") sets the RX/TX delay according to the phy-mode property in t=
he
> > > device tree. For the Orange Pi Plus board this is "rgmii", which is t=
he
> > > wrong setting.
> > >=20
> > > Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananap=
ro:
> > > Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which g=
ets
> > > the Ethernet working again on this board.
> > >=20
> > > Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay con=
fig")
> > > Reported-by: "B.R. Oake" <broake@mailfence.com>
> > > Reported-by: Vagrant Cascadian <vagrant@reproducible-builds.org>
> > > Link: https://bugs.debian.org/988574
> > > Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> >=20
> > Applied, thanks!
>=20
> Did this fall trough the cracks?=20
>=20
> I see it in
> https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?i=
d=3Db19d3479f25e8a0ff24df0b46c82e50ef0f900dd
> but got not merged yet in mainline.

I'm not really sure what happened, but I did send it as part of a fix PR
here:

https://lore.kernel.org/linux-arm-kernel/ad7ba352-315c-4201-b922-4bf914a00d=
98.lettre@localhost/

But it was sent as part of one of the arm-soc PR for 5.14:

https://lore.kernel.org/linux-arm-kernel/20210709234054.10288-1-olof@lixom.=
net/

I'm not sure if it didn't get applied to the right branch, but it
doesn't seem to be part of the proper PR either.

Anyway, this is on its way to Linus, will be part of 5.14 and picked up
by the stable tree at some point in a 5.13.* kernel

Maxime

