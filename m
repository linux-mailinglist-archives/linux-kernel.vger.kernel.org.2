Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2041414D06
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbhIVPcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:32:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:29127 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236419AbhIVPck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:32:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="223653570"
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; 
   d="scan'208";a="223653570"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 08:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; 
   d="scan'208";a="474728205"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga007.fm.intel.com with ESMTP; 22 Sep 2021 08:30:45 -0700
Date:   Wed, 22 Sep 2021 23:30:45 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, rui.xiang@huawei.com
Subject: Re: [PATCH] mm: Fix the uninitialized use in
 overcommit_policy_handler
Message-ID: <20210922153045.GA68763@shbuild999.sh.intel.com>
References: <20210921140301.9058-1-chenjun102@huawei.com>
 <YUn95tAEvHEsT6R+@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUn95tAEvHEsT6R+@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 05:44:38PM +0200, Michal Hocko wrote:
> On Tue 21-09-21 14:03:01, Chen Jun wrote:
> > An unexpected value of /proc/sys/vm/panic_on_oom we will get,
> > after running the following program
> > 
> > int main()
> > {
> >     int fd = open("/proc/sys/vm/panic_on_oom", O_RDWR)
> >     write(fd, "1", 1);
> >     write(fd, "2", 1);
> >     close(fd);
> > }
> > 
> > write(fd, "2", 1) will pass *ppos = 1 to proc_dointvec_minmax.
> > proc_dointvec_minmax will return 0 without setting new_policy.
> > 
> > t.data = &new_policy;
> > ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos)
> >       -->do_proc_dointvec
> >          -->__do_proc_dointvec
> >               if (write) {
> >                 if (proc_first_pos_non_zero_ignore(ppos, table))
> >                   goto out;
> >
> > sysctl_overcommit_memory = new_policy;
> > 
> > so sysctl_overcommit_memory will be set to an uninitialized value.
> 
> The overcommit_policy_handler (ab)use of proc_dointvec_minmax is really
> an odd one. It is not really great that proc_dointvec_minmax cannot
> really tell whether the value has been changed but likely nobody really
> needed that so far.
> 
> I strongly suspect the intention was to do all the follow up handling
> before making the new mode visible to others.

IIRC, You are right, there was some error caught by ltp tool, that when
the overcommit policy get frequently changed while there is stress memory
test, so if the policy is changed to OVERCOMMIT_NEVER, it must happen
after the batch number is changed.

Thanks,
Feng

> Maybe this can be changed
> so that the handler doesn't really need to do any hops.
> 
> Your fix is an easier part I would just initialize the to -1 so that we
> can tell nothing has been done the handler can bail out without any
> follow up work.
> -- 
> Michal Hocko
> SUSE Labs
