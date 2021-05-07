Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8B33760F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhEGHKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:10:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37244 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhEGHKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:10:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1476iwlH036349;
        Fri, 7 May 2021 07:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/dWssVvW+OYhyXRH8CslM4h4dts36Wl65nMFcErQWHk=;
 b=tLInDZH+S3h9oaiJHi+kOoynlSDH0vaVS89ZviS+JhCvIzKYv2qEJBlp+5pzbvq36ToU
 TSLlEGf7e5SNFysjPS7nU0zmrv5g6Ry2V/wyN4AwA9Z02Ads9z2R1rRPFNi+QS7b29Ab
 zeYM9pHQZ/q/qtzMWJ+JqVnlEusothq2VJTGZ5lGrKO0tYKPi+apI6Wwy90d2MiqaEK0
 7pbE8sr04iOMy54jEDivdDPjpym0XSQP4ePEqakaojtAqnTvPv0JQnRoEj31U1hSUlZD
 QzMFoQKshoFDB9tpez76jVhLLbvL4q288JRCYarzOzY0Qk+zmaZy/5C1wj425L/u6Uqz DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38ctjv0hqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 May 2021 07:09:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14775hcw169282;
        Fri, 7 May 2021 07:09:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38csrgjk6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 May 2021 07:09:09 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 147798fr182448;
        Fri, 7 May 2021 07:09:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 38csrgjk59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 May 2021 07:09:08 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 147793LM016898;
        Fri, 7 May 2021 07:09:03 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 May 2021 00:09:02 -0700
Date:   Fri, 7 May 2021 10:08:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gregkh@linuxfoundation.org, shubhankarvk@gmail.com,
        lee.jones@linaro.org, gustavoars@kernel.org, vulab@iscas.ac.cn,
        john453@faraday-tech.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: fotg210-hcd: Fix an error message
Message-ID: <20210507070843.GG1955@kadam>
References: <94531bcff98e46d4f9c20183a90b7f47f699126c.1620333419.git.christophe.jaillet@wanadoo.fr>
 <1620354030.10796.6.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620354030.10796.6.camel@mhfsdcap03>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: ER7NlGwMOivUgjwtyF4Q5Z87RSE5Wp3_
X-Proofpoint-GUID: ER7NlGwMOivUgjwtyF4Q5Z87RSE5Wp3_
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9976 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105070048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 10:20:30AM +0800, Chunfeng Yun wrote:
> On Thu, 2021-05-06 at 22:39 +0200, Christophe JAILLET wrote:
> > 'retval' is known to be -ENODEV here.
> > This is a hard-coded default error code which is not useful in the error
> > message. Moreover, another error message is printed at the end of the
> > error handling path. The corresponding error code (-ENOMEM) is more
> > informative.
> > 
> > So remove simplify the first error message.
> > 
> > While at it, also remove the useless initialization of 'retval'.
> > 
> > Fixes: 7d50195f6c50 ("usb: host: Faraday fotg210-hcd driver")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  drivers/usb/host/fotg210-hcd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
> > index 6cac642520fc..9c2eda0918e1 100644
> > --- a/drivers/usb/host/fotg210-hcd.c
> > +++ b/drivers/usb/host/fotg210-hcd.c
> > @@ -5568,7 +5568,7 @@ static int fotg210_hcd_probe(struct platform_device *pdev)
> >  	struct usb_hcd *hcd;
> >  	struct resource *res;
> >  	int irq;
> > -	int retval = -ENODEV;
> > +	int retval;
> >  	struct fotg210_hcd *fotg210;
> >  
> >  	if (usb_disabled())
> > @@ -5588,7 +5588,7 @@ static int fotg210_hcd_probe(struct platform_device *pdev)
> >  	hcd = usb_create_hcd(&fotg210_fotg210_hc_driver, dev,
> >  			dev_name(dev));
> >  	if (!hcd) {
> > -		dev_err(dev, "failed to create hcd with err %d\n", retval);
> > +		dev_err(dev, "failed to create hcd\n");
> >  		retval = -ENOMEM;
> How about moving this line before dev_err()? then could keep error log
> unchanged.

Then the error message would print misleading information.  The
usb_create_hcd() does not return -ENOMEM, it returns NULL.

regards,
dan carpenter

