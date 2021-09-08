Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F332E403CA2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349752AbhIHPkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:40:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46661 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240432AbhIHPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:40:05 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id AF4915C015B;
        Wed,  8 Sep 2021 11:38:57 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Wed, 08 Sep 2021 11:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type:content-transfer-encoding; s=fm2; bh=Vs
        137dnDwjZ10ROEbJwxlbbzEECzmqTmoM/+qEKvcEc=; b=CbrnKLHycHM1vHTxRr
        LjFLFettRNBdRVwsFMb2/h336pL0Zdyf/hZOXtpKnj2LjxAoAEJ0W+4ifQnxmojw
        IlV/noZMHEz1JE1RkGt5AYOKLQenmVAdTLerj9k192POPWrJxpgxUe43olGl5IOV
        cYSzM0ORYFJvmUPGhn5YnpbtYCsfZotIWOjcPqA7997vWTU39Hjh+Wjf3N+fnh7u
        tfiwX50KsiPhNK060cHi2WuDJQcXQmQzSHPjLo7p1H1F9ox6WXLYgnMfy6Iw0f+4
        f6E9XNtLgvXnsbXipCMzPtU7u8dv4Lgyx1amNnmrqin9xdCPKsrJZOUNr/b1jFEx
        793A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Vs137dnDwjZ10ROEbJwxlbbzEECzmqTmoM/+qEKvc
        Ec=; b=Np/x1QvSytKyzmEThbfYOUWRHjOE8v7lHqyuoPO6lsqh2sHXa+CxkqtU7
        asMqiO0/+RwSovRJP0r1HOMvZYZLqJYu7e2YrSA71EUq1Kb7hakfu/Orj4I9chlW
        YnA9kX1rX3wXtEHjlRnw13nJBrtDAtylShywzda3KT1iEWELLAsK1q2TvcJaKT0P
        KlyyA11r+8QumlrGe4czRB7A5ihYXqz+XUdKcp7zBNklZb+kHbll9THhD9816iPM
        MVsAiPynWLxKlxehJqHpjxbfKR8qNWACt98ekD04O29s8dpCyXmjF1rlnWHXgvCj
        JQQNyxqkBNbO8/b/5XPAa0LHXd+tQ==
X-ME-Sender: <xms:D9k4YZ7cr8P5NDORsI5CApPpuXVvwuKd2w2yPIAIrn_qEsx9db38yA>
    <xme:D9k4YW7_tP-6d8XbnRiXIHsSX8mz5ptqgBRvKJc5KYRFGREqwslqIbx2e2nDk4SiS
    jwP3WE__oAZckkowys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefjedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepteeuudelteefueelvdelheehieevvdfhkeehjeejudfhieelffffudfh
    keeileegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:ENk4YQfuVVLgmvJ893h9pCNF8Fj1Gi2i3EC3dTx-xsEA9MDSy0jdvg>
    <xmx:ENk4YSIPyAfjGJVSziV4KMTPRT2BfFecw3KbV0sz0Sy1gUMXz5LpYA>
    <xmx:ENk4YdLBYrkH9YMiwsH6CORMEuRb8yMBXtz6qbjhdSCeQt_TS_uNrg>
    <xmx:Edk4YSpBNUe2jST2cym6Gwb2CmZ3SWxaGY7ensRfE9-qmzd1eJrAuA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D943051C0060; Wed,  8 Sep 2021 11:38:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1229-g7ca81dfce5-fm-20210908.005-g7ca81dfc
Mime-Version: 1.0
Message-Id: <76e52969-7bed-480e-95ca-597c8706dc85@www.fastmail.com>
In-Reply-To: <YTfUaER6aq+YjBFs@sunset>
References: <20210907145501.69161-1-sven@svenpeter.dev>
 <20210907145501.69161-4-sven@svenpeter.dev> <YTe1cFs5ERe9LDu8@sunset>
 <39b92560-b236-4abb-9de0-ac3a3fa3a506@www.fastmail.com>
 <YTfUaER6aq+YjBFs@sunset>
