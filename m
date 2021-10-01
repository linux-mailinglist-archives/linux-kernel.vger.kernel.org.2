Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E2541E9A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 11:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352979AbhJAJgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 05:36:46 -0400
Received: from foss.arm.com ([217.140.110.172]:38798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhJAJgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 05:36:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9491101E;
        Fri,  1 Oct 2021 02:35:00 -0700 (PDT)
Received: from bogus (unknown [10.57.26.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FFEC3F70D;
        Fri,  1 Oct 2021 02:34:58 -0700 (PDT)
Date:   Fri, 1 Oct 2021 10:34:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org
Subject: Re: [PATCH v5 5/5] optee: add FF-A support
Message-ID: <20211001093424.n4x34qp3ewbbijmc@bogus>
References: <20210831072412.887565-1-jens.wiklander@linaro.org>
 <20210831072412.887565-6-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831072412.887565-6-jens.wiklander@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 09:24:12AM +0200, Jens Wiklander wrote:
> Adds support for using FF-A [1] as transport to the OP-TEE driver.
> 
> Introduces struct optee_msg_param_fmem which carries all information
> needed when OP-TEE is calling FFA_MEM_RETRIEVE_REQ to get the shared
> memory reference mapped by the hypervisor in S-EL2. Register usage is
> also updated to include the information needed.
> 
> The FF-A part of this driver is enabled if CONFIG_ARM_FFA_TRANSPORT is
> enabled.
> 
> [1] https://developer.arm.com/documentation/den0077/latest
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/Makefile        |   3 +-
>  drivers/tee/optee/call.c          |  13 +-
>  drivers/tee/optee/core.c          |  16 +-
>  drivers/tee/optee/ffa_abi.c       | 907 ++++++++++++++++++++++++++++++
>  drivers/tee/optee/optee_ffa.h     | 153 +++++
>  drivers/tee/optee/optee_msg.h     |  27 +-
>  drivers/tee/optee/optee_private.h |  43 +-
>  7 files changed, 1148 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/tee/optee/ffa_abi.c
>  create mode 100644 drivers/tee/optee/optee_ffa.h
> 
> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> index d4e4776d2dec..dbfd83d3c4ae 100644
> --- a/drivers/tee/optee/Makefile
> +++ b/drivers/tee/optee/Makefile
> @@ -7,7 +7,8 @@ optee-objs += supp.o
>  optee-objs += device.o
>  
>  optee-smc-abi-y = smc_abi.o
> -optee-objs += $(optee-smc-abi-y)
> +optee-ffa-abi-$(CONFIG_ARM_FFA_TRANSPORT) = ffa_abi.o
> +optee-objs += $(optee-smc-abi-y) $(optee-ffa-abi-y)
>

This may not work when CONFIG_ARM_FFA_TRANSPORT=m, I don't have cleaner
solution apart from having if else.


[...]

> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index ca0213e330b5..2593742364da 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h

[...]

> @@ -116,11 +127,13 @@ struct optee_ops {
>   *			world
>   * @teedev:		client device
>   * @smc:		specific to SMC ABI
> + * @ffa:		specific to FF-A ABI
>   * @call_queue:		queue of threads waiting to call @invoke_fn
>   * @wait_queue:		queue of threads from secure world waiting for a
>   *			secure world sync object
>   * @supp:		supplicant synchronization struct for RPC to supplicant
>   * @pool:		shared memory pool
> + * @rpc_arg_count:	If > 0 number of RPC parameters to make room for
>   * @scan_bus_done	flag if device registation was already done.
>   * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
>   * @scan_bus_work	workq to scan optee bus and register optee drivers
> @@ -129,11 +142,17 @@ struct optee {
>  	struct tee_device *supp_teedev;
>  	struct tee_device *teedev;
>  	const struct optee_ops *ops;
> -	struct optee_smc smc;
> +	union {
> +		struct optee_smc smc;
> +#ifdef CONFIG_ARM_FFA_TRANSPORT

I don't see a point in saving this especially that the definition is
available always. Also helps the case when FFA is module.

> +		struct optee_ffa ffa;
> +#endif
> +	};
>  	struct optee_call_queue call_queue;
>  	struct optee_wait_queue wait_queue;
>  	struct optee_supp supp;
>  	struct tee_shm_pool *pool;
> +	unsigned int rpc_arg_count;
>  	bool   scan_bus_done;
>  	struct workqueue_struct *scan_bus_wq;
>  	struct work_struct scan_bus_work;
> @@ -266,4 +285,12 @@ static inline void reg_pair_from_64(u32 *reg0, u32 *reg1, u64 val)
>  int optee_smc_abi_register(void);
>  void optee_smc_abi_unregister(void);
>  
> +#ifdef CONFIG_ARM_FFA_TRANSPORT

To support CONFIG_ARM_FFA_TRANSPORT=m this must be,

#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)

-- 
Regards,
Sudeep
