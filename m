Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DF23057C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhA0KFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:05:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S316762AbhAZXJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 18:09:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60AC22065C;
        Tue, 26 Jan 2021 23:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611702537;
        bh=ZcWiVRtGNonnO8A1OWptzd75MMTLGyymFyrOh0mqTMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=avEl48RvWCLjsUQuImILhaUc2gs33aJv/4LJvFRfZ/eGQ3S2AxHaIuGzjeF6m2fDI
         3qgkWlctKqloIkEbGnm1fwCs43WgTFwGvC/YTLO/x7ujGXbnUOk2qQ/3twF3Gm8oJV
         Brykj+eHX/4zYCL9h+dBxWIvUXAYfK0mvpbVaQSsdN8Ua8uLQ9daPtotB+ShbAYq9v
         EztUsEsKwXdDq6fKBn+GdCDjpVfAWrpKaHXpCzLOZOc392pdLziu3JvL6mHMJN1pTZ
         wq69S/9AxpN0/DRgGaySDgu3itV8ns3haNjhqbowuJYu5tCdrab9Ii/MJQisihG0WB
         Mig8ek4jCYVOg==
Date:   Tue, 26 Jan 2021 23:08:52 +0000
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 0/8] Create 'old' ptes for faultaround mappings on
 arm64 with hardware access flag
Message-ID: <20210126230851.GE30941@willie-the-truck>
References: <20210120173612.20913-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120173612.20913-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 05:36:04PM +0000, Will Deacon wrote:
> Hi all,
> 
> This is version four of the patches I previously posted here:
> 
>   v1: https://lore.kernel.org/r/20201209163950.8494-1-will@kernel.org
>   v2: https://lore.kernel.org/r/20210108171517.5290-1-will@kernel.org
>   v3: https://lore.kernel.org/r/20210114175934.13070-1-will@kernel.org
> 
> The patches allow architectures to opt-in at runtime for faultaround
> mappings to be created as 'old' instead of 'young'. Although there have
> been previous attempts at this, they failed either because the decision
> was deferred to userspace [1] or because it was done unconditionally and
> shown to regress benchmarks for particular architectures [2].
> 
> The big change since v3 is that the immutable fields of 'struct vm_fault'
> now live in a 'const' anonymous struct. Although Clang will silently
> accept modifications to these fields [3], GCC emits an error. The
> resulting diffstat is _considerably_ more manageable with this approach.

The only changes I have pending against this series are cosmetic (commit
logs). Can I go ahead and queue this in the arm64 tree so that it can sit
in linux-next for a bit? (positive or negative feedback appreciated!).

Thanks,

Will
