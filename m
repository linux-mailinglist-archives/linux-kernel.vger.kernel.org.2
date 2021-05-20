Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3943138B3E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhETQCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:02:10 -0400
Received: from foss.arm.com ([217.140.110.172]:54638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233386AbhETQCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:02:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46DCF31B;
        Thu, 20 May 2021 09:00:40 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.7.235])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91C573F73B;
        Thu, 20 May 2021 09:00:38 -0700 (PDT)
Date:   Thu, 20 May 2021 17:00:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Derrick McKee <derrick.mckee@gmail.com>
Cc:     Nathan.Burow@ll.mit.edu, Yianni Giannaris <yiannig@mit.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Ensure kernel AI key is not changed on fork
Message-ID: <20210520160035.GP17233@C02TD0UTHF1T.local>
References: <20210430150438.GA57205@C02TD0UTHF1T.local>
 <20210520151854.3632129-1-derrick.mckee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520151854.3632129-1-derrick.mckee@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 11:18:54AM -0400, Derrick McKee wrote:
> The kernel uses the IA key for PAC signing, 
> and this key should remain unchanged from the kernel point of view.
> This patch ensures that the IA key remains constant on fork, 
> if it has been previously set.
> The software is provided on an as-is basis.
> 
> Signed-off-by: Derrick McKee <derrick.mckee@gmail.com>
> Signed-off-by: Yianni Giannaris <yiannig@mit.edu>

On the kernel side, we use a unique IA key per kernel thread, and while
this must remain the same *for that kernel thread*, the kernel IA key
should differ across kernel threads when a fork() occurs.

I think you're trying to use the keys in a different way than upstream
intends to, and we do not need this change as-is.

So NAK to this patch as it stands.

Thanks,
Mark.

> ---
>  arch/arm64/include/asm/pointer_auth.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> index d50416be99be..9748413e72fd 100644
> --- a/arch/arm64/include/asm/pointer_auth.h
> +++ b/arch/arm64/include/asm/pointer_auth.h
> @@ -69,10 +69,13 @@ static inline void ptrauth_keys_init_user(struct ptrauth_keys_user *keys)
>  	ptrauth_keys_install_user(keys);
>  }
>  
> -static __always_inline void ptrauth_keys_init_kernel(struct ptrauth_keys_kernel *keys)
> +static __always_inline void
> +ptrauth_keys_init_kernel(struct ptrauth_keys_kernel *keys)
>  {
> -	if (system_supports_address_auth())
> -		get_random_bytes(&keys->apia, sizeof(keys->apia));
> +	if (keys->apia.lo == 0 && keys->apia.hi == 0) {
> +		if (system_supports_address_auth())
> +			get_random_bytes(&keys->apia, sizeof(keys->apia));
> +	}
>  }
>  
>  static __always_inline void ptrauth_keys_switch_kernel(struct ptrauth_keys_kernel *keys)
> -- 
> 2.31.1
> 
