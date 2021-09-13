Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51BA4098DE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhIMQXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231738AbhIMQXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:23:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F308960F6C;
        Mon, 13 Sep 2021 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631550142;
        bh=Zv4rIie9czFFW4nMHFLTU7dGWvzL1ntTYFHFFdQiEys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tbin15R0e8bdMGqtkg1I4QRzfPEkejA7QahChl9nGK759K7/9ONva5k87T0ikPDop
         0vU1pvbXLYKbltMahFuXXpsfEzpemPp0rbN2li+M984kAcVxiNWhswgrpmCPCXvK4k
         XQW3dEYUFFR0mCYm7vzNmEVpCydwWk3Uc3x+RHI8=
Date:   Mon, 13 Sep 2021 18:22:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] staging: r8188eu: more power management cleanup
Message-ID: <YT96vEoZmj89GMBJ@kroah.com>
References: <20210911161019.26881-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911161019.26881-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 06:10:15PM +0200, Martin Kaiser wrote:
> bHWPwrPindetect is always 0 for the r8188eu driver. This makes a lot of
> code unreachable.
> 
> Tested with Edimax EW-7811Un V2 on an ARM32 embedded system.
> 
> Martin Kaiser (4):
>   staging: r8188eu: bHWPwrPindetect is always false
>   staging: r8188eu: brfoffbyhw is always false
>   staging: r8188eu: remove rtw_hw_suspend
>   staging: r8188eu: remove rtw_hw_resume
> 
>  drivers/staging/r8188eu/core/rtw_cmd.c        | 10 --
>  drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 20 ----
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  4 +-
>  drivers/staging/r8188eu/hal/usb_halinit.c     | 14 ---
>  drivers/staging/r8188eu/include/osdep_intf.h  |  2 -
>  drivers/staging/r8188eu/include/rtw_pwrctrl.h |  2 -
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  7 --
>  drivers/staging/r8188eu/os_dep/usb_intf.c     | 99 -------------------
>  8 files changed, 2 insertions(+), 156 deletions(-)
> 
> -- 
> 2.20.1
> 
> 

I have applied 2 of these, please rebase and resend the rest.

thanks,

greg k-h
