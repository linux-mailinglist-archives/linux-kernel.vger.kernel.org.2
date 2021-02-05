Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AF731171B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBEX2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhBEOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:24:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CEEC0611C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q4i8Vd+iDG7UgW56EgaEHq1NQdnDRIWGcaM4duwOyCM=; b=FkIbdUb09QqaDoWsVhHJ6g8cNE
        G+ZndRUfzxWAZ7ok3ovwJzPYevEjKnYiLRlJl8tnubvT+Er/YGLAWPa4tUMmsZnQ2onbvikPUShtS
        pjBfU3oO753S33JBJuj/kAMqnAkyS9bXi3olgiu6rdVfMDzgz0D5YMe9OBZ5d8lkM1fdbFxkP8HDZ
        dQgLh2si3dQxUII3TC7NUe37YLQEWlKeFGE9do9PlAI5V/9LPOAGDLli5TE+QpQBBV5h3eg8uQfzg
        lhCZGlMF4W47RYGJOB7CPmLhaZYyB0GTTakoiGN93em6QlZLE7sl6pCVU324wkSa4JLWI1hmq3erY
        E7kjs07A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l83M4-002T4R-DL; Fri, 05 Feb 2021 15:49:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE56D3013E5;
        Fri,  5 Feb 2021 16:49:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FAE72BC43F8F; Fri,  5 Feb 2021 16:49:05 +0100 (CET)
Date:   Fri, 5 Feb 2021 16:49:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/9] Linear Address Masking enabling
Message-ID: <YB1o8RZnaaf7xXAQ@hirez.programming.kicks-ass.net>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 06:16:20PM +0300, Kirill A. Shutemov wrote:
> The feature competes for bits with 5-level paging: LAM_U48 makes it
> impossible to map anything about 47-bits. The patchset made these
> capability mutually exclusive: whatever used first wins. LAM_U57 can be
> combined with mappings above 47-bits.

And I suppose we still can't switch between 4 and 5 level at runtime,
using a CR3 bit?
