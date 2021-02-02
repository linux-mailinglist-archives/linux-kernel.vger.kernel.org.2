Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C67F30BDC4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhBBMJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:09:42 -0500
Received: from foss.arm.com ([217.140.110.172]:48600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230419AbhBBMIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:08:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED3261396;
        Tue,  2 Feb 2021 04:07:57 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13D6C3F718;
        Tue,  2 Feb 2021 04:07:54 -0800 (PST)
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jianxiong Gao <jxgao@google.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Erdem Aktas <erdemaktas@google.com>,
        Marc Orr <marcorr@google.com>, Christoph Hellwig <hch@lst.de>,
        m.szyprowski@samsung.com, gregkh@linuxfoundation.org,
        Saravana Kannan <saravanak@google.com>,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        jroedel@suse.de, iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
 <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
 <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
 <CAMGD6P0uwVxKuG503ahGTbPcwb+y2wRXSiE_gvzfdUrMfZ5YbA@mail.gmail.com>
 <YBk1pUbQ/JZQ7WZe@smile.fi.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a34328d1-3918-1eca-b632-57be6a40baee@arm.com>
Date:   Tue, 2 Feb 2021 12:07:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YBk1pUbQ/JZQ7WZe@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-02 11:21, Andy Shevchenko wrote:
> On Mon, Feb 01, 2021 at 04:25:55PM -0800, Jianxiong Gao wrote:
> 
>> +       if (dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
> 
> Side note: we have DMA_BIT_MASK(), please use it.

FWIW I'd actually disagree on that point. Conceptually, this is a very 
different thing from dev->{coherent_}dma_mask. It does not need to 
handle everything up to 2^64-1 correctly without overflow issues, and 
data alignments typically *are* defined in terms of sizes rather than 
numbers of bits.

In fact, it might be neat to just have callers pass a size directly to a 
dma_set_min_align() interface which asserts that it is a power of two 
and stores it as a mask internally.

Robin.

> 
>> +               dev_warn(dev->dev, "dma_set_min_align_mask failed to
>> set offset\n");
> 
