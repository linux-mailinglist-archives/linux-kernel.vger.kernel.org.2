Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC3E420140
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhJCK7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 06:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJCK7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 06:59:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4CDC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 03:57:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u18so24670735wrg.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lcwxJroRSUTohtMf+k9Ugq0yLcYl9nBVFvk57k74DwA=;
        b=ORqew/pfbtvjyK9XsKlhK+NDZxqHTJq2sDOo8lVkUW9zKIQ1z/xaCHl8PBn5NvHbRz
         Jr8WWgjvLImThVj5va1VU+BfgHBPWvYaC9rR0a47WKMKe5s5PB+kN3KH2Qh/kQVOS8Va
         2xBb0AdBcj3m5bGKBtETq4kTEVqpLl3Z093DAfbdDX3aUO/UJCDx+vGqGsQHDMVNamRZ
         pER8so7jA1Y/TnNhelJ0s5gMhEuXz2zQwcIlQ3HVAqH/xfBddYINbtwT2PxH8W7yKgDb
         Ost3owUsAd4kZ59Bg2o4WqYihlSmVtIQLe0X5NqvKQ4EYnnswv1hGYg6yKgMY08qYkE3
         taZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lcwxJroRSUTohtMf+k9Ugq0yLcYl9nBVFvk57k74DwA=;
        b=6vN77DraJFisDok7amRcAMn2FfA04XYIJ3vGyKC6ykUe8ifwq5BH1wqVJXgpkDR/P7
         lCHelxgtEIWMSyqRdzBaTuJEdivAATBlaaWHYRZvnxl7q8+AY8kLaCDbLPDFn9bYnOOd
         v5XNTWxCbTWj6JvP2o1CJJdfgpbk4fdU2zyIKagLegFnHS1iLZncOhmne+5QBnRW0JaJ
         P7/JrboJwVt5w5kQmAYLkS48/FSDVR+6/l955LdFBMlrNjcdTJEYK+nl3icEiIG38CtR
         fEeUiusKQ4+iY+NrGBihS2Wqhhx4SFNghWJFzHf+iS4iC6cnHx88oo969i3BnUtvena3
         v8QA==
X-Gm-Message-State: AOAM532OVj6jn4DXrgEl6A9UO/MIq+5PFrkEKL3hnYw0U2qXshblHXMd
        qQHJywRj4SINL7nGBHVqfHI=
X-Google-Smtp-Source: ABdhPJwDiZGm2d9zjW0jQ2BY32fzWCunGgd0ur+LjfRQw+JSfzqp3ObbqGnW4RKwTALgDO0xJyyMzA==
X-Received: by 2002:a5d:6c69:: with SMTP id r9mr1571693wrz.280.1633258640510;
        Sun, 03 Oct 2021 03:57:20 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::f816? ([2a02:8108:96c0:3b88::f816])
        by smtp.gmail.com with ESMTPSA id l2sm12474853wmi.1.2021.10.03.03.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 03:57:19 -0700 (PDT)
Message-ID: <24683ced-2e92-594e-c67e-7d3e49a63490@gmail.com>
Date:   Sun, 3 Oct 2021 12:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] staging: r8188eu: core: remove unused variable local
 variable
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fmdefrancesco@gmail.com,
        linux@roeck-us.net, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YVhpBWhNt7mwfNKU@user>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YVhpBWhNt7mwfNKU@user>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/21 16:13, Saurav Girepunje wrote:
> Remove unused local variable macAddr.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_br_ext.c    | 3 +--
>   drivers/staging/r8188eu/core/rtw_xmit.c      | 2 +-
>   drivers/staging/r8188eu/include/usb_osintf.h | 3 +--
>   3 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index 62a672243696..bcd0f9dd64b1 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -695,8 +695,7 @@ void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
>   	}
>   }
> 
> -void *scdb_findEntry(struct adapter *priv, unsigned char *macAddr,
> -				unsigned char *ipAddr)
> +void *scdb_findEntry(struct adapter *priv, unsigned char *ipAddr)
>   {
>   	unsigned char networkAddr[MAX_NETWORK_ADDR_LEN];
>   	struct nat25_network_db_entry *db;
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index f9ae48f73cdf..b34cb5b97df1 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -1593,7 +1593,7 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
>   		if (*((__be16 *)(skb->data + MACADDRLEN * 2)) == __constant_htons(ETH_P_IP)) {
>   			if (memcmp(padapter->scdb_mac, skb->data + MACADDRLEN, MACADDRLEN)) {
>   				padapter->scdb_entry = (struct nat25_network_db_entry *)scdb_findEntry(padapter,
> -							skb->data + MACADDRLEN, skb->data + WLAN_ETHHDR_LEN + 12);
> +							skb->data + WLAN_ETHHDR_LEN + 12);
>   				if (padapter->scdb_entry) {
>   					memcpy(padapter->scdb_mac, skb->data + MACADDRLEN, MACADDRLEN);
>   					memcpy(padapter->scdb_ip, skb->data + WLAN_ETHHDR_LEN + 12, 4);
> diff --git a/drivers/staging/r8188eu/include/usb_osintf.h b/drivers/staging/r8188eu/include/usb_osintf.h
> index 34229b1cb081..624298b4bd0b 100644
> --- a/drivers/staging/r8188eu/include/usb_osintf.h
> +++ b/drivers/staging/r8188eu/include/usb_osintf.h
> @@ -19,8 +19,7 @@ u8 usbvendorrequest(struct dvobj_priv *pdvobjpriv, enum bt_usb_request brequest,
>   int pm_netdev_open(struct net_device *pnetdev, u8 bnormal);
>   void netdev_br_init(struct net_device *netdev);
>   void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb);
> -void *scdb_findEntry(struct adapter *priv, unsigned char *macAddr,
> -		     unsigned char *ipAddr);
> +void *scdb_findEntry(struct adapter *priv, unsigned char *ipAddr);
>   void nat25_db_expire(struct adapter *priv);
>   int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method);
> 
> --
> 2.32.0
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
