Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7D2351052
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhDAHsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:48:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53726 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhDAHrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:47:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1317i673030903;
        Thu, 1 Apr 2021 07:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2bcovUiEvqLT3u5u4Mm/FOWPoWqn+P5taGkkF1I4kq4=;
 b=tm8X6D86+wim7J4xB4euCtAUJDXPhNsPcr4ewc4uaX1h34LkBUEtqpJQP3oBeMOHNT/J
 sS3FBIjTTnonJ5I4MQbZB0RLvVp2PoMkqRkvEOH92BVSM3yOvpuXi2h/eSwUObPGrMLJ
 i5+ugOzV+dltP4tdCq2TUvI+FdlcJGBbYZW7pTO8xIm00bbum+n4HnkZQVc83J3R42gD
 yKOGwFDadkZBiaZRokOwcGRlXCRymfsjyuvhSP2a7EjzR4ogKX3Wb8r0+5ID/5c03P02
 aSp/AfDija/Qr4W2n4ok/IApAG5Cwj5QJNelCXUBJxSP8wO6AhH7dWyCKDnk5SmZzeAF xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37n2akgu0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 07:47:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1317fhsC181366;
        Thu, 1 Apr 2021 07:47:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 37n2arwn28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 07:47:28 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1317lQ4e016493;
        Thu, 1 Apr 2021 07:47:26 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Apr 2021 00:47:26 -0700
Date:   Thu, 1 Apr 2021 10:47:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH -next v2] staging: greybus: camera: Switch to
 memdup_user_nul()
Message-ID: <20210401074719.GP2065@kadam>
References: <20210401031752.2861248-1-yangyingliang@huawei.com>
 <20210401074332.GO2065@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401074332.GO2065@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010053
X-Proofpoint-ORIG-GUID: hWVRwZENoBwvIUFAvOrohnWO9uz3lIkC
X-Proofpoint-GUID: hWVRwZENoBwvIUFAvOrohnWO9uz3lIkC
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9940 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 10:43:32AM +0300, Dan Carpenter wrote:
> On Thu, Apr 01, 2021 at 11:17:52AM +0800, Yang Yingliang wrote:
> > Use memdup_user_nul() helper instead of open-coding to
> > simplify the code.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  drivers/staging/greybus/camera.c | 13 +++----------
> >  1 file changed, 3 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> > index b570e13394ac..2ecdc1bc5092 100644
> > --- a/drivers/staging/greybus/camera.c
> > +++ b/drivers/staging/greybus/camera.c
> > @@ -1120,16 +1120,9 @@ static ssize_t gb_camera_debugfs_write(struct file *file,
> >  	if (len > 1024)
> >  		return -EINVAL;
> >  
> > -	kbuf = kmalloc(len + 1, GFP_KERNEL);
> > -	if (!kbuf)
> > -		return -ENOMEM;
> > -
> > -	if (copy_from_user(kbuf, buf, len)) {
> > -		ret = -EFAULT;
> > -		goto done;
> > -	}
> > -
> > -	kbuf[len] = '\0';
> > +	kbuf = memdup_user_nul(buf, len);
> > +	if (IS_ERR(kbuf))
> > +		return PTR_ERR(kbuf);;
>                                     ^^
> There is an extra semi-colon here.  Checkpatch actually catches this
> sort of typo.

So when someone makes a typo like this, my response is:

1) Let's add this to checkpatch (turns out it was already done)
2) Let's grep the kernel and fix the other instances.  The command would
be something like: git grep ';;$' | grep '\.c:'

regards,
dan carpenter

