Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04D742E21F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhJNTow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhJNTot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:44:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEC83604E9;
        Thu, 14 Oct 2021 19:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634240564;
        bh=iIBZIhtkSWMQj1WgKcPeCr6QjVpWAQIm6lxiwng6KCY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=rgqbekksfExbJEHdzFLOFsKIqA8ZbZjDH6BNQZsGElAUs82NMm2bly1+roOhodLbl
         w+3Zf7f0N56dYq38pi+kEIebY7iMdINqvD4iA8+HwVdYisDtSVk1Mr6GFFr/nyS3lA
         1Xvus4nFp7wprCBRh8RrX6qiq64URaagwqhWHzDzyWgVsVw1NjhEG1KOw8C4Wnc21R
         nFJUkQWExuMS3G1js3L1NDpy0nqoX2mkt/hDyrmVQlO5/C6vkKuIAD8Fv1QKa+xPTD
         7p0qpjrp5uhGgNG8Dvwrpybwrd36G0iw5FuMgh41eJprELL+WBpKa0WYwWmjMRbiQ7
         qMA3MjPPXMA5A==
Date:   Thu, 14 Oct 2021 12:42:42 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] xen/pvcalls-back: Remove redundant 'flush_workqueue()'
 calls
In-Reply-To: <2d6c2e031e4aa2acf2ac4e0bbbc17cfdcc8dbee2.1634236560.git.christophe.jaillet@wanadoo.fr>
Message-ID: <alpine.DEB.2.21.2110141242320.9408@sstabellini-ThinkPad-T480s>
References: <2d6c2e031e4aa2acf2ac4e0bbbc17cfdcc8dbee2.1634236560.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021, Christophe JAILLET wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> @@
> expression E;
> @@
> - 	flush_workqueue(E);
> 	destroy_workqueue(E);
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/xen/pvcalls-back.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
> index b47fd8435061..d6f945fd4147 100644
> --- a/drivers/xen/pvcalls-back.c
> +++ b/drivers/xen/pvcalls-back.c
> @@ -465,7 +465,6 @@ static int pvcalls_back_release_passive(struct xenbus_device *dev,
>  		write_unlock_bh(&mappass->sock->sk->sk_callback_lock);
>  	}
>  	sock_release(mappass->sock);
> -	flush_workqueue(mappass->wq);
>  	destroy_workqueue(mappass->wq);
>  	kfree(mappass);
>  
> -- 
> 2.30.2
> 
