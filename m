Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFCF40BC59
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 01:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhINXqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 19:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235136AbhINXqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:46:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D1E2610D1;
        Tue, 14 Sep 2021 23:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631663097;
        bh=jPzXCbaYboqogHgyU4a5pn1KllvDy5UAWUWaY6rE2as=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p6f2Gt07SptLS5tCsam4bUpPP+zv/8SlZDlGFUQWkbk4L4ffFZ745e6rIWReqSg8V
         NygS9oUCLX7g6LUoZcIO4+2VFg3SR3zkHiBP39SB7Jx80xqNCeEn94sfHGoM2JwAY3
         U/asZb3lkVDSv0o5qtgzw+I+PmHEoUfi83pzq5pyR7mQ/285U3/K9UvJDSXuxjBFLf
         NHPw/wIb62dnvgmMvNgvBQ98E3ab9IBHS0yrEhM3EJzJu7087oE02OVljZ/6Q1AP7y
         OAoWDT/C367QTEgP4CNEm8ACuqDwPHW9JystnNRrgGKyZaN5a8z6ZH9AVe3pWk7lea
         yzOyZi8dO56qA==
Date:   Wed, 15 Sep 2021 08:44:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [GIT PULL] tracing: Fixes to bootconfig memory management
Message-Id: <20210915084454.b72fcdd705e553aabe6bc44e@kernel.org>
In-Reply-To: <20210914170553.7c1e1faa@oasis.local.home>
References: <20210914105620.677b90e5@oasis.local.home>
        <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
        <20210914145953.189f15dc@oasis.local.home>
        <CAHk-=whfA=k0CP_cYzCn3Wt7De-OJQbJbOKsvowuYnxKCAavSg@mail.gmail.com>
        <CAHk-=wg5tJ_+sKKnkzc6nxpfEvvbUG2Yg3zF-vVfUfZD=PFy7Q@mail.gmail.com>
        <CAHk-=whBd5Sgg4if7HB4o0Zrj3eNprKv9U02uEUB1QhQvrsQZw@mail.gmail.com>
        <CAHk-=wipBkq-OeUBsgv-_hvTfg=nveTpiZonWeY1dBMofkjEuw@mail.gmail.com>
        <20210914170553.7c1e1faa@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 17:05:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 14 Sep 2021 13:48:15 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Tue, Sep 14, 2021 at 12:38 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > So I'll do a minimal conversion that adds "memblock_free_ptr()" and
> > > hope that people start using that. And then we can later try to move
> > > "memblock_free()" to a name that isn't so misleading.  
> > 
> > Commit 77e02cf57b6c ("memblock: introduce saner 'memblock_free_ptr()'
> > interface") should hopefully fix that panic that Vlastimil saw, and
> > the kernel test robot report as well.
> > 
> > And it should make it easy to cleanly fix that 'copy' leak too.
> > 
> 
> Vlastimil,
> 
> Can you confirm that Linus's changes addresses your issue?
> 
> Masami,
> 
> Care to rebase on top of Linus's change?

Sure! and I found another memblock leak, so I'll add it too.

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
