Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC440B760
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhINTBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232378AbhINTBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:01:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD80761155;
        Tue, 14 Sep 2021 19:00:00 +0000 (UTC)
Date:   Tue, 14 Sep 2021 14:59:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [GIT PULL] tracing: Fixes to bootconfig memory management
Message-ID: <20210914145953.189f15dc@oasis.local.home>
In-Reply-To: <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
References: <20210914105620.677b90e5@oasis.local.home>
        <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 11:01:31 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> All of these are just plain wrong:

I'll revert these, and expect Masami to address the issues you present.

Note, they do fix a real bug as shown by:

  https://lore.kernel.org/all/e5c7ce5b-93f0-b305-de32-c99d0390eb28@suse.cz/

> 
> > +static void *init_xbc_data_copy __initdata;
> > +static phys_addr_t init_xbc_data_size __initdata;
> > +               init_xbc_data_copy = copy;
> > +               init_xbc_data_size = size + 1;
> > +       memblock_free(__pa(init_xbc_data_copy), init_xbc_data_size);  
> 
> because the xbc code already saves these as xbc_data/xbc_data_size and
> that final free should just be done in xbc_destroy_all().
> 
> So this fix is pointlessly ugly to begin with.
> 
> But what I _really_ ended up reacting to was that
> 
> > +               memblock_free(__pa(copy), size + 1);  

Should we hold off until mm has fixed this issue?

-- Steve

