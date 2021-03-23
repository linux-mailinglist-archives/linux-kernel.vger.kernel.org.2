Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C1F346B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhCWVyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbhCWVxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:53:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC909C061765
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=BM40zk4LyHuhuiMVNVI766TuT+5PIp8w2JrM91v81vc=; b=ndU5pvIF2zKGWxgLZvinhz9SpN
        EQhGW1BBFyNsRHs4Dalom4AUrsTkC6Ptfd5zaraGWXSur8C+x8lX1333QxzYWwMEJktsLdzNQQf+a
        Llw5RWBjoHE0szRQmBoq50ZHEFgKnGFCuy+gGI8IJTYX4XwQTsc6l/UfoaqfuNAhpXYvl8UmBkDaO
        MkyQEvBeKCL/Kw0usv+02ZCQxIWDY8NDWVZKbu+nkEBYjDBQS1WSxxeHY80k9AK21IICTVZxAsQHA
        POfnVey5fwyPatpO9/0CgkDOb6lDmsWnBJi9PpW0Amw9WmJX/+cRM72FWvfDLnmp0Ajae4T113cDt
        iInlV2HA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOoxv-00FoLG-L0; Tue, 23 Mar 2021 21:53:34 +0000
Subject: Re: [PATCH] tracing: Trivial typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
References: <20210323203317.31944-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c9589765-b5cd-7cb5-4af5-2f7760a0a7a0@infradead.org>
Date:   Tue, 23 Mar 2021 14:53:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323203317.31944-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 1:33 PM, Bhaskar Chowdhury wrote:
> Trivial spelling fixes.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Ingo has already fixed all of these.
Plus many more that are trace-related.

> ---
>  kernel/trace/trace_seq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
> index 1d84fcc78e3e..e03eae7a5577 100644
> --- a/kernel/trace/trace_seq.c
> +++ b/kernel/trace/trace_seq.c
> @@ -12,11 +12,11 @@
>   * This will set up the counters within the descriptor. You can call
>   * trace_seq_init() more than once to reset the trace_seq to start
>   * from scratch.
>   * The buffer size is currently PAGE_SIZE, although it may become dynamic
>   * in the future.
>   *
> - * A write to the buffer will either succed or fail. That is, unlike
> + * A write to the buffer will either succeed or fail. That is, unlike
>   * sprintf() there will not be a partial write (well it may write into
>   * the buffer but it wont update the pointers). This allows users to
>   * try to write something into the trace_seq buffer and if it fails
> @@ -73,7 +73,7 @@ int trace_print_seq(struct seq_file *m, struct trace_seq *s)
>   * @fmt: printf format string
>   *
>   * The tracer may use either sequence operations or its own
> - * copy to user routines. To simplify formating of a trace
> + * copy to user routines. To simplify formatting of a trace
>   * trace_seq_printf() is used to store strings into a special
>   * buffer (@s). Then the output may be either used by
>   * the sequencer or pulled into another buffer.
> @@ -133,7 +133,7 @@ EXPORT_SYMBOL_GPL(trace_seq_bitmask);
>   * @fmt: printf format string
>   *
>   * The tracer may use either sequence operations or its own
> - * copy to user routines. To simplify formating of a trace
> + * copy to user routines. To simplify formatting of a trace
>   * trace_seq_printf is used to store strings into a special
>   * buffer (@s). Then the output may be either used by
>   * the sequencer or pulled into another buffer.
> @@ -226,7 +226,7 @@ EXPORT_SYMBOL_GPL(trace_seq_puts);
>   * @c: simple character to record
>   *
>   * The tracer may use either the sequence operations or its own
> - * copy to user routines. This function records a simple charater
> + * copy to user routines. This function records a simple character
>   * into a special buffer (@s) for later retrieval by a sequencer
>   * or other mechanism.
>   */
> @@ -348,7 +348,7 @@ int trace_seq_path(struct trace_seq *s, const struct path *path)
>  EXPORT_SYMBOL_GPL(trace_seq_path);
> 
>  /**
> - * trace_seq_to_user - copy the squence buffer to user space
> + * trace_seq_to_user - copy the sequence buffer to user space
>   * @s: trace sequence descriptor
>   * @ubuf: The userspace memory location to copy to
>   * @cnt: The amount to copy
> --


-- 
~Randy

