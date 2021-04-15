Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3654E360187
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhDOFVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:21:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47014 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhDOFVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:21:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13F5JEmW059525;
        Thu, 15 Apr 2021 05:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ov+A9MryhFsZ9CMkzirHLxFXB3cb10I5KxiyLHM/m7Q=;
 b=U35oxl/4+8WSjVvLrV4XGcWB2a9vRlsEbeakNQJrlVA63qfYqM9Pu3YHpX/0xj8Y2ju+
 1PWD+oBc0uaFChnWImUlQQgSvv50Hme6ZOXMi8ib6ppJ6pV/fZcZyZmQ3iklQonQOWQa
 AOtdeYmXqx4zWKTCbxVgpYlQiPD+UzlGk58bF5N0QJ07uWALFJ7+n3zYhFAkFCq24klo
 sLMjlavDpiUuyBekqi8Koxymzs9X44jgjW8pneYA+zx97wMPCtGpuIDsbD28RZyADHEJ
 zPrGRdt+Ms9HdU7h0llPvIoBofDr1Q6jO8bYsQZUZFnj3fuGigitvkXUh4/PEwp5ph6p GA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37u4nnmfxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 05:20:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13F5KTX1071939;
        Thu, 15 Apr 2021 05:20:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 37uny0epnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 05:20:31 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13F5KO80013546;
        Thu, 15 Apr 2021 05:20:24 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 22:20:23 -0700
Date:   Thu, 15 Apr 2021 08:20:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 37/57] staging: rtl8188eu: os_dep: ioctl_linux: Move 2
 large data buffers into the heap
Message-ID: <20210415051835.GY6021@kadam>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-38-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414181129.1628598-38-lee.jones@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150037
X-Proofpoint-ORIG-GUID: HHn02tmwWKnK40RfH7mHWNFpeVBHs_73
X-Proofpoint-GUID: HHn02tmwWKnK40RfH7mHWNFpeVBHs_73
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 07:11:09PM +0100, Lee Jones wrote:
> ---
>  drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> index c95ae4d6a3b6b..cc14f00947781 100644
> --- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> @@ -224,7 +224,7 @@ static char *translate_scan(struct adapter *padapter,
>  	/* parsing WPA/WPA2 IE */
>  	{
>  		u8 *buf;
> -		u8 wpa_ie[255], rsn_ie[255];
> +		u8 *wpa_ie, *rsn_ie;
>  		u16 wpa_len = 0, rsn_len = 0;
>  		u8 *p;
>  
> @@ -232,6 +232,14 @@ static char *translate_scan(struct adapter *padapter,
>  		if (!buf)
>  			return start;
>  
> +		wpa_ie = kzalloc(255, GFP_ATOMIC);
> +		if (!wpa_ie)
> +			return start;

kfree(buf);

> +
> +		rsn_ie = kzalloc(255, GFP_ATOMIC);
> +		if (!rsn_ie)
> +			return start;

kfree(buf);
kfree(wpa_ie);

> +
>  		rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.ie_length, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
>  		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.ssid.ssid));
>  		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));

regards,
dan carpenter
