Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38EA352123
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhDAUx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235073AbhDAUxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:53:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B0A60BBB;
        Thu,  1 Apr 2021 20:53:06 +0000 (UTC)
Date:   Thu, 1 Apr 2021 16:53:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] ftrace: Check if pages were allocated before calling
 free_pages()
Message-ID: <20210401165304.187c7f7e@gandalf.local.home>
In-Reply-To: <CAHk-=wg_6JBGSiKtQp7CT99kFt2L5b1sbvs6YBTXJAWdPc8Hig@mail.gmail.com>
References: <20210331092711.2b23fcff@gandalf.local.home>
        <CAHk-=wjt9b7kxQ2J=aDNKbR1QBMB3Hiqb_hYcZbKsxGRSEb+gQ@mail.gmail.com>
        <CAHk-=whyMxheOqXAORt9a7JK9gc9eHTgCJ55Pgs4p=X3RrQubQ@mail.gmail.com>
        <20210401160710.45a7a9b8@gandalf.local.home>
        <CAHk-=wg_6JBGSiKtQp7CT99kFt2L5b1sbvs6YBTXJAWdPc8Hig@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 13:18:59 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Apr 1, 2021 at 1:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 31 Mar 2021 11:03:21 -0700
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > > @@ -6231,7 +6231,8 @@ static int ftrace_process_locs(struct module *mod,
> > >               if (!addr)
> > >                       continue;
> > >
> > > -             if (pg->index == pg->size) {
> > > +             end_offset = (pg->index+1) * sizeof(pg->records[0]);
> > > +             if (end_offset < PAGE_SIZE << pg->order) {
> >
> > I believe that needs to be:
> >
> >         if (end_offset >= PAGE_SIZE << pg->order) {
> 

[..]

> which will be
> 
>         end_offset = (3+1) * 1024;
> 
> ie 4096. That just means that the struct fill fill things _up_to_ the
> end of the page.
> 
> So only when the end_offset is strictly larger than the page would it
> have overflowed the allocation.

Ah, I forgot about the "+1" you added to the pg->index, which would make it
equivalent to replacing:

	if (pg->index + 1 > pg->size) {


Will update and add your SOB.

Thanks,

-- Steve

