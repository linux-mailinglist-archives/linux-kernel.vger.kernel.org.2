Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC7E4164A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbhIWRvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239489AbhIWRvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:51:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82893C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:49:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id DA8B81F411C5
Subject: Re: [PATCH] x86/fpu/signal: save_xstate_epilog: fix return polarity
To:     Anders Roxell <anders.roxell@linaro.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Remi Duraffort <remi.duraffort@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        andrew.cooper3@citrix.com,
        "kernelci-results@groups.io" <kernelci-results@groups.io>
References: <20210922200901.1823741-1-anders.roxell@linaro.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <2b9a6fd8-0e54-059c-aeb1-c08cb2b8804d@collabora.com>
Date:   Thu, 23 Sep 2021 18:49:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210922200901.1823741-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2021 21:09, Anders Roxell wrote:
> Fix the missing return code polarity in function 'save_xstate_epilog()'.
> 
> Reported-by: Remi Duraffort <remi.duraffort@linaro.org>
> Fixes: a2a8fd9a3efd ("x86/fpu/signal: Change return code of restore_fpregs_from_user() to boolean")
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1461
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> Cc: andrew.cooper3@citrix.com
> ---
>  arch/x86/kernel/fpu/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 68f03da2012e..39c7bae97daf 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -106,7 +106,7 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame)
>  	err = __copy_to_user(&x->i387.sw_reserved, sw_bytes, sizeof(*sw_bytes));
>  
>  	if (!use_xsave())
> -		return err;
> +		return !err;
>  
>  	err |= __put_user(FP_XSTATE_MAGIC2,
>  			  (__u32 __user *)(buf + fpu_user_xstate_size));
> 

This patch has probably been applied already, but since the issue
got bisected and then the fix was verified by KernelCI:

Tested-by: "kernelci.org bot" <bot@kernelci.org>


For the record, see more details about it here:

  https://github.com/kernelci/kernelci-project/issues/53

Best wishes,
Guillaume
