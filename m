Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA03A7759
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 08:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFOGtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 02:49:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57382 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhFOGtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:49:46 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15F6jXB7116543;
        Tue, 15 Jun 2021 06:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=PdOJ7uhVLoKJ8IudTXgqsqb8p8KH82LJt1NWmmnufdk=;
 b=qxtukR5YNH/ei1lKq8QmbjHHldRsKE5p6sZMtv2WQUJzt47FtOiYHIDcuEDABFpky0sm
 8mvIIH+KvzwD32bj1kWGKADuY+slP+1+9YFqMriNbo5Vp6Qaqe8ok9rKxtF2QiofZsbD
 BF5nJr8wONuJH/6vj4qnQl/3qWf2RMqj2Irc1d/N8h6kEaxJG6sxXnMPbWSavx50YMIi
 KQSd0f8U+mYA9nL3R0ulABjWSrVV17Vxp3woviQG318JLg3WnTpBAkouhOMmlMdWWXXY
 ltWoVa0CR4SiwqLnoQxmEXfXdSo9Rwmu+zZxwoMUnaFSa63qNwLZRQY0kMCgdT5ps+vn LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 394jecdawf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 06:47:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15F6jDnX067338;
        Tue, 15 Jun 2021 06:47:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3959ckamh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 06:47:33 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15F6lXwv072668;
        Tue, 15 Jun 2021 06:47:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3959ckamg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 06:47:33 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15F6lQ8k001325;
        Tue, 15 Jun 2021 06:47:27 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Jun 2021 23:47:26 -0700
Date:   Tue, 15 Jun 2021 09:47:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] staging: rtl8188eu: fix usb_submit_urb error handling
Message-ID: <20210615064719.GA2120@kadam>
References: <20210612180019.20387-1-martin@kaiser.cx>
 <20210612180019.20387-2-martin@kaiser.cx>
 <YMdr0alJDEGfsqOA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMdr0alJDEGfsqOA@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: lURhPgTfq9QPm6nTf8f0uMKvBx1t_uCK
X-Proofpoint-GUID: lURhPgTfq9QPm6nTf8f0uMKvBx1t_uCK
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10015 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106150040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 04:46:41PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Jun 12, 2021 at 08:00:15PM +0200, Martin Kaiser wrote:
> > -EPERM should be handled like any other error.
> 
> Why?  This is not "any other error" for the usb core, right?
> 

Yeah.  It's a fair point that this commit message doesn't say why to do
it or explain the implications.

> > 
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> >  drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
> > index ec07b2017fb7..0ceb05f3884f 100644
> > --- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
> > +++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
> > @@ -366,7 +366,6 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
> >  	struct usb_device *pusbd = pdvobj->pusbdev;
> >  	int err;
> >  	unsigned int pipe;
> > -	u32 ret = _SUCCESS;
> >  
> >  	if (adapter->bDriverStopped || adapter->bSurpriseRemoved ||
> >  	    adapter->pwrctrlpriv.pnp_bstop_trx) {
> > @@ -403,10 +402,10 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
> >  			  precvbuf);/* context is precvbuf */
> >  
> >  	err = usb_submit_urb(purb, GFP_ATOMIC);
> > -	if ((err) && (err != (-EPERM)))
> > -		ret = _FAIL;
> 
> if -EPERM returns from this function, someone set the "reject" bit on
> the urb.
> 
> Can this driver do that?  Where did this check originally come from, as
> it feels like this was added for a good reason.
> 

Yeah.  It can cancel urbs in rtw_hal_inirp_deinit().  That function used
to have a better name, "usb_read_port_cancel" and in retrospect the
original name was probably better.

I think the reason for that -EPERM was treated differently was because
originally there were some error messages printed if usb_submit_urb()
failed.  (They were't actually printed because this code is buggy).  The
authors probably didn't want to print the error messages but
accidentally made it return success as well.

There is only one caller that checks the return and it only affects the
behavior if we race against open.  Can that even happen?  I'm pretty
sure that returning a failure is the correct behavior but I'm going to
leave it to Martin to check for absolutely sure.  :P

regards,
dan carpenter

