Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AEE399F93
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFCLLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:11:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:19667 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhFCLLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:11:46 -0400
IronPort-SDR: p/duha5OTsNP2IHPFc1AMxiukk1DBRNN/5ujbsLG/lOGw4wqn/ffHj+7EEDF4fqVXHd8cpXB3R
 haibs1pb30jQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="267883616"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="267883616"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 04:10:01 -0700
IronPort-SDR: 40NLyzidrZVMzwXe2ce8BRDdTxNEnxAEH35sFi3l+yfgrveLgZpizD2GHJxMBSPUI9LyK6ybFv
 r8lrwFardnqQ==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="483433819"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 04:09:59 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lolEa-00GvRp-QS; Thu, 03 Jun 2021 14:09:56 +0300
Date:   Thu, 3 Jun 2021 14:09:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
        song.bao.hua@hisilicon.com
Subject: Re: [PATCH v3 3/3] drivers/base/node.c: use bin_attribute to avoid
 buff overflow
Message-ID: <YLi4hL1LA1vVe4o4@smile.fi.intel.com>
References: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
 <1622712162-7028-4-git-send-email-tiantao6@hisilicon.com>
 <YLimj+KPaQ2P/cnl@smile.fi.intel.com>
 <be871547-5fbc-e273-a8ae-97defe75b85c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be871547-5fbc-e273-a8ae-97defe75b85c@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 06:31:57PM +0800, tiantao (H) wrote:
> 在 2021/6/3 17:53, Andy Shevchenko 写道:
> > On Thu, Jun 03, 2021 at 05:22:42PM +0800, Tian Tao wrote:
> > > Reading sys/devices/system/cpu/cpuX/nodeX/ returns cpumap and cpulist.
> > > However, the size of this file is limited to PAGE_SIZE because of the
> > > limitation for sysfs attribute. so we use bin_attribute instead of
> > > attribute to avoid NR_CPUS too big to cause buff overflow.
> > ...
> > 
> > >   }
> > > -static DEVICE_ATTR_RO(cpumap);
> > > -static inline ssize_t cpulist_show(struct device *dev,
> > > -				   struct device_attribute *attr,
> > > -				   char *buf)
> > > +static BIN_ATTR_RO(cpumap, 0);
> > So, you will have 2 blank lines in a row after this. Why one is not enough?
> > Same question for other similar cases, if any.
> 
>  I can delete the line 55. this is the only problem, are there any other
> problems?

I don't know. I'm not familiar with the area.

-- 
With Best Regards,
Andy Shevchenko


