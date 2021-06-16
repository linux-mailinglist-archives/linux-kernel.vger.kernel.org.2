Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759053A95BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhFPJRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:17:08 -0400
Received: from foss.arm.com ([217.140.110.172]:59748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhFPJQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:16:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE5B331B;
        Wed, 16 Jun 2021 02:14:46 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C97593F70D;
        Wed, 16 Jun 2021 02:14:43 -0700 (PDT)
Date:   Wed, 16 Jun 2021 10:14:36 +0100
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
Subject: Re: [PATCH v4 12/16] firmware: arm_scmi: Add message passing
 abstractions for transports
Message-ID: <20210616091436.GF35368@e120937-lin>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-13-cristian.marussi@arm.com>
 <20210614151036.00000409@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614151036.00000409@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 03:10:36PM +0100, Jonathan Cameron wrote:
> On Fri, 11 Jun 2021 17:59:33 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
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
> > ---
> ...
> > diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> > index b783ae058c8a..fa4075336580 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -410,6 +410,21 @@ void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
> >  bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
> >  		     struct scmi_xfer *xfer);
> >  
> > +/* declarations for message passing transports */
> > +struct scmi_msg_payld;
> > +
> > +/** Maximum overhead of message w.r.t. struct scmi_desc.max_msg_size */
> 
> Doesn't look to be kernel-doc..
> 
Right, I'll fix.

Cristian

> > +#define SCMI_MSG_MAX_PROT_OVERHEAD (2 * sizeof(__le32))
