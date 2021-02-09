Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B7A31534E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhBIP70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231654AbhBIP7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:59:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C677664E8A;
        Tue,  9 Feb 2021 15:58:39 +0000 (UTC)
Date:   Tue, 9 Feb 2021 10:58:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Message-ID: <20210209105838.5fcb31ac@gandalf.local.home>
In-Reply-To: <20210209190215.337b3d0f@xhacker.debian>
References: <20210209190215.337b3d0f@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 19:02:15 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Add tracepoints to retrieve information about the invoke_fn. This would
> help to measure how many invoke_fn are triggered and how long it takes
> to complete one invoke_fn call.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/tee/optee/call.c        |  4 ++
>  drivers/tee/optee/optee_trace.h | 65 +++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 drivers/tee/optee/optee_trace.h
> 
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 780d7c4fd756..9dbab10e7ac3 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -12,6 +12,8 @@
>  #include <linux/tee_drv.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> +#define CREATE_TRACE_POINTS
> +#include "optee_trace.h"
>  #include "optee_private.h"
>  #include "optee_smc.h"
>  
> @@ -138,9 +140,11 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
>  	while (true) {
>  		struct arm_smccc_res res;
>  
> +		trace_optee_invoke_fn_begin(&param);
>  		optee->invoke_fn(param.a0, param.a1, param.a2, param.a3,
>  				 param.a4, param.a5, param.a6, param.a7,
>  				 &res);
> +		trace_optee_invoke_fn_end(&param, &res);
>  
>  		if (res.a0 == OPTEE_SMC_RETURN_ETHREAD_LIMIT) {
>  			/*
> diff --git a/drivers/tee/optee/optee_trace.h b/drivers/tee/optee/optee_trace.h
> new file mode 100644
> index 000000000000..f209df7004c2
> --- /dev/null
> +++ b/drivers/tee/optee/optee_trace.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * optee trace points
> + *
> + * Copyright (C) 2021 Synaptics Incorporated
> + * Author: Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM optee
> +
> +#if !defined(_TRACE_OPTEE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_OPTEE_H
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/tracepoint.h>
> +#include "optee_private.h"
> +
> +TRACE_EVENT(optee_invoke_fn_begin,
> +	TP_PROTO(struct optee_rpc_param *param),
> +	TP_ARGS(param),
> +
> +	TP_STRUCT__entry(
> +		__field(void *, param)
> +		__array(u32, args, 8)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->param = param;
> +		memcpy(__entry->args, param, sizeof(__entry->args));

I wonder if you should add a:

		BUILD_BUG_ON(sizeof(param) < sizeof(__entry->args));

here.

> +	),
> +
> +	TP_printk("param=%p (%x, %x, %x, %x, %x, %x, %x, %x)", __entry->param,
> +		  __entry->args[0], __entry->args[1], __entry->args[2],
> +		  __entry->args[3], __entry->args[4], __entry->args[5],
> +		  __entry->args[6], __entry->args[7])
> +);
> +
> +TRACE_EVENT(optee_invoke_fn_end,
> +	TP_PROTO(struct optee_rpc_param *param, struct arm_smccc_res *res),
> +	TP_ARGS(param, res),
> +
> +	TP_STRUCT__entry(
> +		__field(void *, param)
> +		__array(unsigned long, rets, 4)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->param = param;
> +		memcpy(__entry->rets, res, sizeof(__entry->rets));

and a:

		BUILD_BUG_ON(sizeof(res) < sizeof(__entry->rets));

here

Just to make sure that the size of what is being copied, is not smaller
than the amount being copied.

-- Steve

> +	),
> +
> +	TP_printk("param=%p ret (%lx, %lx, %lx, %lx)", __entry->param,
> +		  __entry->rets[0], __entry->rets[1], __entry->rets[2],
> +		  __entry->rets[3])
> +);
> +#endif /* _TRACE_OPTEE_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE optee_trace
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

