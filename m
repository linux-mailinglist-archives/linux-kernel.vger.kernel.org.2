Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96D33B2D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhFXK56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232330AbhFXK5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:57:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E494A613DA;
        Thu, 24 Jun 2021 10:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624532134;
        bh=+9sE0LtSPd4C4EdjQzA2+/pCvK+7mLM1hBAY1nGLjcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWhN40NUEAQi61Lu74+1OanSLxMEZoEKFH/2x2FyaESSs8dUmcxBevFwMP3pj56e4
         3zciYQ04i8PofFXJmDKvDsb5wcn5WPG6xUGuciCfjPBtRTk2+HMKThFojEaLXpIpAR
         2DpzeneLz406OWAgqa5ZsLCN3BbtBtYXZS7oExkQ=
Date:   Thu, 24 Jun 2021 12:55:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 5.14-rc1
Message-ID: <YNRko0SG9yPiYPKM@kroah.com>
References: <YNRJ7D7kVwaLWXe5@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNRJ7D7kVwaLWXe5@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 11:01:32AM +0200, Johan Hovold wrote:
> Hi Greg,
> 
> Here are the USB serial updates for 5.14-rc1.
> 
> Note that you'll get a merge conflict in cp210x between 
> 
> 	6f7ec77cc8b6 ("USB: serial: cp210x: fix alternate function for CP2102N QFN20")
> 
> which is already in your tree and
> 
> 	8051334e901f ("USB: serial: cp210x: add support for GPIOs on CP2108")
> 
> This was also reported by Stephen here
> 
> 	https://lore.kernel.org/r/20210617150224.19213166@canb.auug.org.au
> 
> and the resolution should be straight forward.
> 
> Let me know if you prefer I pull in Linus's rc:s like you do to resolve any
> issues like this in the future.

Not a problem, now pulled and pushed out, thanks.

greg k-h
