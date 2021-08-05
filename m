Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D2B3E19E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhHERDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235664AbhHERDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:03:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 970B76112F;
        Thu,  5 Aug 2021 17:03:26 +0000 (UTC)
Date:   Thu, 5 Aug 2021 18:03:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com
Subject: Re: [RFC V2 01/10] mm/mmap: Dynamically initialize protection_map[]
Message-ID: <20210805170318.GB6719@arm.com>
References: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
 <1627281445-12445-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627281445-12445-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 12:07:16PM +0530, Anshuman Khandual wrote:
> The protection_map[] elements (__PXXX and __SXXX) might sometimes contain
> runtime variables in certain platforms like arm64 preventing a successful
> build because of the current static initialization. So it just defers the
> initialization until mmmap_init() via a new helper init_protection_map().
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  mm/mmap.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index ca54d36..a95b078 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -100,10 +100,7 @@ static void unmap_region(struct mm_struct *mm,
>   *								w: (no) no
>   *								x: (yes) yes
>   */
> -pgprot_t protection_map[16] __ro_after_init = {
> -	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
> -	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
> -};
> +pgprot_t protection_map[16] __ro_after_init;

Mips, x86, sparc, arm32, m68k all adjust protection_map[] during boot.
Could we do something similar here and avoid changing the generic code?

-- 
Catalin
