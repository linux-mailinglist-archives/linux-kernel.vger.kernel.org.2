Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532FC3B9A3E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 02:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhGBAzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 20:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhGBAzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 20:55:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A49DF6140A;
        Fri,  2 Jul 2021 00:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625187198;
        bh=hOxydK9lrZm1tCUuGvVtxlJm6pqPnLt4Q3e8u+eW+0o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lXic832EbDrfONeY+FbNtkCmiW2k6d7NqRznrL1mf8g4SnHl0OTjSWD4vunYeqB1I
         3YX7oDuMoMuV0PVVIG+0qatCK8HJ9L+wXUWAKXAKAE4KAdLQK3KIV4w4wpuhwI21Um
         HFWuMWzFY1QDQksSjoZjlhUciC+daaEsWFCbH/rJfU428V9t5UdkUK5cX3nCPTwx8M
         MYoXjJlNrKz2dpGfLzo7z8d3M5CA8Ag5WIwx/vL7bTiis3Fl8+FGUzS53EQZsVU0ml
         jNKC7zqsDqEn+i0E2v41DRDP9qegW0zV5PjodVkRKGX3+YHEt/SbB6njVABV0Nuk8I
         GLGGjjnDcOysA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7a06cfaf-4cae-5c4c-edff-16d6406a1b6c@roeck-us.net>
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com> <20210627223959.188139-3-martin.blumenstingl@googlemail.com> <20210701202540.GA1085600@roeck-us.net> <CAFBinCC2KB-_pOenpWPknCuHV+CCjhP5hqukSkwD3qwRe6OtQw@mail.gmail.com> <7a06cfaf-4cae-5c4c-edff-16d6406a1b6c@roeck-us.net>
Subject: Re: [PATCH v3 2/3] clk: divider: Switch from .round_rate to .determine_rate by default
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
To:     Guenter Roeck <linux@roeck-us.net>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 01 Jul 2021 17:53:17 -0700
Message-ID: <162518719742.3570193.6252446967177529304@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guenter Roeck (2021-07-01 14:43:29)
> On 7/1/21 1:57 PM, Martin Blumenstingl wrote:
> > Hi Guenter,
> >=20
> > On Thu, Jul 1, 2021 at 10:25 PM Guenter Roeck <linux@roeck-us.net> wrot=
e:
> > [...]
> >> [    0.000000] [<c07be330>] (clk_core_determine_round_nolock) from [<c=
07c5480>] (clk_core_set_rate_nolock+0x184/0x294)
> >> [    0.000000] [<c07c5480>] (clk_core_set_rate_nolock) from [<c07c55c0=
>] (clk_set_rate+0x30/0x64)
> >> [    0.000000] [<c07c55c0>] (clk_set_rate) from [<c163c310>] (imx6ul_c=
locks_init+0x2798/0x2a44)
> >> [    0.000000] [<c163c310>] (imx6ul_clocks_init) from [<c162a4e4>] (of=
_clk_init+0x180/0x26c)
> >> [    0.000000] [<c162a4e4>] (of_clk_init) from [<c1604d34>] (time_init=
+0x20/0x30)
> >> [    0.000000] [<c1604d34>] (time_init) from [<c1600e0c>] (start_kerne=
l+0x4c8/0x6cc)
> >> [    0.000000] [<c1600e0c>] (start_kernel) from [<00000000>] (0x0)
> >> [    0.000000] Code: bad PC value
> >> [    0.000000] ---[ end trace 7009a0f298fd39e9 ]---
> >> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle =
task!
> >>
> >> Bisct points to this patch as culprit. Reverting it fixes the problem.
> > sorry for breaking imx6 - and at the same time: thanks for reporting th=
is!
> >=20
> > Do you have some additional information about this crash (which clock
> > this relates to, file and line number, etc.)?
> > I am struggling to understand the cause of this NULL dereference
> > My patch doesn't change the clk_core_determine_round_nolock()
> > implementation and the new determine_rate code-path (inside that
> > function) doesn't seem to be more fragile in terms of NULL values
> > compared to the round_rate code-path.
> > Instead I think it's more likely that the problem is somewhere within
> > clk_divider_determine_rate() (or in any helper function it uses), but
> > that doesn't show up in the trace
> >=20
> > I don't have any imx6 board myself and so far I am unable to reproduce
> > this crash on any hardware I have.
> > However, if it's a problem in my clk-divider.c changes then I'd like
> > to find the cause (ASAP) because possibly more SoCs may be broken...
> >=20
>=20
> I don't have such a board either. The problem shows up in my qemu boot te=
sts. See
> https://kerneltests.org/builders/qemu-arm-v7-next/builds/38/steps/qemubui=
ldcommand/logs/stdio
> for an example. The problem reproduces with qemu's mcimx6ul-evk and sabre=
lite
> emulations.
>=20

Would be great if we had some kunit tests for the divider code. No doubt
it would have caught this. I think for now I'll just drop this patch
from clk-next. Thanks for testing.
