Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993F536CB39
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbhD0SkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236773AbhD0Sj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:39:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17E1A613EA;
        Tue, 27 Apr 2021 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619548754;
        bh=m+kOfMpacoy9YSe8CVcZe7xN/+PXhBL1Pvout0upl+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E1WIrHqDhOlMG85zsPjrV8fLuxCMPc/FHs45bPe7yD/HMyKBbUcHnkiR+0hLYvj5M
         auYlMznfAz0mlv+aydFsrsjOWSm9gJFHsUANsL0kfMePzPeXqlW/631+MYCsU3dmz5
         szlMw7lpoZ6eDEU5egLQD9zU5j4uDSS5a86TaatQ=
Date:   Tue, 27 Apr 2021 20:39:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 001/190] Revert "net/rds: Avoid potential use after free
 in rds_send_remove_from_sock"
Message-ID: <YIhaUH9PDZx1SC/J@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-2-gregkh@linuxfoundation.org>
 <YIhaAEsa+92ipKuU@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIhaAEsa+92ipKuU@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 08:37:52PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 21, 2021 at 02:57:56PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 0c85a7e87465f2d4cbc768e245f4f45b2f299b05.
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
> > Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  net/rds/message.c | 1 -
> >  net/rds/send.c    | 2 +-
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/net/rds/message.c b/net/rds/message.c
> > index 4fc66ff0f1ec..799034e0f513 100644
> > --- a/net/rds/message.c
> > +++ b/net/rds/message.c
> > @@ -180,7 +180,6 @@ void rds_message_put(struct rds_message *rm)
> >  		rds_message_purge(rm);
> >  
> >  		kfree(rm);
> > -		rm = NULL;
> >  	}
> >  }
> >  EXPORT_SYMBOL_GPL(rds_message_put);
> > diff --git a/net/rds/send.c b/net/rds/send.c
> > index fe5264b9d4b3..985d0b7713ac 100644
> > --- a/net/rds/send.c
> > +++ b/net/rds/send.c
> > @@ -665,7 +665,7 @@ static void rds_send_remove_from_sock(struct list_head *messages, int status)
> >  unlock_and_drop:
> >  		spin_unlock_irqrestore(&rm->m_rs_lock, flags);
> >  		rds_message_put(rm);
> > -		if (was_on_sock && rm)
> > +		if (was_on_sock)
> >  			rds_message_put(rm);
> >  	}
> >  
> > -- 
> > 2.31.1
> > 
> 
> The original, while again messy, looks ok, so I'll drop this revert.
> 
> greg k-h

Argh, no, this one has already been reverted in Linus's tree.  I've been
reviewing to many of these today, I think it's time to get some rest...

greg k-h
