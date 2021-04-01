Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B07135104A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhDAHoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:44:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35856 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhDAHoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:44:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1317YTWk184020;
        Thu, 1 Apr 2021 07:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=hFOln3RptcUl4fkykhiWc28Mr1nhar6ZZiG6DyXmxDE=;
 b=e5zA0M+5srnhyOrnWA9n2qo5d4hSj2xE7EQ1dhsE2VpxhXEaqmX4DZWOi9+e6DTQ2PWO
 CxxoPoF7ARKO2HSzjDKzMyjV4Rvzk+2MiHMtGBxCXSIT0cYUybN+P8sMk1XK5maMVTgN
 O7+QZReqhoMBQgQyvXdwG6nJVIGmrDaBP4lo28mLYUJut8gDGwuugK7CA8rVWzCFFI1a
 E4slayXefStVe2UArHkkzrUEuk2XXPAZie55GfObigMLKLFosi8/FIvJ18/vz0oYmBR4
 HCExbdZ6v4yWIUeKS4uepkbfs7otnbr3bNQFAuxIRZkI/+F+LBhgk309RkYKHkKX/Sao 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37n2a00tvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 07:43:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1317ewnB079943;
        Thu, 1 Apr 2021 07:43:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 37n2aaw5er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 07:43:43 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1317hfHk032134;
        Thu, 1 Apr 2021 07:43:41 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Apr 2021 07:43:40 +0000
Date:   Thu, 1 Apr 2021 10:43:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH -next v2] staging: greybus: camera: Switch to
 memdup_user_nul()
Message-ID: <20210401074332.GO2065@kadam>
References: <20210401031752.2861248-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401031752.2861248-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010053
X-Proofpoint-GUID: p4kt3Sn3qoZmKngwk_f0Qma362uYHAeQ
X-Proofpoint-ORIG-GUID: p4kt3Sn3qoZmKngwk_f0Qma362uYHAeQ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:17:52AM +0800, Yang Yingliang wrote:
> Use memdup_user_nul() helper instead of open-coding to
> simplify the code.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/staging/greybus/camera.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index b570e13394ac..2ecdc1bc5092 100644
> --- a/drivers/staging/greybus/camera.c
> +++ b/drivers/staging/greybus/camera.c
> @@ -1120,16 +1120,9 @@ static ssize_t gb_camera_debugfs_write(struct file *file,
>  	if (len > 1024)
>  		return -EINVAL;
>  
> -	kbuf = kmalloc(len + 1, GFP_KERNEL);
> -	if (!kbuf)
> -		return -ENOMEM;
> -
> -	if (copy_from_user(kbuf, buf, len)) {
> -		ret = -EFAULT;
> -		goto done;
> -	}
> -
> -	kbuf[len] = '\0';
> +	kbuf = memdup_user_nul(buf, len);
> +	if (IS_ERR(kbuf))
> +		return PTR_ERR(kbuf);;
                                    ^^
There is an extra semi-colon here.  Checkpatch actually catches this
sort of typo.

regards,
dan carpenter

