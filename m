Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8C940DB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbhIPN1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240001AbhIPN1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:27:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFFEA61216;
        Thu, 16 Sep 2021 13:26:31 +0000 (UTC)
Date:   Thu, 16 Sep 2021 09:26:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 4/4] bootconfig: Rename xbc_destroy_all() to
 xbc_fini()
Message-ID: <20210916092630.48e01b5e@gandalf.local.home>
In-Reply-To: <163177341667.682366.1520674275752512771.stgit@devnote2>
References: <163177338366.682366.5998343833719057348.stgit@devnote2>
        <163177341667.682366.1520674275752512771.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 15:23:36 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Avoid using this noisy name and use more calm one.
> This is just a name change. No functional change.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  include/linux/bootconfig.h |    2 +-
>  init/main.c                |    2 +-
>  lib/bootconfig.c           |    8 ++++----
>  tools/bootconfig/main.c    |    2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index f955bb7eabbb..ba40194a339c 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -277,7 +277,7 @@ int __init xbc_init(const char *buf, size_t size, const char **emsg, int *epos);
>  int __init xbc_get_info(int *node_size, size_t *data_size);
>  
>  /* XBC cleanup data structures */
> -void __init xbc_destroy_all(void);
> +void __init xbc_fini(void);
>  
>  /* Debug dump functions */
>  void __init xbc_debug_dump(void);
> diff --git a/init/main.c b/init/main.c
> index 747b4fd38a1a..99a23324d4a1 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -463,7 +463,7 @@ static void __init setup_boot_config(void)
>  
>  static void __init exit_boot_config(void)
>  {
> -	xbc_destroy_all();
> +	xbc_fini();

I didn't know this was a thing. But looking for other use cases with
"*_fini(", there seems to be plenty of precedence in the kernel for this
change.

-- Steve


>  }
