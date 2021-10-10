Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381E3428418
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 00:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhJJWoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 18:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232586AbhJJWoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 18:44:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC5F860F0F;
        Sun, 10 Oct 2021 22:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633905724;
        bh=JlESLPD7yjmMAz+qz4CiD4yeMC2Nn8eK3Msu1ni+Lek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tCcTqAdFqhRaotyRQV+GWKeJRaNGhCMhkj0RHPCdueU1PADTvxl+9hvLy5h4CcK5b
         B15Hxl9JE4SzO1hLJFjZ0EIQ3FLCslRx85bR1J8fOB+lX/zQ6JfEPLAmX+8KEUUpBK
         LG0rOAd7G5/ftpSK+Ooy+0vFwz6q+MTljk1xJvM4=
Date:   Sun, 10 Oct 2021 15:42:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, ultrachin@163.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        brookxu.cn@gmail.com, chen xiaoguang <xiaoggchen@tencent.com>,
        zeng jingxiang <linuszeng@tencent.com>,
        lu yihui <yihuilu@tencent.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH] mm: Free per cpu pages async to shorten program exit
 time
Message-Id: <20211010154201.6a1940a17da6669154d9109c@linux-foundation.org>
In-Reply-To: <8f30837b-5186-e836-21bc-9964456400c1@suse.cz>
References: <20211008063933.331989-1-ultrachin@163.com>
        <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
        <8f30837b-5186-e836-21bc-9964456400c1@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 14:38:15 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 10/8/21 10:17, David Hildenbrand wrote:
> > On 08.10.21 08:39, ultrachin@163.com wrote:
> >> From: chen xiaoguang <xiaoggchen@tencent.com>
> >>
> >> The exit time is long when program allocated big memory and
> >> the most time consuming part is free memory which takes 99.9%
> >> of the total exit time. By using async free we can save 25% of
> >> exit time.
> >>
> >> Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
> >> Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
> >> Signed-off-by: lu yihui <yihuilu@tencent.com>
> > 
> > I recently discussed with Claudio if it would be possible to tear down the
> > process MM deferred, because for some use cases (secure/encrypted
> > virtualization, very large mmaps) tearing down the page tables is already
> > the much more expensive operation.
> 
> OK, but what exactly is the benefit here? The cpu time will have to be spent
> in any case, but we move it to a context that's not accounted to the exiting
> process. Is that good? Also if it's a large process and restarts
> immediately, allocating all the memory back again, it might not be available
> as it's still being freed in the background, leading to a risk of OOM?

Yes, concerns.  Some way of blocking the oom-killer if this freeing is
in progress sounds needed.

Dumb question: can the exiting process just clone(CLONE_MM) then exit? 
Let the child take the burden of all the cleanup?
