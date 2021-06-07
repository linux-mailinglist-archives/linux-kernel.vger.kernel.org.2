Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446DA39E059
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhFGPay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:30:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:28731 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhFGPaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:30:52 -0400
IronPort-SDR: aVLnPAQEJDo4pPotTfC3rNSBzYPizkSax6qLIKCSR5wvzzUvFz8C+PUFIVgYW887Rnyn+FwipR
 idfQaxa7QiCw==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="265797684"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="265797684"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 08:28:59 -0700
IronPort-SDR: ZDOqp0VjZthuNlcLEFoR5ZLErRZX+kH4LxmMs0P5Nwo/qN5pmNsybcB552J7RHrqtV+eLZXb1w
 08vzIm1pFK5A==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="476244310"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 08:28:57 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lqHBP-000Hpe-5q; Mon, 07 Jun 2021 18:28:55 +0300
Date:   Mon, 7 Jun 2021 18:28:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] usb: typec: wcove: Use LE to CPU conversion when
 accessing msg->header
Message-ID: <YL47Ny7hXZmgH/dx@smile.fi.intel.com>
References: <20210519085534.48732-1-andriy.shevchenko@linux.intel.com>
 <YKYrQXXk/X72iI+0@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKYrQXXk/X72iI+0@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 12:26:25PM +0300, Heikki Krogerus wrote:
> On Wed, May 19, 2021 at 11:55:34AM +0300, Andy Shevchenko wrote:
> > As LKP noticed the Sparse is not happy about strict type handling:
> >    .../typec/tcpm/wcove.c:380:50: sparse:     expected unsigned short [usertype] header
> >    .../typec/tcpm/wcove.c:380:50: sparse:     got restricted __le16 const [usertype] header
> > 
> > Fix this by switching to use pd_header_cnt_le() instead of pd_header_cnt()
> > in the affected code.
> > 
> > Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks!

Greg, should I amend or resend this?

-- 
With Best Regards,
Andy Shevchenko


