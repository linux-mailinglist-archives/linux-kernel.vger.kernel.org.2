Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5903934F2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhC3VUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhC3VUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:20:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E73DC061574;
        Tue, 30 Mar 2021 14:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=nGIouhZDUCYWUhXG6ttkQe/9Kl8gmJMxUxdH8264KVo=; b=rhrp1SxlUOXQVkBAatku9ZeQaD
        UF7YnSaF5xAgKOeSuK03fVKOS3StQ5eGvKvheN3brOwjXzEYNGgEpLsRIsOurmCTqo3dje9wSy0NI
        q3LKxPFfgggmOjSISRMiCEt/KF0cnXWk33H3943IIa9oKpd/ZIZzgJicrv8hvEqsJcEBeH7fh4qxl
        Oth16IXUdRaoIn8MHuYfEb8U8oSjxkhMVtA9NezZSbOxeJe6oRoqlHHS5sDPpxLCUHQzsEEmLbAWz
        cJ0oRedqRswhSdGxEaVeHkvOzSMnU5KfhlKQO0ArFR7NQL16M7wvwW0vJ8gS5cm5xiYqXYlJUYV1G
        As213jUg==;
Received: from [2601:1c0:6280:3f0::4557]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRLmZ-003ckU-Qs; Tue, 30 Mar 2021 21:20:19 +0000
Subject: Re: [PATCH] x86/sgx: fix incorrect kernel-doc comment syntax in files
To:     Aditya Srivastava <yashsri421@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, jarkko@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-sgx@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
References: <20210330211813.28030-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2449c5b6-852f-4e8e-6d71-3308938b12e0@infradead.org>
Date:   Tue, 30 Mar 2021 14:20:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330211813.28030-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/21 2:18 PM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> There are certain files in arch/x86/kernel/cpu/sgx, which follow this
> syntax, but the content inside does not comply with kernel-doc.
> Such lines were probably not meant for kernel-doc parsing, but are parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warnings from kernel-doc.
> 
> E.g., presence of kernel-doc like comment in the header lines for
> arch/x86/kernel/cpu/sgx/encl.h causes this warning:
> "warning: expecting prototype for 2016(). Prototype was for _X86_ENCL_H() instead"
> 
> Similarly for arch/x86/kernel/cpu/sgx/arch.h too.
> 
> Provide a simple fix by replacing these occurrences with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> * Applies perfectly on next-20210326
> 
>  arch/x86/kernel/cpu/sgx/arch.h | 2 +-
>  arch/x86/kernel/cpu/sgx/encl.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/arch.h b/arch/x86/kernel/cpu/sgx/arch.h
> index 26315bea1cb4..70b84bbdaa1d 100644
> --- a/arch/x86/kernel/cpu/sgx/arch.h
> +++ b/arch/x86/kernel/cpu/sgx/arch.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/**
> +/*
>   * Copyright(c) 2016-20 Intel Corporation.
>   *
>   * Contains data structures defined by the SGX architecture.  Data structures
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index d8d30ccbef4c..76b9bc1c5c30 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/**
> +/*
>   * Copyright(c) 2016-20 Intel Corporation.
>   *
>   * Contains the software defined data structures for enclaves.
> 


-- 
~Randy

