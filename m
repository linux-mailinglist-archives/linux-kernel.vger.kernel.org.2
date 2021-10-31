Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5B6440E7A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 13:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhJaM7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhJaM7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 08:59:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94019C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 05:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vksooUceYy57ZAFzmLNWbTzWlOTs21ncEuVv2N8+e0A=; b=cfZJ6MCQh/tPCHcS/7woXDyzzj
        aNjFNcRUb/iwdafRWYFJuGNt2R1XhqmKAiY307ilxLGtGagE9+cOq58xle6DPSZ8hJeZgzpwPOzFr
        cCqnkaYpmbr8/auXfGbKwgKy+UFTI+4OsewNHzxJMZ5IqM+sNGAOllUiT1wBp9rtpTBgMwb/lknvd
        3PEjIhFAzv9X8U2LetFnRYZT7XcQzoU2Qa3YjvqiTbNn+J6//FvUHEsi461in00AxqgT2GowECJwb
        Ga9usZOjcap/EhQxVoAOrKHRFo+bq1yTg+i4Ovjk+smIS7zddL75HYVjcxL4uf8oaqQn+8gXvdmGT
        B5BjOk+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhALc-0032gK-HX; Sun, 31 Oct 2021 12:54:20 +0000
Date:   Sun, 31 Oct 2021 12:54:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, wuxu.wu@huawei.com,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] mm, slub: place the trace before freeing memory in
 kmem_cache_free()
Message-ID: <YX6R7EUdxok8phma@casper.infradead.org>
References: <867f6da4-6d38-6435-3fbb-a2a3744029f1@huawei.com>
 <CAMZfGtU+wyjD6e0Xm7-toqqfA2tsu8nSUQJsZdC=piZzgq76fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtU+wyjD6e0Xm7-toqqfA2tsu8nSUQJsZdC=piZzgq76fw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2021 at 08:23:12PM +0800, Muchun Song wrote:
> On Sat, Oct 30, 2021 at 6:12 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
> >
> > After the memory is freed, it may be allocated by other CPUs and has
> > been recorded by trace. So the timing sequence of the memory tracing is
> > inaccurate.
> >
> > For example, we expect the following timing sequeuce:
> >
> >     CPU 0                 CPU 1
> >
> >   (1) alloc xxxxxx
> >   (2) free  xxxxxx
> >                          (3) alloc xxxxxx
> >                          (4) free  xxxxxx
> >
> > However, the following timing sequence may occur:
> >
> >     CPU 0                 CPU 1
> >
> >   (1) alloc xxxxxx
> >                          (2) alloc xxxxxx
> >   (3) free  xxxxxx
> >                          (4) free  xxxxxx
> >
> > So place the trace before freeing memory in kmem_cache_free().
> 
> Could you tell me what problem you have encountered
> here?

It's confusing to see the memory allocated before it's freed.  If you're
unaware of this problem, you might think it was being used after free
because (1) happened a long time ago, so you see (2) immediately followed
by (3) and then see the memory being used.

The patch makes sense to me.
