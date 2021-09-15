Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C8940C765
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbhIOOZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237755AbhIOOZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:25:21 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6DF46113E;
        Wed, 15 Sep 2021 14:24:01 +0000 (UTC)
Date:   Wed, 15 Sep 2021 10:23:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 3/3] bootconfig: Free xbc_data in xbc_destroy_all()
Message-ID: <20210915102354.2841798d@oasis.local.home>
In-Reply-To: <163171199244.590070.6356174550728998874.stgit@devnote2>
References: <163171196689.590070.15063104707696447188.stgit@devnote2>
        <163171199244.590070.6356174550728998874.stgit@devnote2>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 22:19:52 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> @@ -810,6 +811,8 @@ void __init xbc_destroy_all(void)
>   * In error cases, @emsg will be updated with an error message and
>   * @epos will be updated with the error position which is the byte offset
>   * of @buf. If the error is not a parser error, @epos will be -1.
> + * Note that the @buf ownership is transferred, so it will be freed
> + * in xbc_destroy_all().
>   */
>  int __init xbc_init(char *buf, const char **emsg, int *epos)
>  {

I hate this "ownership transfer". Looking at the use case here:

init/main.c:

	copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);
	if (!copy) {
		pr_err("Failed to allocate memory for bootconfig\n");
		return;
	}

	memcpy(copy, data, size);
	copy[size] = '\0';

	ret = xbc_init(copy, &msg, &pos);
	if (ret < 0) {

Instead of having xbc_init() return the node count on success, how about
having it allocate the buffer to use and then return it?

That is, move the:

	copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);
	if (!copy) {
		pr_err("Failed to allocate memory for bootconfig\n");
		return;
	}

	memcpy(copy, data, size);
	copy[size] = '\0';

into xbc_init(), and have data, and size be passed to it.

Then, have it return the pointer of "copy" or NULL on error?

This will keep the semantics of xbc_* owning the buffer that gets
freed by the destroy.

The xbc_init() could also do the pr_info() that prints the bytes and
node count. There's no other reason to pass that node count to the
caller, is there?

-- Steve
