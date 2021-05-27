Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A874D393027
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbhE0NzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:55:06 -0400
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:49567 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236580AbhE0NzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:55:05 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 8DE711E30
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 14:53:30 +0100 (IST)
Received: (qmail 13155 invoked from network); 27 May 2021 13:53:30 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 May 2021 13:53:30 -0000
Date:   Thu, 27 May 2021 14:53:28 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] x86: fixmap: use CONFIG_NR_CPUS instead of NR_CPUS
Message-ID: <20210527135328.GD30378@techsingularity.net>
References: <20210521195918.2183-1-rdunlap@infradead.org>
 <YK3vrIB7cWop+UIW@gmail.com>
 <59676378-1b52-cae7-7944-adeffd27190e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <59676378-1b52-cae7-7944-adeffd27190e@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 10:59:51AM -0700, Randy Dunlap wrote:
> >  - Once early_ioremap.h is gone from io.h, it's potentially possible to 
> >    include <linux/threads.h>. More work to resolve dependencies might be 
> >    needed though.
> 
> Yes, my first patch for this (unsent) just included <linux/threads.h>
> in fixmap.h unconditionally instead of conditionally.
> 
> > Frankly, I'd prefer if such a low level header dependencies change came in 
> > via the x86 tree so we can properly review it, test it, and keep it 
> > working. Right now I can only guess what is needed here...
> 
> Sure, makes sense.
> 
> Mel, do you have any patch suggestions here?  re:

For whatever reason, I do not see the same build warnings you report.

Dropping "mm/early_ioremap: add prototype for early_memremap_pgprot_adjust"
is one option. Alternatively, this should also work and it's a more
sensible dependency.

diff --git a/include/asm-generic/early_ioremap.h b/include/asm-generic/early_ioremap.h
index 022f8f908b42..d95c693de640 100644
--- a/include/asm-generic/early_ioremap.h
+++ b/include/asm-generic/early_ioremap.h
@@ -3,7 +3,7 @@
 #define _ASM_EARLY_IOREMAP_H_
 
 #include <linux/types.h>
-#include <asm/fixmap.h>
+#include <linux/pgtable.h>
 
 /*
  * early_ioremap() and early_iounmap() are for temporary early boot-time

-- 
Mel Gorman
SUSE Labs
