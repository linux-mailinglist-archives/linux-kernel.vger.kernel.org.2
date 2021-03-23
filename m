Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F6345561
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhCWCMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCWCLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:11:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E339C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0jV8L/eta9FUAW6CaxrcK1SMnq0K3JU8UUtVFBh1gwA=; b=YwTPJ8jt+kwsZR3kT+ATPd0haX
        KaSdDuDBAgCK1eYS79Qpn8PGTIONmZQEbbQKB2ntdrD0pThDWhDT4xrrXO+KG4l0sFX7wJjQO6ccx
        WGcW2ltnUYgJl+Um/A4QSmDPS8ca1WsF14sxlmwdEdnZrCG2KgOiFDRiuQAFP+VKS+37nTfqg1Q67
        z9/RqD2ECS2rYuMjSa6TSPtcergEqN113zNeJM6oNDJsuSmNlpUa6cZETlbX7MVlp8J3a/bI98f70
        P1Puoeu98IA3tu3UHnQwzCVIWmWddRWpqy8Ba0jTJiJChjH/I7+6T1u5ePWvF8RlVtHJEhbTpPNZS
        s6w1nurA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOWW1-009OoH-84; Tue, 23 Mar 2021 02:11:31 +0000
Date:   Tue, 23 Mar 2021 02:11:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/23] mm: Introduce zap_details.zap_flags
Message-ID: <20210323021129.GZ1719932@casper.infradead.org>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323004912.35132-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323004912.35132-8-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 08:48:56PM -0400, Peter Xu wrote:
> +/* Whether to check page->mapping when zapping */
> +#define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
> +
>  /*
>   * Parameter block passed down to zap_pte_range in exceptional cases.
>   */
>  struct zap_details {
> -	struct address_space *check_mapping;	/* Check page->mapping if set */
> +	struct address_space *zap_mapping;	/* Check page->mapping if set */

Now the comment is wrong.  It used to mean "If this is NULL, zap pages
with any mapping", but now it's always set, and the decision about whether
to check the mapping is in the flag.

Honestly, I'd remove the comments from both these members.  They don't add
anything to understandability now.

> +	unsigned long zap_flags;		/* Special flags for zapping */
>  };
