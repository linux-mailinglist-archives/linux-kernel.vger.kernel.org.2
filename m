Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B083E581E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbhHJKTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238920AbhHJKT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:19:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C6206108F;
        Tue, 10 Aug 2021 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628590745;
        bh=9CIYaoUk3OsY+BjiTGw8q0Huaalf7bY8/x0CBVVHlI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEcHyhYjtQz+a+HeSkTIh91M3Cso18O/SugDnEbx0canubN2xtecscTSm4r914SuY
         faCtbl+EnNl3X/fhMHTSaPJeIYRaGPsIvzyBkARY2pb+37VY4GNTlva76lw4yxcwNr
         uaty7syo7uVh4xMPAXdOsW4YjUI0xtjylZBmhOfs=
Date:   Tue, 10 Aug 2021 12:19:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove some dead files
Message-ID: <YRJSlU9jquQkseXt@kroah.com>
References: <20210809210912.1022-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809210912.1022-1-Larry.Finger@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 04:09:12PM -0500, Larry Finger wrote:
> The porting of the new version included 3 source files that are
> only used for testing of the device. They are not needed here.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
>  drivers/staging/r8188eu/Makefile            |    3 -
>  drivers/staging/r8188eu/core/rtw_mp.c       |  974 ---------------
>  drivers/staging/r8188eu/core/rtw_mp_ioctl.c | 1170 -------------------
>  drivers/staging/r8188eu/hal/rtl8188e_mp.c   |  798 -------------
>  4 files changed, 2945 deletions(-)
>  delete mode 100644 drivers/staging/r8188eu/core/rtw_mp.c
>  delete mode 100644 drivers/staging/r8188eu/core/rtw_mp_ioctl.c
>  delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_mp.c

I get the following error with this patch applied:

ERROR: modpost: "rtl8188eu_oid_rt_pro_set_data_rate_hdl" [drivers/staging/r8188eu/r8188eu.ko] undefined!
ERROR: modpost: "rtl8188eu_oid_rt_pro_set_single_carrier_tx_hdl" [drivers/staging/r8188eu/r8188eu.ko] undefined!
ERROR: modpost: "rtl8188eu_oid_rt_pro_stop_test_hdl" [drivers/staging/r8188eu/r8188eu.ko] undefined!
ERROR: modpost: "mp_stop_test" [drivers/staging/r8188eu/r8188eu.ko] undefined!
ERROR: modpost: "MPT_InitializeAdapter" [drivers/staging/r8188eu/r8188eu.ko] undefined!
ERROR: modpost: "Hal_GetThermalMeter" [drivers/staging/r8188eu/r8188eu.ko] undefined!
ERROR: modpost: "Hal_SetThermalMeter" [drivers/staging/r8188eu/r8188eu.ko] undefined!
ERROR: modpost: "MP_PHY_SetRFPathSwitch" [drivers/staging/r8188eu/r8188eu.ko] undefined!
ERROR: modpost: "rtl8188eu_oid_rt_get_efuse_max_size_hdl" [drivers/staging/r8188eu/r8188eu.ko] undefined!
ERROR: modpost: "rtl8188eu_oid_rt_pro_trigger_gpio_hdl" [drivers/staging/r8188eu/r8188eu.ko] undefined!
WARNING: modpost: suppressed 46 unresolved symbol warnings because there were too many)

Are you sure those symbols are not used?

thanks,

greg k-h
