Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07F53FDD4D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbhIAN3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244113AbhIAN3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:29:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B392461026;
        Wed,  1 Sep 2021 13:28:16 +0000 (UTC)
Date:   Wed, 1 Sep 2021 14:28:14 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V2] arm64/mm: Drop <asm/page-def.h>
Message-ID: <YS9/7mE+5uieqKh8@arm.com>
References: <1629457516-32306-1-git-send-email-anshuman.khandual@arm.com>
 <20210820183520.GC23080@arm.com>
 <84b647b6-9cee-5aad-78f8-7bc253300534@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84b647b6-9cee-5aad-78f8-7bc253300534@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 09:15:30AM +0530, Anshuman Khandual wrote:
> On 8/21/21 12:05 AM, Catalin Marinas wrote:
> > On Fri, Aug 20, 2021 at 04:35:16PM +0530, Anshuman Khandual wrote:
> >> PAGE_SHIFT (PAGE_SIZE and PAGE_MASK) which is derived from ARM64_PAGE_SHIFT
> >> should be moved into <asm/page.h> instead like in case for other platforms,
> >> and then subsequently <asm/page-def.h> can be just dropped off completely.
> > 
> > These were moved to page-def.h as part of commit b6531456ba27 ("arm64:
> > factor out PAGE_* and CONT_* definitions") to avoid some circular header
> > dependencies.
> > 
> >> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> >> index 824a3655dd93..649d26396f9e 100644
> >> --- a/arch/arm64/include/asm/memory.h
> >> +++ b/arch/arm64/include/asm/memory.h
> >> @@ -12,7 +12,7 @@
> >>  
> >>  #include <linux/const.h>
> >>  #include <linux/sizes.h>
> >> -#include <asm/page-def.h>
> >> +#include <asm/page.h>
> > 
> > In 5.14-rc3, asm/page.h still includes asm/memory.h.
> 
> Dropping <asm/memory.h> from <asm/page.h> does not seem to cause
> any problem, will change that. Afterwards build tested it across
> page sizes and also with some random configs. Is that circular
> dependency still present ? Also wondering why was <asm/memory.h>
> included in <asm/page.h> to begin with ?

asm/memory.h is not included by any of the generic files, however it has
essential definitions like PAGE_OFFSET, THREAD_SIZE. The expectations
from the arch code is to have these defined in asm/page.h (see the
asm-generic/page.h), hence the inclusion. It probably gets included by
other arch headers and that's why you don't get any errors, but I
wouldn't rely on this.

I don't remember how we ended up with a separate memory.h file. On arm64
we inherited it from arch/arm.

-- 
Catalin
