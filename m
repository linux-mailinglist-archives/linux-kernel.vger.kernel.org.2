Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F16030BD14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBBLXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:23:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:27980 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhBBLXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:23:05 -0500
IronPort-SDR: PJ+w4yrZzc3YsP0pCJ46WR9EDAVTDJ9z4tEouhsOwLSdS53N/tmmeaS6DgjNAibAvEkLfNsCct
 azSFZPTVTyfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="177328508"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="177328508"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 03:21:18 -0800
IronPort-SDR: arxa1CnexkB+IedD8L6vPTrDVN5f4z/C8a5pzT/twDzjV3GGUUsXy2Tf3v1Tqzazeo+z2FX1Hd
 8pL4xV87qATw==
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="359007943"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 03:21:13 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6tk5-001NHP-Ui; Tue, 02 Feb 2021 13:21:09 +0200
Date:   Tue, 2 Feb 2021 13:21:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jianxiong Gao <jxgao@google.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Erdem Aktas <erdemaktas@google.com>,
        Marc Orr <marcorr@google.com>, Christoph Hellwig <hch@lst.de>,
        m.szyprowski@samsung.com, Robin Murphy <robin.murphy@arm.com>,
        gregkh@linuxfoundation.org, Saravana Kannan <saravanak@google.com>,
        heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        jroedel@suse.de, iommu@lists.linux-foundation.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] Adding
 device_dma_parameters->offset_preserve_mask to NVMe driver.
Message-ID: <YBk1pUbQ/JZQ7WZe@smile.fi.intel.com>
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
 <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
 <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
 <CAMGD6P0uwVxKuG503ahGTbPcwb+y2wRXSiE_gvzfdUrMfZ5YbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGD6P0uwVxKuG503ahGTbPcwb+y2wRXSiE_gvzfdUrMfZ5YbA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 04:25:55PM -0800, Jianxiong Gao wrote:

> +       if (dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))

Side note: we have DMA_BIT_MASK(), please use it.

> +               dev_warn(dev->dev, "dma_set_min_align_mask failed to
> set offset\n");

-- 
With Best Regards,
Andy Shevchenko


