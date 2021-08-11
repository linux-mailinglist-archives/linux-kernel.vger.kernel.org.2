Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A783E904C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbhHKMQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237540AbhHKMPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:15:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA16760FC3;
        Wed, 11 Aug 2021 12:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628684122;
        bh=irWqmSUH1/ML7unA3kAGPLQs6RzjTFj1LRE3RBi/7uA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWiEn6NQt2QEye6Wzv9LpGZn4RqnIljkxxoNbuBDIu4bd3YZe+W1DYmeqtLQFUtSq
         0e8yYus7TgjRw6ZrpCzOzjwimI2Us1Ot1dII3/iOUjl8lQn9UoJ3t5twgQtV/Ez3Xw
         +zgbPEaJhx37Ojq8iEglLqVqemr7Ve+B8vmalbMuZOJ5I3enz1cRyBYnFSld8DU0YJ
         BIx9lJ4Fii9axtjz7BTFuNRLDo40kAMm2TLo9aY7SsZYqo98nCYo9IwVKjyrSqlrgo
         7a9xr13+/PbEGH9ZB5ajQ5eG9oPKCu/ejw/vQ/uH6nEVj8gu2JkpHKjd5T3UYbtc5G
         ga165PmyZH8cg==
Date:   Wed, 11 Aug 2021 15:15:17 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 11/18] ARC: mm: move MMU specific bits out of entry code
Message-ID: <YRO/VSMNi00X37xQ@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-12-vgupta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811004258.138075-12-vgupta@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe a few words here would be useful even for the future version of
yourself ;-)

On Tue, Aug 10, 2021 at 05:42:51PM -0700, Vineet Gupta wrote:
> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
> ---
>  arch/arc/kernel/entry.S | 6 ------
>  arch/arc/mm/tlb.c       | 3 +++
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arc/kernel/entry.S b/arch/arc/kernel/entry.S
> index 2cb8dfe866b6..684efd094520 100644
> --- a/arch/arc/kernel/entry.S
> +++ b/arch/arc/kernel/entry.S
> @@ -101,12 +101,6 @@ ENTRY(EV_MachineCheck)
>  	lr  r0, [efa]
>  	mov r1, sp
>  
> -	; hardware auto-disables MMU, re-enable it to allow kernel vaddr
> -	; access for say stack unwinding of modules for crash dumps
> -	lr	r3, [ARC_REG_PID]
> -	or	r3, r3, MMU_ENABLE
> -	sr	r3, [ARC_REG_PID]
> -
>  	lsr  	r3, r2, 8
>  	bmsk 	r3, r3, 7
>  	brne    r3, ECR_C_MCHK_DUP_TLB, 1f
> diff --git a/arch/arc/mm/tlb.c b/arch/arc/mm/tlb.c
> index b68d5798327b..34f16e0b41e6 100644
> --- a/arch/arc/mm/tlb.c
> +++ b/arch/arc/mm/tlb.c
> @@ -813,5 +813,8 @@ void do_tlb_overlap_fault(unsigned long cause, unsigned long address,
>  		}
>  	}
>  
> +	/* Re-enable MMU as hardware may have auto-disabled it upon exception */
> +	write_aux_reg(ARC_REG_PID, read_aux_reg(ARC_REG_PID) | MMU_ENABLE);
> +
>  	local_irq_restore(flags);
>  }
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
