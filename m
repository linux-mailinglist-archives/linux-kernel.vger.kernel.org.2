Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC430E004
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhBCQtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhBCQts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:49:48 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77030C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 08:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=c6zsAXxZpKAibMmUVfNq6iDfAguQAcSqE6ETGE+J7ME=; b=D3VUDcGjewtPHddgVl2KZVnBur
        /wcJ3WPtftGlxXD+FaeSh3sY7/F5jrrTENy0HQ7+5ms6RkR1vov335X1ItoIpr7k6NRJHPHHYfS9K
        wNdUwSbpICOexksWX91yqCb4aqZ0vD1AR+dyt2dUYFrGKd4rG0v8gQBEDJkuC65ATDikJwaAwUyCG
        xG85pUYdU4v3Oab6x6p5xRv4vdXZJKFEKGLI44qL2mC4Rnw/5MHmy+goZTTWurL/uyfasW0d7szUX
        eN0kgLDOPTrUvNPf0+LYpaL65u3/+Jk3rExeMExfe6BjSVfwac6KHD5+6foFNzN0XoIcjj3EhL2US
        nnArgKrw==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7LKz-0003GR-Om; Wed, 03 Feb 2021 16:49:06 +0000
Subject: Re: [PATCH] arch: x86: kernel: Mundane spelling fixes throughout the
 file apm_32.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, jikos@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20210203144837.30246-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8ee5a8bf-d9dd-d756-0522-abef96f1b062@infradead.org>
Date:   Wed, 3 Feb 2021 08:49:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210203144837.30246-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 6:48 AM, Bhaskar Chowdhury wrote:
> 
> s/messges/messages/
> s/powermanagement/power management/
> s/secodnds/seconds/
> s/powerdown/poer down/
> 
> Capitalize and truncate space in start of the sentence.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/x86/kernel/apm_32.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
> index 660270359d39..04204e01ff7c 100644
> --- a/arch/x86/kernel/apm_32.c
> +++ b/arch/x86/kernel/apm_32.c
> @@ -2366,7 +2366,7 @@ static int __init apm_init(void)
>  	/*
>  	 * Note we don't actually care if the misc_device cannot be registered.
>  	 * this driver can do its job without it, even if userspace can't
> -	 * control it.  just log the error
> +	 * control it.Just log the error

missing space and period:

	 * control it. Just log the error.

The rest of the changes look good.

Thanks.

>  	 */
>  	if (misc_register(&apm_device))
>  		printk(KERN_WARNING "apm: Could not register misc device.\n");
> --
> 2.26.2
> 


-- 
~Randy

