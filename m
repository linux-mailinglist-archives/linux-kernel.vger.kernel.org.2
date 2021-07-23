Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0FE3D3A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhGWLxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:53:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:63627 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234856AbhGWLwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:52:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="199073397"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="199073397"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 05:32:56 -0700
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="663258265"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 05:32:54 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m6uMC-00HMOM-HP; Fri, 23 Jul 2021 15:32:48 +0300
Date:   Fri, 23 Jul 2021 15:32:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH 1/2] device property: Check fwnode->secondary in
 fwnode_graph_get_next_endpoint()
Message-ID: <YPq28BNOmqZPdRqq@smile.fi.intel.com>
References: <20210722201929.3585671-1-djrscally@gmail.com>
 <20210722201929.3585671-2-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722201929.3585671-2-djrscally@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 09:19:28PM +0100, Daniel Scally wrote:
> Sensor drivers often check for an endpoint to make sure that they're
> connected to a consuming device like a CIO2 during .probe(). Some of
> those endpoints might be in the form of software_nodes assigned as
> a secondary to the device's fwnode_handle. Account for this possibility
> in fwnode_graph_get_next_endpoint() to avoid having to do it in the
> sensor drivers themselves.

...

> +	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
> +
> +	if (IS_ERR_OR_NULL(ep) && !IS_ERR_OR_NULL(parent) &&
> +	    !IS_ERR_OR_NULL(parent->secondary))

Nit-pick, I would put it like:

	if (!IS_ERR_OR_NULL(parent->secondary) && !IS_ERR_OR_NULL(parent) &&
	    IS_ERR_OR_NULL(ep))

or

	if (IS_ERR_OR_NULL(ep) &&
	    !IS_ERR_OR_NULL(parent->secondary) && !IS_ERR_OR_NULL(parent))

for the sake of logical split.

> +		ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);

-- 
With Best Regards,
Andy Shevchenko


