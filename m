Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEC536EC7A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbhD2Ogn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:36:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40032 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbhD2Ogk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:36:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TEGATE007742;
        Thu, 29 Apr 2021 14:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=OZcICzs7p+CNORIipbTD7WjNxFxyZPDdbnWZ3TzgtYQ=;
 b=YqIFGPBI9ME/+a2PoaA9CyZ3roMe9zeNWHB/VjPEqqH3KIsPHX+BnmUjsVgBl4kAbwkG
 4bFcc3OY2Qe7dJAMIn0YY4euZWVVCxsc8LULqX3Riky5CI3sK1UxzskHWD3LvxR23maf
 JTU4ht8seluxEHUSEZYPqnXJdzjHjHtPnaAZTF5BgTN42D0gjjIUsX63isdV1dUJd/cR
 a+h46WP4JJpz24Nl6rEWSmH3r28CtIKxSmT2t1Pz8WXf2UgNHGUVk8XqYtmk/Uvab8/0
 f1Y8CzfapZGX2IUrQXPKS9xULg/lOcBxihXgKHDALOnztxKK39gVBk1561gA2HM6yRsI sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 385ahbvkva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:35:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TEYu23142485;
        Thu, 29 Apr 2021 14:35:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3848f1653h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:35:46 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13TEZj0t147341;
        Thu, 29 Apr 2021 14:35:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3848f16538-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 14:35:45 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13TEZiX6032445;
        Thu, 29 Apr 2021 14:35:44 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Apr 2021 07:35:43 -0700
Date:   Thu, 29 Apr 2021 17:35:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 2/2] staging: rtl8723bs: core: Removed
 set but unused variable.
Message-ID: <20210429143536.GD1981@kadam>
References: <20210428113346.28305-1-fmdefrancesco@gmail.com>
 <20210428113346.28305-3-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428113346.28305-3-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 3I-WfEfnF7HtXKDJ1_iqrugYLeTgwa2h
X-Proofpoint-ORIG-GUID: 3I-WfEfnF7HtXKDJ1_iqrugYLeTgwa2h
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1031 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 01:33:46PM +0200, Fabio M. De Francesco wrote:
> Removed set but unused variable. Issue detected by gcc.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index a2fdd5ea5fc4..b0d2ba5ed129 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -1019,7 +1019,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
>  	u16 capab_info;
>  	struct rtw_ieee802_11_elems elems;
>  	struct sta_info *pstat;
> -	unsigned char 	reassoc, *p, *pos, *wpa_ie;
> +	unsigned char 	*p, *pos, *wpa_ie;
>  	unsigned char WMM_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01};
>  	int		i, ie_len, wpa_ie_len, left;
>  	unsigned char 	supportRate[16];
> @@ -1040,10 +1040,8 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
>  
>  	frame_type = GetFrameSubType(pframe);
>  	if (frame_type == WIFI_ASSOCREQ) {
> -		reassoc = 0;
>  		ie_offset = _ASOCREQ_IE_OFFSET_;
>  	} else { /*  WIFI_REASSOCREQ */
> -		reassoc = 1;
>  		ie_offset = _REASOCREQ_IE_OFFSET_;
>  	}

Get rid of the curly braces as well, otherwise the patch introduces a
checkpatch warning.

regards,
dan carpenter

