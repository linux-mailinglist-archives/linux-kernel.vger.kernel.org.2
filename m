Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DD040BD0D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhIOBSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230016AbhIOBSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:18:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAC4861164;
        Wed, 15 Sep 2021 01:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631668650;
        bh=l+NumUB63WbtzsGXu6pyRmmSG7XUlP1lW29+cN38ZvM=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=PrYGRL1SREgen1aObM0sj5ZfYFpGL18JWflZ9aCg0DIhHTulC22kCFvCV+3CzHt9g
         1/AJ0w3GxHPE7pZVuPZspNCVF2WD36mO+D5LpHwQneVtoRx4r7OZ9YiCfAs64XMJlp
         uymGShsaisX/96GDb6QAQ5jjIDb7GF7w5QJXQfXSmAAU/Gwv7zxyDdqV+tCbKjuHA1
         3tWeTA/+Pws27OowMhsp3TX88VoMmIQJQsgFd+yPJFroez52F/DOdbHO4icRHGoOnn
         7o3QzYlNng3/ZrO0t48jkTvhALmB4twMX8RD4PXv0lZ6codsjt4OVqIbOlUHIJznrb
         lKEjeiabngboQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <HK0PR06MB33806C10EB8B3F87FE144F8DF2D99@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20210908091845.4230-1-ryan_chen@aspeedtech.com> <4571c9ae-0287-4f70-2adb-9c227e706736@microchip.com> <HK0PR06MB33806C10EB8B3F87FE144F8DF2D99@HK0PR06MB3380.apcprd06.prod.outlook.com>
Subject: RE: [PATCHv2] clk:aspeed:Fix AST2600 hpll calculate formula
From:   Stephen Boyd <sboyd@kernel.org>
To:     Claudiu.Beznea@microchip.com, Ryan Chen <ryan_chen@aspeedtech.com>,
        andrew@aj.id.au, joel@jms.id.au, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
Date:   Tue, 14 Sep 2021 18:17:29 -0700
Message-ID: <163166864956.763609.8140689140101809508@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Chen (2021-09-12 22:31:46)
> > > +               if (hwstrap & BIT(10))
> > > +                       m =3D 0x5F;
> > > +               else {
> > > +                       if (hwstrap & BIT(8))
> >=20
> > You may write it directly:
> >                 else if (hwstrap & BIT(8))
> >=20
> Hello,
>         Like I commit message M =3D SCU500[10] ? 0x5F : SCU500[8] ? 0xBF =
: SCU200[12:0]
>         it need keep from register read, if BIT(8)/BIT(10) not 1.
>        =20

I don't get it. The review comment was that the else { if (...) can be
collapsed into an else if (..) What does commit message have to do with
it?
