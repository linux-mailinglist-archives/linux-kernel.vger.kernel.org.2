Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8654B3345A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhCJRtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:49:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40564 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhCJRso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:48:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AHfi88091752;
        Wed, 10 Mar 2021 17:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2nFXaqO+IMxgomZInrb6mZnb5Zaqy4wyO3kAeFUfVco=;
 b=jlDczlIN4t/LD2PDUCtrKZeQo2NYqTSJrSLdvnO0Z2RTCeqUoWj7b9DyxlEP1aNsp3bv
 vWQo8N/9bQmvbMZDxn5qoPxG2DxH1RYOslQT12+EQtLSDxmOB7/+Vm8Na3LQM9ISrsaE
 OiVVCZ6CcThwyf02ZggnEQ+/oDbpGu4HNNVOfOwdfV/HAZtL4zedTjL7hVzasxD+6hCx
 5UvcPDL2UmtwEFnoA6XjIWIjavItOs4VTuVMPLWIGHbIqK4O5DwqB8TugE+wdo0x+Xho
 xBJPaplDXa6OMi+OgfBXQvxyq5UPz5TI8Wvl4NkB9c2cSl4GOak+L1qE70K8F33GT7n2 XQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 3742cnbtkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 17:48:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AHf6BO092016;
        Wed, 10 Mar 2021 17:48:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 374kgtpv0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 17:48:38 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12AHmb0h011650;
        Wed, 10 Mar 2021 17:48:37 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Mar 2021 09:48:37 -0800
Date:   Wed, 10 Mar 2021 20:48:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: align comments
Message-ID: <20210310174830.GM2087@kadam>
References: <20210310153717.GA5741@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310153717.GA5741@agape.jhs>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 04:37:21PM +0100, Fabio Aiuto wrote:
> fix the following checkpatch warnings:
> 
> WARNING: Block comments use * on subsequent lines
> +	/*
> +		AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
> --
> WARNING: Block comments use * on subsequent lines
> +/*
> +op_mode
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 28 ++++++++++++-------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index b6f944b37b08..3a0e4f64466a 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -721,9 +721,9 @@ static void update_hw_ht_param(struct adapter *padapter)
>  
>  	/* handle A-MPDU parameter field */
>  	/*

Combine these two comments into one mult-line comment.

> -		AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
> -		AMPDU_para [4:2]:Min MPDU Start Spacing
> -	*/
> +	 *	AMPDU_para [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
> +	 *	AMPDU_para [4:2]:Min MPDU Start Spacing
> +	 */
>  	max_AMPDU_len = pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x03;
>  
>  	min_MPDU_spacing = (
> @@ -1815,17 +1815,17 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
>  }
>  
>  /*
> -op_mode
> -Set to 0 (HT pure) under the following conditions
> -	- all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
> -	- all STAs in the BSS are 20 MHz HT in 20 MHz BSS
> -Set to 1 (HT non-member protection) if there may be non-HT STAs
> -	in both the primary and the secondary channel
> -Set to 2 if only HT STAs are associated in BSS,
> -	however and at least one 20 MHz HT STA is associated
> -Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
> -	(currently non-GF HT station is considered as non-HT STA also)
> -*/
> + *op_mode

You need to have a space character after the '*'.

/*
 * op_mode
 * Set to ...

> + *Set to 0 (HT pure) under the following conditions
> + *	 - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
> + *	 - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
> + *Set to 1 (HT non-member protection) if there may be non-HT STAs
> + *	 in both the primary and the secondary channel
> + *Set to 2 if only HT STAs are associated in BSS,
> + *	 however and at least one 20 MHz HT STA is associated
> + *Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
> + *	 (currently non-GF HT station is considered as non-HT STA also)
> + */

regards,
dan carpenter

