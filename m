Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066CD313269
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhBHMdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhBHMWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:22:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DD7C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 04:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y3a1IAgMXErULBk7gX1nRMtG8uMbaf2CkHLwdwfqDFE=; b=tIhB0acp1Jzy+NsV9V22ID3vMr
        PMM7LQqRM5mIiUdIze3klYsisF4z6sZjU716lnYjNZ6f6cNxyS+0iPoyhfuJpO2iwBM+/J3lNvvV+
        K8YTRlLkRIiz5nZTOzBv05gXxjXb+0X97Hfoqk4vN4AccmW7UAwusB8tAtTEWhk2bYdrgLb8DiOHr
        UMNpdvvqR0m3qwflFNX9VNRoRUOgV2v+Q/80HKIR4thOWQ8iIltsmXiO6UcD1moz473gxbUAS+kws
        qpAF3anpTf72AcJjdy28q9D0egPNMk+coghX6Ba3IPz6Dtou1F0DVZWXpIUuC3enriBO7zkyC+WQH
        NYm0C6DA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l95Xh-005wew-V1; Mon, 08 Feb 2021 12:21:26 +0000
Date:   Mon, 8 Feb 2021 12:21:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, cl@linux.com, linmiaohe@huawei.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm, slub: use pGp to print page flags
Message-ID: <20210208122125.GO308988@casper.infradead.org>
References: <20210208101439.55474-1-laoar.shao@gmail.com>
 <20210208101439.55474-2-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208101439.55474-2-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 06:14:37PM +0800, Yafang Shao wrote:
> As pGp has been already introduced in printk, we'd better use it to make
> the output human readable.
> 
> Before this change, the output is,
> [ 6155.716018] INFO: Slab 0x000000004027dd4f objects=33 used=3 fp=0x000000008cd1579c flags=0x17ffffc0010200
> 
> While after this change, the output is,
> [ 8846.517809] INFO: Slab 0x00000000f42a2c60 objects=33 used=3 fp=0x0000000060d32ca8 flags=0x17ffffc0010200(slab|head)
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
