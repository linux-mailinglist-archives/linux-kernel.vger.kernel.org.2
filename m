Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7EA3FEB26
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245185AbhIBJZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244578AbhIBJZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:25:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20CE061058;
        Thu,  2 Sep 2021 09:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630574654;
        bh=zIj7EQLNOtKs8u2vD/qBGXMIOQRpa8s5VsWEc1wDKn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aAmyV4KMzNzdUtemIe4LXd7UPFqmAoHK9HeAEXzd58xgeF+VmtRCmOOv9NWbeDB8H
         UrqiMXE2BjfZKNdFLimQT4KkG98Oid6EQR0vNUb36S0cTrcMi3Ek+eb8G0XboXdlo+
         QrICBAP4mXoNvhnuc2ImeMBm07de6omqUojEyHl0=
Date:   Thu, 2 Sep 2021 11:23:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: r8188eu: remove unused constants from wifi.h
Message-ID: <YTCYFu6fAi5vs2IE@kroah.com>
References: <20210829180717.15393-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829180717.15393-1-straube.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 08:07:16PM +0200, Michael Straube wrote:
> The constants WLAN_REASON_PWR_CAPABILITY_NOT_VALID and
> WLAN_REASON_SUPPORTED_CHANNEL_NOT_VALID defined in wifi.h
> are unused, remove them.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/include/wifi.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
> index 0b3fd94cea18..eb07ac9b8943 100644
> --- a/drivers/staging/r8188eu/include/wifi.h
> +++ b/drivers/staging/r8188eu/include/wifi.h
> @@ -126,8 +126,6 @@ enum WIFI_REASON_CODE	{
>  #define WLAN_REASON_DISASSOC_STA_HAS_LEFT 8
>  #define WLAN_REASON_STA_REQ_ASSOC_WITHOUT_AUTH 9 */
>  /* IEEE 802.11h */

This comment can now be deleted, right?

thanks,

greg k-h
