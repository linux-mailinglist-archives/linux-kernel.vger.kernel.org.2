Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50253522E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhDAWsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234043AbhDAWso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:48:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1AE8610CE;
        Thu,  1 Apr 2021 22:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617317324;
        bh=ihxVY1Xf7RR0Ojf3QwbQINACQO40jOZN2xYgkYw4Vpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekBdLhBLQ1QXfEPpmXTeSj1bybHoWfsdh5j9sbTsK8o8EVIJNVYmBqc/DV5VmTZ0L
         zLbfE/OkR4SsUTVf+KSGK/5jyds34x7e2SML4BhMjZPtxVT939b+wFb4EbI8qdVfkG
         isddxDbB3qZjVT0wHYaV8fm0eiyRMGBS3tpFfc1T1X/RaulPECV+Icxaxg7KzN6Di3
         T5zPq2zsmJ0NkdXbMmnBHC3OQaq+csITwZbj918LUMRodWprZQDJGJeLDnUxLXcFoP
         KuisUVFvPNS+R9aMBJlMiQgvUMAlO900PTMFcAmM8F3Zt6CEejPB87MBtIp1337EgO
         MWEBW0Ec+m97A==
Date:   Fri, 2 Apr 2021 00:48:41 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] torture: Correctly fetch CPUs for kvm-build.sh with all
 native language
Message-ID: <20210401224841.GD116405@lothringen>
References: <20210401132602.116352-1-frederic@kernel.org>
 <20210401185116.GH2696@paulmck-ThinkPad-P72>
 <20210401203112.GA116405@lothringen>
 <20210401204022.GI2696@paulmck-ThinkPad-P72>
 <20210401204113.GB116405@lothringen>
 <20210401210253.GJ2696@paulmck-ThinkPad-P72>
 <20210401210802.GC116405@lothringen>
 <20210401223329.GK2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401223329.GK2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 03:33:29PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 01, 2021 at 11:08:02PM +0200, Frederic Weisbecker wrote:
> How about like this?  I put this only in kvm.sh for the moment, but
> if these keep cropping up I will just hit all the scripts.  ;-)

Sure, works for me!

Thanks.

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 4ca332016ed81c15ebb3b744dbfc462281c544b8
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Apr 1 15:26:56 2021 -0700
> 
>     torture:  Set kvm.sh language to English
>     
>     Some of the code invoked directly and indirectly from kvm.sh parses
>     the output of commands.  This parsing assumes English, which can cause
>     failures if the user has set some other language.  In a few cases,
>     there are language-independent commands available, but this is not
>     always the case.  Therefore, as an alternative to polyglot parsing,
>     this commit sets the LANG environment variable to en_US.UTF-8.
>     
>     Reported-by: Frederic Weisbecker <frederic@kernel.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
> index fab3bd9..390bb97 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
> @@ -20,6 +20,9 @@ mkdir $T
>  
>  cd `dirname $scriptname`/../../../../../
>  
> +# This script knows only English.
> +LANG=en_US.UTF-8; export LANG
> +
>  dur=$((30*60))
>  dryrun=""
>  KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
