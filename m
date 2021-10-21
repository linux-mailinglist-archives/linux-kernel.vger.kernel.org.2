Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACBA436D40
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 00:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhJUWLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 18:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhJUWLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 18:11:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 830B561354;
        Thu, 21 Oct 2021 22:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634854156;
        bh=f2xp7La1dpqIPm1JUYKJqOD2M46JtuC20QBPtaH0jNU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fpLYMiUzRz3DMAsQMeSUFjh4wZT/bigxbjLJbm0zNDfLB2mxZNU/NeWCOQ8S2fDSd
         0JrRDiwmiqrQN6YIjCQp2c3v/+7RUo4jzwpBcfMbD+f46rfvqZgUgQ/d97QSEeG97f
         X/DUqMl8OYe2+0NmxTSrItXqqXD5rI0Lqd5VOUxPj9/dcLLrDFUlAhFxby7n4MO8jT
         ev1sYsBscrHuYhv3dmZI2CQqCYkd+LjLGogczCFd1/xUm7uU3UU3EAgJ6ZlruanJa+
         yN3yO04XvCcCEWCA1qV0fD3f9Ggndj17TxgNsbsQuMWeKbG/qyJOxC1Pv8zMFAUsxd
         zH1/Bmf7FlvqQ==
Subject: Re: [PATCH v3] nios2: Make NIOS2_DTB_SOURCE_BOOL depend on
 !COMPILE_TEST
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
References: <20211021143315.3139952-1-linux@roeck-us.net>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <c89e23d6-b56c-1c69-287e-18d8c890f539@kernel.org>
Date:   Thu, 21 Oct 2021 17:09:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021143315.3139952-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/21 9:33 AM, Guenter Roeck wrote:
> nios2:allmodconfig builds fail with
> 
> make[1]: *** No rule to make target 'arch/nios2/boot/dts/""',
> 	needed by 'arch/nios2/boot/dts/built-in.a'.  Stop.
> make: [Makefile:1868: arch/nios2/boot/dts] Error 2 (ignored)
> 
> This is seen with compile tests since those enable NIOS2_DTB_SOURCE_BOOL,
> which in turn enables NIOS2_DTB_SOURCE. This causes the build error
> because the default value for NIOS2_DTB_SOURCE is an empty string.
> Disable NIOS2_DTB_SOURCE_BOOL for compile tests to avoid the error.
> 
> Fixes: 2fc8483fdcde ("nios2: Build infrastructure")
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: Added Fixes: and Reviewed-by: tags
> v2: Add build error message to commit description
> 
>   arch/nios2/platform/Kconfig.platform | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/nios2/platform/Kconfig.platform b/arch/nios2/platform/Kconfig.platform
> index 9e32fb7f3d4c..e849daff6fd1 100644
> --- a/arch/nios2/platform/Kconfig.platform
> +++ b/arch/nios2/platform/Kconfig.platform
> @@ -37,6 +37,7 @@ config NIOS2_DTB_PHYS_ADDR
>   
>   config NIOS2_DTB_SOURCE_BOOL
>   	bool "Compile and link device tree into kernel image"
> +	depends on !COMPILE_TEST
>   	help
>   	  This allows you to specify a dts (device tree source) file
>   	  which will be compiled and linked into the kernel image.
> 

Applied!

Thanks,
Dinh
