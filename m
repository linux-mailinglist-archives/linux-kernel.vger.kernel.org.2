Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C31A331FDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 08:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhCIHbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 02:31:46 -0500
Received: from verein.lst.de ([213.95.11.211]:58639 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhCIHbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 02:31:14 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AEA8B68B05; Tue,  9 Mar 2021 08:31:10 +0100 (CET)
Date:   Tue, 9 Mar 2021 08:31:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        kernel test robot <lkp@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] libnvdimm: Let revalidate_disk() revalidate region
 read-only
Message-ID: <20210309073110.GA3140@lst.de>
References: <161527286194.446794.5215036039655765042.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161527286194.446794.5215036039655765042.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 10:54:22PM -0800, Dan Williams wrote:
> Previous kernels allowed the BLKROSET to override the disk's read-only
> status. With that situation fixed the pmem driver needs to rely on
> revalidate_disk() to clear the disk read-only status after the host
> region has been marked read-write.
> 
> Recall that when libnvdimm determines that the persistent memory has
> lost persistence (for example lack of energy to flush from DRAM to FLASH
> on an NVDIMM-N device) it marks the region read-only, but that state can
> be overridden by the user via:
> 
>    echo 0 > /sys/bus/nd/devices/regionX/read_only
> 
> ...to date there is no notification that the region has restored
> persistence, so the user override is the only recovery.

I've just resent my series to kill of ->revalidate_disk for good, so this
obvious makes me a little unhappy.  Given that ->revalidate_disk
only ends up beeing called from the same path that ->open is called,
why can't you just hook this up from the open method?

Also any reason the sysfs attribute can't just directly propagate the
information to the disk?
