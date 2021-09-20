Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0560741129C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhITKKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhITKKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:10:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86C0160E9C;
        Mon, 20 Sep 2021 10:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632132553;
        bh=S+3ma9YFjHGWvmLW58NxGb6gvt/Tr6xPp8Acn3HjfVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwzutkduiqVq+KN31ixwh7uelCMJX4Wwktmfl+4idHYdnA2GRBnGT9rdqldo+1qgz
         dnrTJbRA8j1K1jTuOzjHcNa+i+xVzTQN6ZbSLw5MkfKc+xmnsQh3zZqoO4JoTOch2K
         ID3HDa9ERNz7L+3fFTJVIH3qAlRqhhK/uWIsqEZ0=
Date:   Mon, 20 Sep 2021 12:09:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix -Wrestrict warnings
Message-ID: <YUhdxrSWhObY9gg0@kroah.com>
References: <20210920095525.1150678-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920095525.1150678-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 11:55:09AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Adding back the nonstandard ioctl commands caused -Wrestrict warnings
> when building with 'make W=1':
> 
> drivers/staging/r8188eu/os_dep/ioctl_linux.c: In function 'rtw_mp_read_rf':
> drivers/staging/r8188eu/os_dep/ioctl_linux.c:5515:27: error: 'sprintf' argument 3 overlaps destination object 'extra' [-Werror=restrict]
>  5515 |                           sprintf(extra, "%s %d", extra, strtou);
>       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/staging/r8188eu/os_dep/ioctl_linux.c:5470:54: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
>  5470 |                         struct iw_point *wrqu, char *extra)
>       |                                                ~~~~~~^~~~~
> 
> Change these to the same construct used elsewhere in that driver,
> with an offset to the string to make the warning go away.
> 
> The ioctl commands were previously removed, and it's unlikely that
> anything is actually using them, so ideally I would prefer to have
> them removed again.

I'll apply this to get rid of the warning, but will also work on
removing the ioctls entirely.

thanks,

greg k-h
