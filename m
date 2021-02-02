Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF2530BAF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhBBJcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhBBJc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:32:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2878C061573;
        Tue,  2 Feb 2021 01:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9KzakhvbdvrVuIhJCaujo2BiN5IuFWAm6tV0NCLB24Q=; b=WQI9v3Fm+YGJL5PLHXu17b3K22
        RuE4J49J6OEbD5VOJtDDNX8J+nxknxSho7XSv0wKzrtz5CbKv4IUELjrmqWTGl24O9yh/iUa1MrJu
        sf5qftPGCUIFqrjbI3r5y1Pp1FxAQMZoJqSO8A0ZwFmIpx1/kgsopT5zDn7A55SSypQOR4CORQjar
        9fa7lWvlOC8S1H0VISKCVuCxvEm9FmduwfoWJqql7E8FFP145R9+IbtnXq75beFHh7yAV6gWlrDkM
        7GLyL0AZ1NJkL/xHJWf50KjJGZ5zw67ZToWpSTlsNsP72bxYZUAKWhci2Dy8smLhif9sweQykcOqR
        bqXrtItg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6s26-0001fV-Rv; Tue, 02 Feb 2021 09:31:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E8E83003D8;
        Tue,  2 Feb 2021 10:31:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BE1D299C9F56; Tue,  2 Feb 2021 10:31:32 +0100 (CET)
Date:   Tue, 2 Feb 2021 10:31:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [RFC 11/20] mm/tlb: remove arch-specific tlb_start/end_vma()
Message-ID: <YBkb8yKSUKTPJvxk@hirez.programming.kicks-ass.net>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-12-namit@vmware.com>
 <YBfvh1Imz6RRTUDV@hirez.programming.kicks-ass.net>
 <1612247956.0a1r1yjmm3.astroid@bobo.none>
 <F1C67840-C62F-4583-8593-B621706034F6@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F1C67840-C62F-4583-8593-B621706034F6@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 07:20:55AM +0000, Nadav Amit wrote:
> Arm does not define tlb_end_vma, and consequently it flushes the TLB after
> each VMA. I suspect it is not intentional.

ARM is one of those that look at the VM_EXEC bit to explicitly flush
ITLB IIRC, so it has to.
