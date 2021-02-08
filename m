Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49B031392A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhBHQUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 11:20:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60316 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhBHPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:12:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118F9dXs033475;
        Mon, 8 Feb 2021 15:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ol0bPClWvCVaUabTFV3GQWU3n5U4mCJ6uK7XYxDPnOw=;
 b=jDxgdzGTLBnP6+nzD+E4c4OXKjj8BaMZY3zto3j55JioKi859w9ZvWaTXo/BbmgrhriC
 68VjFxt9JyUw+tozgVeM4exrcRUItb+FUFuuyd4ymoAhAtHRFoWakJskVsmc3IoQ+JmP
 wjAl0hYVe9P0+IuXjW55v6RevJw2BYFAhvYs3BOB82PGotX7zaHb3OlPUHJOaQRT0mxU
 Ymecj9rctUocNoCrO7cDYH1UbB2rBPUW5vHLrVElahxrNvH3cz9b37lrc1N3TPjRJbMo
 Pvn58i5G3sLmoHw2LU8irUVpIY3uGclayuN36jgbXNu3GKZuVXZ3VxMqf/fG5vhD6D0a +A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36hkrmv52r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 15:11:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118FBLAc039903;
        Mon, 8 Feb 2021 15:11:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 36j50yxrwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 15:11:39 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 118FBad0027411;
        Mon, 8 Feb 2021 15:11:36 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Feb 2021 07:11:36 -0800
Date:   Mon, 8 Feb 2021 18:11:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] bus: fsl-mc: Fix test for end of loop
Message-ID: <20210208151129.GJ2696@kadam>
References: <YBf0Br9obNGZTcNI@mwanda>
 <20210208141803.bqbnbgvprtlo3vs6@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208141803.bqbnbgvprtlo3vs6@skbuf>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9888 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080104
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9888 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 02:18:04PM +0000, Ioana Ciornei wrote:
> On Mon, Feb 01, 2021 at 03:28:54PM +0300, Dan Carpenter wrote:
> > The "desc" pointer can't possibly be NULL here.  If we can't find the
> > correct "desc" then tt points to the last element of the
> > fsl_mc_accepted_cmds[] array.  Fix this by testing if
> > "i == FSL_MC_NUM_ACCEPTED_CMDS" instead.
> > 
> > Fixes: 2cf1e703f066 ("bus: fsl-mc: add fsl-mc userspace support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Hi,
> 
> I just noticed that Greg wasn't copied on the initial email.
> 
> If you don't mind I will re-submit your patch along with other updates
> to the fsl-mc bus so that you don't have to bother.
> 

Thanks for doing that!

Was Greg supposed to have been copied, though?  He's not listed in the
./scripts/get_maintainer.pl output.

regards,
dan carpenter

