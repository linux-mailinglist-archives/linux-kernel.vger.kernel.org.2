Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FA03A2041
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFIWiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbhFIWiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:38:50 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 685C26139A;
        Wed,  9 Jun 2021 22:36:55 +0000 (UTC)
Date:   Wed, 9 Jun 2021 18:36:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] tracing: Simplify the max length test when using
 the filtering temp buffer
Message-ID: <20210609183653.0b77510c@rorschach.local.home>
In-Reply-To: <CAHk-=wj3S_DxdQkXVaQKcUBCyjiYHC3KqPBTMY151rvZzqKVFQ@mail.gmail.com>
References: <20210609220457.220164154@goodmis.org>
        <20210609220537.927890401@goodmis.org>
        <CAHk-=wj3S_DxdQkXVaQKcUBCyjiYHC3KqPBTMY151rvZzqKVFQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 15:21:52 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Jun 9, 2021 at 3:05 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >                 val = this_cpu_inc_return(trace_buffered_event_cnt);
> > -               if ((len < (PAGE_SIZE - sizeof(*entry) - sizeof(entry->array[0]))) && val == 1) {
> > +               if (val == 1 && unlikely(len < max_len)) {  
> 
> unlikely? No.

Bah, that was suppose to be "likely()" :-p

> 
> Also, I still think that "len < max_len" should actually be "len <=
> max_len".  It should be ok to use the whole page, no?

Sure, I was still being paranoid. ;-)

> 
> Unless there is some *other* overflow issue, and "len" doesn't contain
> a terminating NUL character or something like that.
> 

No, this is kind of like an internal "malloc", where the caller is
passing in the length via "len" of what it needs.

-- Steve
