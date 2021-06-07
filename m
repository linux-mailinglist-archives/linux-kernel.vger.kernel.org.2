Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D1239E627
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFGSGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFGSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:06:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285F4C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZTh2RnYV27oLVt4BJj4ZhqnskEuzydcOTMgQsGZpXh4=; b=RxwF/q2Rye4NC95etr0kDbNka+
        tROFkFQ+1cDU8FWiO0vAOD4ceReIB59VAIYX3i1CrWedoFgQEr93OxIGkjtMnfxcVNcxP8vaz+bNZ
        IZ1vpMu9XasdCayeQud6YvPpIXwAYtdtI4dFSeSBWOwuThMJmTQ/76lxj6HOgGrZ3ZgDAAA5A6lpY
        gXYMN2J+JZrbshybaIkbcQz1KrHScMrbK9bH3SClCJL9Yrp6379zrd01Ox60MSku9JIWi01w2wF4s
        zlM+UGDmMSyEhNFG4MDnVIXnJZXzs9ISLxhKn3Rr+bXmg8rZz0S1km5AR9f8rAXgvKIN6FJnynitY
        +bEwad1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqJat-00G67M-KS; Mon, 07 Jun 2021 18:03:29 +0000
Date:   Mon, 7 Jun 2021 19:03:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        chinwen.chang@mediatek.com,
        kernel list <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        syzbot <syzbot+1f52b3a18d5633fa7f82@syzkaller.appspotmail.com>
Subject: Re: split_huge_page_to_list() races with page_mapcount() on
 migration entry in smaps code? [was: Re: [syzbot] kernel BUG in
 __page_mapcount]
Message-ID: <YL5fayfh03Wecyd7@casper.infradead.org>
References: <00000000000017977605c395a751@google.com>
 <CAG48ez0M=iwJu=Q8yUQHD-+eZDg6ZF8QCF86Sb=CN1petP=Y0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0M=iwJu=Q8yUQHD-+eZDg6ZF8QCF86Sb=CN1petP=Y0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 07:27:23PM +0200, Jann Horn wrote:
> === Short summary ===
> I believe the issue here is a race between /proc/*/smaps and
> split_huge_page_to_list():
> 
> The codepath for /proc/*/smaps walks the pagetables and (e.g. in
> smaps_account()) calls page_mapcount() not just on pages from normal
> PTEs but also on migration entries (since commit b1d4d9e0cbd0a
> "proc/smaps: carefully handle migration entries", from Linux v3.5).
> page_mapcount() expects compound pages to be stable.
> 
> The split_huge_page_to_list() path first protects the compound page by
> locking it and replacing all its PTEs with migration entries (since
> the THP rewrite in v4.5, I think?), then does the actual splitting
> using __split_huge_page().
> 
> So there's a mismatch of expectations here:
> The smaps code expects that migration entries point to stable compound
> pages, while the THP code expects that it's okay to split a compound
> page while it has migration entries.

Will it be a colossal performance penalty if we always get the page
refcount after looking it up?  That will cause split_huge_page() to
fail to split the page if it hits this race.