Date:   Wed, 08 Sep 2021 17:38:35 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc:     "Jassi Brar" <jassisinghbrar@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Hector Martin" <marcan@marcan.st>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mailbox: apple: Add driver for Apple mailboxes
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Sep 7, 2021, at 23:06, Alyssa Rosenzweig wrote:
> > > > + * Both the main CPU and the co-processor see the same set of r=
egisters but
> > > > + * the first FIFO (A2I) is always used to transfer messages fro=
m the application
> > > > + * processor (us) to the I/O processor and the second one (I2A)=
 for the
> > > > + * other direction.
> > >=20
> > > Do we actually know what the copro sees? It seems obvious, but *kn=
ow*?
> >=20
> > Yes, I know. They see the exact same set of registers. I wouldn't ha=
ve written
> > it like that otherwise.
>=20
> Ack.
>=20
> > > > +struct apple_mbox {
> > > > +	void __iomem *regs;
> > > > +	const struct apple_mbox_hw *hw;
> > > > +     ...
> > > > +};
> > >=20
> > > This requires a lot of pointer chasing to send/receive messages. W=
ill
> > > this become a perf issue in any case? It'd be good to get ballpark=
s on
> > > how often these mboxes are used. (For DCP, it doesn't matter, only=
 a few
> > > hundred messages per second. Other copros may have different behav=
iour)
> >=20
> > If this actually becomes a problem I'm happy to fix it but right now
> > this feels like premature optimization to me. DCP is going to be the
> > worst offender followed by SMC (at most a few per second when it's r=
eally
> > busy during boot time) and SEP (I've also never seen more than a few=
 per
> > second here). The rest of them are mostly quiet after they have boot=
ed.
>=20
> Good enough for me -- it won't matter for DCP, so if it doesn't get any
> worse than DCP there's no point in optimizing this.
>=20
> > > > +static bool apple_mbox_hw_can_send(struct apple_mbox *apple_mbo=
x)
> > > > +{
> > > > +	u32 mbox_ctrl =3D
> > > > +		readl_relaxed(apple_mbox->regs + apple_mbox->hw->a2i_control);
> > > > +
> > > > +	return !(mbox_ctrl & apple_mbox->hw->control_full);
> > > > +}
> > >=20
> > > If you do the pointer chasing, I suspect you want accessor
> > > functions/macros at least to make it less intrusive...
> >=20
> > There's regmap but that can't easily be used here because I need 32b=
it
> > and 64bit writes. I also don't really see the advantage of replacing
> > this with some custom functions like e.g.
> >=20
> > 	mbox_ctrl =3D apple_mbox_hw_readl(apple_mbox, apple_mbox->hw->a2i_c=
ontrol);
> >=20
> > which is almost as long. And if I introduce a separate function just=
 to read the
