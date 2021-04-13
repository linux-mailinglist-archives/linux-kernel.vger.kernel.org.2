Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3B435DFA2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345935AbhDMM7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:59:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345920AbhDMM7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:59:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 012E0613AE;
        Tue, 13 Apr 2021 12:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618318772;
        bh=aKtum944X7oeenAWgmQgDcJZvTXmMz3gUbpNSPJyU8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HRZZp/nN3mhOQgmRjVbkHRGs0pQ25itch/o9i3kiQepQran+rOaCkj2ah0UN152Z+
         vxddEeb1ZJJwsgjUmD4xwpwp0RcQnAwqHk5b8rwV9hCZbTeZ9W/Uaa2sBXOVMiu26q
         h6LKIutVyRa1GZs4DmiaFuMtin+uFB3C66r0l3UE=
Date:   Tue, 13 Apr 2021 14:59:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8192u: ieee80211:
 Replaced strncpy() with strscpy()
Message-ID: <YHWVsahY4nfo9xF/@kroah.com>
References: <20210413123041.24260-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413123041.24260-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:30:41PM +0200, Fabio M. De Francesco wrote:
> Replaced strncpy() with strscpy() because of compilation time warnings
> about possible truncation of output [-Wstringop-truncation].

build warnings?  What build warnings?

> Furthermore, according to the Linux official documentation, strscpy() is
> preferred to strncpy.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> index 25ea8e1b6b65..aa58eedf5e86 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> @@ -1385,12 +1385,12 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
>  			 * essid provided by the user.
>  			 */
>  			if (!ssidbroad) {
> -				strncpy(tmp_ssid, ieee->current_network.ssid, IW_ESSID_MAX_SIZE);
> +				strscpy(tmp_ssid, ieee->current_network.ssid, IW_ESSID_MAX_SIZE);

Are you sure you can just replace this like this?


>  				tmp_ssid_len = ieee->current_network.ssid_len;
>  			}
>  			memcpy(&ieee->current_network, net, sizeof(struct ieee80211_network));
>  
> -			strncpy(ieee->current_network.ssid, tmp_ssid, IW_ESSID_MAX_SIZE);
> +			strscpy(ieee->current_network.ssid, tmp_ssid, IW_ESSID_MAX_SIZE);

Same here, are you sure?

thanks,

greg k-h
