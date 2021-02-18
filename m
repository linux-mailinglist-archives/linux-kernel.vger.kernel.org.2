Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA15231EE47
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhBRS2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:28:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48224 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhBRQFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:05:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IFsK69112500;
        Thu, 18 Feb 2021 16:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=UdQaTckhRsQ/jLTcCYtgh8CqaJ2t3hREWioBusMXLg8=;
 b=bh6tXScDka/SJZxzWNk8AI2igzzRkZ1ioRC7sVc9jCuDZR5BnFcSoxKvzQldFOTStXjn
 HrmVWcmGK5D0avmETisKOaAUDUMT7nB3MCymb78yo7LJwoASLM7/ZRXRhEFaPMi+lQak
 vPoLlMpYWy1V1ZqHVJ/QwyE2UGqcmzFK3+DlHoL6JCCRO/q9mVo4ugJtbfh3QuUHHOJb
 vWXjIEB1TUjHxfVoJ4iVAAAvIr/s+RwAJ9yw+5lam7T55d45a9ot2DYaWWo3fEv8B3Tc
 p6UMcw5FFxbp2PE+IHy4hA7DMqILV2aH8SV5zzBJx9CkD9w6y12lCxXNnmlecI/bOazu 6w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36p7dnpc4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 16:04:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IFpfW3083329;
        Thu, 18 Feb 2021 16:04:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 36prhudng4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 16:04:31 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11IG4UW1001769;
        Thu, 18 Feb 2021 16:04:30 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Feb 2021 08:04:29 -0800
Date:   Thu, 18 Feb 2021 19:04:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kurt Manucredo <fuzzybritches@protonmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix comparisons - put constant on right side- eudyptula
 challenge 10
Message-ID: <20210218160420.GN2087@kadam>
References: <20210218155422.7-1-fuzzybritches@protonmail.com>
 <20210218155422.7-2-fuzzybritches@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218155422.7-2-fuzzybritches@protonmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180139
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180139
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the subject.  Don't mention eudyptula.

[PATCH] Staging: rtl8723bs: put constant on right side of comparison

Add a commit message:

Checkpatch complains that the constant needs to be on the right hand
side of the comparion.


On Thu, Feb 18, 2021 at 03:54:40PM +0000, Kurt Manucredo wrote:
> Signed-off-by: Kurt Manucredo <fuzzybritches@protonmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> index 975f2830e29e..089c6ec19373 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> @@ -2146,7 +2146,7 @@ void rtw_get_sec_iv(struct adapter *padapter, u8 *pcur_dot11txpn, u8 *StaAddr)
>  	struct security_priv *psecpriv = &padapter->securitypriv;
>  
>  	memset(pcur_dot11txpn, 0, 8);
> -	if (NULL == StaAddr)
> +	if (StaAddr == NULL)

The prefered format for this is actually:

	if (!StaAddr)
		return;

regards,
dan carpenter

