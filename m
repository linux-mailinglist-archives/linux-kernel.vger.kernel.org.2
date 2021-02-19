Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4397431F92F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhBSMNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:13:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53252 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhBSMNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:13:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JC9s9N061889;
        Fri, 19 Feb 2021 12:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=seAu6hg07cIlZfvQDfSyx2dnNqdr2n5wbaEVfoJZhRY=;
 b=L9FpuGVSc2Z8+0gsbfmX0LVLN42Ifr/TKggD1k39cwL8CLF7Hz5Fi1WxE8Xta2ZTnusi
 M+sJIzfnaW4Rvuj0Rih4i/X8i6rBeOYnRNK+cfLCLj3hf3nUbZeSDyHX/kEn5Pr9eBaH
 4ofv002iT58846F6ZNXzVciXjOiOuY2RbGjZ4MCiSEGbzriEYq9Uy2hJFPAS+wpUpw+Q
 e0V2APTRyJtiz+OxksMlHq9KOBlMoMu6iluNYs9QeEtDKR2izhPDuSMYBYjBlOuwkuom
 39pudXaxolmeTBu9MB1ISb2Ki7XxqkqxcPk8kei277hERVpMMqSVB4bYbTPdkQR/gsD1 aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36pd9agt00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 12:12:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JCAE8f119071;
        Fri, 19 Feb 2021 12:12:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 36prq1u49b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 12:12:31 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11JCCUkN010043;
        Fri, 19 Feb 2021 12:12:30 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Feb 2021 04:12:29 -0800
Date:   Fri, 19 Feb 2021 15:12:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Selvakumar Elangovan <selvakumar16197@gmail.com>
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        tvboxspy@gmail.com, oscar.carter@gmx.com,
        devel@driverdev.osuosl.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: fixed a CamelCase coding style issue.
Message-ID: <20210219121219.GZ2087@kadam>
References: <20210219095835.9687-1-selvakumar16197@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219095835.9687-1-selvakumar16197@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190100
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You're not asking the right questions.

On Fri, Feb 19, 2021 at 03:28:35PM +0530, Selvakumar Elangovan wrote:
> This patch renames CamelCase macros uVar and uModulo into u_var and
> u_module in device.h
> 

Is "u_var" a good name?  What does the "u_" even mean?

> This issue was reported by checkpatch.pl
> 
> Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
> ---
>  drivers/staging/vt6656/device.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
> index 947530fefe94..6615d356f74a 100644
> --- a/drivers/staging/vt6656/device.h
> +++ b/drivers/staging/vt6656/device.h
> @@ -385,11 +385,11 @@ struct vnt_private {
>  	struct ieee80211_low_level_stats low_stats;
>  };
>  
> -#define ADD_ONE_WITH_WRAP_AROUND(uVar, uModulo) {	\
> -	if ((uVar) >= ((uModulo) - 1))			\
> -		(uVar) = 0;				\
> +#define ADD_ONE_WITH_WRAP_AROUND(u_var, u_modulo) {	\
> +	if ((u_var) >= ((u_modulo) - 1))			\

The \ is not aligned any more.

> +		(u_var) = 0;				\
>  	else						\
> -		(uVar)++;				\
> +		(u_var)++;				\
>  }


This macro is rubbish.  How does the wrap around even make sense?
I hope that if you review the code a bit I think you will find that the
wrap around is impossible?  Just fix the two callers and delete this
macro.

regards,
dan carpenter

