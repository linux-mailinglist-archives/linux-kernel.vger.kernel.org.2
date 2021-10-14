Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD13542D17E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 06:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhJNE0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 00:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhJNE0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 00:26:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E55A610E6;
        Thu, 14 Oct 2021 04:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634185441;
        bh=vJT/Fonji+gCvVPQnpFOqQuK7TrDdMcCq3KD+XwPQrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJsvyTBoSfoZNbPYAppoygn4O8oOOzSLbV4yW8U9PKSt1zuesKel5DwhJiNQZgh2U
         gVywR9Xaj1JXtnZfJyBozyyx9npBCSaSEGAC1ZA0c/wUXz7GwoNGBebdQmDuX/IEaw
         XqCD22T72Y1odbGgOkWoalVsNitqho2Smn2C+AawksdT56AkZ+ahx5mKIHxfw5WDEB
         AMBUW/DaLTsUnfw7vxgeJvYvQ1bIFUOckQZdgLumk6JxkZspdDxUFhH7Q2YCM5dgXS
         RyIOSm+92lVNeDTd1QZDKo6m/UM6iFpkD7BstfUN1TLahQdEDrCtPV5lb2IXBqrurH
         C83m+8JxxqjBg==
Date:   Wed, 13 Oct 2021 21:23:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Yafang Shao <laoar.shao@gmail.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip:sched/core 14/47] kernel/sched/fair.c:893:22: error:
 variable 'p' set but not used
Message-ID: <YWew3ItdPC5QrL/w@archlinux-ax161>
References: <202110121132.N2z9JrD0-lkp@intel.com>
 <YWVw/oVd5ztGZDAK@hirez.programming.kicks-ass.net>
 <YWWPLnaZGybHsTkv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWWPLnaZGybHsTkv@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 03:35:42PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 12, 2021 at 01:26:54PM +0200, Peter Zijlstra wrote:
> 
> > Again, I have absolutely no intention of fixing this. IMO this is the
> > compiler being a total pain in the arse.
> > 
> > Please stop reporting this.
> 
> How's this then?
> 
> diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
> index 978fcfca5871..b0d9121c5dce 100644
> --- a/kernel/sched/Makefile
> +++ b/kernel/sched/Makefile
> @@ -3,6 +3,10 @@ ifdef CONFIG_FUNCTION_TRACER
>  CFLAGS_REMOVE_clock.o = $(CC_FLAGS_FTRACE)
>  endif
>  
> +# The compilers are complaining about unused variables inside an if(0) scope
> +# block. This is daft, shut them up.
> +ccflags-y += -Wno-unused-but-set-variable

Please consider making this

ccflags-y += $(call cc-disable-warning, unused-but-set-variable)

because -Wunused-but-set-variable was only added to clang in the 13
release but we support back to 10, meaning this will cause errors for
those older compilers.

With that:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Additionally, perhaps this could be restricted to just fair.c?

> +
>  # These files are disabled because they produce non-interesting flaky coverage
>  # that is not a function of syscall inputs. E.g. involuntary context switches.
>  KCOV_INSTRUMENT := n
> 
