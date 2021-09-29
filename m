Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9570341CFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 01:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbhI2X1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 19:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245025AbhI2X1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 19:27:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A2AB61504;
        Wed, 29 Sep 2021 23:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632957939;
        bh=xUoojM5baZbirs9n9pr5p0EQ68LtFMWxRkYfM9vHTrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xXoW1nkhG5+Xw7yT2XvU8PGVUVE/7WTX2YuRi/JaC+nKLFdktXY5T00uXpCkrHVOH
         nhCsbNPC43twMUhs60qozYairoRHpJQrynslXyqCgZ+e0ra8zVcs47mXjoYC4zCNwq
         crlC5ixAuTkJMRo7zORBkUtvy5sbGpEoaUuH4v8s=
Date:   Wed, 29 Sep 2021 16:25:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Zhenguo Yao <yaozhenguo1@gmail.com>, mike.kravetz@oracle.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        corbet@lwn.net, yaozhenguo@jd.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [PATCH v7] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
Message-Id: <20210929162538.5c1452d63e064bf9da3cc9e5@linux-foundation.org>
In-Reply-To: <YVToRpjbg5mO0bru@kernel.org>
References: <20210927104149.46884-1-yaozhenguo1@gmail.com>
        <YVS9VhrAuKE2YdbF@archlinux-ax161>
        <YVToRpjbg5mO0bru@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 15:27:18 -0700 Mike Rapoport <rppt@kernel.org> wrote:

> > mm/hugetlb.c:2957:33: error: variable 'm' is used uninitialized whenever '&&' condition is false [-Werror,-Wsometimes-uninitialized]
> >         for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
> >         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > mm/hugetlb.c:1254:3: note: expanded from macro 'for_each_node_mask_to_alloc'
> >                 nr_nodes > 0 &&                                         \
> >                 ^~~~~~~~~~~~
> > mm/hugetlb.c:2974:18: note: uninitialized use occurs here
> >         INIT_LIST_HEAD(&m->list);
> >                         ^
> > mm/hugetlb.c:2957:33: note: remove the '&&' if its condition is always true
> >         for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
> >                                        ^
> > mm/hugetlb.c:2942:29: note: initialize the variable 'm' to silence this warning
> >         struct huge_bootmem_page *m;
> >                                    ^
> >                                     = NULL
> > 1 error generated.
> > 
> > I am not sure if it is possible for nr_nodes to be 0 right out of the
> > gate so might be a false positive?
> 
> With nr_nodes == 0 there will be no memory in the system :)

Let's keep clang happy?

--- a/mm/hugetlb.c~hugetlbfs-extend-the-definition-of-hugepages-parameter-to-support-node-allocation-fix
+++ a/mm/hugetlb.c
@@ -2939,7 +2939,7 @@ int alloc_bootmem_huge_page(struct hstat
 	__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
 int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 {
-	struct huge_bootmem_page *m;
+	struct huge_bootmem_page *m = NULL;	/* initialize for clang */
 	int nr_nodes, node;
 
 	if (nid >= nr_online_nodes)
_

