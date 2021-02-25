Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA668324FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhBYMRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhBYMRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:17:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551FCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 04:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dhg25HBLQmpPTUrBeAi4KzvGulGLk3wK8liuB/pkJUM=; b=svnVtvU9dhrIjMrSXZc60bSONi
        0bmr2LlUpHb2v7UTLnwvCv3IzRoPEb7wJoZluzAoVwjjmN9ZKwU6GMm0x2KM0zM8t9Srpvk59teXk
        cJ+6hHxQZUs7JeVJuzafAYVCqkdf9yXucTTsmkrceBZirJLPphZgaNjUPMDKbNACOgROU8jZjH4AV
        t76PLK1KaRZxdoJAujnXSnx1sdeqgJJ6eUDEEXVfa80MLGZzOa7Kqr/xeg6o71yDSI82GmqSziVRP
        SVOETPEGcEgqj3xUprT5skABezTo6dFcHaOBiF2L26fHS7CIwEbeFQrB1s1gUtY/FjMjeXwlf7fzW
        n4eRfATw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFFZV-00AgNl-8k; Thu, 25 Feb 2021 12:16:47 +0000
Date:   Thu, 25 Feb 2021 12:16:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <namit@vmware.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [RFC 0/6] x86: prefetch_page() vDSO call
Message-ID: <20210225121645.GZ2858050@casper.infradead.org>
References: <20210225072910.2811795-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225072910.2811795-1-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 11:29:04PM -0800, Nadav Amit wrote:
> Just as applications can use prefetch instructions to overlap
> computations and memory accesses, applications may want to overlap the
> page-faults and compute or overlap the I/O accesses that are required
> for page-faults of different pages.

Isn't this madvise(MADV_WILLNEED)?
