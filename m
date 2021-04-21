Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7A03663DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 05:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhDUDCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 23:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbhDUDCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 23:02:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362A5C06174A;
        Tue, 20 Apr 2021 20:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=WI/aItqK+8dg9dEzYrDYvW0KyLS3FBK0v7uvxZbEckI=; b=vljXIHKSG4ovLgfwvgJluhwkj8
        ZMs/8FXbZwif5NfB39K3+jFo2XlXLVvdhBR9ANArg+oQmZg/1j/mjsKkWLYPs2APqLgFJrmO0U/Oy
        keaSFLpLAq94aLenz4krpzob9RsKVbjL/5f3hJa74+1wF6fKsLkWn3sZM/QkpN2JobKy+MqnGySCo
        XKvAp0GL2WUh1Z4s/i6IeU1x0CdLYZvQdeawUJlnz0w46IvOnILaRrOUNwbMkF38D1Oyyg/bxXfPd
        mTtZuORwYbaA5olAW8KiUtdkBl4ChWw6ht/oDBwXMN233I3zwR3KeM4uDDFI6esEnlKhjKEnPhwwF
        9Z5o+sZQ==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZ37B-00FyZb-VE; Wed, 21 Apr 2021 03:01:26 +0000
Subject: Re: [PATCH 2/2] csky: add CONFIG_CPU_HAS_MATHEMU and use in traps
To:     Wang Junqiang <wangjunqiang@iscas.ac.cn>, guoren@kernel.org
Cc:     guoren@linux.alibaba.com, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Weiwei <liweiwei@iscas.ac.cn>
References: <20210421024916.13603-1-wangjunqiang@iscas.ac.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8bb2a70f-7f3a-26f1-98ed-e6b7b2220798@infradead.org>
Date:   Tue, 20 Apr 2021 20:01:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210421024916.13603-1-wangjunqiang@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/20/21 7:49 PM, Wang Junqiang wrote:
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 34e91224adc3..a414225570c1 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -97,6 +97,9 @@ config CPU_HAS_CACHEV2
>  config CPU_HAS_FPUV2
>  	bool
>  
> +config CPU_HAS_MATHEMU
> +	bool
> +

Why do you have this new kconfig symbol two times in the same file?

>  config CPU_HAS_HILO
>  	bool
>  
> @@ -281,6 +284,11 @@ config CPU_HAS_VDSP
>  	bool "CPU has VDSP coprocessor"
>  	depends on CPU_HAS_FPU && CPU_HAS_FPUV2
>  
> +config CPU_HAS_MATHEMU
> +	bool "CPU has FPU Mathemu Instructions"
> +	depends on CPU_CK810 || CPU_CK860
> +	default n
> +
>  config CPU_HAS_FPU
>  	bool "CPU has FPU coprocessor"
>  	depends on CPU_CK807 || CPU_CK810 || CPU_CK860


thanks.
-- 
~Randy

