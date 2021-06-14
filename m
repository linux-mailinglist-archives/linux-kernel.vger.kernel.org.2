Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588D03A6648
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhFNMNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:13:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47162 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232559AbhFNMNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:13:06 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15EC67uX029012;
        Mon, 14 Jun 2021 12:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=PRI3ZbgvF7XvhqI9wXPGuawQLkmg0GBcZQdugIdIQU4=;
 b=D4vxZRGzqAsXDpbqLet4KrkleKx2phlVOy+1OWM9pPy9E0TL5YcYvQFO/eJcAVIfBi9p
 c+V7Ie3RP5sWcC0bSEs0sl85ApzR+YPxuicOeTxfB/GunSw7Ccv2e4Jv5K9SlAamrL2G
 wzja/4FhDTY0ijvOnWZRbapQZYpUP/ewUJi2SNbwiteexGmVz22hJ1EzVHuAwdmo1pXd
 dAs8kqGG5aOUEwIkuqSYhAEI/Wfq9SoDbWodfEjevjl3HaXHsjXeW54rGvL+WsG4qtyD
 JRHr9C5ApPLQH4TzQ9gK/MySceG+WN2J9GxvDfNcMlROqbIKFo4tBLamclV+BSrKQ+3Q xw== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 395x06g4y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 12:10:43 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15ECAgip168196;
        Mon, 14 Jun 2021 12:10:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 394mr6b4s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 12:10:42 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15ECAgPi168072;
        Mon, 14 Jun 2021 12:10:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 394mr6b4r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 12:10:42 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15ECAdnV007959;
        Mon, 14 Jun 2021 12:10:39 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Jun 2021 12:10:39 +0000
Date:   Mon, 14 Jun 2021 15:10:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux@roeck-us.net, straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: convert DBG_88E calls in
 core/rtw_sta_mgt.c
Message-ID: <20210614121032.GN1955@kadam>
References: <20210612232831.1325-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612232831.1325-1-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: bWqRKij9z9hHX_2MxOzgKrSytKjtUhhu
X-Proofpoint-GUID: bWqRKij9z9hHX_2MxOzgKrSytKjtUhhu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 12:28:31AM +0100, Phillip Potter wrote:
> Convert both calls to the DBG_88E macro in core/rtw_sta_mgt.c into
> netdev_dbg calls. The DBG_88E macro is unnecessary, as visibility of
> debug messages can be controlled more precisely by just using debugfs.
> It is important to keep these messages still, as they are displayable
> via a kernel module parameter when using DBG_88E.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
> index 5af7af5f5a5a..ad1d851a2f69 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
> @@ -113,17 +113,20 @@ u32 _rtw_init_sta_priv(struct sta_priv *pstapriv)
>  inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
>  {
>  	int offset = (((u8 *)sta) - stapriv->pstainfo_buf) / sizeof(struct sta_info);
> +	struct net_device *pnetdev = stapriv->padapter->pnetdev;
>  
>  	if (!stainfo_offset_valid(offset))
> -		DBG_88E("%s invalid offset(%d), out of range!!!", __func__, offset);
> +		netdev_dbg(pnetdev, "invalid offset(%d), out of range!!!", offset);
>  
>  	return offset;
>  }
>  
>  inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int offset)
>  {
> +	struct net_device *pnetdev = stapriv->padapter->pnetdev;
> +
>  	if (!stainfo_offset_valid(offset))
> -		DBG_88E("%s invalid offset(%d), out of range!!!", __func__, offset);
> +		netdev_dbg(pnetdev, "invalid offset(%d), out of range!!!", offset);

This should be an error and the code should handle it correctly instead
of reading beyond the end of the struct.

regards,
dan carpenter

