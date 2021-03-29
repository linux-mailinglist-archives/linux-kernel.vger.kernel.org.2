Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C49034D9AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhC2Vob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbhC2Vo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:44:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0349261989;
        Mon, 29 Mar 2021 21:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617054269;
        bh=EYxKY5cj+eXScS9penVqhmJaLofkZ6a2MhIudLVrLbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fId5cUg6e38V8CVqnpGRCjIJuezOj6rIbvO791peZ1fZyLrJRBRjFEZShwVRvLC7j
         eS5KFCuERQWZezoW4pu7shHusfULQ0L11L+P9jQzoYTDzalW2mGQCNx4wkFmTyA1iO
         ikSv0d7nQmDuJdlVVe1eR5bT6SNwoCpY6YIMnrNH1jOFQJQy3a3xhniaf1roxxHvil
         ergCGhO80Ka/i+ivPPj+bgYeO1SIQA/Oa80zFtRGZRo+1dHCEi2UOf8A8y5raJl0+B
         Ka6Z2DXOdbd0rBeo/04rtg7CUB7MVY6w6rIIunDnN/2EUOG8oiv5SSBACU3otvh6JB
         o5ZxftfPi6FjA==
Date:   Mon, 29 Mar 2021 23:44:24 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?B?R8OpcmFsZA==?= Kerma <gerald@gk2.net>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: Re: [PATCH mvebu v2 09/10] cpufreq: armada-37xx: Remove
 cur_frequency variable
Message-ID: <20210329234424.1f6fdb2c@thinkpad>
In-Reply-To: <87mtumdmyr.fsf@BL-laptop>
References: <20210114124032.12765-1-pali@kernel.org>
        <20210114124032.12765-10-pali@kernel.org>
        <87mtumdmyr.fsf@BL-laptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 17:00:12 +0200
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Pali Roh=C3=A1r <pali@kernel.org> writes:
>=20
> > Variable cur_frequency in armada37xx_cpufreq_driver_init() is unused.
> >
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org> =20
>=20
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Gregory, THX for the acks.

Will you be merging these patches or should this be done by
someone else? cpufreq maintainers maybe?

Marek
