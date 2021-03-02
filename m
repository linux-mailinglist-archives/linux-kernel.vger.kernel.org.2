Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CBC32A84C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580124AbhCBR3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:29:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448612AbhCBPHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:07:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E11F764F42;
        Tue,  2 Mar 2021 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614697022;
        bh=OYRXFzNNuTlKILRI33Ey1i/DTxNtqM1YKXxKvQKx4N4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DfCbgKMqycOYqa6vkIArkKbgCfHn2Gb7ERiOJ8pppKXQRVy6oqjvTte6FY2XtVHS7
         2YiagAevDAnM4tHoxxStF6A9HFw57amQCKUTprTeKP0z5p/Oj+9PcLS0J9ypUuI3gW
         hu78OzUwNgOuHdvq0W2sXw3lM09NduxfGBAg1Y0S8W/tK9sgxUQ3WXmtNZi/TRZhAL
         9gCJ3TBiU/EJIWvMwBptzVsvP9Nw8GBFPgiozuRKKiWlkLNRV0AkBmx5RqRMv08+VN
         0vnky7Ni4d99cNTT6vwdU0x9PyGeUUQWy6djq+/j3395p2GRXxY8wkqIBXnH3hKa7n
         gNOtCibozGmjA==
Received: by mail-ed1-f53.google.com with SMTP id l12so25531792edt.3;
        Tue, 02 Mar 2021 06:57:01 -0800 (PST)
X-Gm-Message-State: AOAM531E2lDEaWszF+W+Tl+1cKE3sXjx8z7/ZIFN8eA2qPOKpg2ktVzD
        uityBT1VFvgHvUvx2M8e8FZ2pkEFL/BEKgEbKA==
X-Google-Smtp-Source: ABdhPJyOQjhu8QpzXxm3gjRgsjCtnH1S+FQjObTQigNPRVgE/zOQdHmeMC6USt0SikilodDuu3psdvaEg2aOTatDL9g=
X-Received: by 2002:a05:6402:c0f:: with SMTP id co15mr2856893edb.373.1614697020164;
 Tue, 02 Mar 2021 06:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20210225125921.13147-1-will@kernel.org> <CAL_JsqJX=TCCs7=gg486r9TN4NYscMTCLNfqJF9crskKPq-bTg@mail.gmail.com>
 <20210301144153.GA16716@willie-the-truck> <CAL_JsqJ11D-7a3pwLTVd+rHjqDGBb=b8OU_a6h3Co-at+2qMtQ@mail.gmail.com>
 <bbbf5def-a168-9a4c-1106-b80883dfd389@csgroup.eu>
In-Reply-To: <bbbf5def-a168-9a4c-1106-b80883dfd389@csgroup.eu>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 2 Mar 2021 08:56:47 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Te5+kQzbAMCzuRCkmoZWBDKGhynUC8BfvOm=R5jT4Jg@mail.gmail.com>
Message-ID: <CAL_Jsq+Te5+kQzbAMCzuRCkmoZWBDKGhynUC8BfvOm=R5jT4Jg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix CMDLINE_EXTEND handling for FDT "bootargs"
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Will Deacon <will@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Daniel Walker <danielwa@cisco.com>, devicetree@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Doug Anderson <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Max Uvarov <muvarov@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 11:45 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 01/03/2021 =C3=A0 18:26, Rob Herring a =C3=A9crit :
> > +PPC folks and Daniel W
> >
> > On Mon, Mar 1, 2021 at 8:42 AM Will Deacon <will@kernel.org> wrote:
> >>
> >> On Mon, Mar 01, 2021 at 08:19:32AM -0600, Rob Herring wrote:
> >>> On Thu, Feb 25, 2021 at 6:59 AM Will Deacon <will@kernel.org> wrote:
> >>>> We recently [1] enabled support for CMDLINE_EXTEND on arm64, however
> >>>> when I started looking at replacing Android's out-of-tree implementa=
tion [2]
> >>>
> >>> Did anyone go read the common, reworked version of all this I
> >>> referenced that supports prepend and append. Here it is again[1].
> >>> Maybe I should have been more assertive there and said 'extend' is
> >>> ambiguous.
> >>
> >> I tried reading that, but (a) most of the series is not in the mailing=
 list
> >> archives and (b) the patch that _is_ doesn't touch CMDLINE_EXTEND at a=
ll.
> >> Right now the code in mainline does the opposite of what it's document=
ed to
> >> do.
> >
> > Actually, there is a newer version I found:
> >
> > https://lore.kernel.org/linuxppc-dev/1551469472-53043-1-git-send-email-=
danielwa@cisco.com/
> > https://lore.kernel.org/linuxppc-dev/1551469472-53043-2-git-send-email-=
danielwa@cisco.com/
> > https://lore.kernel.org/linuxppc-dev/1551469472-53043-3-git-send-email-=
danielwa@cisco.com/
>
> This was seen as too much intrusive into powerpc.

It looked like the main issue was string functions for KASAN?

As far as being too complex, I think that will be needed if you look
at all architectures and non-DT cases.

> I proposed an alternative at
> https://patchwork.ozlabs.org/project/linuxppc-dev/cover/cover.1554195798.=
git.christophe.leroy@c-s.fr/ but
> never got any feedback.

Didn't go to a list I subscribe to. In particular, if it had gone to
DT list and into PW you would have gotten a reply from me.

Rob
