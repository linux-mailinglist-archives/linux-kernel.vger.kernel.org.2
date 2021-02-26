Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1303268C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhBZUbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhBZUWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:22:36 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B056FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:22:13 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u8so10925860ior.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RHa2D7KXPMnadDnKBMg5+XM2s/0n45bECjcvpilBAc0=;
        b=bwU1TglRUXTJnraQwHDvZD9CDXHZFQZP74++szcIfuNLJ+zQ59aHKRCDNcwTNCiEM7
         9UNBEWQzmPyHlKw48wu5v5eChRicQKmLLN3U6Vw/eO7ulv/RekEeg3NGfS5vFGS18zK1
         dtv89qFIdM//PAJDSUk253l84BhBZE6FN6JKTyrZ72XeWzMGVYGE/I+EG81lSGwEoVnw
         Gi2EBfIv7pTyy5dZueLwklNyBgMNIBO2p9Nu8eEMweSCJMOiKlDmiLkDBKhC3YGu6q2Q
         m8M6+PZMTJRAWTDRsIrQHksmcnTZuSMfwaGzkzg7W8SSFYGJ7V+ZkgGjA62fRiqUP/sa
         nxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RHa2D7KXPMnadDnKBMg5+XM2s/0n45bECjcvpilBAc0=;
        b=V8Kc/d+XfH0NpGfFCfktRrrd5oahULLPlH+kayAsop8uN5iMCn7TAbGPAjQqFbwVnw
         Gb3vCSD/i7cZTx2m1VAWsJtJGAzzVTb1QEDNx42VYBpZxSsbsex5Trua2dw0L7qaIasj
         51ZHQelPJNn+Fnx/XFX93c5yMwMTnl6PhYKiItq1fu7U13P/aEEjCT39e49RczriYEmC
         wjqdpb6KBJsbqehudwKg3n811B46ksuEHwP7Z2mvAKXFG++4LfsaMqZGSORgB1LRDnJ7
         MkVj1NtNMKWqqb95SKSS8TqxC673FldvMAtRDiampGlFWRhQbHeQTVnAH5NyC+VNkPqR
         xchA==
X-Gm-Message-State: AOAM531jtoRalZHoYM4tgr0ZjglFxbvJp7aEuUBYQPKp7iNeWgS4ieq2
        3bAxocDioMciVthuSgws9TSTbQ==
X-Google-Smtp-Source: ABdhPJzoe/ddEaVDeSLVgtONhm5KgOQazvs43ameu+yB/9lPqSPaQH+A8djeSriYr4Z251T+osDjRQ==
X-Received: by 2002:a5d:814f:: with SMTP id f15mr4277064ioo.14.1614370933029;
        Fri, 26 Feb 2021 12:22:13 -0800 (PST)
Received: from google.com ([2620:15c:183:200:bd06:d32d:458e:cd3a])
        by smtp.gmail.com with ESMTPSA id a14sm4922614ilj.39.2021.02.26.12.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 12:22:12 -0800 (PST)
Date:   Fri, 26 Feb 2021 13:22:08 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        vbabka@suse.cz, willy@infradead.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH v2 2/3] mm: use PF_NO_TAIL for PG_lru
Message-ID: <YDlYcB7NyNG4N3c6@google.com>
References: <20210224084807.2179942-1-yuzhao@google.com>
 <20210226091718.2927291-1-yuzhao@google.com>
 <20210226091718.2927291-3-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226091718.2927291-3-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 02:17:17AM -0700, Yu Zhao wrote:
> Trying to set or clear PG_lru on tail pages has been considered buggy.
> Enforce this rule by changing the policy for PG_lru from PF_HEAD to
> PF_NO_TAIL. This means setting or clearing PG_lru on tail pages won't
> be "corrected" by compound_page(). Such "correction" isn't helpful --
> even if a piece of buggy code has gotten away with
> compound_page(tail)->flags, it will run into trouble with lru list
> addition and deletion because they use tail->lru rather than
> compound_page(tail)->lru.
> 
> bloat-o-meter result:
>   add/remove: 0/0 grow/shrink: 0/11 up/down: 0/-535 (-535)
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/page-flags.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 1995208a3763..c9626e54df8d 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -333,8 +333,8 @@ PAGEFLAG(Referenced, referenced, PF_HEAD)
>  	__SETPAGEFLAG(Referenced, referenced, PF_HEAD)
>  PAGEFLAG(Dirty, dirty, PF_HEAD) TESTSCFLAG(Dirty, dirty, PF_HEAD)
>  	__CLEARPAGEFLAG(Dirty, dirty, PF_HEAD)
> -PAGEFLAG(LRU, lru, PF_HEAD) __CLEARPAGEFLAG(LRU, lru, PF_HEAD)
> -	TESTCLEARFLAG(LRU, lru, PF_HEAD)

As a side note, IMO, testing PG_lru on compound_head(tail)->flags is
a bug because it defeats the purpose of the following pattern when,
e.g., racing with compound page creations.

This pattern is intended to avoid dirtying struct page cache line when
scanning PFNs speculatively in isolate_migratepages_block() and
page_idle_get_page(). Without compound_head(), it works well when it
misses head pages. But with compound_head(), get_page_unless_zero()
will run unnecessarily on tail pages.

  if (!PageLRU(page) || !get_page_unless_zero(page))
    continue;

  if (!PageLRU(page)) {
    put_page(page);
    continue;
  }

  do_something();
