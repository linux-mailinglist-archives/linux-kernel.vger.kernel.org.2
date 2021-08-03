Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD7F3DE64A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 07:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhHCFlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 01:41:52 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:54046 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhHCFlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:41:50 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 1735fNxQ029902
        for <linux-kernel@vger.kernel.org>; Tue, 3 Aug 2021 14:41:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 1735fNxQ029902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1627969283;
        bh=ViaPnwpbmXT/7F8lQ252gytz1LPyxMDXw/eLqLQ+tS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0E/eTrWQvraAtD+M6NVVMwuCSlMrAhO08AJwRU0pV51W5APN0q22X1wiUbT9/kvWv
         no61GCh8m4lZf6e21FeEvRUOMQnmbDOr0W4CmN9so5So2R/Qx2/ZZ7EEfjHaV19Ke5
         TAj0yoAqR3w7zUaiTvVvKtTpf2BG1grSXIjrAglbrOxL0LdHBXkY68oIvBlBvUt5Pp
         PZ63jYSpYrf5Po8NcscpjyPamPZy26GS6n/NU1NzKOPKHQ8X50agDyL1Dnx2Xrjub+
         hBh/gcecO7Zg+cK8dyiDl96Czrbgs5Ddixrj9oBh9pRbYT5K2Mqx9jARUzCPLRmV6j
         luSASlm9jhcuw==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so2291116pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 22:41:23 -0700 (PDT)
X-Gm-Message-State: AOAM530kPXLdjMHBwm9Zxabmc6SGehrSi+fxJI9cssPgWPNXrSCN7ycn
        eUqEDJ6lEjWx/Cy7cPduLoXoFrGs2wZicHfUAXQ=
X-Google-Smtp-Source: ABdhPJzREULFuTK23zdIrPuCKXys9eGxfHn8HeDU3FLnvRnRAGSTSdj8oJwpXyRBE987wvMPwqZTHDA7yPIzjJ0cJA8=
X-Received: by 2002:a63:dd51:: with SMTP id g17mr283420pgj.47.1627969282733;
 Mon, 02 Aug 2021 22:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210729140527.443116-1-masahiroy@kernel.org> <20210802124624.GG18685@arm.com>
In-Reply-To: <20210802124624.GG18685@arm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 3 Aug 2021 14:40:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARFWRgGsea03mZJfSPjyxYLxz3g6fjTs9aon9hxYvsxcw@mail.gmail.com>
Message-ID: <CAK7LNARFWRgGsea03mZJfSPjyxYLxz3g6fjTs9aon9hxYvsxcw@mail.gmail.com>
Subject: Re: [PATCH] arm64: move the (z)install rules to arch/arm64/Makefile
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 9:46 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Jul 29, 2021 at 11:05:27PM +0900, Masahiro Yamada wrote:
> > Currently, the (z)install targets in arch/arm64/Makefile descend into
> > arch/arm64/boot/Makefile to invoke the shell script, but there is no
> > good reason to do so.
> >
> > arch/arm64/Makefile can run the shell script directly.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/arm64/Makefile      | 7 +++++--
> >  arch/arm64/boot/Makefile | 8 --------
> >  2 files changed, 5 insertions(+), 10 deletions(-)
>
> Is this part of some cross-arch clean-up? I can see x86 for example does
> the same thing.
>
> Thanks.
>

Yes. I want to do these cleanups tree-wide, but
I sent patches per arch.

Please pick it up to your arm64 tree
if you do not mind.



-- 
Best Regards
Masahiro Yamada
