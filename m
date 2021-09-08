Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180D5403247
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 03:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346646AbhIHBl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 21:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235180AbhIHBl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 21:41:56 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B0CC60EE6;
        Wed,  8 Sep 2021 01:40:49 +0000 (UTC)
Date:   Tue, 7 Sep 2021 21:40:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Carles Pey <carles.pey@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ftrace: add unit test for removing trace function
Message-ID: <20210907214047.04ef5ac8@rorschach.local.home>
In-Reply-To: <20210904180248.1886220-2-carles.pey@gmail.com>
References: <20210904180248.1886220-1-carles.pey@gmail.com>
        <20210904180248.1886220-2-carles.pey@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Sep 2021 22:02:48 +0400
Carles Pey <carles.pey@gmail.com> wrote:


Two errors here.

-ENOCHANGELOG
-ENOSIG

No matter how trivial the patch, you need a change log. The subject is
"what" the patch does, the change log is "why" it is done. What was the
motivation for this patch.

And more critical, I can't even take this patch because there's no
"Signed-off-by".

-- Steve


> ---
>  kernel/trace/trace_selftest.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
> index adf7ef194005..875b4f1a0476 100644
> --- a/kernel/trace/trace_selftest.c
> +++ b/kernel/trace/trace_selftest.c
> @@ -287,6 +287,40 @@ static int trace_selftest_ops(struct trace_array *tr, int cnt)
>  	if (trace_selftest_test_probe3_cnt != 4)
>  		goto out_free;
>  
> +	/* Remove trace function from probe 3 */
> +	func1_name = "!" __stringify(DYN_FTRACE_TEST_NAME);
> +	len1 = strlen(func1_name);
> +
> +	ftrace_set_filter(&test_probe3, func1_name, len1, 0);
> +
> +	DYN_FTRACE_TEST_NAME();
> +
> +	print_counts();
> +
> +	if (trace_selftest_test_probe1_cnt != 3)
> +		goto out_free;
> +	if (trace_selftest_test_probe2_cnt != 2)
> +		goto out_free;
> +	if (trace_selftest_test_probe3_cnt != 4)
> +		goto out_free;
> +	if (cnt > 1) {
> +		if (trace_selftest_test_global_cnt == 0)
> +			goto out_free;
> +	}
> +	if (trace_selftest_test_dyn_cnt == 0)
> +		goto out_free;
> +
> +	DYN_FTRACE_TEST_NAME2();
> +
> +	print_counts();
> +
> +	if (trace_selftest_test_probe1_cnt != 3)
> +		goto out_free;
> +	if (trace_selftest_test_probe2_cnt != 3)
> +		goto out_free;
> +	if (trace_selftest_test_probe3_cnt != 5)
> +		goto out_free;
> +
>  	ret = 0;
>   out_free:
>  	unregister_ftrace_function(dyn_ops);

