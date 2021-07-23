Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7121B3D3A50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhGWLx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:53:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:60302 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234977AbhGWLxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:53:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="209978281"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="209978281"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 05:33:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="471498282"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 05:33:40 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m6uMw-00HMP6-Cz; Fri, 23 Jul 2021 15:33:34 +0300
Date:   Fri, 23 Jul 2021 15:33:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH 0/2] Check for endpoints in fwnode->secondary more
 sensibly
Message-ID: <YPq3HvKWvChRp45A@smile.fi.intel.com>
References: <20210722201929.3585671-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722201929.3585671-1-djrscally@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 09:19:27PM +0100, Daniel Scally wrote:
> Hello all
> 
> A while ago I patched fwnode_graph_get_endpoint_by_id() to check for endpoints
> against fwnode->secondary if none was found against the primary. It's actually
> better to do this in fwnode_graph_get_next_endpoint() instead, since that
> function is called by fwnode_graph_get_endpoint_by_id() and also directly called
> in a bunch of other places (primarily sensor drivers checking that they have
> endpoints connected during probe). This small series just adds the equivalent
> functionality to fwnode_graph_get_next_endpoint() and reverts the earlier
> commit.

Makes sense to me (one nit-pick to patch 1, though).
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Daniel Scally (2):
>   device property: Check fwnode->secondary in
>     fwnode_graph_get_next_endpoint()
>   Revert "media: device property: Call fwnode_graph_get_endpoint_by_id()
>     for fwnode->secondary"
> 
>  drivers/base/property.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


