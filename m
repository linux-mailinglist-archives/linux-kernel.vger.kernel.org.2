Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806B0434E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 16:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhJTOvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 10:51:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:40263 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhJTOvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:51:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="252284960"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="252284960"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 07:48:25 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="483759073"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 07:48:23 -0700
Date:   Wed, 20 Oct 2021 23:08:16 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [block]  52b85909f8: ndctl.test-libndctl.fail
Message-ID: <20211020150816.GB22721@xsang-OptiPlex-9020>
References: <20210831145036.GA14661@xsang-OptiPlex-9020>
 <20210901113424.GA6637@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901113424.GA6637@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph Hellwig,

On Wed, Sep 01, 2021 at 01:34:24PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 31, 2021 at 10:50:36PM +0800, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 52b85909f85d06efa69aaf4210e72467f1f58d2b ("block: fold register_disk into device_add_disk")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Can someone help to decode the output?  I'm a little lost in debug output
> from libkmod but can't really find anything substancial that looks wrong.

sorry for late, we retested on this commit and its parent,
also we noticed a fix commit:
commit d55174cccac2e4c2a58ff68b6b573fc0836f73bd (nvdimm/libnvdimm-fixes)
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Sep 22 19:34:29 2021 +0200

    nvdimm/pmem: fix creating the dax group

    The recent block layer refactoring broke the way how the pmem driver
    abused device_add_disk.  Fix this by properly passing the attribute groups
    to device_add_disk.

    Fixes: 52b85909f85d ("block: fold register_disk into device_add_disk")


rerun on all these 3 commits, we now confirmed the ndctl.test-libndctl.fail
can be reproduced on all of them.

sorry for inconvenience.


