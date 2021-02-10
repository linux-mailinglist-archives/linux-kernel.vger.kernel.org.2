Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61550316688
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhBJMXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:23:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57232 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhBJMUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:20:17 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ACFIJj117957;
        Wed, 10 Feb 2021 12:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=RSSYx5ZKyLwSH2WY20S360SzVHoate5hhIssdRM7i4w=;
 b=PePQVMmURpS+XLsy2yNWWMLPwxopuGErm8HDwg+7rysPqfu+Fc3eNsM8ba93ZfXUzTWT
 WOdg00F3KBIBf/arngjQ+PXREcvrC15p2xfBkJClXR8UhfqKO+CLCLQYiDmquMUjsura
 jNZkX+O8nQfmB49VMuvDch6E/irvkCBxe2s6HmS6SsEshzPpz2xerlNsq+5Y56VZNnMc
 2P//T/MIqf/Oy9y6x4qYPgKP5eVcheLS3hWAn56D+k9PrzYB5xkDVbPug0c/bO/HBNbe
 DszITgMQe2V0NAVJNpapEiGNrxQaXQD2CPCjACbJ6GBXGFbmH2y8GZeWcJzA00tx7YMN fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36m4upsnum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 12:19:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ACEg1c074049;
        Wed, 10 Feb 2021 12:19:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 36j4vsqyj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 12:19:24 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11ACJNjJ008895;
        Wed, 10 Feb 2021 12:19:23 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 04:19:22 -0800
Date:   Wed, 10 Feb 2021 15:19:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] staging: ralink-gdma: Fix checkpatch.pl CHECK
Message-ID: <20210210121915.GX2696@kadam>
References: <20210210120348.262328-1-aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210120348.262328-1-aakashhemadri123@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 05:33:48PM +0530, Aakash Hemadri wrote:
> Remove CHECK: Lines should not end with a '('
> 
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
> 
>  drivers/staging/ralink-gdma/ralink-gdma.c | 28 ++++++++++++-----------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
> index 655df317d0ee..a11f915f3308 100644
> --- a/drivers/staging/ralink-gdma/ralink-gdma.c
> +++ b/drivers/staging/ralink-gdma/ralink-gdma.c
> @@ -135,8 +135,7 @@ struct gdma_data {
>  	int (*start_transfer)(struct gdma_dmaengine_chan *chan);
>  };
> 
> -static struct gdma_dma_dev *gdma_dma_chan_get_dev(
> -	struct gdma_dmaengine_chan *chan)
> +static struct gdma_dma_dev *gdma_dma_chan_get_dev(struct gdma_dmaengine_chan *chan)
>  {
>  	return container_of(chan->vchan.chan.device, struct gdma_dma_dev,
>  		ddev);
> @@ -510,10 +509,11 @@ static void gdma_dma_issue_pending(struct dma_chan *c)
>  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
>  }
> 
> -static struct dma_async_tx_descriptor *gdma_dma_prep_slave_sg(
> -		struct dma_chan *c, struct scatterlist *sgl,
> -		unsigned int sg_len, enum dma_transfer_direction direction,
> -		unsigned long flags, void *context)
> +static struct dma_async_tx_descriptor
> +	*gdma_dma_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,

Don't do it like this...  The original code is better so, I guess, lets
leave it as is.  There are two accepted ways to start a function in the
kernel:

ONE:
static type
function_name(paramenters)

TWO
static type function_name(paramenters)

Either option will let you grep for the names of the functions:

	egrep "^[a-zA-Z]" dir/file.c | grep '('

regards,
dan carpenter


