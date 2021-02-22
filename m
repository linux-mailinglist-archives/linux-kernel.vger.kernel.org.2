Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CB13222B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhBVXoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:44:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230088AbhBVXoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:44:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2762E64E00;
        Mon, 22 Feb 2021 23:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614037404;
        bh=gJMms421b5cvbD5M9HvPWUC+099Pr/G7QIjdPJ3ZCgY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iImD1sVhKc2Obnx1+gPxf93iJNt3PzkZ70wPdlZgIYS97P0y9u3ApcrQqpWT7jiSh
         NRcQiwheD7jxd/9d9VYqvdZ7WKx3oJEZJGhzW4bs8i4Q+URcBW4iAypCvO/H7NmkfL
         h7h0No192BEDzllQcTqWMmKu+kXtXsv8+dCE9NoTECdoZtSc+TJjnHr9b8YW0VORFE
         BBfZiiFACtbSTFXDMeY6A3kCrINrH5RD8w7uXcOnB0vhLPkgh8dej2MljgwklVId0m
         usekEGTb1z+rQ/NyzE7qCkbVwsDwa8jrUGwFDXkvNL8n2z3Xr4hEX8FCRiahHXK3nO
         ZOSo4GQEWG6aw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EB11E3523031; Mon, 22 Feb 2021 15:43:23 -0800 (PST)
Date:   Mon, 22 Feb 2021 15:43:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 0/8] support for bitmap (and hence CPU) list "N"
 abbreviation
Message-ID: <20210222234323.GR2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210221080827.84862-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210221080827.84862-1-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 03:08:19AM -0500, Paul Gortmaker wrote:
> This is the 5th and final version of this series.  We got some good
> improvements, like adding self-tests, using "N" as "just another number"
> that could be used anywhere, and making things not CPU specific.
> 
> But now it is time to close this review out since is down to just
> hand-wringing over hypothetical use cases, bikeshedding on upper/lower
> case, and a wild goose chase on trying to avoid adding a function arg.
> 
> So, once again - thanks to all who provided input; it was all considered
> even if not all of it was used.  And in that vein, just to be clear:
> 
> 1) There will be no adaptive modifying or guessing what the user meant if
> a range turns out to be invalid.  The caller will be responsible for
> handling the -EINVAL just as things are currently today.
> 
> 2) There will be no use of "L" or lower case "n" because there is simply
> no need for it.  Yes, it would be simple enough to add, but it complicates
> things and would also be impossible to remove later, once it went mainline.

Queued and pushed, thank you!!!

							Thanx, Paul

> The original text from v4 follows:
> 
> The basic objective here was to add support for "nohz_full=8-N" and/or
> "rcu_nocbs="4-N" -- essentially introduce "N" as a portable reference
> to the last core, evaluated at boot for anything using a CPU list.
> 
> The thinking behind this, is that people carve off a few early CPUs to
> support housekeeping tasks, and perhaps dedicate one to a busy I/O
> peripheral, and then the remaining pool of CPUs out to the end are a
> part of a commonly configured pool used for the real work the user
> cares about.
> 
> Extend that logic out to a fleet of machines - some new, and some
> nearing EOL, and you've probably got a wide range of core counts to
> contend with - even though the early number of cores dedicated to the
> system overhead probably doesn't vary.
> 
> This change would enable sysadmins to have a common bootarg across all
> such systems, and would also avoid any off-by-one fencepost errors that
> happen for users who might briefly forget that core counts start at zero.
> 
> Originally I did this at the CPU subsys level, but Yury suggested it
> be moved down further to bitmap level itself, which made the core 
> implementation smaller and less complex, but the series longer.
> 
> New self tests are added to better exercise what bitmap range/region
> currently supports, and new tests are added for the new "N" support.
> 
> Also tested boot arg and the post-boot cgroup use case as per below:
> 
>    root@hackbox:~# cat /proc/cmdline 
>    BOOT_IMAGE=/boot/bzImage root=/dev/sda1 rcu_nocbs=2,3,8-N:1/2
>    root@hackbox:~# dmesg|grep Offl
>    rcu:     Offload RCU callbacks from CPUs: 2-3,8,10,12,14.
> 
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>    
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 10-N > cpuset.cpus
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>    10-15
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo N-N:N/N > cpuset.cpus
>    root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
>    15
> 
> This was on a 16 core machine with CONFIG_NR_CPUS=16 in .config file.
> 
> Note that "N" is a dynamic quantity, and can change scope if the bitmap
> is changed in size.  So at the risk of stating the obvious, don't use it
> for "burn_eFuse=128-N" or "secure_erase_firmware=32-N" type stuff.
> 
> Paul.
> ---
> 
> [v5: go back to v3 location of "nbits" in region.  Add acks/reviewed.]
> 
> [v4: pair nbits with region, instead of inside it.  Split EINVAL and
>  ERANGE tests.  Don't handle start/end/offset within a macro to
>  abstract away nbits usage.  Added some Reviwed-by/Ack tags.]
>  https://lore.kernel.org/lkml/20210209225907.78405-1-paul.gortmaker@windriver.com/
> 
> [v3: Allow "N" to be used anywhere in the region spec, i.e. "N-N:N/N" vs.
>  just being allowed at end of range like "0-N".  Add new self-tests.  Drop
>  "all" and "none" aliases as redundant and not worth the extra complication. ]
>  https://lore.kernel.org/lkml/20210126171141.122639-1-paul.gortmaker@windriver.com/
> 
> [v2: push code down from cpu subsys to core bitmap code as per
>  Yury's comments.  Change "last" to simply be "N" as per PeterZ.]
>  https://lore.kernel.org/lkml/20210121223355.59780-1-paul.gortmaker@windriver.com/
> 
> [v1: https://lore.kernel.org/lkml/20210106004850.GA11682@paulmck-ThinkPad-P72/
> 
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> 
> 
> Paul Gortmaker (8):
>   lib: test_bitmap: clearly separate ERANGE from EINVAL tests.
>   lib: test_bitmap: add tests to trigger ERANGE case.
>   lib: test_bitmap: add more start-end:offset/len tests
>   lib: bitmap: fold nbits into region struct
>   lib: bitmap: move ERANGE check from set_region to check_region
>   lib: bitmap: support "N" as an alias for size of bitmap
>   lib: test_bitmap: add tests for "N" alias
>   rcu: deprecate "all" option to rcu_nocbs=
> 
>  .../admin-guide/kernel-parameters.rst         |  7 +++
>  .../admin-guide/kernel-parameters.txt         |  4 +-
>  kernel/rcu/tree_plugin.h                      |  6 +--
>  lib/bitmap.c                                  | 49 +++++++++++--------
>  lib/test_bitmap.c                             | 46 ++++++++++++++---
>  5 files changed, 79 insertions(+), 33 deletions(-)
> 
> -- 
> 2.30.0
> 
