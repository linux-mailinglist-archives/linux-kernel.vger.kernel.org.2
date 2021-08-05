Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683B43E1F8E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 01:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbhHEXvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 19:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233076AbhHEXvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:51:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B051F610FD;
        Thu,  5 Aug 2021 23:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628207481;
        bh=9NRjcq6xrOIr1OnUpQMzu1Et/nL8ECC9yne2s6h0WB4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Y9TsItyqO5AdbFXQvBonD0YcpTL22P1920kj3wyG1bI3wWjmZlzqD78OncK0uyuGg
         avRXcQqSc0txHgkC4DR+NU6Cb+VNbhiZczzFu/emvNU0UuqOex+RvnPmXm9gZHidvo
         cADjZDqAPNMfPnzruFrbiqenHsg3V4ECNVmYz8w6YscwADfVFY1QEodH61oh01in9j
         PXNApGHitsTkSG6D4rdMfUJ2ayrib4R1izBoyj4tUkUEaTKNHkFq4VAQxjDxh8DJOo
         ckly00dkFRMcCtlRJgA3JvJQHQSkknzEpsu3o8RSu2gTEVAjMYLyxjv1JU/a6/+zJg
         CaKGxBTrX8Hdg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YQuaiW/MSZY4bmok@google.com>
References: <20210801233314.3150754-1-linus.walleij@linaro.org> <20210801233314.3150754-2-linus.walleij@linaro.org> <YQejHNP1AzFHZ6gK@google.com> <CACRpkdaK0pBgmFSazjJ5NOj9rF9DzUyCfumxyi8PNaS_61_=Ww@mail.gmail.com> <YQuaiW/MSZY4bmok@google.com>
Subject: Re: [PATCH 2/2] mfd: db8500-prcmu: Handle missing FW variant
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        phone-devel@vger.kernel.org
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 05 Aug 2021 16:51:20 -0700
Message-ID: <162820748053.19113.16240444817751473992@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-08-05 01:00:09)
> On Thu, 05 Aug 2021, Linus Walleij wrote:
>=20
> > On Mon, Aug 2, 2021 at 9:47 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Mon, 02 Aug 2021, Linus Walleij wrote:
> > >
> > > > There was an "unknown" firmware variant turning up in the wild
> > > > causing problems in the clock driver. Add this missing variant
> > > > and clarify that varian 11 and 15 are Samsung variants, as this
> > > > is now very well known from released products.
> > > >
> > > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > > Cc: linux-clk@vger.kernel.org
> > > > Cc: phone-devel@vger.kernel.org
> > > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > > ---
> > > > Clock maintainers: could you please ACK this so Lee can take
> > > > this into the MFD tree? The chances of merge collisions are
> > > > zero, this code changes very seldom.
> > > > ---
> > > >  drivers/clk/ux500/u8500_of_clk.c | 3 ++-
> > >
> > > >  drivers/mfd/db8500-prcmu.c       | 6 ++++--
> > > >  include/linux/mfd/dbx500-prcmu.h | 3 ++-
> > >
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> >=20
> > Actually I intended for the clock people to ACK it for you
> > but since it is completely independent of 1/2 it actually works
> > either way, maybe they will rather pick it up, who knows? :D
>=20
> That's fine too.
>=20
> I assume they will not require an immutable branch, as the turn-over
> in this file is very low.
>=20

Seems fine to go through mfd. Isn't there some other ux500 patch on the
list though?
