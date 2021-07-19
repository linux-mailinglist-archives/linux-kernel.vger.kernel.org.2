Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4753CD06C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhGSIgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:36:21 -0400
Received: from foss.arm.com ([217.140.110.172]:53432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236020AbhGSIgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:36:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C64256D;
        Mon, 19 Jul 2021 02:16:54 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE5E03F73D;
        Mon, 19 Jul 2021 02:16:51 -0700 (PDT)
Date:   Mon, 19 Jul 2021 10:16:49 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        igor.skalkin@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v6 14/17] firmware: arm_scmi: Add message passing
 abstractions for transports
Message-ID: <20210719091649.GH49078@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-15-cristian.marussi@arm.com>
 <853e757b-1048-1528-7f61-63a482e06458@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <853e757b-1048-1528-7f61-63a482e06458@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 06:36:26PM +0200, Peter Hilber wrote:
> On 12.07.21 16:18, Cristian Marussi wrote:
> > From: Peter Hilber <peter.hilber@opensynergy.com>
> > 
> > Add abstractions for future transports using message passing, such as
> > virtio. Derive the abstractions from the shared memory abstractions.
> > 
> > Abstract the transport SDU through the opaque struct scmi_msg_payld.
> > Also enable the transport to determine all other required information
> > about the transport SDU.
> > 
> > Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> > [ Cristian: Adapted to new SCMI Kconfig layout, updated Copyrigths ]
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v4 --> v5
> > - adapted to new SCMI Kconfig
> > - removed raw_payload msg helpers
> > v3 --> v4
> > - added raw_payload msg helpers
> > ---
> >   drivers/firmware/arm_scmi/Kconfig  |   6 ++
> >   drivers/firmware/arm_scmi/Makefile |   1 +
> >   drivers/firmware/arm_scmi/common.h |  15 ++++
> >   drivers/firmware/arm_scmi/msg.c    | 113 +++++++++++++++++++++++++++++
> >   4 files changed, 135 insertions(+)
> >   create mode 100644 drivers/firmware/arm_scmi/msg.c
> > 
> > diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> > index ee6517b24080..1fdaa8ad7d3f 100644
> > --- a/drivers/firmware/arm_scmi/Kconfig
> > +++ b/drivers/firmware/arm_scmi/Kconfig
> > @@ -34,6 +34,12 @@ config ARM_SCMI_HAVE_SHMEM
> >   	  This declares whether a shared memory based transport for SCMI is
> >   	  available.
> > +config ARM_SCMI_HAVE_MSG
> > +	bool
> > +	help
> > +	  This declares whether a message passing based transport for SCMI is
> > +	  available.
> > +
> >   config ARM_SCMI_TRANSPORT_MAILBOX
> >   	bool "SCMI transport based on Mailbox"
> >   	depends on ARM_SCMI_PROTOCOL && MAILBOX
> > diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> > index e0e6bd3dba9e..aaad9f6589aa 100644
> > --- a/drivers/firmware/arm_scmi/Makefile
> > +++ b/drivers/firmware/arm_scmi/Makefile
> > @@ -4,6 +4,7 @@ scmi-driver-y = driver.o notify.o
> >   scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
> >   scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += mailbox.o
> >   scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
> > +scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
> >   scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
> >   scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
> >   		    $(scmi-transport-y)
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index 14457f0d5dea..7a1e84dc191b 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -415,6 +415,21 @@ void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
> >   bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
> >   		     struct scmi_xfer *xfer);
> > +/* declarations for message passing transports */
> > +struct scmi_msg_payld;
> > +
> > +/* Maximum overhead of message w.r.t. struct scmi_desc.max_msg_size */
> > +#define SCMI_MSG_MAX_PROT_OVERHEAD (2 * sizeof(__le32))
> > +
> > +size_t msg_response_size(struct scmi_xfer *xfer);
> > +size_t msg_command_size(struct scmi_xfer *xfer);
> > +void msg_tx_prepare(struct scmi_msg_payld *msg, struct scmi_xfer *xfer);
> > +u32 msg_read_header(struct scmi_msg_payld *msg);
> > +void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
> > +			struct scmi_xfer *xfer);
> > +void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
> > +			    size_t max_len, struct scmi_xfer *xfer);
> > +
> >   void scmi_notification_instance_data_set(const struct scmi_handle *handle,
> >   					 void *priv);
> >   void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
> > diff --git a/drivers/firmware/arm_scmi/msg.c b/drivers/firmware/arm_scmi/msg.c
> > new file mode 100644
> > index 000000000000..639969b7dc10
> > --- /dev/null
> > +++ b/drivers/firmware/arm_scmi/msg.c
> > @@ -0,0 +1,113 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * For transports using message passing.
> > + *
> > + * Derived from shm.c.
> > + *
> > + * Copyright (C) 2019-2021 ARM Ltd.
> > + * Copyright (C) 2020-2021 OpenSynergy GmbH
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/processor.h>
> 
> The above two includes appear to be unnecessary.

Right. Thanks, I'll fix.

Cristian

