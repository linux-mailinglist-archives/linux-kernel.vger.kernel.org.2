Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833813BA4E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 23:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhGBVD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 17:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230274AbhGBVD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:03:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E68C61167;
        Fri,  2 Jul 2021 21:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625259654;
        bh=WOZ1VopfRwrnnRB8pJr+CmLYqpYymi8au37V22c6ILU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cZUPmVEuu0gWRMENpm98DvfRaC+h2GHX4YbmTv9UeHJcNwcYDlx6UJLolKVzBB7iK
         00qmT3BIYsgZzZ1T0Cv58FakY+fVxiUzKQFOj679u+AYj6fGVuUOQyAp5DKglSBUIj
         RR10lJKV/cwQEkRA3T6aIJjUfK/n2tHAr43olZkcKymvLTamFByWz2WxK7+R3FR9ur
         ChcOy+jhcH37K/twV5a94rG7c0A8I9uazPp3cfivmn3JJMVRIA0p1BpNI9iMi5zIof
         hageaNPakNSd286Y5JCNvpOUY19PMfrUqFuDselKK6fO+j/nfttz/mO8dO8N7o1/PG
         cK6IbvZRSlqCQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e21c34a3-2586-057d-013b-6c8ec094d1a8@samsung.com>
References: <20210627223959.188139-1-martin.blumenstingl@googlemail.com> <20210627223959.188139-3-martin.blumenstingl@googlemail.com> <20210701202540.GA1085600@roeck-us.net> <CAFBinCC2KB-_pOenpWPknCuHV+CCjhP5hqukSkwD3qwRe6OtQw@mail.gmail.com> <162518776607.3570193.14348711594242395887@swboyd.mtv.corp.google.com> <CAFBinCAASQUB=cg5EFsBQ4jd3TvcCJzV1=sYJci4ibR7FjRcww@mail.gmail.com> <CGME20210702124612eucas1p1762911deb37e4fb03adc9239bb715135@eucas1p1.samsung.com> <e21c34a3-2586-057d-013b-6c8ec094d1a8@samsung.com>
Subject: Re: [PATCH v3 2/3] clk: divider: Switch from .round_rate to .determine_rate by default
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, mturquette@baylibre.com,
        linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 02 Jul 2021 14:00:53 -0700
Message-ID: <162525965307.3570193.9588997729905273358@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marek Szyprowski (2021-07-02 05:46:11)
> Hi
>=20
> On 02.07.2021 11:19, Martin Blumenstingl wrote:
> > Hi Stephen,
> >
> > On Fri, Jul 2, 2021 at 3:02 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > [...]
> >> My guess is that we have drivers copying the clk_ops from the
> >> divider_ops structure and so they are copying over round_rate but not
> >> determine_rate.
> > I just learned something new - thanks for investigating this as well!
> >
> > $ git grep "clk_divider_ops\.round_rate" drivers/
> > drivers/clk/bcm/clk-bcm2835.c:  return clk_divider_ops.round_rate(hw,
> > rate, parent_rate);
>=20
> I confirm that this issue appears also on Raspberry Pi 3b+ board. I was=20
> about to write a bug report, but you were faster. The funny thing is=20
> that is so nondeterministic, that automated bisecting failed to catch it.
>=20

I'd think it was deterministic. The function pointer is NULL after this
patch so it should always try to set the PC to 0 and fail to execute.
Unless that is somehow executable?
