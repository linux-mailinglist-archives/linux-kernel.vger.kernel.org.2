Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5185F35EEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349779AbhDNHr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:47:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41034 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349034AbhDNHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:47:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E7jeKi115510;
        Wed, 14 Apr 2021 07:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=D01IDBkOJKK8IoEXuT4uTN5oFz2k2n3rYP6OKM4xW9E=;
 b=uIw0xgJ2t+SQhQM0rYf65qILiW+EO0cZidcRVUKZrRdXa2JWQyV2vrMc5gmhSf719HEs
 FzL3Q1f6vrNxW3avphYRpp28CJpJN0cKD5wMAoM4warMQXkas1905QXOI5k42cL5cXyX
 3HvzyO8Al6nmzNDta9qsJz5DEijJMtMKZLuZ4nFju/5CQHyG4zvzS7bfwlqp3IwJ/uT2
 Cj6ZyA6Etf/x2CGfQxvISTAP5JN6u+l1m3m+92bm9AukvDvSWa2XN+UmHso7BvDs9qKQ
 UJ3TlHx3BKtSbgi9aIlMlvkKXaTLA4VKEGVTLI4Cr7YuMNXvs6eNQkDPaLx9eU3JmVrJ Zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37u1hbhjr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 07:47:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E7iVs4046913;
        Wed, 14 Apr 2021 07:47:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 37unkqnras-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 07:47:16 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13E7lFb9029724;
        Wed, 14 Apr 2021 07:47:15 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 00:47:15 -0700
Date:   Wed, 14 Apr 2021 10:47:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless
 led_blink_hdl()
Message-ID: <20210414074707.GC6048@kadam>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com>
 <7008359.Jy8utYDuns@linux.local>
 <20210413194844.GR2531743@casper.infradead.org>
 <3505455.GpAHCVcAZI@linux.local>
 <20210414052150.GO6021@kadam>
 <20210414074035.GA1880@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414074035.GA1880@agape.jhs>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140052
X-Proofpoint-GUID: 6OyrOP6oTIHmoYQgyuNXlFRc9SoF979B
X-Proofpoint-ORIG-GUID: 6OyrOP6oTIHmoYQgyuNXlFRc9SoF979B
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1031 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 09:40:36AM +0200, Fabio Aiuto wrote:
> On Wed, Apr 14, 2021 at 08:21:50AM +0300, Dan Carpenter wrote:
> > On Tue, Apr 13, 2021 at 10:08:32PM +0200, Fabio M. De Francesco wrote:
> > > On Tuesday, April 13, 2021 9:48:44 PM CEST Matthew Wilcox wrote:
> > > > On Tue, Apr 13, 2021 at 09:45:03PM +0200, Fabio M. De Francesco wrote:
> > > > > 1) The driver doesn't call that function from anywhere else than the
> > > > > macro. 2) You have explained that the macro add its symbol to a slot
> > > > > in an array that would shift all the subsequent elements down if that
> > > > > macro is not used exactly in the line where it is.
> > > > > 3) Dan Carpenter said that that array is full of null functions (or
> > > > > empty slots?).
> > > > > 
> > > > > Unless that function is called anonymously dereferencing its address
> > > > > from the position it occupies in the array, I'm not able to see what
> > > > > else means can any caller use.
> > > > > 
> > > > > I know I have much less experience than you with C: what can go wrong?
> > > > 
> > > > Here's where the driver calls that function:
> > > > 
> > > > $ git grep wlancmds drivers/staging/rtl8723bs/
> > > > drivers/staging/rtl8723bs/core/rtw_cmd.c:static struct cmd_hdl wlancmds[]
> > > > = { drivers/staging/rtl8723bs/core/rtw_cmd.c:               if
> > > > (pcmd->cmdcode < ARRAY_SIZE(wlancmds)) {
> > > > drivers/staging/rtl8723bs/core/rtw_cmd.c:                       cmd_hdl
> > > > = wlancmds[pcmd->cmdcode].h2cfuns;
> > > >
> > > OK, I had imagined an anonymous call from its location in the array (as I 
> > > wrote in the last phrase of my message). However, I thought that it could 
> > > have been an improbable possibility, not a real one.
> > > 
> > > Linux uses a lot of interesting ideas that newcomers like me should learn. 
> > > Things here are trickier than they appear at first sight.
> > 
> > One trick would be to build the Smatch cross function database.
> > 
> > https://www.spinics.net/lists/smatch/msg00568.html 
> > 
> > Then you could do:
> > 
> > $ ~/path/to/smatch_data/db/smdb.py led_blink_hdl
> > file | caller | function | type | parameter | key | value |
> > drivers/staging/rtl8723bs/core/rtw_cmd.c |       rtw_cmd_thread | rtw_cmd_thread ptr cmd_hdl |           INTERNAL | -1 |                 | uchar(*)(struct adapter*, uchar*)
> > drivers/staging/rtl8188eu/core/rtw_cmd.c |       rtw_cmd_thread | rtw_cmd_thread ptr cmd_hdl |           INTERNAL | -1 |                 | uchar(*)(struct adapter*, uchar*)
> > drivers/staging/rtl8188eu/core/rtw_cmd.c |       rtw_cmd_thread | rtw_cmd_thread ptr cmd_hdl |           BUF_SIZE |  1 |            pbuf | 1,4,6,8,12,14,16,19-20,23-24,48,740,884,892,900,960
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
> 
> very powerful tool.
> 
> I tried this:
> 
> fabio@agape:~/src/git/kernels/staging$ ~/src/git/smatch/smatch_data/db/smdb.py led_blink_hdl
> Traceback (most recent call last):
>   File "/home/fabio/src/git/smatch/smatch_data/db/smdb.py", line 725, in <module>
>     print_caller_info("", func)
>   File "/home/fabio/src/git/smatch/smatch_data/db/smdb.py", line 366, in print_caller_info
>     ptrs = get_function_pointers(func)
>   File "/home/fabio/src/git/smatch/smatch_data/db/smdb.py", line 53, in get_function_pointers
>     get_function_pointers_helper(func)
>   File "/home/fabio/src/git/smatch/smatch_data/db/smdb.py", line 38, in get_function_pointers_helper
>     cur.execute("select distinct ptr from function_ptr where function = '%s';" %(func))
> sqlite3.OperationalError: no such table: function_ptr
> 
> I run smatch version 1.71 on Debian Buster machine
> 

It takes a few hours to build the DB.  The instructions are in the
email.

	~/path/to/smatch/smatch_scripts/build_kernel_data.sh

regards,
dan carpenter

