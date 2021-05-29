Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F283949E4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 03:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhE2BxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 21:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhE2BxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 21:53:08 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 206CF6127C;
        Sat, 29 May 2021 01:51:32 +0000 (UTC)
Date:   Fri, 28 May 2021 21:51:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix debugfs_read_file_str()
Message-ID: <20210528215130.19523600@oasis.local.home>
In-Reply-To: <20210527091105.258457-1-dietmar.eggemann@arm.com>
References: <20210527091105.258457-1-dietmar.eggemann@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 11:11:05 +0200
Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

> +++ b/fs/debugfs/file.c
> @@ -893,7 +893,7 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
>  
>  	copy[copy_len] = '\n';
>  
> -	ret = simple_read_from_buffer(user_buf, count, ppos, copy, copy_len);
> +	ret = simple_read_from_buffer(user_buf, count, ppos, copy, len);
>  	kfree(copy);

As we have:

	len = strlen(str) + 1;
	[..]
	copy_len = strscpy(copy, str, len);

I can't think of any situation that len is not equal to copy_len + 1. :-/

Anyway, either "len" or "copy_len + 1" would work.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
