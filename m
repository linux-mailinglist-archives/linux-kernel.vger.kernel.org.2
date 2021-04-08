Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C1358113
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhDHKse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhDHKsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:48:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99AC861130;
        Thu,  8 Apr 2021 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617878891;
        bh=PLEqyjaoSZqxWZzmTtM4yUUjZCs5Y+H9HNoAmhQTFiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJdKpA+QCLdUbMnCb83YjVkbIuXr8kScNBngpcWH3Nj79mI3J23MuUIFludXnOpU7
         MmCTuWKP1PBLgGmP+afC60zBBlo1CtyRHAmSIY6rygbOja7GvsMs9QqI7u91MOjrGv
         U0T0ZmlUF9QQrtYqkpIXjHw5S1ijlWA2fdiv0k5E=
Date:   Thu, 8 Apr 2021 12:48:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ks7010: remove useless variable
Message-ID: <YG7faOKrAJIzf7v8@kroah.com>
References: <1617875479-58849-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1617875479-58849-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 05:51:19PM +0800, Jiapeng Chong wrote:
> Fix the following gcc warning:
> 
> drivers/staging/ks7010/ks_hostif.c:929:19: warning: variable ‘noise’ set
> but not used [-Wunused-but-set-variable].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index 8bc3b7d..499161d 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -926,14 +926,13 @@ void hostif_bss_scan_confirm(struct ks_wlan_private *priv)
>  void hostif_phy_information_confirm(struct ks_wlan_private *priv)
>  {
>  	struct iw_statistics *wstats = &priv->wstats;
> -	u8 rssi, signal, noise;
> +	u8 rssi, signal;
>  	u8 link_speed;
>  	u32 transmitted_frame_count, received_fragment_count;
>  	u32 failed_count, fcs_error_count;
>  
>  	rssi = get_byte(priv);
>  	signal = get_byte(priv);
> -	noise = get_byte(priv);

Are you sure you did not just break the functionality of the device
here?

thanks,

greg k-h
