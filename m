Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F53312493
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhBGOD5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 7 Feb 2021 09:03:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:26521 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhBGODz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:03:55 -0500
IronPort-SDR: 8D3jnlqdJkFFWwCoCYGVx4n6feYwehA4i4xZN6XZFgkDTnE1yedXxIgEPE6le74wRd40mO0FVq
 l1IMjvxzpe1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9887"; a="161361343"
X-IronPort-AV: E=Sophos;i="5.81,160,1610438400"; 
   d="scan'208";a="161361343"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 06:03:15 -0800
IronPort-SDR: w4HwOLhkr11WcQKJxIouR3zrWuMLjBvTTgX35xGPQULIwJH8khipzlNpWCHX9peZwLkDGn593g
 Gj056aD/h/nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,160,1610438400"; 
   d="scan'208";a="486633978"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2021 06:03:14 -0800
Received: from lcsmsx602.ger.corp.intel.com (10.109.210.11) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 7 Feb 2021 06:03:14 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX602.ger.corp.intel.com (10.109.210.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 7 Feb 2021 16:03:12 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Sun, 7 Feb 2021 16:03:11 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>
Subject: RE: [char-misc-next 6/6] mei: bus: add client dma interface
Thread-Topic: [char-misc-next 6/6] mei: bus: add client dma interface
Thread-Index: AQHW/JZ6zfy6g0Lzl0WlwNIsjRgFAKpLE28AgAAknRD///f+gIABA0qw
Date:   Sun, 7 Feb 2021 14:03:11 +0000
Message-ID: <8223112ef8504a31996c2c1bd386d1fe@intel.com>
References: <20210206144325.25682-1-tomas.winkler@intel.com>
 <20210206144325.25682-6-tomas.winkler@intel.com> <YB6sIi61X5p6Dq6y@kroah.com>
 <2a9b40090acd41438fc6b1d2fb49f38d@intel.com> <YB7EIciZrmBrEqUA@kroah.com>
In-Reply-To: <YB7EIciZrmBrEqUA@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sat, Feb 06, 2021 at 03:04:34PM +0000, Winkler, Tomas wrote:
> > > On Sat, Feb 06, 2021 at 04:43:25PM +0200, Tomas Winkler wrote:
> > > > From: Alexander Usyskin <alexander.usyskin@intel.com>
> > > >
> > > > Expose the client dma mapping via mei client bus interface.
> > > >
> > > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > ---
> > > >  drivers/misc/mei/bus.c     | 46
> > > ++++++++++++++++++++++++++++++++++++++
> > > >  drivers/misc/mei/hw.h      |  5 +++++
> > > >  include/linux/mei_cl_bus.h |  3 +++
> > > >  3 files changed, 54 insertions(+)
> > > >
> > > > diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c index
> > > > 34fb5e541fe5..d430710a5fe5 100644
> > > > --- a/drivers/misc/mei/bus.c
> > > > +++ b/drivers/misc/mei/bus.c
> > > > @@ -636,6 +636,52 @@ static void mei_cl_bus_vtag_free(struct
> > > mei_cl_device *cldev)
> > > >  	kfree(cl_vtag);
> > > >  }
> > > >
> > > > +void *mei_cldev_dma_map(struct mei_cl_device *cldev, u8
> > > > +buffer_id, size_t size) {
> > > > +	struct mei_device *bus;
> > > > +	struct mei_cl *cl;
> > > > +	int ret;
> > > > +
> > > > +	if (!cldev || !buffer_id || !size)
> > > > +		return ERR_PTR(-EINVAL);
> > > > +
> > > > +	if (!IS_ALIGNED(size, MEI_FW_PAGE_SIZE)) {
> > > > +		dev_err(&cldev->dev, "Map size should be aligned to %lu\n",
> > > > +			MEI_FW_PAGE_SIZE);
> > > > +		return ERR_PTR(-EINVAL);
> > > > +	}
> > > > +
> > > > +	cl = cldev->cl;
> > > > +	bus = cldev->bus;
> > > > +
> > > > +	mutex_lock(&bus->device_lock);
> > > > +	ret = mei_cl_dma_alloc_and_map(cl, NULL, buffer_id, size);
> > > > +	mutex_unlock(&bus->device_lock);
> > > > +	if (ret)
> > > > +		return ERR_PTR(ret);
> > > > +	return cl->dma.vaddr;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(mei_cldev_dma_map);
> > >
> > > Why are you exporting symbols without a user of them?
> > >
> > > That's a sure way to get them removed by someone right after this
> > > lands in the tree :)
> > >
> > > Please only add infrastructure for when you have a real user.
> > You are right,  the user is coming from wifi tree. We need merge before
> they do.
> > If you prefer we can merge that all from the wifi tree.
> 
> That wasn't documented well at all in your changelog comment :(
Note taken.  
> It can go through whatever tree needs it.
If possible please merge our changes already here, and let the wifi guys to finish their task in their tree, in their own time.
Thanks
Tomas

