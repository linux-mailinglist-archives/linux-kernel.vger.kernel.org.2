Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61ACD3F33E8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhHTSgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhHTSgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:36:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D09B56113D;
        Fri, 20 Aug 2021 18:35:33 +0000 (UTC)
Date:   Fri, 20 Aug 2021 19:35:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V2] arm64/mm: Drop <asm/page-def.h>
Message-ID: <20210820183520.GC23080@arm.com>
References: <1629457516-32306-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629457516-32306-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 04:35:16PM +0530, Anshuman Khandual wrote:
> PAGE_SHIFT (PAGE_SIZE and PAGE_MASK) which is derived from ARM64_PAGE_SHIFT
> should be moved into <asm/page.h> instead like in case for other platforms,
> and then subsequently <asm/page-def.h> can be just dropped off completely.

These were moved to page-def.h as part of commit b6531456ba27 ("arm64:
factor out PAGE_* and CONT_* definitions") to avoid some circular header
dependencies.

> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 824a3655dd93..649d26396f9e 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -12,7 +12,7 @@
>  
>  #include <linux/const.h>
>  #include <linux/sizes.h>
> -#include <asm/page-def.h>
> +#include <asm/page.h>

In 5.14-rc3, asm/page.h still includes asm/memory.h.

-- 
Catalin
