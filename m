Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FAD379ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 01:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhEJXoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 19:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhEJXoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 19:44:13 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC9AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 16:43:08 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso15994670otg.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nI6OyGK/NDS5KWwyMcxjHYV++Bw+P/38diaFjV4zBiw=;
        b=XkLmCEA2tZEsOS/on3p917VhWFUcl7NKtWoH8X+5ICOWQA9u6LahaURWjQ9oOX7lQs
         nZ4hLFWGHFpyLxjIo5yX1Cl/shVaT50CuVuZoAU282yqDKC0ENPL2X8mCH/PmhLWatm4
         73PtM05PUCWd+CFi2fqAg94B9RoBKdViq10QhRWMxkCuWc3Z/iVsKLG+J8IIUetA+6QL
         0yBKuttVB/+qHl2Nl/1ghdNfRDN3D9BaObcHMn4HSKndwBx4t/SwllWik37yjCJZgeUa
         W2QyvCdI82v7AGB9qAlntdxswXFb40aSMghDoxeq4EwFTMmrJ4iKjx5c9BC+k9Su8/qM
         8VLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nI6OyGK/NDS5KWwyMcxjHYV++Bw+P/38diaFjV4zBiw=;
        b=jtb7rSnooVA51JXoO53JrU0a4WxJ6QC1QeNAaJvYp8r2m6hyd1YpSAyLoygLSaI24s
         JQWmThk0mU9vnySr5f9KBwW+/YICCd05CWNTkrrdhPk7gy8Aw1pZ0I59AW4KI5LL3xN4
         Sk4m/BOLMTgEX0pAi4PXlMWD8NK0QoXG/DM88NBbH56AE8Yj9sdmqx4l8clN04sL7Trp
         H5utvKyPradT64j1hhvVQvLMh2yWnUusrzUckgmSeDjZvzkOx+XQ3cqqJk4vi6wCo9N1
         Qv18kljj5PrQY92oPtjSpOfPJeLO9gbcNr9XRI/MquONm9PTilDovPiTnadp82vufi9J
         WrjQ==
X-Gm-Message-State: AOAM532jTazhxvQgS2jaCqlM+CuzzbphVCwVcXCpg1B9mlVojiW0TEAq
        TZWKH6GBQY2e/0KhKPBIAJJCgQ==
X-Google-Smtp-Source: ABdhPJwc7k8WryWRBA8BZ3WaBx9TJKkdH+Q2Mb1JowR0hD3dnCw13CNL/cexiLI7pDcx9SPE7hQxlw==
X-Received: by 2002:a05:6830:1b6e:: with SMTP id d14mr6931963ote.65.1620690187161;
        Mon, 10 May 2021 16:43:07 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n98sm3446769ota.24.2021.05.10.16.43.05
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 10 May 2021 16:43:06 -0700 (PDT)
Date:   Mon, 10 May 2021 16:42:48 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Miaohe Lin <linmiaohe@huawei.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] ksm: Revert "use GET_KSM_PAGE_NOLOCK to get ksm page in
 remove_rmap_item_from_tree()"
In-Reply-To: <0e04877c-5b2d-b810-7464-108e793b84d3@huawei.com>
Message-ID: <alpine.LSU.2.11.2105101615570.1127@eggly.anvils>
References: <alpine.LSU.2.11.2105092253500.1127@eggly.anvils> <0e04877c-5b2d-b810-7464-108e793b84d3@huawei.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021, Miaohe Lin wrote:
> On 2021/5/10 13:59, Hugh Dickins wrote:
> > This reverts commit 3e96b6a2e9ad929a3230a22f4d64a74671a0720b.
> > General Protection Fault in rmap_walk_ksm() under memory pressure:
> > remove_rmap_item_from_tree() needs to take page lock, of course.
> > 
> 
> I'am really sorry about it! And many thanks for this bugfix!
> It seems rmap_walk_ksm() relies on the page lock to protect against
> concurrent modifications to that page's node of the stable tree.
> Could you please add a comment in remove_rmap_item_from_tree() to
> clarify this in case similar trouble again? Many thanks!

Sorry, no.  Page lock is held by callers of stable_tree_append() when
adding an rmap_item to the tree, and held by callers of rmap_walk_ksm()
(see VM_BUG_ON_PAGE there) when walking the tree: you would surely
expect some kind of locking when removing an rmap_item from the tree,
and the appropriate page lock is what GET_KSM_PAGE_LOCK provided.

I do not want us to go through the kernel source adding a comment
/* We really mean to take this lock: it protects against concurrency */
every time we take a lock in the kernel: you should generally assume
that if a lock is taken, then the writer intended it to be taken.

There are sure to be some exceptions, where a lock is taken pointlessly:
but please look deeper before assuming that is the case.

Hugh

> 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> > 
> >  mm/ksm.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > --- 5.13-rc1/mm/ksm.c	2021-05-09 17:03:44.010422188 -0700
> > +++ linux/mm/ksm.c	2021-05-09 22:12:39.403008350 -0700
> > @@ -776,11 +776,12 @@ static void remove_rmap_item_from_tree(s
> >  		struct page *page;
> >  
> >  		stable_node = rmap_item->head;
> > -		page = get_ksm_page(stable_node, GET_KSM_PAGE_NOLOCK);
> > +		page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
> >  		if (!page)
> >  			goto out;
> >  
> >  		hlist_del(&rmap_item->hlist);
> > +		unlock_page(page);
> >  		put_page(page);
> >  
> >  		if (!hlist_empty(&stable_node->hlist))
