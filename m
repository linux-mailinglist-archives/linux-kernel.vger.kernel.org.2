Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5EF321A39
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhBVOW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:22:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52486 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhBVOAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 09:00:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MDxU0Z136147;
        Mon, 22 Feb 2021 13:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=aX+P9kh7w4UrrUdvSNZ8xoZ4dyXpe9ZJLipE1LjBy2U=;
 b=WX8e80nw0rkxB2HuST1OsIRcKWf/tYjD2GujmQfoVYnUgWfFElANLNgYTn6DI2fnEM01
 QLOEoXkRRMeQRO1EUwI/aq2QKey8eNV90NGD+REJE/aLQha8glJGTIYbBMDPKYj+AxWh
 BNjEzLCloeJBoKonqqBAbYlyEBKrMOG7EfiaBIp3K3cWukw0iwXT5466MB59lL1Ce6qS
 CXslRkaDgvhc8Q7XAEZp20KT4BQLdonZohd4WT6/abl2yxAflfnck1yZZZNVS0kVfWkt
 C1r7iW0iQyUwSVztdKVGT0Ec83Utkllj67yB5iQ3FVzb2Ni3uvj8QdtCbdBmrkMznsDW BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36tsuqupye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 13:59:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MDuPqY033485;
        Mon, 22 Feb 2021 13:59:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 36ucbw4b99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 13:59:48 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11MDxk1P000702;
        Mon, 22 Feb 2021 13:59:46 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Feb 2021 05:59:46 -0800
Date:   Mon, 22 Feb 2021 16:59:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     karthek <mail@karthek.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: wlan-ng/p80211 : check userspacebuf size for
 sanity
Message-ID: <20210222135937.GV2222@kadam>
References: <YDOnoLJzHYXMZBA/@karthik-strix-linux.karthek.com>
 <20210222132132.GU2222@kadam>
 <YDO0vtJyyGSSi44n@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDO0vtJyyGSSi44n@karthik-strix-linux.karthek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have added the Driver Devel list to the CC list.  Adding linux-kernel
is sort of useless.  The correct people who are interested in this patch
are all on the Driver Devel list.

On Mon, Feb 22, 2021 at 07:12:22PM +0530, karthek wrote:
> On Mon, Feb 22, 2021 at 04:21:33PM +0300, Dan Carpenter wrote:
> > On Mon, Feb 22, 2021 at 06:16:24PM +0530, karthek wrote:
> > > currently p80211knetdev_do_ioctl() is testing user passed
> > > struct ifreq for sanity by checking for presence of a magic number,
> > > in addition to that also check size field, preventing buffer overflow
> > > before passing data to p80211req_dorequest() which casts it
> > > to *struct p80211msg
> > > 
> > > Signed-off-by: karthek <mail@karthek.com>
> > > ---
> > > is this correct?
> > > is it necessary to check for size in addition to magicnum?
> > > did i even understand the problem correctly?
> > > 
> > >  drivers/staging/wlan-ng/p80211netdev.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
> > > index 70570e8a5..c7b78d870 100644
> > > --- a/drivers/staging/wlan-ng/p80211netdev.c
> > > +++ b/drivers/staging/wlan-ng/p80211netdev.c
> > > @@ -568,7 +568,10 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
> > >  		result = -EINVAL;
> > >  		goto bail;
> > >  	}
> > > -
> > > +	if (req->len < sizeof(struct p80211msg)) {
> > > +		result = -EINVAL;
> > > +		goto bail;
> > > +	}
> > 
> > Please don't send private emails.  Always CC the list.
> sorry
> > 
> > That's only a partial solution.  You need to check in p80211req_handlemsg()
> > as well and probably other places.
> currently p80211req_handlemsg() is only referenced in p80211req_dorequest()
> can we check that there instead?

If I have to do all the work in finding the buffer overflows, then I
should write my own patch.  :/

Anyway the p80211knetdev_do_ioctl() function calls p80211req_dorequest()
which calls p80211req_handlemsg(wlandev, msg); and
wlandev->mlmerequest(wlandev, msg);.

We have already discussed the p80211req_handlemsg() function.  The
wlandev->mlmerequest() function is always just prism2sta_mlmerequest().
The prism2sta_mlmerequest() calls a bunch of functions and each of those
functions need to have a different limit check added to prevent memory
corruption.

Homework #1: Should we get rid of the wlandev->mlmerequest() pointer
and just call prism2sta_mlmerequest() directly?

Homework #2: Another solution is to just delete all these custom IOCTLs.
I don't know what they do so I don't know if they are necessary or not.

regards,
dan carpenter

