Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB09739E8BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhFGUwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:52:38 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:37855 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhFGUwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:52:37 -0400
Received: by mail-lf1-f48.google.com with SMTP id f11so28392130lfq.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TvLQf2wXHegMO4uEWEbqN/2+ymXClH1c47usYHXpKPM=;
        b=j6colDVcTN6A/b35XaPZE4vfAMXgk36m3VueudKIPO+29yOnWbhBPZ7vFNJgZ2+yVQ
         hDIWgs8o1n4MyM30H3UDD9fzlPds4ERgcN8ylTWLdrz/NOWYGHQXGee88DKHgcf1yVwu
         +CWmNVnaz2J7eO2lB/yZzTxyjOjSUH2+o4OoHrnT2+/R7JHqfCooJoKS5j4TdG1rJdDh
         uag2/FVuA6gts+bE2FAAFi9dR2HlQ+3TPWvcO0De2BQLFMjQeeawg2AXsiJfdipstxHM
         xrBZmLdAln/aMJ60sNtC9bjDTLHPYQQ2FQWvOVy9yca9wAZ9Lknk97Gl/f8eSQXvdyT+
         u+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TvLQf2wXHegMO4uEWEbqN/2+ymXClH1c47usYHXpKPM=;
        b=timMfTwBFXn9a+NyUTV3x632RpRdMtGVqufxJFovPKuxg8FJOtTzyiEp3f4UjKcyMu
         3K8mwe+hoTgXS3OI7HiaaaqHqnK6ZKNinBhjxBuS01qYWfswmCGY0ofUlrjfMkM377Z/
         mOM9rDAWMzbnDXoJojedFmusdjd9xwEe1KTEVELsj36exI2bheuo8XZVrDoQFuiTrG5j
         crf45FRQyKx/NMwdSbEFI8ZKDjfQqbKXOFOTX45Aq/34miSfx581U+In3hfQnBxLlGzX
         y1yMDVwHMWJFgFyh2AMVZNwp/cctnbG8UemWLgAwk/B8JljhEI15P4tc4kXa3HnKZj+4
         oVmQ==
X-Gm-Message-State: AOAM5321zU4GUKy0ntm23sACQJcfZ3G24WuWH2cPEDq/V6aTUkWv2HNf
        G2QP1F0e8OPjJykOy4xmMNIVlQ==
X-Google-Smtp-Source: ABdhPJxhAfAQ88rG5kSCkiw5DymwPnlnDy67yswfnuHDyWwGh+X2e4dbklZWygL1TDN+0BJcBwWE9w==
X-Received: by 2002:a19:f706:: with SMTP id z6mr12847846lfe.122.1623098969472;
        Mon, 07 Jun 2021 13:49:29 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j16sm1238926lfk.155.2021.06.07.13.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 13:49:28 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F3890101ED7; Mon,  7 Jun 2021 23:49:42 +0300 (+03)
Date:   Mon, 7 Jun 2021 23:49:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jann Horn <jannh@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>, Zi Yan <ziy@nvidia.com>,
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
Message-ID: <20210607204942.buratcsapp5fk627@box.shutemov.name>
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
> 2. let smaps assume that the mapcount is 1 for all migration entries?

I believe that what we effectively do for migration entries to
non-compound pages:

	for (i = 0; i < nr; i++, page++) {
		int mapcount = page_mapcount(page);
		unsigned long pss = PAGE_SIZE << PSS_SHIFT;
		if (mapcount >= 2)
			pss /= mapcount;
		smaps_page_accumulate(mss, page, PAGE_SIZE, pss, dirty, locked,
				      mapcount < 2);
	}

For non-compound pages with page_count(page) != 1 (== 1 handled
separately) we would have nr == 1 and will look into mapcount, which for
pages under migration is 0. The code above will handle mapcount == 0 as
mapcount == 1. I think it would not be a stretch to do the same for
compound pages here.

I guess we should take an additional argument to smaps_account() which would
indicate that we deal with migration entry and handle it as mapcount == 1.

Hm. Do we need the same for device-private entries?

-- 
 Kirill A. Shutemov
