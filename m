Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7540EBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbhIPUt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233853AbhIPUt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:49:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCCD361056;
        Thu, 16 Sep 2021 20:48:06 +0000 (UTC)
Date:   Thu, 16 Sep 2021 16:48:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 4/4] bootconfig: Rename xbc_destroy_all() to
 xbc_fini()
Message-ID: <20210916164805.32592423@gandalf.local.home>
In-Reply-To: <CAHk-=wgsST9kbbDf9a3pa91jaPS-of2fB5L2808APd1mnMpCPQ@mail.gmail.com>
References: <163177338366.682366.5998343833719057348.stgit@devnote2>
        <163177341667.682366.1520674275752512771.stgit@devnote2>
        <20210916092630.48e01b5e@gandalf.local.home>
        <CAHk-=wgsST9kbbDf9a3pa91jaPS-of2fB5L2808APd1mnMpCPQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 13:16:59 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So I'm not going to NAK 'fini', but it's a completely stupid and
> pointless thing to use and there are better character sequences that
> aren't any more typing and are real words.

I didn't like it when I first saw it, but only was going to take it because
it's used elsewhere in the kernel.

Because of your response, and my initial feeling about the change, I'm going
to leave this patch out, and just review and accept the first three patches
in the series.

Masami, are you OK with that?

-- Steve
