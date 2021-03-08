Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637713313F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCHQ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:59:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhCHQ6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:58:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E424E6522C;
        Mon,  8 Mar 2021 16:58:49 +0000 (UTC)
Date:   Mon, 8 Mar 2021 16:58:47 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] arm64: kasan: allow to init memory when setting
 tags
Message-ID: <20210308165847.GF15644@arm.com>
References: <cover.1615218180.git.andreyknvl@google.com>
 <755161094eac5b0fc15273d609c78a459d4d07b9.1615218180.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <755161094eac5b0fc15273d609c78a459d4d07b9.1615218180.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 04:55:14PM +0100, Andrey Konovalov wrote:
> @@ -68,10 +69,16 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>  		 * 'asm volatile' is required to prevent the compiler to move
>  		 * the statement outside of the loop.
>  		 */
> -		asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
> -			     :
> -			     : "r" (curr)
> -			     : "memory");
> +		if (init)
> +			asm volatile(__MTE_PREAMBLE "stzg %0, [%0]"
> +				     :
> +				     : "r" (curr)
> +				     : "memory");
> +		else
> +			asm volatile(__MTE_PREAMBLE "stg %0, [%0]"
> +				     :
> +				     : "r" (curr)
> +				     : "memory");
>  
>  		curr += MTE_GRANULE_SIZE;
>  	} while (curr != end);

Is 'init' always a built-in constant here? If not, checking it once
outside the loop may be better (or check the code generation, maybe the
compiler is smart enough).

-- 
Catalin
