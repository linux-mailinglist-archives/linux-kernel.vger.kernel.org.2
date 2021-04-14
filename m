Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB43435EC2F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 07:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347324AbhDNFXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 01:23:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54696 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347213AbhDNFXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 01:23:04 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E5JgvP102985;
        Wed, 14 Apr 2021 05:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=CZkptgcO3DGKGJ08iwMUHqqcUbf4lj+BxntMCOs7Pgg=;
 b=LsZPIn9KekMDv6/z7JVklg4qX8brFrq2kGV+fjPr27SCCdagI5oyS20hTRohxbDSKfbV
 AWjAOSE+pZ56WEjiYUQUM/ggzK/XWHVHVRf4GPYdBVC2S9oOxKZO6H9GvmKxxUI5x64G
 9Z09Ot3B1EElFzt9o5CtpNXtc7eX8VoUCyhnGSjkeVpp2qN4zSiOQRLwFawV5pYj8B/o
 gDql57cbRC3R3iqyeWc4E5WEeQGJEvTdqS/ZTN7cDtpoRWhsPB4ohXD739lcz4HFObUS
 hFy/z7EerHoRfFo2773Dcb29DLhxUiU4ZJwhbLZgVm4ZmHg3R+SSgKWk1ByGR/BZZWX+ ZQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37u1hbh7he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 05:22:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E5KVwL169344;
        Wed, 14 Apr 2021 05:22:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 37unkqgyd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 05:22:04 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13E5Lwdd019636;
        Wed, 14 Apr 2021 05:21:59 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Apr 2021 22:21:58 -0700
Date:   Wed, 14 Apr 2021 08:21:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] :staging: rtl8723bs: Remove useless
 led_blink_hdl()
Message-ID: <20210414052150.GO6021@kadam>
References: <20210413155908.8691-1-fmdefrancesco@gmail.com>
 <7008359.Jy8utYDuns@linux.local>
 <20210413194844.GR2531743@casper.infradead.org>
 <3505455.GpAHCVcAZI@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3505455.GpAHCVcAZI@linux.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140036
X-Proofpoint-GUID: YEzxurop5mggoI9SiG_lYx3jEjcb2yFb
X-Proofpoint-ORIG-GUID: YEzxurop5mggoI9SiG_lYx3jEjcb2yFb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1031 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 10:08:32PM +0200, Fabio M. De Francesco wrote:
> On Tuesday, April 13, 2021 9:48:44 PM CEST Matthew Wilcox wrote:
> > On Tue, Apr 13, 2021 at 09:45:03PM +0200, Fabio M. De Francesco wrote:
> > > 1) The driver doesn't call that function from anywhere else than the
> > > macro. 2) You have explained that the macro add its symbol to a slot
> > > in an array that would shift all the subsequent elements down if that
> > > macro is not used exactly in the line where it is.
> > > 3) Dan Carpenter said that that array is full of null functions (or
> > > empty slots?).
> > > 
> > > Unless that function is called anonymously dereferencing its address
> > > from the position it occupies in the array, I'm not able to see what
> > > else means can any caller use.
> > > 
> > > I know I have much less experience than you with C: what can go wrong?
> > 
> > Here's where the driver calls that function:
> > 
> > $ git grep wlancmds drivers/staging/rtl8723bs/
> > drivers/staging/rtl8723bs/core/rtw_cmd.c:static struct cmd_hdl wlancmds[]
> > = { drivers/staging/rtl8723bs/core/rtw_cmd.c:               if
> > (pcmd->cmdcode < ARRAY_SIZE(wlancmds)) {
> > drivers/staging/rtl8723bs/core/rtw_cmd.c:                       cmd_hdl
> > = wlancmds[pcmd->cmdcode].h2cfuns;
> >
> OK, I had imagined an anonymous call from its location in the array (as I 
> wrote in the last phrase of my message). However, I thought that it could 
> have been an improbable possibility, not a real one.
> 
> Linux uses a lot of interesting ideas that newcomers like me should learn. 
> Things here are trickier than they appear at first sight.

One trick would be to build the Smatch cross function database.

https://www.spinics.net/lists/smatch/msg00568.html

Then you could do:

$ ~/path/to/smatch_data/db/smdb.py led_blink_hdl
file | caller | function | type | parameter | key | value |
drivers/staging/rtl8723bs/core/rtw_cmd.c |       rtw_cmd_thread | rtw_cmd_thread ptr cmd_hdl |           INTERNAL | -1 |                 | uchar(*)(struct adapter*, uchar*)
drivers/staging/rtl8188eu/core/rtw_cmd.c |       rtw_cmd_thread | rtw_cmd_thread ptr cmd_hdl |           INTERNAL | -1 |                 | uchar(*)(struct adapter*, uchar*)
drivers/staging/rtl8188eu/core/rtw_cmd.c |       rtw_cmd_thread | rtw_cmd_thread ptr cmd_hdl |           BUF_SIZE |  1 |            pbuf | 1,4,6,8,12,14,16,19-20,23-24,48,740,884,892,900,960


Which says that led_blink_hdl() is called as a function pointer called
"cmd_hdl" from rtw_cmd_thread().

Hm...  It says it can be called from either rtw_cmd_thread() function
(the rtl8723bs or rtl8188eu version) which is not ideal.  But also
basically harmless so whatever...

regards,
dan carpenter
