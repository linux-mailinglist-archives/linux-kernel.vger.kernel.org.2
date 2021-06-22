Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1115C3B0F54
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 23:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFVVT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 17:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFVVT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 17:19:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EA186108E;
        Tue, 22 Jun 2021 21:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624396660;
        bh=4hqUaho/Ab0/b89LGZN2tYhoZu25lf6YRdYhZjsELBM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LjYDkXgEZA9X7z80M6zL0i+zZYfGkiNfZmr+qC4qsKsW0309YkVLC8WvOfRjo9u0j
         JwVA5e1hckatuWjsSV2P1WNlx1HRdD5Eq9Roa86w5sUmlL8oxhPAKAlMUqfeUa4304
         jb78aSUAo917vTEdemhQhUX8dMl4jbybkIsvZXYixfaJdKC63HI8Nsl5NxA2IrX+y/
         +vdf3vWKObq8mZPhxc1XgjypzDjCDPBkYW457ZA4PujIKph60LUNOD4wDnqaBj1f2T
         O/DdXGgXSKbIx1MHJ8kp4Gc+IjuMxhqGtwO7A/UqSnZ21AbAG109eePfNDPX8WYvI3
         xOL/C4R3LDFTA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFBinCBpkci-BeqLSN+BNbrcAE9sLKM8Hs0BB09AM1GKmtU9_g@mail.gmail.com>
References: <20210524103733.554878-1-martin.blumenstingl@googlemail.com> <CAFBinCDn_0TeyLG9b9uB+4-4PdeNXgja11wf2CGcQ99tUNjkyQ@mail.gmail.com> <1jr1heqhoy.fsf@starbuckisacylon.baylibre.com> <CAFBinCBpkci-BeqLSN+BNbrcAE9sLKM8Hs0BB09AM1GKmtU9_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] clk: meson: rounding for fast clocks on 32-bit SoCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, mturquette@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 22 Jun 2021 14:17:39 -0700
Message-ID: <162439665901.1026800.14766697980134538910@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2021-06-22 14:04:55)
> Hi Stephen,
>=20
> On Mon, Jun 7, 2021 at 9:04 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> >
> >
> > On Fri 04 Jun 2021 at 19:18, Martin Blumenstingl <martin.blumenstingl@g=
ooglemail.com> wrote:
> >
> > > Hi Jerome, Hi Stephen,
> > >
> > > On Mon, May 24, 2021 at 12:37 PM Martin Blumenstingl
> > > <martin.blumenstingl@googlemail.com> wrote:
> > >>
> > >> On the 32-bit Amlogic Meson8/8b/8m2 SoCs we run into a problem with =
the
> > >> fast HDMI PLL and it's OD (post-dividers). This clock tree can run at
> > >> up to approx. 3GHz.
> > >> This however causes a problem, because these rates require BIT(31) to
> > >> be usable. Unfortunately this is not the case with clk_ops.round_rate
> > >> on 32-bit systems. BIT(31) is reserved for the sign (+ or -).
> > >>
> > >> clk_ops.determine_rate does not suffer from this limitation. It uses
> > >> an int to signal any errors and can then take all availble 32 bits f=
or
> > >> the clock rate.
> > >>
> > >> Changes since v1 from [0]:
> > >> - reworked the first patch so the the existing
> > >>   divider_{ro_}round_rate_parent implementations are using the new
> > >>   divider_{ro_}determine_rate implementations to avoid code duplicat=
ion
> > >>   (thanks Jerome for the suggestion)
> > >> - added a patch to switch the default clk_divider_{ro_}ops to use
> > >>   .determine_rate instead of .round_rate as suggested by Jerome
> > >>   (thanks)
> > >> - dropped a patch for the Meson PLL ops as these are independent from
> > >>   the divider patches and Jerome has applied that one directly (than=
ks)
> > >> - added Jerome's Reviewed-by to the meson clk-regmap patch (thanks!)
> > >> - dropped the RFC prefix
> > > please let me know what you think about this v2
> > > I am asking because clk-divider is widely used, so I'd appreciate if
> > > this gets some time in linux-next (so for example Kernel CI can test
> > > this and report issues if there are any).
> Do you have any comments on this series?
> I am fine with it skipping 5.14 as it's a change which affects
> multiple platforms.
> So I would like to use the time until the trees are opening for
> patches targeting 5.15 to iron out code-review comments.
>=20
> > Looks good to me
> > Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
> Thanks Jerome - I'll add it to v3 once I send it (assuming nothing
> major changes)

Looks ok to me. Will you resend?
