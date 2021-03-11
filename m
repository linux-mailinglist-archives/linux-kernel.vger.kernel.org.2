Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3353378AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhCKQCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:02:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:62714 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234358AbhCKQC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:02:26 -0500
IronPort-SDR: V64VhHctN+wbuLRY+Wim9JTowjnXkfS13CQggwGD4HT2qch7b92CD5z4pFsi52mVgnlbeeJoH/
 mUkj4wR91Kuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="250051782"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="250051782"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 08:02:21 -0800
IronPort-SDR: TgXkgDIxrkFNbVebBWByqbErUiiENfNPJN9K+7uPCMtMqH7ay2EozaXX48hLrafcqze5WzjRhp
 Z6RrXrgIyS5A==
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="603582690"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 08:02:20 -0800
Date:   Thu, 11 Mar 2021 08:02:20 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        David Sterba <dsterba@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>
Subject: Re: [mm/highmem] 61b205f579:
 WARNING:at_mm/highmem.c:#__kmap_local_sched_out
Message-ID: <20210311160220.GS3014244@iweiny-DESK2.sc.intel.com>
References: <20210304083825.GB17830@xsang-OptiPlex-9020>
 <BYAPR04MB496507720FEEF2B77FB639E186929@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496507720FEEF2B77FB639E186929@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 08:53:04PM +0000, Chaitanya Kulkarni wrote:
> Ira,
> 
> On 3/4/21 00:23, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: 61b205f579911a11f0b576f73275eca2aed0d108 ("mm/highmem: Convert memcpy_[to|from]_page() to kmap_local_page()")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> >
> > in testcase: trinity
> > version: trinity-static-i386-x86_64-f93256fb_2019-08-28
> > with following parameters:
> >
> > 	runtime: 300s
> >
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> >
> >
> > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> Is the fix for this been posted yet ?

No.  I've been unable to reproduce it yet.

Ira

> 
> (asking since I didn't see the fix and my mailer is dropping emails from
>  lkml).
