Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6300D379F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 07:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhEKFlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 01:41:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:26582 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhEKFlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 01:41:23 -0400
IronPort-SDR: iTonsBvoF17N1VUbQqP35BVEqwb0t8hyVWERb7py7u9LRZq7K25cXP4UV7cjsCsk9SHLjupM0i
 dNqBtCerZjNw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="220316508"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="220316508"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 22:40:18 -0700
IronPort-SDR: fa7SYtMMFu8U+yKCj2+1c+bDai3KtD5syLwUUbiyrJ/XtVkKuaZrGlVfaUjc+hmxUzckyrhVJ/
 tsYyu+1a8Kiw==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="436491414"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 22:40:15 -0700
Date:   Tue, 11 May 2021 13:57:16 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Pratik Sampat <psampat@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: Re: [percpu]  ace7e70901:  aim9.sync_disk_rw.ops_per_sec -2.3%
 regression
Message-ID: <20210511055716.GC8539@xsang-OptiPlex-9020>
References: <20210427073448.GD32408@xsang-OptiPlex-9020>
 <YItcfQfZlNZTmQKR@carbon.dhcp.thefacebook.com>
 <40632FBD-8874-4B6C-A945-F2EBC96CF12B@fb.com>
 <20210507030606.GA27263@xsang-OptiPlex-9020>
 <YJV+Vn9eGfIlxDQE@carbon.dhcp.thefacebook.com>
 <YJWQE8AFjyYpsLYA@google.com>
 <20210511022614.GB8539@xsang-OptiPlex-9020>
 <YJnxd7nw2T+1A0mf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJnxd7nw2T+1A0mf@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dennis,

On Tue, May 11, 2021 at 02:52:39AM +0000, Dennis Zhou wrote:
> On Tue, May 11, 2021 at 10:26:14AM +0800, Oliver Sang wrote:
> > Hi Dennis,
> > 
> > On Fri, May 07, 2021 at 07:08:03PM +0000, Dennis Zhou wrote:
> > > On Fri, May 07, 2021 at 10:52:22AM -0700, Roman Gushchin wrote:
> > > > On Fri, May 07, 2021 at 11:06:06AM +0800, Oliver Sang wrote:
> > > > > hi Roman,
> > > > >  
> > > > > On Thu, May 06, 2021 at 12:54:59AM +0000, Roman Gushchin wrote:
> > > > > > Ping
> > > > > 
> > > > > sorry for late.
> > > > > 
> > > > > the new patch makes the performance a little better but still has
> > > > > 1.9% regression comparing to
> > > > > f183324133 ("percpu: implement partial chunk depopulation")
> > > > 
> > > > Hi Oliver!
> > > > 
> > > > Thank you for testing it!
> > > > 
> > > > Btw, can you, please, confirm that the regression is coming specifically
> > > > from ace7e70901 ("percpu: use reclaim threshold instead of running for every page")?
> > > > I do see *some* regression in my setup, but the data is very noisy, so I'm not sure
> > > > I can confirm it.
> > > > 
> > > > Thanks!
> > > 
> > > Thanks Oliver and Roman. If this is the case, I'll drop the final patch
> > > and just merge up to f183324133 ("percpu: implement partial chunk
> > > depopulation") into for-next as this is v5.14 anyway.
> > > 
> > > Oliver, is there a way to trigger the kernel test robot for a specific
> > > test?
> > 
> > sorry for late.
> 
> No worries. Thanks for all you work!
> 
> > not sure what kind of specific test you want robot to do?
> > if you mean for-next branch, if the branch is monitored by kernel test robot,
> > after merge, it will be tested by robot automatically and the bisect will be
> > triggered if there is still regression.
> 
> In this case, we believe there is a regression in
> "aim9.sync_disk_rw.ops_per_sec". I know my branches are monitored (hence
> we suspect this regression), but it would be nice to be able to kick off
> a test with a patch or set of patches on top to validate that the
> regression is fixed on your hardware configuration. Unfortunately I
> don't have a 100+ core machine lying around :P.

yes, we can do that. you could either send us the patch or patch set,
or give us the branch information and commits you want us to check.

> 
> Sorry for the additional questions, but is there a time frame that the
> kernel robot is expected scrape over my tree / what test suites get run
> against any particular branch?

kernel robot uses a merge strategy which allows it to monitor thousands of
branches. but also due to this merge, we cannot guarantee a branch merged
into a target kernel in a given time, tested by our dozens of test suite,
and bisected to a particular commit on a perticular branch. sorry that we
currently cannot supply a link for you to search out the information you said.

however, just like above, please kindly let us know if you want some further
tests based on our report.

> 
> > I found the ace7e70901 has already been dropped from original branch (dennis-percpu/for-5.14),
> 
> Yeah I have temporarily dropped it to get the others into for-next for
> now. I'll spend some time later this week digging deeper into this.
> 
> > and we have data for this branch as below. from data, the f183324133 (current
> > branch tip) doesn't introduce regression comparing 5.12-rc7 in our tests.
> > 
> > f183324133ea5 percpu: implement partial chunk depopulation                 103673.09 102188.39 104325.06 104038.4 102908.57 104057.06
> > 1c29a3ceaf5f0 percpu: use pcpu_free_slot instead of pcpu_nr_slots - 1      104777.31 102225.93 101657.6
> > 8ea2e1e35d1eb percpu: factor out pcpu_check_block_hint()                   102290.78 101853.87 102541.65
> > d434405aaab7d Linux 5.12-rc7                                               102103.06 102248.12 101906.81 103033.13 102043.33
> > 
> 
> Thanks,
> Dennis
