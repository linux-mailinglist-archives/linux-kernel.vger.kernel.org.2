Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F330A6E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhBALxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhBALw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:52:59 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0874C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 03:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DFvEMuSmJTMwKrx37KZALAZlQNbzmwOQTAjJ5KIsmrw=; b=w8cvjP/EhS0PSzIPxW+VuBQ9mb
        TZNQ7dWwgSY6NA0ZJzbMQK6Ku1B2KLt6pqyzZ16Bw1txT58zsTw7Ni3J459la9y5DYgKtNxTVmjyo
        YUgjsCd7fg6FJ67kJFf80vej3f4ZFRlLieWTI74UD6BVEXKpeGP1XG03NP6MH1MCL+ilraOrakuJl
        x1dNXJMRx+BR604fYQUQJfEZ1Q84nXFh7f+XKp3wdr2ExO7Tw9AQ36LdJ0z0Wxs+ovIQ5UtmUMquN
        +jbZ74Xwlo+ObX9Ain6ZPLDiMmMS94XtxKFzz2oC8cueQNZw1+LgT9gWroaPexBgFc9m9QARKLmR3
        AV0epSdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6XkX-00035y-Bm; Mon, 01 Feb 2021 11:52:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE3CA3011FE;
        Mon,  1 Feb 2021 12:52:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 98E9121A2F1E2; Mon,  1 Feb 2021 12:52:07 +0100 (CET)
Date:   Mon, 1 Feb 2021 12:52:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [RFC 08/20] mm: store completed TLB generation
Message-ID: <YBfrZ+gBCTYFS995@hirez.programming.kicks-ass.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-9-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131001132.3368247-9-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 04:11:20PM -0800, Nadav Amit wrote:
> +static inline void tlb_update_generation(atomic64_t *gen, u64 new_gen)
> +{
> +	u64 cur_gen = atomic64_read(gen);
> +
> +	while (cur_gen < new_gen) {
> +		u64 old_gen = atomic64_cmpxchg(gen, cur_gen, new_gen);
> +
> +		/* Check if we succeeded in the cmpxchg */
> +		if (likely(cur_gen == old_gen))
> +			break;
> +
> +		cur_gen = old_gen;
> +	};
> +}

	u64 cur_gen = atomic64_read(gen);
	while (cur_gen < new_gen && !atomic64_try_cmpxchg(gen, &cur_gen, new_gen))
		;

