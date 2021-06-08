Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3B739F79A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhFHNUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:20:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:2174 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232916AbhFHNU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:20:28 -0400
IronPort-SDR: DVXPmKH8vMgx9UJjscyVFhcy2g0CUZYfhWXy34sZSFQX2X/Z1qFkxL/UXZ0pgA9DkxzClxkJer
 4dIpzitiAE6w==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="226184001"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="226184001"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 06:18:35 -0700
IronPort-SDR: 7JQRozo58WL6GPe4AKfKHK9YOjwgV53n0ap5P0UP42As1RqJ5qgkOx6JetDc0cRlv0EfMA9fY1
 xqYUJZBEbBPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="552275810"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Jun 2021 06:18:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 08 Jun 2021 16:18:32 +0300
Date:   Tue, 8 Jun 2021 16:18:32 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Benjamin Berg <bberg@redhat.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/7] usb: typec: ucsi: Don't stop alt mode
 registration on busy condition
Message-ID: <YL9uKFiHm0fht67X@kuha.fi.intel.com>
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
 <20210607131442.20121-3-heikki.krogerus@linux.intel.com>
 <2f4bf248-cd27-623d-5984-fafa931404fa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4bf248-cd27-623d-5984-fafa931404fa@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 12:31:45PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 07.06.2021 16:14, Heikki Krogerus wrote:
> 
> > If the PPM tells it's busy, we can now simply try again.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >   drivers/usb/typec/ucsi/ucsi.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > index 366c8a468bc18..a8e0e31dcddf5 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -437,8 +437,11 @@ static int ucsi_register_altmodes(struct ucsi_connector *con, u8 recipient)
> >   		command |= UCSI_GET_ALTMODE_CONNECTOR_NUMBER(con->num);
> >   		command |= UCSI_GET_ALTMODE_OFFSET(i);
> >   		len = ucsi_send_command(con->ucsi, command, alt, sizeof(alt));
> 
>    Could insert your check here, to reduce the indentation...

Sure thing.

> > -		if (len <= 0)
> > +		if (len <= 0) {
> > +			if (len == -EBUSY)
> > +				continue;
> >   			return len;
> > +		}
> >   		/*
> >   		 * This code is requesting one alt mode at a time, but some PPMs

thanks,

-- 
heikki
