Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58F237B4B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhELDwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhELDwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:52:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EEEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 20:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aTvKpxfUjpa51UfREN7+HPOb94z389kuVFnSFnj9YgU=; b=tWukLvpVP3mWDqMnudvsVMOPTc
        CmanCzPaqq7vaM/1/jq6bWGBSxQ3KbDbSrx7HXFJbsmPDtkYy4Otxvki0LA5rW70CbgL2eZOF7QvP
        9B7yVLaQD0Hjxcrq7IujWR/L1KaTqkAXO6A4mqboJgFywAHTN0/T0UsT26KwQwny3Ls3Q28LnABN0
        B8BV0mR9rlxHn61P/4eRUggbQ3nQsnWrLywPbuJMq0PKzhrw3nVzQJlTVxJ6t9vNlpVcIDQLtjauW
        6rkqQgGSKWKfH4CGfwBd2PqMSMmKJErqrtglN00r3qEjnwg4Mjl5Xp9NUTYSt3H2fxePeFZjFa00p
        s7nH+zzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgftX-007ukN-UV; Wed, 12 May 2021 03:50:54 +0000
Date:   Wed, 12 May 2021 04:50:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: arm32: panic in move_freepages (Was [PATCH v2 0/4] arm64: drop
 pfn_valid_within() and simplify pfn_valid())
Message-ID: <YJtQl3wLUo4msF+Y@casper.infradead.org>
References: <20210421065108.1987-1-rppt@kernel.org>
 <9aa68d26-d736-3b75-4828-f148964eb7f0@huawei.com>
 <YIEl8aKr8Ly0Zd3O@kernel.org>
 <33fa74c2-f32d-f224-eb30-acdb717179ff@huawei.com>
 <2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com>
 <YIUYG8N9T3/C/tSG@kernel.org>
 <52f7d03b-7219-46bc-c62d-b976bc31ebd5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f7d03b-7219-46bc-c62d-b976bc31ebd5@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 03:51:56PM +0800, Kefeng Wang wrote:
> we see the PC is at PageLRU, same reason like arm64 panic log,
> 
> "PageBuddy in move_freepages returns false Then we call PageLRU, the macro
> calls PF_HEAD which is compound_page() compound_page reads
> page->compound_head, it is 0xffffffffffffffff, so it resturns
> 0xfffffffffffffffe - and accessing this address causes crash"

Oh.  I posted patches to fix this back in 2018.

https://lore.kernel.org/linux-mm/20180414043145.3953-6-willy@infradead.org/

and 2019.

https://lore.kernel.org/linux-mm/20190501202433.GC28500@bombadil.infradead.org/

and 2020.

https://lore.kernel.org/linux-mm/20200408150148.25290-6-willy@infradead.org/

Looks like it's about that time of year for me to try to fix this again.

