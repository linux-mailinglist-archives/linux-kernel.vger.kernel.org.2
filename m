Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB203E8B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhHKHlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234043AbhHKHkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:40:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F14E560EBD;
        Wed, 11 Aug 2021 07:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628667629;
        bh=gN43+LJE+iOcONmqq4TcikkCL1EAaJJj6TgY7+AMcQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iqN1iY0hXQakX5/E5hqdc1PQ8JbMHthvP3fcLWzPAswXzXJP7jJcSJ9+yEcYbvjIg
         JJsgzmctj0a9heNQ2fl0uQZOTbHBRzlSAko0VioOt9k8maDb/SF8s6aSRn/wvG2sqW
         y9cIh/VDHfxP2pbxcmr9s6sqUz2lO6Z9C4PDpXEU=
Date:   Wed, 11 Aug 2021 09:40:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] staging: r8188eu: remove unused functions from
 os_dep/ioctl_linux.c
Message-ID: <YRN+6yLnjQTM6LJU@kroah.com>
References: <20210810235047.177883-1-phil@philpotter.co.uk>
 <20210810235047.177883-2-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810235047.177883-2-phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:50:40AM +0100, Phillip Potter wrote:
> Remove unused functions that are now no longer called as a result of the
> removal of rtw_ioctl in a previous patch. This includes functions not
> directly called from rtw_ioctl, but anything in that specific
> call-chain.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 1538 ++----------------
>  1 file changed, 127 insertions(+), 1411 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 4e21801cbfcf..1ccc5f8de1ee 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -1539,7 +1539,6 @@ static int rtw_wx_get_essid(struct net_device *dev,
>  	wrqu->essid.length = len;
>  	wrqu->essid.flags = 1;
>  
> -exit:

This is not a "function", but a label that was not used.

I'll take this but be more careful next time in the description of
patches as to what they are doing...

thanks,

greg k-h
