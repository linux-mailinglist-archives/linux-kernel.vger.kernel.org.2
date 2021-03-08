Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D752330C88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhCHLh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:37:26 -0500
Received: from foss.arm.com ([217.140.110.172]:36500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhCHLhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:37:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04F34D6E;
        Mon,  8 Mar 2021 03:37:09 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F1703F73C;
        Mon,  8 Mar 2021 03:37:07 -0800 (PST)
Date:   Mon, 8 Mar 2021 11:37:04 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 02/37] firmware: arm_scmi: introduce protocol handle
 definitions
Message-ID: <20210308113704.GD30179@e120937-lin>
References: <20210202221555.41167-1-cristian.marussi@arm.com>
 <20210202221555.41167-3-cristian.marussi@arm.com>
 <20210308055030.ljgyybawujmaf2gg@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308055030.ljgyybawujmaf2gg@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 05:50:30AM +0000, Sudeep Holla wrote:
> On Tue, Feb 02, 2021 at 10:15:20PM +0000, Cristian Marussi wrote:
> > Add basic protocol handles definitions and private data helpers support.
> > 
> > A protocol handle identifies a protocol instance initialized against a
> > specific handle; it embeds all the references to the core SCMI xfer methods
> > that will be needed by a protocol implementation to build and send its own
> > protocol specific messages using common core methods.
> > 
> > As such, in the interface, a protocol handle will be passed down from the
> > core to the protocol specific initialization callback at init time.
> > 
> > Anyway at this point only definitions are introduced, all protocols
> > initialization code and SCMI drivers probing is still based on the old
> > interface, so no functional change.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/common.h | 59 ++++++++++++++++++++++++++++++
> >  drivers/firmware/arm_scmi/driver.c | 45 +++++++++++++++++++++++
> >  2 files changed, 104 insertions(+)
> > 
> 
> [...]
> 
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index ed94efbecd61..2328a468bbd1 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> 
> [...]
> 
> >  /**
> >   * scmi_get_protocol_instance  - Protocol initialization helper.
> >   * @handle: A reference to the SCMI platform instance.
> > @@ -588,6 +629,10 @@ scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
> >  
> >  		pi->gid = gid;
> >  		pi->proto = proto;
> > +		pi->handle = handle;
> > +		pi->ph.dev = handle->dev;
> > +		pi->ph.set_priv = scmi_set_protocol_priv;
> > +		pi->ph.get_priv = scmi_get_protocol_priv;
> 
> 
> Sorry missed this in earlier patch. Not a must, but I prefer if you can move
> all these initialisation into separate functions so that scmi_get_protocol_instance
> can be simplified to read.
> 
> if (pi)
> 	increment refcount
> else
> 	scmi_get_protocol
> 	alloc and init protocol instance
> 	register events
> 
> How about some thing like above ?
> 

Sure I'll do.

> --
> Regards,
> Sudeep
