Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06D645DA87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354829AbhKYNAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:00:42 -0500
Received: from foss.arm.com ([217.140.110.172]:50666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351807AbhKYM6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:58:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D4001FB;
        Thu, 25 Nov 2021 04:55:26 -0800 (PST)
Received: from bogus (unknown [10.57.46.248])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B94AF3F66F;
        Thu, 25 Nov 2021 04:55:24 -0800 (PST)
Date:   Thu, 25 Nov 2021 12:55:21 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v8 2/2] firmware: arm_scmi: Add optee transport
Message-ID: <20211125125521.duwjqkkdcbvrc2ct@bogus>
References: <20211028140009.23331-1-etienne.carriere@linaro.org>
 <20211028140009.23331-2-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211028140009.23331-2-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 04:00:09PM +0200, Etienne Carriere wrote:
> Add a new transport channel to the SCMI firmware interface driver for
> SCMI message exchange based on optee transport channel. The optee
> transport is realized by connecting and invoking OP-TEE SCMI service
> interface PTA.
> 
> Optee transport support (CONFIG_ARM_SCMI_TRANSPORT_OPTEE) is default
> enabled when optee driver (CONFIG_OPTEE) is enabled. Effective optee
> transport is setup upon OP-TEE SCMI service discovery at optee
> device initialization. For this SCMI UUID is registered to the optee
> bus for probing. This is done from the link_supplier operator of the
> SCMI optee transport.
> 
> The optee transport can use a statically defined shared memory in
> which case SCMI device tree node defines it using an "arm,scmi-shmem"
> compatible phandle through property shmem. Alternatively, optee transport
> allocates the shared memory buffer from the optee driver when no shmem
> property is defined.
> 
> The protocol used to exchange SCMI message over that shared memory is
> negotiated between optee transport driver and the OP-TEE service through
> capabilities exchange.
> 
> OP-TEE SCMI service is integrated in OP-TEE since its release tag 3.13.0.
> The service interface is published in [1].
> 
> Link: [1] https://github.com/OP-TEE/optee_os/blob/3.13.0/lib/libutee/include/pta_scmi_client.h
> Cc: Cristian Marussi <cristian.marussi@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v7:
>  - Fix transport exit to not unregister scmi optee driver from tee bus
>    if the transport was not initialized (hence registered to tee bus).
> 
> Changes since v6:
>  - Fixed at last s/CFG_OPTEE/CONFIG_OPTEE/ in commit log.
> 
> Changes since v5:
>  - scmi_optee_link_supplier() doesn't test scmi_optee_private->tee_ctx.
>  - Free allocated shared memory when scmi_optee_chan_setup() fails.
>  - Close session to TEE SCMI service when SCMI channel is freed.
>  - Use SCMI_OPTEE_MAX_MSG_SIZE in SCMI transport descriptor.
> 
> Changes since v4:
>  - Fix commit log that was not updated to v4 changes.
>  - Operator scmi_optee_chan_setup() don't need the defer probe
>    operation, it's already done from scmi_optee_link_supplier().
> 
> Changes since v3:
>  - Fix use of configuration switches when CONFIG_OPTEE and
>    CONFIG_ARM_SCMI_PROTOCOL are enabled/modules/disabled.
>    Mimics scmi virtio integration.
>  - Implement link_supplier operator for the scmi_optee transport
>    to possibly defer probing when optee bus has not yet enumerated
>    the SCMI OP-TEE service. The function ensures scmi_optee registers
>    to optee bus enumeration when probe is deferred.
>  - Add memory barriers to protect global optee service reference
>    when it's updated at transport initialization and removal.
>  - Replace enum pta_scmi_caps with macro definitions as enumerated
>    types do not really match bit flags definitions. The capabilities
>    data is now of type u32.
>  - Use scmi_optee_ prefix for scmi transport operator handles
>    and few other resources.
>  - Fix typo: s/optee_smci_pta_cmd/optee_scmi_pta_cmd/
>  - Remove useless DRIVER_NAME.
>  - Minor reordering in struct optee_channel.
>  - Removed some useless empty lines.
> 
> Changes since v2:
> - Rebase on for-next/scmi, based on Linux v5.15-rc1.
> - Implement support for dynamic and static shared memory.
> - Factorize some functions and simplify transport exit sequence.
> - Rename driver source file from optee_service.c to optee.c.
> 
> No change since v1
> ---
>  drivers/firmware/arm_scmi/Kconfig  |  12 +
>  drivers/firmware/arm_scmi/Makefile |   1 +
>  drivers/firmware/arm_scmi/common.h |   3 +
>  drivers/firmware/arm_scmi/driver.c |   3 +
>  drivers/firmware/arm_scmi/optee.c  | 581 +++++++++++++++++++++++++++++
>  5 files changed, 600 insertions(+)
>  create mode 100644 drivers/firmware/arm_scmi/optee.c
> 

[...]

> +static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *channel)
> +{
> +	const size_t msg_size = SCMI_OPTEE_MAX_MSG_SIZE;
> +
> +	channel->tee_shm = tee_shm_alloc_kernel_buf(scmi_optee_private->tee_ctx, msg_size);
> +	if (IS_ERR(channel->tee_shm)) {
> +		dev_err(channel->cinfo->dev, "shmem allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	channel->shmem = (void *)tee_shm_get_va(channel->tee_shm, 0);
> +	memset(channel->shmem, 0, msg_size);
> +	shmem_clear_channel(channel->shmem);
> +
> +	return 0;
> +}

I was holding on applying this patch as I reviewed this partially when I was
on vacation and couldn't remember the comment I had until I just replied now
with applied message 😄.

Anyways, is this dynamic_shmem tested on a hardware ?
shmem_* apis are based on __iomem and IIUC tee_shm_alloc_kernel_buf returns
normal memory, so you can't use those shmem_* apis as is. Please drop the
whole dynamic_shmem and send me a patch for v5.17 as we may need more changes
to support that.

I remember Broadcom or someone else wanted this with normal memory, we can
add that support correctly at once involving them too. For now, please drop
that or I can post a patch to do that if you agree with my arguments.

Sorry for completely forgetting about this.
--
Regards,
Sudeep
