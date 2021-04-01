Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0A35214A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhDAVIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233710AbhDAVIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:08:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5914B6023E;
        Thu,  1 Apr 2021 21:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617311284;
        bh=oRAU1aLqpuZLbEgF6AvATIUxz5sNjxR9aSqYA5ZpliQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y07i3HGP22Q6JsjOJr9GUY1qNAuzus12l5VFINX4mpLM2YakkQ8QB+a7yq1zmcWD8
         u3LU/UrPveADqSKjvPFCrYdYku9HnvF7eo9J41e/PZaz0xciBJax3zovbfFXUVmfD5
         Bx56EWCA5LRzZDrQwXOmekhP/RgMw/u5e/akEhfwL9sSeuGyz8mokJdWNv3gzQhx+H
         OsXrYKBRQrUraRWVhxSxd4c6Ug64YRz/1BMBen4viIcIZ3zKmwqcwuw5wS0jISJTKF
         /ZBj89ly7AZHqT/zl/PEWw/DPc0MRKzuQONeOZFFA5IG1WQW2luOgHRNd6twnb8WfF
         H2WNUtTI5pEmw==
Date:   Thu, 1 Apr 2021 23:08:02 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] torture: Correctly fetch CPUs for kvm-build.sh with all
 native language
Message-ID: <20210401210802.GC116405@lothringen>
References: <20210401132602.116352-1-frederic@kernel.org>
 <20210401185116.GH2696@paulmck-ThinkPad-P72>
 <20210401203112.GA116405@lothringen>
 <20210401204022.GI2696@paulmck-ThinkPad-P72>
 <20210401204113.GB116405@lothringen>
 <20210401210253.GJ2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401210253.GJ2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:02:53PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 01, 2021 at 10:41:13PM +0200, Frederic Weisbecker wrote:
> > On Thu, Apr 01, 2021 at 01:40:22PM -0700, Paul E. McKenney wrote:
> > > On Thu, Apr 01, 2021 at 10:31:12PM +0200, Frederic Weisbecker wrote:
> > > > On Thu, Apr 01, 2021 at 11:51:16AM -0700, Paul E. McKenney wrote:
> > > > > On Thu, Apr 01, 2021 at 03:26:02PM +0200, Frederic Weisbecker wrote:
> > > > > > Grepping for "CPU" on lscpu output isn't always successful, depending
> > > > > > on the local language setting. As a result, the build can be aborted
> > > > > > early with:
> > > > > > 
> > > > > > 	"make: the '-j' option requires a positive integer argument"
> > > > > > 
> > > > > > Prefer a more generic solution.
> > > > > > 
> > > > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > > 
> > > > > Good catch, applied, thank you!
> > > > > 
> > > > > There is a similar construct in kvm-remote.sh, so I added a similar
> > > > > fix to your patch.
> > > > > 
> > > > > But what about this in functions.sh?
> > > > > 
> > > > > nt="`lscpu | grep '^NUMA node0' | sed -e 's/^[^,]*,\([0-9]*\),.*$/\1/'`"
> > > > > 
> > > > > I am guessing that "node0" is human-language-independent, but is "NUMA"?
> > > > 
> > > > I thought they wouldn't bother translating that, but they did...
> > > > 
> > > >     NUMA node0 CPU(s):               0-7
> > > > 
> > > > becomes:
> > > > 
> > > >     Nœud NUMA 0 de processeur(s) : 0-7
> > > > 
> > > > Not sure about the best way to fix it.
> > > 
> > > The rude and crude fix is for the scripts to force the local language
> > > to English.  ;-)
> > 
> > I don't have a better answer :o)
> 
> If you set the environment variable LANG to en_US.UTF-8, does that
> make things work for you?  Huh.  Setting it to fr_FR.UTF-8 does not
> shift lscpu out of English for me, so I am guessing "no".

Maybe that language isn't installed in your system. I would expect
en_US.UTF-8 to be supported pretty much everywhere though. At least it
works for me with: "LANG=en_US.UTF-8 lscpu".

Thanks.

> 
> Help?
> 
> 							Thanx, Paul
