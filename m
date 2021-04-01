Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAC6350F53
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhDAGr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhDAGrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:47:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADD3C0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 23:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BWgtyJ0RQt3FZgtPXdA8u22FETTOqA6uOVFPAZEg1FQ=; b=it88p1U1o0kQE4LYo1rQrPEZvg
        nM8A4OA0sV9SX5rpRpUt7eopmRgvV6bgQJB0x+aXFwXuAz0Vzjs2nhXFg8L0P/Wqg20mBKPKunfeh
        G0b/iwYvU0P9wschSjXpu9ushNVY8EywbbU1qgerm1S67R2z08XBsHnPwbBifeQv+wUNq76xaq0JJ
        ZG5G12+rG6JTmWToS0Gb7rHf1ewI31k5Z8IEXGaz9XaoPeU3nrYaVEsCrZqIkv/zZxAMNs6WvSMOM
        0GdTK36YTQHpfGvz3eSk9mb0xp0RSLXQUAVJF6hM4l3CfI2GsZq2UIviP5jNRgaFUGeDi++V40K2u
        s9RmrDLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRr78-008iwS-JY; Thu, 01 Apr 2021 06:47:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1A40F3003E5;
        Thu,  1 Apr 2021 08:47:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 08A2B235FA3BF; Thu,  1 Apr 2021 08:47:34 +0200 (CEST)
Date:   Thu, 1 Apr 2021 08:47:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Hunt <johunt@akamai.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        hannes@cmpxchg.org
Subject: Re: [PATCH] psi: allow unprivileged users with CAP_SYS_RESOURCE to
 write psi files
Message-ID: <YGVshWmKgZgIgBKd@hirez.programming.kicks-ass.net>
References: <20210401033156.7262-1-johunt@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401033156.7262-1-johunt@akamai.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 11:31:56PM -0400, Josh Hunt wrote:
> Currently only root can write files under /proc/pressure. Relax this to
> allow tasks running as unprivileged users with CAP_SYS_RESOURCE to be
> able to write to these files.
> 
> Signed-off-by: Josh Hunt <johunt@akamai.com>

I suppose that's ok, but lets also ask Johannes.

> ---
>  kernel/sched/psi.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index b1b00e9bd7ed..98ff7baf1ba8 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1270,6 +1270,9 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
>  	if (!nbytes)
>  		return -EINVAL;
>  
> +	if (!capable(CAP_SYS_RESOURCE))
> +		return -EPERM;
> +
>  	buf_size = min(nbytes, sizeof(buf));
>  	if (copy_from_user(buf, user_buf, buf_size))
>  		return -EFAULT;
> @@ -1353,9 +1356,9 @@ static int __init psi_proc_init(void)
>  {
>  	if (psi_enable) {
>  		proc_mkdir("pressure", NULL);
> -		proc_create("pressure/io", 0, NULL, &psi_io_proc_ops);
> -		proc_create("pressure/memory", 0, NULL, &psi_memory_proc_ops);
> -		proc_create("pressure/cpu", 0, NULL, &psi_cpu_proc_ops);
> +		proc_create("pressure/io", 0666, NULL, &psi_io_proc_ops);
> +		proc_create("pressure/memory", 0666, NULL, &psi_memory_proc_ops);
> +		proc_create("pressure/cpu", 0666, NULL, &psi_cpu_proc_ops);
>  	}
>  	return 0;
>  }
> -- 
> 2.17.1
> 
