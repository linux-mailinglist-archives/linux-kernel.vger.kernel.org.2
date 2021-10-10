Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FBD4283E0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 23:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhJJVr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 17:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbhJJVr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 17:47:56 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B8A860EB4;
        Sun, 10 Oct 2021 21:45:57 +0000 (UTC)
Date:   Sun, 10 Oct 2021 17:45:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     mingo@redhat.com, akpm@linux-foundation.org, vbabka@suse.cz,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm: mmap_lock: remove redundant "\n" in
 TP_printk
Message-ID: <20211010174555.6a623b29@rorschach.local.home>
In-Reply-To: <20211009071105.69544-1-ligang.bdlg@bytedance.com>
References: <20211009071105.69544-1-ligang.bdlg@bytedance.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Oct 2021 15:11:05 +0800
Gang Li <ligang.bdlg@bytedance.com> wrote:

> Ftrace core will add "\n" automatically on print. "\n" in TP_printk
> will create blank line, so remove it.
> 

Yes, thank you!

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
>  include/trace/events/mmap_lock.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
> index 0abff67b96f0..5f980c92e3e9 100644
> --- a/include/trace/events/mmap_lock.h
> +++ b/include/trace/events/mmap_lock.h
> @@ -32,7 +32,7 @@ TRACE_EVENT_FN(mmap_lock_start_locking,
>  	),
>  
>  	TP_printk(
> -		"mm=%p memcg_path=%s write=%s\n",
> +		"mm=%p memcg_path=%s write=%s",
>  		__entry->mm,
>  		__get_str(memcg_path),
>  		__entry->write ? "true" : "false"
> @@ -63,7 +63,7 @@ TRACE_EVENT_FN(mmap_lock_acquire_returned,
>  	),
>  
>  	TP_printk(
> -		"mm=%p memcg_path=%s write=%s success=%s\n",
> +		"mm=%p memcg_path=%s write=%s success=%s",
>  		__entry->mm,
>  		__get_str(memcg_path),
>  		__entry->write ? "true" : "false",
> @@ -92,7 +92,7 @@ TRACE_EVENT_FN(mmap_lock_released,
>  	),
>  
>  	TP_printk(
> -		"mm=%p memcg_path=%s write=%s\n",
> +		"mm=%p memcg_path=%s write=%s",
>  		__entry->mm,
>  		__get_str(memcg_path),
>  		__entry->write ? "true" : "false"

