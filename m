Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB21B3D6B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 03:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhG0Aiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 20:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhG0Aim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 20:38:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEFF060F8F;
        Tue, 27 Jul 2021 01:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627348750;
        bh=cedZER80Bx35E0iQ5JejSSTvmqmwrBLUwul03A9Vwa4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bQlPLFSIkWmy8EwC43+w8blVmLAKYe5z6v+MYsQh+1U/ikJOW9fYSViNsvdHwVfZI
         lMs+Mzr87kmy1XZmO8EAjbxB0TVAFHRzuXNayd/BomjA16RUdgPQaNfyt4pokdcx0Y
         MYJTEYoTlXXPmqt0/L72R9XXz2W3AJsWnFirwbkC2GhO4pZHZS+Ymx+TP9W34c8hr3
         Wp6+/KdCRRXKwPURLWlu8heXd307HWpCreNo34ANaUi/xrNaSSTBdm45k76jDYM9r/
         xid1c8vfT1BzJ5kMfxU+QAFuM5DaDSueJrocpd1hDvkL3dEgHKd3p/kFO4YtyXBpzF
         nLAwk6ddWR+LQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3bee1689-5e1d-e65f-e66c-95d4521ea9f4@microchip.com>
References: <20210719080317.1045832-1-claudiu.beznea@microchip.com> <20210719080317.1045832-3-claudiu.beznea@microchip.com> <3bee1689-5e1d-e65f-e66c-95d4521ea9f4@microchip.com>
Subject: Re: [PATCH 2/2] clk: at91: add register definition for sama7g5's master clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     eugen.hristev@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        sfr@canb.auug.org.au
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        alexandre.belloni@bootlin.com, linux@armlinux.org.uk,
        ludovic.desroches@microchip.com, mturquette@baylibre.com
Date:   Mon, 26 Jul 2021 18:19:09 -0700
Message-ID: <162734874941.2368309.7238828348099448826@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas Ferre (2021-07-19 05:46:00)
> On 19/07/2021 at 10:03, Claudiu Beznea wrote:
> > Add register definitions for SAMA7G5's master clock. These would be
> > also used by architecture specific power saving code.
> >=20
> > Fixes: 6cb0e54412a3 ("ARM: at91: pm: add support for MCK1..4 save/resto=
re for ulp modes")
> > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>=20
> > ---
> >=20
> > Hi Stephen,
> >=20
> > This is a part from patch at [1]. I keep it at minimum (only definition=
s)
> > for faster acceptance as the build is broken on arm multi_v7_defconfig
> > without it).
> > In next version of patch at [1] I will update it accordingly.
>=20
> Stephen,
>=20
> Before hearing from you I inserted this patch in our at91-soc branch=20
> that is part of linux-next. With this at least the build don't break=20
> anymore.

I don't think I need the patches? I'll try to remember this patch if I
apply some patch that needs this in the future and probably just
duplicate the commit to make things simpler.

>=20
> Tell me if you want to have an immutable branch that we could share with =

> it on top of 5.14-rc1 or if it's fine if we add the same patch in both=20
> of our trees.
>
