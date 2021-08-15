Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43BE3EC888
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 12:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbhHOK3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 06:29:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:46489 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237218AbhHOK3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 06:29:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10076"; a="215762023"
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; 
   d="scan'208";a="215762023"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2021 03:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,322,1620716400"; 
   d="scan'208";a="486769745"
Received: from pl-dbox.sh.intel.com (HELO pl-dbox) ([10.239.159.39])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2021 03:28:42 -0700
Date:   Sun, 15 Aug 2021 18:22:51 +0800
From:   Philip Li <philip.li@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/urgent] BUILD SUCCESS WITH WARNING
 064855a69003c24bd6b473b367d364e418c57625
Message-ID: <20210815102251.GA1550379@pl-dbox>
References: <6118d218.4ZZRXYKZCzQSq1Km%lkp@intel.com>
 <YRjTkkpDjaWxEpjb@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRjTkkpDjaWxEpjb@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2021 at 10:42:58AM +0200, Borislav Petkov wrote:
> Hi,
> 
> On Sun, Aug 15, 2021 at 04:36:40PM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
> > branch HEAD: 064855a69003c24bd6b473b367d364e418c57625  x86/resctrl: Fix default monitoring groups reporting
> > 
> > possible Warning in current branch:
> > 
> > arch/x86/kernel/cpu/resctrl/monitor.c:310 __mon_event_count() error: uninitialized symbol 'm'.
> > arch/x86/kernel/cpu/resctrl/monitor.c:315 __mon_event_count() error: potentially dereferencing uninitialized 'm'.
> > 
> > Warning ids grouped by kconfigs:
> > 
> > gcc_recent_errors
> > `-- i386-randconfig-m021-20210812
> >     |-- arch-x86-kernel-cpu-resctrl-monitor.c-__mon_event_count()-error:potentially-dereferencing-uninitialized-m-.
> >     `-- arch-x86-kernel-cpu-resctrl-monitor.c-__mon_event_count()-error:uninitialized-symbol-m-.
> 
> AFAIR, I had already asked you guys to make those reports more useful
> as, for example, adding a link to that randconfig above or even
> attaching it so that a person - not a machine - reading it, can
> *actually* act upon it.
> 
> But that hasn't happened.
Sorry Boris, we actually followed this suggestion to enable such logic, and
it is supposed to show the report link like below in the summary report in case
the user doesn't receive the standalone issue report.

We will check what happened here and look for resolving it soon.

	tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210813-sysfs-fixes-v8
	branch HEAD: f5b8aadeca76656caad8bccc795bfe7b0730230a  zram: use ATTRIBUTE_GROUPS to fix sysfs deadlock module removal

	Error/Warning reports:

	https://lore.kernel.org/lkml/202108141020.SK0WVBMv-lkp@intel.com
	https://lore.kernel.org/lkml/202108141131.dFBzZxp1-lkp@intel.com
	https://lore.kernel.org/lkml/202108141238.Ch3EsLWk-lkp@intel.com
	https://lore.kernel.org/lkml/202108141311.9xkkGVte-lkp@intel.com
	https://lore.kernel.org/lkml/202108142031.4ZMZDpLa-lkp@intel.com
	https://lore.kernel.org/lkml/202108142340.phk6ixfR-lkp@intel.com

	Error/Warning in current branch:

	arch/x86/kernel/cpu/resctrl/rdtgroup.c:210:7: error: too few arguments to function '__kernfs_create_file'
	arch/x86/kernel/cpu/resctrl/rdtgroup.c:212:13: warning: passing argument 7 of '__kernfs_create_file' makes integer from pointer without a cast [-Wint-conversion]
	arch/x86/kernel/cpu/resctrl/rdtgroup.c:212:23: error: passing argument 8 of '__kernfs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
	arch/x86/kernel/cpu/resctrl/rdtgroup.c:212:38: error: too few arguments to function call, expected 11, have 10

Thanks

> 
> Until it happens, I'm going to ignore all those reports from you.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
