Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434283A403A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhFKKf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhFKKfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:35:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07009613DE;
        Fri, 11 Jun 2021 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623407605;
        bh=5WadPKSiLW4dx4lYOs2lFpxn4Zz5o5yVCJzwf6Jmzn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gq0Z7NjT5PoJijBBXexNohBqbFZljNWjPDo5YwPhDBompbhm8PAzedSDLOYIvHrCj
         V5xJWAIS8R9lKoyrtdUZ+q57OylGV7gV+jYPvZRd8VzLA/Cz5Qw7/WxuOOET6rGNSN
         P0vijAHIQIYzYWzrz605hcJKwzu7PrRPrP5I/Liw=
Date:   Fri, 11 Jun 2021 12:33:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 5.13-rc6
Message-ID: <YMM768yexdUZkOwO@kroah.com>
References: <YMM24hYHEe78rHoJ@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMM24hYHEe78rHoJ@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 12:11:46PM +0200, Johan Hovold wrote:
> The following changes since commit bc96c72df33ee81b24d87eab953c73f7bcc04f29:
> 
>   USB: serial: ftdi_sio: add NovaTech OrionMX product ID (2021-06-05 12:26:01 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-5.13-rc6

Pulled and pushed out, thanks,

greg k-h
