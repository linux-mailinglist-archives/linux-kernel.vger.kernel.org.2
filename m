Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BDF3A9581
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhFPJGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:06:51 -0400
Received: from foss.arm.com ([217.140.110.172]:59436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231354AbhFPJGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:06:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96DB131B;
        Wed, 16 Jun 2021 02:04:42 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 017353F70D;
        Wed, 16 Jun 2021 02:04:38 -0700 (PDT)
Date:   Wed, 16 Jun 2021 10:04:36 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        peter.hilber@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v4 03/16] firmware: arm_scmi: Add transport optional
 init/exit support
Message-ID: <20210616090436.GC35368@e120937-lin>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-4-cristian.marussi@arm.com>
 <20210614142956.000030f5@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614142956.000030f5@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

thanks for having a look at this series.

On Mon, Jun 14, 2021 at 02:29:56PM +0100, Jonathan Cameron wrote:
> On Fri, 11 Jun 2021 17:59:24 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > Some SCMI transport could need to perform some transport specific setup
> > before they can be used by the SCMI core transport layer: typically this
> > early setup consists in registering with some other kernel subsystem.
> > 
> > Add the optional capability for a transport to provide a couple of .init
> > and .exit functions that are assured to be called early during the SCMI
> > core initialization phase, well before the SCMI core probing step.
> > 
> > [ Peter: Adapted RFC patch by Cristian for submission to upstream. ]
> > Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> > [ Cristian: Fixed scmi_transports_exit point of invocation ]
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 
> Drive by comment inline.  Feel free to ignore ;)
> 
> Jonathan
> 
> > ---
> >  drivers/firmware/arm_scmi/common.h |  8 ++++
> >  drivers/firmware/arm_scmi/driver.c | 59 ++++++++++++++++++++++++++++++
> >  2 files changed, 67 insertions(+)
> > 
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 7c2b9fd7e929..6bb734e0e3ac 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -321,6 +321,12 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
> >  /**
> >   * struct scmi_desc - Description of SoC integration
> >   *
> > + * @init: An optional function that a transport can provide to initialize some
> > + *	  transport-specific setup during SCMI core initialization, so ahead of
> > + *	  SCMI core probing.
> > + * @exit: An optional function that a transport can provide to de-initialize
> > + *	  some transport-specific setup during SCMI core de-initialization, so
> > + *	  after SCMI core removal.
> >   * @ops: Pointer to the transport specific ops structure
> >   * @max_rx_timeout_ms: Timeout for communication with SoC (in Milliseconds)
> >   * @max_msg: Maximum number of messages that can be pending
> > @@ -328,6 +334,8 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
> >   * @max_msg_size: Maximum size of data per message that can be handled.
> >   */
> >  struct scmi_desc {
> > +	int (*init)(void);
> > +	void (*exit)(void);
> >  	const struct scmi_transport_ops *ops;
> >  	int max_rx_timeout_ms;
> >  	int max_msg;
> > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > index f15d75af87ea..20f8f0581f3a 100644
> > --- a/drivers/firmware/arm_scmi/driver.c
> > +++ b/drivers/firmware/arm_scmi/driver.c
> > @@ -1594,10 +1594,67 @@ static struct platform_driver scmi_driver = {
> >  	.remove = scmi_remove,
> >  };
> >  
> > +/**
> > + * __scmi_transports_setup  - Common helper to call transport-specific
> > + * .init/.exit code if provided.
> > + *
> > + * @init: A flag to distinguish between init and exit.
> > + *
> > + * Note that, if provided, we invoke .init/.exit functions for all the
> > + * transports currently compiled in.
> > + *
> > + * Return: 0 on Success.
> > + */
> > +static inline int __scmi_transports_setup(bool init)
> > +{
> > +	int ret = 0;
> > +	const struct of_device_id *trans;
> > +
> > +	for (trans = scmi_of_match; trans->data; trans++) {
> > +		const struct scmi_desc *tdesc = trans->data;
> > +
> > +		if ((init && !tdesc->init) || (!init && !tdesc->exit))
> > +			continue;
> > +
> > +		pr_debug("SCMI %sInitializing %s transport\n",
> > +			 init ? "" : "De-", trans->compatible);
> 
> Clever formatting can makes grepping for messages harder.
> 
> Perhaps
> 		if (init)
> 			pr_debug("SCMI Initializing %s transport\n",
> 				 trans->compatible);
> 		else
> 			pr_debug("SCMI Deinitializing %s transport\n",
> 				 trans->compatible);
> 
> would be nicer even though it burns some lines. Also avoids somewhat
> ugly capitalization : De-Initializing xxx transport.
> 
> You could combine it with the convenient if(init) below
> 

Right, I'll rework to avoid issues grepping.

Thanks,
Cristian

