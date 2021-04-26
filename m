Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBABF36B8D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhDZSZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234156AbhDZSZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:25:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB05B613BB;
        Mon, 26 Apr 2021 18:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619461473;
        bh=Mf3DHDPaUo/gGh0DytcdeEMUSdwelcaOcL7YK2HhiYw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K9jzhPZWw2CC0MF6oZsQOwDTuDxD6wq0AE3dj8q64Dlz3/cbSnvvySrs41eDxrF9v
         S/kZC6kxbstY2Al/OD6IPQLqTq40D7P38WB/ydvHes9bJQ3qgf2qnLXLyQTd6eGRA/
         f/s9Ft18gb/ubhFJ25uvVgI88O/ZkZeiw2E21v8NZNF1hGoVSMLI1BslO0vZTPn1yZ
         tdHZfEOqckPe8UQA6uQl9A81KFJNyp+vF2QNvIFzdeu5e9ylo+t+uDxY4pT7GY++sv
         3/jUK3LwSXSBm/kwKDgqoLVRWYfLHy1E0c94JNa5sU/GeGVbYkzIrZBZqNkpERWsvK
         rmVyKcZm8+iZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5F05F5C06D0; Mon, 26 Apr 2021 11:24:33 -0700 (PDT)
Date:   Mon, 26 Apr 2021 11:24:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, feng.tang@intel.com,
        zhengjun.xing@intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v10 clocksource 1/7] clocksource: Provide module
 parameters to inject delays in watchdog
Message-ID: <20210426182433.GD975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-1-paulmck@kernel.org>
 <20210426040736.GS1401198@tassilo.jf.intel.com>
 <20210426152801.GY975577@paulmck-ThinkPad-P17-Gen-1>
 <20210426160008.GY1401198@tassilo.jf.intel.com>
 <20210426161425.GC975577@paulmck-ThinkPad-P17-Gen-1>
 <20210426175627.GZ1401198@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426175627.GZ1401198@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 10:56:27AM -0700, Andi Kleen wrote:
> > ------------------------------------------------------------------------
> > 
> > - module parameters
> > 
> >   If the scope of the fault injection capability is limited to a
> >   single kernel module, it is better to provide module parameters to
> >   configure the fault attributes.
> > 
> > ------------------------------------------------------------------------
> > 
> > And in this case, the fault injection capability is in fact limited to
> > kernel/clocksource.c.
> 
> 
> I disagree with this recommendation because it prevents fuzzer coverage.
> 
> Much better to have an uniform interface that can be automatically
> explored.

The permissions for these module parameters is 0644, so there is no
reason why the fuzzers cannot use them via sysfs.

							Thanx, Paul
