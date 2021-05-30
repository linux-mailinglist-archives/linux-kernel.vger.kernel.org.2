Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49CB395097
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhE3LKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 07:10:44 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:44003 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE3LKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 07:10:41 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 31C255849E1;
        Sun, 30 May 2021 07:09:03 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sun, 30 May 2021 07:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=2hN+Y6whIltMm10I8URjSpg82Tc2
        xNvQpJgef9e0Lso=; b=3yxm8ZMxOOpax8We+5bmJ1kcUXGO118hg7ilPzQ8Pdyp
        1RUu/oUotRGBMHONPuHAl6HLJIkwfYvGj6JVCvWPg1X7244159mygY0xi9ujZWV1
        /GSOdilq9hDIJRU2ScziiwR/U21hQwxUcZzlp1MWOACYPwKVRFMzFclSp35B78qz
        s75lF7q+Eog0U8AhEsuSpF//QMtZo0r+JFa5Dw3O6nvVlGzIiDZK6L+LrlnHi9mi
        ZLoAcbSlezBYH2SB6a8ETeTf2HZCiFnb0J4JLReFDsA4hUjQU8vj/CKKoZExrTzL
        uy3XjavLMsDa5ITwglUMrC+aOgqRXOmu2T+qR1cW/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2hN+Y6
        whIltMm10I8URjSpg82Tc2xNvQpJgef9e0Lso=; b=E+E/wiF5bQgY4EgKydN4PM
        A1KAWksDctqpsGZ3nqW0O+o5OMMBaLmg2jT8VNsXYHA21giDbk1ppJzxpCSD2dw9
        EJR+xx9wg0OFbBEyCJbQQcb1IrlWPJkJ50PPYYBWkBFNKET1fW97BFrJ99U5r110
        gtF3FCBIMYVtNDfCD45xFULbBoWQeXlewrBNbWdaueKB1Gscm0SF3HRw6K6MAVvx
        8GkEhpQ8TMR2mhcAP1D7oHM0ZaCww/2iTf2ksYsHHHiraPYxpIqUJh9b11DVvZT7
        Gy4MkxiQDj+uGpE//2o1C1T5mDcKt46e/Yv1dcCxfS2+anl+kSM/LrWJvffXVaiA
        ==
X-ME-Sender: <xms:TnKzYCXjPZCRc_vgujAbilnOctKn5Bx7zMoW_d84Vo8P73AkFYODCQ>
    <xme:TnKzYOkQf8jarNYPd96DCvZ20tgMKT5USD2sAumM_daFRAZUvU4htJR2GqK_oy9Ao
    z1eJYVq820VtEx_Vtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeluddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:TnKzYGbhdyNMNpaMLz1W-z2VTLZ3VijXOLfixsP7kX66P_1PoAgLEA>
    <xmx:TnKzYJUIeFFFEJp5N-gPTuTZu888OYlldjwNMVE4BJ0J5A9JVuiZXg>
    <xmx:TnKzYMlJceNAEgfDKD_V-CtimGxik3ucyBig6x1vDXhDyj2hw3k87w>
    <xmx:T3KzYG7vGYtJieP1Gkb2u10jmIa8eKF-7qEUSLGv9OqC60tqFJH9hQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DF48F51C0060; Sun, 30 May 2021 07:09:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-468-gdb53729b73-fm-20210517.001-gdb53729b
Mime-Version: 1.0
Message-Id: <9ff6ec26-4b78-4684-9c23-16d5cbfef857@www.fastmail.com>
In-Reply-To: <YK32Mmiq9QXGkELF@atomide.com>
References: <20210524182745.22923-1-sven@svenpeter.dev>
 <CAL_JsqKqpSQbdj_Crc-LSc12700kyFFkMTU29BDY2bwGNLXn9A@mail.gmail.com>
 <YK32Mmiq9QXGkELF@atomide.com>
Date:   Sun, 30 May 2021 13:08:40 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Tony Lindgren" <tony@atomide.com>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hector Martin" <marcan@marcan.st>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH 0/3] Apple M1 clock gate driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 26, 2021, at 09:18, Tony Lindgren wrote:
> Hi,
> 
> * Rob Herring <robh+dt@kernel.org> [210525 18:09]:
> > I would do a single node per mmio region with the register offset (or
> > offset / 4) being the clock id. This can still support new SoCs easily
> > if you have a fallback compatible. If you want/need to get all the
> > clocks, just walk the DT 'clocks' properties and extract all the IDs.
> 
> I mostly agree.. Except I'd also leave out the artificial clock ID and
> just use real register offsets from the clock controller base instead.

Sure, I'll do that.

> 
> So a single clock controller node for each MMIO range, then set
> #clock=cells = <1>. Then the binding follows what we have for the
> interrupts-extended binding for example.
> 
> If the clock controller optionally needs some data in the dts,
> that can be added to the clock controller node. Or it can be driver
> internal built-in data. If the data for dts can be described in a
> generic way, even better :)

Now the big question is *how* to describe this additional data in the
dts. Essentially I need to specify that e.g. to enable clock 0x270
I first need to enable the (internal) clocks 0x1c0 and then 0x220.
Are you aware of any generic way to describe this? I'm not even sure
how a sane non-generic way would look like when I just have a single
clock controller node.



Best,

Sven
