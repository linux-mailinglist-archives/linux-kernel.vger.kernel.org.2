Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBF73CB6B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 13:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhGPL1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 07:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhGPL06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 07:26:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF60C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dh2PIzlnUvHFBmdkKuZ7ODIlWlfAia5F5qRXgNpzT3I=; b=Iy0TfOdO+LC3gS+b7BnZ3VVq59
        oYlpjMtYhRjqjO5LVF3+dG7T4iIZfKiFuZw2Gv99vhCJFfP4YJZ7w+rSKlHAoo0w05OmPHpr30gcF
        uukHe1BeMVJUL7sO/4wETWnCxt3nQgoYl31jeIjilW3SHvo5dQEfimqfRAZsMRbMArMzROp9FQCGW
        XFveN/V2xpk2AWxRH+GdZT8zB14yPVauPNB+3TxN4HRODH8q9yvPLO1X0rIQjG8n9/6R8m6vyWJKY
        aCI+cOBT0rCEvDSSUVBtoYXoXAbG0l+YAGF8Sg5dmhMXCikuCDRcKp7+5l0kdO2HQHhI69SYq7DDG
        Np3skuww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4Lvk-004QU9-9v; Fri, 16 Jul 2021 11:23:03 +0000
Date:   Fri, 16 Jul 2021 12:22:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Huan <link@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel@vivo.com,
        Wang Qing <wangqing@vivo.com>
Subject: Re: [PATCH] mm/page_alloc: enable alloc bulk when page owner is on
Message-ID: <YPFsEDRqWqydcfTY@casper.infradead.org>
References: <20210716081756.25419-1-link@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716081756.25419-1-link@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 04:17:53PM +0800, Yang Huan wrote:
> Last alloc bulk version have a bug, when page_owner is on, system maybe
> crashed due to alloc bulk invoke prep_new_page in irq disabled context,
> and set_page_owner use page_flag(may GFP_KERNEL) to get memory and save
> stacktrace.
> We fix it by a circumvention plan -- bandon alloc bulk feature when
> page_owner is set.
> I think both alloc_bulk and page_owner is valuable, so, it's worth to
> find a way enable alloc bulk when page owner is on.

Why do you think it's valuable?  The point of alloc_bulk is speed.
Doing the allocation of a stack for each page removes the speed.
Where's the value?

If you're really interested in making both these things work together,
then I observed that all of these pages are going to have the same
allocation stack.  Allocating that stack once per call to alloc_bulk,
reference counting it and having each page use the shared stack would 
be a good way of combining the two (it'd even save memory!)

This patch, I think, does not make sense.

