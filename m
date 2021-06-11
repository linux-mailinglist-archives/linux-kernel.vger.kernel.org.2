Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17283A3FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhFKKOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:14:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:18582 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhFKKOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:14:48 -0400
IronPort-SDR: tisnBD48CxYUzp+U4daDlfdZVGC5RkSx3Eo9KWqzA3LXIZFr0C9zGrifCrgbLQy9kc20OqRNXN
 xs0lM9WEmenw==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="205457842"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="205457842"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 03:12:50 -0700
IronPort-SDR: iCTLD0cGg8bKeb8CjdPnLSKU/CSoTwwbzI1Xx8whS+4kShCjMhxN5bARcy642M9aJsHWUjOdiH
 Xm4vKpEimLBQ==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="486541505"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 03:12:48 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lre9d-001TxF-Uc; Fri, 11 Jun 2021 13:12:45 +0300
Date:   Fri, 11 Jun 2021 13:12:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/4] devres: Make locking straight forward in
 release_nodes()
Message-ID: <YMM3HYt2q5i35OUv@smile.fi.intel.com>
References: <20210517122946.53161-1-andriy.shevchenko@linux.intel.com>
 <YK421dBVoXLElvKB@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK421dBVoXLElvKB@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 02:53:57PM +0300, Andy Shevchenko wrote:
> On Mon, May 17, 2021 at 03:29:43PM +0300, Andy Shevchenko wrote:
> > It seems for the sake of saving stack memory of couple of pointers,
> > the locking in release_nodes() callers becomes interesting.
> > 
> > Replace this logic with a straight forward locking and unlocking scheme.
> 
> Any comments on the series?

Greg, Rafael, anything I should do here?

-- 
With Best Regards,
Andy Shevchenko


