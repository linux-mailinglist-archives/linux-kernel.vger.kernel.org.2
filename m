Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684DC3E88B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 05:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhHKDJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 23:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbhHKDJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 23:09:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33414C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 20:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ji70bBzWzyIsNlqNlXXzqEpkz30w2PSWcwSbBgj0JSc=; b=YiyeRQe1UYy2bOPJOEId3lcakg
        5ipV5ZHAtgBoeVZP0G5lOcOIHtjcFveclB421+VGjvuAjJP+Ccfjdpa6cPU8Iyj06nxBorajI3PoU
        hjGp6s6ZNUO3JkXt6hKwVjL6w8xQ856+U7onoFhTQjis8NECtSPpQIudXhRqINQg0t4Jzkid2cLOC
        HLn5A419STBphrTGZ3pilr/TKjEb+co20dEKqvdGf4H8ahYm3Xify0F2+2mimGfPmwD2cD7KZ7qLu
        lx0Rv7i2IS2RalNyMzCtJ1ZOom+j5MAyuO/I1E1VKCzEn3hly4ZW3QAZORtLgDeGXDt5vTyjh+mwl
        sIJcWxvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDeZO-00CtQg-An; Wed, 11 Aug 2021 03:06:34 +0000
Date:   Wed, 11 Aug 2021 04:06:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-next: crash in alloc_huge_page()
Message-ID: <YRM+qm66PfTUQNFL@casper.infradead.org>
References: <846c4502-3332-0d25-87f5-cb3b71afc38f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846c4502-3332-0d25-87f5-cb3b71afc38f@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 10:22:37PM -0400, Qian Cai wrote:
> and the page->lru has an address fffffffffffffffc for some reasons. Does it sound like some error code
> had not been handled properly and had been propagated here instead? I tried reverting a few recent
> commits for mm/hugetlb.c and mm/memblock.c without luck so far.

Yes, ff..fc is going to be at offset 8 from the actual address, so
that's -12 and -12 is ...

#define ENOMEM          12      /* Out of memory */

so something's returning ERR_PTR(-ENOMEM) instead of NULL.

> [ 8107.262232][T62705] Unable to handle kernel paging request at virtual address fffffffffffffffc

These logs would be a lot easier to read if you snipped the irrelevant
timestamp and whatever this Txxxxx thing is.

