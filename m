Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3381735209B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhDAUbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234407AbhDAUbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:31:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4B05610D0;
        Thu,  1 Apr 2021 20:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617309075;
        bh=hesAkTNQJud2zSBji7Xla+24h8mR3EHcOqfAeZrr1B0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TrGqF8xCn5JXauHa1Ww3ZJv8dcABJr6+qQTnvSQu27UOMk/E70Jl3/xtAPhOAoj8e
         GB8WLDztAnLLGPhMBvAoLUyHG3Q9Uma27Z6ihQou1oMHt1IBcuZTAYDdiR4dX0mdJx
         yba0gB6oLR1vIFbqD0S+ayt8FAaYe46YfhqdOMMF95lSeE+GxH5okZCoyskdozCXP+
         KP9MVkh1s9hFnOYFa1tIoHqYi04lnJbYJRduZwBg/bCaP35Dv5/A7NTMH0NiGLkGTD
         xcLSmNopvPKs/XYu1hYotEZJkq1PgBQPKZ/EsjeLwVPDNU9rG4J8IqBMePD+eACS2P
         DQmU50u1b+g+g==
Date:   Thu, 1 Apr 2021 22:31:12 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] torture: Correctly fetch CPUs for kvm-build.sh with all
 native language
Message-ID: <20210401203112.GA116405@lothringen>
References: <20210401132602.116352-1-frederic@kernel.org>
 <20210401185116.GH2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401185116.GH2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:51:16AM -0700, Paul E. McKenney wrote:
> On Thu, Apr 01, 2021 at 03:26:02PM +0200, Frederic Weisbecker wrote:
> > Grepping for "CPU" on lscpu output isn't always successful, depending
> > on the local language setting. As a result, the build can be aborted
> > early with:
> > 
> > 	"make: the '-j' option requires a positive integer argument"
> > 
> > Prefer a more generic solution.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Good catch, applied, thank you!
> 
> There is a similar construct in kvm-remote.sh, so I added a similar
> fix to your patch.
> 
> But what about this in functions.sh?
> 
> nt="`lscpu | grep '^NUMA node0' | sed -e 's/^[^,]*,\([0-9]*\),.*$/\1/'`"
> 
> I am guessing that "node0" is human-language-independent, but is "NUMA"?

I thought they wouldn't bother translating that, but they did...

    NUMA node0 CPU(s):               0-7

becomes:

    Nœud NUMA 0 de processeur(s) : 0-7

Not sure about the best way to fix it.

Thanks.
