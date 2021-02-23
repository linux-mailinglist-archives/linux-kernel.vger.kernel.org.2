Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5862322ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhBWMuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:50:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:46364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232489AbhBWMui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:50:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69BA464E57;
        Tue, 23 Feb 2021 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614084597;
        bh=ZwLSEkv9ULwVhvjLMFYiYYF1IZnzRSzjqD14ce8PBu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cjBbeVP/7uB6me5AXmcpsFdhWLGEFEo4pRVzATN5IXf9LyWku5JdSrcNo+aj6d33+
         eSVn+VKrSuWhhqTCNo+VfouWMRuDrYhCXbPuiZHHtP2iWwemkbp1BB67YNFK4FM2YK
         tS2kT+bPAWxEnC+WRM5JPBJGEl/pKk1EhU0djMXC75OpsizpQAjF4oDTArQfWz0L8r
         0c0kf1vMPiJ/Zul/attffbAUPVk2Na6Rllv2n28XpQczHbGY8Im5DvAjC7dwHBH/wA
         Z3jGzr0ixaVG4CXuBujEJk4h3TpsF2bue1eO4Q1tK3Fyu2WHFllv6hqi3AW+pLKub+
         KHFfdm6mNslNQ==
Date:   Tue, 23 Feb 2021 12:49:52 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v13 4/7] arm64: mte: Enable TCO in functions that can
 read beyond buffer limits
Message-ID: <20210223124951.GA10563@willie-the-truck>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-5-vincenzo.frascino@arm.com>
 <20210212172128.GE7718@arm.com>
 <c3d565da-c446-dea2-266e-ef35edabca9c@arm.com>
 <20210222175825.GE19604@arm.com>
 <6111633c-3bbd-edfa-86a0-be580a9ebcc8@arm.com>
 <20210223120530.GA20769@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223120530.GA20769@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 12:05:32PM +0000, Catalin Marinas wrote:
> On Tue, Feb 23, 2021 at 10:56:46AM +0000, Vincenzo Frascino wrote:
> > On 2/22/21 5:58 PM, Catalin Marinas wrote:
> > > We'll still have an issue with dynamically switching the async/sync mode
> > > at run-time. Luckily kasan doesn't do this now. The problem is that
> > > until the last CPU have been switched from async to sync, we can't
> > > toggle the static label. When switching from sync to async, we need
> > > to do it on the first CPU being switched.
> > 
> > I totally agree on this point. In the case of runtime switching we might need
> > the rethink completely the strategy and depends a lot on what we want to allow
> > and what not. For the kernel I imagine we will need to expose something in sysfs
> > that affects all the cores and then maybe stop_machine() to propagate it to all
> > the cores. Do you think having some of the cores running in sync mode and some
> > in async is a viable solution?
> 
> stop_machine() is an option indeed. I think it's still possible to run
> some cores in async while others in sync but the static key here would
> only be toggled when no async CPUs are left.

Just as a general point, but if we expose stop_machine() via sysfs we
probably want to limit that to privileged users so you can't DoS the system
by spamming into the file.

Will
