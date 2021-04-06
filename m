Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1217435548C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbhDFNGp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Apr 2021 09:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232492AbhDFNGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:06:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD27B613A3;
        Tue,  6 Apr 2021 13:06:34 +0000 (UTC)
Date:   Tue, 6 Apr 2021 09:06:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhang Jianhua <zhangjianhua18@huawei.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <johnny.chenyi@huawei.com>, <heying24@huawei.com>
Subject: Re: [PATCH -next] arm: patch: FUNCTION_GRAPH_TRACER depends on
 CPU_ENDIAN_BE8 or !CPU_ENDIAN_BE32
Message-ID: <20210406090633.224f2921@gandalf.local.home>
In-Reply-To: <20210406102351.64028-1-zhangjianhua18@huawei.com>
References: <20210406102351.64028-1-zhangjianhua18@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2021 18:23:51 +0800
Zhang Jianhua <zhangjianhua18@huawei.com> wrote:

> If CONFIG_FUNCTION_GRAPH_TRACER=y, the following errors will be seen
> while compiling patch.c
> 
> arch/arm/kernel/patch.c: In function ‘__patch_text_real’:
> arch/arm/kernel/patch.c:94:11: error: implicit declaration of function
> ‘__opcode_to_mem_thumb32’; did you mean ‘__opcode_to_mem_thumb16’?
> [-Werror=implicit-function-declaration]
>     insn = __opcode_to_mem_thumb32(insn);
>            ^~~~~~~~~~~~~~~~~~~~~~~
>            __opcode_to_mem_thumb16
> 
> Signed-off-by: Zhang Jianhua <zhangjianhua18@huawei.com>
> ---
>  kernel/trace/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 7fa82778c3e6..fbf5fd80f105 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -177,6 +177,7 @@ config FUNCTION_GRAPH_TRACER
>  	depends on HAVE_FUNCTION_GRAPH_TRACER
>  	depends on FUNCTION_TRACER
>  	depends on !X86_32 || !CC_OPTIMIZE_FOR_SIZE
> +	depends on CPU_ENDIAN_BE8 || !CPU_ENDIAN_BE32

Doesn't this break 32 bit big endian powerpc?

Not to mention, my config doesn't have either of those.

NACK

-- Steve

>  	default y
>  	help
>  	  Enable the kernel to trace a function at both its return

