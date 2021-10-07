Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726ED424B70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 03:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbhJGBEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 21:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240114AbhJGBEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 21:04:12 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62A8060F6B;
        Thu,  7 Oct 2021 01:02:18 +0000 (UTC)
Date:   Wed, 6 Oct 2021 21:02:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 1/4] bootconfig: init: Fix memblock leak in
 xbc_make_cmdline()
Message-ID: <20211006210216.2fdf63cd@rorschach.local.home>
In-Reply-To: <163177339181.682366.8713781325929549256.stgit@devnote2>
References: <163177338366.682366.5998343833719057348.stgit@devnote2>
        <163177339181.682366.8713781325929549256.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 15:23:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Free unused memblock in a error case to fix memblock leak
> in xbc_make_cmdline().
> 
> Fixes: 51887d03aca1 ("bootconfig: init: Allow admin to use bootconfig for kernel command line")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  init/main.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/init/main.c b/init/main.c
> index 3f7216934441..0b054fff8e92 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -382,6 +382,7 @@ static char * __init xbc_make_cmdline(const char *key)
>  	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root);
>  	if (ret < 0 || ret > len) {
>  		pr_err("Failed to print extra kernel cmdline.\n");
> +		memblock_free_ptr(new_cmdline, len + 1);
>  		return NULL;
>  	}
>  

Hmm, looking at my patch queue, I noticed that this did not get
applied. I'm thinking I may have been confused with the other memory
freeing that was put into the xbc_destroy(), thinking this was part of
that. But now that I look at this patch in the context of the code, it
looks like this patch is required, as "new_cmdline" never gets exposed
on this error.

Masami, I just want to confirm, that this patch is still relevant, right?

Thanks!

-- Steve
