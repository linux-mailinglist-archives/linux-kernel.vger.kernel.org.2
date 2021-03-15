Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE11033A91B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 01:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCOAiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 20:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhCOAhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 20:37:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A1FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 17:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=38vnoiIBOpESzfxEzG3nj/BXtJ6NAK+uvQW+9Jymr90=; b=o7dJPAxQEyNHYvJBMVEFxYCZvt
        GlzMmNEll8MvN8KC1a8KTY4xWLe+5Q4BtB8mhTtudk6UhN8y7NGPpb9hpQnmiyeglrtWzHO8kvhHS
        HN0xE2UmQmrWr4TRCf77Fkg79Mrp/ANzfsabi/8dp1Df+c81a6F7Pl372Pb+wQpVe321q5t9Ykcys
        xPHO0/4+emwlb8X2Uk0OHLfBobaP7ZqoC8nwa79bRF0SdyyJaYKWfRbueCdWr1+0r37c3ckbNMLrj
        hr6ukL2KFqetU3oJhMFN2WGFIM9f4rH1PRs0C8TI2y+agX7kXzj0pAtIR9Zo3VAR4iTuY/1svVzOZ
        l1NflJ8Q==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLbEs-001F1y-GK; Mon, 15 Mar 2021 00:37:42 +0000
Subject: Re: [PATCH] powerpc: kernel: Trivial spelling fixes throughout the
 file head_fsl_booke.S
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        akpm@linux-foundation.org, rppt@kernel.org, oss@buserror.net,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210314220436.3417083-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f8dc3cbe-54f4-1da1-b14f-4735d28aad13@infradead.org>
Date:   Sun, 14 Mar 2021 17:37:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314220436.3417083-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/21 3:04 PM, Bhaskar Chowdhury wrote:
> 
> Trivial spelling fixes throughout the file.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/powerpc/kernel/head_fsl_booke.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> index fdd4d274c245..c6fcfca0b0d7 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -403,7 +403,7 @@ interrupt_base:
>  	EXCEPTION(0x2900, AP_UNAVAIL, AuxillaryProcessorUnavailable, \
>  		  unknown_exception, EXC_XFER_STD)
> 
> -	/* Decrementer Interrupt */
> +	/* Decremented Interrupt */

No, the comment matches the macro (or whatever that is).

>  	DECREMENTER_EXCEPTION
> 
>  	/* Fixed Internal Timer Interrupt */


-- 
~Randy

