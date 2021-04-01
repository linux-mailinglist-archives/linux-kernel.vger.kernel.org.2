Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D17351F0F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbhDASwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:52:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236107AbhDASiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:38:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA309601FC;
        Thu,  1 Apr 2021 18:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617302283;
        bh=ycPZTuXV6tAL8jhfe8KPvmUs0jN23x/LD9ZQt1KdAlc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n39PS0t2fQ2IrKMq53PHuuJSgR5J7pjh7fvUUnw5Jd+SvZGirKnnrb1dWMmsjWOo4
         Bwv+jQB4pwY+mVq8VzcES9XCMCXY4EdrcxtmxixoubsdUk9csiXRPusoF7Ly4NltRl
         zkkyD6CgRNOGvL0Xy6mo2Th5E9ANeWX5oVrPiQPQR0fsmqIRAO+s1ri5Tp6GIXFHd3
         LtrwmmnMX0YqntyhbB/wWG53+jHpx2eVRas40o6DDqju8PuWckCWAs15Shqd6sncea
         C4USwvXc41frPMXQR2+4zbyaqXIFITWyoBwsQupy+9fz7DoyhaHwaw3XqoRmfYacY0
         mgVNNR7PcInZQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8AC5035237B2; Thu,  1 Apr 2021 11:38:03 -0700 (PDT)
Date:   Thu, 1 Apr 2021 11:38:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     tony.luck@intel.com, linux-kernel@vger.kernel.org, riel@surriel.com
Subject: Re: Backporting to v5.6: fd258dc4442c ("x86/mce: Add Skylake quirk
 for patrol scrub reported errors")
Message-ID: <20210401183803.GG2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210401161740.GA22501@paulmck-ThinkPad-P72>
 <20210401181854.GB11782@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401181854.GB11782@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 08:18:54PM +0200, Borislav Petkov wrote:
> Hey Paul,
> 
> On Thu, Apr 01, 2021 at 09:17:40AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > We are looking at backporting fd258dc4442c ("x86/mce: Add Skylake quirk
> > for patrol scrub reported errors") to v5.6.  When accompanied by these
> > guys, it passes our usual kernel smoke-testing:
> > 
> > 1df73b2131e3 ("x86/mce: Fixup exception only for the correct MCEs")
> > 1de08dccd383 ("x86/mce: Add a struct mce.kflags field")
> 
> why do you even need those two?
> 
> fd258dc4442c gives you only an Action Optional severity for that
> particular error type and the other two patches are for recovery of
> errors in the kernel memory range, i.e., for pmem etc., so should be
> unrelated.
> 
> I mean, it depends on what you want to backport, ofc.

Even better, thank you very much!

							Thanx, Paul
