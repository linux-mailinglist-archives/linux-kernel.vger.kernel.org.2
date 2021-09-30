Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457E641D535
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349071AbhI3IJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:09:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:39175 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349131AbhI3IIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:08:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="286149407"
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="286149407"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 01:05:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="476915768"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.115])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 01:04:59 -0700
Date:   Thu, 30 Sep 2021 16:05:23 +0800
From:   Philip Li <philip.li@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        0day robot <lkp@intel.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [driver core]  eedc73d4f3:
 BUG:kernel_reboot-without-warning_in_boot_stage
Message-ID: <YVVtnrEn4wg7QVGs@rli9-dbox>
References: <1614590004-69592-1-git-send-email-yang.lee@linux.alibaba.com>
 <20210929150240.GB12854@xsang-OptiPlex-9020>
 <YVSCs7BDC6ODf+oZ@kroah.com>
 <20210930055944.GA29843@xsang-OptiPlex-9020>
 <YVVX3ir2DHg0FUxF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVVX3ir2DHg0FUxF@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 08:23:26AM +0200, Greg KH wrote:
> On Thu, Sep 30, 2021 at 01:59:44PM +0800, Oliver Sang wrote:
> > Hi, Greg KH,
> > 
> > On Wed, Sep 29, 2021 at 05:13:55PM +0200, Greg KH wrote:
> > > On Wed, Sep 29, 2021 at 11:02:40PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Greeting,
> > > > 
> > > > FYI, we noticed the following commit (built with gcc-9):
> > > > 
> > > > commit: eedc73d4f330cf7a8d18d64f327837ae9a00d003 ("[PATCH] driver core: Switch to using the new API kobj_to_dev()")
> > > > url: https://github.com/0day-ci/linux/commits/Yang-Li/driver-core-Switch-to-using-the-new-API-kobj_to_dev/20210929-102216
> > > > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 5816b3e6577eaa676ceb00a848f0fd65fe2adc29
> > > 
> > > There is no such commit in my tree, or anywhere else I can see, so I
> > > have no idea what is happening here :(
> > > 
> > 
> > this report was sent to Yang Li, who is the patch author.
> > https://lore.kernel.org/lkml/1614590004-69592-1-git-send-email-yang.lee@linux.alibaba.com/
> > 
> > since Yang sent the patch to you, so our Rot automatically add you in
> > the Cc list.
> 
> That patch was sent back on March 1.  And was instantly rejected for the
> obvious reason it was never tested :)
> 
> Why is 0-day running on such old changes now?
sorry about this Greg, that we have a storage crash in last 5 days, and
the data seems not consistent after we recovered that old patches are
re-scanned to be tested. We will manually check the existing data to
avoid test old ones.

> 
> And it is not obvious that this is being run on an email submission at
> all, where would I have found that information in this response?  I see
> a git id that points to a kernel tree.  No email link at all.
We will improve this in our report to point out the original patch mail
link whenever possible. Currently we show the git to provide the branch
that we apply such mail patch for author to reproduce. But definitely,
it is clearer to show explicitly that this is test against the mail patch.

> 
> thanks,
> 
> greg k-h
