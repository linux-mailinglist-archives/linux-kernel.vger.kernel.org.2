Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D852339C055
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFDTVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhFDTVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:21:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAA8060FF2;
        Fri,  4 Jun 2021 19:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622834372;
        bh=P6IaSvqgJAriq/iT+X5V+CNKjpfeWSTD2AHq/76koTg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ejX9ePwh000rZ2RTbyRE2Pe6GXBBS2PN/Wc2oQVAatnlpWfaZcBkhfYgA7oi7KBZn
         6wm1k9Q2hVgmWBcHCX9BJuhuE8ynJTW9gIY8PLmC8/4VX1DqvyQm4zfT2m3j8A4BA/
         XIFwT2rmdyCcybtxJx1qIFNfrY8PRG4hWpIi9DqvLPRMoB1ZqfVUeddqQ6QJ8ZS7Ux
         buA+sQUzvHLai7nTi7a/r13HgUoa6oPikJzhCtGPXshgkEgGr9YY1WSz/gW+BtPch3
         ywX5jhxbRgzzkyewaIpqqriBej+9+ZUuXaFCjPgMWbSOa+XzdoSZwogroXDYEhWk4W
         cWCLSBbBOJciQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210604132335.GK2435141@dell>
References: <1595493126-21611-1-git-send-email-wendell.lin@mediatek.com> <1597052186.27843.1.camel@mtkswgap22> <CAF2Aj3hZB08d8x6XOqsP4m5fv76fWH48U95j8ugLt-YWFJ-kkA@mail.gmail.com> <162276982204.1835121.10976600065855289763@swboyd.mtv.corp.google.com> <20210604082427.GE2435141@dell> <20210604082524.GF2435141@dell> <1622802121.26830.22.camel@mtkswgap22> <20210604132335.GK2435141@dell>
Subject: Re: [PATCH 1/1] clk: Export clk_register_composite
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        ARM/Mediatek SoC support <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list:
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>, ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
To:     Lee Jones <lee.jones@linaro.org>,
        Wendell Lin <wendell.lin@mediatek.com>
Date:   Fri, 04 Jun 2021 12:19:31 -0700
Message-ID: <162283437157.1835121.5925083479747882207@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-06-04 06:23:35)
> On Fri, 04 Jun 2021, Wendell Lin wrote:
>=20
> > On Fri, 2021-06-04 at 09:25 +0100, Lee Jones wrote:
> > > On Fri, 04 Jun 2021, Lee Jones wrote:
> > >=20
> > > > On Thu, 03 Jun 2021, Stephen Boyd wrote:
> > > >=20
> > > > > Quoting Lee Jones (2021-05-20 09:07:42)
> > > > > > On Mon, 10 Aug 2020 at 10:36, Wendell Lin <wendell.lin@mediatek=
.com> wrote:
> > > > > >=20
> > > > > >     Hi Matthias and all,
> > > > > >=20
> > > > > >     Gentle ping on this patch.
> > > > > >=20
> > > > > >=20
> > > > > > What about a not-so-gentle ping on this patch?  Grrrr... :)
> > > > > >=20
> > > > > > FYI, this is still required by more than one source.
> > > > > >=20
> > > > > > Please help get this out of all of the vendor trees please.
> > > > > >=20
> > > > >=20
> > > > > Is there an in-kernel user?
> > > >=20
> > > > How can there be?  It's not exported yet. :)
> > > >=20
> > > > However there shouldn't be any barriers for vendors represented in
> > > > Mainline to build their drivers as modules if they so wish.  If/when
> > > > they do, this will need to be exported.
> > >=20
> > > Wendell Lin, is this what you wish to do with the in-kernel MediaTek
> > > driver?
> > >=20
> > This is because Mediatek clock driver would be built as kernel module,
> > so clk_register_composite() used should be exported, then we could use
> > it.=20
> >=20
> > Please refer:
> > [PATCH 2/2] clk: mediatek: Add EXPORT_SYMBOL for kernel module support =

> > https://lkml.org/lkml/2020/7/1/124
> > +EXPORT_SYMBOL(mtk_clk_register_composites);
> >=20
> > clk_register_composite() is used by Mediatek clk kernel module.
> > From export symbol: mtk_clk_register_composites.=20
>=20
> Perfect.  Thanks for the clarification.
>=20
> Anything else you need from us Stephen?
>=20

Is the mediatek driver compilable as a module? Last time I checked it
wasn't a module. I want an upstream modular driver that uses the symbol.
Otherwise we're exporting symbols when it doesn't need to be.
