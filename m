Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF43431F8AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBSLxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:53:25 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59368 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhBSLxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:53:20 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JBmato050666;
        Fri, 19 Feb 2021 11:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+8bfzoRhaDwROuEZgt+Kzx6XCu4t+OtL05aUyZz0JUE=;
 b=EISFXHFw7ksoSz7lPqC/m1k0hKtjKQQuLlyGIyF6lENl6YL8QebU2W0QA35HHP3+wlZ+
 laG+SBvIiec7YyKRUiHiP7NW/7M057BIeZfjLjCummiOkYkhRINCBhFQpxNSNMi+e6h4
 Yo3JJFtBcKfPbBtL5+uSAupCKuya/MHKkU28YzksDM9uWF8t/dh2X5VoyZPLMQzYRe1v
 n2c76LV4dAldnzROX80VX2YrrFqaUCwA37Ohf4G6q5S+yauXYEL4xONWOU/LaqtK3twH
 Lp0a2swWJfei21P0HqW/0E/cKJUflDwiARv3DeUhoP6iawE2wIFWdJeS5XdPz+475ZCO nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 36p49bhdds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 11:52:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JBoDWU043814;
        Fri, 19 Feb 2021 11:52:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 36prq1tev2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 11:52:33 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11JBqWRD017112;
        Fri, 19 Feb 2021 11:52:32 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Feb 2021 03:52:31 -0800
Date:   Fri, 19 Feb 2021 14:52:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     17UCS047_Prakash Dubey <prakashdubey1999@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fwserial: Fix alignment of function parameters
Message-ID: <20210219115221.GW2087@kadam>
References: <20210218102851.GA20810@gmail.com>
 <YC9zNVWX7R9kD0Rq@kroah.com>
 <CALVjNJP=iXH+u2zUB93UZo+1+Ly0g23k5JtPXFbx=vaO+5-0Gw@mail.gmail.com>
 <YC+VX4NpOWX1z3+V@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC+VX4NpOWX1z3+V@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190096
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:39:27AM +0100, Greg KH wrote:
> On Fri, Feb 19, 2021 at 03:25:38PM +0530, 17UCS047_Prakash Dubey wrote:
> > I was unable to align it right below the opening parenthesis, just by using
> > tabs. And when I did that with spaces, the checkpatch yelled at me for
> > using spaces. Any suggestions how to do this without using spaces? I am
> > using vim, I will try to find a workaround meanwhile.
> 

Your comment hasn't made it to the list yet.  Sometimes there is a delay
or maybe it was blocked for some reason (html email?).

You are allowed to use spaces but you can't have 8 consecutive spaces
and spaces are not allowed before a tab character.  The way to align it
is:

		ret = wait_event_interruptible_timeout(port->wait_tx,
						       !test_bit(IN_TX, &port->flags),
						       10);

[tab x6][space x7]!test_bit(IN_TX, &port->flags)

regards,
dan carpenter
