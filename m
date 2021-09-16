Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA240D08D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhIPAG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232465AbhIPAGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:06:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6597D61165;
        Thu, 16 Sep 2021 00:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631750705;
        bh=Qe2RhOiF6NH6LAk/j0a+uF0k+epN0Ae/d4fNfyU39sM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HkI85ySY9XO0meXDumSGQ7yGTPMCFpr6wCzufDdlD3bVhYn+1/yz/WERV6/BG5kWu
         EkujdztHulhKFWJIDJS46nuOHsCM/ZZEJbFhFcRwRfwSZXjuHyo0DMOXt01BzcJjbH
         JvW/ukfC5HuyiMoCHzSZJmTG97z2U7WJeeky280WXVZ1wpS3yvhYjCCGuKZmOSGjDF
         zJ/u8rl/nDE4zLGTSCbNQz7QUkufkV0a2vfqFEX/ODv+ICFD8yhEixBGRvADsX7Ouk
         rMUbYFmQzp/dCXynZxkSXZ7RXtlLsAFqB7oN2M3aHxdKpTe9tGlLAOw58nG7FrMTxN
         mycwsR65D96gA==
Date:   Thu, 16 Sep 2021 09:05:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 3/3] bootconfig: Free xbc_data in xbc_destroy_all()
Message-Id: <20210916090503.c9d8209e8c88e9c4c7d3072c@kernel.org>
In-Reply-To: <20210915102354.2841798d@oasis.local.home>
References: <163171196689.590070.15063104707696447188.stgit@devnote2>
        <163171199244.590070.6356174550728998874.stgit@devnote2>
        <20210915102354.2841798d@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 10:23:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 15 Sep 2021 22:19:52 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > @@ -810,6 +811,8 @@ void __init xbc_destroy_all(void)
> >   * In error cases, @emsg will be updated with an error message and
> >   * @epos will be updated with the error position which is the byte offset
> >   * of @buf. If the error is not a parser error, @epos will be -1.
> > + * Note that the @buf ownership is transferred, so it will be freed
> > + * in xbc_destroy_all().
> >   */
> >  int __init xbc_init(char *buf, const char **emsg, int *epos)
> >  {
> 
> I hate this "ownership transfer". Looking at the use case here:
> 
> init/main.c:
> 
> 	copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);
> 	if (!copy) {
> 		pr_err("Failed to allocate memory for bootconfig\n");
> 		return;
> 	}
> 
> 	memcpy(copy, data, size);
> 	copy[size] = '\0';
> 
> 	ret = xbc_init(copy, &msg, &pos);
> 	if (ret < 0) {
> 
> Instead of having xbc_init() return the node count on success, how about
> having it allocate the buffer to use and then return it?
> 
> That is, move the:
> 
> 	copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);
> 	if (!copy) {
> 		pr_err("Failed to allocate memory for bootconfig\n");
> 		return;
> 	}
> 
> 	memcpy(copy, data, size);
> 	copy[size] = '\0';
> 
> into xbc_init(), and have data, and size be passed to it.
> 
> Then, have it return the pointer of "copy" or NULL on error?

Thanks for pointing it out, that is also good to me.
Let me update it.

> 
> This will keep the semantics of xbc_* owning the buffer that gets
> freed by the destroy.
> 
> The xbc_init() could also do the pr_info() that prints the bytes and
> node count. There's no other reason to pass that node count to the
> caller, is there?

Ah, it is my policy that the error or information message is shown
by caller (since caller can also ignore that, e.g. passing the
testing data), not from the library code.
I learned that from perf-probe and ftrace, sometimes the library
code reused in unexpected way. So I decided to decouple the
generating error message and showing it.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
