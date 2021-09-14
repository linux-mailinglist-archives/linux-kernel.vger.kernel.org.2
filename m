Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCF240B999
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhINVHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233101AbhINVHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:07:41 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7707F6117A;
        Tue, 14 Sep 2021 21:06:19 +0000 (UTC)
Date:   Tue, 14 Sep 2021 17:05:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [GIT PULL] tracing: Fixes to bootconfig memory management
Message-ID: <20210914170553.7c1e1faa@oasis.local.home>
In-Reply-To: <CAHk-=wipBkq-OeUBsgv-_hvTfg=nveTpiZonWeY1dBMofkjEuw@mail.gmail.com>
References: <20210914105620.677b90e5@oasis.local.home>
        <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
        <20210914145953.189f15dc@oasis.local.home>
        <CAHk-=whfA=k0CP_cYzCn3Wt7De-OJQbJbOKsvowuYnxKCAavSg@mail.gmail.com>
        <CAHk-=wg5tJ_+sKKnkzc6nxpfEvvbUG2Yg3zF-vVfUfZD=PFy7Q@mail.gmail.com>
        <CAHk-=whBd5Sgg4if7HB4o0Zrj3eNprKv9U02uEUB1QhQvrsQZw@mail.gmail.com>
        <CAHk-=wipBkq-OeUBsgv-_hvTfg=nveTpiZonWeY1dBMofkjEuw@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 13:48:15 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Sep 14, 2021 at 12:38 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So I'll do a minimal conversion that adds "memblock_free_ptr()" and
> > hope that people start using that. And then we can later try to move
> > "memblock_free()" to a name that isn't so misleading.  
> 
> Commit 77e02cf57b6c ("memblock: introduce saner 'memblock_free_ptr()'
> interface") should hopefully fix that panic that Vlastimil saw, and
> the kernel test robot report as well.
> 
> And it should make it easy to cleanly fix that 'copy' leak too.
> 

Vlastimil,

Can you confirm that Linus's changes addresses your issue?

Masami,

Care to rebase on top of Linus's change?

Thanks!

-- Steve
