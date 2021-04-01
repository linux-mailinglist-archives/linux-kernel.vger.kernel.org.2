Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1273520AF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhDAUlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234376AbhDAUlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:41:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 829BC610E9;
        Thu,  1 Apr 2021 20:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617309676;
        bh=yuDRLRtXXUlCn56424LLjY6gpkdOniglbruDAsp0dII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uKkF9QgGhXa2W/z2aoBY7b9lCuIeNSHHK+mv6Dq7C2pfvvgOx6PIythX+fnilBz4U
         3m7UKdn/iaS/4LvcR9YPd7WroVmbow7PdHp6jSI4q6sT6XcF1zDPLz4PJnj3RnEasQ
         BsCd3hgMDSlXMvzOUFMNCvKLWzqJkwMczXA9GJJMONh+Sg7FieNDHWc/n2uIRVozYm
         9F9A8U5bYt+lSB0ywWK4kfMdXRQMTU3vuIrUumTBWoR1tuLMon5ldtEbMilbAN1WGQ
         xrn0ocvHFHKHK1DxP9yQwelSXVCVi/fnueGI2LKpLelyaHZLve+UdRAqobUqzzibbC
         M+vLM4vBxmrQw==
Date:   Thu, 1 Apr 2021 22:41:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] torture: Correctly fetch CPUs for kvm-build.sh with all
 native language
Message-ID: <20210401204113.GB116405@lothringen>
References: <20210401132602.116352-1-frederic@kernel.org>
 <20210401185116.GH2696@paulmck-ThinkPad-P72>
 <20210401203112.GA116405@lothringen>
 <20210401204022.GI2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401204022.GI2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 01:40:22PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 01, 2021 at 10:31:12PM +0200, Frederic Weisbecker wrote:
> > On Thu, Apr 01, 2021 at 11:51:16AM -0700, Paul E. McKenney wrote:
> > > On Thu, Apr 01, 2021 at 03:26:02PM +0200, Frederic Weisbecker wrote:
> > > > Grepping for "CPU" on lscpu output isn't always successful, depending
> > > > on the local language setting. As a result, the build can be aborted
> > > > early with:
> > > > 
> > > > 	"make: the '-j' option requires a positive integer argument"
> > > > 
> > > > Prefer a more generic solution.
> > > > 
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > 
> > > Good catch, applied, thank you!
> > > 
> > > There is a similar construct in kvm-remote.sh, so I added a similar
> > > fix to your patch.
> > > 
> > > But what about this in functions.sh?
> > > 
> > > nt="`lscpu | grep '^NUMA node0' | sed -e 's/^[^,]*,\([0-9]*\),.*$/\1/'`"
> > > 
> > > I am guessing that "node0" is human-language-independent, but is "NUMA"?
> > 
> > I thought they wouldn't bother translating that, but they did...
> > 
> >     NUMA node0 CPU(s):               0-7
> > 
> > becomes:
> > 
> >     Nœud NUMA 0 de processeur(s) : 0-7
> > 
> > Not sure about the best way to fix it.
> 
> The rude and crude fix is for the scripts to force the local language
> to English.  ;-)

I don't have a better answer :o)
