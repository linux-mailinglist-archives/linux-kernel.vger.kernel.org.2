Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1534F372B4F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhEDNrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:47:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45528 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhEDNr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:47:27 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144DdSbg170143;
        Tue, 4 May 2021 13:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=79Ai/Di0JCvnrw4CopF3XPt9cikg1GNfNQSqF6ynUFM=;
 b=HkiCmQrTrnMteOwB+9CRTDgvPAnwlWI49kpEh/dLQ2M+ENs3Gn33pnXv6D25zC5n9BlV
 oQZGemP2702sh8ayWph0KJwjhZPeT3+alqI+WnTF6vfjfHzzxZ4G2q9Cgp2YTcInrYYC
 DX9Ql9cjSU+CwwaRNs5/PVRCkVcAoiA6zJpVlrn6IirspsB6WC557+fKl7EchzzO8VHK
 G9nEb1OpXx5nLM5Pp7iJ7903GaVJP6JuAODiOWZX2uzVH5lJZ2Phq/AA4xCFt+122XKq
 fP2MNpP1fEOjmJO2UGFDCudNvw1Rq1QqmNQ+wt6fkPDrdD3Ws9onlpLB0VcpqGTpG6yG vQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 388vgbq3bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 13:46:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144DkE25023944;
        Tue, 4 May 2021 13:46:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 388xt44awe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 13:46:20 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 144DkJGJ025229;
        Tue, 4 May 2021 13:46:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 388xt44aur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 13:46:19 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 144DkFS8021541;
        Tue, 4 May 2021 13:46:16 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 May 2021 13:46:15 +0000
Date:   Tue, 4 May 2021 16:46:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v7] staging: unisys: visorhba: Convert module from IDR to
 XArray
Message-ID: <20210504134606.GR21598@kadam>
References: <20210504133253.32269-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504133253.32269-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: S0RvSQDvwrHl6c0aq3BIib0UyHTi6b-p
X-Proofpoint-ORIG-GUID: S0RvSQDvwrHl6c0aq3BIib0UyHTi6b-p
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 03:32:53PM +0200, Fabio M. De Francesco wrote:
> +static int setup_scsitaskmgmt_handles(struct xarray *xa, struct uiscmdrsp *cmdrsp,
>  				       wait_queue_head_t *event, int *result)
>  {
> -	/* specify the event that has to be triggered when this */
> -	/* cmd is complete */
> -	cmdrsp->scsitaskmgmt.notify_handle =
> -		simple_idr_get(idrtable, event, lock);
> -	cmdrsp->scsitaskmgmt.notifyresult_handle =
> -		simple_idr_get(idrtable, result, lock);
> +	int ret;
> +	u32 id;
> +
> +	/* specify the event that has to be triggered when this cmd is complete */
> +	ret = xa_alloc_irq(xa, &id, event, xa_limit_32b, GFP_KERNEL);
> +	if (ret) 
> +		return ret;
> +	else
> +		cmdrsp->scsitaskmgmt.notify_handle = id;
> +	ret = xa_alloc_irq(xa, &id, result, xa_limit_32b, GFP_KERNEL);
> +	if (ret) {
> +		xa_erase_irq(xa, cmdrsp->scsitaskmgmt.notify_handle);
> +		return ret;
> +	} else
> +		cmdrsp->scsitaskmgmt.notifyresult_handle = id;

This else statement is not required.  Please use the checkpatch script.

	if (ret) {
		xa_erase_irq(xa, cmdrsp->scsitaskmgmt.notify_handle);
		return ret;
	}
	cmdrsp->scsitaskmgmt.notifyresult_handle = id;


> +
> +	return 0;
>  }
>  

[ snip ]

> @@ -1096,7 +1080,7 @@ static void visorhba_remove(struct visor_device *dev)
>  	scsi_remove_host(scsihost);
>  	scsi_host_put(scsihost);
>  
> -	idr_destroy(&devdata->idr);
> +	xa_destroy(&devdata->xa);

Don't add this.  Matthew explained this earlier.

>  
>  	dev_set_drvdata(&dev->device, NULL);
>  	debugfs_remove(devdata->debugfs_info);

regards,
dan carpenter
