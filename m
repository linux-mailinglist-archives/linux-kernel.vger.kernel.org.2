Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D6134A99E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhCZOXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:23:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53904 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCZOXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:23:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QEJ2sj121989;
        Fri, 26 Mar 2021 14:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=lMSIXLOLSr0s1sxx9Av48/cjPnSg++Go8pCMx5aItjk=;
 b=vI8xjbLfSVbl/jzwdrtuS3eAgrd5M7bll3F67fx9XLu9iznLhWBXCvdGuR08J3QIlIG8
 H/47tcPjajwt+c+lvEkvxuXSzNvoW9KaTUgkM3gKloWO3nZyiy/yviEvVs6bfb1ufEMT
 U7VVtL7H5ipdwtyMViLe4bWTrNDQ8OgPJ9H5X2JJhCJa0HH+9D0nTA79z1QDU1STNLIy
 gBuD+deKXTttAqYQJLRr47WwAdh3fcKYarUyFLBFq/c62SBxDgFOc7rFySDKJKc2bQzC
 QjpN4LudWkJ0Sv+KoSmu+Hy2ivaFtxFfD2jWbs+BVz8QSl6gMq5fV9o+i42oENSflSJV Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37h13rt8n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 14:23:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QEFAK3163166;
        Fri, 26 Mar 2021 14:23:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 37h13xr793-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 14:23:06 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12QEN5es010071;
        Fri, 26 Mar 2021 14:23:05 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Mar 2021 07:23:04 -0700
Date:   Fri, 26 Mar 2021 17:22:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] staging: rtl8723bs: put parentheses on macros with
 complex values in include/drv_types.h
Message-ID: <20210326142257.GF1717@kadam>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
 <fea98d1b0260494dc5cb0dfb7fc03d6f74d9acdf.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fea98d1b0260494dc5cb0dfb7fc03d6f74d9acdf.1616748885.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260109
X-Proofpoint-ORIG-GUID: Qdlnip9PXlLOCiN4Dh3osKehekf_Xfaa
X-Proofpoint-GUID: Qdlnip9PXlLOCiN4Dh3osKehekf_Xfaa
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 10:09:12AM +0100, Fabio Aiuto wrote:
> fix the following checkpatch warning:
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> 279: FILE: drivers/staging/rtl8723bs/include/drv_types.h:279:
> +#define KEY_ARG(x) ((u8 *)(x))[0], ((u8 *)(x))[1],
> ((u8 *)(x))[2], ((u8 *)(x))[3], ((u8 *)(x))[4], ((u8 *)(x))[5], \
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/include/drv_types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
> index 1658450b386e..ead4cb9c1e5a 100644
> --- a/drivers/staging/rtl8723bs/include/drv_types.h
> +++ b/drivers/staging/rtl8723bs/include/drv_types.h
> @@ -276,9 +276,9 @@ struct cam_entry_cache {
>  };
>  
>  #define KEY_FMT "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
> -#define KEY_ARG(x) ((u8 *)(x))[0], ((u8 *)(x))[1], ((u8 *)(x))[2], ((u8 *)(x))[3], ((u8 *)(x))[4], ((u8 *)(x))[5], \
> +#define KEY_ARG(x) (((u8 *)(x))[0], ((u8 *)(x))[1], ((u8 *)(x))[2], ((u8 *)(x))[3], ((u8 *)(x))[4], ((u8 *)(x))[5], \
>  	((u8 *)(x))[6], ((u8 *)(x))[7], ((u8 *)(x))[8], ((u8 *)(x))[9], ((u8 *)(x))[10], ((u8 *)(x))[11], \
> -	((u8 *)(x))[12], ((u8 *)(x))[13], ((u8 *)(x))[14], ((u8 *)(x))[15]
> +	((u8 *)(x))[12], ((u8 *)(x))[13], ((u8 *)(x))[14], ((u8 *)(x))[15])

KEY_ARG() isn't used anywhere that I can see.  Just delete it.

Please take your time when you re-write this series and think about each
change clearly and fix the underlying badness instead of just making
checkpatch happy.  I would really just throw out the patchset and start
over from scratch.

regards,
dan carpenter

