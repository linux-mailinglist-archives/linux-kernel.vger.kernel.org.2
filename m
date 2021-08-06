Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7B33E2854
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244972AbhHFKN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244941AbhHFKMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:12:38 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823F4C06179E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:12:20 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id h17so144815vsu.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RGtgXfwmYcFQbjYreqnR5225xrRr2PJrw8FOYkigses=;
        b=drslwnriHb49yiA4FlJ2IAOAFa854aF5V1BZ0IoT2jib2a1c08xPzIctwuJfh7ZvLT
         HQr0nBjioANUzY8Ll+Z58V5xQ/T+kjZy25luvbRQDaZMgfHEgJ2lD7p4B78HDw+pp8NB
         PnfwpqwE2bOKGxHi0aaxuHgpVYVLLSC4CCsYOcICHDs57pJl7FTYAlvroXjvLOf5sC0E
         1zEdGPqOEKNSjctAo9N3SRjxOWN3SgZUIKBSYff8wU1cZbbPqgtTCnZYny0YdE/p6ttT
         p/3lQXqGZLETA8PTLFMCteCqyWQZ9h6bvJS7hs3s3BKN1VU+6juNwKsEyt+y4bBgQ2te
         gkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RGtgXfwmYcFQbjYreqnR5225xrRr2PJrw8FOYkigses=;
        b=HBqN3aZ5a78jwYt1n3fKWxCt2hHVTkCg1NVI3fe3QFOUbczBlW2fEQviOxVssFEqj8
         2AjBNwdtLBlA+EeJhEOn5zhD18WY5fhi1dNuvn3uGziwQm+nJ3x+/fyNxo7cBmVj8VQw
         2H9WTnx1yFrLeEMlfI6tqMDoIdmGhbf/S54mJRkT2rEJq/ZEvT4EZJVjg7NnBt2DiYGV
         HFSBHqwS3ngTd0owuST95XYKPTfuVr4H7YUC3vbMz8H7YDQLDoXoRDR9hjkXLKjXrtG7
         m7eheyEiFWWWn5EdO9sX1gd3Nq867+3EzncUMOmQSuRXvMw3earaxUMm78tK2Tj9TOUD
         wGkg==
X-Gm-Message-State: AOAM5320mYhGmwdW7HRf0qkSUnXCxCnyZ8aEY7hXXzBU1rl6ImGmLaA0
        88spbtu1mZXlx8xj+3L4qaZan/oMrmYvZXJ6oaOT7g==
X-Google-Smtp-Source: ABdhPJwFvbyka1FymkHv0zUfPRnqStn9uGkOJdFEFPbVEBRbIhe7XbAdE8fyYW/ypueDW/Vqt2ndw67y3Ojhj50YFG4=
X-Received: by 2002:a67:328f:: with SMTP id y137mr8365666vsy.34.1628244739559;
 Fri, 06 Aug 2021 03:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210722051414.8331-1-jasonlai.genesyslogic@gmail.com>
 <CAPDyKFqwiaTNNLKt_O6njyB6HPL35_gYy6KRZXqM4HRKJinShg@mail.gmail.com> <CAG0XXUG5q8_o-A3K0LNVXoeJmXHn=N=uyR81p2ai0H827SeS4Q@mail.gmail.com>
In-Reply-To: <CAG0XXUG5q8_o-A3K0LNVXoeJmXHn=N=uyR81p2ai0H827SeS4Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Aug 2021 12:11:43 +0200
Message-ID: <CAPDyKFqB4nxv5andQktNDjGkf-vPfbiFVwkZ7PGOWW9NbdM+qA@mail.gmail.com>
Subject: Re: [RFC PATCH v3.2 00/29] Add support UHS-II for GL9755
To:     Lai Jason <jasonlai.genesyslogic@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Jason Lai <jason.lai@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021 at 08:37, Lai Jason <jasonlai.genesyslogic@gmail.com> wr=
ote:
>
> On Tue, 03 Aug 2021 at 12:23,   Ulf Hansson <ulf.hansson@linaro.org>  wro=
te:
> >
> > On Thu, 22 Jul 2021 at 07:14, Jason Lai <jasonlai.genesyslogic@gmail.co=
m> wrote:
> > >
> > > Summary
> > > =3D=3D=3D=3D=3D=3D=3D
> > > In these patches we focus on uhs2 side to address Ulf's suggestion wh=
ich
> > > was mentioned in patch [mmc: core: Preparations to support SD UHS-II =
cards].
> > >
> > >
> > > I moved codes in uhs2.c to proper functions in sd_uhs2.c, which shoul=
d meet
> > > Ulf's expection.
> > >
> > > Please review this series (particularly Patch 29/29).
> >
> > I think you have misunderstood the intent with the series that I
> > posted [1] a while ago. The idea was to add the foundation of what
> > should be needed in the mmc core to support UHS-II cards. Note, it's
> > only the foundation, not the complete code.
> >
> > In other words, I think you should base the next version of $subject
> > series *on top* of my series [1], rather than the opposite.
> >
> Actually, I understand your intention is to implement functions which
> can be applied to control all UHS-II cards.
> However, why do I choose to base it on =E2=80=9C[RFC,v3.1,00/27] Add supp=
ort
> UHS-II for GL9755=E2=80=9D?
> Because it contains a complete UHS-II interface(both host & card side)
> and UHS-II card can work normally.

It doesn't matter if things "work".

The code/patches need to be better organized than currently,
especially the changes for the mmc core, which is why I stepped in and
tried to help out earlier. Otherwise it is impossible for me to review
the changes, but also to maintain the code in the long run.

The sdhci part is likely a bit more mature as it has been reviewed and
iterated with Adrian/Ben/Akashi-san. However, new/more changes needed
when my suggested changes for the mmc core come into play.

[...]

Kind regards
Uffe