> > control reg this just becomes a lot of boilerplate and harder to fol=
low.
> >=20
> > Or did you have anything else in mind?
>=20
> I was envisioning a macro:
>=20
> >	#define apple_mbox_readl(mbox, name) \
> >		readl_relaxed(mbox->regs + mbox->hw-> ## name)
> >
> > 	mbox_ctrl =3D apple_mbox_readl(apple_mbox, a2i_control);
>=20
> Now that I've typed it out, however, it seems a bit too magical to
> justify the minor space savings. And given you need both 32b and 64b
> there would be ~4 such macros which is also a lot of boilerplate.
>=20
> It's not a huge deal either way but I thought I'd raise it.

Yeah, I've thought about this as well but this entire hardware is
so simple that we don't gain much from it imho.

>=20
> > > > +	dev_dbg(apple_mbox->dev, "> TX %016llx %08x\n", msg->msg0, msg=
->msg1);
> > >=20
> > > Isn't "TX" redundant here?
> >=20
> > Sure, but it also doesn't hurt in a debug message. I can spot the TX=
 easier
> > but I'm sure there are people who prefer >.
>=20
> Fair enough.
>=20
> > > > +	dev_dbg(apple_mbox->dev, "got FIFO empty IRQ\n");
> > >=20
> > > I realize it's a dev_dbg but this still seems unnecessarily noisy.
> >=20
> > This code path is almost never reached. I've only been able to trigg=
er
> > it by forcing send_message to return EBUSY even when it could still
> > move messages to the FIFO to test this path.
> > This also can't be triggered more often than the TX debug message.
> > If this triggers more often there's a bug somewhere that kept the in=
terrupt
> > enabled and then the whole machine will hang due an interrupt storm =
anyway. In
> > that case I'd prefer to have this as noisy as possible.
>=20
> Ah! Sure, makes sense. Is it worth adding a few words to the functions
> comments indicating this rarely occurs in good conditions?

Sure, I can add a small comment if it makes the code easier to understan=
d.

>=20
> > > > +static irqreturn_t apple_mbox_recv_irq(int irq, void *data)
> > > > +{
> > > > +	struct apple_mbox *apple_mbox =3D data;
> > > > +	struct apple_mbox_msg msg;
> > > > +
> > > > +	while (apple_mbox_hw_can_recv(apple_mbox)) {
> > > > +		apple_mbox_hw_recv(apple_mbox, &msg);
> > > > +		mbox_chan_received_data(&apple_mbox->chan, (void *)&msg);
> > > > +	}
> > > ```
> > >=20
> > > A comment is warranted why this loop is safe and will always termi=
nate,
> > > especially given this is an IRQ context. (Ah... can a malicious
> > > coprocessor DoS the AP by sending messages faster than the AP can
> > > process them? freezing the system since preemption might be disabl=
ed
> > > here? I suppose thee's no good way to protect against that level of
> > > goofy.)
> >=20
> > The only way this can't terminate is if the co-processor tries to st=
all
> > us with messages, but what's your threat model here? If the co-proce=
ssor wants
> > to be evil it usually has many other ways to annoy us (e.g. ANS coul=
d just disable
> > NVMe, SMC could just trigger a shutdown, etc.)
> >=20
> > I could move this to threaded interrupt context though which would m=
ake that a bit
> > harder to pull off at the cost of a bit more latency from incoming m=
essages.
> > Not sure that's worth it though.
>=20
> Probably not worth it, no.

One small advantage of the threaded interrupt would be that the mailbox =
clients could
detect the invalid messages and at least get a chance to shut the channe=
l down if
the co-processor did this by accident.
Still not sure if that would actually help much but I guess it won't mat=
ter in
the end anyway. Changing this only requires to request a threaded irq in=
 the probe
function so it's also not a big deal either way.


>=20
> > >=20
> > > > +	 * There's no race if a message comes in between the check in =
the while
> > > > +	 * loop above and the ack below: If a new messages arrives inb=
etween
> > > > +	 * those two the interrupt will just fire again immediately af=
ter the
> > > > +	 * ack since it's level sensitive.
> > >=20
> > > I don't quite understand the reasoning. Why have IRQ controls at a=
ll
> > > then on the M3?
> >=20
> > Re-read the two lines just above this one. If the interrupt is not a=
cked here
> > it will keep firing even when there are no new messages.
> > But it's fine to ack it even when there are message available since =
it will
> > just trigger again immediately.
>=20
> Got it, thanks.
>=20
> > > > +	/*
> > > > +	 * Only some variants of this mailbox HW provide interrupt con=
trol
> > > > +	 * at the mailbox level. We therefore need to handle enabling/=
disabling
> > > > +	 * interrupts at the main interrupt controller anyway for hard=
ware that
> > > > +	 * doesn't. Just always keep the interrupts we care about enab=
led at
> > > > +	 * the mailbox level so that both hardware revisions behave al=
most
> > > > +	 * the same.
> > > > +	 */
> > >=20
> > > Cute. Does macOS do this? Are there any tradeoffs?
> >=20
> > Not sure if macOS does is and I also don't see a reason to care what=
 it
> > does exactly. I've verified that this works with the M3 mailboxes.
> > I also don't see why there would there be any tradeoffs.
> > Do you have anything specific in mind?
> >=20
> > I suspect this HW was used in previous SoCs where all four interrupts
> > shared a single line and required this chained interrupt controller
> > at the mailbox level. But since they are all separate on the M1 it's
> > just a nuisance we have to deal with - especially since the ASC
> > variant got rid of the interrupt controls.
>=20
> Makes sense for a legacy block =F0=9F=91=8D
>=20


Best,


Sven
