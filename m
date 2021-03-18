Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987C33410A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 00:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhCRXJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 19:09:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:14147 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232539AbhCRXIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 19:08:40 -0400
IronPort-SDR: JGHBRoTEFUx8mkhEbPIUKxsSBQtB5SDdpgA54FT1JfG6x/6+JhLsq0YFlE/Vh9RozY1ZJUQQ9e
 az/4sNEkMlDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="189826070"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="189826070"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 16:08:40 -0700
IronPort-SDR: qLoEcnaesFvw5IGzJERhBclTOxZS9bIOB+4zBC4xbfhYL+Gt2iT6TaQs0aobO13c0V0w1otsNU
 VgR23RfyA60A==
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="406547310"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 16:08:39 -0700
Date:   Thu, 18 Mar 2021 16:08:39 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
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
Message-ID: <20210318230839.GY3014244@iweiny-DESK2.sc.intel.com>
References: <20210304083825.GB17830@xsang-OptiPlex-9020>
 <BYAPR04MB496507720FEEF2B77FB639E186929@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210311160220.GS3014244@iweiny-DESK2.sc.intel.com>
 <20210312062755.GA5022@xsang-OptiPlex-9020>
 <20210316073756.GQ3014244@iweiny-DESK2.sc.intel.com>
 <87blbhzygm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blbhzygm.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 02:44:41PM +0100, Thomas Gleixner wrote:
> On Tue, Mar 16 2021 at 00:37, Ira Weiny wrote:
> >
> > I think I see the issue.  I think this is an invalid configuration.
> >
> > 00:26:43 > grep DEBUG_KMAP config-5.11.0-rc7-00002-g61b205f57991 
> > CONFIG_DEBUG_KMAP_LOCAL=y
> > CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
> >
> > 00:26:48 > grep DEBUG_HIGHMEM config-5.11.0-rc7-00002-g61b205f57991 
> > # CONFIG_DEBUG_HIGHMEM is not set
> 
> No. It's valid so you can test that crap on 64bit.
> 
> > DEBUG_KMAP_LOCAL causes guard pages to be added to the kmap_ctrl array.  But
> > DEBUG_HIGHMEM is used in __kmap_local_sched_out() to check the guard pages.
> >
> > DEBUG_HIGHMEM is supposed to select DEBUG_KMAP_LOCAL...  but apparently that
> > did not happen when this configuration was made.
> >
> > I still have not hit this condition in my testing.  Could you ensure that
> > DEBUG_HIGMEM is set and rerun the test to see if I am correct?
> 
> Why? The whole point of CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is to allow
> testing of this kmap_local/atomic stuff w/o HIGHMEM, e.g. on 64 bit.

Ok yea I was looking at this backwards.

> 
> > Thomas wouldn't the following enable checks make more sense?  Or perhaps be
> > more consistent with the processing of kmap_ctrl?
> 
> Neither nor. It's simply required to make DEBUG_KMAP_LOCAL=y &&
> HIGHMEM=n case work.
> 
> Please add:
> Fixes: 0e91a0c6984c ("mm/highmem: Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP")
> 

Patch sent.

Thanks for setting me straight,
Ira
