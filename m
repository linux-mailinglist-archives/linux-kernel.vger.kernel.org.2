Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B31D3C1A50
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 22:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhGHUIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 16:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230201AbhGHUIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 16:08:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DBED61419;
        Thu,  8 Jul 2021 20:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625774718;
        bh=vr9wCtU5CSOmF8rHrWBOnnQ8DxpD4EGpO0RJkacQjy8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bx/4KKQT8j/V62W2q3mFLMXJxOExdEsVIpA32t4JvnKHamq5d2zWawQdtRMUlyBKj
         oUiKX99YysoL8QJeB18PKmcEdr30K1cehWdReKjH54MtbVGjeV3299Pp9OKCxhEymK
         9i6kMW1nN2xBx2o1Rk+pFr1PXjnAon7wE411MIRdSSg/atvpvwWyB0yIhkqPoreL/1
         /wJ9Rj9hBQw4rq+et0KthzXAQjWqVJRpH2wlkGENMjp0GSa67BGFQOn1TCeA3AbNST
         Js4uFcg8xO09qMdR3sHQUNWLEBHPIlVVq2sMcxLgGmqKwhVAdTCe4H5PafMSCyKbgp
         vvtp05YDXt8bw==
Message-ID: <b0c64284cbba5613daaa5284a8dda1dcac60aead.camel@kernel.org>
Subject: Re: [PATCH 2/2 v3] tracing/histogram: Update the documentation for
 the buckets modifier
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Date:   Thu, 08 Jul 2021 15:05:16 -0500
In-Reply-To: <20210707213922.167218794@goodmis.org>
References: <20210707213623.250212325@goodmis.org>
         <20210707213922.167218794@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2021-07-07 at 17:36 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Update both the tracefs README file as well as the histogram.rst to
> include an explanation of what the buckets modifier is and how to use
> it.
> Include an example with the wakeup_latency example for both log2 and
> the
> buckets modifiers as there was no existing log2 example.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  Documentation/trace/histogram.rst | 92
> +++++++++++++++++++++++++++++--
>  kernel/trace/trace.c              |  1 +
>  2 files changed, 87 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/trace/histogram.rst
> b/Documentation/trace/histogram.rst
> index b71e09f745c3..11094ec6e52e 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -77,6 +77,7 @@ Documentation written by Tom Zanussi
>  	.syscall    display a syscall id as a system call name
>  	.execname   display a common_pid as a program name
>  	.log2       display log2 value rather than raw number
> +	.buckets=size  display grouping of values rather than raw
> number
>  	.usecs      display a common_timestamp in microseconds
>  	=========== ==========================================
>  
> @@ -228,7 +229,7 @@ Extended error information
>    that lists the total number of bytes requested for each function
> in
>    the kernel that made one or more calls to kmalloc::
>  
> -    # echo 'hist:key=call_site:val=bytes_req' > \
> +    # echo 'hist:key=call_site:val=bytes_req.buckets=32' > \
>              /sys/kernel/debug/tracing/events/kmem/kmalloc/trigger

This just seems random, not sure why you changed it, and it doesn't
make sense on a val anyway..

The rest looks good, though, thanks for doing this!

Reviewed-by: Tom Zanussi <zanussi@kernel.org>



