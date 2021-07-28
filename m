Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B463D8CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhG1Llk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:41:40 -0400
Received: from foss.arm.com ([217.140.110.172]:55446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231631AbhG1Llj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:41:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A75D31B;
        Wed, 28 Jul 2021 04:41:38 -0700 (PDT)
Received: from bogus (unknown [10.57.37.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEEA33F66F;
        Wed, 28 Jul 2021 04:41:34 -0700 (PDT)
Date:   Wed, 28 Jul 2021 12:40:18 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        peter.hilber@opensynergy.com, alex.bennee@linaro.org,
        jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
        anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andriy.Tryshnivskyy@opensynergy.com
Subject: Re: [PATCH v6 05/17] firmware: arm_scmi: Add transport optional
 init/exit support
Message-ID: <20210728114018.i7fquzpgfl4qv6tm@bogus>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712141833.6628-6-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 03:18:21PM +0100, Cristian Marussi wrote:
> Some SCMI transport could need to perform some transport specific setup
> before they can be used by the SCMI core transport layer: typically this
> early setup consists in registering with some other kernel subsystem.
> 
> Add the optional capability for a transport to provide a couple of .init
> and .exit functions that are assured to be called early during the SCMI
> core initialization phase, well before the SCMI core probing step.
> 
> [ Peter: Adapted RFC patch by Cristian for submission to upstream. ]
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> [ Cristian: Fixed scmi_transports_exit point of invocation ]
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v4 --> V5
> - removed useless pr_debug
> - moved scmi_transport_exit() invocation
> ---
>  drivers/firmware/arm_scmi/common.h |  8 +++++
>  drivers/firmware/arm_scmi/driver.c | 56 ++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 7c2b9fd7e929..6bb734e0e3ac 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -321,6 +321,12 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
>  /**
>   * struct scmi_desc - Description of SoC integration
>   *
> + * @init: An optional function that a transport can provide to initialize some
> + *	  transport-specific setup during SCMI core initialization, so ahead of
> + *	  SCMI core probing.
> + * @exit: An optional function that a transport can provide to de-initialize
> + *	  some transport-specific setup during SCMI core de-initialization, so
> + *	  after SCMI core removal.
>   * @ops: Pointer to the transport specific ops structure
>   * @max_rx_timeout_ms: Timeout for communication with SoC (in Milliseconds)
>   * @max_msg: Maximum number of messages that can be pending
> @@ -328,6 +334,8 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
>   * @max_msg_size: Maximum size of data per message that can be handled.
>   */
>  struct scmi_desc {
> +	int (*init)(void);
> +	void (*exit)(void);

Does it make sense to rename scmi_desc as scmi_transport or scmi_transport_desc ?
I reason I ask is plain init/exit here doesn't make sense. You can change it
to transport_init/exit if we don't want to rename the structure.

>  	const struct scmi_transport_ops *ops;

I assume we don't want init/exit inside ops as it is shared with protocols ?
Looks good other than the above comment.

-- 
Regards,
Sudeep
