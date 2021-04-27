Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409BB36CA67
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbhD0Rf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:35:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0Rf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:35:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BA92611C1;
        Tue, 27 Apr 2021 17:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619544883;
        bh=t9CBCqKbukMpYL5bAz907pUSdbug1Nr9jXv8HMncGxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUeXGQXew2h2VV9iwblM0+NgTgbVoQ0+gVP/RwEzKf6RIwazQfAv1q4q3BtLA1Za5
         7jMvnIUXSNH2rOGxE3OCIxPixOEjquxMbC5rfHbro+/CuDRnrUTUxuXiG6AkDcDVQF
         KOJyL9FVkYasIJ5rr1B68rVbe8rfFH5yps5y8rSo=
Date:   Tue, 27 Apr 2021 19:34:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 071/190] Revert "pppoe: remove redundant BUG_ON() check
 in pppoe_pernet"
Message-ID: <YIhLMcU71EKGi+qE@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-72-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-72-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:06PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 02a896ca84874bbfcedc006303f2951dda89b298.
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
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/ppp/pppoe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index d7f50b835050..803a4fe1ca18 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -119,6 +119,8 @@ static inline bool stage_session(__be16 sid)
>  
>  static inline struct pppoe_net *pppoe_pernet(struct net *net)
>  {
> +	BUG_ON(!net);
> +
>  	return net_generic(net, pppoe_net_id);
>  }
>  
> -- 
> 2.31.1
> 

THe original here was correct so I'll drop this revert.

greg k-h
