Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78B93D265A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhGVOVr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jul 2021 10:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbhGVOVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 10:21:45 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DA5A6128C;
        Thu, 22 Jul 2021 15:02:19 +0000 (UTC)
Date:   Thu, 22 Jul 2021 11:02:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhang Jianhua <chris.zjh@huawei.com>
Cc:     <corbet@lwn.net>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH -next] trace doc: Fix the wrong example of tracepoint
Message-ID: <20210722110212.05ec6ee3@oasis.local.home>
In-Reply-To: <20210720020607.4128715-1-chris.zjh@huawei.com>
References: <20210720020607.4128715-1-chris.zjh@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2021 10:06:07 +0800
Zhang Jianhua <chris.zjh@huawei.com> wrote:

> The example in tracepoints.rst is out of date, the build error below
> will occur if coding according to example in the document.
> 
> drivers/irqchip/irq-riscv-intc.c:24:24:
> error: macro "DEFINE_TRACE" requires 3 arguments, but only 1 given
>    24 | DEFINE_TRACE(test_event);
>       |                        ^
> In file included from include/trace/events/test.h:8,
> from drivers/irqchip/irq-riscv-intc.c:22:
> include/linux/tracepoint.h:368:
> note: macro "DEFINE_TRACE" defined here
>   368 | #define DEFINE_TRACE(name, proto, args)
>       |
> drivers/irqchip/irq-riscv-intc.c:24:1:
> warning: data definition has no type or storage class
>    24 | DEFINE_TRACE(test_event);
>       | ^~~~~~~~~~~~
> drivers/irqchip/irq-riscv-intc.c:24:1:
> error: type defaults to ‘int’ in declaration of ‘DEFINE_TRACE’
> [-Werror=implicit-int]
> 
> There are two reasons for this error. On the one hand, the macro DEFINE_TRACE
> has been refactored in commit d25e37d89dd2 ("tracepoint: Optimize using
> static_call()") from DEFINE_TRACE(name) to DEFINE_TRACE(name, proto, args),
> and the doc is not updated in time. On the other hand, the tracepoint has been
> defined in header file, and it does not need to define repeatedly in C file.

Actually, the above is not quite correct.

By removing DEFINE_TRACE() you just removed the tracepoint entirely,
making it non-existent. This is a very old document and probably has a
lot more wrong with it than just this.

But for this case, you probably want it to read:

        #define CREATE_TRACE_POINTS

        #include <trace/events/subsys.h>

Otherwise the tracepoint is never created.

-- Steve


> 
> --------
> 
> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
> ---
>  Documentation/trace/tracepoints.rst | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/trace/tracepoints.rst b/Documentation/trace/tracepoints.rst
> index 0cb8d9ca3d60..fbb2cb4abd3d 100644
> --- a/Documentation/trace/tracepoints.rst
> +++ b/Documentation/trace/tracepoints.rst
> @@ -66,7 +66,6 @@ In subsys/file.c (where the tracing statement must be added)::
>  	#include <trace/events/subsys.h>
>  
>  	#define CREATE_TRACE_POINTS
> -	DEFINE_TRACE(subsys_eventname);
>  
>  	void somefct(void)
>  	{

