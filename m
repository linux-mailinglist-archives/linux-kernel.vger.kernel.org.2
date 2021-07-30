Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097463DB7EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbhG3Leq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 07:34:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:63437 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhG3Lep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 07:34:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="200288228"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="200288228"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 04:34:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="500478875"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 04:34:38 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m9Qmd-003N12-Nh; Fri, 30 Jul 2021 14:34:31 +0300
Date:   Fri, 30 Jul 2021 14:34:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH 1/2] device property: Check fwnode->secondary in
 fwnode_graph_get_next_endpoint()
Message-ID: <YQPjxzpfGn0csS+S@smile.fi.intel.com>
References: <20210722201929.3585671-1-djrscally@gmail.com>
 <20210722201929.3585671-2-djrscally@gmail.com>
 <YPq28BNOmqZPdRqq@smile.fi.intel.com>
 <acf4838d-3c70-20c1-5fce-ee36765b06c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acf4838d-3c70-20c1-5fce-ee36765b06c4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 02:04:59PM +0100, Daniel Scally wrote:
> 
> On 23/07/2021 13:32, Andy Shevchenko wrote:
> > On Thu, Jul 22, 2021 at 09:19:28PM +0100, Daniel Scally wrote:
> >> Sensor drivers often check for an endpoint to make sure that they're
> >> connected to a consuming device like a CIO2 during .probe(). Some of
> >> those endpoints might be in the form of software_nodes assigned as
> >> a secondary to the device's fwnode_handle. Account for this possibility
> >> in fwnode_graph_get_next_endpoint() to avoid having to do it in the
> >> sensor drivers themselves.
> > ...
> >
> >> +	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
> >> +
> >> +	if (IS_ERR_OR_NULL(ep) && !IS_ERR_OR_NULL(parent) &&
> >> +	    !IS_ERR_OR_NULL(parent->secondary))
> > Nit-pick, I would put it like:
> >
> > 	if (!IS_ERR_OR_NULL(parent->secondary) && !IS_ERR_OR_NULL(parent) &&
> > 	    IS_ERR_OR_NULL(ep))
> >
> > or
> >
> > 	if (IS_ERR_OR_NULL(ep) &&
> > 	    !IS_ERR_OR_NULL(parent->secondary) && !IS_ERR_OR_NULL(parent))
> >
> > for the sake of logical split.
> 
> 
> OK; I'll do the second one, feel like it's better to have ep as the
> first check.

Fine, but also I have just noticed that parent should be checked before
parent->secondary.

Something like this

	if (IS_ERR_OR_NULL(ep) &&
	    !IS_ERR_OR_NULL(parent) && IS_ERR_OR_NULL(parent->secondary))

> >> +		ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);

-- 
With Best Regards,
Andy Shevchenko


