Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB63EA35D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbhHLLQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:16:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:28663 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232081AbhHLLQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:16:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="202492232"
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="202492232"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 04:16:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="469725505"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 04:16:01 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mE8gk-008Z2D-MY; Thu, 12 Aug 2021 14:15:54 +0300
Date:   Thu, 12 Aug 2021 14:15:54 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v1 3/3] kernel/resource: cleanup and optimize
 iomem_is_exclusive()
Message-ID: <YRUC6p+9jKmXu/NT@smile.fi.intel.com>
References: <20210811203612.138506-1-david@redhat.com>
 <20210811203612.138506-4-david@redhat.com>
 <CAHp75VdQ_FkvBH4rw63mzm-4MymCWD2Ke_7Rf8T3Zmef3FeQVQ@mail.gmail.com>
 <37179df3-13d7-9b98-4cd8-13bb7f735129@redhat.com>
 <CAHp75VcU2_qE1xt397L5dpxVMejZdHwWq0D_-Bo57_eWMtmgig@mail.gmail.com>
 <a2af90f4-5bce-df8d-2466-8dabe85dd4b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2af90f4-5bce-df8d-2466-8dabe85dd4b7@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 09:34:00AM +0200, David Hildenbrand wrote:
> On 12.08.21 09:14, Andy Shevchenko wrote:
> > On Thursday, August 12, 2021, David Hildenbrand <david@redhat.com
> > <mailto:david@redhat.com>> wrote:
> >     On 11.08.21 22:47, Andy Shevchenko wrote:
> >         On Wednesday, August 11, 2021, David Hildenbrand
> >         <david@redhat.com <mailto:david@redhat.com>
> >         <mailto:david@redhat.com <mailto:david@redhat.com>>> wrote:

> > Yes, it’s like micro optimization. If you want your way I suggest then
> > to add a macro
> > 
> > #define for_each_iomem_resource_child() \
> >   for (iomem_resource...)
> 
> I think the only thing that really makes sense would be something like this on top (not compiled yet):

Makes sense to me, thanks, go for it!

-- 
With Best Regards,
Andy Shevchenko


