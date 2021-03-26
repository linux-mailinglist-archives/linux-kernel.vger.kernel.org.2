Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F3034A503
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCZJzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:55:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60036 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhCZJzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:55:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12Q9rrNX020680;
        Fri, 26 Mar 2021 09:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=D+TlEFR74IBjhYCJeVkvSgkKb0Ms7eWrGbAyvMwfH78=;
 b=JRRjUFPY+25eOPHtWdmyzUPqg9S6DNfPia1ajeLm0CgljfmnCgCv4zftU578Ks6golVR
 Z6oGWD1+Gb79Ij9EvoecIs8xdPclkNl34nToKks8SPgD2mAtXkTHxMlrKllgyz1UZ3ER
 iE97FWOr/bEVsf6FNhNInqD5K3ZH3wk6KNvqAoGiYqpk+fIika7dKAbYLL+2AtcvM3iV
 ZCDhhpcvRttLBAYNzZ6fvnUlHSL131mXWRe0A0RRpxUyZPs4VlPxI+6DTjUnkKDtNkui
 Ra0AUlDE9J/PFXdem3cOoJvlqZYHvA4bFL/ysb9c+OQyY9GO5FuULLeoJMNHlxhicXm2 aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37h1421h5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 09:55:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12Q9oLfZ195442;
        Fri, 26 Mar 2021 09:54:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 37h14gytaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 09:54:57 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12Q9suY8032116;
        Fri, 26 Mar 2021 09:54:56 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Mar 2021 02:54:56 -0700
Date:   Fri, 26 Mar 2021 12:54:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] staging: rtl8723bs: put parentheses on macros with
 complex values in hal/HalBtcOutSrc.h
Message-ID: <20210326095449.GD1717@kadam>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
 <7c734b6d796b369f6a0d23c76daa344c241691b5.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c734b6d796b369f6a0d23c76daa344c241691b5.1616748885.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260071
X-Proofpoint-GUID: GBzSIJrjeuv502DYY0C-5zXYs5qnGd0z
X-Proofpoint-ORIG-GUID: GBzSIJrjeuv502DYY0C-5zXYs5qnGd0z
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 10:09:09AM +0100, Fabio Aiuto wrote:
> fix the following checkpatch warning:
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> 152: FILE: drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h:152:
> +#define BTC_PRINT(dbgtype, dbgflag, printstr) \
> no_printk printstr
> --
> ERROR: Macros with complex values should be enclosed in parentheses
> 153: FILE: drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h:153:
> +#define BTC_PRINT_F(dbgtype, dbgflag, printstr) \
> no_printk printstr
> --
> ERROR: Macros with complex values should be enclosed in parentheses
> 154: FILE: drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h:154:
> +#define BTC_PRINT_ADDR(dbgtype, dbgflag, printstr, _Ptr) \
> no_printk printstr
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
> index 10c021024b24..1926a1f7a7e5 100644
> --- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
> +++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
> @@ -149,9 +149,9 @@ extern u32 		GLBtcDbgType[];
>  }
>  
>  #else
> -#define BTC_PRINT(dbgtype, dbgflag, printstr)		 no_printk printstr
> -#define BTC_PRINT_F(dbgtype, dbgflag, printstr)		 no_printk printstr
> -#define BTC_PRINT_ADDR(dbgtype, dbgflag, printstr, _Ptr) no_printk printstr
> +#define BTC_PRINT(dbgtype, dbgflag, printstr)		 (no_printk printstr)
> +#define BTC_PRINT_F(dbgtype, dbgflag, printstr)		 (no_printk printstr)
> +#define BTC_PRINT_ADDR(dbgtype, dbgflag, printstr, _Ptr) (no_printk printstr)

This makes no sense at all.  no_printk is a function.  The BTC_PRINT()
macros are super ugly and this only makes it worse.

regards,
dan carpenter

