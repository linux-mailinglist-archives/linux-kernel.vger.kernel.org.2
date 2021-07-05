Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600EF3BB48F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 02:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhGEAvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 20:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhGEAvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 20:51:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972E9C061574;
        Sun,  4 Jul 2021 17:48:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r26so11912156lfp.2;
        Sun, 04 Jul 2021 17:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zbny6c4U5xIiHOmoSTTHs4i8OEndtnMhRSM0VtOkERs=;
        b=sAXo4x/vOOlwkXdE+3nC3QO4YjOIakudSwwvHQN9NnxQCP9pjuIsiXbI8H8N4gfdGf
         GF8+mN/O1J+nj5gccgUQv5TNJ4TMwMwG87BvAbmXp0ZKoxj9Faf+H9OudqKwJrpQ4orI
         F2Dv6Lm/1GUcCflk9YcUxdrbSNVPBLPyvaNz14hUMMBru9lq6kr/FX8HIoqG0T77iW8x
         kkzAKjl4RL93xIoqjGCEdepIfLMPhA+D3OO1WtkWqbhUU/K520650SbNYnymB+lVwdyY
         IjI1dZH+Kz+oo5jG2EqTjklVHHiX+WVFEBymX+pzLmcVlgqJxZ+xR7BorTUIII70kTOj
         31wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zbny6c4U5xIiHOmoSTTHs4i8OEndtnMhRSM0VtOkERs=;
        b=oPkr5zvIzZRp4WfHwMli1OFjZ6g6xWrGNcoWQMvsljtFxp2f0HPHeuJ5oQEH5DkkXc
         0LaRJbG2UFfbcZehOfrfVufCyOHnJNCmQgXF4gJcRce+T0QsawA2Hp1enrlb7VCLyDpg
         iAXiGipu4wQZ3tnz981+fNTjk3RwTmNs6ojyIe71/6+eTcUCkavJlgBxcXfpB/hWt/nf
         OPJTMCvEY/BCD2Jpf+HpgNQs5SDMDVRsjTHw7JXww5a+3yBvSQAT46ftXH5CxTNvAPJA
         pKzNkFlGORwHCr/z8h1aJxEWTNA/zNNZWOKts+I2W83rN1ON9vJsjsvEGKOp2Q9bzexI
         a/gQ==
X-Gm-Message-State: AOAM530bgagVjvLI7IF/1mvni7yenvIIEY7se0AE2v1ZHFxBywgFExG9
        RPHd1I/aNBu+oDXPrvJ4T44rHQJuJsWvSKn6Utk=
X-Google-Smtp-Source: ABdhPJyO+Fh66SzuQVx4z1RCdu7stkCBJn2n70+cZ8Uz9me9HiobpU1kclyK9HFiiNFwoO+l5bRrs5HYsOIg5V25i+c=
X-Received: by 2002:ac2:55a7:: with SMTP id y7mr8598442lfg.179.1625446137972;
 Sun, 04 Jul 2021 17:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <1243888060.510560.1612783497400@ichabod.co-bxl>
 <20210210150118.ly252i37eykayrcb@gilmour> <1719200956.433094.1613199092092@ichabod.co-bxl>
 <6612268.HtAl026vyE@jernej-laptop> <206881200.203318.1622780349817@ichabod.co-bxl>
 <CAGRGNgVSze9yW6KTsC=KGCVOJLzck65J-f9v8y30iBw7k0KXQA@mail.gmail.com> <131830164.377678.1625444303416@ichabod.co-bxl>
In-Reply-To: <131830164.377678.1625444303416@ichabod.co-bxl>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 5 Jul 2021 10:48:46 +1000
Message-ID: <CAGRGNgWEFXLYL7Day6TC9XM5zWPYyq3+7TAYGpLWLoD=Kg-Nnw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix
 Ethernet PHY mode
To:     "B.R. Oake" <broake@mailfence.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You're veering dangerously close to troll territory, but I'll give you
one last response on this.

