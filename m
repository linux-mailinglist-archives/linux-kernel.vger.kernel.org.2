Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55F03EC5BF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 00:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhHNWHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 18:07:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhHNWHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 18:07:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A94C560F48;
        Sat, 14 Aug 2021 22:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628978813;
        bh=DbknUOPIPPc6SG9JbTMauk/L0G2VZm9flyfYhsntT+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b5v4VJKXLKGf4wlGL/ZVRl0uKrWMmEu9PdDMXPmf1xWXUiSQHszWHRNcDmfzWyPEG
         CEDMz3PiN3zkezBSiFChwDBMvRJWkvGtdFCOyTGWZ7f5TxGhul61EFQ/F0d7d9lqm9
         DqmKBbgge6IcxKKxgYTRowuzqsJkGpWzi+vQt13U=
Date:   Sat, 14 Aug 2021 15:06:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+57876cfc2dca0c6b2e6a@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 alloc_huge_page
Message-Id: <20210814150652.c61e3c09a58222260fa2d02d@linux-foundation.org>
In-Reply-To: <000000000000fbad4305c982f836@google.com>
References: <000000000000fbad4305c982f836@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2021 04:07:23 -0700 syzbot <syzbot+57876cfc2dca0c6b2e6a@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:

Thanks.

> HEAD commit:    92d00774360d Add linux-next specific files for 20210810
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12e2b4d9300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a6933fa6f9a86ca9
> dashboard link: https://syzkaller.appspot.com/bug?extid=57876cfc2dca0c6b2e6a
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f81581300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11419dfa300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+57876cfc2dca0c6b2e6a@syzkaller.appspotmail.com
> 
> BUG: unable to handle page fault for address: fffffffffffffffc
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD b68f067 P4D b68f067 PUD b691067 PMD 0 
> Oops: 0002 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 6601 Comm: syz-executor361 Not tainted 5.14.0-rc5-next-20210810-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__list_add include/linux/list.h:71 [inline]
> RIP: 0010:list_add include/linux/list.h:86 [inline]
> RIP: 0010:alloc_huge_page+0xdcb/0x11b0 mm/hugetlb.c:2821

That appears to be

		list_add(&page->lru, &h->hugepage_activelist);

I'm suspecting Mike's surplus page changes?

> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11419dfa300000

Nice to have that,
