Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1B6310DE3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 17:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhBEOqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhBEOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:41:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2904BC061794
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iGbyC596o0UVVNLvsBxtdOUHOqzW5C4ozG/jtf3rj+A=; b=pt0U3xWG8C7/TN7+b7cWfCMooE
        8JAFAiNYwmmU/oeAbaMEMMBEXONCA1HeGAVkxAqhH1uu9C6JFLdyw7CowRzokUPXTUkX2KK/63a+Q
        tYUBrtZCsCxMCuSVxRYGRCqrR3GIuG2cMrol10K5HrvAFCL0qXr3qaTObN0NhLxj7yArzCQnMom8P
        x/HH1MiqzpiVGhV89ir0AfRWErs2wwGvqL8UommK3EjrCeJJuSZO3Khwe9y9wyGUV2XWPBF57ttq2
        eBX3k3+kWLlLBRj0DTQiwu/MdDYw0q1mYeEgObDyMQ9M4g0r7vmiwVHo+rx7BYfSEHTTyoggc5Vac
        T9NR0UlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l83p9-002Uqp-HR; Fri, 05 Feb 2021 16:19:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D4E4301CC4;
        Fri,  5 Feb 2021 17:19:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00B57207A9879; Fri,  5 Feb 2021 17:19:09 +0100 (CET)
Date:   Fri, 5 Feb 2021 17:19:09 +0100
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
Message-ID: <YB1v/aWqZjk4vEJb@hirez.programming.kicks-ass.net>
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <YB1o8RZnaaf7xXAQ@hirez.programming.kicks-ass.net>
 <20210205160127.ylcdd6bbve6q2bbk@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205160127.ylcdd6bbve6q2bbk@black.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 07:01:27PM +0300, Kirill A. Shutemov wrote:
> On Fri, Feb 05, 2021 at 04:49:05PM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 05, 2021 at 06:16:20PM +0300, Kirill A. Shutemov wrote:
> > > The feature competes for bits with 5-level paging: LAM_U48 makes it
> > > impossible to map anything about 47-bits. The patchset made these
> > > capability mutually exclusive: whatever used first wins. LAM_U57 can be
> > > combined with mappings above 47-bits.
> > 
> > And I suppose we still can't switch between 4 and 5 level at runtime,
> > using a CR3 bit?
> 
> No. And I can't imagine how would it work with 5-level on kernel side.

KPTI already switches CR3 on every entry and only maps a very limited
number of kernel pages in the user map. This means a 4 level user
page-table should be possible.

The kernel page-tables would only need to update their p5d[0] on every
4l user change.

Not as nice as actually having separate user and kernel page-tables in
hardware, but it would actually make 5l page-tables useful on machines
with less than stupid amounds of memory I think.

One of the road-blocks to doing per-cpu kernel page-tables is having to
do 2k copies, only having to update a single P5D entry would be ideal.

Ofcourse, once we get 5l user tables we're back to being stupid, but
maybe tasks with that much memory don't actually switch much, who
knows.
