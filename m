Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A943E1F79
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 01:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242467AbhHEXru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 19:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhHEXrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 19:47:45 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE5FC0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 16:47:29 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w6so9639201oiv.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 16:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OQWDDlOSX9gtP+071Su50rAXqbgHCyyr9WMmSuYegz0=;
        b=mELehyYOMFONKRgWnZjlahZBcRMHzxQoGbavM8+p29NSvz/+ZJzKkGWJIvCvYs2SXC
         R1Ak+74R5ZRMLd0S2bX08Dm2XJYNiEN3lUcyy/DDRacZuQtdLF+3knnl6H6fT3Tgk7sP
         +Eqeqb461S0MC8jxC702FJyyhgcHichDuwInm2xAKVHNad3iom31+B8eRIl+SPZTQZn+
         Erz3nIRvyywpFIEWDn2CPoFRHjkW1AJagjdS3qqohr0knKV/1GxVSvV+/wozgpelfpDV
         k/p0KYFijxMiyxbb5dzVLpLQEsNwundvZaLXIfjTq5N9TaxZZIhaDYD8R5KzVARhDs8J
         /ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OQWDDlOSX9gtP+071Su50rAXqbgHCyyr9WMmSuYegz0=;
        b=aYN1c6GyukffKMIkKVi0XhboprncojkFMcBS70ymnAmOpzEOJHQLw8JFiv7zdESbmY
         7Q8n7QTT2CMEwaidfn+7aVzdKnVSYnpmF43uKL8YKPPkGfeHtOWweEUFt6Pa7APByZlg
         XmB2x4OGrDqFYSGG5VfrC5i+qrfdk9XhKRmfyc6uPlvmd82E88wjxxJYpHrUSqcYZK5B
         kWaO5VoPTL/d6xKQX3wgW7xyhYdc9WVWU34qacyWFQNI07b8D67+D/D716tHbksQw/YQ
         20oRlETMC0jWhhlnar496HNM22/3EUi+urNKpDZ6i2Z2VWza4LUwKROdqHkzlhqdIp/+
         zfGw==
X-Gm-Message-State: AOAM531Tfh9I0vxMjJfCmNgChsX2txkL90PTNDOChLZI1mlqNaXLNLyR
        xam4BsfA0matnPbdvIzj+KKoNqHRQXU=
X-Google-Smtp-Source: ABdhPJw8+nnZbm3ybJZQNL/TB0QpC7SB2iW6QwY4lPZFHx7hFBIAzbe07xsiqjR5rCn9fj9gYLqAKQ==
X-Received: by 2002:a05:6808:1388:: with SMTP id c8mr7323392oiw.172.1628207248842;
        Thu, 05 Aug 2021 16:47:28 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id bc42sm1030098oob.39.2021.08.05.16.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 16:47:28 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: replace custom macros with
 is_broadcast_ether_addr
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210805205010.31192-1-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <32466d30-6259-4752-281b-875158ad307a@lwfinger.net>
Date:   Thu, 5 Aug 2021 18:47:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805205010.31192-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 3:50 PM, Michael Straube wrote:
> Replace usage of custom macros with is_broadcast_ether_addr. All buffers
> are properly aligned. Remove the now unsued macros MacAddr_isBcst and
> IS_MAC_ADDRESS_BROADCAST.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_ioctl_set.c | 13 +++----------
>   drivers/staging/r8188eu/core/rtw_recv.c      |  2 +-
>   drivers/staging/r8188eu/include/wifi.h       |  7 -------
>   3 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> index 3e2add5409cc..c354f720310c 100644
> --- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> +++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> @@ -13,13 +13,6 @@
>   
>   extern void indicate_wx_scan_complete_event(struct adapter *padapter);
>   
> -#define IS_MAC_ADDRESS_BROADCAST(addr) \
> -(\
> -	((addr[0] == 0xff) && (addr[1] == 0xff) && \
> -		(addr[2] == 0xff) && (addr[3] == 0xff) && \
> -		(addr[4] == 0xff) && (addr[5] == 0xff))  ? true : false \
> -)
> -
>   u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
>   {
>   	u8	 i;
> @@ -656,8 +649,8 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
>   		}
>   
>   		/*  check BSSID */
> -		if (IS_MAC_ADDRESS_BROADCAST(key->BSSID) == true) {
> -			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("MacAddr_isBcst(key->BSSID)\n"));
> +		if (is_broadcast_ether_addr(key->BSSID)) {
> +			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("is_broadcast_ether_addr(key->BSSID)\n"));
>   			ret = false;
>   			goto exit;
>   		}
> @@ -744,7 +737,7 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
>   				 padapter->securitypriv.dot118021XGrpPrivacy, key->KeyLength));
>   		}
>   
> -		if ((check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE) == true) && (IS_MAC_ADDRESS_BROADCAST(key->BSSID) == false)) {
> +		if (check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE) && !is_broadcast_ether_addr(key->BSSID)) {
>   			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
>   				 (" IBSS but BSSID is not Broadcast Address.\n"));
>   			ret = _FAIL;
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index aef32f029537..afab951d87fd 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -694,7 +694,7 @@ static void count_rx_stats(struct adapter *padapter, struct recv_frame *prframe,
>   
>   	padapter->mlmepriv.LinkDetectInfo.NumRxOkInPeriod++;
>   
> -	if ((!MacAddr_isBcst(pattrib->dst)) && (!IS_MCAST(pattrib->dst)))
> +	if (!is_broadcast_ether_addr(pattrib->dst) && !IS_MCAST(pattrib->dst))
>   		padapter->mlmepriv.LinkDetectInfo.NumRxUnicastOkInPeriod++;
>   
>   	if (sta)
> diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
> index 2c56d1d70d03..65fc677bf4eb 100644
> --- a/drivers/staging/r8188eu/include/wifi.h
> +++ b/drivers/staging/r8188eu/include/wifi.h
> @@ -368,13 +368,6 @@ enum WIFI_REG_DOMAIN {
>   
>   #define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
>   
> -#define MacAddr_isBcst(addr) \
> -	( \
> -	((addr[0] == 0xff) && (addr[1] == 0xff) && \
> -	(addr[2] == 0xff) && (addr[3] == 0xff) && \
> -	(addr[4] == 0xff) && (addr[5] == 0xff))  ? true : false \
> -)
> -
>   static inline int IS_MCAST(unsigned char *da)
>   {
>   	if ((*da) & 0x01)

Acked-by: Larry Finger <Larry.Finger@lwfinger,net>



