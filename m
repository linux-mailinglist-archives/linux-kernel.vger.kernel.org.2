Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D792E38775B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhERLX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:23:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:10072 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhERLXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:23:06 -0400
IronPort-SDR: WnO0kP0oBgLzXN5QA2iFEourGki9b4sdCunC9Em6sg9CdVM6Urj9ItePA6WIEPyB3e1svD/XIK
 CQV9uDQoyRRQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="200734363"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="200734363"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:21:46 -0700
IronPort-SDR: OkFTpoS986SZ2JMNI9Obk7NMsRKu2hppclKdNNK3c4uArufGh98aeLWosOnTIpu+pbFVps4uwm
 T9liX0YDFSlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="541704189"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 18 May 2021 04:21:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 18 May 2021 14:21:43 +0300
Date:   Tue, 18 May 2021 14:21:43 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] driver core: platform: Remove
 platform_device_add_properties()
Message-ID: <YKOjRyGlx6bHtgZc@kuha.fi.intel.com>
References: <20210518083046.23302-1-heikki.krogerus@linux.intel.com>
 <YKOB6lRqc5DKo2GS@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKOB6lRqc5DKo2GS@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 11:59:22AM +0300, Andy Shevchenko wrote:
> On Tue, May 18, 2021 at 11:30:44AM +0300, Heikki Krogerus wrote:
> > Hi,
> > 
> > It looks like there is only one place left that still uses the
> > function. Converting that last user and removing the thing.
> > 
> > Note, I'm actually resending the patch for board-paz00.c. I'm assuming
> > the original patch slipped through the cracks because it did not end
> > up anywhere.
> 
> Cool!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Btw, which base have you used for this series?

intel-next for this one.


-- 
heikki
