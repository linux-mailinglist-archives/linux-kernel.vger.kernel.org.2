Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD6315D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhBJCd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:33:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234717AbhBJCNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:13:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5623C64DEE;
        Wed, 10 Feb 2021 02:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612923163;
        bh=mU7P5kYB5pwu1ZcXRO4M9stXvCcsOmmLi6LZWpdu/rk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jJjPiTN4clZy1RoxjIXLcTPtMACvUyz2pKa66BB8DUV9c29dLzkKNU20ljp6lLers
         SdUwvxM7kdDWHEPKzWRHcCrAixxRdUmtAejTJBtfqrKGk1ELeyr+8B7Dz25f/pWxbO
         eJjzENJW7eS1lpRmI4VTBU8uRgNVoZu83UMGR7bLqUg4q6YxXYhFKPDZqqQIZohAWc
         BKtiCaaFUWMpH6Kk/RE/b3SmCGt9Iy1Bc6gbuu64K/3r/Vzd3oY06R4FauxPIKz0Ty
         wgjKWCA+I//6yvo1WOwYsRyTva8zeEyNqbAENKQ5wbdqrxf7VaB8SSpSTbNMA5KSGA
         15Q0ECxpd1rNw==
Date:   Wed, 10 Feb 2021 03:12:37 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     nnet <nnet@fastmail.fm>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, a.heider@gmail.com,
        andrew@lunn.ch, gerald@gk2.net, gregory.clement@bootlin.com,
        kostap@marvell.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        luka.perkov@sartura.hr, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, rmk+kernel@armlinux.org.uk,
        sboyd@kernel.org, tmn505@gmail.com, vladimir.vid@sartura.hr
Subject: Re: [PATCH mvebu v2 00/10] Armada 37xx: Fix cpufreq changing base
 CPU speed to 800 MHz from 1000 MHz
Message-ID: <20210210031237.6229b7ef@kernel.org>
In-Reply-To: <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
References: <d59ba191-43db-4b7b-b201-62a60ca752c0@www.fastmail.com>
        <20210209213330.hnc7op72zoj24mgz@pali>
        <7b0988cc-eeb8-4ea7-92f6-e8234ca910d3@www.fastmail.com>
        <20210209224223.p22yhjdy7ibzepss@pali>
        <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
        <20210209225630.mdwnzkvnaz3r4blt@pali>
        <a86c5069-d423-44db-92dd-b3e406b7ec91@www.fastmail.com>
        <20210210002619.43104a9b@kernel.org>
        <ac03801e-87e2-4e57-b131-bff52f03579d@www.fastmail.com>
        <1cd0c2ee-aa3a-4da2-9c0c-57cc5a1dad49@www.fastmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Feb 2021 17:51:53 -0800
nnet <nnet@fastmail.fm> wrote:

> On Tue, Feb 9, 2021, at 5:31 PM, nnet wrote:
> > On Tue, Feb 9, 2021, at 3:26 PM, Marek Beh=C3=BAn wrote: =20
> > > On Tue, 09 Feb 2021 15:16:45 -0800
> > > nnet <nnet@fastmail.fm> wrote:
> > >  =20
> > > > I've two of these and I've just swapped them (and re-pasted the hea=
t sinks).
> > > >=20
> > > > The second one ran under load for awhile and now has frozen as well.
> > > >=20
> > > > Under a moderate load `wget -O /dev/null <large.bin>` @X00Mbits the=
y are fine.
> > > >=20
> > > > Under a 1 min speed test of load ~200Mbits routed WireGuard they fr=
eeze.
> > > >=20
> > > > They fine with both those workloads @1000_800.
> > > >=20
> > > > Perhaps it's heat? Unfortunately I don't have any numbers on that A=
TM. =20
> > >=20
> > > Try disabling cpufreq in kernel completely, compile boot image at
> > > 1200 MHz. If it continues freezing, then I fear we can't help you with
> > > 1200 MHz :( =20
> >=20
> > cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequenci=
es=20
> > 200000 300000 600000 1200000=20
> >=20
> > I'm not getting any freezes with 1.2GHz fixed after 20 minutes of load:
> >=20
> > echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
> >=20
> > Setting it back to min 200MHz I get a freeze within a minute:
> >=20
> > echo 200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
> >  =20
> > > Marek
> > > =20
>=20
> > +#define MIN_VOLT_MV_FOR_L0_L1_1GHZ 1108 =20
>=20
> Based on the below at boot time might an equivalent of the above need to =
be 1225 for 1.2GHz?
>=20
> 1200_750
> SVC REV: 5, CPU VDD voltage: 1.225V
>=20
> 1000_800
> SVC REV: 5, CPU VDD voltage: 1.108V

It may be... But it is possible that the value 1.225 is computed by the
code by default.

Marek
