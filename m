Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFEF36C9C6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbhD0Qwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236169AbhD0Qwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:52:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7286613B0;
        Tue, 27 Apr 2021 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619542315;
        bh=Gb6j6D802U5onjtS/Hv4Fxx78OSEhrKvCt23km/J5CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nyM3bcPsdA/6BZHVvtIuaxb7r8GIkjyzOOT2LkrPwiG9m3i385YQVC8QoJsSNebhF
         8BZehLYSovB20oxf/45r3ZEHYp/53Nn2J5pLVevWx++eL9UzjJx609b8GyyFz4z+Mp
         cc7NTRGgEQTMyEc/AfHi9T4dyolxFq0M5WYT9RVk=
Date:   Tue, 27 Apr 2021 18:51:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 176/190] Revert "net/net_namespace: Check the return
 value of register_pernet_subsys()"
Message-ID: <YIhBKbFNetIODdAy@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-177-gregkh@linuxfoundation.org>
 <c4cdd3fe-0fd1-c328-14f4-e428eee1d02c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4cdd3fe-0fd1-c328-14f4-e428eee1d02c@virtuozzo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:45:26PM +0300, Kirill Tkhai wrote:
> On 21.04.2021 16:00, Greg Kroah-Hartman wrote:
> > This reverts commit 0eb987c874dc93f9c9d85a6465dbde20fdd3884c.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Aditya Pakki <pakki001@umn.edu>
> > Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  net/core/net_namespace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> > index 43b6ac4c4439..9ae0b275238e 100644
> > --- a/net/core/net_namespace.c
> > +++ b/net/core/net_namespace.c
> > @@ -1101,8 +1101,7 @@ static int __init net_ns_init(void)
> >  	init_net_initialized = true;
> >  	up_write(&pernet_ops_rwsem);
> >  
> > -	if (register_pernet_subsys(&net_ns_ops))
> > -		panic("Could not register network namespace subsystems");
> > +	register_pernet_subsys(&net_ns_ops);
> 
> Nacked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> This patch does not have any problem, since it has been already carefully reviewed.
> Kernel panics here only, if we can't allocate ns_common::inum for init_net.
> This can be only a result of a critical deficiency of memory during boot.

Odd, ok, I'll drop this but this feels strange...

greg k-h
