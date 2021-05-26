Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA23916C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 13:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhEZL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 07:57:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:43056 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234562AbhEZL4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 07:56:24 -0400
IronPort-SDR: BOvCTY8qFBbJbrX2+fd/iOrUl+bdusUtzdk3tdbmHGw3XSYGBxsvX0NuypMwJmgDjV1ICW5PX/
 SEkGvoPrK90w==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="202200818"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="202200818"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 04:54:01 -0700
IronPort-SDR: YM/p155tk0deTvBFGMg8m8K/l55zEd5Cwudek8iMOlJ0fUePokqn2t/4e3Fg/n9UULk5g7/iZl
 lDyG4sG+yp2w==
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="547165940"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 04:53:59 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lls6n-00EmzC-9r; Wed, 26 May 2021 14:53:57 +0300
Date:   Wed, 26 May 2021 14:53:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/4] devres: Make locking straight forward in
 release_nodes()
Message-ID: <YK421dBVoXLElvKB@smile.fi.intel.com>
References: <20210517122946.53161-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517122946.53161-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 03:29:43PM +0300, Andy Shevchenko wrote:
> It seems for the sake of saving stack memory of couple of pointers,
> the locking in release_nodes() callers becomes interesting.
> 
> Replace this logic with a straight forward locking and unlocking scheme.

Any comments on the series?

-- 
With Best Regards,
Andy Shevchenko


