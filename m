Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A432BAC6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358275AbhCCL5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:57:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54438 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236446AbhCCFYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 00:24:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1235L2ke112284;
        Wed, 3 Mar 2021 05:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6sJkNvGHrVmMtI/AqoNEU4T1AjvVLS5rr4NaMFJNQx0=;
 b=Ys8UiwK9LsCq+zVpWUiV33OpRLsjVP3Ys53b7o9lE/6Tz+tGKzaODeXPqcVBf3Tu68wq
 z/ZEhl8/+beHoJcbR966tIkMtgHNCD08Qfyt8estb9xs7XUIKpIfnwwHb1FmrDxQKH1u
 T3Y13le4oNwE0WlsM+LFiQi5DBTpANSUVnVOcaBIUS1e2oDb/KwoCP+vqhasLg2p+tFL
 PWjYj+BcLI6+ECEAZ9lwTo8OwTcafiIDvHJhjlOBqOtIZzGxGZui6DMxns5RVpa+2b75
 Kmmr4gR1RxJcp9tu0WdPOxM9r8qlk320Ki4b1fBcz558ka5/dI4JTggRB8mTTFlOxRYs /w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36ye1ma0wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 05:22:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1235L3L0118668;
        Wed, 3 Mar 2021 05:22:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 370000tn26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 05:22:48 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1235Ml3B023460;
        Wed, 3 Mar 2021 05:22:47 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Mar 2021 21:22:46 -0800
Date:   Wed, 3 Mar 2021 08:22:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] firewire: prevent integer overflow on 32bit systems
Message-ID: <20210303052239.GY2222@kadam>
References: <YD4e9XOD8JPlJzxW@mwanda>
 <20210302221911.6c1582e2@kant>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302221911.6c1582e2@kant>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030039
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 10:19:11PM +0100, Stefan Richter wrote:
> On Mar 02 Dan Carpenter wrote:
> > In TCODE_STREAM_DATA mode, on 32bit systems, the "sizeof(*e) +
> > request->length" operation can overflow leading to memory corruption.
> > 
> > Fixes: 18e9b10fcdc0 ("firewire: cdev: add closure to async stream ioctl")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/firewire/core-cdev.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
> > index fb6c651214f3..314de0384035 100644
> > --- a/drivers/firewire/core-cdev.c
> > +++ b/drivers/firewire/core-cdev.c
> > @@ -587,6 +587,9 @@ static int init_request(struct client *client,
> >  	    request->length < 4)
> >  		return -EINVAL;
> >  
> > +	if (request->length > ULONG_MAX - sizeof(*e))
> > +		return -EINVAL;
> > +
> >  	e = kmalloc(sizeof(*e) + request->length, GFP_KERNEL);
> >  	if (e == NULL)
> >  		return -ENOMEM;
> 
> There is already a length check for asynchronous stream requests.
> It happens in ioctl_send_stream_packet().

Oh, yeah.  You're right.  I should have looked more carefully.  Sorry.

regards,
dan carpenter

