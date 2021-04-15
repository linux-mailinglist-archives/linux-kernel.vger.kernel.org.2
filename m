Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E143607E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhDOLC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:02:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:58665 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231771AbhDOLCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:02:54 -0400
IronPort-SDR: 8xYtHaaxMc2mDjyws2arAxKcIfXo7VlvgtuQRcRZmfypLDbui/Om5mRhbTbrDmEa8qpAVj7ggM
 VoNFZcnlQFEA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="182330507"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="182330507"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 04:02:30 -0700
IronPort-SDR: YDc8AL8j4VH8wKghSzxwpTIqvIj921iMls3RGM14JVmv02uhl9SSo2GHZYzKk9/JUi42xpPK3+
 LNwe2a0+Lfbg==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="452869839"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 04:02:28 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lWzlS-004DxR-72; Thu, 15 Apr 2021 14:02:26 +0300
Date:   Thu, 15 Apr 2021 14:02:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/1] mfd: intel_quark_i2c_gpio: Don't play dirty trick
 with const
Message-ID: <YHgdQsNbehBEE4ZZ@smile.fi.intel.com>
References: <20210326124842.2437-1-andriy.shevchenko@linux.intel.com>
 <20210326145129.GB2916463@dell>
 <20210414171319.GQ4869@dell>
 <YHcr144krHDay72g@smile.fi.intel.com>
 <20210414211916.GS4869@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414211916.GS4869@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:19:16PM +0100, Lee Jones wrote:
> On Wed, 14 Apr 2021, Andy Shevchenko wrote:
> > On Wed, Apr 14, 2021 at 06:13:19PM +0100, Lee Jones wrote:
> > > On Fri, 26 Mar 2021, Lee Jones wrote:

...

> > > Am I still missing patches from you Andy?
> > 
> > Patches for fixes should be applied to for-next as well. I don't know why with
> > my patches it diverged.
> > 
> > I have already commented on this when kbuild bot complained.
> > 
> > So,
> > 
> > 	git checkout for-mfd-next
> > 	git merge for-mfd-fixes
> > 
> > or equivalent (cherry-pick) will fix that.
> 
> Ah, it's in -rc5.  Very good.  Thanks for the explanation.

You are welcome!

-- 
With Best Regards,
Andy Shevchenko


