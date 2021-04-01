Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D978C3522CA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhDAWdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233789AbhDAWda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:33:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B56F360FE7;
        Thu,  1 Apr 2021 22:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617316409;
        bh=fROVYi26J7ke/VX/V+4Nv14tpmDBZAjJdqilLVHHglk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uHXRfi5K+pBC6bS4BvrFy+IU/6XjZ9+WZGGee/glm1/qVm+SoSC/FE18X+kcWSk52
         JPldzNVCggoYvexsrYcsJBZwxOBOJcFCQsQlnoQgENOkPqy4pKxSdF34il0e+J4qst
         cN+HAmoNz/n5NIojvvIUcstfO37YF5NrH9xJeWqcotDVKIHPmOPpl80ZgKkkW5ZSZ8
         oJRHp1Qb6R+Qd19UnTHCVytCNtdvEEr2ohDVGJX2aGLkVzV1geTGS9V0ngQxR8fxJg
         3LZfFKBYPUkRAOf/PwWBkC9kq56Nbdoa+nxzMqoJSPiuwLfRX3wkhqdNXgQI66oY1Y
         Kakasdb+lVvqQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 61D7035237B2; Thu,  1 Apr 2021 15:33:29 -0700 (PDT)
Date:   Thu, 1 Apr 2021 15:33:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] torture: Correctly fetch CPUs for kvm-build.sh with all
 native language
Message-ID: <20210401223329.GK2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210401132602.116352-1-frederic@kernel.org>
 <20210401185116.GH2696@paulmck-ThinkPad-P72>
 <20210401203112.GA116405@lothringen>
 <20210401204022.GI2696@paulmck-ThinkPad-P72>
 <20210401204113.GB116405@lothringen>
 <20210401210253.GJ2696@paulmck-ThinkPad-P72>
 <20210401210802.GC116405@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401210802.GC116405@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:08:02PM +0200, Frederic Weisbecker wrote:
> On Thu, Apr 01, 2021 at 02:02:53PM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 01, 2021 at 10:41:13PM +0200, Frederic Weisbecker wrote:
> > > On Thu, Apr 01, 2021 at 01:40:22PM -0700, Paul E. McKenney wrote:
> > > > On Thu, Apr 01, 2021 at 10:31:12PM +0200, Frederic Weisbecker wrote:
> > > > > On Thu, Apr 01, 2021 at 11:51:16AM -0700, Paul E. McKenney wrote:
> > > > > > On Thu, Apr 01, 2021 at 03:26:02PM +0200, Frederic Weisbecker wrote:
> > > > > > > Grepping for "CPU" on lscpu output isn't always successful, depending
> > > > > > > on the local language setting. As a result, the build can be aborted
> > > > > > > early with:
> > > > > > > 
> > > > > > > 	"make: the '-j' option requires a positive integer argument"
> > > > > > > 
> > > > > > > Prefer a more generic solution.
> > > > > > > 
> > > > > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > > > 
> > > > > > Good catch, applied, thank you!
> > > > > > 
> > > > > > There is a similar construct in kvm-remote.sh, so I added a similar
> > > > > > fix to your patch.
> > > > > > 
> > > > > > But what about this in functions.sh?
> > > > > > 
> > > > > > nt="`lscpu | grep '^NUMA node0' | sed -e 's/^[^,]*,\([0-9]*\),.*$/\1/'`"
> > > > > > 
> > > > > > I am guessing that "node0" is human-language-independent, but is "NUMA"?
> > > > > 
> > > > > I thought they wouldn't bother translating that, but they did...
> > > > > 
> > > > >     NUMA node0 CPU(s):               0-7
> > > > > 
> > > > > becomes:
> > > > > 
> > > > >     Nœud NUMA 0 de processeur(s) : 0-7
> > > > > 
> > > > > Not sure about the best way to fix it.
> > > > 
> > > > The rude and crude fix is for the scripts to force the local language
> > > > to English.  ;-)
> > > 
> > > I don't have a better answer :o)
> > 
> > If you set the environment variable LANG to en_US.UTF-8, does that
> > make things work for you?  Huh.  Setting it to fr_FR.UTF-8 does not
> > shift lscpu out of English for me, so I am guessing "no".
> 
> Maybe that language isn't installed in your system. I would expect
> en_US.UTF-8 to be supported pretty much everywhere though. At least it
> works for me with: "LANG=en_US.UTF-8 lscpu".
> 
> Thanks.

How about like this?  I put this only in kvm.sh for the moment, but
if these keep cropping up I will just hit all the scripts.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit 4ca332016ed81c15ebb3b744dbfc462281c544b8
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Apr 1 15:26:56 2021 -0700

    torture:  Set kvm.sh language to English
    
    Some of the code invoked directly and indirectly from kvm.sh parses
    the output of commands.  This parsing assumes English, which can cause
    failures if the user has set some other language.  In a few cases,
    there are language-independent commands available, but this is not
    always the case.  Therefore, as an alternative to polyglot parsing,
    this commit sets the LANG environment variable to en_US.UTF-8.
    
    Reported-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index fab3bd9..390bb97 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -20,6 +20,9 @@ mkdir $T
 
 cd `dirname $scriptname`/../../../../../
 
+# This script knows only English.
+LANG=en_US.UTF-8; export LANG
+
 dur=$((30*60))
 dryrun=""
 KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
