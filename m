Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76E03DEC1C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhHCLg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:36:59 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:20533 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbhHCLgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:36:41 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 173BZxL8029685
        for <linux-kernel@vger.kernel.org>; Tue, 3 Aug 2021 20:35:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 173BZxL8029685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627990559;
        bh=4g7op37K4Z7RFzfmHtUvzT54GZur3wtjaNHjXMQo4LE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=htrX2UOyfSgvrqYCB4WrfH/i9QHUI/emesVufbUbgrcdObAMnhi7Ashf/+earXB+O
         aoeMvnJJ7w1/jKS4GuTYGc+MMaeT3FAfGpjKQAP9zCLcuiHuMAduWaMRPP6sYOfQVW
         6kuGCg1mNwVROEyKCKDObRlNvp6TT3g2EN6RbVFBvY0+nI42ni/rnz7rQyh4gC7/7y
         PIcPQvb7/PuDpTYqi2HN/81OkcPgp7OrOPa1CQwqxC1rRtXN+vK2McSQ0XBlfiy18c
         4sIozc06sQsEuRkh06aMv4qw3ioHX/KdrLhv9JmJRvQSEvG0otFbO8M+L9pJevCWdh
         h5nOvyC8XE+8w==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so3396386pjr.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 04:35:59 -0700 (PDT)
X-Gm-Message-State: AOAM533qqUMqzjJlPTt8L1rs/kil8NUo9vF/9IyZKtKo5+5BXiGYt5Vr
        JSM6SPiG7znQGx4WiZw/vldDyYmfZsTvrT1RRls=
X-Google-Smtp-Source: ABdhPJwL89MAz94d0LBxKuDkJqZz8BdoQK05FCU7uOspMiDDfVIZYNvXNETLBcZjCjirIS25cqz74I4n89sJnpdKuGY=
X-Received: by 2002:a17:902:e28a:b029:12c:13e9:1166 with SMTP id
 o10-20020a170902e28ab029012c13e91166mr1178827plc.47.1627990558641; Tue, 03
 Aug 2021 04:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210729140527.443116-1-masahiroy@kernel.org> <20210802124624.GG18685@arm.com>
 <CAK7LNARFWRgGsea03mZJfSPjyxYLxz3g6fjTs9aon9hxYvsxcw@mail.gmail.com> <20210803090626.GA30265@willie-the-truck>
In-Reply-To: <20210803090626.GA30265@willie-the-truck>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 3 Aug 2021 20:35:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ1pRhpZYVEnyZCdqizFRo+1T_fJjCXciG42a_qNnKsnQ@mail.gmail.com>
Message-ID: <CAK7LNAQ1pRhpZYVEnyZCdqizFRo+1T_fJjCXciG42a_qNnKsnQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: move the (z)install rules to arch/arm64/Makefile
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 6:06 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Aug 03, 2021 at 02:40:44PM +0900, Masahiro Yamada wrote:
> > On Mon, Aug 2, 2021 at 9:46 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >
> > > On Thu, Jul 29, 2021 at 11:05:27PM +0900, Masahiro Yamada wrote:
> > > > Currently, the (z)install targets in arch/arm64/Makefile descend into
> > > > arch/arm64/boot/Makefile to invoke the shell script, but there is no
> > > > good reason to do so.
> > > >
> > > > arch/arm64/Makefile can run the shell script directly.
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > > >
> > > >  arch/arm64/Makefile      | 7 +++++--
> > > >  arch/arm64/boot/Makefile | 8 --------
> > > >  2 files changed, 5 insertions(+), 10 deletions(-)
> > >
> > > Is this part of some cross-arch clean-up? I can see x86 for example does
> > > the same thing.
> > >
> > > Thanks.
> > >
> >
> > Yes. I want to do these cleanups tree-wide, but
> > I sent patches per arch.
> >
> > Please pick it up to your arm64 tree
> > if you do not mind.
>
> Just to confirm -- this would be for 5.15, right?
>
> Will


Right.

This is not a bug fix, but a clean-up.

So, we can queue it for the next MW.


-- 
Best Regards
Masahiro Yamada
