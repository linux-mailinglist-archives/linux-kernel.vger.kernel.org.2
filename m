Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337AA3BA0A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhGBMpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:45:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47134 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232085AbhGBMpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:45:11 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 162CRFxT013803;
        Fri, 2 Jul 2021 12:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+IJpwNA8I0jIOfMjRkbkVtev9n6gx+bEwQcrxVqju/M=;
 b=mD60Jo191DdsOuG8QiWskOjnV9jmPZovt9p6d3t4QJZ0XSF6dafpJjEQZ7UO5b2dDRT/
 tbyPg4qvMlbpuMyU53DNz6yii8n3erLwkNTyaoczqF5i7Mz/wyjQJnxRnOyuQGnM8dpN
 tOQ1v41gT27WHq7aT1ZyGzhx7Y9XWFR4pWnIOAnS+b88im6r7xlFKy/sf/EA03ft2Rrs
 6s6LdZUy784LmFrCo/K19x3R44FaMxPQEHL09JV3YicbEBg//BO1GlazNrLfOZuPGV0j
 o32wzKfktCtiWV9rcb6LeCRh/tA9YAFoX/VDX95hwneSQTu6JLrnc/Lt40v3/M2D1ADY DQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gy5w3n99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 12:42:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 162CeELB008075;
        Fri, 2 Jul 2021 12:42:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 39dt9nsdax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 12:42:33 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 162CgW1b014129;
        Fri, 2 Jul 2021 12:42:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 39dt9nsdaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 12:42:32 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.14.4) with ESMTP id 162CgVDA009874;
        Fri, 2 Jul 2021 12:42:31 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Jul 2021 05:42:31 -0700
Date:   Fri, 2 Jul 2021 15:42:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Remove an unused variable and some
 lines of code
Message-ID: <20210702124225.GW2040@kadam>
References: <20210701144707.22820-1-fmdefrancesco@gmail.com>
 <20210702074840.GT2040@kadam>
 <20210702083521.GV2040@kadam>
 <2153683.Tj7f0gbxMR@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2153683.Tj7f0gbxMR@linux.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: DeV7b3Mf6xTtMvSAxMZRo7jDxsVaxF48
X-Proofpoint-ORIG-GUID: DeV7b3Mf6xTtMvSAxMZRo7jDxsVaxF48
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 02:14:45PM +0200, Fabio M. De Francesco wrote:
> On Friday, July 2, 2021 10:35:21 AM CEST Dan Carpenter wrote:
> > On Fri, Jul 02, 2021 at 10:48:40AM +0300, Dan Carpenter wrote:
> > > On Thu, Jul 01, 2021 at 04:47:07PM +0200, Fabio M. De Francesco wrote:
> > > > Remove set but unused iw_operation_mode[]. Remove all the lines of
> > > > code from the function rtw_wx_set_rate, except the "return 0;" line
> > > > to not break userland code that somewhat uses this IOCTL.
> > > > 
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > [...]
> > > 
> 
> Dear Dan,
> 
> > > Just delete this whole file.  It doesn't do anything now.
> > 
> > Sorry, I meant function, not file.  *chortle*.  :P
> 
> No worries, it is clear it was unintended.
> 
> Back to the function... As you may suspect :-) I know practically nothing 
> neither of Linux device drivers or of whatever else kernel, so I take your 
> words for good. ASAP, I'll send a v2 of this patch.
> 
> However, I usually like to understand what I make (just for fun and... more).
> 
> That rtw_wx_set_rate() is the implementation of the SIOCSIWRATE IOCTL command. 
> I hope that I have not misunderstood it, have I? 

Correct.

> 
> However, we know that this function does practically nothing and then simply 
> returns 0 to the user. That's exactly the reason why I deleted all its lines 
> (except one). 

It used to do nothing in a much more complicated way before commit
1aef69ecacda ("staging: rtl8188eu: Remove function rtw_setdatarate_cmd()")

> 
> If I am a user of that command I get a "success" return code (0) and I don't  
> notice that it won't be able to set the bit rate. However everything should 
> still keep running (I suppose using the default bit rate of the hardware; who 
> really knows?). 

It will still do nothing but now instead of returning success it will
return -ENOTSUPP.  This is done in wireless_process_ioctl().

> 
> Now it's time for two questions: 
> 
> 1) what happens if that command is used by some users that (hopelessly) expect 
> the function to set the bit rate? I mean: if the function is not anymore in 
> the list of the IOCTL commands of the rtw_handlers array will still the user 
> program compile, link, and don't crash at runtime? 
> 

Userspace programs are supposed to be written so that they work with
every wifi driver, so they should be able to handle -ENOTSUPP.  If this
breaks a userspace application then we will have to change it back.  But
returning -ENOTSUPP is the correct behavior, so let's first try to do
the correct thing and then think about working around bugs in userspace
if we find them.

> 2) how should I delete the association of SIOCSIWRATE with rtw_wx_set_rate() 
> in the rtw_handlers array?
> 	- delete the entry and shift the array one position up?
> 	- set the SIOCSIWRATE entry to NULL?

The IW_HANDLER() macro puts the function in the correct position in the
array.  So just delete it.  Everything else will remain unchanged.

regards,
dan carpenter
