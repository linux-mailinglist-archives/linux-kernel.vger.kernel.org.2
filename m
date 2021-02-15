Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCEC31B7AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 11:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhBOKxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 05:53:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42442 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhBOKxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 05:53:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FAorwY042406;
        Mon, 15 Feb 2021 10:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=fMoM8Ix0x/Dbh2zsKueaLXLFv/J/pF55/FcnlbqQ4OU=;
 b=JXuB0yZMVhUlrYljM9aq0DvYcy+9jSnmnGodCSjee2WXcJ5KieE4apcWZDrFhCbr3puB
 4Fu0XH8+mEpeXVTgp1rzW4f9npC1XVFBieYxGLzeQHwsqIXsvECmAnGjfkLdrDVWxJK/
 lYuE2k16aS/w1q+zbf4mZkRbLNzi+qxyrq0zQfgPZfLbt0A5yzKAmS5FiVVdUik9VkPy
 nh9HdWEhLQYGUJNJy8Nv8PEseu+6VwZknD/n9POMKgpgRRhsH2t2qRydZOWXjt6z2lFB
 ZdRBnzWiKpAWtbaOnCJF6ddV5mV5BtZ6ZIK5/mvZN8xqtprbhkyVkRhv239rEzOMnDCL IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36p7dnbkew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 10:52:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FAntIZ167407;
        Mon, 15 Feb 2021 10:52:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 36prpvevdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 10:52:15 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11FAqBlX027234;
        Mon, 15 Feb 2021 10:52:12 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Feb 2021 02:52:11 -0800
Date:   Mon, 15 Feb 2021 13:52:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        elder@kernel.org, linux-kernel@vger.kernel.org, johan@kernel.org,
        greybus-dev@lists.linaro.org,
        Hemansh Agnihotri <hemanshagnihotri27@gmail.com>
Subject: Re: [greybus-dev] [PATCH 1/1] staging: greybus: Added do - while in
 multi statement macro
Message-ID: <20210215105202.GA2087@kadam>
References: <20210211095444.54447-1-hemanshagnihotri27@gmail.com>
 <YCUAMgFa6i9vl9An@kroah.com>
 <20210211101039.m5q26qgxififotqp@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211101039.m5q26qgxififotqp@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150089
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 03:40:39PM +0530, Viresh Kumar wrote:
> On 11-02-21, 11:00, Greg KH wrote:
> > On Thu, Feb 11, 2021 at 03:24:44PM +0530, Hemansh Agnihotri wrote:
> > > This patch add fixes an checkpatch error for "Macros with multiple statements
> > > should be enclosed in a do - while loop"
> > > 
> > > Signed-off-by: Hemansh Agnihotri <hemanshagnihotri27@gmail.com>
> > 
> > Any reason you didn't test-build your patch before sending it out?
> > 
> > That's a bit rude to reviewers :(
> 
> I also wonder how two people stumbled upon the exact same thing at the
> same time. Copy/paste ?
> 

Those things are pretty common where people try to fix the first
checkpatch warning they find.  There was one time some years back when 5
people sent the same patch.

regards,
dan carpenter

