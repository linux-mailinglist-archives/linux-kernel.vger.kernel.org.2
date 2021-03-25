Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E823489D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCYHJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:09:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60866 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCYHJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:09:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P704Bd177227;
        Thu, 25 Mar 2021 07:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=VaoZTJ6LkffLVohHJ9mc4VH0Jy4omsa7wqQBqnPFKw0=;
 b=PDlojjzB+QL3ixZ8xdY8QeMv+KqyhzAq0YcwMUyrx2e9VvG10RBpEmB6BsJ7DHaWVU8j
 fQwM0SV3DtCMV6Kf2W/CsTKOHJElmZBxnlTkTRVIuiAvBafCe5vcAiCuNFm9c+4aSW9R
 mgWsujl8QSOBRQUyGZd3v5mQBXXIf9J68yAt73tpLu5xC8mnEQ/7bI0FxwIThJ+R/MXC
 YU91fw3QcuaAiL4PW9FmukZWjRoIVtbSbIETWjgLeiaVO1PWj1bYG8vV+70FNpoBInB0
 cDtnzyYVwYcsluAoe13Ay1jZkb/qKuAsGigbmfMIgh2WXhNwIQ0evPF22oLwxlAP3CZm DQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 37d90mn6fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 07:08:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P711nf140464;
        Thu, 25 Mar 2021 07:08:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 37du00tqrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 07:08:03 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12P77xmT003688;
        Thu, 25 Mar 2021 07:07:59 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Mar 2021 00:07:58 -0700
Date:   Thu, 25 Mar 2021 10:07:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, colin.king@canonical.com
Subject: Re: [PATCH] ALSA: usb-audio: Fix missing return assignment
Message-ID: <20210325070751.GU1667@kadam>
References: <20210324172604.GA380592@LEGION>
 <20210324185047.GP1667@kadam>
 <abc46d0ad37b9e59ac71288d04e43c9911f71072.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc46d0ad37b9e59ac71288d04e43c9911f71072.camel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250051
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 01:24:23AM +0500, Muhammad Usama Anjum wrote:
> On Wed, 2021-03-24 at 21:50 +0300, Dan Carpenter wrote:
> > > -			usb_driver_claim_interface(driver, iface, (void *)-1L);
> > > +			err = usb_driver_claim_interface(driver, iface, (void *)-1L);
> > 
> > This is in a loop so only the last return value is used.  Which seems
> > sort of weird and pointless that the last value would matter more than
> > the others.
> > 
> Correct. Lets not store the return value. To stop the static analyzers
> to report the missing return assignment, can we add (void) in start of
> this function call? I've not seen use of (void) this way in the
> kernel. Is there any other way used in the kernel?

Don't add (void).  Don't add any code just to help static checkers, only
do it if it helps humans.  The (void) stuff is ugly.  We have a
__must_check annotation for functions where it's a bug not to check the
return and the usb_driver_claim_interface() is not a __must_check
function.  Just ignore the static checker when it's wrong.

When I'm reviewing static checker warnings, I only look at the new ones.
Then after I've looked at them, I mark them as old.  I currently have
65k old ignored warnings.

regards,
dan carpenter

