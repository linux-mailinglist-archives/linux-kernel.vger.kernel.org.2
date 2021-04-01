Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FA835213F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhDAVCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233665AbhDAVCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:02:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE75B60724;
        Thu,  1 Apr 2021 21:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617310973;
        bh=SL8RNPXSmnjG3Oh0JNkqCPmWSrtOax7VXHm0VsJb2Kc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tULNTpGXwNU1qHdcEyIKL7kQhuQsoWqa09xCfjH05WnaFH2d9Y/S74IdZZNG++bQg
         7/X8Ph2tkCNualaIq5vSuxss4NL2+MjVPNQ81ZeFAwjYYa5GMlTr0Qfm0iZ8nciBju
         dWkAvdDMMaucfXbsStG9B40e+PA4VMaAeLb8mT1A5FAOkl4o8MLlrQHOV5k/2rHBR4
         dlO/ZVg3aUTgG643ysfukzzeCydYEzghnWicS0KrPVIxLwoR0/ZUpJCPGq9VVqtMjR
         XdVfXP2qDGnK+Va6y1iGtsThB6emiZ/VCHDL2JLiLRElJJ4vpQ2Kc2FjBlL/VjVBo1
         7SwLmm9ltIOoQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 767DC35237B2; Thu,  1 Apr 2021 14:02:53 -0700 (PDT)
Date:   Thu, 1 Apr 2021 14:02:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] torture: Correctly fetch CPUs for kvm-build.sh with all
 native language
Message-ID: <20210401210253.GJ2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210401132602.116352-1-frederic@kernel.org>
 <20210401185116.GH2696@paulmck-ThinkPad-P72>
 <20210401203112.GA116405@lothringen>
 <20210401204022.GI2696@paulmck-ThinkPad-P72>
 <20210401204113.GB116405@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401204113.GB116405@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 10:41:13PM +0200, Frederic Weisbecker wrote:
> On Thu, Apr 01, 2021 at 01:40:22PM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 01, 2021 at 10:31:12PM +0200, Frederic Weisbecker wrote:
> > > On Thu, Apr 01, 2021 at 11:51:16AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Apr 01, 2021 at 03:26:02PM +0200, Frederic Weisbecker wrote:
> > > > > Grepping for "CPU" on lscpu output isn't always successful, depending
> > > > > on the local language setting. As a result, the build can be aborted
> > > > > early with:
> > > > > 
> > > > > 	"make: the '-j' option requires a positive integer argument"
> > > > > 
> > > > > Prefer a more generic solution.
> > > > > 
> > > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > 
> > > > Good catch, applied, thank you!
> > > > 
> > > > There is a similar construct in kvm-remote.sh, so I added a similar
> > > > fix to your patch.
> > > > 
> > > > But what about this in functions.sh?
> > > > 
> > > > nt="`lscpu | grep '^NUMA node0' | sed -e 's/^[^,]*,\([0-9]*\),.*$/\1/'`"
> > > > 
> > > > I am guessing that "node0" is human-language-independent, but is "NUMA"?
> > > 
> > > I thought they wouldn't bother translating that, but they did...
> > > 
> > >     NUMA node0 CPU(s):               0-7
> > > 
> > > becomes:
> > > 
> > >     Nœud NUMA 0 de processeur(s) : 0-7
> > > 
> > > Not sure about the best way to fix it.
> > 
> > The rude and crude fix is for the scripts to force the local language
> > to English.  ;-)
> 
> I don't have a better answer :o)

If you set the environment variable LANG to en_US.UTF-8, does that
make things work for you?  Huh.  Setting it to fr_FR.UTF-8 does not
shift lscpu out of English for me, so I am guessing "no".

Help?

							Thanx, Paul
