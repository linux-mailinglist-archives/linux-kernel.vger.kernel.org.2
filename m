Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203A53A6689
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhFNMaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:30:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19206 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233076AbhFNMaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:30:15 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15ECIxA1012548;
        Mon, 14 Jun 2021 12:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Q05ttNKlZN+gTToFgr+9sBUffHcFzlw6UBfLvpbT1nA=;
 b=f8xP/5chHz6bFSAeMkhcUEvEhnLZDBn5lWYlhguU/i3J0HQ8ev4xpTowDFkRpal52Z64
 LucuV2zpJo4De+PKVeyRQDFTStL4p3iyGGEK/JowY3GAUWYdrqmx6EzFTbRkPHzbUZSD
 P3RyHuY3YpWTAK6bu5xH5ldhUIMC0eNTqa6PsbVeMvmyrUEH+jplzhi7ANwAkEq6Lj4s
 FQ0/TZTYSQVwdK5WBGjX6HEF6666/+Xcyk5KYGb3llus4Ym/hkYjmuCvoxSyTg3CSCic
 Ybi1UQT1u/zg9GrGjMvfIECwl1Wu7Z/jL+8VR26fxic7INXGbKkMLrwcwyvkHHJLwcXK fw== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 395nsar8k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 12:28:02 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15ECKVBJ148276;
        Mon, 14 Jun 2021 12:28:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 395hk26xvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 12:28:01 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15ECP2Yh159231;
        Mon, 14 Jun 2021 12:28:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 395hk26xvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 12:28:00 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15ECRwF5004854;
        Mon, 14 Jun 2021 12:27:58 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Jun 2021 05:27:58 -0700
Date:   Mon, 14 Jun 2021 15:27:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        insafonov@gmail.com, martin@kaiser.cx, straube.linux@gmail.com,
        simon.fodin@gmail.com, yepeilin.cs@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: convert DBG_88E calls in
 core/rtw_recv.c
Message-ID: <20210614122749.GO1955@kadam>
References: <20210612232835.1378-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612232835.1378-1-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 3KZypUh3vJoeQXcDsGueSYgEUSYrr2iD
X-Proofpoint-ORIG-GUID: 3KZypUh3vJoeQXcDsGueSYgEUSYrr2iD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 12:28:35AM +0100, Phillip Potter wrote:
> Convert all calls to the DBG_88E macro in core/rtw_recv.c into
> netdev_dbg calls. The DBG_88E macro is unnecessary, as visibility of
> debug messages can be controlled more precisely by just using debugfs.
> It is important to keep these messages still, as they are displayable
> via a kernel module parameter when using DBG_88E.
> 
> One such converted call is after a failed skb allocation, but as it prints
> additional information besides just stating failure, I've left it in
> despite the checkpatch warning.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/rtl8188eu/core/rtw_recv.c | 55 ++++++++++++++++-------
>  1 file changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
> index 5a8170d4eab6..008f9fd9fc10 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_recv.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
> @@ -189,7 +189,7 @@ u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
>  
>  	while ((pending_frame = rtw_alloc_recvframe(&adapter->recvpriv.uc_swdec_pending_queue))) {
>  		rtw_free_recvframe(pending_frame, &adapter->recvpriv.free_recv_queue);
> -		DBG_88E("%s: dequeue uc_swdec_pending_queue\n", __func__);
> +		netdev_dbg(adapter->pnetdev, "dequeue uc_swdec_pending_queue");

This printk has no useful information.

>  		cnt++;
>  	}
>  
> @@ -229,7 +229,7 @@ static int recvframe_chkmic(struct adapter *adapter,
>  					res = _FAIL;
>  					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
>  						 ("\n %s: didn't install group key!!!!!!!!!!\n", __func__));
> -					DBG_88E("\n %s: didn't install group key!!!!!!!!!!\n", __func__);
> +					netdev_dbg(adapter->pnetdev, "didn't install group key!!!!!!!!!!");

This condition is impossible.  Otherwise it would be better to make
this an error message.


>  					goto exit;
>  				}
>  				mickey = &psecuritypriv->dot118021XGrprxmickey[prxattrib->key_index].skey[0];
> @@ -318,10 +318,14 @@ static int recvframe_chkmic(struct adapter *adapter,
>  				if ((prxattrib->bdecrypted) && (brpt_micerror)) {
>  					rtw_handle_tkip_mic_err(adapter, (u8)is_multicast_ether_addr(prxattrib->ra));
>  					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted=%d ", prxattrib->bdecrypted));
> -					DBG_88E(" mic error :prxattrib->bdecrypted=%d\n", prxattrib->bdecrypted);
> +					netdev_dbg(adapter->pnetdev,
> +						   "mic error :prxattrib->bdecrypted=%d",
> +						   prxattrib->bdecrypted);
>  				} else {
>  					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" mic error :prxattrib->bdecrypted=%d ", prxattrib->bdecrypted));
> -					DBG_88E(" mic error :prxattrib->bdecrypted=%d\n", prxattrib->bdecrypted);
> +					netdev_dbg(adapter->pnetdev,
> +						   "mic error :prxattrib->bdecrypted=%d",
> +						   prxattrib->bdecrypted);

Both sides of this if statement are the same.

>  				}
>  				res = _FAIL;
>  			} else {
> @@ -361,7 +365,8 @@ static struct recv_frame *decryptor(struct adapter *padapter,
>  		prxattrib->key_index = (((iv[3]) >> 6) & 0x3);
>  
>  		if (prxattrib->key_index > WEP_KEYS) {
> -			DBG_88E("prxattrib->key_index(%d)>WEP_KEYS\n", prxattrib->key_index);
> +			netdev_dbg(padapter->pnetdev,
> +				   "prxattrib->key_index(%d)>WEP_KEYS", prxattrib->key_index);

This should be an error message if it's possible.  I just feel like
this debugging is a random grab bag of printks.  A lot of them are
pretty pointless and there was no thought to it at all.

We'd be better off with a mass delete.

regards,
dan carpenter

