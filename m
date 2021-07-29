Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672303DA74E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhG2PRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:17:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:31731 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237389AbhG2PRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:17:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="200083113"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="200083113"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 08:17:40 -0700
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="518251900"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 08:17:39 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m97mv-00304N-9W; Thu, 29 Jul 2021 18:17:33 +0300
Date:   Thu, 29 Jul 2021 18:17:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/1] pps: clients: parport: Switch to use
 module_parport_driver()
Message-ID: <YQLGjZ7/TLB6Mud5@smile.fi.intel.com>
References: <20210607153729.58623-1-andriy.shevchenko@linux.intel.com>
 <YOxJy5SbObWeZbf5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOxJy5SbObWeZbf5@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 04:55:23PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 07, 2021 at 06:37:29PM +0300, Andy Shevchenko wrote:
> > Switch to use module_parport_driver() to reduce boilerplate code.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> > ---
> > v2: added tag (Rodolfo)
> 
> Seems missed patch.

Greg, can you pick this up, or should I resend?

-- 
With Best Regards,
Andy Shevchenko


