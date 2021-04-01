Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EAE35208C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhDAUZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234287AbhDAUZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:25:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 017A3610CD;
        Thu,  1 Apr 2021 20:25:21 +0000 (UTC)
Date:   Thu, 1 Apr 2021 16:25:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] ftrace: Check if pages were allocated before calling
 free_pages()
Message-ID: <20210401162520.57a0366c@gandalf.local.home>
In-Reply-To: <20210401160710.45a7a9b8@gandalf.local.home>
References: <20210331092711.2b23fcff@gandalf.local.home>
        <CAHk-=wjt9b7kxQ2J=aDNKbR1QBMB3Hiqb_hYcZbKsxGRSEb+gQ@mail.gmail.com>
        <CAHk-=whyMxheOqXAORt9a7JK9gc9eHTgCJ55Pgs4p=X3RrQubQ@mail.gmail.com>
        <20210401160710.45a7a9b8@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 16:07:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > @@ -6231,7 +6231,8 @@ static int ftrace_process_locs(struct module *mod,
> >  		if (!addr)
> >  			continue;
> >  
> > -		if (pg->index == pg->size) {
> > +		end_offset = (pg->index+1) * sizeof(pg->records[0]);
> > +		if (end_offset < PAGE_SIZE << pg->order) {  
> 
> I believe that needs to be:
> 
> 	if (end_offset >= PAGE_SIZE << pg->order) {
> 
> But as you said, you didn't test it. I'll look to see what else needs to be
> fixed.

After making the above change, it appears to work.

Want to give me your "Signed-off-by"?

-- Steve
