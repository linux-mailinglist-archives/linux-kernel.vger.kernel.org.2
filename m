Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB846319CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhBLKzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:55:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhBLKzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:55:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA47D64E35;
        Fri, 12 Feb 2021 10:55:01 +0000 (UTC)
Date:   Fri, 12 Feb 2021 10:54:59 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] arm64: Fix warning in mte_get_random_tag()
Message-ID: <20210212105458.GA7718@arm.com>
References: <20210211152208.23811-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210211152208.23811-1-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 03:22:08PM +0000, Vincenzo Frascino wrote:
> The simplification of mte_get_random_tag() caused the introduction of the
> warning below:
> 
> In file included from arch/arm64/include/asm/kasan.h:9,
>                  from include/linux/kasan.h:16,
>                  from mm/kasan/common.c:14:
> mm/kasan/common.c: In function ‘mte_get_random_tag’:
> arch/arm64/include/asm/mte-kasan.h:45:9: warning: ‘addr’ is used
>                                          uninitialized [-Wuninitialized]
>    45 |         asm(__MTE_PREAMBLE "irg %0, %0"
>       |
> 
> Fix the warning using "=r" for the address in the asm inline.
> 
> Fixes: c8f8de4c0887 ("arm64: kasan: simplify and inline MTE functions")
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
