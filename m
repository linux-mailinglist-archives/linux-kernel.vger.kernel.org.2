Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B89435EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhJUKWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhJUKWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:22:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E36C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:20:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v17so212385wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7A8gfnKA+Y+7HAEbh81zbD8Ms3KWC+a9weWS9FJezE8=;
        b=ePhcLvjliVuzdum1olRgGqqxViUwVBh7h4cikloLmWP0Xy+wicISLgnn4slTJBdtLi
         ajSlIP2GxT8Dbv/S08cfmXxZNpe4iJw6p/JTTSo4X5li+JM/X0QoBKe+l/Pa63dHAXYz
         L7QJNnOxqoAHO+zj4dvWzk5KLuWo2LLqSnkaiD5EdrZzG9E7TN/1EIzPTP9uFcRZiAR8
         q0P/nJCvqz+Vksma1BqxOGV8E4wa2SZhZg1dQObUhp9lWKktOycGsMDIPwGWYnuvnyEF
         mnkKDsMFgMMZRerFeNTOvEmXQ3coJ49HDKBqX8hviBmKFVBsK1c7XZYMVJu5p80ercl0
         FMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7A8gfnKA+Y+7HAEbh81zbD8Ms3KWC+a9weWS9FJezE8=;
        b=Q7VkLk6phVZ4B1nyfh/PUmNUlOVM9GhomE7QmCatcGrIdC54HRie1Tn8NOM8XlsVRc
         EFMhJU/BziIk8R9pZezymicB7j2uH7AGILm8TnaMV7+c+1hGZhtLHQPfOUo++474cdYT
         fd6XZoKxPNVydRDAy42lxKpqxeTqYq6UBleOpyGmC+4DZ/m8vbW/DljJt+RgdrKpjhC3
         YXx3JQvHUko8ZF6CA1BbKwl2x4M9bh79W87F62ePossXOmfQ/PTEc6ecTJRg7W6RP0IS
         o59BMpZIwM9G4szz+fyfd/xefikMRg1z6YA+E/E45tYEBtikQ/iFCRZpkrA5ubRo8h9P
         0MqQ==
X-Gm-Message-State: AOAM532Qs0ERvFW3wu2lZcmRv41lfbCsKygE9HxH0Zxyqb3Yd0VEdiIh
        BUjf7Iw83Dg3ffoOqAikuPE=
X-Google-Smtp-Source: ABdhPJyHLdQ8cmtkHX+9eIIgBB2krzmZcrtOFoD9z32xmOj0OBSMI3srarF92/AgWTS4BhXtm+RqNA==
X-Received: by 2002:a05:6000:11c5:: with SMTP id i5mr4889875wrx.228.1634811620674;
        Thu, 21 Oct 2021 03:20:20 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7f0? ([2a02:8108:96c0:3b88::d7f0])
        by smtp.gmail.com with ESMTPSA id d24sm4295388wmb.35.2021.10.21.03.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 03:20:20 -0700 (PDT)
Message-ID: <920e9e3c-5f3b-8eed-4961-038bcc980b31@gmail.com>
Date:   Thu, 21 Oct 2021 12:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/5] staging: r8188eu: use helper to set broadcast address
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211020195401.12931-1-martin@kaiser.cx>
 <20211020195401.12931-4-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211020195401.12931-4-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 21:54, Martin Kaiser wrote:
> The eth_broadcast_addr helper assigns the broadcast address to an address
> array. Call this function instead of copying the address bytes manually.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 13 +++++--------
>   drivers/staging/r8188eu/hal/rtl8188e_cmd.c  |  3 +--
>   2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index b0dfafe526f7..7b372374e638 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -3409,7 +3409,6 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
>   	unsigned char			*mac;
>   	struct xmit_priv		*pxmitpriv = &padapter->xmitpriv;
>   	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
> -	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>   	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
>   	u8 wpsie[255] = { 0x00 }, p2pie[255] = { 0x00 };
>   	u16 wpsielen = 0, p2pielen = 0;
> @@ -3443,8 +3442,8 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
>   			memcpy(pwlanhdr->addr3, pwdinfo->p2p_peer_interface_addr, ETH_ALEN);
>   		} else {
>   			/*	broadcast probe request frame */
> -			memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
> -			memcpy(pwlanhdr->addr3, bc_addr, ETH_ALEN);
> +			eth_broadcast_addr(pwlanhdr->addr1);
> +			eth_broadcast_addr(pwlanhdr->addr3);
>   		}
>   	}
>   	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
> @@ -4311,7 +4310,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
>   	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
>   	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>   	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
> -	u8	bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>   	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
>   
>   	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
> @@ -4334,7 +4332,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
>   	fctrl = &pwlanhdr->frame_ctl;
>   	*(fctrl) = 0;
>   
> -	memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
> +	eth_broadcast_addr(pwlanhdr->addr1);
>   	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
>   	memcpy(pwlanhdr->addr3, get_my_bssid(cur_network), ETH_ALEN);
>   
> @@ -4676,7 +4674,6 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
>   	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>   	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
>   	int	bssrate_len = 0;
> -	u8	bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>   
>   	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
>   	if (!pmgntframe)
> @@ -4702,8 +4699,8 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
>   		memcpy(pwlanhdr->addr3, da, ETH_ALEN);
>   	} else {
>   		/*	broadcast probe request frame */
> -		memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
> -		memcpy(pwlanhdr->addr3, bc_addr, ETH_ALEN);
> +		eth_broadcast_addr(pwlanhdr->addr1);
> +		eth_broadcast_addr(pwlanhdr->addr3);
>   	}
>   
>   	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> index c5f9353fe3e6..14eed14a4c6a 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> @@ -226,14 +226,13 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
>   	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
>   	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>   	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
> -	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>   
>   	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
>   
>   	fctrl = &pwlanhdr->frame_ctl;
>   	*(fctrl) = 0;
>   
> -	memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
> +	eth_broadcast_addr(pwlanhdr->addr1);
>   	memcpy(pwlanhdr->addr2, myid(&adapt->eeprompriv), ETH_ALEN);
>   	memcpy(pwlanhdr->addr3, get_my_bssid(cur_network), ETH_ALEN);
>   
> 


Looks good, thanks.

Acked-by: Michael Straube <straube.linux@gmail.com>
