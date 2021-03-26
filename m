Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E8734AE98
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhCZS3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhCZS2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:28:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A8A061A3F;
        Fri, 26 Mar 2021 18:28:42 +0000 (UTC)
Date:   Fri, 26 Mar 2021 18:28:40 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: [PATCH 1/4] arm64: expose orig_x0 in the user_pt_regs structure
Message-ID: <20210326182839.GE5126@arm.com>
References: <20210322225053.428615-1-avagin@gmail.com>
 <20210322225053.428615-2-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322225053.428615-2-avagin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:50:50PM -0700, Andrei Vagin wrote:
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index 758ae984ff97..3c118c5b0893 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -90,6 +90,7 @@ struct user_pt_regs {
>  	__u64		sp;
>  	__u64		pc;
>  	__u64		pstate;
> +	__u64		orig_x0;
>  };

That's a UAPI change, likely to go wrong. For example, a
ptrace(PTRACE_GETREGSET, pid, REGSET_GPR, data) would write past the end
of an old struct user_pt_regs in the debugger.

-- 
Catalin
