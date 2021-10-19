Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7294331EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbhJSJOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231652AbhJSJOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:14:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D87560ED5;
        Tue, 19 Oct 2021 09:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634634748;
        bh=4Y54qAG6SRXNvYiZ1LcJOiHDloI0SXwfRzo3IjO3mVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ijSLT+QR1DpZHv68nkYmfDqx6EE/62lPKZ5RnrVfbCmfw2UY8er4UWQUcmB1OwwHL
         21KgwMiL7vG2ibKtz0CmwybzmlsEPY4nZwft4dMWA6GWfniAE6ZuAy22+QnqU5tHMT
         ZY22siodxD1jQHLazru6Sg5JLm5OexZ06Jn8wDrQ=
Date:   Tue, 19 Oct 2021 11:12:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Ran Jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH binder] binder: remove duplicate include in binder.c
Message-ID: <YW6L+LkxamhGLwmt@kroah.com>
References: <20211019080402.993974-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019080402.993974-1-ran.jianping@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 08:04:02AM +0000, cgel.zte@gmail.com wrote:
> From: Ran Jianping <ran.jianping@zte.com.cn>
> 
> 'binder_trace.h' included in 'drivers/android/binder.c'
>  is duplicated.It is also included on the 6026 line.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ran Jianping <ran.jianping@zte.com.cn>
> ---
>  drivers/android/binder.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 26382e982c5e..19f6247d33f5 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -6023,6 +6023,5 @@ static int __init binder_init(void)
>  device_initcall(binder_init);
>  
>  #define CREATE_TRACE_POINTS
> -#include "binder_trace.h"
>  
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.25.1
> 

Did you build this code after making this change and verify that the
tracepoints still work properly?

Please fix your "robot", it is broken.

greg k-h
