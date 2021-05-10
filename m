Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4E2377EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhEJIzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhEJIzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:55:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93388C06175F;
        Mon, 10 May 2021 01:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jac63i9sp+2HDTsLLc4LJUWG/al5HXdYHUq8upjX9UY=; b=PoOh1YAsQsQJsKGPG9SdJESPGd
        Wr8U0VUVXdUCZ/WD9EYow6JmIsJaF9RbGcytrxjA4jmLGIjsHkMCtxGnuCg/b1zOBymia7U6m/sqe
        xs93Dn5pLKFrgNmbo4PQghn7DljG05hoYKVsCjdyGRaX1Tsebnly6IMLB1rtPVqw5MvVC9PWSwgBf
        ytJAi/RFn08GbnPEL2p8IiMSZuEpEbW7a1jU5yT+e6w37P62pO69CO2+9QxrmpIwlALbIFMkejaQw
        mKY3dD7XwbLa449uJsuHiPaq3i8m9jbbdC14KypJ7FgBMiQEXLO4UF05eC7SK3adsZnMSAl3ltTlK
        wqbBQ25A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lg1f8-005s3j-S6; Mon, 10 May 2021 08:53:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FD21980331; Mon, 10 May 2021 10:53:13 +0200 (CEST)
Date:   Mon, 10 May 2021 10:53:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/thp: Make ARCH_ENABLE_SPLIT_PMD_PTLOCK dependent on
 PGTABLE_LEVELS > 2
Message-ID: <20210510085313.GB5618@worktop.programming.kicks-ass.net>
References: <1620621345-29176-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620621345-29176-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 10:05:45AM +0530, Anshuman Khandual wrote:
> -	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if X86_64 || X86_PAE
> +	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if (PGTABLE_LEVELS > 2) && (X86_64 || X86_PAE)

It's still very early on a Monday, but IIRC this new condition is
identical to the pre-existing one.
