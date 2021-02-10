Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316D8316462
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhBJKx4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Feb 2021 05:53:56 -0500
Received: from gloria.sntech.de ([185.11.138.130]:43390 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231518AbhBJKuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:50:12 -0500
Received: from [95.90.166.74] (helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l9n3f-0003Yx-RQ; Wed, 10 Feb 2021 11:49:19 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, robh+dt@kernel.org
Subject: Re: [PATCH 2/5] ARM: dts: rockchip: assign a fixed index to mmc devices on rv1108 boards
Date:   Wed, 10 Feb 2021 11:49:17 +0100
Message-ID: <46108228.fMDQidcC6G@diego>
In-Reply-To: <CAK8P3a25iYksubCnQb1-e5yj=crEsK37RB9Hn4ZGZMwcVVrG7g@mail.gmail.com>
References: <20210118155242.7172-1-jbx6244@gmail.com> <6598201.ejJDZkT8p0@diego> <CAK8P3a25iYksubCnQb1-e5yj=crEsK37RB9Hn4ZGZMwcVVrG7g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Februar 2021, 11:34:41 CET schrieb Arnd Bergmann:
> On Wed, Feb 10, 2021 at 12:50 AM Heiko Stübner <heiko@sntech.de> wrote:
> > Am Dienstag, 9. Februar 2021, 23:25:40 CET schrieb Arnd Bergmann:
> >
> > Hmm, right now I don't see the disadvantage of missing mmc numbers.
> 
> It's inconsistent with the normal use of these aliases across other
> platforms.
> 
> > As similarly we count i2c and serial numbers for a long time, even though
> > not all of them appear on every board.
> 
> Yes, that is a similar mistake.
> 
> > Especially as the main goal is to simply have stable numbers and
> > not having the mmc devices swap numbers on every boot.
> >
> > So right now we're not using them from a userspace POV but
> > instead agreed on following the address ordering of the soc.
> > so when ordering mmc controllers by their io-address, mmc0
> > is the first one, then mmc1, etc.
> >
> > So just for my understanding, what is different for mmc?
> > I guess to guarantee ongoing numbering similar to sd{a,b,c,...}
> > Or should all aliases be duplicted in each board dts and not
> > live in any soc dtsi?
> 
> Each board should have its own aliases node that describes
> exactly which of the devices are wired up on that board, and
> in which order. If there are connectors on the board that
> are labeled in some form, then the aliases are meant to
> match what is written on the board or in its documentation.

Then we're at least in the clear for i2c, serial and the rest ... as these
are numbered in the soc documentation, and all boards I've seen so
far use these number also to identify these in schematics.

So an i2c2 is always i2c2 even if i2c1 is not populated.

And of course doing
	i2c0 = &i2c2
would definitly confuse people to no end.

So I guess we'll just move the mmc stuff over to board files.


