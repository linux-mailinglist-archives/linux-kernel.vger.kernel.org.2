Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3E43EC5F0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 01:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhHNX0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 19:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhHNX0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 19:26:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8358C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 16:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hPEyx1TMU52F7z7VfmQhvcPax967bzgQrYJgqNP/sUQ=; b=t6W6WorpKODERSTnEWyYsgN2Er
        5Zu5/v+h7AzF6OB6JjVByW2VwrGrb7Y965h/2MzcoN144BqdUOGQklL3FIc7G5xMI6qU3Tryxrg5O
        +jHOx8IIXZ0HowfmNtLHr+8wUjl1AO/AoAf79jUvFHEng5pbu8LR7rLmzYpGLnymFLCen/RI/1duL
        Gyld7+WHIAXJThr7PN2101rXE4Zftk6EB2naSwU2ao54p+2bUjmMyISoBEFZvcaTlGm8X8FCdPXJj
        HMso+VbRpgqkKXsZpoZWFDZvWpzUi+HnJ5EFrDUXYlFEq1LzI0aMAGeJvWbRXC8DL1kk9vbqYehf6
        3thZHrOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mF31E-00HBYz-93; Sat, 14 Aug 2021 23:25:03 +0000
Date:   Sun, 15 Aug 2021 00:24:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+57876cfc2dca0c6b2e6a@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 alloc_huge_page
Message-ID: <YRhQwOvZNBRZqk9O@casper.infradead.org>
References: <000000000000fbad4305c982f836@google.com>
 <20210814150652.c61e3c09a58222260fa2d02d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814150652.c61e3c09a58222260fa2d02d@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 03:06:52PM -0700, Andrew Morton wrote:
> On Sat, 14 Aug 2021 04:07:23 -0700 syzbot <syzbot+57876cfc2dca0c6b2e6a@syzkaller.appspotmail.com> wrote:
> > HEAD commit:    92d00774360d Add linux-next specific files for 20210810
> > RIP: 0010:__list_add include/linux/list.h:71 [inline]
> > RIP: 0010:list_add include/linux/list.h:86 [inline]
> > RIP: 0010:alloc_huge_page+0xdcb/0x11b0 mm/hugetlb.c:2821
> 
> That appears to be
> 
> 		list_add(&page->lru, &h->hugepage_activelist);
> 
> I'm suspecting Mike's surplus page changes?

Is this not the same as
https://lore.kernel.org/linux-mm/846c4502-3332-0d25-87f5-cb3b71afc38f@quicinc.com/
which is already patched in your tree?
