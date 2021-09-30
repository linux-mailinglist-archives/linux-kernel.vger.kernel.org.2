Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAEB41E492
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 01:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349158AbhI3XH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 19:07:59 -0400
Received: from server.lespinasse.org ([63.205.204.226]:52695 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhI3XH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 19:07:58 -0400
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Sep 2021 19:07:58 EDT
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-35-ed;
 t=1633042731; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=c4tAztelNd4I3jqxJmzgttxMzW+0BW3CnTQ/W3W41z4=;
 b=tqodSRzZEERZmTZw6/eese8sapZxy9+R60kCui+0BLISkSmjI8UmGKMkxwQSNbo2BS1Wk
 ONwvzJSu2GwnTb0CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-35-rsa; t=1633042731; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=c4tAztelNd4I3jqxJmzgttxMzW+0BW3CnTQ/W3W41z4=;
 b=Lp50lrimmRiri2Jg+20OmkoUOshtgaSHb1UwN1fEdJv5DhvBvy2gaa1MNbnIry8q8ZFWn
 XgybYTKzedw25BEFYm1uRXsRSmK31ht9+CDqpbxhnAqjYszSdlSHKgfV88eDxQp9R143hBj
 CONhHMDxzPPHCj/I9BLb6Ai8jOixc6Dn+I9jHIpxPDYagBaRN09QQG9+UpW6sbNoWmB1m21
 zhNLhyleRN18ANCaNRb4nxsiGqh7f+Rx56WIrXk+InbQ6F7Jgv+BLxPpxAHheFz00dcXTe4
 BajagHz1I/HJggQmW1cd6Pa28VzbBVsEpKlEyGwUG9L8+DDAX9bZvBtsmEfw==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 02CA0160723; Thu, 30 Sep 2021 15:58:51 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:58:50 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     linux-kernel@vger.kernel.org, michel@lespinasse.org
Subject: Re: [PATCH] rbtree: Remove unneeded check condition in rb_find_first
Message-ID: <20210930225850.GA6434@lespinasse.org>
References: <1632986196-20074-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632986196-20074-1-git-send-email-lirongqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 03:16:36PM +0800, Li RongQing wrote:
> the variable c is int type, so change the following condition
> 
> 	 if (c <= 0) {
> 
> 	 }
> 	 else if (c > 0) {
> 
> 	 }
> as:
> 	 if (c <= 0) {
> 
> 	 }
> 	 else {
> 
> 	 }
> 
> Spotted-by: Michel Lespinasse <<michel@lespinasse.org>>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  include/linux/rbtree.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
> index 235047d..d5ac8f7 100644
> --- a/include/linux/rbtree.h
> +++ b/include/linux/rbtree.h
> @@ -294,7 +294,7 @@ static inline void rb_replace_node_cached(struct rb_node *victim,
>  			if (!c)
>  				match = node;
>  			node = node->rb_left;
> -		} else if (c > 0) {
> +		} else {
>  			node = node->rb_right;
>  		}
>  	}

Looks good to me, thanks for the fix.

Reviewed-by: Michel Lespinasse <michel@lespinasse.org>

--
Michel "walken" Lespinasse
