Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8E1357919
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 02:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhDHAiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 20:38:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhDHAiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 20:38:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A6D761130;
        Thu,  8 Apr 2021 00:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617842292;
        bh=TSCqDSbsCRDRSxtG+nNsrnrXL8+DHlTFEIjwcS8G4i4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gqLcKnc2KtoBOyqyFUCHKlcGoT/Ff1VugVnGo64igZhwRVI6NBYfnG4931FnhtdBm
         ukyJ+rFR7BJX0akjnPvdsYzJVNbYuboteHf1gwakJ0ly7HDGF5/2I9VCnr2hKiSMmx
         ED/ij27XjdBiK44BNDLTicFBGKR+aBBD2KjSREAoTzGJAC+N82i5KQXkpTt5buy3VY
         VlzJZcxLdkdSp1xTlLOw90RaEDWxpXsd0oxlmPl8HvoXTUWxwc7/udEy2e26EL4L8O
         Rudt+gHtwC/Gr4/IzcwaqEYyCLnht+yG8EbsH2fbbvrmrXAdiTk0yG/B7ChT2J/gey
         pY2XaJTRa4LSQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210328113102.jk3os7p56kq43yve@pali>
References: <20210114124032.12765-1-pali@kernel.org> <20210222194158.12342-1-pali@kernel.org> <20210301192024.tgvp6f5zscbknepo@pali> <87a6r8ka6x.fsf@BL-laptop> <20210328113102.jk3os7p56kq43yve@pali>
Subject: Re: [PATCH mvebu v3 00/10] Armada 37xx: Fix cpufreq changing base CPU speed to 800 MHz from 1000 MHz
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?utf-8?q?G=C3=A9rald?= Kerma <gerald@gk2.net>,
        Konstantin Porotchkin <kostap@marvell.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Date:   Wed, 07 Apr 2021 17:38:11 -0700
Message-ID: <161784229111.3790633.14149077702883618937@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pali Roh=C3=A1r (2021-03-28 04:31:02)
> On Friday 12 March 2021 10:12:06 Gregory CLEMENT wrote:
> > Hello Pali,
> >=20
> > > Hello Gregory!
> > >
> > > Patches are the for almost two months and more people have tested the=
m.
> > > They are marked with Fixed/CC-stable tags, they should go also into
> > > stable trees as they are fixing CPU scaling and instability issues.
> > >
> > > Are there any issues with these patches? If not, could you please mer=
ge
> > > them for upcoming Linux version?
> >=20
> > Actually I am not the maintainer of the clk and cpufreq subsystems, so
> > the only thing I can apply is the device tree relative patch.
> >=20
> > Gregory
>=20
> Hello Gregory! Could you please at least review this patches, so other
> maintainers could merge them?

Maybe it can merge through cpufreq tree? I've already acked the clk
driver patches I believe.
