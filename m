Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF28032C971
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356503AbhCDBEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:04:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345260AbhCDAcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:32:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB8A364EE8;
        Thu,  4 Mar 2021 00:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614817886;
        bh=1OfWDDIGe/X+T7nswi0OqliEAV+DKRcAUcRjqrpwpjw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T3VSM8zqbgJQGFOTIR4u5nl//8IAa62b4hLNykdkgipvE+hAU59NKSj/K4ujF5K4O
         Rlo7oAMy2lY76BmuMS4Sq+4L4wzr94ZZFUAdMDuWn4TpPAvT5f+/2d90m+bGAnJW7z
         6V1YMiDdD6Ae0COa3S7CjPEm2gIcbpD9DyAa+reM=
Date:   Wed, 3 Mar 2021 16:31:25 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] units: Add the HZ_PER_KHZ macro
Message-Id: <20210303163125.dcc0a086a939a58ed30750e8@linux-foundation.org>
In-Reply-To: <CAHp75Vcqug9qC_ejHE03YguiSy-XpsZV6g36-pe3VOFgTS2-tA@mail.gmail.com>
References: <20210223203004.7219-1-daniel.lezcano@linaro.org>
        <CAHp75VcJwoye5KOYXF3Fs1F-82JPP-7VaU4z5OqBrYDr+AGQ5w@mail.gmail.com>
        <CAHp75Vcqug9qC_ejHE03YguiSy-XpsZV6g36-pe3VOFgTS2-tA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 10:39:36 +0200 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wednesday, February 24, 2021, Andy Shevchenko <andy.shevchenko@gmail.com>
> wrote:
> 
> >
> >
> > On Tuesday, February 23, 2021, Daniel Lezcano <daniel.lezcano@linaro.org>
> > wrote:
> >
> >> The macro for the unit conversion for frequency is duplicated in
> >> different places.
> >>
> >> Provide this macro in the 'units' header, so it can be reused.
> >>
> >>
> >
> > Thanks! That was the idea behind my reviews to add those definitions
> > explicitly in the users. I just want to be sure you covered them all. Also
> > there are few non-standard names for above in some drivers (they can be
> > fixed on per driver basis in separate patches though).
> >
> >
> 
> Seems you introduced a common macro and forget about dropping it elsewhere.
> 
> https://elixir.bootlin.com/linux/latest/A/ident/HZ_PER_MHZ

Yes.  And HZ_PER_KHZ.

Also, why make them signed types?  Negative Hz is physically
nonsensical.  If that upsets some code somewhere because it was dealing
with signed types then, well, that code needed fixing anyway.

Ditto MILLIWATT_PER_WATT and friends, sigh.

