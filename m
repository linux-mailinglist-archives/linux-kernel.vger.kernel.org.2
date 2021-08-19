Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F113F1947
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbhHSMbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:31:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:41338 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236605AbhHSMbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:31:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="203688705"
X-IronPort-AV: E=Sophos;i="5.84,334,1620716400"; 
   d="scan'208";a="203688705"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:30:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,334,1620716400"; 
   d="scan'208";a="594413782"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 05:30:14 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mGhBQ-00BSma-LZ; Thu, 19 Aug 2021 15:30:08 +0300
Date:   Thu, 19 Aug 2021 15:30:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc/pvpanic: fix set driver data
Message-ID: <YR5O0IETmMOgftVv@smile.fi.intel.com>
References: <1629301110-2714-1-git-send-email-mihai.carabas@oracle.com>
 <1629301110-2714-2-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629301110-2714-2-git-send-email-mihai.carabas@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 06:38:30PM +0300, Mihai Carabas wrote:

Thank you for the report and fix! My comments below.

> Add again dev_set_drvdata in order for dev_get_drvdata to not return NULL.

dev_set_drvdata()
dev_get_drvdata()

> Fixes: 394febc9d0a6 ("misc/pvpanic: Make 'pvpanic_probe()' resource managed")

> 

Shouldn't be blank line(s) in the tag block.

> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>

...

> +	dev_set_drvdata(dev, pi);
> +
>  	return devm_pvpanic_probe(dev, pi);

I think it makes sense to have the above line as a part of pvpanic_probe().

-- 
With Best Regards,
Andy Shevchenko


