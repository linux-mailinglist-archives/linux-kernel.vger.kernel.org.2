Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B72F45B13B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 02:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbhKXBsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 20:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234973AbhKXBsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 20:48:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F01B6608FB;
        Wed, 24 Nov 2021 01:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637718330;
        bh=kiaJRLePvhBgr5TnXI0Vb5WflATcvJsR2VopECRaz+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H4nPHI/Xsmt8UdMFr2vKGoKxP+PJPQ1uaEOkEAr4liBk8OJPrchvj9cfqoUo4v6N4
         yqAVcGYv3w4MtFKJYEInTb9G5m8Km6293hn+f1UUooIOYE0J2xW4DnZgQtKtu0+Wf2
         LpZLa6moC9t/qrJI3mAOvp29wb1ogBA+3vVKCVWeme7oIvfq7vkUuA4dlKR3vsyM0A
         UULujK6QCOArwFCUOjw9kSwiYRA/OiP8S5KKRbSpG7tkhEugqfkg1KJRgL3nxkBpL1
         pFMgtpHXWukHfMKlfJqJKD9frl8Q9jUCMJADbw45GpT01oIvsPsS7w/tNLe2wrm2Yt
         mH5s1uWSj967w==
Date:   Wed, 24 Nov 2021 10:45:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tracing/uprobe: Fix uprobe_perf_open probes iteration
Message-Id: <20211124104526.a9da7deb3fe64c76f0bd9a86@kernel.org>
In-Reply-To: <20211123142801.182530-1-jolsa@kernel.org>
References: <20211123142801.182530-1-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 15:28:01 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> Add missing 'tu' variable initialization in the probes loop,
> otherwise the head 'tu' is used instead of added probes.

Thanks for fixing this bug!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> 
> Fixes: 99c9a923e97a ("tracing/uprobe: Fix double perf_event linking on multiprobe uprobe")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/trace_uprobe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 0a5c0db3137e..f5f0039d31e5 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1313,6 +1313,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
>  		return 0;
>  
>  	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
> +		tu = container_of(pos, struct trace_uprobe, tp);
>  		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
>  		if (err) {
>  			uprobe_perf_close(call, event);
> -- 
> 2.32.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
