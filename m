Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C7A30F31D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhBDM13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:27:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235819AbhBDM11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:27:27 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9258F64F53;
        Thu,  4 Feb 2021 12:26:46 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l7die-00C0QN-4h; Thu, 04 Feb 2021 12:26:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Feb 2021 12:26:44 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>, kernelci-results@groups.io
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
In-Reply-To: <CAMj1kXF6SLXN3HQAG3SyOujX5MPCSrLG-k82iNz=61HjaiEEVw@mail.gmail.com>
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com>
 <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk>
 <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <20210204104714.GU1463@shell.armlinux.org.uk>
 <CAMj1kXF6SLXN3HQAG3SyOujX5MPCSrLG-k82iNz=61HjaiEEVw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <090003e6f825de1f8460c0e987e14577@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ardb@kernel.org, linux@armlinux.org.uk, guillaume.tucker@collabora.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, nico@fluxnic.net, kernelci-results@groups.io
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-04 10:55, Ard Biesheuvel wrote:
> (cc Marc)
> 
> On Thu, 4 Feb 2021 at 11:48, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
>> 
>> On Thu, Feb 04, 2021 at 11:27:16AM +0100, Ard Biesheuvel wrote:
>> > Hi Russell,
>> >
>> > If Guillaume is willing to do the experiment, and it fixes the issue,
>> > it proves that rk3288 is relying on the flush before the MMU is
>> > disabled, and so in that case, the fix is trivial, and we can just
>> > apply it.
>> >
>> > If the experiment fails (which would mean rk3288 does not tolerate the
>> > cache maintenance being performed after cache off), it is going to be
>> > hairy, and so it will definitely take more time.
>> >
>> > So in the latter case (or if Guillaume does not get back to us), I
>> > think reverting my queued fix is the only sane option. But in that
>> > case, may I suggest that we queue the revert of the original by-VA
>> > change for v5.12 so it gets lots of coverage in -next, and allows us
>> > an opportunity to come up with a proper fix in the same timeframe, and
>> > backport the revert and the subsequent fix as a pair? Otherwise, we'll
>> > end up in the situation where v5.10.x until today has by-va, v5.10.x-y
>> > has set/way, and v5.10y+ has by-va again. (I don't think we care about
>> > anything before that, given that v5.4 predates any of this)
>> 
>> I'm suggesting dropping your fix (9052/1) and reverting
>> "ARM: decompressor: switch to by-VA cache maintenance for v7 cores"
>> which gets us to a point where _both_ regressions are fixed.
>> 
> 
> I understand, but we don't know whether doing so might regress other
> platforms that were added in the mean time.
> 
>> I'm of the opinion that the by-VA patch was incorrect when it was
>> merged (it caused a regression), and it's only a performance
>> improvement.
> 
> It is a correctness improvement, not a performance improvement.
> 
> Without that change, the 32-bit ARM kernel cannot boot bare metal on
> platforms with a system cache such as 8040 or SynQuacer, and can only
> boot under KVM on such systems because of the special handling of
> set/way instructions by the host.

I agree. With set/way CMOs, there is no way to reach the PoC if
it beyond the system cache, leading to an unbootable kernel.
This is actually pretty well documented in the architecture,
and it did bite us for the first time on XGene-1, 7 years ago.

In retrospect, having KVM to handle set/way CMOs in was a mistake,
as it just papered over the problem for the sake of running older
32bit guests. It violated the principle of KVM/arm being strictly
architectural and provided unrealistic expectations. I'll take the
blame for this.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
