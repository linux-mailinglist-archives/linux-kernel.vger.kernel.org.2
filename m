Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D7D3D5C90
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 17:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhGZOWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234862AbhGZOWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:22:16 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5702660F0F;
        Mon, 26 Jul 2021 15:02:44 +0000 (UTC)
Date:   Mon, 26 Jul 2021 11:02:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: use WARN_ONCE
Message-ID: <20210726110237.3c25dbc7@oasis.local.home>
In-Reply-To: <20210726135635.143285-1-wangborong@cdjrlc.com>
References: <20210726135635.143285-1-wangborong@cdjrlc.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 21:56:35 +0800
Jason Wang <wangborong@cdjrlc.com> wrote:

> printk + WARN_ON_ONCE can be just WARN_ONCE.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  kernel/trace/trace_output.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index a0bf446bb034..c06726b6d8b4 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1574,9 +1574,8 @@ __init static int init_events(void)
>  
>  		ret = register_trace_event(event);
>  		if (!ret) {
> -			printk(KERN_WARNING "event %d failed to register\n",
> -			       event->type);
> -			WARN_ON_ONCE(1);
> +			WARN_ONCE(1, "event %d failed to register\n",
> +				  event->type);
>  		}
>  	}
>  

If you're going to change this, then nuke the conditional!

	WARN_ONCE(!ret, "event %d failed to register\n", event->type);

-- Steve
