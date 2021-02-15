Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666CF31BA59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 14:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhBON2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 08:28:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40304 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhBON1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 08:27:36 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FDKmwd078977;
        Mon, 15 Feb 2021 13:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=kC3ddnFu7KnCeXK7Jaz9eWQ6Ye55HYcSZKJgSfoX+fs=;
 b=DLdDKT5PN9lNzsAfbYyaCmtyt5MC5Tux/bC4jwCvdjJG1XnFxBpMf3srXOC1vlKlxPep
 JTBdjiHbScMQcaGp7pnt5e2F4U0Q832wgj+lB7+kxWRY3aAVQl+2Xi1VJtVlEfsGfCGz
 R23XSUbg74MTGmTJ7MvB2f8C5xmxVwgbG8pmejTBod3vxmRyrGHzukMR9su7X4W8JYvP
 09n2Y3l1f7wIZpjw5mmmpmS2xL+lH2mAnQvHiWJv+F4bop86k9zcHriq7WXNK+ImxBX/
 0RK75vHUd4lA0V1cHJZjWK+K+2B2m7Physq2DGW8fLhrVsl9jdK3J65V4HWSbTNwIGha 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36p7dnbyp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 13:26:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11FDK3QN149398;
        Mon, 15 Feb 2021 13:26:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 36prnwsff8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 13:26:16 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11FDQDsD005133;
        Mon, 15 Feb 2021 13:26:13 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Feb 2021 05:26:12 -0800
Date:   Mon, 15 Feb 2021 16:26:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Ivan Safonov <insafonov@gmail.com>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Abheek Dhawan <adawesomeguy222@gmail.com>
Subject: Re: [PATCH] staging:wlan-ng: use memdup_user instead of
 kmalloc/copy_from_user
Message-ID: <20210215132604.GO2087@kadam>
References: <20210213120527.451531-1-insafonov@gmail.com>
 <YCo0aAMajx0AG7JM@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCo0aAMajx0AG7JM@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102150108
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9895 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 09:44:24AM +0100, Michal Hocko wrote:
> On Sat 13-02-21 15:05:28, Ivan Safonov wrote:
> > memdup_user() is shorter and safer equivalent
> > of kmalloc/copy_from_user pair.
> > 
> > Signed-off-by: Ivan Safonov <insafonov@gmail.com>
> > ---
> >  drivers/staging/wlan-ng/p80211netdev.c | 28 ++++++++++++--------------
> >  1 file changed, 13 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
> > index a15abb2c8f54..6f9666dc0277 100644
> > --- a/drivers/staging/wlan-ng/p80211netdev.c
> > +++ b/drivers/staging/wlan-ng/p80211netdev.c
> > @@ -569,24 +569,22 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
> >  		goto bail;
> >  	}
> >  
> > -	/* Allocate a buf of size req->len */
> > -	msgbuf = kmalloc(req->len, GFP_KERNEL);
> > -	if (msgbuf) {
> > -		if (copy_from_user(msgbuf, (void __user *)req->data, req->len))
> > -			result = -EFAULT;
> > -		else
> > -			result = p80211req_dorequest(wlandev, msgbuf);
> > +	msgbuf = memdup_user(req->data, req->len);
> 
> Move to memdup_user is definitely a right step. What is the range of
> req->len though? If this can be larger than PAGE_SIZE then vmemdup_user
> would be a better alternative.

req->len shoudn't be anywhere close to PAGE_SIZE but it's actually
important to check req->len and this code does not do that which leads
to memory corruption:

drivers/staging/wlan-ng/p80211netdev.c
   566                  goto bail;
   567          } else if (cmd != P80211_IFREQ) {
   568                  result = -EINVAL;
   569                  goto bail;
   570          }
   571  
   572          msgbuf = memdup_user(req->data, req->len);
   573          if (IS_ERR(msgbuf)) {
   574                  result = PTR_ERR(msgbuf);
   575                  goto bail;
   576          }
   577  
   578          result = p80211req_dorequest(wlandev, msgbuf);

We don't know that "req->len" is >= sizeof(*msgbuf), and then we pass
msgbuf top80211req_dorequest() which calls p80211req_handlemsg().  In
p80211req_handlemsg() then "req->len" has to be larger than
sizeof(struct p80211msg_lnxreq_hostwep).

   579  
   580          if (result == 0) {
   581                  if (copy_to_user
   582                      ((void __user *)req->data, msgbuf, req->len)) {
   583                          result = -EFAULT;
   584                  }
   585          }
   586          kfree(msgbuf);
   587  
   588  bail:
   589          /* If allocate,copyfrom or copyto fails, return errno */
   590          return result;
   591  }

Smatch has a problem parsing this code because struct ifreq *ifr is a
union and Smatch gets confused.  :/

regards,
dan carpenter
