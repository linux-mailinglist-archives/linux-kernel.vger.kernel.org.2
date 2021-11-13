Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B89C44F38A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 15:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhKMOOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 09:14:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhKMOOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 09:14:40 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A28DE60E90;
        Sat, 13 Nov 2021 14:11:47 +0000 (UTC)
Date:   Sat, 13 Nov 2021 09:11:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhaoyu Liu <zackary.liu.pro@gmail.com>
Cc:     corbet@lwn.net, mingo@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ftrace: fix the wrong path of tracefs
Message-ID: <20211113091145.05ba14b5@rorschach.local.home>
In-Reply-To: <20211113133722.GA11656@pc>
References: <20211113133722.GA11656@pc>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2021 21:37:34 +0800
Zhaoyu Liu <zackary.liu.pro@gmail.com> wrote:

> Delete "tracing" due to it has been included in /proc/mounts.
> Delete "echo nop > $tracefs/tracing/current_tracer", maybe
> this command is redundant.
> 
> Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Jon,

Can you take this through your tree?

Thanks,

-- Steve


> ---
>  Documentation/trace/ftrace.rst | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 4e5b26f03d5b..b3166c4a7867 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -2442,11 +2442,10 @@ Or this simple script!
>    #!/bin/bash
>  
>    tracefs=`sed -ne 's/^tracefs \(.*\) tracefs.*/\1/p' /proc/mounts`
> -  echo nop > $tracefs/tracing/current_tracer
> -  echo 0 > $tracefs/tracing/tracing_on
> -  echo $$ > $tracefs/tracing/set_ftrace_pid
> -  echo function > $tracefs/tracing/current_tracer
> -  echo 1 > $tracefs/tracing/tracing_on
> +  echo 0 > $tracefs/tracing_on
> +  echo $$ > $tracefs/set_ftrace_pid
> +  echo function > $tracefs/current_tracer
> +  echo 1 > $tracefs/tracing_on
>    exec "$@"
>  
>  

