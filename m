Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC12F387802
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244997AbhERLuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:50:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:27529 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233617AbhERLuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:50:00 -0400
IronPort-SDR: J0Mw1CXN8N2b6z5MtVKaANMEmdh0PeaIG4tBbG+DDyIPp4xLyH3DypnsevHHWd246zMoxQh7Ev
 U+ZyfpHhf0+A==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="200385404"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200385404"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:48:41 -0700
IronPort-SDR: Pcji/Kzv5DlV5z8YXaEteeXD8fYq2rzPic6lhVvQCbHD4dsJrwAjJgBVO8ciIPwZbA/MmuxVRy
 4HGCGar0BEwQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="473518661"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:48:39 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1liyDF-00Cwbf-2p; Tue, 18 May 2021 14:48:37 +0300
Date:   Tue, 18 May 2021 14:48:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] driver core: platform: Remove
 platform_device_add_properties()
Message-ID: <YKOplS4Z4lleYWht@smile.fi.intel.com>
References: <20210518083046.23302-1-heikki.krogerus@linux.intel.com>
 <YKOB6lRqc5DKo2GS@smile.fi.intel.com>
 <YKOjRyGlx6bHtgZc@kuha.fi.intel.com>
 <YKOlcQqLarSIxE37@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKOlcQqLarSIxE37@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 02:30:57PM +0300, Heikki Krogerus wrote:
> On Tue, May 18, 2021 at 02:21:46PM +0300, Heikki Krogerus wrote:
> > On Tue, May 18, 2021 at 11:59:22AM +0300, Andy Shevchenko wrote:
> > > On Tue, May 18, 2021 at 11:30:44AM +0300, Heikki Krogerus wrote:
> > > > Hi,
> > > > 
> > > > It looks like there is only one place left that still uses the
> > > > function. Converting that last user and removing the thing.
> > > > 
> > > > Note, I'm actually resending the patch for board-paz00.c. I'm assuming
> > > > the original patch slipped through the cracks because it did not end
> > > > up anywhere.
> > > 
> > > Cool!
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > Btw, which base have you used for this series?
> > 
> > intel-next for this one.
> 
> I mean linux-next :-)

Let's wait for CIs to respond. I have a feeling that the first patch is good
for v5.14, while the second one is probably for the next cycle.

-- 
With Best Regards,
Andy Shevchenko


