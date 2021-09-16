Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5301F40EDD4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbhIPXWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236843AbhIPXWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:22:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9989561029;
        Thu, 16 Sep 2021 23:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631834447;
        bh=zMDyHlN0CSjI4jkyYQWSQq6gwE/Y3QcU/6y3Jk80zNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZFPtIiASvBkat/sbfqegF8C0+lcqQKawqT8xCTdprpVJafOsgTqZcNnuV4kN22WaU
         Eg7XWrTlvhr4i6QteyIToBJT2OqATmNGnRFwm8laR9l0WbVoSfxwuzhBOb39cgTkTY
         BmBIo6L6TUFZUnH/09DGQchogF2B8dGRFJhWSM4PlDSJIqxLMVmDoedUH0/1t08+Wt
         MYo+/3nxgx3c0++4EOcDyOt7KYEz5i5SB06XgeEdtYQ8+to8+xVZmpkZG/JpmFykRE
         eproXCUybKvXiii5pfXnXW5GblA10jFmnd/prSn9upzeb/9EyEODJIVjZRm6JfeuYU
         JEEVZpwM13EfQ==
Date:   Fri, 17 Sep 2021 08:20:44 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 4/4] bootconfig: Rename xbc_destroy_all() to
 xbc_fini()
Message-Id: <20210917082044.dddc65ee8114828f4c54e3ab@kernel.org>
In-Reply-To: <20210916164805.32592423@gandalf.local.home>
References: <163177338366.682366.5998343833719057348.stgit@devnote2>
        <163177341667.682366.1520674275752512771.stgit@devnote2>
        <20210916092630.48e01b5e@gandalf.local.home>
        <CAHk-=wgsST9kbbDf9a3pa91jaPS-of2fB5L2808APd1mnMpCPQ@mail.gmail.com>
        <20210916164805.32592423@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 16:48:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 16 Sep 2021 13:16:59 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > So I'm not going to NAK 'fini', but it's a completely stupid and
> > pointless thing to use and there are better character sequences that
> > aren't any more typing and are real words.
> 
> I didn't like it when I first saw it, but only was going to take it because
> it's used elsewhere in the kernel.
> 
> Because of your response, and my initial feeling about the change, I'm going
> to leave this patch out, and just review and accept the first three patches
> in the series.
> 
> Masami, are you OK with that?

Yes, I'm OK. And I will update it to use "xbc_exit()" then.

Anyway, it is good to know your opinion about this. :-)
I also noticed this "_fini" recently when reviewing patches.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
