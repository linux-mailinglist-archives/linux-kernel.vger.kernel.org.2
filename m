Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55CB311E35
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhBFO7k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 6 Feb 2021 09:59:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:8762 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhBFO73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:59:29 -0500
IronPort-SDR: qQhblP2XlZa25FyLO4lrJpcW65UidPMaqJPDyEWM2kqeppJVS10u2SwhJtgzXLfuTweJ1SEOc2
 N7qSpTelZH1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181609195"
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="181609195"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 06:58:48 -0800
IronPort-SDR: H7+jjMBA0i8FQSLN04oORNx8Jt/lLfcaVi+Cm9WET5szUMfJxNqEvpjzaM+YJblC0PLuZhT2F6
 kKm+VhDBhjWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="373769466"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2021 06:58:48 -0800
Received: from lcsmsx603.ger.corp.intel.com (10.109.210.12) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 6 Feb 2021 06:58:47 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX603.ger.corp.intel.com (10.109.210.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 6 Feb 2021 16:58:43 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Sat, 6 Feb 2021 16:58:43 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next 1/6] mei: use sprintf in tx_queue_limit_show
 sysfs
Thread-Topic: [char-misc-next 1/6] mei: use sprintf in tx_queue_limit_show
 sysfs
Thread-Index: AQHW/JZ1OmeVbG9b6UmW8NQyyplctapLExIAgAAkUkA=
Date:   Sat, 6 Feb 2021 14:58:43 +0000
Message-ID: <32de2e88c66d467fb2eafe8d20bc280d@intel.com>
References: <20210206144325.25682-1-tomas.winkler@intel.com>
 <YB6r1HcHjEQpseaM@kroah.com>
In-Reply-To: <YB6r1HcHjEQpseaM@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sat, Feb 06, 2021 at 04:43:20PM +0200, Tomas Winkler wrote:
> > Using of snprintf is discouraged in sysfs.
> > For simple u8 it is safe to use sprintf.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> >  drivers/misc/mei/main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c index
> > 9f6682033ed7..24a05f45b639 100644
> > --- a/drivers/misc/mei/main.c
> > +++ b/drivers/misc/mei/main.c
> > @@ -1026,7 +1026,7 @@ static ssize_t tx_queue_limit_show(struct device
> *device,
> >  	size = dev->tx_queue_limit;
> >  	mutex_unlock(&dev->device_lock);
> >
> > -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> > +	return sprintf(buf, "%u\n", size);
> 
> If you are going to do this, why not just convert it to use sysfs_emit()
> instead?

I thought it's an overkill, but if you prefer that I will resubmit. 

Thanks
Tomas

