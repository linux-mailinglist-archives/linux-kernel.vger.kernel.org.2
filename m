Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD634FDFE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhCaKYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:24:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37960 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbhCaKYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:24:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VA5HIB105333;
        Wed, 31 Mar 2021 10:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=WKBWbPsQJxc9VOnqiOE3LeStzi42sIL5UBxKpzrYUKE=;
 b=PzsEUq0G0gD9J0pfgu7s+JnOA12j1S+QjlpXfkQSZT0CQqazwu7iEjWA6OmboBp3c4XK
 u7t/6PYeQ/Vp876gEUV+bqS4ivBReB+uY21sOkeWhgZnfm41S3zgOdsn2qHcrBcs4VK4
 K9u6os+GK//5hPEgZBr3vfpTETT03kuN1sTEv3PbRtvHqAThnJHfdIkCaTJnhksX7w8q
 GR/la476IgvGut5QgIbCufrqVBM26HFGNhz8kSfr1K6hF2S9+TnHBEYepmsLLk9dAHfU
 ggu0/O9vYAaAEJ7sDGAnxq0qvd0prTEfMJ40y6eAFsgN7KyZBSSljZetSQ0m3OTmJNLb eA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37mad9srn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 10:24:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VA6d9l009287;
        Wed, 31 Mar 2021 10:24:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 37mac59rm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 10:24:22 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12VAOLBv028265;
        Wed, 31 Mar 2021 10:24:21 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Mar 2021 03:24:21 -0700
Date:   Wed, 31 Mar 2021 13:24:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH -next] staging: greybus: camera: Switch to
 memdup_user_nul()
Message-ID: <20210331102414.GL2065@kadam>
References: <20210331095201.2173793-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331095201.2173793-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310073
X-Proofpoint-ORIG-GUID: Z2UkK1U1itczqd4-02As8YtvJo7NbOiI
X-Proofpoint-GUID: Z2UkK1U1itczqd4-02As8YtvJo7NbOiI
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 05:52:01PM +0800, Yang Yingliang wrote:
> Use memdup_user_nul() helper instead of open-coding to
> simplify the code.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/staging/greybus/camera.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index b570e13394ac..0f005facffbc 100644
> --- a/drivers/staging/greybus/camera.c
> +++ b/drivers/staging/greybus/camera.c
> @@ -1120,16 +1120,10 @@ static ssize_t gb_camera_debugfs_write(struct file *file,
>  	if (len > 1024)
>  		return -EINVAL;
>  
> -	kbuf = kmalloc(len + 1, GFP_KERNEL);
> -	if (!kbuf)
> +	kbuf = memdup_user_nul(buf, len);
> +	if (IS_ERR(kbuf))
>  		return -ENOMEM;

return PTR_ERR(kbuf);

>  
> -	if (copy_from_user(kbuf, buf, len)) {
> -		ret = -EFAULT;
> -		goto done;
> -	}
> -
> -	kbuf[len] = '\0';
>  
   ^^^^^^^^
Please delete this blank line so there aren't two blank lines in a row.

>  	ret = op->execute(gcam, kbuf, len);

regards,
dan carpenter

