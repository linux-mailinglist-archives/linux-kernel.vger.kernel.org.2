Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C289840B7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhINTQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232682AbhINTQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:16:13 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2503360E8B;
        Tue, 14 Sep 2021 19:14:55 +0000 (UTC)
Date:   Tue, 14 Sep 2021 15:14:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [GIT PULL] tracing: Fixes to bootconfig memory management
Message-ID: <20210914151448.75abc7a5@oasis.local.home>
In-Reply-To: <CAHk-=whfA=k0CP_cYzCn3Wt7De-OJQbJbOKsvowuYnxKCAavSg@mail.gmail.com>
References: <20210914105620.677b90e5@oasis.local.home>
        <CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com>
        <20210914145953.189f15dc@oasis.local.home>
        <CAHk-=whfA=k0CP_cYzCn3Wt7De-OJQbJbOKsvowuYnxKCAavSg@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 12:05:09 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > Note, they do fix a real bug as shown by:
> >
> >   https://lore.kernel.org/all/e5c7ce5b-93f0-b305-de32-c99d0390eb28@suse.cz/  
> 
> Ok, can you send me that NULL ptr check as one separate thing?

Perfect, because that one was added first, and I only need to rebase to
it without changing the history. Although, I will add the tested-by
from Vlastimil and the link he provided. But the actual code has
already ran through my test suite, and I don't need to re-run it.

-- Steve
