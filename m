Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F05403C9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349765AbhIHPiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:38:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54521 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235441AbhIHPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:38:01 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D92375C00F2;
        Wed,  8 Sep 2021 11:36:52 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Wed, 08 Sep 2021 11:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type:content-transfer-encoding; s=fm2; bh=tz
        BJ1QB5ptfxnKFM1W/uFX8bdJBVWCl+P6cWXM7+70Y=; b=JPD6xW1xMJZ+NyRAIu
        1/VrcIMqYTrfDElDhHfT1YyCSYIXTqQrQ1stNW5Ur7+4vOzkjPpFokPU+SNlvuol
        SCmj3XmTxsGM/MYc8KAiOz184uHVYX/k1+vnLyMT+Poo5xQOotVWjxLXVPqXpK91
        oIDx1q1HP6o8lq8AylzcWMGE1BOLessJ97cgRAZmP2Euj9lnHK0XzzuuDLThdLFj
        UHhW063tc60eE/N+GFrKd0R9Ab65xktW8NifzrjRMhkyFRZ3pTFxGLRZUXzkmeVp
        37wLfPmIxWtm9el3IjsvIckiqOPHXWfmJFOyyTYN9cOtHrY22H2U1mesWGTIpIAB
        b+sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=tzBJ1QB5ptfxnKFM1W/uFX8bdJBVWCl+P6cWXM7+7
        0Y=; b=tHaWkyBPbdlJylGp/Bdz3qGe4vV8ONF5X+VB72WPjXmenx5/N5izLuHXC
        knRJ00bOEG6CvhdVriwVj+wkey68+wmv5WyIlqjzV9m4/0kFn92k5FKHl6gir6vt
        2dpJ4IhQDAcdHM8y7arf+R233qPvzcm5W5ejv0zv7kD2/nkwfxPa/SQciW9Yd9St
        WxQqwCeOr2zsAlpF7yYJWb4LOWTKyv756bZnsjEqDOmgFR6dswNDDjTx2g6ydDeF
        ksdkCOfVyZYBCumSLcuRQ7PxOIQAL0cVyctwrDeSJzsd8hCFlhf8YKtO46twAGlg
        i++2VtWaEByo4j5G64EjbWIj7xcQA==
X-ME-Sender: <xms:k9g4YdNH9JS89AC_1vww-c6DkrXJ3fcZm5IKcgg5o8ZuZYlEv5P_6Q>
    <xme:k9g4Yf9CBF0mFziKjiGhqsavDpWdSkiR6RyANYvnfEL67v1fwPzCEZG7uTsD6eioN
    ntC4uaKb-gQcs4FJFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefjedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepteeuudelteefueelvdelheehieevvdfhkeehjeejudfhieelffffudfh
    keeileegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:k9g4YcT4dUs2BKMQTU2BtjuG1K9UbiYbT-2yZxq_sojOynxiDTEXnA>
    <xmx:k9g4YZtvTrDbMIBMydM2qL8IAxjmF26EqW5mYfkkATb9ghRc-99HnA>
    <xmx:k9g4YVeL0hJNteRDYG8jdXu36xFAzP8cFagGrBuH1wtpfWAP9A9rrg>
    <xmx:lNg4YfuKkJQUUXVSQBYZqi6jFpnlXfKt-2M7ikgDUlT0krVUiTNBbw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7E92B51C0060; Wed,  8 Sep 2021 11:36:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1229-g7ca81dfce5-fm-20210908.005-g7ca81dfc
Mime-Version: 1.0
Message-Id: <758441b2-9b04-4e6a-8182-741ae1f858ff@www.fastmail.com>
In-Reply-To: <YTfQGqLv6FLnUfv+@sunset>
References: <20210907145501.69161-1-sven@svenpeter.dev>
 <20210907145501.69161-3-sven@svenpeter.dev> <YTe17jGBobarePaK@sunset>
 <ff66c30d-1b43-43d3-a4b0-02fe7d346118@www.fastmail.com>
 <YTfQGqLv6FLnUfv+@sunset>
Date:   Wed, 08 Sep 2021 17:36:30 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc:     "Jassi Brar" <jassisinghbrar@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Hector Martin" <marcan@marcan.st>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: mailbox: Add Apple mailbox bindings
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Sep 7, 2021, at 22:48, Alyssa Rosenzweig wrote:
> > > > +      - description:
> > > > +          M3 mailboxes are an older variant with a slightly dif=
ferent MMIO
> > > > +          interface still found on the M1.
> > > > +        items:
> > > > +          - const: apple,t8103-m3-mailbox
> > >=20
> > > Would be nice to document an example of where an M3 mailbox is fou=
nd.
> >=20
> > Sure, I can add a comment that this is used for the coprocessor cont=
rolling Thunderbolt.
>=20
> That raises another issue ... how do we know the M3 code works at all
> without TB support yet? It "looks" correct but some of the IRQ handling
> stuff is nontrivial.

Enabling the mailbox interface just requires a few clocks to be ungated.
Then I injected messages manually to verify that the code works.
In addition I also brought up parts of the Thunderbolt controller which
then allowed the co-processor on the other end of the mailbox to boot.
After that I was also able to successfully talk to that processor using
the same protocol used by most other processors.


>=20
> > > > +  interrupts:
> > > > +    minItems: 4
> > > > +    items:
> > > > +      - description: send fifo is empty interrupt
> > > > +      - description: send fifo is not empty interrupt
> > > > +      - description: receive fifo is empty interrupt
> > > > +      - description: receive fifo is not empty interrupt
> > > > +
> > > > +  interrupt-names:
> > > > +    minItems: 4
> > > > +    items:
> > > > +      - const: send-empty
> > > > +      - const: send-not-empty
> > > > +      - const: recv-empty
> > > > +      - const: recv-not-empty
> > >=20
> > > If the names became not-constant the asprintf thing goes away, not=
 sure
> > > that's better or worse.
> >=20
> > I'm not sure I understand your comment here. This property just give=
s a name
> > to the interrupts so that they can be referenced by that instead of =
a magic
> > number between 0 and 4 in the driver.
>=20
> D'oh, right, retracted. (Both this comment and the corresponding comme=
nt
> on the driver itself). Sorry about that.
>=20
> > > > +  clocks:
> > > > +    description:
> > > > +      Reference to the clock gate phandle(s) if required for th=
is mailbox.
> > > > +      Optional since not all mailboxes are attached to a clock =
gate.
> > >=20
> > > Do we do anything with the clocks at this point?
> > >=20
> >=20
> > The device tree bindings describe the hardware (as best as we can wi=
thout proper
> > documentation) and some of these mailboxes have clock gates which ne=
ed to be turned
> > on before accessing their MMIO. This driver already tries to do that=
 and works fine
> > with the downstream clock driver(s) we have.
>=20
> Good enough for me, thanks for clarifying =F0=9F=91=8D
>=20
> Commit r-b, though Rob will surely point out problems and I'll need to
> rereview =F0=9F=98=89
>=20

Thanks!



Sven


