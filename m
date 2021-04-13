Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A5A35E631
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345672AbhDMSVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:21:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45882 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbhDMSV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:21:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DIA0X9196183;
        Tue, 13 Apr 2021 18:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=zJmMkPWwEHnOFNx4ivbLmpeaymE1s3KJ3peFswgFjwY=;
 b=Kz82JCk912rEHsVJnuMfsqwRct74ZYpiSyuQQmrkD57v3S5jmDXBR/BZA99ydZ6R2ij4
 XybjaP5583EBOkD3KCpCFSBWXrkb+6jMlQUK7huhCPMUNyYMEu4SxneK10dZD5QUnSNJ
 6GQBRdhic7Izhu7LukZtc/SEzksGCa1x3Q9pBes1kycindtvTd8EbeYKi1MflqJ8/aVi
 GKP9ed6BxW49GHFLlhAp3hv3e6nb9SQ8Ktx+UhJlaYt6/LPLcnjJpkyn0gEjF3QMuWO7
 ptMubslnUkWkf90VVFZsfinK2CCjC3EsG7+7QxMT3NigNR0FYwfbBJks7RHkKGuoEyDe +Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37u3erg2fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 18:21:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DIBTOL004221;
        Tue, 13 Apr 2021 18:20:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 37unssrb0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 18:20:59 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13DIKv8P020610;
        Tue, 13 Apr 2021 18:20:57 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Apr 2021 11:20:56 -0700
Date:   Tue, 13 Apr 2021 21:20:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless
 led_blink_hdl()
Message-ID: <20210413182050.GJ6021@kadam>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com>
 <1843649.8FsqevVC75@linux.local>
 <alpine.DEB.2.22.394.2104131826160.8430@hadrien>
 <3381109.TaO10cqo9c@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3381109.TaO10cqo9c@linux.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130123
X-Proofpoint-ORIG-GUID: D77uMoNZ9pSonbrsXGT2AVbjHDFVxWIe
X-Proofpoint-GUID: D77uMoNZ9pSonbrsXGT2AVbjHDFVxWIe
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1031
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 06:47:06PM +0200, Fabio M. De Francesco wrote:
> On Tuesday, April 13, 2021 6:27:17 PM CEST Julia Lawall wrote:
> > On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:
> > > On Tuesday, April 13, 2021 6:04:16 PM CEST Julia Lawall wrote:
> > > > On Tue, 13 Apr 2021, Fabio M. De Francesco wrote:
> > > > > Removed the led_blink_hdl() function (declaration, definition, and
> > > > > caller code) because it's useless. It only seems to check whether
> > > > > or
> > > > > not a given pointer is NULL. There are other (simpler) means for
> > > > > that
> > > > > purpose.
> > > > > 
> > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > ---
> > > > > 
> > > > >  drivers/staging/rtl8723bs/core/rtw_cmd.c         | 1 -
> > > > >  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
> > > > >  drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
> > > > >  3 files changed, 11 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > b/drivers/staging/rtl8723bs/core/rtw_cmd.c index
> > > > > 0297fbad7bce..4c44dfd21514 100644
> > > > > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > > > > @@ -150,7 +150,6 @@ static struct cmd_hdl wlancmds[] = {
> > > > > 
> > > > >  	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
> > > > >  	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param),
> > > > >  	set_chplan_hdl) /*59*/>
> > > > > 
> > > > > -	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param),
> > > 
> > > led_blink_hdl)
> > > 
> > > > > /*60*/
> > > > 
> > > > This is worrisome.  Doyou fully understand the impact of this?  If
> > > > not,
> > > > the change is probably not a good idea.
> > > 
> > > This is that macro definition:
> > > 
> > > #define GEN_MLME_EXT_HANDLER(size, cmd) {size, cmd},
> > > 
> > > struct C2HEvent_Header {
> > > 
> > > #ifdef __LITTLE_ENDIAN
> > > 
> > >         unsigned int len:16;
> > >         unsigned int ID:8;
> > >         unsigned int seq:8;
> > > 
> > > #else
> > > 
> > >         unsigned int seq:8;
> > >         unsigned int ID:8;
> > >         unsigned int len:16;
> > > 
> > > #endif
> > > 
> > >         unsigned int rsvd;
> > > 
> > > };
> > > 
> > > It's a bit convoluted with regard to my experience. Probably I don't
> > > understand it fully, but it seems to me to not having effects to the
> > > code where I removed its use within core/rtw_cmd.c.
> > > 
> > > What am I missing?
> > 
> > It seems that the function is being put into an array.  Probably someone
> > expects to find it there.  Probably you have shifted all of the functions
> > that come afterwards back one slot so that they are all in the wrong
> > places.
> > 
> > julia
> >
> Thanks for your explanation. Obviously this implies that the function 
> cannot be removed, unless one fill the slot that is deleted by to not 
> calling this macro at the right moment. 
> 
> I also suppose that providing a function pointer with a NULL value wouldn't 
> work either.

It would work.  That array is full of NULL function pointers.

regards,
dan carpenter

