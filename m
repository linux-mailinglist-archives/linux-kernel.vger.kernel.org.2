Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A8F4354FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhJTVLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhJTVKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:10:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA5C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:08:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso1048911wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=737iJuMi9Zni8oopNt+lYZQ6z/VWdYa1IwGd68uPj8A=;
        b=ftxK2hbMp0LzrQoWpB2SePGkWqx3rwaWoPNsUPvdiatOPgyQ4tfEzvlMmVLGaW78Vg
         neOY57a1aYwiRDzawvm47AFNzw6hUGwJM/qtkyLFj+dthvHhDw9aSSXWnJ0iI/v/HHxO
         5H/6JZ1kvr201ErkWlQdJCj7Sqo7f8NwvDxYwvE1e1MAYwfqHkq0sB0jFRXmXsAD+95r
         iNUl1V17XY/Jl+UA8hNTAD2P6pCg4uYW8+8fwVeRGLNxJ4xs/FBXRkpioY6Pt+ERmRL5
         79uynBdFMEfP9myWuJsBKPTOsQ6F9K886M+3P+2PUzfQAzgIOm4cOv5x62cF8fZzfIKF
         um7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=737iJuMi9Zni8oopNt+lYZQ6z/VWdYa1IwGd68uPj8A=;
        b=a/b32NRUu4Ie6+6IxJydRYn+nWXsso67R17kDKmuDQ/9MQSHGxjrKJMKie03ntrJRp
         4W7elk/xut4LK8u48svgjFu1bOL6tsbg7C69QJ86MTwdXAJUF84BvlWOgCiD3wXbSTH6
         rSvwbP2ix5KB94f3zEzBHcRBkhyq+yxeqTAKaEH6OYj7fVLrpxUTt7KGXcxN907+A44/
         j32of/bn6PSPfVreCH4EzmzjYlS0onGpK6dPQZ6ERIgbd+L3meUnE82M80CdnFfC58+u
         RKQ3O7P47G0AuDXq1blQSm4kEAFfv8lrSFM4c02kkCQKXrcwxkCfXc9q0wSkYAZvQ0y5
         sDVg==
X-Gm-Message-State: AOAM532JRVzYUrmEkaseobP5t0hOAt2qysgDwcYsNtJTTKJ4bg7/wUVw
        VRSbzaqAgil0U4Ek4xWqZN7f8g==
X-Google-Smtp-Source: ABdhPJyJJBCfAM80Lm7nchOtKkeR2MEAq0YehC4wbAubB3EIN0kWqCHfbP7Zp3ZH9x1lfw6z057agQ==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr16092870wmc.176.1634764112272;
        Wed, 20 Oct 2021 14:08:32 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id s3sm2976555wrm.40.2021.10.20.14.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:08:31 -0700 (PDT)
Date:   Wed, 20 Oct 2021 22:08:30 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] staging: r8188eu: use helper to set broadcast address
Message-ID: <YXCFToOeWveWDVXp@equinox>
References: <20211020195401.12931-1-martin@kaiser.cx>
 <20211020195401.12931-4-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020195401.12931-4-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:54:00PM +0200, Martin Kaiser wrote:
> The eth_broadcast_addr helper assigns the broadcast address to an address
> array. Call this function instead of copying the address bytes manually.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c | 13 +++++--------
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c  |  3 +--
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index b0dfafe526f7..7b372374e638 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -3409,7 +3409,6 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
>  	unsigned char			*mac;
>  	struct xmit_priv		*pxmitpriv = &padapter->xmitpriv;
>  	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
> -	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>  	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
>  	u8 wpsie[255] = { 0x00 }, p2pie[255] = { 0x00 };
>  	u16 wpsielen = 0, p2pielen = 0;
> @@ -3443,8 +3442,8 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
>  			memcpy(pwlanhdr->addr3, pwdinfo->p2p_peer_interface_addr, ETH_ALEN);
>  		} else {
>  			/*	broadcast probe request frame */
> -			memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
> -			memcpy(pwlanhdr->addr3, bc_addr, ETH_ALEN);
> +			eth_broadcast_addr(pwlanhdr->addr1);
> +			eth_broadcast_addr(pwlanhdr->addr3);
>  		}
>  	}
>  	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
> @@ -4311,7 +4310,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
>  	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
>  	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>  	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
> -	u8	bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>  	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
>  
>  	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
> @@ -4334,7 +4332,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
>  	fctrl = &pwlanhdr->frame_ctl;
>  	*(fctrl) = 0;
>  
> -	memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
> +	eth_broadcast_addr(pwlanhdr->addr1);
>  	memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
>  	memcpy(pwlanhdr->addr3, get_my_bssid(cur_network), ETH_ALEN);
>  
> @@ -4676,7 +4674,6 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
>  	int	bssrate_len = 0;
> -	u8	bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>  
>  	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
>  	if (!pmgntframe)
> @@ -4702,8 +4699,8 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
>  		memcpy(pwlanhdr->addr3, da, ETH_ALEN);
>  	} else {
>  		/*	broadcast probe request frame */
> -		memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
> -		memcpy(pwlanhdr->addr3, bc_addr, ETH_ALEN);
> +		eth_broadcast_addr(pwlanhdr->addr1);
> +		eth_broadcast_addr(pwlanhdr->addr3);
>  	}
>  
>  	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> index c5f9353fe3e6..14eed14a4c6a 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
> @@ -226,14 +226,13 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
>  	struct mlme_ext_priv *pmlmeext = &adapt->mlmeextpriv;
>  	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>  	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
> -	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>  
>  	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
>  
>  	fctrl = &pwlanhdr->frame_ctl;
>  	*(fctrl) = 0;
>  
> -	memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
> +	eth_broadcast_addr(pwlanhdr->addr1);
>  	memcpy(pwlanhdr->addr2, myid(&adapt->eeprompriv), ETH_ALEN);
>  	memcpy(pwlanhdr->addr3, get_my_bssid(cur_network), ETH_ALEN);
>  
> -- 
> 2.20.1
> 

Looks good.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
