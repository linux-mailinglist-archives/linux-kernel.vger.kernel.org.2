Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7729C31572C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 20:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhBITsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 14:48:55 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59862 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhBISUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:20:35 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119IDxjr023448;
        Tue, 9 Feb 2021 18:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=mXF2S+84uidYb9ZOFD31+7fdLlCAK8tk/gCYcuBHPpU=;
 b=iIY7aYAYvR+PHO6+Ag3WI0TMXcSNYBvCnLLkq7CUW2b6bRU/r08sKfVQPmhMTh0aMIoe
 /yI0aKJZfrihya3QVhR0pRrvALIPBTJ5NwdziLSwOnISG33nfzjwE1y40QzNysXjlAZr
 Zjui89+o7n11vaLairSDA2xaGRWNbHHS+cBblJKRi4G9dB4AEMjn+EauO4ZTqrrALuLh
 Rgyrm8eyqa/+NQ4Lv9ADOrYDkOlwf0KkCHtcrt0SGRC6iXTS5Lp0PcvvQgVNutVgFAyY
 ApMybUEMpib+B/kyc0fUj8wnlrUhnC1HJUEem5k1w7TEvP3yvh1YS+Uabfk4lCVAxyE4 +Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36hgmagn76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 18:19:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119IAdC3116880;
        Tue, 9 Feb 2021 18:19:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 36j4vrpss6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 18:19:37 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 119IJZeH008693;
        Tue, 9 Feb 2021 18:19:36 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Feb 2021 10:19:35 -0800
Date:   Tue, 9 Feb 2021 21:19:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ameynarkhede03@gmail.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: Fix DMA from stack
Message-ID: <20210209181914.GQ2696@kadam>
References: <20210209145415.29609-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209145415.29609-1-ameynarkhede03@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090087
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 08:24:15PM +0530, ameynarkhede03@gmail.com wrote:
> From: Amey Narkhede <ameynarkhede03@gmail.com>
> 
> Stack allocated buffers cannot be used for DMA
> on all architectures so allocate usbdev buffer
> using kmalloc().
> 
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_usb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
> index dc4da66c3..50dc463d4 100644
> --- a/drivers/staging/gdm724x/gdm_usb.c
> +++ b/drivers/staging/gdm724x/gdm_usb.c
> @@ -56,7 +56,7 @@ static int gdm_usb_recv(void *priv_dev,
> 
>  static int request_mac_address(struct lte_udev *udev)
>  {
> -	u8 buf[16] = {0,};
> +	u8 *buf;
>  	struct hci_packet *hci = (struct hci_packet *)buf;
>  	struct usb_device *usbdev = udev->usbdev;
>  	int actual;
> @@ -66,6 +66,10 @@ static int request_mac_address(struct lte_udev *udev)
>  	hci->len = gdm_cpu_to_dev16(udev->gdm_ed, 1);
>  	hci->data[0] = MAC_ADDRESS;
> 
> +	buf = kmalloc(16, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
>  	ret = usb_bulk_msg(usbdev, usb_sndbulkpipe(usbdev, 2), buf, 5,
>  			   &actual, 1000);


You need to add a kfree() as well.

regards,
dan carpenter

