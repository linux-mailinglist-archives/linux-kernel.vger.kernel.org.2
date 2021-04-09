Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DC235A0A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhDIOGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 10:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232855AbhDIOGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:06:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A7CA61165;
        Fri,  9 Apr 2021 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617977167;
        bh=A++tGxLLYu0bdoyDhMCSlTwTXMIaIFQOaEUZQ9jm4xA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsNv9s1aWpH8thPfA1YDD3gsORQfeZgYgVxvcrDY0T2SZITORc11DmHRaXyeuaTP7
         fxuUmaIZvo14vSk54bxgj5BLdxU7ZLA/w/dysll00dN/Ar7JJgmTSwgC64eOJxDAUn
         pdFt0j/Daktr54mwgRROzYPwgdKjUvPGSfPp588Q=
Date:   Fri, 9 Apr 2021 16:06:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: do not use tty class device for debugging
Message-ID: <YHBfTIJ3uh7SK0Hm@kroah.com>
References: <20210408150859.16868-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408150859.16868-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 05:08:59PM +0200, Johan Hovold wrote:
> Use the port struct device rather than tty class device for debugging.
> 
> Note that while USB serial doesn't support serdev yet (due to serdev not
> handling hotplugging), serdev ttys do not have a corresponding class
> device and would have been logged using a "(NULL device *):" prefix.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/serial/metro-usb.c  |  4 ++--
>  drivers/usb/serial/upd78f0730.c |  7 +++----
>  drivers/usb/serial/usb-serial.c | 32 ++++++++++++++++----------------
>  3 files changed, 21 insertions(+), 22 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
