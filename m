Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92444311E3D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhBFPFs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 6 Feb 2021 10:05:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:42012 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhBFPFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 10:05:33 -0500
IronPort-SDR: Z7jN5Uj9tqL1GzLp4pIQI3wYaK3clwm1z8mH0FAGtQ06Sx5W2QDHB8GlfTQx9fLkpF007M7zfy
 yTkl8jLbHaWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="168667859"
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="168667859"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 07:04:37 -0800
IronPort-SDR: 2r4eqh7NX8XprghcOrgxODDadsgbYLHokaXJIF+0qxRFFRYI7mL/dfFa9Te8H2AOEDvtxPj+po
 kIWO0wuNZcew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="374524976"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 06 Feb 2021 07:04:37 -0800
Received: from hasmsx601.ger.corp.intel.com (10.184.107.141) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 6 Feb 2021 07:04:37 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX601.ger.corp.intel.com (10.184.107.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 6 Feb 2021 17:04:35 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Sat, 6 Feb 2021 17:04:34 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: RE: [char-misc-next 6/6] mei: bus: add client dma interface
Thread-Topic: [char-misc-next 6/6] mei: bus: add client dma interface
Thread-Index: AQHW/JZ6zfy6g0Lzl0WlwNIsjRgFAKpLE28AgAAknRA=
Date:   Sat, 6 Feb 2021 15:04:34 +0000
Message-ID: <2a9b40090acd41438fc6b1d2fb49f38d@intel.com>
References: <20210206144325.25682-1-tomas.winkler@intel.com>
 <20210206144325.25682-6-tomas.winkler@intel.com> <YB6sIi61X5p6Dq6y@kroah.com>
In-Reply-To: <YB6sIi61X5p6Dq6y@kroah.com>
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

> On Sat, Feb 06, 2021 at 04:43:25PM +0200, Tomas Winkler wrote:
> > From: Alexander Usyskin <alexander.usyskin@intel.com>
> >
> > Expose the client dma mapping via mei client bus interface.
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> >  drivers/misc/mei/bus.c     | 46
> ++++++++++++++++++++++++++++++++++++++
> >  drivers/misc/mei/hw.h      |  5 +++++
> >  include/linux/mei_cl_bus.h |  3 +++
> >  3 files changed, 54 insertions(+)
> >
> > diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c index
> > 34fb5e541fe5..d430710a5fe5 100644
> > --- a/drivers/misc/mei/bus.c
> > +++ b/drivers/misc/mei/bus.c
> > @@ -636,6 +636,52 @@ static void mei_cl_bus_vtag_free(struct
> mei_cl_device *cldev)
> >  	kfree(cl_vtag);
> >  }
> >
> > +void *mei_cldev_dma_map(struct mei_cl_device *cldev, u8 buffer_id,
> > +size_t size) {
> > +	struct mei_device *bus;
> > +	struct mei_cl *cl;
> > +	int ret;
> > +
> > +	if (!cldev || !buffer_id || !size)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (!IS_ALIGNED(size, MEI_FW_PAGE_SIZE)) {
> > +		dev_err(&cldev->dev, "Map size should be aligned to %lu\n",
> > +			MEI_FW_PAGE_SIZE);
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	cl = cldev->cl;
> > +	bus = cldev->bus;
> > +
> > +	mutex_lock(&bus->device_lock);
> > +	ret = mei_cl_dma_alloc_and_map(cl, NULL, buffer_id, size);
> > +	mutex_unlock(&bus->device_lock);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +	return cl->dma.vaddr;
> > +}
> > +EXPORT_SYMBOL_GPL(mei_cldev_dma_map);
> 
> Why are you exporting symbols without a user of them?
> 
> That's a sure way to get them removed by someone right after this lands in
> the tree :)
> 
> Please only add infrastructure for when you have a real user.
You are right,  the user is coming from wifi tree. We need merge before they do.
If you prefer we can merge that all from the wifi tree. 


Thanks
Tomas

