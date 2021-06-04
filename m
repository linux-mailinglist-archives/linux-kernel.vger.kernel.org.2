Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132D039B17D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 06:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhFDE1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 00:27:22 -0400
Received: from mailout-l3b-97.contactoffice.com ([212.3.242.97]:42276 "EHLO
        mailout-l3b-97.contactoffice.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhFDE1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 00:27:22 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2021 00:27:21 EDT
Received: from ichabod.co-bxl (ichabod.co-bxl [10.2.0.36])
        by mailout-l3b-97.contactoffice.com (Postfix) with ESMTP id 52793A46;
        Fri,  4 Jun 2021 06:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1622780353;
        s=20210208-e7xh; d=mailfence.com; i=broake@mailfence.com;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=2612; bh=w2nEVGuGdnczyTILlBwY6TwUcHmF3Bc7DpAA05kNbHo=;
        b=iIqRpOU6RY5cQRiKIWXgf4p1szQsoDAMn0GzrkbtaOwA1eF005MnYbli2c1UMIEO
        bjCnW/6RkGkGzk+1A65dKuRjI2UB7FdxTCJvoTOLn2CHJwQ2QjeE+Rc53oajfavydnx
        oaN14H6z8+ojI0whfDK24OTS+NwtRtfRW7c3EtAAIKmFQYljwiGtKeQwjSJ+Us8BuBe
        fQgHmKbNnMF4oW80qw7pCbQobTN++uS6sG2V9q7/gG/cuxRTooNX/2F5bU0lRmeowZ+
        DRjDLT8ibdCrQfcnNXAxi5vogD0ZGa+vLMaF8uhP0KBAeQtDaGJdtrjwopw/gStSi9h
        wRKzUcnU7g==
Date:   Fri, 4 Jun 2021 06:19:09 +0200 (CEST)
From:   "B.R. Oake" <broake@mailfence.com>
Reply-To: "B.R. Oake" <broake@mailfence.com>
To:     =?utf-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, devicetree@vger.kernel.org
Message-ID: <206881200.203318.1622780349817@ichabod.co-bxl>
In-Reply-To: <6612268.HtAl026vyE@jernej-laptop>
References: <1243888060.510560.1612783497400@ichabod.co-bxl> <20210210150118.ly252i37eykayrcb@gilmour> <1719200956.433094.1613199092092@ichabod.co-bxl> <6612268.HtAl026vyE@jernej-laptop>
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix Ethernet PHY
 mode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Mailer: ContactOffice Mail
X-ContactOffice-Account: com:276068926
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Feb 13 09:51:17 CET 2021, Jernej =C5=A0krabec wrote:
> Let me first explain that it was oversight on my side not noticing initia=
ls in=20
> your SoB tag. But since the issue was raised by Maxime, I didn't follow u=
p.
> [...]

Dear Jernej,

First of all, thank you very much for all your linux-sunxi work: I=20
especially appreciate the video support you've provided.

Thank you for initially approving my patch. Although I first posted a=20
patch to the linux-sunxi list about seven years ago, this patch was my=20
first formal submission to LKML, so it meant a lot to me to see it=20
accepted by a kernel developer, even if only briefly.

I'm sorry for taking a long time to reply. I wanted to wait for the=20
maintainers to respond to my last mail because I thought it would be=20
best for them to speak for themselves on this issue. Sadly I haven't=20
yet received a response from them.


> I believe that real name means no initials, no matter what people are=20
> accustomed to. From my point of view, CJ is pseudonym derived from real n=
ame.

I don't think that's a widely held belief though. For example, I think=20
most people consider "J.R.R. Tolkien" to be a real name, even though it=20
contains initials. Also, a first name like CJ isn't necessarily derived=20
from some longer name like Cathy Jane, it can simply be the person's=20
given name. I'm grateful to Vagrant Cascadian for drawing our attention=20
to Patrick McKenzie's essay "Falsehoods Programmers Believe About Names".=
=20
I believe we harm Linux development when we exclude people whose names=20
don't fit our assumptions.

Another reason for signing with initials is to ensure that other people=20
cannot infer anything about the author's gender. Women especially might=20
choose to do this to avoid the harassment that a female name can attract,=
=20
as shown in these studies for example:

https://ece.umd.edu/news/story/study-finds-femalename-chat-users-get-25-tim=
es-more-malicious-messages
https://www.reach3insights.com/women-gaming-study

If we forbid people from contributing in a gender-neutral way, many may=20
feel they cannot contribute at all. Again, I think that when we exclude=20
these people we are all worse off as a result.


> Speaking generally, not only for this case, prior art arguments rarely ho=
ld,=20
> [...]
> This is not the first time that fix of SoB tag was requested, you can fin=
d such=20
> requests in ML archives.

Isn't that a prior art argument? ;-)

Best wishes,
B.R.


--=20
Mailfence.com
Private and secure email
