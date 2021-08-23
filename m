Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B863F5192
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 21:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhHWTvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 15:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbhHWTvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:51:35 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A95FC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:50:52 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mIFy3-0006Ia-8C; Mon, 23 Aug 2021 21:50:47 +0200
Date:   Mon, 23 Aug 2021 21:50:47 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove 5 GHz code
Message-ID: <20210823195047.xn4brfgrec726oew@viti.kaiser.cx>
References: <20210823193028.12391-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823193028.12391-1-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> The driver is for chips that do not operate in the 5 GHz band.
> Remove some 5 GHz related code.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 30 ++++++--------------
>  1 file changed, 8 insertions(+), 22 deletions(-)

> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index ab4a9200f079..81d4255d1785 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -208,17 +208,10 @@ static char *translate_scan(struct adapter *padapter,
>  		else
>  			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bg");
>  	} else {
> -		if (pnetwork->network.Configuration.DSConfig > 14) {
> -			if (ht_cap)
> -				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11an");
> -			else
> -				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11a");
> -		} else {
> -			if (ht_cap)
> -				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11gn");
> -			else
> -				snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11g");
> -		}
> +		if (ht_cap)
> +			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11gn");
> +		else
> +			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11g");
>  	}

>  	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_CHAR_LEN);
> @@ -737,17 +730,10 @@ static int rtw_wx_get_name(struct net_device *dev,
>  			else
>  				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bg");
>  		} else {
> -			if (pcur_bss->Configuration.DSConfig > 14) {
> -				if (ht_cap)
> -					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11an");
> -				else
> -					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11a");
> -			} else {
> -				if (ht_cap)
> -					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11gn");
> -				else
> -					snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11g");
> -			}
> +			if (ht_cap)
> +				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11gn");
> +			else
> +				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11g");
>  		}
>  	} else {
>  		snprintf(wrqu->name, IFNAMSIZ, "unassociated");
> -- 
> 2.32.0


Hi Michael and all,

looks good.

Acked-by: Martin Kaiser <martin@kaiser.cx>


Two comments unrelated to your patch: I guess that DSConfig is the
channel number, those two drivers have a misleading comment:

  3 F   m    DSConfig
    drivers/staging/r8188eu/include/wlan_bssdef.h
               struct:ndis_802_11_config
               u32           DSConfig;           /*  Frequency, units are kHz */
  4 F   m    DSConfig          drivers/staging/rtl8712/wlan_bssdef.h
               struct:NDIS_802_11_CONFIGURATION
               u32 DSConfig;           /* Frequency, units are kHz */


The rtw_wx_get_name function has a similar check
if (pcur_bss->Configuration.DSConfig > 14).

But when Larry adds cfg80211 support, I guess all IW_HANDLER()s will
become obsolete...

Best regards,
Martin
