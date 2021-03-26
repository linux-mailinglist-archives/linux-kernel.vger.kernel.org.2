Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366AC34AEAD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCZSj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhCZSj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:39:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 258856197C;
        Fri, 26 Mar 2021 18:39:27 +0000 (UTC)
Date:   Fri, 26 Mar 2021 18:39:24 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: [PATCH 2/4] arm64/ptrace: introduce orig_x7 in the user_pt_regs
 structure
Message-ID: <20210326183924.GF5126@arm.com>
References: <20210322225053.428615-1-avagin@gmail.com>
 <20210322225053.428615-3-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322225053.428615-3-avagin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:50:51PM -0700, Andrei Vagin wrote:
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index d4cdf98ac003..1008f0fbc5ea 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -184,6 +184,7 @@ struct pt_regs {
>  			u64 pc;
>  			u64 pstate;
>  			u64 orig_x0;
> +			u64 orig_x7;
>  		};
>  	};
>  #ifdef __AARCH64EB__
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index 3c118c5b0893..be7583ff5f4d 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -91,6 +91,7 @@ struct user_pt_regs {
>  	__u64		pc;
>  	__u64		pstate;
>  	__u64		orig_x0;
> +	__u64		orig_x7;
>  };

Same here. So unless I miss something, we better have a separate
NT_ORIGREG (or some better name) regset to retrieve the additional
registers. Or, if you want to get all of them in one go, just add a
new one similar to NT_PRSTATUS but which restores x0 to orig_x0 and x7
to orig_x7.

Sorry if this was already discussed. I had a brief look at the previous
versions and couldn't see a user_pt_regs structure change, nor a
suggestion to do so.

-- 
Catalin
