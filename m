Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC863DDC44
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbhHBPW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:22:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:40341 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234995AbhHBPW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:22:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="211605926"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="211605926"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 08:22:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="419348696"
Received: from nradovan-mobl.amr.corp.intel.com (HELO [10.212.45.122]) ([10.212.45.122])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 08:22:47 -0700
Subject: Re: [PATCH] x86/asm: fix gcc-5 enqcmds() build failure
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
References: <20210802145356.1154321-1-arnd@kernel.org>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <196808b0-fa78-eab4-d68b-45bded788f86@intel.com>
Date:   Mon, 2 Aug 2021 08:22:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210802145356.1154321-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/2/2021 7:53 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Building drivers/dma/idxd/submit.o with gcc-5.5 results in a cryptic
> error messages:
>
> arch/x86/include/asm/special_insns.h: Assembler messages:
> arch/x86/include/asm/special_insns.h:286: Error: operand size mismatch for `setz'
> make[5]: *** [scripts/Makefile.build:272: drivers/dma/idxd/submit.o] Error 1
>
> It seems that this happens for 32-bit arguments when the instruction
> expects an 8-bit argument. Change the type of the local variable
> accordingly to get a clean build.
>
> Fixes: 7f5933f81bd8 ("x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction")
> Fixes: 8e50d392652f ("dmaengine: idxd: Add shared workqueue support") # guessed
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Dave Jiang <dave.jiang@intel.com>

Thanks!

> ---
>   arch/x86/include/asm/special_insns.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index f3fbb84ff8a7..33264839f99e 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -275,7 +275,7 @@ static inline int enqcmds(void __iomem *dst, const void *src)
>   {
>   	const struct { char _[64]; } *__src = src;
>   	struct { char _[64]; } __iomem *__dst = dst;
> -	int zf;
> +	u8 zf;
>   
>   	/*
>   	 * ENQCMDS %(rdx), rax
