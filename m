Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6215C418DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 04:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhI0CsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 22:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhI0CsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 22:48:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A9EC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 19:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k2A/LhTENoKqHIRa0xasZJjq7PMzUxcVqZzt/hWLzM8=; b=dJxBsmBHzkymd2Ilgqzsco8vCt
        B/riiHML9ZO2O6Cbe5omNO+vNqrXyBd4GZUEu1/2IHfSTt1zjiD2c9iPMClQNN+A0gDb9ZrptnOuq
        ykjzwt1PJMQLmaHNWiLkl89I6lGCrhkeuDvIRVfzWzBWmcEHlvXKGe3P8cXEKbrUQMtK4p7eZSac6
        onHyXgWXL0ptj4mzK9Ndlr+LHygMxesSXO83acSN5QFz8i+wG/0VKGGLAFYc0TsOhmQOtwxwEf9Hf
        H2ee+o6jSc+zvy40kikUBP0BTTc/3HlC/tbAgkYCr9sWgbFKMajIYWc22wRowf0R8UVrwxXyb21jC
        Y98XKi1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUgan-009Mwc-Pd; Mon, 27 Sep 2021 02:44:47 +0000
Date:   Mon, 27 Sep 2021 03:42:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     shakeelb@google.com, vbabka@suse.cz,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] slub: Add back check for free nonslab objects
Message-ID: <YVEvgfJQJ1aRerg6@casper.infradead.org>
References: <20210927021538.155991-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927021538.155991-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:15:38AM +0800, Kefeng Wang wrote:
> Commit ("0937502af7c9 slub: Add check for kfree() of non slab objects.")
> add the ability, which should be needed in any configs to catch the
> invalid free, they even could be potential issue, eg, memory corruption,
> use after free and double-free, so replace VM_BUG_ON_PAGE to WARN_ON, and
> add dump_page() to help use to debug the issue.

Is dump_page() really the best way to catch such a thing?  I would have
thought that printing the address of 'object' would be more helpful.

> @@ -3522,7 +3522,8 @@ static inline void free_nonslab_page(struct page *page, void *object)
>  {
>  	unsigned int order = compound_order(page);
>  
> -	VM_BUG_ON_PAGE(!PageCompound(page), page);
> +	if (WARN_ON(!PageCompound(page)))
> +		dump_page(page, "invalid free nonslab page");

