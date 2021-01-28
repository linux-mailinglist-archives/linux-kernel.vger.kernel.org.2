Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADCC3070B0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhA1IGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:06:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232308AbhA1IFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:05:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16D4B64DDA;
        Thu, 28 Jan 2021 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611821094;
        bh=GuLi/8pmF+rCgjPXwttqZpfpUDWjxcO0+aBtX7a6cpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJNlFazuzogyHS95uUijQnggfofbJSHp4E1kJjQrb9wi7AOPHtoRGgcFljLsNPOsI
         dAiKEea5u8NcfJs6yeXLXdg4+We5/Nt6h5G8s9pjXEpsTUNn2Mz9zTaovvLzmjt7EE
         JfRf+akhzadrBzz//k88tU5HlhLlEJyPUsxYYbZI=
Date:   Thu, 28 Jan 2021 09:04:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jianxiong Gao <jxgao@google.com>
Cc:     erdemaktas@google.com, marcorr@google.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        saravanak@google.com, heikki.krogerus@linux.intel.com,
        rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        jroedel@suse.de, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, kbusch@kernel.org, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Adding offset keeping option when mapping data via
 SWIOTLB.*
Message-ID: <YBJwImu3RoQsGhJq@kroah.com>
References: <20210128003829.1892018-1-jxgao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128003829.1892018-1-jxgao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 04:38:26PM -0800, Jianxiong Gao wrote:
> NVMe driver and other applications may depend on the data offset
> to operate correctly. Currently when unaligned data is mapped via
> SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. This
> patch adds an option to make sure the mapped data preserves its
> offset of the orginal addrss.
> 
> Without the patch when creating xfs formatted disk on NVMe backends,
> with swiotlb=force in kernel boot option, creates the following error:
> meta-data=/dev/nvme2n1           isize=512    agcount=4, agsize=131072 blks
>          =                       sectsz=512   attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=0, rmapbt=0, refl
> ink=0
> data     =                       bsize=4096   blocks=524288, imaxpct=25
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
> log      =internal log           bsize=4096   blocks=2560, version=2
>          =                       sectsz=512   sunit=0 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
> mkfs.xfs: pwrite failed: Input/output error
> 
> Jianxiong Gao (3):
>   Adding page_offset_mask to device_dma_parameters
>   Add swiotlb offset preserving mapping when
>     dma_dma_parameters->page_offset_mask is non zero.
>   Adding device_dma_parameters->offset_preserve_mask to NVMe driver.


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
