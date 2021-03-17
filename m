Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A630433F739
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhCQRi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhCQRiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:38:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE5AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=8BWN60n1BMZenVNSXOAhYopOXZLzcn6RzVKWX/dELqA=; b=CNIsvx9FxAVz++2JiA94yDZCkC
        20MDGYa8kUmRvAymYfeIv8OvzWNYxG3LqaXIHKYKcU8No7B/8c7ThO0U4RLWIqVsM7lFW5zvjuENC
        8N3VAVmyjOhAscI/SQMV80fRwEjDpWtGIp6T1Yf/goI4xOZn8ENZ3sWbH/z/zuIk4vMM8ulQR4lwD
        rODkZfH/12c9I6pYR1bOGl5nvN8Ze+ABUBVVvdgNWiWw3AY1lGwFvzWpJdGQmmStwS+NqQmG0w2Kh
        8DvtCRTfX1RD0l4AoHer8Vk9rDNwL+rpbay7b1sUJ2WZFmcFB81dE6D3PZ4e9Tar3mlAG7xzg3BtD
        3EZxHwlA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMa7Q-001fY3-8z; Wed, 17 Mar 2021 17:38:04 +0000
Subject: Re: [PATCH] xtensa: kernel: Fix typo in the file vectors.S
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, chris@zankel.net,
        jcmvbkbc@gmail.com, akpm@linux-foundation.org, rppt@kernel.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
References: <20210317082758.3785266-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ad1a8d60-3583-a003-9aee-ed21294855e7@infradead.org>
Date:   Wed, 17 Mar 2021 10:37:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317082758.3785266-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 1:27 AM, Bhaskar Chowdhury wrote:
> 
> s/markt/mark/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/xtensa/kernel/vectors.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/xtensa/kernel/vectors.S b/arch/xtensa/kernel/vectors.S
> index 1a7538ccfc5a..bb4243de8ba3 100644
> --- a/arch/xtensa/kernel/vectors.S
> +++ b/arch/xtensa/kernel/vectors.S
> @@ -202,7 +202,7 @@ ENDPROC(_KernelExceptionVector)
>   * See the handle_alloca_user and spill_registers routines for example clients.
>   *
>   * FIXME: Note: we currently don't allow signal handling coming from a double
> - *        exception, so the item markt with (*) is not required.

                                    marked


> + *        exception, so the item mark with (*) is not required.
>   */
> 
>  	.section .DoubleExceptionVector.text, "ax"
> --


-- 
~Randy

