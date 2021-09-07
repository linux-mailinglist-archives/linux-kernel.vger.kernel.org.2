Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C004402FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346502AbhIGU1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:27:49 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39027 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346457AbhIGU1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:27:47 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 664BF5C0152;
        Tue,  7 Sep 2021 16:26:40 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Tue, 07 Sep 2021 16:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=lcpU2CxkGVxmNJlEgg40FlED8MuY
        46mhZqXqU1CnrRQ=; b=VjcHXlXAALRMftUEOdXM6giehfWYvRiyBMyyYGIXffPZ
        YMTOvDYAItd4hZB40+/NQjN+W1qaVkX5CUFODvGX/RiVBJYhSOzOz13X6t166qM2
        EvcU8MY8g9st6pVtZJZ/lnWdutcYf0mZDWWojV4QBBsDvqQNjCSn5n4jienM77Jx
        dw8MPrEyLYXHwRX1rsm41zQck14brFoKkHL3+7wikiNnSMErysNZVaR8PQg2A89b
        qZdx6m1vC+gS7r89faBcb4lhVjYtxYEOqPJW8MjiwVmkSS6fl5vxJs67SDBsfmaM
        KvayNwVDjBCQx2TuCwvadHkWCDItS97ynUJ3JR/Zqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=lcpU2C
        xkGVxmNJlEgg40FlED8MuY46mhZqXqU1CnrRQ=; b=KIRudOLKGrSUVYTPzOw7BJ
        te7I+q51c9DsYZ0Yz1D6oM9MyUQnRfga6EdCYLXNSfF/Ai6P35rwacb+2rWX6N3S
        Tncij3mLh1lE1a0QbZjc+q05oDgdy1F5EnJN7oXOxqbM8htzHKFkGfVFRRVlUfSH
        Fzw9jBvydmBrd1Hm/4Rj10sktRbQp+I6bIrpuyH+P+XvioBgRjkOBZpFPopGxioy
        TWpna7O8efxiE1n0vRcUv4E0Mtxzfp066hMmu7OIET2kxdAZJNtqHNWqHIg931pU
        1FYmUMJ/FwnznYoaDXnR6G5kNEm0Mg5gADYgIXMWjd9goYvORHqQSG2pDjCPWFOw
        ==
X-ME-Sender: <xms:_so3YXDDPjIBTx_RdwC497gX2ANCbQJoppWbdA6mUCwAMp9WPoW0TA>
    <xme:_so3YdjyhVse3DRyoxKyE_drG6yFaYgm3WNOUIowqVHKDJxt09Y7vzntH5_ikhpS8
    -ysmSUyrIEkdp_pOsM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefhedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:_so3YSnOtnZhYCbTHc0NChq0Dfest5tSxwJUQ8GpOzHNEczOWRuFWA>
    <xmx:_so3YZwJvqmQrOKZhb6G-5dUyUudiTN1FhUErBXbAeLv2MR1Tnm5zw>
    <xmx:_so3YcQDoGKK0GfB0PtaS38QbuEbrm2BwMOwYkEz8dHnJbi2RTRTkg>
    <xmx:AMs3YRTjMUWlKqiUoNjyd5LiSh4EGNmrv4eKWnkKiYgb91zF8ry2TA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C7D0C51C0060; Tue,  7 Sep 2021 16:26:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1126-g6962059b07-fm-20210901.001-g6962059b
Mime-Version: 1.0
Message-Id: <ff66c30d-1b43-43d3-a4b0-02fe7d346118@www.fastmail.com>
In-Reply-To: <YTe17jGBobarePaK@sunset>
References: <20210907145501.69161-1-sven@svenpeter.dev>
 <20210907145501.69161-3-sven@svenpeter.dev> <YTe17jGBobarePaK@sunset>
Date:   Tue, 07 Sep 2021 22:26:17 +0200
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
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Tue, Sep 7, 2021, at 20:56, Alyssa Rosenzweig wrote:
> > +      - description:
> > +          M3 mailboxes are an older variant with a slightly different MMIO
> > +          interface still found on the M1.
> > +        items:
> > +          - const: apple,t8103-m3-mailbox
> 
> Would be nice to document an example of where an M3 mailbox is found.

Sure, I can add a comment that this is used for the coprocessor controlling Thunderbolt.

> 
> > +  interrupts:
> > +    minItems: 4
> > +    items:
> > +      - description: send fifo is empty interrupt
> > +      - description: send fifo is not empty interrupt
> > +      - description: receive fifo is empty interrupt
> > +      - description: receive fifo is not empty interrupt
> > +
> > +  interrupt-names:
> > +    minItems: 4
> > +    items:
> > +      - const: send-empty
> > +      - const: send-not-empty
> > +      - const: recv-empty
> > +      - const: recv-not-empty
> 
> If the names became not-constant the asprintf thing goes away, not sure
> that's better or worse.

I'm not sure I understand your comment here. This property just gives a name
to the interrupts so that they can be referenced by that instead of a magic
number between 0 and 4 in the driver.

> 
> > +  clocks:
> > +    description:
> > +      Reference to the clock gate phandle(s) if required for this mailbox.
> > +      Optional since not all mailboxes are attached to a clock gate.
> 
> Do we do anything with the clocks at this point?
> 

The device tree bindings describe the hardware (as best as we can without proper
documentation) and some of these mailboxes have clock gates which need to be turned
on before accessing their MMIO. This driver already tries to do that and works fine
with the downstream clock driver(s) we have.



Sven
