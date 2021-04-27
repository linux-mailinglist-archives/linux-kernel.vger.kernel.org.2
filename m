Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295A536C737
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhD0Nsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234429AbhD0Nsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:48:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13AE7613DD;
        Tue, 27 Apr 2021 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619531274;
        bh=6BN68rVlGQIexnOIjZGfK42Qc+IEN1DzMqpFTyWcqcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nELL+xnT73CNqXYe66mqgLHf2vJddBXUGffjOUgtXWh8sc2uZOetEwKDVLkoVL53J
         NDwymZEVFuALiMyKKkSH0dSNdsRiT/gAgEhCWNhn8pkHVz2JiWjZt/P5e/fXO1R2a8
         ODRMMz2qZF8LIxjnUNuKcvl1J7WuRwEKebTitnR0=
Date:   Tue, 27 Apr 2021 15:47:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 156/190] Revert "serial: max310x: pass return value of
 spi_register_driver"
Message-ID: <YIgWCObqV2y+Uz16@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-157-gregkh@linuxfoundation.org>
 <b56966c8-64e2-fee7-4218-4d5db013469b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b56966c8-64e2-fee7-4218-4d5db013469b@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 07:28:51AM +0200, Jiri Slaby wrote:
> On 21. 04. 21, 15:00, Greg Kroah-Hartman wrote:
> > This reverts commit 51f689cc11333944c7a457f25ec75fcb41e99410.
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
> > Cc: Kangjie Lu <kjlu@umn.edu>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/tty/serial/max310x.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> > index 1b61d26bb7af..93f69b66b896 100644
> > --- a/drivers/tty/serial/max310x.c
> > +++ b/drivers/tty/serial/max310x.c
> > @@ -1518,10 +1518,10 @@ static int __init max310x_uart_init(void)
> >   		return ret;
> >   #ifdef CONFIG_SPI_MASTER
> > -	ret = spi_register_driver(&max310x_spi_driver);
> > +	spi_register_driver(&max310x_spi_driver);
> >   #endif
> > -	return ret;
> > +	return 0;
> 
> ACK, uart_unregister_driver() is missing in case of error at least.

Many thanks for the review of the two serial driver changes in this
series, I've updated the changelog with the information and added your
acks.

greg k-h
