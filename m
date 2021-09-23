Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E654415D14
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbhIWLxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240696AbhIWLxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:53:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF15D60F41;
        Thu, 23 Sep 2021 11:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632397905;
        bh=tooeYk5RF2FZT1/J+XN4o/HkjCQqxRJOx2tzuHtPtyA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UEd07lA33a3FY2Hydpi/N8LHwzb1uKolaDQ/FCl6JgcLA3TnL3UGwBwfaDjbYoY7R
         71F5pG01B44Ha/093FQuTJrxk1BRsJzh5FBlY1sjCJOG+e7yBRJniwzCfpod61dsfV
         Nxcn7Ig/eaLR7g/ZbQDj7YFm1atVEoa/oWMTqRBCFhm0enlVqEf/qT14/cE8arNcPf
         GfJc71agPsmlRBmFAzYLVVTmiNfeGu8BVmuGD6kzot10OkHL1Z1zHjTjQQaqFAPSeZ
         huBqoqS6vzlDMpXBp4QT1jW4VWE3XIqcPveUAl88wrUyVIsddJRHbWlnqO/Ljd20pi
         LJCSb2PZvvPQA==
Date:   Thu, 23 Sep 2021 20:51:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ismael Luceno <ismael@iodev.co.uk>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] uapi: Fix undefined __always_inline on non-glibc
 systems
Message-Id: <20210923205142.a0f872407b97466d3d028cd9@kernel.org>
In-Reply-To: <20210923005706.1368-1-ismael@iodev.co.uk>
References: <20210923005706.1368-1-ismael@iodev.co.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 02:57:06 +0200
Ismael Luceno <ismael@iodev.co.uk> wrote:

> This macro is defined by glibc itself, which makes the issue go unnoticed on
> those systems.  On non-glibc systems it causes build failures on several
> utilities and libraries, like bpftool and objtool.

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Fixes: 1d509f2a6ebc ("x86/insn: Support big endian cross-compiles")
> Fixes: 2d7ce0e8a704 ("tools/virtio: more stubs")
> Fixes: 3fb321fde22d ("selftests/net: ipv6 flowlabel")
> Fixes: 50b3ed57dee9 ("selftests/bpf: test bpf flow dissection")
> Fixes: 9cacf81f8161 ("bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE")
> Fixes: a4b2061242ec ("tools include uapi: Grab a copy of linux/in.h")
> Fixes: b12d6ec09730 ("bpf: btf: add btf print functionality")
> Fixes: c0dd967818a2 ("tools, include: Grab a copy of linux/erspan.h")
> Fixes: c4b6014e8bb0 ("tools: Add copy of perf_event.h to tools/include/linux/")
> 
> Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
> ---
>  include/uapi/linux/byteorder/big_endian.h    | 1 +
>  include/uapi/linux/byteorder/little_endian.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/byteorder/big_endian.h b/include/uapi/linux/byteorder/big_endian.h
> index 2199adc6a6c2..80aa5c41a763 100644
> --- a/include/uapi/linux/byteorder/big_endian.h
> +++ b/include/uapi/linux/byteorder/big_endian.h
> @@ -9,6 +9,7 @@ #define __BIG_ENDIAN 4321
>  #define __BIG_ENDIAN_BITFIELD
>  #endif
>  
> +#include <linux/stddef.h>
>  #include <linux/types.h>
>  #include <linux/swab.h>
>  
> diff --git a/include/uapi/linux/byteorder/little_endian.h b/include/uapi/linux/byteorder/little_endian.h
> index 601c904fd5cd..cd98982e7523 100644
> --- a/include/uapi/linux/byteorder/little_endian.h
> +++ b/include/uapi/linux/byteorder/little_endian.h
> @@ -9,6 +9,7 @@ #define __LITTLE_ENDIAN 1234
>  #define __LITTLE_ENDIAN_BITFIELD
>  #endif
>  
> +#include <linux/stddef.h>
>  #include <linux/types.h>
>  #include <linux/swab.h>
>  
> -- 
> 2.33.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
