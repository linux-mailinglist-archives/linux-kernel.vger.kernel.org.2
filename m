Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7757441F022
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhJAPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:00:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:48867 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231872AbhJAPAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:00:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205612416"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="205612416"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 07:58:54 -0700
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="480493368"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 07:58:52 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mWJzt-007TFE-L9;
        Fri, 01 Oct 2021 17:58:49 +0300
Date:   Fri, 1 Oct 2021 17:58:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, linux-kernel@vger.kernel.org,
        Fei Li <fei1.li@intel.com>
Subject: Re: [PATCH v1 1/1] virt: acrn: Drop internal kernel type from ABI
Message-ID: <YVciKWdHJMaEwQu6@smile.fi.intel.com>
References: <20211001135644.1884-1-andriy.shevchenko@linux.intel.com>
 <YVcUxXJeduv1OHrz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVcUxXJeduv1OHrz@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 04:01:41PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 01, 2021 at 04:56:44PM +0300, Andy Shevchenko wrote:
> > guid_t is internal type of the kernel which is mistakenly had been exposed
> > to the user space. Replace it with raw buffers.
> 
> Wait, why is it a mistake to expose it to userspace?  What does this
> conflict with?  Is it a namespace issue?  Or something else?

It is the type which is defined solely for kernel use and what user space
should do is to use types defined by respective libraries, such as libuuid.

If you read the commit message to the end, you will notice that I have
mentioned the possible scenario what happened here. They seems misusing
guid_t as uuid_t, but the latter is not available for the users from
the kernel headers (and this is good). So this is an exact example why
guid_t shouldn't be exposed.

-- 
With Best Regards,
Andy Shevchenko


