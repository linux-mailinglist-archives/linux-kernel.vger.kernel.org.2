Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7731F68A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhBSJ1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:27:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36504 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBSJ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:27:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J9OqRU022352;
        Fri, 19 Feb 2021 09:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+jSkHsONTkTAseVQX+sbaAc6sHzUxCQX5x/sMxZIGnw=;
 b=VWWO5tkc6ARoeLA2pZ2HJX/Cx2EZlcWKG94D1ZVPy5oY2slSwJQDd3DcGSq3gaQfdh8Q
 QeoFEOPKQtEacgT1TPVKpHYXV9CaZljb2iGe7+RNzQL4lljkGVbKgjWA474ccJ3APoZQ
 FUKiXCh8qPWm9AyBfRvX2wd1CQ6R58lZ7PFb4Gkl6KcYslQdTh2KI8lVclm4HctnGaE9
 fuCBAXhczlwXtJ9OWbhoyjbVL68aPu+buKitrHX4chhXarzuhyS8yXnsehhaemqlMOYY
 1zKA4IM7vAJkkNJl7YylOqINM2DyLuL+HQn5hWIdQsb4tNalFBgJurhd8ghM9dWQAUSd sA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36p49bgxhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 09:26:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11J9KVhH115387;
        Fri, 19 Feb 2021 09:26:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 36prbrxcvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 09:26:36 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11J9QX7b022082;
        Fri, 19 Feb 2021 09:26:33 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Feb 2021 01:26:32 -0800
Date:   Fri, 19 Feb 2021 12:26:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Ian Abbott'" <abbotti@mev.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Atul Gopinathan <atulgopinathan@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: comedi: cast to (unsigned int *)
Message-ID: <20210219092621.GU2087@kadam>
References: <20210217165907.9777-1-atulgopinathan@gmail.com>
 <YC1T06VCh0K2BBW5@kroah.com>
 <20210217181000.GB10124@atulu-ubuntu>
 <YC1fzjVOwiqzO1nb@kroah.com>
 <3cfef23d-8d4a-205c-61e8-cbe8c9a0c0f4@mev.co.uk>
 <21a953261eb44e7ba302cfe74d8efa2d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a953261eb44e7ba302cfe74d8efa2d@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190073
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 09:03:59AM +0000, David Laight wrote:
> > It's kind of moot anyway because the patch is outdated.  But the reason
> > for the ___force is that the same `struct comedi_cmd` is used in both
> > user and kernel contexts.  In user contexts, the `chanlist` member
> > points to user memory and in kernel contexts it points to kernel memory
> > (copied from userspace).
> 
> Can't you use a union of the user and kernel pointers?
> (Possibly even anonymous?)
> Although, ideally, keeping them in separate fields is better.
> 8 bytes for a pointer isn't going make a fat lot of difference.
> 

Creating a union is worse than adding casts.  With the casts, at least
you know that you're doing something dangerous.  It's good that it looks
scary because it is scary.

Keeping them in separate fields is a good idea, but this is part of the
user space API so it's not possible.

The best we can do is adding some more comments so people know why we
are doing the scary casts.

regards,
dan carpenter

