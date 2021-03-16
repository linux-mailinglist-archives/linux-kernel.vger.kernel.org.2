Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED1C33CEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhCPHiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:38:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:39668 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhCPHh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:37:58 -0400
IronPort-SDR: 4bpxVN4ISVbIFV7w3lomCjILQMbxs/bkWuhPans8s0NB72wn44SY1VxmP4mKA42kFFl0Go3oeY
 nriTAiy39DeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="176346059"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="176346059"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 00:37:57 -0700
IronPort-SDR: HNeCwIo1Mkt+dS+vxOUUNaGghv/D5WFdBLfyrGGC8PMve3+nGv2z9i4l8qKhXdc+aHorlC5S3o
 fnTuee6kD7/w==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="412119186"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 00:37:57 -0700
Date:   Tue, 16 Mar 2021 00:37:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Oliver Sang <oliver.sang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [mm/highmem] 61b205f579:
 WARNING:at_mm/highmem.c:#__kmap_local_sched_out
Message-ID: <20210316073756.GQ3014244@iweiny-DESK2.sc.intel.com>
References: <20210304083825.GB17830@xsang-OptiPlex-9020>
 <BYAPR04MB496507720FEEF2B77FB639E186929@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210311160220.GS3014244@iweiny-DESK2.sc.intel.com>
 <20210312062755.GA5022@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312062755.GA5022@xsang-OptiPlex-9020>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Thomas.  Thomas I've been looking into the following test failure:

https://lore.kernel.org/lkml/20210304083825.GB17830@xsang-OptiPlex-9020/

See below.

On Fri, Mar 12, 2021 at 02:27:55PM +0800, Oliver Sang wrote:
> Hi Ira,
 
[snip]

> > > >
> > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > 
> > > Is the fix for this been posted yet ?
> > 
> > No.  I've been unable to reproduce it yet.
> 
> just FYI
> the issue does not always happen but the rate on 61b205f579 is not low,
> while we didn't observe it happen on parent commit.
> 
> bb90d4bc7b6a536b 61b205f579911a11f0b576f7327
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :38          16%           6:38    dmesg.EIP:__kmap_local_sched_in
>            :38          16%           6:38    dmesg.EIP:__kmap_local_sched_out
>            :38          16%           6:38    dmesg.WARNING:at_mm/highmem.c:#__kmap_local_sched_in
>            :38          16%           6:38    dmesg.WARNING:at_mm/highmem.c:#__kmap_local_sched_out
> 
> also please permit me to quote our internal analysis by Zhengjun (cced)
> (Thanks a lot, Zhengjun)
> 
> "the commit has the potential to cause the issue.
> It replaces " kmap_atomic" to " kmap_local_page".
> 
> Most of the two API is the same, except for " kmap_atomic" disable preemption and cannot sleep.
> I check the issue happened when there is a preemption,  in FBC " kmap_local_page",
> the  preemption is enabled,  the issue may happen."
> "


I think I see the issue.  I think this is an invalid configuration.

00:26:43 > grep DEBUG_KMAP config-5.11.0-rc7-00002-g61b205f57991 
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y

00:26:48 > grep DEBUG_HIGHMEM config-5.11.0-rc7-00002-g61b205f57991 
# CONFIG_DEBUG_HIGHMEM is not set


DEBUG_KMAP_LOCAL causes guard pages to be added to the kmap_ctrl array.  But
DEBUG_HIGHMEM is used in __kmap_local_sched_out() to check the guard pages.

DEBUG_HIGHMEM is supposed to select DEBUG_KMAP_LOCAL...  but apparently that
did not happen when this configuration was made.

I still have not hit this condition in my testing.  Could you ensure that
DEBUG_HIGMEM is set and rerun the test to see if I am correct?

Thomas wouldn't the following enable checks make more sense?  Or perhaps be
more consistent with the processing of kmap_ctrl?

Ira

diff --git a/mm/highmem.c b/mm/highmem.c
index 86f2b9495f9c..6ef8f5e05e7e 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -618,7 +618,7 @@ void __kmap_local_sched_out(void)
                int idx;
 
                /* With debug all even slots are unmapped and act as guard */
-               if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
+               if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL) && !(i & 0x01)) {
                        WARN_ON_ONCE(!pte_none(pteval));
                        continue;
                }
@@ -654,7 +654,7 @@ void __kmap_local_sched_in(void)
                int idx;
 
                /* With debug all even slots are unmapped and act as guard */
-               if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
+               if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL) && !(i & 0x01)) {
                        WARN_ON_ONCE(!pte_none(pteval));
                        continue;
                }



