Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40585316D81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhBJR72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:59:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233393AbhBJR6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:58:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AABC64D9E;
        Wed, 10 Feb 2021 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612979872;
        bh=188LP55ZbL/5tqabYWzrzaSkit0jX+HJGf9gmnyTYEw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JZXlyWq8OJbUDecHAJQfmPePaRJ6LnIoZ2R+eIfi/X3o9sMyUqYghqTf+5EDl+IrG
         MW01Jrfbkq1GVURbW62Tx+OCvANOtqIR2D00qM6Ih/HwXpf50eOVR/qqIJhwYnBgqx
         NJ2l/AVfhlCXl3DZpseof7ZUJpddb0lE1sSa8kJp0w4hfEf2WOYEs9sBQdhOifRJQf
         ujnujHhkZPErmZk6cK2+tlfoXCpTxybnBHy2mZ81qa87v2tlU4pT5eET83o8CtMr4/
         jYd4YKUAEoqlgD84pybtOYX9uFVrzxFixbg9y1edDwe62+wiRCWHQHqHqW+KKxRbTP
         a6a4mWgV8Q5JA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D068C35226F9; Wed, 10 Feb 2021 09:57:51 -0800 (PST)
Date:   Wed, 10 Feb 2021 09:57:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 0/8] support for bitmap (and hence CPU) list "N"
 abbreviation
Message-ID: <20210210175751.GH2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
 <YCQJToq1d63BU55S@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQJToq1d63BU55S@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 06:26:54PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 09, 2021 at 05:58:59PM -0500, Paul Gortmaker wrote:
> > The basic objective here was to add support for "nohz_full=8-N" and/or
> > "rcu_nocbs="4-N" -- essentially introduce "N" as a portable reference
> > to the last core, evaluated at boot for anything using a CPU list.
> 
> I thought we kinda agreed that N is confusing and L is better.
> N to me is equal to 32 on 32 core system as *number of cores / CPUs*. While L
> sounds better as *last available CPU number*.

The advantage of "N" is that people will automatically recognize it as
"last thing" or number of things" because "N" has long been used in
both senses.  In contrast, someone seeing "0-L" for the first time is
likely to go "What???".

Besides, why would someone interpret "N" as "number of CPUs" when doing
that almost always gets you an invalid CPU number?

							Thanx, Paul
