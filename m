Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D6D36EC29
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbhD2OM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235277AbhD2OM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:12:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94024610A0;
        Thu, 29 Apr 2021 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619705530;
        bh=w55x0izuN1ft4DBjWA1AS1lN4V6x+pLo3VVeZf4UQAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GhP+6BONAUxFFwXNUftsA0EAHj9zQWRpPSO19YjxpB2GwghhZZLy25pD3LnGNyr9K
         Kr4EjO7ND1Cfus7r0LDG9HoDfjxJPkohSyH5C6SsT5uVG1OBpJbszfw8+4CyRDsNga
         TOdcpwHZCF2oyBNYOs7sCBqfnOhp33yokvPGXqps=
Date:   Thu, 29 Apr 2021 16:12:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 7/7] Revert "serial: max310x: pass return value of
 spi_register_driver"
Message-ID: <YIq+t/JbpSR4eezH@kroah.com>
References: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
 <20210429130811.3353369-8-gregkh@linuxfoundation.org>
 <YIq3nzLCKEKI/Mnx@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIq3nzLCKEKI/Mnx@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 03:41:51PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 29, 2021 at 03:08:11PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 51f689cc11333944c7a457f25ec75fcb41e99410.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper submitted to the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota) but later
> > withdrawn.
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Kangjie Lu <kjlu@umn.edu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/tty/serial/max310x.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> > index 8534d6e45a1d..a3ba0e6520a1 100644
> > --- a/drivers/tty/serial/max310x.c
> > +++ b/drivers/tty/serial/max310x.c
> > @@ -1518,10 +1518,10 @@ static int __init max310x_uart_init(void)
> >  		return ret;
> >  
> >  #ifdef CONFIG_SPI_MASTER
> > -	ret = spi_register_driver(&max310x_spi_driver);
> > +	spi_register_driver(&max310x_spi_driver);
> >  #endif
> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  module_init(max310x_uart_init);
> >  
> > -- 
> > 2.31.1
> > 
> 
> This is incorrect because if spi_register_driver fails, the uart needs
> to be properly unregistered before the module is unloaded automatically,
> causing a crash.
> 
> I'll keep the revert and fix this up properly.

Argh, I already reviewed this one, sigh...

greg k-h
