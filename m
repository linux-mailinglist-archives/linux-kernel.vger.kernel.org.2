Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462CE382098
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 21:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhEPTZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 15:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhEPTZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 15:25:25 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64546C061573;
        Sun, 16 May 2021 12:24:10 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id j19so3440107qtp.7;
        Sun, 16 May 2021 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fZxwgKfIQimb2AFH9JXSBKvKMRan0cAJtKbrTFd8DCw=;
        b=oAFuw8Wmvx0yY/70GlCle9lO76HkGhbMJymOixmBUvyzzqQT0FOomMm56cDB73Rd5g
         t4zw3VSbnD//3Ew+RisP/Dy8OWP24iNKZTqgt0VdIjmuF46hpwRwCa6pFa7YxgaU1xo8
         1KyLY+bFS6eBYBQzDT5vI0sRjLFzgTg0bJtFBchVtxQKg1LRPV8+JcPiiYUfyIdibnAI
         /wnf6FonMZ1G/hOypvchbLwy/sHTeKUDE4GwBy7g+pwKTED4yjLEPFw/5hPIsao/ZNSe
         F2/IPPW+X3FGPaeBWtoK9IvlmGjTZiPx4jZCyjUJlkqxvqDgW5htN4TcSaIpn5TUHTmj
         XBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fZxwgKfIQimb2AFH9JXSBKvKMRan0cAJtKbrTFd8DCw=;
        b=G2BuNgG2Z2uJs/ErwLsHXpA/ntLtXzfVInx0Vu2TCicPsVJyYLE2ycP06d9ZAGyi3p
         VsIOqdI/31OE+3Pu2JNko3FOVCONg4cRr0N8Y74HZ0pfJ5rpreocSIrV5XNdlJ04Ihlm
         0RBvA+67ztO/ToMglVH68HCwkO4ImYa7RtIeXJdSniLywJ+ayxvk08PH2GuGVOhpGugy
         kesTx0uwtyhudsGGE1iZUUzhtM47yfmlp5JDaDylaFWWxsFJl3pMiKBfp5bWm1WG8evY
         7YpjuDzOfvKx97nmRTQJZwRbSXtL2DJp8kEAxHmoguI53xPrIW+UoBMXIXDLKMdc7wzw
         iP6w==
X-Gm-Message-State: AOAM5333xIGEeeLAtEuF3ATl3UqyFI6f6ArKNuPgh6Z472qEt/Yr1Zi9
        qjS2OIBhL4lVMd1ZKMG0FRI8ZfLu9rI=
X-Google-Smtp-Source: ABdhPJw4ToR7cX6GwzJbqm5gAAoq9uNgPrbSZky7o6MUT6XFMq14WKNkqN9PXv1mbajcZYIUonTbcg==
X-Received: by 2002:ac8:5751:: with SMTP id 17mr36207643qtx.389.1621193049615;
        Sun, 16 May 2021 12:24:09 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h8sm9027603qtp.46.2021.05.16.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 12:24:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 May 2021 12:24:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] staging: rtl8188eu: use safe iterator in
 rtw_free_network_queue
Message-ID: <20210516192407.GA2126643@roeck-us.net>
References: <20210516160613.30489-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516160613.30489-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 06:06:08PM +0200, Martin Kaiser wrote:
> rtw_free_network_queue iterates over the scanned wireless networks and
> calls _rtw_free_network for each of them. In some cases,
> _rtw_free_network removes a network from the list.
> 
> We have to use list_for_each_safe if we remove list entries while we
> iterate over a list.
> 
> Fixes: 23017c8842d2 ("staging: rtl8188eu: Use list iterators and helpers")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> Without this patch, it's easy to get the driver into an endless loop by
> scanning, connecting and disconnecting repeatedly.
> 

Oops. Good catch. Thanks for noticing.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> wpa_supplicant -B -Dwext -i wlan0 -c /path/to/my/config...
> while true ; do
>    sleep 1
>    wpa_cli reconfigure     
>    wpa_cli add_network
>    wpa_cli set_network 0 ssid ...
>    wpa_cli set_network 0 psk ...
>    wpa_cli select_network 0
>    sleep 6
>    wpa_cli status
>    wpa_cli disconnect 0
> done
> 
>  drivers/staging/rtl8188eu/core/rtw_mlme.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> index 159465b073c2..14816ad51668 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> @@ -199,7 +199,7 @@ struct wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
>  
>  void rtw_free_network_queue(struct adapter *padapter, u8 isfreeall)
>  {
> -	struct list_head *phead, *plist;
> +	struct list_head *phead, *plist, *temp;
>  	struct wlan_network *pnetwork;
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct __queue *scanned_queue = &pmlmepriv->scanned_queue;
> @@ -207,7 +207,7 @@ void rtw_free_network_queue(struct adapter *padapter, u8 isfreeall)
>  	spin_lock_bh(&scanned_queue->lock);
>  
>  	phead = get_list_head(scanned_queue);
> -	list_for_each(plist, phead) {
> +	list_for_each_safe(plist, temp, phead) {
>  		pnetwork = list_entry(plist, struct wlan_network, list);
>  
>  		_rtw_free_network(pmlmepriv, pnetwork, isfreeall);
> -- 
> 2.20.1
> 
