Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A83348A36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCYHca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:32:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46928 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCYHcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:32:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P7TvYs025496;
        Thu, 25 Mar 2021 07:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+hc5QzBp8dI1Nj437tRScoE7b36iWkHz03eULCcpxzc=;
 b=R+4Pi2b/QFwNyJKZLbVJxiPwaxIbRAILc71g2tBYoEXIQNqgrzsvedQX82EMM18zZ8ox
 ktl1KQaoNvkp190+Qxq2DZUWwT/8pf8MfFyWKNZahvyTO/jjSkD4tWa4Zx1ePGsZF8db
 nm9OymUuffVvpeDm97mcHrAFrrmC5ZLr28knJN3GLwLHyagZ0N2upyTOUt7wNrdfMsQv
 3HHg657i2IYrg2Z7wB9NPmYdhZPtLzbAVEuejR//e+fIGAnuBmUz2LJ6GSYSa0GbT3S+
 +IKhT/z2J/cZCs9lN1qtYjaODaYZrkCK7DRPVhV+471EOOkDrmSeiB/aOy+wu/MoZrWz DQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37d90mn80u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 07:32:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P7V2C5043207;
        Thu, 25 Mar 2021 07:32:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 37du00uc9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 07:32:05 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12P7W2Pa023178;
        Thu, 25 Mar 2021 07:32:02 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Mar 2021 00:32:01 -0700
Date:   Thu, 25 Mar 2021 10:31:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] drivers: staging: _adapter is declared twice
Message-ID: <20210325073154.GU1717@kadam>
References: <20210325062843.852204-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325062843.852204-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=946 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250055
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=906 suspectscore=0 clxscore=1011 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 02:28:40PM +0800, Wan Jiabing wrote:
> struct _adapter has been declared at 23rd line. 
> Remove the duplicate.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/staging/rtl8712/drv_types.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
> index 0c4325073c63..976d19cdcf87 100644
> --- a/drivers/staging/rtl8712/drv_types.h
> +++ b/drivers/staging/rtl8712/drv_types.h
> @@ -36,7 +36,6 @@ enum _NIC_VERSION {
>  	RTL8716_NIC
>  };
>  
> -struct _adapter;
>  
>  struct	qos_priv	{

You need to delete the blank line after it as well to avoid the
checkpatch warning about two blank lines in a row.

regards,
dan carpenter

