Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D114392BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhE0Kid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:38:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52292 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbhE0Kia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:38:30 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RAYhTT178963;
        Thu, 27 May 2021 10:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=80S8cMT7bKdLi9y0x2gMMKJOdqWMukWva0P9NsqCifs=;
 b=QYMQaj10mKZyWZcVAHzHtCX5IDbcCvyDQnXQQYgNZ75tgXjtVkpDpNzXYJIn/p4P+4Ld
 yY6xXN3Wcd8rC5uaX9Ip0GcdQwf3M1dCDSIR0PHud2GJ6mB26SuZCqcfLmoIKpwKRvnB
 wQMe+ah3nayLcXukUISpOBCwKkvFl6sIYy2ijqtU/gM9Ofcd7GVke3lyDmJrqqvFgmIU
 VPgs+IpUExiXCxKLCmnXabI/fXsB6t9n34a5p3Wudiozk42QrEgHdcKxaOVbuKsYpEVk
 g3wMX9jeAVlxdVGeNL5+STqZfXtHZm79SmHhqwPJY6wHLT3qqvFoTZjIzePo2DlrlPcn FQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38pqfcktj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 10:36:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14RAZVIB046312;
        Thu, 27 May 2021 10:36:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38pq2w9dv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 10:36:52 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14RAapv1048160;
        Thu, 27 May 2021 10:36:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 38pq2w9dus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 May 2021 10:36:51 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14RAan4w032245;
        Thu, 27 May 2021 10:36:49 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 May 2021 03:36:48 -0700
Date:   Thu, 27 May 2021 13:36:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gregkh@linuxfoundation.org, atull@kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] firmware: stratix10-svc: Fix a resource leak in an error
 handling path
Message-ID: <20210527103641.GS1955@kadam>
References: <0ca3f3ab139c53e846804455a1e7599ee8ae896a.1621621271.git.christophe.jaillet@wanadoo.fr>
 <f669ed42-348f-808b-afeb-9528d2ece6ee@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f669ed42-348f-808b-afeb-9528d2ece6ee@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: 5i188k-zGJ1R86dMPKsfMfYhL4OVBBv1
X-Proofpoint-GUID: 5i188k-zGJ1R86dMPKsfMfYhL4OVBBv1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 02:13:12PM -0500, Richard Gong wrote:
> >   	dev_set_drvdata(dev, svc);
> >   	pr_info("Intel Service Layer Driver Initialized\n");
> > +	return 0;
> > +
> > +err_put_device:
> > +	platform_device_put(svc->stratix10_svc_rsu);
> > +err_free_kfifo:
> > +	kfifo_free(&controller->svc_fifo);
> 
> Need for the allocated memory pool as well,
> 	if (ctrl->genpool)
>                 gen_pool_destroy(ctrl->genpool);
> 

Good point, but there is no need to check, the genpool is not optional
and the "if (ctrl->genpool)" condition could be deleted from the remove
function as well.

err_put_device:
	platform_device_put(svc->stratix10_svc_rsu);
err_free_kfifo:
	kfifo_free(&controller->svc_fifo);
err_destroy_pool:
	gen_pool_destroy(genpool);

	return ret;

But the other question is what's on with the &svc_ctrl list?  I would
have thought that we needed to remove freed controller from the list as
well, but looking at it now I think the list itself should be removed.
I think there can only be one item in the list at a time.  So we could
just make the controller pointer a file scope global or we could find
some other way to go from the client pointer to the controller pointer.

regards,
dan carpenter


