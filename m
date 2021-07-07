Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B173BEC46
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhGGQd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhGGQd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:33:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3B2D61CAC;
        Wed,  7 Jul 2021 16:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625675448;
        bh=hFQSmO9JZuU7PCl2e+L0oHy7wyT+9t8i3+Qu5Qji0m0=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=dkncukvVxdLVbUB/3nlKeFY/kQGT4V3/rQZ7wcMxI5PX1KTpSOZUNNqZXZ1Azf4q3
         0qdWwA3alXlmqklyHXekIUM2c2/s/QZqO9FsohRsyE03YY53lcZB1Jv4dJOoMyINS8
         QUvZL0MKmjom4lqUl6+3TpoSVdWxfbj0yaX0QRAAjMdskNvN0oXQHAbnXHNZfzqOmT
         GjCHT0a4FkvTik31uWBZOYUxNXahl2rBkcSPY9IQ84I8xdG3RbA3pdU0H281NvcvYn
         XNW4HH/4sUM+LNoCL1oWykNt4vG9SSbUE1CGXYbwh9NeLfDy55Hb6nYH766Jp1Zv1a
         ovyUV6GRZk7dA==
Message-ID: <9769cf1a02fae0be892d6b69cc624eb2b41c1d4d.camel@kernel.org>
Subject: Re: [PATCH] tracing/histograms: Fix parsing of "sym-offset" modifier
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Date:   Wed, 07 Jul 2021 11:30:46 -0500
In-Reply-To: <20210707110821.188ae255@oasis.local.home>
References: <20210707110821.188ae255@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2021-07-07 at 11:08 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> With the addition of simple mathematical operations (plus and minus),
> the
> parsing of the "sym-offset" modifier broke, as it took the '-' part
> of the
> "sym-offset" as a minus, and tried to break it up into a mathematical
> operation of "field.sym - offset", in which case it failed to parse
> (unless the event had a field called "offset").
> 
> Both .sym and .sym-offset modifiers should not be entered into
> mathematical calculations anyway. If ".sym-offset" is found in the
> modifier, then simply make it not an operation that can be calculated
> on.
> 
> Cc: stable@vger.kernel.org
> Fixes: 100719dcef447 ("tracing: Add simple expression support to hist
> triggers")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index ba03b7d84fc2..0207aeed31e6 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1555,6 +1555,13 @@ static int contains_operator(char *str)
>  
>  	switch (*op) {
>  	case '-':
> +		/*
> +		 * Unfortunately, the modifier ".sym-offset"
> +		 * can confuse things.
> +		 */

Good catch.

> +		if (op - str >= 4 && !strncmp(op - 4, ".sym-offset",
> 11))
> +			return FIELD_OP_NONE;
> +
>  		if (*str == '-')
>  			field_op = FIELD_OP_UNARY_MINUS;
>  		else

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


