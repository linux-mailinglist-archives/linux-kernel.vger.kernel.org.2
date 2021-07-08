Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011723BF46C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 06:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhGHEKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 00:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhGHEKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 00:10:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 695E461CDD;
        Thu,  8 Jul 2021 04:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625717291;
        bh=boW1AcRJ4UzHMtEsuJgWXTE8IJMsnRRxwrRVUm6hleY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gTe0Ff0UqOBitlEDUoYjuOUNE3n3kbN2XCbBGB9Vq/+c95qhbEvAead9C1rTNvZZr
         TuBo1j++cPPMi+JH9y9e1S5N8bYh+4T9tK44lGvxZD6hF0rYpGoBRRPXpEilrRqMYN
         C1MGwSy/IfsFOyUImoqGVCIDRCq0j6/rVTYl1Gxt+kfvu+dS70GMfouPD4ytRzHpv9
         jfXmpaFtfudw73keDftdeEhjsj+0FCpX5psOHhrmIgfWDMQVIAI8EMb0diXmXTQJyH
         zKBOhCFh+UQMxGig3P2F3S4P4a/T+bmu6RO1RgOEIyEch9+kav3rmuA9WRMWpV30+M
         PPDmh7jif9AxA==
Date:   Thu, 8 Jul 2021 13:08:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] tracing/selftests: Add tests to test histogram sym and
 sym-offset modifiers
Message-Id: <20210708130807.f502ab87cdc7bc90a47b211f@kernel.org>
In-Reply-To: <20210707121451.101a1002@oasis.local.home>
References: <20210707121451.101a1002@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2021 12:14:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Add a test to the tracing selftests that will catch if the .sym or
> .sym-offset modifiers break in the future.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> ---
>  .../ftrace/test.d/trigger/trigger-hist.tc      | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
> index 2950bfbc6fce..adae72665500 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist.tc
> @@ -39,6 +39,24 @@ grep "parent_comm: $COMM" events/sched/sched_process_fork/hist > /dev/null || \
>  
>  reset_trigger
>  
> +echo "Test histogram with sym modifier"
> +
> +echo 'hist:keys=call_site.sym' > events/kmem/kmalloc/trigger
> +for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
> +grep '{ call_site: \[[0-9a-f][0-9a-f]*\] [_a-zA-Z][_a-zA-Z]* *}' events/kmem/kmalloc/hist > /dev/null || \
> +    fail "sym modifier on kmalloc call_site did not work"
> +
> +reset_trigger
> +
> +echo "Test histogram with sym-offset modifier"
> +
> +echo 'hist:keys=call_site.sym-offset' > events/kmem/kmalloc/trigger
> +for i in `seq 1 10` ; do ( echo "forked" > /dev/null); done
> +grep '{ call_site: \[[0-9a-f][0-9a-f]*\] [_a-zA-Z][_a-zA-Z]*+0x[0-9a-f][0-9a-f]*' events/kmem/kmalloc/hist > /dev/null || \
> +    fail "sym-offset modifier on kmalloc call_site did not work"
> +
> +reset_trigger
> +
>  echo "Test histogram with sort key"
>  
>  echo 'hist:keys=parent_pid,child_pid:sort=child_pid.ascending' > events/sched/sched_process_fork/trigger
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
