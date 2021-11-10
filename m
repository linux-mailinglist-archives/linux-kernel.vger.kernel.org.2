Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E704744C283
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhKJNwp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Nov 2021 08:52:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:61784 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231460AbhKJNwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:52:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="293499494"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="293499494"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 05:49:54 -0800
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="492101967"
Received: from skofoed-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.124])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 05:49:48 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20211109075957.GC27339@lst.de>
References: <20211102070601.155501-1-hch@lst.de> <163603075885.4807.880888219859400958@jlahtine-mobl.ger.corp.intel.com> <20211109075957.GC27339@lst.de>
Subject: Re: refactor the i915 GVT support and move to the modern mdev API v2
Cc:     Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Christoph Hellwig <hch@lst.de>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <163655218578.6332.7934375733343731100@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Wed, 10 Nov 2021 15:49:45 +0200
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christoph Hellwig (2021-11-09 09:59:57)
> On Thu, Nov 04, 2021 at 02:59:18PM +0200, Joonas Lahtinen wrote:
> > The minimal we should do is to eliminate the double underscore
> > prefixed functions. But I would prefer to have the symbol exports by
> > default so that we can enable the functionality just by loading the
> > module.
> 
> I'm fine with exporting by default, but just loading won't really work
> even with that:
> 
>  - there are a bunch of IS_ENABLED conditionals in the i915 (although
>    they look like minor optimizations to me).

I'd assume the golden state capture being the one with biggest impact.

>  - the enable_gvt needs to be set, although after this refactor this
>    option is completely pointless and should probably be enabled

Indeed. Hope is that modprobe/rmmod would be enough to enable/disable.
This should help any distros intending to enable the feature, too.

So mostly about making sure the IS_ENABLED portions in base i915
operation are not too invasive.

>  - the enable_guc option needs to be disable for gvt to work.

On the GVT supported platforms GuC is disabled by default, so it should
be fine. We can change the logic to opposite to disable the feature if
the enable_guc unsafe modparam is used.

Regards, Joonas
