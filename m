Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5461333EA1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhCQGxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:53:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44962 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCQGxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:53:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12H6mMrE144487;
        Wed, 17 Mar 2021 06:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ZG6B4kmr+vgeAC7nT6ygggEDkvVAPDCcE2NWhZF9qEE=;
 b=DV9d0Ohf/aUYAfOgpKUfWRSKYydl5+3ecI0yf5tLVm+AFnRsZJaRcLWqbq+qwKy9RX3Y
 5Lr8Jx9cVYs5ScgVybkAyd3+DB5Cld2A9BASMWpUkbdj/Tfyrx3XVRyKATg9jhc3WMFN
 lF3XWBeo+jfQ2D7+vRngoGblbRPEyDpNBCoo4DjFUdiXv2jOIGNY6fJFArmjDAWiQrah
 mJqNKh2TGvVFsg3PEaFyOBaKGZh2OqCU1fIYWp0je3QsF7SXZNu/t8uJKKyHwBN/oyOZ
 6tjM0/LRLf78p5StI3mb0FmWU3uDIKgeztH4eK/2d2zAqCX3KSpPoMBAWSR4c7eCwusc mA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37a4ekqx1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 06:53:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12H6ojg7148718;
        Wed, 17 Mar 2021 06:53:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3796yuex2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 06:53:03 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12H6quXG021234;
        Wed, 17 Mar 2021 06:52:56 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Mar 2021 23:52:55 -0700
Date:   Wed, 17 Mar 2021 09:52:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ian Abbott <abbotti@mev.co.uk>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: das800: fix request_irq() warn
Message-ID: <20210317065248.GW21246@kadam>
References: <92b7c57b-b645-9965-8157-4ca76a803cba@mev.co.uk>
 <20210316224227.348310-1-ztong0001@gmail.com>
 <20210317051426.GX2087@kadam>
 <CAA5qM4BcQ6+aa1C3_28zLVojwLduK-WZwsEftuasJgo8z0t0ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4BcQ6+aa1C3_28zLVojwLduK-WZwsEftuasJgo8z0t0ew@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170052
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 01:55:40AM -0400, Tong Zhang wrote:
> Thanks for pointing that out.
> Yes you are right there is a mistake.
> I am a human. Human make mistakes. Therefore I make mistakes.
> 

Yep.  We all make mistakes.  One thing to do is if you make a mistake
then check to see if anyone else has made a similar mistake.

git grep repalce

If enough people make that specific mistake then consider adding it to
the list of commonly mispelled words:  scripts/spelling.txt
I looked through the logs and it looks like someone mispells it once a
year so it's probably not common enough to worry about.

regards,
dan carpenter

