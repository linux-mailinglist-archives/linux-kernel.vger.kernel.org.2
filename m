Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6771743BB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 22:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbhJZUQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 16:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhJZUQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:16:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FA5C061570;
        Tue, 26 Oct 2021 13:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XpcCZaMDhTMnYyJSdOgPGsmV13N4Kdjo79sKD4gwqi4=; b=g5HEEyPqoYTrvCHhJurluWH14d
        GhrqbBsrMvPDxy93l7ms1zJyXKSFlQCa/LcV8U0RTMKWGuWnxQI24FGbLMu8zHwvrMLrnqUi7tFT6
        x7c0HQwcj3ReCJzyafrRF61hUCM6Z4S1ZD4MhfSXT9l7BRR3TXlibO9ctHctzH3sjvUMB2boWHSee
        uZcOLIZsHsWvanVlKVUUCC/IDuooM92qmnVaFSUIqoSUdfV1U6MCo5rfV0RHQ1FKjHge/6ODqa2K8
        RvfTG4GNCkq3Xf8EQmS24cUsJU7l2oKbS40/FVt0pUD0/whQdI/hSSpNkAz/8SOFI+XCHw89P006k
        YKvVEp4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfSpB-00H8Hv-3p; Tue, 26 Oct 2021 20:13:45 +0000
Date:   Tue, 26 Oct 2021 21:13:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, songmuchun@bytedance.com,
        weixugc@google.com, Greg Thelen <gthelen@google.com>
Subject: Re: [RFC 0/8] Hardening page _refcount
Message-ID: <YXhhbSSRQrG5Av6P@casper.infradead.org>
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <YXhHq52jDrU61V4E@casper.infradead.org>
 <CA+CK2bBbGEJa4s7HtgQkG_tZmN66UaVcDRovgLz4q+a0VGSqZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBbGEJa4s7HtgQkG_tZmN66UaVcDRovgLz4q+a0VGSqZg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 02:30:25PM -0400, Pasha Tatashin wrote:
> On Tue, Oct 26, 2021 at 2:24 PM Matthew Wilcox <willy@infradead.org> wrote:
> > I think this is overkill.  Won't we get exactly the same protection
> > by simply testing that page->_refcount == 0 in set_page_count()?
> > Anything which triggers that BUG_ON would already be buggy because
> > it can race with speculative gets.
> 
> We can't because set_page_count(v) is used for
> 1. changing _refcount form a current value to unconstrained v
> 2.  initialize _refcount from undefined state to v.
> 
> In this work we forbid the first case, and reduce the second case to
> initialize only to 1.

Anything that is calling set_page_refcount() on something which is
not 0 is buggy today.  There are several ways to increment the page
refcount speculatively if it is not 0.  eg lockless GUP and page cache
reads.  So we could have:

CPU 0: alloc_page() (refcount now 1)
CPU 1: get_page_unless_zero() (refcount now 2)
CPU 0: set_page_refcount(5) (refcount now 5)
CPU 1: put_page() (refcount now 4)

Now the refcount is wrong.  So it is *only* safe to call
set_page_refcount() if the refcount is 0.  If you can find somewhere
that's calling set_page_refcount() on a non-0 refcount, that's a bug
that needs to be fixed.
