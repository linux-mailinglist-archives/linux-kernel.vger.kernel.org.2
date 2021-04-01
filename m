Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8576D3520AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhDAUkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234462AbhDAUkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:40:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6426610E9;
        Thu,  1 Apr 2021 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617309622;
        bh=k81mSUwdLdwsb6oYkK10kDp03Ff3waN7MrD1Kh+VfPw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=i8/Ce9KSMjNiImtY51AbA39yg4i04QBhqiI97JF6+vLr32fV8Oa/d0izE0ZkyANFJ
         YEwWEvIPnRrnIw5ItJLBkD1aS42E0VP92B+ecPtRts0ucXjwxZvaQAqZeIZIhbv/L+
         uaP6hfA6SXA1jBX8xdkVsV0Y1XbxTzGWK6z2zYaYEusv+Fplp48s3iHbMXDSyxxkNv
         cdtxVao5dsxT6h44KEuXqVgTMr+N1qMGJ7l5+IzivMtxRXsUtr/ZrLmRiNkVZxHKWC
         Ri4E98kI1Ifcccy0kYbb/OeoT/d3f8HpOGZh8hX7+hS9e8HlKENlfVC4io8VRgd2LJ
         6q3BKIPTBVW3Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6D8CA35237B2; Thu,  1 Apr 2021 13:40:22 -0700 (PDT)
Date:   Thu, 1 Apr 2021 13:40:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] torture: Correctly fetch CPUs for kvm-build.sh with all
 native language
Message-ID: <20210401204022.GI2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210401132602.116352-1-frederic@kernel.org>
 <20210401185116.GH2696@paulmck-ThinkPad-P72>
 <20210401203112.GA116405@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401203112.GA116405@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 10:31:12PM +0200, Frederic Weisbecker wrote:
> On Thu, Apr 01, 2021 at 11:51:16AM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 01, 2021 at 03:26:02PM +0200, Frederic Weisbecker wrote:
> > > Grepping for "CPU" on lscpu output isn't always successful, depending
> > > on the local language setting. As a result, the build can be aborted
> > > early with:
> > > 
> > > 	"make: the '-j' option requires a positive integer argument"
> > > 
> > > Prefer a more generic solution.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Good catch, applied, thank you!
> > 
> > There is a similar construct in kvm-remote.sh, so I added a similar
> > fix to your patch.
> > 
> > But what about this in functions.sh?
> > 
> > nt="`lscpu | grep '^NUMA node0' | sed -e 's/^[^,]*,\([0-9]*\),.*$/\1/'`"
> > 
> > I am guessing that "node0" is human-language-independent, but is "NUMA"?
> 
> I thought they wouldn't bother translating that, but they did...
> 
>     NUMA node0 CPU(s):               0-7
> 
> becomes:
> 
>     Nœud NUMA 0 de processeur(s) : 0-7
> 
> Not sure about the best way to fix it.

The rude and crude fix is for the scripts to force the local language
to English.  ;-)

							Thanx, Paul
