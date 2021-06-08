Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1554339F9CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhFHPBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233590AbhFHPBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:01:38 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D31D261183;
        Tue,  8 Jun 2021 14:59:44 +0000 (UTC)
Date:   Tue, 8 Jun 2021 10:59:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ring-buffer: remove leading spaces before tabs
Message-ID: <20210608105943.2376328c@oasis.local.home>
In-Reply-To: <20210608081051.13382-1-thunder.leizhen@huawei.com>
References: <20210608081051.13382-1-thunder.leizhen@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 16:10:51 +0800
Zhen Lei <thunder.leizhen@huawei.com> wrote:

> 1) Run the following command to find and remove the leading spaces before
>    tabs:
>    find kernel/trace/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'
> 2) Manually check and correct if necessary
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Sorry, but I do not accept whitespace changes. Clean ups like this is
only welcomed if they come along with actual changes to the code around
them. Otherwise, this just causes extra churn and unwelcomed work for
the maintainer.

-- Steve


> ---
>  kernel/trace/ring_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 833ade3d0b00..a555258556c5 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5887,7 +5887,7 @@ static __init int test_ringbuffer(void)
>  		}
>  
>  		kthread_bind(rb_threads[cpu], cpu);
> - 		wake_up_process(rb_threads[cpu]);
> +		wake_up_process(rb_threads[cpu]);
>  	}
>  
>  	/* Now create the rb hammer! */

