Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C8042C20A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhJMOEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235589AbhJMOEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:04:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9EAF60E8B;
        Wed, 13 Oct 2021 14:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634133762;
        bh=RHnMUoM44+/2jvtNjJOKKEWOXqXVTINGoUUhr/d7sPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=XeCnCH54F2ghg/Kj/cIiaZ1wQy9vt0T4Yj9y4wtZXhAOYE7v9DI1r4ykK9B8oqa10
         Xvq+KqnqtJPf6AXQD1MTTfHOPgARpRCUeQvBpmtwfsMKgLN54EOWb63lBT4GB/0hx2
         1nZPK0Hv5HElXcYRHuz0rlpDHvo5pPQqzO3rOFFDet1a58GJOEKDe8x+SS4/ZNaPVj
         FNin/ullNPP5NLq+KqAdPAKbpLneD3BHCX5+4BC3JaBv0QAsKtQcCPOyaoiK92JC1h
         rdQfU0slUjpaz4kzj+0uTgNsyfe4JSDM+0Kcg9cMuLgYYSrSE7yolTsjxlWYfCMPs0
         hAcf+h12nUolQ==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Adjust the size of kbuf array to avoid overflow
Date:   Wed, 13 Oct 2021 14:02:38 +0000
Message-Id: <20211013140238.16347-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211013114854.15705-1-xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Wed, 13 Oct 2021 19:48:54 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In order to avoid the 'count' size space of kbuf array is
> used up, but a "\0" is still added.

Thank you for this patch! :)

But... I unsure how this can cause a buffer overflow, as 'kbuf' is accessed by
only size-specified functions, namely 'scnprintf()' and
'simple_read_from_buffer()'.

If I'm missing something, please feel free to let me know.


Thanks,
SJ

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/damon/dbgfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index faee070977d8..20c61eed54af 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -247,7 +247,7 @@ static ssize_t dbgfs_kdamond_pid_read(struct file *file,
>  	char *kbuf;
>  	ssize_t len;
>  
> -	kbuf = kmalloc(count, GFP_KERNEL);
> +	kbuf = kmalloc(count + 1, GFP_KERNEL);
>  	if (!kbuf)
>  		return -ENOMEM;
>  
> -- 
> 2.31.0
> 
