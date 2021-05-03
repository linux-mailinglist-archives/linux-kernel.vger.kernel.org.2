Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E47372116
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 22:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhECUEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 16:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhECUEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 16:04:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E28F6115B;
        Mon,  3 May 2021 20:03:36 +0000 (UTC)
Date:   Mon, 3 May 2021 16:03:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Cao jin <jojing64@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ingo Molnar <mingo@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>,
        Wan Jiabing <wanjiabing@vivo.com>, Xu Wang <vulab@iscas.ac.cn>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: Re: [ GIT PULL] tracing: Updates for 5.13
Message-ID: <20210503160335.3f3be2f2@gandalf.local.home>
In-Reply-To: <CAHk-=wgo40oeh3huHvb64KfeNEYXw_hQXLXqujbhYz18TMZ6ZA@mail.gmail.com>
References: <20210503091713.1aa7a7b7@gandalf.local.home>
        <CAHk-=wgo40oeh3huHvb64KfeNEYXw_hQXLXqujbhYz18TMZ6ZA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2021 11:27:02 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > This is the first time I'm sending a pull request with a merge
> > in it. I'm hoping my scripts did everything correctly. Might want
> > to check it a bit more than usual.  
> 
> The merge looks fine. It causes the diffstat to show incorrectly,
> which is normal (and generally avoided by you doing a test merge so
> that you get the diffstat from the merged state - but don't send the
> merge itself to me, just use it to (a) look at what conflicts there
> will be and (b) get that correct diffstat for the end result).

OK, makes sense.

> 
> That said, if the only reason for the merge was one single trivial
> commit, you could just have cherry-picked it instead, avoiding the
> things like "oh, now it has two merge bases so 'diff' no longer has an
> unambiguous result" etc.

I was thinking of doing the simple cherry-pick, but I wanted to test if
merges would work too, as I'm hoping that I can start pulling from others
someday, and not just take patches. I figured I'd try on a trivial merge
to see what breaks.

> 
> But this is fine. If you start doing a lot of merges, I may really ask
> you to then also do that test-merge for the pull request, but if it's

Good to know. If I start pulling more complex merges, I'll do the test
merge for the diffstat then.

Thanks,

-- Steve
