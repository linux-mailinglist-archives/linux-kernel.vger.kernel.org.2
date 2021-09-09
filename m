Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0371A404830
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhIIKEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhIIKD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:03:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4666E61186;
        Thu,  9 Sep 2021 10:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631181769;
        bh=tST3j+VeGfiMYjUDeIGLoo4VkNGbnSZ4tPRr+7FlyMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pNm933f+qZndUR+pmDQ+YbQFyNU6af7tZ23/XLh5eqi2FT6SDDaQ5KFO13Axvf8R/
         5WWCOzDDL6t8J7QYFVLPK81UFoyagCw73gUXcSkYO0IKQfQDXHhAiFaeHCDnzx1VB2
         kFX1ocQEFRR+py8GDEJkI/LzpU8jUHfzUiLBHQ68=
Date:   Thu, 9 Sep 2021 12:02:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove conditionals
 CONFIG_88EU_{AP_MODE,P2P}
Message-ID: <YTnbx2h10cgUeYmQ@kroah.com>
References: <20210908050109.1279-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908050109.1279-1-Larry.Finger@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 12:01:09AM -0500, Larry Finger wrote:
> These two conditional compile symbols are explicitly defined.
> As a result, their included code is always compiled. They could be
> converted to Kconfig symbols; however, my experience with this driver
> in a GitHub repo is that many users of the device have it built into
> a SOC or SBC that they wish to use as an access point. As a result,
> CONFIG_88EU_APMODE would need to be selected. Thus it should be built in.
> 
> There have also been many users the wish to establish peer-to-peer
> networks with this device. For this reason, I am also proposing that
> CONFIG_88EU_P2P be automatically included.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
>  drivers/staging/r8188eu/core/rtw_ap.c         |   8 -
>  drivers/staging/r8188eu/core/rtw_cmd.c        |  13 --
>  drivers/staging/r8188eu/core/rtw_debug.c      |   3 -
>  drivers/staging/r8188eu/core/rtw_ieee80211.c  |   5 -
>  drivers/staging/r8188eu/core/rtw_ioctl_set.c  |   5 -
>  drivers/staging/r8188eu/core/rtw_mlme.c       |  20 +--
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 156 ++----------------
>  drivers/staging/r8188eu/core/rtw_p2p.c        |  16 --
>  drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  19 ---
>  drivers/staging/r8188eu/core/rtw_recv.c       |   9 -
>  drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  17 --
>  drivers/staging/r8188eu/core/rtw_wlan_util.c  |   2 -
>  drivers/staging/r8188eu/core/rtw_xmit.c       |   6 -
>  drivers/staging/r8188eu/hal/hal_intf.c        |   2 -
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |   3 -
>  drivers/staging/r8188eu/hal/usb_halinit.c     |   2 -
>  drivers/staging/r8188eu/include/drv_types.h   |   8 -
>  drivers/staging/r8188eu/include/ieee80211.h   |  12 --
>  .../staging/r8188eu/include/ioctl_cfg80211.h  |   2 -
>  .../staging/r8188eu/include/rtl8188e_cmd.h    |   2 -
>  .../staging/r8188eu/include/rtl8188e_hal.h    |   2 -
>  drivers/staging/r8188eu/include/rtw_ap.h      |   5 -
>  drivers/staging/r8188eu/include/rtw_cmd.h     |   4 -
>  drivers/staging/r8188eu/include/rtw_debug.h   |   4 -
>  drivers/staging/r8188eu/include/rtw_mlme.h    |   5 -
>  .../staging/r8188eu/include/rtw_mlme_ext.h    |   4 -
>  .../staging/r8188eu/include/rtw_security.h    |   2 -
>  drivers/staging/r8188eu/include/rtw_xmit.h    |   2 -
>  drivers/staging/r8188eu/include/sta_info.h    |   7 -
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  38 -----
>  drivers/staging/r8188eu/os_dep/mlme_linux.c   |   4 -
>  drivers/staging/r8188eu/os_dep/os_intfs.c     |  13 --
>  drivers/staging/r8188eu/os_dep/usb_intf.c     |   4 -
>  .../staging/r8188eu/os_dep/usb_ops_linux.c    |   2 -
>  34 files changed, 12 insertions(+), 394 deletions(-)

Wait, shouldn't you also remove it from the Kconfig file as part of this
change?

thanks,

greg k-h
