Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2E4393460
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhE0Q53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:57:29 -0400
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:43722 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233979AbhE0Q52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:57:28 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 16E3EBAA56
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 17:55:54 +0100 (IST)
Received: (qmail 24881 invoked from network); 27 May 2021 16:55:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 May 2021 16:55:53 -0000
Date:   Thu, 27 May 2021 17:55:52 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] x86: fixmap: use CONFIG_NR_CPUS instead of NR_CPUS
Message-ID: <20210527165552.GF30378@techsingularity.net>
References: <20210521195918.2183-1-rdunlap@infradead.org>
 <YK3vrIB7cWop+UIW@gmail.com>
 <59676378-1b52-cae7-7944-adeffd27190e@infradead.org>
 <20210527135328.GD30378@techsingularity.net>
 <d3bcf780-fb3d-ae86-9706-d5f8798a342e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d3bcf780-fb3d-ae86-9706-d5f8798a342e@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 08:48:02AM -0700, Randy Dunlap wrote:
> > Dropping "mm/early_ioremap: add prototype for early_memremap_pgprot_adjust"
> > is one option. Alternatively, this should also work and it's a more
> > sensible dependency.
> > 
> > diff --git a/include/asm-generic/early_ioremap.h b/include/asm-generic/early_ioremap.h
> > index 022f8f908b42..d95c693de640 100644
> > --- a/include/asm-generic/early_ioremap.h
> > +++ b/include/asm-generic/early_ioremap.h
> > @@ -3,7 +3,7 @@
> >  #define _ASM_EARLY_IOREMAP_H_
> >  
> >  #include <linux/types.h>
> > -#include <asm/fixmap.h>
> > +#include <linux/pgtable.h>
> >  
> >  /*
> >   * early_ioremap() and early_iounmap() are for temporary early boot-time
> > 
> 
> That patch also lots of (different) problems:
> 

Ok, thanks. Turns out the header dependencies are many and it ends
either including a bunch of headers or else just mm_types.h. That's
a lot to import just to get a working definition of pgprot_t and some
other configuration could still be missed leaving linux-next broken for
same people.

Andrew, can you drop
mm-early_ioremap-add-prototype-for-early_memremap_pgprot_adjust-fix.patch
from mmotm please? It's caused more hassle than it's worth.

-- 
Mel Gorman
SUSE Labs
