Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DC23FCFBD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 01:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbhHaXBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 19:01:30 -0400
Received: from mail-4322.protonmail.ch ([185.70.43.22]:63487 "EHLO
        mail-4322.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbhHaXB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 19:01:28 -0400
Date:   Tue, 31 Aug 2021 23:00:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanbrattlof.com;
        s=protonmail; t=1630450829;
        bh=noA0FZoSk+OcatcyPOJCreA4yUOp3PHiHQgl9tJ6gww=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Ta45suJT0EnyDHCLyFsvdwkZId3zgaID66MMTGAGyzYFdePMbUATJPHyxScunxv9L
         I8jkflsJ1mGxzZyT16kpOzpDXPH8gIivCDCMosCQXYiVSeeol9GJilBbqKj2jfaDeJ
         HFbGjNDSdh2cQ/J0SXZrzWusDtjq9j+yYGfZ/wAT2L+toYe4GPRieeR4tUClnBaDTs
         SKv3mrtn/v4chh1M/fDBtCdGt3ARMJZjPC1/MKsXwHkpLIEtfQ5y4aBc9k0c+vxi1x
         clPnkWfl/oROrmsEcCxkZFry2i1fAKc31o6PmF0JEJZn5D9R0jh7Z6jb0Iq6g4azwk
         x+JHCNNJrCeUQ==
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
From:   Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Krish Jain <krishjain02939@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Reply-To: Bryan Brattlof <hello@bryanbrattlof.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
Message-ID: <20210831230014.cp46vho2hnndacjp@h510>
In-Reply-To: <13366651.n50aozgL3V@localhost.localdomain>
References: <20210829144531.c2syu4vv4s22dlg7@h510> <CAPGkw+wyH3Pj6DV_m8wqCV5yujhjRwTwVNs6dK4i9JO-Y3ys6w@mail.gmail.com> <20210831133533.6aayzjghdakrhy56@h510> <13366651.n50aozgL3V@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this day, August 31, 2021, thus sayeth Fabio M. De Francesco:
>
> I just want to *really* thank you for the hard work you got involved and =
that
> you carried out with one of the highest levels of professionalism (and
> patience :)) very few of us could ever equal (not I, for sure).
>
> I thank you also not for the technical hints you gave to Krish, instead f=
or
> your your choice "to not rob [you] Krish the opportunity to learn".
>
> Actually I was tempted to write something like "first do this, than that,=
 and
> finally run this tool". But I was able to desist, by learning from you ho=
w
> people should be helped for real.
>
> Most of us here should learn by your attitude.
>
> Thanks again, seriously.
>

Thank you for such kind words, Fabio.

I was very lucky to be, and still am, surrounded by people who
demonstrated this idea to me when I was young. I am very happy to see
others here see how beneficial and helpful (in the long term) learning
this way can be.

I'm grateful to have found and be a part of this community.
~Bryan

