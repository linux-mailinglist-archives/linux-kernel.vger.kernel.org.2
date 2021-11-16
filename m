Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5701B453B98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhKPV3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:29:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhKPV3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:29:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BCCA63217;
        Tue, 16 Nov 2021 21:26:55 +0000 (UTC)
Date:   Tue, 16 Nov 2021 16:26:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix spelling mistake "aritmethic" ->
 "arithmetic"
Message-ID: <20211116162653.6e0beb3d@gandalf.local.home>
In-Reply-To: <20211108201513.42876-1-colin.i.king@gmail.com>
References: <20211108201513.42876-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Nov 2021 20:15:13 +0000
Colin Ian King <colin.i.king@googlemail.com> wrote:

> There is a spelling mistake in the tracing mini-HOWTO text. Fix it.

I'll apply this but it could be reverted if someone was using that line to
know if hist triggers are supported. The README file is user space ABI, so
changes need to be carefully done, even if it means keeping misspellings.

-- Steve

> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index f9139dc1262c..b8e8f1962189 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5623,7 +5623,7 @@ static const char readme_msg[] =
>  	"\t        - a numeric literal: e.g. ms_per_sec=1000,\n"
>  	"\t        - an arithmetic expression: e.g. time_secs=current_timestamp/1000\n"
>  	"\n"
> -	"\t    hist trigger aritmethic expressions support addition(+), subtraction(-),\n"
> +	"\t    hist trigger arithmetic expressions support addition(+), subtraction(-),\n"
>  	"\t    multiplication(*) and division(/) operators. An operand can be either a\n"
>  	"\t    variable reference, field or numeric literal.\n"
>  	"\n"