On Mon, Jul 5, 2021 at 10:18 AM B.R. Oake <broake@mailfence.com> wrote:
>
> On Fri Jun 04 08:49:28 CEST 2021, Julian Calaby wrote:
> > While I completely sympathise with your points here, the issue isn't a
> > technical or social issue, but a legal one.
> > [...]
>
> Dear Julian,
>
> Thank you for giving your point of view on this issue, and sorry for not
> replying sooner. Thanks also for your work on the Atheros wifi driver,
> which I've used a lot. I think it's a particularly important one since
> it's one of the few wireless chipsets with open firmware.
>
>
> > The DCO was introduced to provide a mechanism to trace the origin of a
> > piece of code for legal purposes, so my understanding is that the name
> > supplied needs to be your legal name.
>
> Please could you say what you mean by "legal name"? For example, do you
> consider "J.R.R. Tolkien" to be a legal name?

Nope, I'd be surprised if that was his legal name. I'd expect it would
have been "John Tolkien" or "John Ronald Reuel Tolkien".

> Can you give an example of a legal purpose for which the DCO was
> intended and which fails when the DCO is signed with a name like
> G. Robinson or C.J. Newton?

https://lkml.org/lkml/2004/5/23/10 is the rationale behind the DCO.
The TL;DR is that SCO was claiming that code was written by them and
suing people over that. The DCO was developed as a method to assign a
legal origin to contributions to Linux.

My understanding is that there needs to be some way to link up a piece
of code with an actual physical person, so "real" / "legal" name +
email was chosen as the simplest solution. My understanding is that if
your name on your passport / drivers license / official id card is
"B.R. Oake" then we're good, otherwise use the name that would be used
in a legal document.

> > Whilst, as you've pointed out, there are a lot of ways that names
> > don't match up to the normal "Firstname I. N. I. T. I. A. L. S.
> > Lastname" format, that is the case for the vast majority of people and
> > exceptions to that are rare.
>
> I'm not sure about that - for example, Mandarin names don't really fit
> that template. But even if exceptions were rare, would that mean those
> people and their contributions didn't matter?

Here's an example of someone who I believe is a Chinese national using
a anglicised chinese name as their name in a patch:
https://lore.kernel.org/linux-wireless/20210517050141.61488-6-shenyang39@huawei.com/

Here's another example:
https://lore.kernel.org/linux-wireless/2e938041399b47ae04c6c339c6cd5cdb7786ee6b.1623912317.git.ryder.lee@mediatek.com/

> > Your arguments against providing that
> > name haven't exactly helped your case [...]
>
> Well I didn't actually argue against providing a name of the form you've
> specified - I have no objection to authors doing that if they want to. I
> just gave some reasons why an author might sign with a name of the form
> J.K. Smith. When a practice is contested I believe it does help to show
> that it has legitimate reasons.

The first link above was found on the third search result on Bing.
It's not difficult to find out why this practice has been adopted and
what the reasoning behind it is.

> > Your points about previous instances of this happening also don't hold
> > water either as we don't know the circumstances behind those cases.
> > Git's history is considered immutable once it makes it to an
> > "official" repository (generally one published publicly) so it's
> > likely they were oversights that weren't caught until it was too late.
>
> Although the history might be immutable, offending commits can still be
> reverted. However, I have not found any examples of this happening to
> the commits by the authors I mentioned, which suggests there is no
> problem with having them.

Reverting doesn't eliminate history, it just puts things back to how
they were. Kinda like tidying a room the day after you messed it up
instead of changing history to not mess it up at all.

I don't believe that reverting is a strong enough act to fix these
sorts of issues.

> And I think we do know a bit about their circumstances. To take one
> example, over an 18-month period I can see 72 commits authored by KP
> Singh which were variously committed, signed off, acknowledged and
> reviewed by Daniel Borkmann, Yonghong Song, Mimi Zohar, Alexei
> Starovoitov, Andrii Nakryiko, Martin KaFai Lau, Song Liu, Florent
> Revest, James Morris, Andrew Morton, Linus Torvalds, Brendan Jackman,
> Thomas Garnier, Kees Cook, Casey Schaufler and Randy Dunlap.
>
> It doesn't seem very likely that these approvals were all oversights. It
> seems a lot more likely that there is actually no problem with names of
> this form.

Or perhaps KP is that person's legal name and they've proven that
sufficiently to the various people involved. Perhaps the changes they
make are considered minor enough that it's not likely to be a problem
in the future. Or perhaps the maintainer who accepted the patches has
lower standards than Maxime. Generally subsystem maintainers assume
that driver maintainers do the right thing. So It's possible that most
of those people assumed that everything was fine and whoever accepted
the patch initially (Probably the second Signed-off-by line) was fine
with this.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
