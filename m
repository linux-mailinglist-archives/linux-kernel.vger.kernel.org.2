Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380FE45E010
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349452AbhKYR6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347894AbhKYR4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:56:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F8C0619F6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:43:24 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so5189620wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TN/QQkM1NntF1m6fJ6zPw0ksMJntIEEt1v1JsMs1Xxo=;
        b=B1VT2bhTux1ksTjwklT4nU8DwdebnyeqDKHMURVCvjSfmdeO1f/8M2a9FWPxk5FCGS
         OOkYiv9ftxyumKk2tbeuPy6mBkAQLiKPns7VlGlGV5ofSxb9gIkCdiAWMrseQwRsKDoh
         gcPu/JksJjPXXfceYxQv/W7m7lJ2aCHKDBrqLOcm6EaUtzTKCnqVLZE6ATUAk1lmpziL
         VhCTNvVp8Dn9DYXRMx6cY58qYUe0gKNWCQQ8vPT7zMRV+H3fbx5getsGTqV+gOwhoHSJ
         eugfrVYM9RG3zwx5qSuP1fxUf4gjyQEyXAagV/O/6j+e5lPSeqEk8erqsqdKhnEVZ2DZ
         WKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TN/QQkM1NntF1m6fJ6zPw0ksMJntIEEt1v1JsMs1Xxo=;
        b=qwGHNqpXBSSCd2mDcLmehRNU/feNy4v8mXa5AdOLKWVvFH2/cxfK06jE/6GZP4n7N/
         Ny9SxJGb/5D20ZWpIV0v1mrmPRRpVscog/RqyIX57zJEIHHH112eQwxeLbwClWuBhMt5
         0jDJbGviVenli7JB+/JOCMFZgdYmB94qBEXYXkzNFT2Zklvqo6Mpyp0gS07FKXbrXLb1
         ieNra7ZfnLvdpLZCPmg6a0/mFYlj2j1qcVxsrXMqNrMl2ZM3vYSuChAsj2prB/CJpotq
         IZXeuXLz+cUCMjoTfcu1xUJFp8CDjVfmh/oKWLZLNKRilDkRuYhCXXW2ZQ8jM/JmK8hb
         oVYw==
X-Gm-Message-State: AOAM531UCP88/yACj32PL42vcre9JYoLJ49UXParrKd+pMwzx9riizAR
        WToWBYkZG0GrTiBc5Wa0XWst6J1Lj/k=
X-Google-Smtp-Source: ABdhPJxu1FQCs/jtd196x1cJ2eMVoJbQ2skwTguVLKbWh/iEbr/dKD9GzyfX56fGeuMtaP/s0Ai/oA==
X-Received: by 2002:a05:600c:4e45:: with SMTP id e5mr9548080wmq.43.1637862202950;
        Thu, 25 Nov 2021 09:43:22 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::7311? ([2a02:8108:96c0:3b88::7311])
        by smtp.gmail.com with ESMTPSA id f7sm4168768wri.74.2021.11.25.09.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 09:43:22 -0800 (PST)
Message-ID: <813f1715-181f-515b-46c9-fafa374453a2@gmail.com>
Date:   Thu, 25 Nov 2021 18:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/4] staging: r8188eu: remove pm_netdev_open
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211125164745.8188-1-martin@kaiser.cx>
 <20211125164745.8188-2-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211125164745.8188-2-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/21 17:47, Martin Kaiser wrote:
> The only caller of pm_netdev_open sets bnormal to true. In this case,
> pm_netdev_open just calls netdev_open.
> 
> Remove pm_netdev_open and call netdev_open directly.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/include/usb_osintf.h |  1 -
>   drivers/staging/r8188eu/os_dep/os_intfs.c    | 11 -----------
>   drivers/staging/r8188eu/os_dep/usb_intf.c    |  2 +-
>   3 files changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/usb_osintf.h b/drivers/staging/r8188eu/include/usb_osintf.h
> index 624298b4bd0b..3e777ca52745 100644
> --- a/drivers/staging/r8188eu/include/usb_osintf.h
> +++ b/drivers/staging/r8188eu/include/usb_osintf.h
> @@ -16,7 +16,6 @@ extern int rtw_mc2u_disable;
>   u8 usbvendorrequest(struct dvobj_priv *pdvobjpriv, enum bt_usb_request brequest,
>   		    enum rt_usb_wvalue wvalue, u8 windex, void *data,
>   		    u8 datalen, u8 isdirectionin);
> -int pm_netdev_open(struct net_device *pnetdev, u8 bnormal);
>   void netdev_br_init(struct net_device *netdev);
>   void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb);
>   void *scdb_findEntry(struct adapter *priv, unsigned char *ipAddr);
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 5a5f182d30c9..397981bc9a62 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -760,17 +760,6 @@ void rtw_ips_dev_unload(struct adapter *padapter)
>   		rtw_hal_deinit(padapter);
>   }
>   
> -int pm_netdev_open(struct net_device *pnetdev, u8 bnormal)
> -{
> -	int status;
> -
> -	if (bnormal)
> -		status = netdev_open(pnetdev);
> -	else
> -		status =  (_SUCCESS == ips_netdrv_open((struct adapter *)rtw_netdev_priv(pnetdev))) ? (0) : (-1);
> -	return status;
> -}
> -
>   int netdev_close(struct net_device *pnetdev)
>   {
>   	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index eca1036a721f..984e408f9366 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -298,7 +298,7 @@ static int rtw_resume(struct usb_interface *pusb_intf)
>   		pwrpriv->bkeepfwalive = false;
>   
>   	DBG_88E("bkeepfwalive(%x)\n", pwrpriv->bkeepfwalive);
> -	if (pm_netdev_open(pnetdev, true) != 0) {
> +	if (netdev_open(pnetdev) != 0) {
>   		mutex_unlock(&pwrpriv->lock);
>   		goto exit;
>   	}
> 

Reviewed-by: Michael Straube <straube.linux@gmail.com>
