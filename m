Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431403877B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbhERLcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:32:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:48987 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237487AbhERLcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:32:19 -0400
IronPort-SDR: ALUQwuMvC9FgIfaobm1zfXc/QWkY2AbQHiedslOjmIJxVgZsABJXiU/rtOpb6rAJKVUdQlLBnt
 MN/pDbMmli8w==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="261916647"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="261916647"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:31:01 -0700
IronPort-SDR: koxQTwtp9qhujy9SV5XThf26GKNpYVVMWXRxH8c68EeaArq7g5LAmlqC5n9rzOLAcFh33AfUiy
 j9Hb+oiJmG3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="541708200"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 18 May 2021 04:30:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 18 May 2021 14:30:57 +0300
Date:   Tue, 18 May 2021 14:30:57 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] driver core: platform: Remove
 platform_device_add_properties()
Message-ID: <YKOlcQqLarSIxE37@kuha.fi.intel.com>
References: <20210518083046.23302-1-heikki.krogerus@linux.intel.com>
 <YKOB6lRqc5DKo2GS@smile.fi.intel.com>
 <YKOjRyGlx6bHtgZc@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKOjRyGlx6bHtgZc@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 02:21:46PM +0300, Heikki Krogerus wrote:
> On Tue, May 18, 2021 at 11:59:22AM +0300, Andy Shevchenko wrote:
> > On Tue, May 18, 2021 at 11:30:44AM +0300, Heikki Krogerus wrote:
> > > Hi,
> > > 
> > > It looks like there is only one place left that still uses the
> > > function. Converting that last user and removing the thing.
> > > 
> > > Note, I'm actually resending the patch for board-paz00.c. I'm assuming
> > > the original patch slipped through the cracks because it did not end
> > > up anywhere.
> > 
> > Cool!
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Btw, which base have you used for this series?
> 
> intel-next for this one.

I mean linux-next :-)

-- 
heikki
