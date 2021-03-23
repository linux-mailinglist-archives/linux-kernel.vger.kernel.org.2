Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C92F345A57
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhCWJGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhCWJFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:05:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6314F619B1;
        Tue, 23 Mar 2021 09:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616490334;
        bh=sOzjyAwHyRoht8QLAT7g78gd11n/MSMJneGdpUF80Ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGcOg+mKoWZbV5c4hIZ0V2UTHcfXnKckhZpFcFXAqI1baT/qpXoTjC3iYJgs8470E
         Wrmm+4njRbXNTYmsN9E8IH9dn7mVIWuU30Ow9BRPlW0kToclm3nYq655OOjd0bl+Zi
         dzWzgwqyUUJwUcpoKcCelN9fO/9c7KZDsBYvFlaU=
Date:   Tue, 23 Mar 2021 10:05:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     ross.schm.dev@gmail.com, yanaijie@huawei.com,
        matthew.v.deangelis@gmail.com, amarjargal16@gmail.com,
        izabela.bakollari@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Trivial typo fix
Message-ID: <YFmvWzGZ0hHJbx6d@kroah.com>
References: <20210323010835.4061779-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323010835.4061779-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 06:38:35AM +0530, Bhaskar Chowdhury wrote:
> 
> s/netowrk/network/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 2c9425e2a1e9..3888d3984ec0 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -599,7 +599,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
>  		}
> 
>  		if (rtw_roam_flags(adapter)) {
> -			/* TODO: don't  select netowrk in the same ess as oldest if it's new enough*/
> +			/* TODO: don't  select network in the same ess as oldest if it's new enough*/

Any reason you did not remove the two spaces at the same time?

thanks,

greg k-h
