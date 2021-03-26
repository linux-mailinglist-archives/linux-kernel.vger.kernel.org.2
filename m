Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE7834A4F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCZJw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:52:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58794 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCZJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:52:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12Q9hd8e195611;
        Fri, 26 Mar 2021 09:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=avCY6q93eNNoRefnAtNulcrPTgJVBJ/EjJwMJ+IPy+Q=;
 b=xdNvNM+O8Oh/SGVflMx97UTlfLPpfL6QuSrxbTpmUuaZDED/l1tBdO4F1IAutEYHttZ4
 hAxC2uXUysQDUl2IegSL1Ls1BBuL+D9rf40U6/jFwU5+AjoeIK5af4SlxqXKhUbSIA5G
 mw0UGNdweTQrVuzzOTPjfmYO/T7Bry9sAM2hC7KX1GP/52keHm/d3em+PDv9kQUuVN2K
 S34VaEJ819M00KqPn27yuM+DiFXTADmDWHRomd1Rp8hrw1964jXjnZA16AaSE3Q1xV0G
 Y1qqba53zOX+IgKcch8kEq6ACYfWbocO35w+Q92loQtLY7ug368QrkAxXw/VYgBL5cLr wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37h1421h13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 09:52:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12Q9pKtq166100;
        Fri, 26 Mar 2021 09:52:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 37h1416wye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 09:52:30 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12Q9qTa9023675;
        Fri, 26 Mar 2021 09:52:29 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Mar 2021 02:52:29 -0700
Date:   Fri, 26 Mar 2021 12:52:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] staging: rtl8723bs: inlcude macros in a do..while
 loop in core/rtw_security.c
Message-ID: <20210326095220.GC1717@kadam>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
 <2e02f646ab3f8058b159d6d790e202a0e4744af8.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e02f646ab3f8058b159d6d790e202a0e4744af8.1616748885.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260071
X-Proofpoint-GUID: 3BL4vuliYYY3jwEahB32VThO8e6vN13Y
X-Proofpoint-ORIG-GUID: 3BL4vuliYYY3jwEahB32VThO8e6vN13Y
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 10:09:08AM +0100, Fabio Aiuto wrote:
> fix the following checkpatch warning:
> 
> ERROR: Macros starting with if should be enclosed by a do - while
> loop to avoid possible if/else logic defects
> 33: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:33:
> +#define WEP_SW_ENC_CNT_INC(sec, ra) \
> --
> ERROR: Macros starting with if should be enclosed by a do - while
> loop to avoid possible if/else logic defects
> 41: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:41:
> +#define WEP_SW_DEC_CNT_INC(sec, ra) \
> --
> ERROR: Macros starting with if should be enclosed by a do - while
> loop to avoid possible if/else logic defects
> 49: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:49:
> +#define TKIP_SW_ENC_CNT_INC(sec, ra) \
> --
> ERROR: Macros starting with if should be enclosed by a do - while
> loop to avoid possible if/else logic defects
> 57: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:57:
> +#define TKIP_SW_DEC_CNT_INC(sec, ra) \
> --
> ERROR: Macros starting with if should be enclosed by a do - while
> loop to avoid possible if/else logic defects
> 65: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:65:
> +#define AES_SW_ENC_CNT_INC(sec, ra) \
> --
> ERROR: Macros starting with if should be enclosed by a do - while
> loop to avoid possible if/else logic defects
> 73: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:73:
> +#define AES_SW_DEC_CNT_INC(sec, ra) \
> --
> ERROR: Macros with multiple statements should be enclosed in a
> do - while loop
> 2082: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:2082:
> +#define ROUND(i, d, s) \
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 94 +++++++++++--------
>  1 file changed, 54 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index 44e2b362c867..c92984fcf42d 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -31,52 +31,64 @@ const char *security_type_str(u8 value)
>  
>  #ifdef DBG_SW_SEC_CNT
>  #define WEP_SW_ENC_CNT_INC(sec, ra) \
> -	if (is_broadcast_mac_addr(ra)) \
> -		sec->wep_sw_enc_cnt_bc++; \
> -	else if (is_multicast_mac_addr(ra)) \
> -		sec->wep_sw_enc_cnt_mc++; \
> -	else \
> -		sec->wep_sw_enc_cnt_uc++;
> +	do { \
> +		if (is_broadcast_mac_addr(ra)) \
> +			sec->wep_sw_enc_cnt_bc++; \
> +		else if (is_multicast_mac_addr(ra)) \
> +			sec->wep_sw_enc_cnt_mc++; \
> +		else \
> +			sec->wep_sw_enc_cnt_uc++; \
> +	} while (0)

What are these statistics used for?  So far as I can see there not
used at all.  It's probably better to just delete all the
DBG_SW_SEC_CNT code.

regards,
dan carpenter

