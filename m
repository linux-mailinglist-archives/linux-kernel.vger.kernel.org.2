Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A0D456E41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhKSLgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:36:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:32952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231271AbhKSLgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:36:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3904D61AFF;
        Fri, 19 Nov 2021 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637321591;
        bh=hwJY9CHZDCQslh/+zp3ti/I7l4cCpXqIEjeEE1u1cuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cc6qzPmY7Fw9e9O+rgNp+469oBOORKNE7rsCS940JH1SUCANJoa6gZVVwiz+qUHuB
         +maa+B4re4e+AUypzXhb35Fm1H8aE6EW70G1TuS9CkcBETXv0lMbVUhJck/PKzCwQn
         Jr3ShgU5jjmuWx55EbFjeWXiwu6aEb1Lf5D7km6nR3jwKBorWtVAAcjiWDltWD4u9e
         XshLklylaROkxZdViyBccbr2uzAwGYVuVdL5yvPVLq4phq+Z+I90Z4Zi9YBHiuYpJf
         F2XX2pppyGmeovSmAbxfoolyBVVjbTMILzxHQWKt2GjpqNY4fkhP6IsdaECJzb0SUb
         pvJaO4Cnw4o7Q==
Date:   Fri, 19 Nov 2021 11:33:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, kernel@axis.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: uaccess: fix put_user() with TTBR0 PAN
Message-ID: <20211119113306.GA13292@willie-the-truck>
References: <20211118163417.21617-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118163417.21617-1-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 05:34:17PM +0100, Vincent Whitchurch wrote:
> The value argument to put_user() must be evaluated before the TTBR0
> switch is done.  Otherwise, if it is a function and the function sleeps,
> the reserved TTBR0 will be restored when the process is switched in
> again and the process will end up in an infinite loop of faults.
> 
> This problem was seen with the put_user() in schedule_tail().  A similar
> fix was done for RISC-V in commit 285a76bb2cf51b0c74c634 ("riscv:
> evaluate put_user() arg before enabling user access").
> 
> Fixes: f253d827f33cb5a5990 ("arm64: uaccess: refactor __{get,put}_user")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  arch/arm64/include/asm/uaccess.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 6e2e0b7031ab..96b26fa9d3d0 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -362,10 +362,11 @@ do {									\
>  #define __put_user_error(x, ptr, err)					\
>  do {									\
>  	__typeof__(*(ptr)) __user *__p = (ptr);				\
> +	__typeof__(*(__p)) __val = (x);					\
>  	might_fault();							\
>  	if (access_ok(__p, sizeof(*__p))) {				\
>  		__p = uaccess_mask_ptr(__p);				\
> -		__raw_put_user((x), __p, (err));			\
> +		__raw_put_user(__val, __p, (err));			\
>  	} else	{							\
>  		(err) = -EFAULT;					\
>  	}								\


Oh, nice spot! I hope you didn't lose too much time debugging if you
actually ran into this...

Although it seems a lot less likely to cause a problem, should we do
something similar for __get_user_error() and assign to (x) outside of
the uaccess-disabled section?

Will
