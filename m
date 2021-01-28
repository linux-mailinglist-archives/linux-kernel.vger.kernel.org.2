Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14E307DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhA1STl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:19:41 -0500
Received: from verein.lst.de ([213.95.11.211]:58507 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231506AbhA1SQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:16:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B320468B02; Thu, 28 Jan 2021 19:15:58 +0100 (CET)
Date:   Thu, 28 Jan 2021 19:15:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jianxiong Gao <jxgao@google.com>, erdemaktas@google.com,
        marcorr@google.com, hch@lst.de, m.szyprowski@samsung.com,
        gregkh@linuxfoundation.org, saravanak@google.com,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        andriy.shevchenko@linux.intel.com, dan.j.williams@intel.com,
        bgolaszewski@baylibre.com, jroedel@suse.de,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com,
        kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Adding page_offset_mask to device_dma_parameters
Message-ID: <20210128181557.GA11790@lst.de>
References: <20210128003829.1892018-1-jxgao@google.com> <20210128003829.1892018-2-jxgao@google.com> <2863b6d2-47f6-51fa-f60c-ba24904818e9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2863b6d2-47f6-51fa-f60c-ba24904818e9@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 05:27:25PM +0000, Robin Murphy wrote:
> On 2021-01-28 00:38, Jianxiong Gao wrote:
>> Some devices rely on the address offset in a page to function
>> correctly (NVMe driver as an example). These devices may use
>> a different page size than the Linux kernel. The address offset
>> has to be preserved upon mapping, and in order to do so, we
>> need to record the page_offset_mask first.
>>
>> Signed-off-by: Jianxiong Gao <jxgao@google.com>
>> ---
>>   include/linux/device.h      |  1 +
>>   include/linux/dma-mapping.h | 17 +++++++++++++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 1779f90eeb4c..f44e0659fc66 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -292,6 +292,7 @@ struct device_dma_parameters {
>>   	 */
>>   	unsigned int max_segment_size;
>>   	unsigned long segment_boundary_mask;
>> +	unsigned int page_offset_mask;
>
> Could we call this something more like "min_align_mask" (sorry, I can't 
> think of a name that's actually good and descriptive right now). 
> Essentially I worry that having "page" in there is going to be too easy to 
> misinterpret as having anything to do what "page" means almost everywhere 
> else (even before you throw IOMMU pages into the mix).
>
> Also note that of all the possible ways to pack two ints and a long, this 
> one is the worst ;)

The block layer uses virt_boundary for the related concept, but that
is pretty horrible too.
