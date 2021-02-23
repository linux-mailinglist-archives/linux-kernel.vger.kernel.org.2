Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0023A3226BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 09:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhBWIAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 03:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBWIAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 03:00:14 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2784C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:59:33 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id b16so14748368otq.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZyNLjSL1B6qwkY7yL9AfgZbdVB6v/72Ioh+4lurV0s=;
        b=JUYmbOYHkcAy8+cvIRRK9zxSqq+6gCJmpzOC0XY716RSoI9Bp2T1BZPmfPzdpjG5FK
         cgqz+A1qv1Niz0w48pyesI6ZDue9oKjILx4F3hoNIySoZeM7cZIn5PVI+/f6BNdpLGpD
         KtHegHNJLztezNRR3YnMq/fPibdEyLTOgbWOnutH18zyFVKzEVP1sw8HbTJDlapqQEFY
         uKY0YE++Et0NflCn11zWcCCO3vDkeRelDEcuCVWwiW44nDQxqrZVXeYsVMArRwPVe5PJ
         qC9XrFcQHBmDe6g7OeKf8juWaqe4kJ40sChNbBpa+N1ecS2r4itZMbZCI8ZotXniLWOI
         HSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZyNLjSL1B6qwkY7yL9AfgZbdVB6v/72Ioh+4lurV0s=;
        b=WSeKuc3q6mkUHqGgyOUAxP6fD3q6ng2/7mESGfz5T0S2dTDQpjQycc+ztvDBZPVMz8
         aHi+M7yWQkqqT5fcAt1oqcGJ8CqT4Be6+75RFTv6+qgTJpEWlp7jER4ABnwco8418PjK
         dDV7WGkIgsb8VFBfV15MlnzFK52Uw+9xVsKj56QT5bUjl2V+iSPXetsVU+9lLD9v+0cL
         McTttXibhlcW6b5s11K9UdeUH8cFmNJvw5SYnBwCFuXKS1hTr1FnlaHcM5WemxTI5Tgh
         dhFsEJT7IAVlPK29kEq/uwfglgghRWW17t/qdYYdO8wTBoVLdpv8yqOAWql4ocpPx0P9
         13/g==
X-Gm-Message-State: AOAM533DFPhQSSwxe6HtLEmDRkENG8ouuHWU6JRJ6icYQOIRqmrufGGo
        SFj19wV2TMnv3AexJY+9GFvfqcclaKoe70qaQ9wV5Q==
X-Google-Smtp-Source: ABdhPJxmaYSeIY3dD5n/SZsmsJCq6VgcdvhfwCE0tTHG+sBhGKkiM0/uDOQK8h8q1ofhEN4vIuz8rZauPbZv0rD4tc8=
X-Received: by 2002:a05:6830:1352:: with SMTP id r18mr6620863otq.283.1614067173106;
 Mon, 22 Feb 2021 23:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20210210144409.36ecdaed@xhacker.debian>
In-Reply-To: <20210210144409.36ecdaed@xhacker.debian>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 23 Feb 2021 08:59:22 +0100
Message-ID: <CAHUa44E-_czjhRxr2JjggYu0sDCsRvOA3Uc=hqp7j5Cmtb9q0w@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Wed, Feb 10, 2021 at 7:44 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> Add tracepoints to retrieve information about the invoke_fn. This would
> help to measure how many invoke_fn are triggered and how long it takes
> to complete one invoke_fn call.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>
> Since v1:
>  - add BUILD_BUG_ON() macro usage to make sure that the size of what is being
>    copied, is not smaller than the amount being copied. Thank Steve.
>  - move optee_trace.h to keep include headers sorted
>
>  drivers/tee/optee/call.c        |  4 ++
>  drivers/tee/optee/optee_trace.h | 67 +++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 drivers/tee/optee/optee_trace.h
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 780d7c4fd756..0da6fe50f1af 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -14,6 +14,8 @@
>  #include <linux/uaccess.h>
>  #include "optee_private.h"
>  #include "optee_smc.h"
> +#define CREATE_TRACE_POINTS
> +#include "optee_trace.h"
>
>  struct optee_call_waiter {
>         struct list_head list_node;
> @@ -138,9 +140,11 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
>         while (true) {
>                 struct arm_smccc_res res;
>
> +               trace_optee_invoke_fn_begin(&param);
>                 optee->invoke_fn(param.a0, param.a1, param.a2, param.a3,
>                                  param.a4, param.a5, param.a6, param.a7,
>                                  &res);
> +               trace_optee_invoke_fn_end(&param, &res);
>
>                 if (res.a0 == OPTEE_SMC_RETURN_ETHREAD_LIMIT) {
>                         /*
> diff --git a/drivers/tee/optee/optee_trace.h b/drivers/tee/optee/optee_trace.h
> new file mode 100644
> index 000000000000..7c954eefa4bf
> --- /dev/null
> +++ b/drivers/tee/optee/optee_trace.h
> @@ -0,0 +1,67 @@
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

Checkpatch has some complaints below. Is that something that could be
fixed or is this so far from regular C-syntax that we don't care?

Thanks,
Jens

> +TRACE_EVENT(optee_invoke_fn_begin,
> +       TP_PROTO(struct optee_rpc_param *param),
> +       TP_ARGS(param),
> +
> +       TP_STRUCT__entry(
> +               __field(void *, param)
> +               __array(u32, args, 8)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->param = param;
> +               BUILD_BUG_ON(sizeof(*param) < sizeof(__entry->args));
> +               memcpy(__entry->args, param, sizeof(__entry->args));
> +       ),
> +
> +       TP_printk("param=%p (%x, %x, %x, %x, %x, %x, %x, %x)", __entry->param,
> +                 __entry->args[0], __entry->args[1], __entry->args[2],
> +                 __entry->args[3], __entry->args[4], __entry->args[5],
> +                 __entry->args[6], __entry->args[7])
> +);
> +
> +TRACE_EVENT(optee_invoke_fn_end,
> +       TP_PROTO(struct optee_rpc_param *param, struct arm_smccc_res *res),
> +       TP_ARGS(param, res),
> +
> +       TP_STRUCT__entry(
> +               __field(void *, param)
> +               __array(unsigned long, rets, 4)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->param = param;
> +               BUILD_BUG_ON(sizeof(*res) < sizeof(__entry->rets));
> +               memcpy(__entry->rets, res, sizeof(__entry->rets));
> +       ),
> +
> +       TP_printk("param=%p ret (%lx, %lx, %lx, %lx)", __entry->param,
> +                 __entry->rets[0], __entry->rets[1], __entry->rets[2],
> +                 __entry->rets[3])
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
> --
> 2.30.0
>
