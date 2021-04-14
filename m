Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A65D35EE20
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349564AbhDNHBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:01:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50100 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348486AbhDNHBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:01:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E6oU9i193686;
        Wed, 14 Apr 2021 07:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=m/BC1PXDIRHi2UEq3219ItPZCDRmPUW6dTcnGRZcjxY=;
 b=JPZS+leU8X3ymojlV9/FmnKxJQSxThB5TdrHD6eFOJ+MzMzyiz0pPYK8vI2U9tNbr+9p
 lVeOYnbsdQIW48RPG9kMx8jQzBhF3D9eTv9oD15QlKX4BzkIE2NOZksaieqvJalMVe1h
 mH0RpL7INo1iCddd62XOxSDV/QxqqbrC/vxZBOQDIM3ENu+7txTWME7J0xnJl+Pu0CrW
 FjcF3FlljAvxduv8JRp4sDqhAYT1RJ7ctZBvhXIYKw7nfqTSR4E1SvmKMF8W3hqrzm2B
 amwNoLcZ/AYqZvKwi/h/tvLET8DoQZMLUrr+LMqZXFsVknbDTDhdaydSUsFICNx+tuAw +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37u3ymha26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 07:00:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E6nWMu022173;
        Wed, 14 Apr 2021 07:00:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 37unstgv07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 07:00:37 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13E70XIn028227;
        Wed, 14 Apr 2021 07:00:33 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 00:00:32 -0700
Date:   Wed, 14 Apr 2021 10:00:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless
 led_blink_hdl()
Message-ID: <20210414070025.GB6048@kadam>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com>
 <3505455.GpAHCVcAZI@linux.local>
 <20210414052150.GO6021@kadam>
 <2418632.vfNx7fMs9o@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2418632.vfNx7fMs9o@linux.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140046
X-Proofpoint-GUID: uhSbYR7RrlWs6VDyQdG19EBzB06XCwT-
X-Proofpoint-ORIG-GUID: uhSbYR7RrlWs6VDyQdG19EBzB06XCwT-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1031
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 08:33:48AM +0200, Fabio M. De Francesco wrote:
> On Wednesday, April 14, 2021 7:21:50 AM CEST Dan Carpenter wrote:
> > On Tue, Apr 13, 2021 at 10:08:32PM +0200, Fabio M. De Francesco wrote:
> > > On Tuesday, April 13, 2021 9:48:44 PM CEST Matthew Wilcox wrote:
> > > > On Tue, Apr 13, 2021 at 09:45:03PM +0200, Fabio M. De Francesco 
> wrote:
> > > > > 1) The driver doesn't call that function from anywhere else than
> > > > > the
> > > > > macro. 2) You have explained that the macro add its symbol to a
> > > > > slot
> > > > > in an array that would shift all the subsequent elements down if
> > > > > that
> > > > > macro is not used exactly in the line where it is.
> > > > > 3) Dan Carpenter said that that array is full of null functions (or
> > > > > empty slots?).
> > > > > 
> > > > > Unless that function is called anonymously dereferencing its
> > > > > address
> > > > > from the position it occupies in the array, I'm not able to see
> > > > > what
> > > > > else means can any caller use.
> > > > > 
> > > > > I know I have much less experience than you with C: what can go
> > > > > wrong?
> > > > 
> > > > Here's where the driver calls that function:
> > > > 
> > > > $ git grep wlancmds drivers/staging/rtl8723bs/
> > > > drivers/staging/rtl8723bs/core/rtw_cmd.c:static struct cmd_hdl
> > > > wlancmds[] = { drivers/staging/rtl8723bs/core/rtw_cmd.c:            
> > > >   if
> > > > (pcmd->cmdcode < ARRAY_SIZE(wlancmds)) {
> > > > drivers/staging/rtl8723bs/core/rtw_cmd.c:                      
> > > > cmd_hdl
> > > > = wlancmds[pcmd->cmdcode].h2cfuns;
> > > 
> > > OK, I had imagined an anonymous call from its location in the array (as
> > > I wrote in the last phrase of my message). However, I thought that it
> > > could have been an improbable possibility, not a real one.
> > > 
> > > Linux uses a lot of interesting ideas that newcomers like me should
> > > learn. Things here are trickier than they appear at first sight.
> > 
> > One trick would be to build the Smatch cross function database.
> > 
> > https://www.spinics.net/lists/smatch/msg00568.html 
> > 
> > Then you could do:
> > 
> > $ ~/path/to/smatch_data/db/smdb.py led_blink_hdl
> > file | caller | function | type | parameter | key | value |
> > drivers/staging/rtl8723bs/core/rtw_cmd.c |       rtw_cmd_thread |
> > rtw_cmd_thread ptr cmd_hdl |           INTERNAL | -1 |                 |
> > uchar(*)(struct adapter*, uchar*)
> > drivers/staging/rtl8188eu/core/rtw_cmd.c |       rtw_cmd_thread |
> > rtw_cmd_thread ptr cmd_hdl |           INTERNAL | -1 |                 |
> > uchar(*)(struct adapter*, uchar*)
> > drivers/staging/rtl8188eu/core/rtw_cmd.c |       rtw_cmd_thread |
> > rtw_cmd_thread ptr cmd_hdl |           BUF_SIZE |  1 |            pbuf |
> > 1,4,6,8,12,14,16,19-20,23-24,48,740,884,892,900,960
> > 
> > 
> > Which says that led_blink_hdl() is called as a function pointer called
> > "cmd_hdl" from rtw_cmd_thread().
> > 
> > Hm...  It says it can be called from either rtw_cmd_thread() function
> > (the rtl8723bs or rtl8188eu version) which is not ideal.  But also
> > basically harmless so whatever...
> > 
> > regards,
> > dan carpenter
> >
> Nice tool, thanks. I'll surely use it when it is needed to find out which  
> callers use a function pointer.
> 
> However I cannot see how it can help in this context. That function *does* 
> something, even if I cannot understand why someone needs a function to test 
> the initialization of a pointer. Furthermore it is actually called by 
> rtw_cmd_thread() (as you found out by using smatch) that expect one of the 
> two possible values that led_blink_hdl() returns.
> 
> That said, what trick could I use for the purpose of getting rid of that 
> function? At this point I'm not sure it could be made.

If you look at how this is called:

drivers/staging/rtl8723bs/core/rtw_cmd.c
   449                  memcpy(pcmdbuf, pcmd->parmbuf, pcmd->cmdsz);
   450  
   451                  if (pcmd->cmdcode < ARRAY_SIZE(wlancmds)) {
   452                          cmd_hdl = wlancmds[pcmd->cmdcode].h2cfuns;
   453  
   454                          if (cmd_hdl) {
   455                                  ret = cmd_hdl(pcmd->padapter, pcmdbuf);
                                                                      ^^^^^^^

   456                                  pcmd->res = ret;
   457                          }
   458  
   459                          pcmdpriv->cmd_seq++;
   460                  } else {
   461                          pcmd->res = H2C_PARAMETERS_ERROR;
   462                  }
   463  
   464                  cmd_hdl = NULL;

The led_blink_hdl() function returns success if "pcmdbuf" is non-NULL
and fail if it's NULL.  "pcmdbuf" is never supposed to be NULL.  (The
"supposed" caveat is because there may be a race in rtw_sdio_if1_init()
which briefly allows a NULL "pcmdbuf", but that is an unrelated bug).

Anyway, there is no point to the led_blink_hdl() function.  Likely
they intended it to do something but never got around to implementing
it.  Just delete it.

regards,
dan carpenter

