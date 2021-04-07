Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618FB356D85
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347401AbhDGNk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:40:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:27432 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235536AbhDGNkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:40:24 -0400
IronPort-SDR: sKOYx2DxpS/SFMwfF5LCFq0vdoqMYpLgsWBK/UT9N01uEigVDY/sdTkj2kED+TC9EPL3KQsjdd
 hnL7bYLb6R4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="180437487"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="180437487"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 06:40:14 -0700
IronPort-SDR: cqKZMTMNKr1TbWNHHXtC82JhOBU6bIl+cEeCw4koBHuh2zsbS7xzig4/CHKPPtIiM5LTGY23Ut
 ZKN2H7/ykjzQ==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="379829570"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 06:40:13 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lU8Pi-0021Ol-5D; Wed, 07 Apr 2021 16:40:10 +0300
Date:   Wed, 7 Apr 2021 16:40:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v1 1/1] drm/i915: Include only needed headers in ascii85.h
Message-ID: <YG22OhNg3iQ8DFXW@smile.fi.intel.com>
References: <20210407122337.77493-1-andriy.shevchenko@linux.intel.com>
 <87h7kijm8i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7kijm8i.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 03:46:37PM +0300, Jani Nikula wrote:
> On Wed, 07 Apr 2021, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > The ascii85.h is user of exactly two headers, i.e. math.h and types.h.
> > There is no need to carry on entire kernel.h.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> That's hardly drm/i915 specific!

It was originated from i915!

> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Thanks!

> But who's going to pick it up and, hopefully, change the subject prefix
> to ascii85 or something?

It's drm specific. Should I leave drm and resend? Or what is the general rule
for drm misc changes?

-- 
With Best Regards,
Andy Shevchenko


