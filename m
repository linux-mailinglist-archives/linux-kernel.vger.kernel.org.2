Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D3E40A732
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbhINHQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240613AbhINHQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:16:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B01761163;
        Tue, 14 Sep 2021 07:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631603702;
        bh=GkbZv416XVxgZ7KC/sJpNSy6lMiYhkfOz6Mo4NJgI1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXxOtrMLRTxyKajaYRjbaqvp8CzJUDNH2WK218UT2l27Y4oGvpmHQQdp30BkmpjCI
         YyRXb+q8YF+BeTzTZ+cTHv17kj7JlNskQaR0BIDBThUmjAkDtObMwy6YpnK6xtm2Pa
         ckJlrxyPyMReLFYXD/7UvK8N+Nmz7YNScNT6l0dY=
Date:   Tue, 14 Sep 2021 09:14:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] staging: r8188eu: more power management cleanup
Message-ID: <YUBL89DoPPtRRJqW@kroah.com>
References: <20210911161019.26881-1-martin@kaiser.cx>
 <20210913185957.3166-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913185957.3166-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 08:59:55PM +0200, Martin Kaiser wrote:
> bHWPwrPindetect is always 0 for the r8188eu driver. This makes a lot of
> code unreachable.
> 
> Tested with Edimax EW-7811Un V2 on an ARM32 embedded system.
> 
> v2:
> - rebased against today's staging-testing branch
> 
> Martin Kaiser (2):
>   staging: r8188eu: brfoffbyhw is always false
>   staging: r8188eu: remove rtw_hw_resume
> 
>  drivers/staging/r8188eu/include/osdep_intf.h  |  1 -
>  drivers/staging/r8188eu/include/rtw_pwrctrl.h |  1 -
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  7 ----
>  drivers/staging/r8188eu/os_dep/usb_intf.c     | 40 -------------------
>  4 files changed, 49 deletions(-)
> 
> -- 
> 2.20.1
> 
> 

Series does not apply to my tree :(
