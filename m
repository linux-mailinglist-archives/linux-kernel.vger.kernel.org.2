Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4EB43546D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 22:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJTUSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 16:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJTUSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 16:18:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAB3C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Yw3jn3CYgr9CBgXf3ycDMXRpVL6MwJA2O+a8isTBzbE=; b=1s6k4BOTXFEgLTs62Oo7up9dzI
        vsxZOrCMMFQYkt6pUGPMv+DnHJ3ns+R6vH7mCpM7X+jGLYgqgygmopxKSuy5MZXElFsh+wPyUf6xr
        F1N2gwDd9x4GajU9hSAyX22Q0whyuJRmwHViICG5yO8ATcaPW+6tHHE9ABUI9sLEhGyGPgr1BOfLT
        QSwmRr/WVSzteu/m68k0eGEhWaXmEmYiv1C0tHW+lhjQXmmdwKZ9cT0iSteQcxSHCOqa/5yriOrno
        oufF0jY+ynPzfTUVL91hjHVj9ARUYzzzzYlRBQQqPxAYpQg3dugK2lBxC65ksVcKTH1f5d+cyMxHx
        6DCpJayg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdI03-005kxt-8f; Wed, 20 Oct 2021 20:15:47 +0000
Subject: Re: [PATCH v2] nios2: Make NIOS2_DTB_SOURCE_BOOL depend on
 !COMPILE_TEST
To:     Guenter Roeck <linux@roeck-us.net>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20211020191116.2510450-1-linux@roeck-us.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4b747abf-73f1-fa97-cb2b-23d8c838426e@infradead.org>
Date:   Wed, 20 Oct 2021 13:15:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211020191116.2510450-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 12:11 PM, Guenter Roeck wrote:
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
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks, I've seen this problem also.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> v2: Include error message
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


-- 
~Randy
