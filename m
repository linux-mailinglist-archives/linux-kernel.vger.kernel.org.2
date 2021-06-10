Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69FD3A27DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhFJJMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:12:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:12131 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhFJJMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:12:15 -0400
IronPort-SDR: m55rjNS1u+twcMoOl3kygSxHmUvaQvIMllXfyEBA2z+OYMVTActMW9iZlRknv97VoMm8+nSOhe
 0MMZVyCVv1BQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="205292782"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="205292782"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 02:10:16 -0700
IronPort-SDR: bxFcL31JFW33VUDlSzLMRq5Nj3B5KVEI2KPFoicP+8jr3T05unnqpYJFC1a8V8dVEChfTatMBX
 A0pf0ozQNK2Q==
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="552985062"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 02:10:14 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1lrGhX-0015vb-RQ; Thu, 10 Jun 2021 12:10:11 +0300
Date:   Thu, 10 Jun 2021 12:10:11 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] lib: remove leading spaces before tabs
Message-ID: <YMHW80wUyFpW6Utf@smile.fi.intel.com>
References: <20210608071430.12687-1-thunder.leizhen@huawei.com>
 <CAHp75VfuMJ5kfRDB4tE2zr2Em79HiwrDJVROnw+kD3H+QNM4sg@mail.gmail.com>
 <da4915c5-fa13-0cf2-f2d2-02779a64af1b@huawei.com>
 <8a70d592e14f93822bf40832c7374d8e491c3afc.camel@perches.com>
 <26ee1009-259d-07a6-495f-87557be9ed8a@huawei.com>
 <3211e76c-d2a0-1e26-940b-9710073ee7d4@huawei.com>
 <CAHp75VfQq=RkjyZQsc-PHLTLRCzXovm-D_Z+Pp3A6vWGA-GKug@mail.gmail.com>
 <7e0f67a63b7093f4d20e0c0ccb076d9244e26a9a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e0f67a63b7093f4d20e0c0ccb076d9244e26a9a.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 02:44:54PM -0700, Joe Perches wrote:
> On Wed, 2021-06-09 at 13:30 +0300, Andy Shevchenko wrote:
> > On Wed, Jun 9, 2021 at 9:21 AM Leizhen (ThunderTown)
> > <thunder.leizhen@huawei.com> wrote:
> > > On 2021/6/9 13:15, Leizhen (ThunderTown) wrote:
> > > > On 2021/6/9 0:03, Joe Perches wrote:
> > > > > On Tue, 2021-06-08 at 17:00 +0800, Leizhen (ThunderTown) wrote:
> > > > > > On 2021/6/8 16:44, Andy Shevchenko wrote:
> > > > > > > On Tue, Jun 8, 2021 at 10:14 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> > > > > > > > 
> > > > > > > > 1) Run the following command to find and remove the leading spaces before
> > > > > > > >    tabs:
> > > > > > > >    find lib/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'
> > > > > > > 
> > > > > > > Hint for the future, try to use what Git provides, for example `git
> > > > > > > ls-files -- lib/`.
> > > > > > 
> > > > > > Okay, thanks. I learned a new trick.
> > 
> > > > > For instance:
> > > > > 
> > > > > $ git diff --stat lib
> > > > > $ git ls-files lib/ | \
> > > > >   xargs ./scripts/checkpatch.pl --types=SPACE_BEFORE_TAB --fix-inplace
> > > 
> > > I just tried it. It's too slow.
> > 
> > If checkpath accepts infinite positional arguments, then proper way of
> > use (that's how I do with simple perl regexps) is to
> > 
> > scripts/checkpatch.pl --types=SPACE_BEFORE_TAB --fix-inplace -- $(git ls-files lib/)
> 
> That won't always work:
> 
> $ git ls-files | xargs | wc -c
> 2716737
> 
> Nothing accepts infinite positional arguments.
> You are always limited by the maximum length of a command line
> 
> $ getconf ARG_MAX
> 2097152
> 
> xargs has:
> 
> $ xargs --show-limits
> Your environment variables take up 3517 bytes
> POSIX upper limit on argument length (this system): 2091587
> POSIX smallest allowable upper limit on argument length (all systems): 4096
> Maximum length of command we could actually use: 2088070
> Size of command buffer we are actually using: 131072
> Maximum parallelism (--max-procs must be no greater): 2147483647

If you care about parallelism, the checkpatch should be doing it itself.

Currently it's one perl interpreter with a single queue vs. zillions of perl
invocations (with all downsides of this). And I'm not sure which one is a
winning.

And yes, I'm aware of why xargs is ever exists (including handling of the
special file names).

> > Seems like we have a shell lesson :-)
> 
> Maybe so.
> 
> Using xargs allows use of -P to invoke parallelism.
> Or you could just use gnu parallel instead of xargs.
> 
> Using './scripts/checkpatch.pl -- $(git ls-files <path>)' will only
> allow a single process to be invoked for the files to be scanned.

-- 
With Best Regards,
Andy Shevchenko


