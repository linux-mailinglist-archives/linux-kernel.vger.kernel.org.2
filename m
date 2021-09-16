Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7676740D09D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhIPAJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233213AbhIPAJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:09:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 670BA61165;
        Thu, 16 Sep 2021 00:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631750863;
        bh=1THsqh9OCYGVNJTkEDYNJGExl363eF6Fh2/9D/hg9U0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JJCl2wkwWSjLKAAQ3vrnKJkRNSj1DTRM0YlQVkujVl7gtAXMeOUlVUcLnk7jnsNjS
         dD2xXdoQIirFoE7urN9WfbF1o2+C1pL1hZYzNzywz4CfN0uZLSc250r27EmbYkQ0GC
         pBrV2V0Vz7HantC3sTrddlRfmBYzSgcpbMPcKgmfqZlsaOcPdO+ewgn/QiKmNI0ZJ3
         6TdAsYEBsC4hIBe3nnSO9gjO8m8GDgXi3Dm0bEeJBeLhSSA4JdrjAEnGrKZIxTJBfj
         eWFGmNvZLmfdPfFVo378pOywjLLhzH8wWAGV46nblMMZ8RMJurqQx44J/QAvipW4Un
         uwRlehHxvUL0g==
Date:   Thu, 16 Sep 2021 09:07:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 0/3] bootconfig: Fixes to bootconfig memory
 management
Message-Id: <20210916090740.eeea3a0d73ba659c9ea68df2@kernel.org>
In-Reply-To: <CAHk-=win5Syn-=2viR6MHCBnhBNh=wj2c189pa_=-9g3OdMEuQ@mail.gmail.com>
References: <163171196689.590070.15063104707696447188.stgit@devnote2>
        <CAHk-=wjtP5U-jr7cpTS78iqyh6rys15-Gf0VwoqngNNH1AQH8Q@mail.gmail.com>
        <CAHk-=win5Syn-=2viR6MHCBnhBNh=wj2c189pa_=-9g3OdMEuQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 09:51:15 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Sep 15, 2021 at 9:47 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > IOW, I'll apply your trivial fixup for the bootconfig copy of
> > memblock.h, and forget about it, and then if we end up having more
> > problems with it later, we can look at a bigger fix.

Thanks, and OK, I'll try to solve this issue.

> 
> Just to clarify - I applied that build fix directly to my tree, but
> this series of leak fixes I'll leave for the tracing tree.

OK, I got it.


Thank you,

> 
>              Linus


-- 
Masami Hiramatsu <mhiramat@kernel.org>
