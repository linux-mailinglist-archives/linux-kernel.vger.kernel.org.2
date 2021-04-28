Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702E636D1C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 07:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhD1Fkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 01:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232529AbhD1Fkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 01:40:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6619B61151;
        Wed, 28 Apr 2021 05:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619588395;
        bh=qcm2LKOyvDfsY6a0QATO2wrAge2b/0RgJtqGlQMzAKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJHPLaOkE/26FQppgSYR6oa/zWoI/0J39mGG/bGKCep6b627WACt9jFPFzXFiLdf9
         GaXAAHZPz1kBoXP7m56Qu+GEAhFDOy+PwfXt8ncaXxWO/gmICQpa+ubvbtF2y9q8bl
         JDr8mJEwjcRbd6QWfeVAHarSkKqrDwIky/tYkcBs=
Date:   Wed, 28 Apr 2021 07:39:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 128/190] Revert "net: strparser: fix a missing check for
 create_singlethread_workqueue"
Message-ID: <YIj1KKNRKunMPmzN@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-129-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-129-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:03PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 228cd2dba27cee9956c1af97e6445be056881e41.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/strparser/strparser.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> index b3815c1e8f2e..efce4ddaa320 100644
> --- a/net/strparser/strparser.c
> +++ b/net/strparser/strparser.c
> @@ -542,8 +542,6 @@ EXPORT_SYMBOL_GPL(strp_check_rcv);
>  static int __init strp_dev_init(void)
>  {
>  	strp_wq = create_singlethread_workqueue("kstrp");
> -	if (unlikely(!strp_wq))
> -		return -ENOMEM;
>  
>  	return 0;
>  }
> -- 
> 2.31.1
> 

In the original commit "unlikely" should not have been used as it is not
needed at all (the compiler and CPU already know this), but the commit
is correct so I'll drop this revert.

greg k-h
