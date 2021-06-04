Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB6E39B342
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 08:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhFDGwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 02:52:41 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:33365 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhFDGwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 02:52:39 -0400
Received: by mail-lf1-f45.google.com with SMTP id t7so5356804lff.0;
        Thu, 03 Jun 2021 23:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kaQSMao5BG9s/Mo5xQzGz0o3ckk1n5tL2skjZO8oAN4=;
        b=o2RBE89HEbwJAgw+1+TCT4by4UKkM2fIx3eDfTqZ2hpV+WJXf7sBAW8y/zrlnQcUso
         CY0xPzMTzkbS+s9gCuJ9rUOJSupkPofz18D7dmRK8vkUXOp00ydnJD35S/FxNDDIK9oY
         bsCbBBSI+8hFQz6jXHq21CD8QaFL8qBtTLlrTY3UjwnnK0mc5hL3sywWHIOMz65+PI3S
         3TSHYZJOtgaRT0rbGSQe6SWIySyOLHT6GtAihCIjr4guEEpBgMA4rO+OoYUXV6hfhAcU
         uS7BBZzDGTBEHsgIWtHQ5cGiD9ahjF+syOTfPZiIXmF4m6ZnR1kpCOCpQaEvymMrxGIs
         O7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kaQSMao5BG9s/Mo5xQzGz0o3ckk1n5tL2skjZO8oAN4=;
        b=CKIsK+rVwYk0jq5pKm+TITOQYvahkx1hpvxe0lBJ6YkEHKOrewRdLfN525ChXX7fH9
         Xwzey5B51g81zvi1CnenH3HXRqcAvblbqoGbT33ePdpY+atHPINnFaMPcB0biESGF1eI
         waYDOUQOhcI9O9i6kBcWO02TqhPQuctnQbBRE2Y2xLReEbORdeLr6zNhQ51uyIEXWHDw
         BbAlwqy3jqNJCEFGld3sAcF3nTrV5frMnO4472VVSs2MhILUlzYgU+1ES9MghDGcoZZV
         S+N+vF+6IbeOiIXcUQ1cj7CdD1f7VwFYZP5DGwJMUKXhjT7/2DVRmU7vV2Dx+8aZ979R
         yTxQ==
X-Gm-Message-State: AOAM53393PoIXh8jLSTcoaHhQUai3akFO/lptEJL0P5QoSM3vaDSTlLf
        xw7ywAtPmK1VJKzCs8FrciiyggJpAG9xghHmq5M=
X-Google-Smtp-Source: ABdhPJzpgIdt9qTidz6JILOFe6SgId4AwPgluxUxDYfG8w8Nhgqz3Z5eMejUiYcCBKnp5ESehgaWueQPLTdiD6jOxlg=
X-Received: by 2002:a05:6512:3e14:: with SMTP id i20mr171986lfv.474.1622789380421;
 Thu, 03 Jun 2021 23:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <1243888060.510560.1612783497400@ichabod.co-bxl>
 <20210210150118.ly252i37eykayrcb@gilmour> <1719200956.433094.1613199092092@ichabod.co-bxl>
 <6612268.HtAl026vyE@jernej-laptop> <206881200.203318.1622780349817@ichabod.co-bxl>
In-Reply-To: <206881200.203318.1622780349817@ichabod.co-bxl>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Fri, 4 Jun 2021 16:49:28 +1000
Message-ID: <CAGRGNgVSze9yW6KTsC=KGCVOJLzck65J-f9v8y30iBw7k0KXQA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix
 Ethernet PHY mode
To:     broake@mailfence.com
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 4, 2021 at 3:45 PM 'B.R. Oake' via linux-sunxi
<linux-sunxi@googlegroups.com> wrote:
>
> On Sat Feb 13 09:51:17 CET 2021, Jernej =C5=A0krabec wrote:
> > Let me first explain that it was oversight on my side not noticing init=
ials in
> > your SoB tag. But since the issue was raised by Maxime, I didn't follow=
 up.
> > [...]
>
> Dear Jernej,
>
> First of all, thank you very much for all your linux-sunxi work: I
> especially appreciate the video support you've provided.
>
> Thank you for initially approving my patch. Although I first posted a
> patch to the linux-sunxi list about seven years ago, this patch was my
> first formal submission to LKML, so it meant a lot to me to see it
> accepted by a kernel developer, even if only briefly.
>
> I'm sorry for taking a long time to reply. I wanted to wait for the
> maintainers to respond to my last mail because I thought it would be
> best for them to speak for themselves on this issue. Sadly I haven't
> yet received a response from them.
>
>
> > I believe that real name means no initials, no matter what people are
> > accustomed to. From my point of view, CJ is pseudonym derived from real=
 name.
>
> I don't think that's a widely held belief though. For example, I think
> most people consider "J.R.R. Tolkien" to be a real name, even though it
> contains initials. Also, a first name like CJ isn't necessarily derived
> from some longer name like Cathy Jane, it can simply be the person's
> given name. I'm grateful to Vagrant Cascadian for drawing our attention
> to Patrick McKenzie's essay "Falsehoods Programmers Believe About Names".
> I believe we harm Linux development when we exclude people whose names
> don't fit our assumptions.
>
> Another reason for signing with initials is to ensure that other people
> cannot infer anything about the author's gender. Women especially might
> choose to do this to avoid the harassment that a female name can attract,
> as shown in these studies for example:
>
> https://ece.umd.edu/news/story/study-finds-femalename-chat-users-get-25-t=
imes-more-malicious-messages
> https://www.reach3insights.com/women-gaming-study
>
> If we forbid people from contributing in a gender-neutral way, many may
> feel they cannot contribute at all. Again, I think that when we exclude
> these people we are all worse off as a result.

While I completely sympathise with your points here, the issue isn't a
technical or social issue, but a legal one.

The DCO was introduced to provide a mechanism to trace the origin of a
piece of code for legal purposes, so my understanding is that the name
supplied needs to be your legal name.

Whilst, as you've pointed out, there are a lot of ways that names
don't match up to the normal "Firstname I. N. I. T. I. A. L. S.
Lastname" format, that is the case for the vast majority of people and
exceptions to that are rare. Your arguments against providing that
name haven't exactly helped your case either as they are similar to
the arguments someone trying to hide behind a pseudonym might use.

Your points about previous instances of this happening also don't hold
water either as we don't know the circumstances behind those cases.
Git's history is considered immutable once it makes it to an
"official" repository (generally one published publicly) so it's
likely they were oversights that weren't caught until it was too late.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
