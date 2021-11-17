Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F137453F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 04:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhKQDuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 22:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhKQDuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 22:50:04 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B58E5619EA;
        Wed, 17 Nov 2021 03:47:05 +0000 (UTC)
Date:   Tue, 16 Nov 2021 22:47:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     kernel-team@android.com, mhiramat@kernel.org, zanussi@kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/histogram: Fix UAF in destroy_hist_field()
Message-ID: <20211116224703.133f1750@rorschach.local.home>
In-Reply-To: <20211117021223.2137117-1-kaleshsingh@google.com>
References: <20211117021223.2137117-1-kaleshsingh@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 18:12:22 -0800
Kalesh Singh <kaleshsingh@google.com> wrote:

> Calling destroy_hist_field() on an expression will recursively free
> any operands associated with the expression. If during expression
> parsing the operands of the expression are already set when an error
> is encountered, there is no need to explicity free the operands. Doing
> so will result in destroy_hist_field() being called twice for the
> operands and lead to a use-after-free (UAF) error.
> 
> Fix this by only calling destroy_hist_field() for the expression if the
> operands are already set.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> Fixes: 8b5d46fd7a38 ("tracing/histogram: Optimize division by constants")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 5ea2c9ec54a6..e3856eaf2ac3 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -2669,7 +2669,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
>  		if (!divisor) {
>  			hist_err(file->tr, HIST_ERR_DIVISION_BY_ZERO, errpos(str));
>  			ret = -EDOM;
> -			goto free;
> +			goto free_expr;
>  		}
>  
>  		/*
> @@ -2709,7 +2709,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
>  		expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
>  		if (!expr->type) {
>  			ret = -ENOMEM;
> -			goto free;
> +			goto free_expr;
>  		}
>  
>  		expr->name = expr_str(expr, 0);
> @@ -2719,6 +2719,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
>  free:
>  	destroy_hist_field(operand1, 0);
>  	destroy_hist_field(operand2, 0);
> +free_expr:
>  	destroy_hist_field(expr, 0);
>  
>  	return ERR_PTR(ret);
> 
> base-commit: 8ab774587903771821b59471cc723bba6d893942

Wouldn't this be a simpler and more robust fix?

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5ea2c9ec54a6..aab69b4ffe11 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2717,8 +2717,10 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 
 	return expr;
 free:
-	destroy_hist_field(operand1, 0);
-	destroy_hist_field(operand2, 0);
+	if (!expr || expr->operand[0] != operand1)
+		destroy_hist_field(operand1, 0);
+	if (!expr || expr->operand[1] != operand2)
+		destroy_hist_field(operand2, 0);
 	destroy_hist_field(expr, 0);
 
 	return ERR_PTR(ret);


I'm worried about the complexity of having to know where to free what,
and not just figuring it out at the end.

-- Steve
