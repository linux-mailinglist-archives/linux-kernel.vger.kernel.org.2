Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DDE43CB68
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242353AbhJ0ODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237334AbhJ0ODx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:03:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B8860F9D;
        Wed, 27 Oct 2021 14:01:27 +0000 (UTC)
Date:   Wed, 27 Oct 2021 10:01:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: Fix to initialize 'ret' local variable
Message-ID: <20211027100126.58769bf9@gandalf.local.home>
In-Reply-To: <163534286875.793799.13298849524607405594.stgit@devnote2>
References: <163534286875.793799.13298849524607405594.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 22:54:28 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fix xbc_parse_tree() to initialize the 'ret' local variable
> before referring in the loop.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> Fixes: f3668cde8562 ("bootconfig: Split parse-tree part from xbc_init")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Heh, I just sent the exact same thing. But you have the wrong fixes tag I
believe. As that change just moved the code, but the original location had
the same issue I believe.

I'm fine taking yours instead. But I'd like to update the text explaining
how the ret can be uninitialized and what happens if we set it to zero.

-- Steve


> ---
>  lib/bootconfig.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index a10ab25f6fcc..70e0d52ffd24 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -836,7 +836,7 @@ static int __init xbc_verify_tree(void)
>  static int __init xbc_parse_tree(void)
>  {
>  	char *p, *q;
> -	int ret, c;
> +	int ret = 0, c;
>  
>  	last_parent = NULL;
>  	p = xbc_data;

