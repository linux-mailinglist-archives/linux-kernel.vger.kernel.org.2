Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394E23FA8EC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 06:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhH2Eh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 00:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhH2Ehz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 00:37:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A5D36056C;
        Sun, 29 Aug 2021 04:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630211824;
        bh=15aA9PoLrVLhhzbIERoowOHfuu6BH/mJ4ap92834RuE=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=NbNCVrF/Ix7iUWDy6/tOMoXGuAMEuBkfyw/039QkeGnbbQlnPgzELc/KLasyaYB1r
         9hdND5rFIdpGpzC6IKrbPhedUvKGeWCNllBWilYGeO6jpJ5DDMrbXAIfCz9gR9kNo2
         1EPdQRivspdyB8Oktu/u7fN9m8bDhKWqp0U5Cn/S1eOjeMRH3FXjk2SlIzL7c4K+hp
         5q/N1+kt0OJN1PdYVYCpENJzZw8E0TSgGOa4WYJpbmAhQA25KwIznNnh76vLoHyMSj
         QYMITQYpv1QLZQOeH/59IEStt5yhgSJYqzpxBi0fi8jUQejoAKRq8lQ92c3rri5kU3
         s8JkhmBWWiZGg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210818080518.9491-2-ryan_chen@aspeedtech.com>
References: <20210818080518.9491-1-ryan_chen@aspeedtech.com> <20210818080518.9491-2-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH 1/1] clk:aspeed:Fix AST2600 hpll calculate formula
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        bmc-sw@aspeedtech.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>
Date:   Sat, 28 Aug 2021 21:37:02 -0700
Message-ID: <163021182287.2676726.14377450905895813289@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Chen (2021-08-18 01:05:18)
> AST2600 HPLL calculate formula [SCU200]
> HPLL Numerator(M): have fixed value depend on SCU strap.
> M =3D SCU500[10] ? 0x5F : SCU500[8] ? 0xBF : SCU200[12:0]
>=20
> if SCU500[10] =3D 1, M=3D0x5F.
> else if SCU500[10]=3D0 & SCU500[8]=3D1, M=3D0xBF.
> others (SCU510[10]=3D0 and SCU510[8]=3D0)
> depend on SCU200[12:0] (default 0x8F) register setting.
>=20
> HPLL Denumerator (N) =3D  SCU200[18:13] (default 0x2)
> HPLL Divider (P)         =3D      SCU200[22:19] (default 0x0)
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Any Fixes tag? Joel, can you review?
