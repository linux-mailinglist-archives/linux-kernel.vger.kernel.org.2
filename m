Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3456322C17
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhBWOUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:20:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232326AbhBWOUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:20:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 103EE64E58;
        Tue, 23 Feb 2021 14:19:37 +0000 (UTC)
Date:   Tue, 23 Feb 2021 09:19:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Message-ID: <20210223091936.5b390f35@gandalf.local.home>
In-Reply-To: <20210223131124.GA2303918@jade>
References: <20210210144409.36ecdaed@xhacker.debian>
        <CAHUa44E-_czjhRxr2JjggYu0sDCsRvOA3Uc=hqp7j5Cmtb9q0w@mail.gmail.com>
        <20210223184026.22c86356@xhacker.debian>
        <20210223131124.GA2303918@jade>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 14:11:24 +0100
Jens Wiklander <jens.wiklander@linaro.org> wrote:

> I used the -strict option.
> 
> ./scripts/checkpatch.pl -strict 0001-tee-optee-add-invoke_fn-tracepoints.patch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #44: 
> new file mode 100644

The above is just asking for someone to take maintainership of the new file.

> 
> CHECK: Alignment should match open parenthesis
> #68: FILE: drivers/tee/optee/optee_trace.h:20:
> +TRACE_EVENT(optee_invoke_fn_begin,
> +	TP_PROTO(struct optee_rpc_param *param),
> 
> CHECK: Lines should not end with a '('
> #71: FILE: drivers/tee/optee/optee_trace.h:23:
> +	TP_STRUCT__entry(
> 
> CHECK: Lines should not end with a '('
> #76: FILE: drivers/tee/optee/optee_trace.h:28:
> +	TP_fast_assign(
> 
> CHECK: Alignment should match open parenthesis
> #89: FILE: drivers/tee/optee/optee_trace.h:41:
> +TRACE_EVENT(optee_invoke_fn_end,
> +	TP_PROTO(struct optee_rpc_param *param, struct arm_smccc_res *res),
> 
> CHECK: Lines should not end with a '('
> #92: FILE: drivers/tee/optee/optee_trace.h:44:
> +	TP_STRUCT__entry(
> 
> CHECK: Lines should not end with a '('
> #97: FILE: drivers/tee/optee/optee_trace.h:49:
> +	TP_fast_assign(

The TRACE_EVENT() macro is "special", and checkpatch notoriously stumbles
over it. I usually recommend that people ignore the checkpatch warnings on
TRACE_EVENT() macros.

-- Steve


> 
> total: 0 errors, 1 warnings, 6 checks, 86 lines checked

