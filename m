Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564ED38E350
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhEXJ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:28:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62724 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232573AbhEXJ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:27:45 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14O9G1Pl021840;
        Mon, 24 May 2021 09:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7qMhvIo2k8QfOIC7t0pO3C3PVg5uItGXijn7n6D91o4=;
 b=G4MeXiK7O63mTf8HQrQTL+dX4rxVDIE8wvv1GQ53VrlROJqEVNSyT2iMzvGVmpmRFtjx
 Os3BHSdRiiKmm3ArUtq6o9zfkxdKjIgTEQTN2gsUq8UvSZBJHA7uIJxyS7cGKIFuorJa
 swUi1F4jTyiLN6NgMrcd13FRwgX0QdLgf0qtdkdzelZW6/sR0vOhIYbAzx+9MQElNnMy
 LxsyM1A0vU1g6cJ2XoSTzw/aQ4f0mmQylVL8FPktMzTL9yusXtByiJu/JZzdfYJ2F5rJ
 OLP9wuKoxqxs1VyYdZ5XHB7/v9VGvFZsb0Aq+yXm7vqqs+WOsLC1BOG5L3G3cWxj+J75 4A== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38r267r4dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 09:26:14 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14O9QDwv025912;
        Mon, 24 May 2021 09:26:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38pr0avrxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 09:26:13 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14O9QDgC025796;
        Mon, 24 May 2021 09:26:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 38pr0avrud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 09:26:13 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14O9PxqL008532;
        Mon, 24 May 2021 09:25:59 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 May 2021 09:25:59 +0000
Date:   Mon, 24 May 2021 12:25:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: core: rtw_mlme_ext.c: Remove set but
 unused variable
Message-ID: <20210524092552.GO1955@kadam>
References: <20210523173042.19785-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523173042.19785-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: BmYV4bysKhdknh73zMU6DluvCf8H9Xs-
X-Proofpoint-GUID: BmYV4bysKhdknh73zMU6DluvCf8H9Xs-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 07:30:42PM +0200, Fabio M. De Francesco wrote:
> Removed set but unused 'reason_code' variable. Issue detected by GCC
> running with the warning option -Wunused-but-set-variable. Removed its
> use as a storage of the return value of get_unaligned_le16(), which has
> been left as is because it has side effects on the argument it takes.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 9fc612fb736f..a13b3ec42bc9 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -1721,7 +1721,7 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
>  	struct recv_reorder_ctrl *preorder_ctrl;
>  	unsigned char 	*frame_body;
>  	unsigned char 	category, action;
> -	unsigned short	tid, status, reason_code = 0;
> +	unsigned short	tid, status;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
>  	u8 *pframe = precv_frame->u.hdr.rx_data;
> @@ -1791,8 +1791,7 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
>  				psta->htpriv.candidate_tid_bitmap &=
>  					~BIT((frame_body[3] >> 4) & 0xf);
>  
> -				/* reason_code = frame_body[4] | (frame_body[5] << 8); */
> -				reason_code = get_unaligned_le16(&frame_body[4]);
> +				get_unaligned_le16(&frame_body[4]);

It doesn't have any side effects.  Just delete it too.

regards,
dan carpenter

