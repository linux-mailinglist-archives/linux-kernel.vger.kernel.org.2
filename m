Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA283317134
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhBJUUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:20:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52676 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhBJUTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:19:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AK9gvf074519;
        Wed, 10 Feb 2021 20:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=x2Ejk5RTL4VbPBIwoylAxyBhC1fu3VWb9A+AHvApC/E=;
 b=YFbk5RQl2VX0gDl90v0dz4UVcjEPaNMDzhsMCjAIUW/LunG/TIf0L989dfgGkw+9oIxq
 fr5JiDFPUlVAaq9sl8HvzbW6P1ehw+iZSqc2IV2GH95euZRZ8IeX2h2PBl2a8PvgNjKF
 ExE738ehYkaTcT1I4SstdYgeeskyCt03sVZIJBMHzE4I+IjPej0On7hSr1Gdv5EC6LvN
 BXdtU9eyDLlE6sVcd4TnRgExjkSmtJx7+tqhRXz/6ImTacMhfOkye0wv0ncMQhXvWXcm
 CjueuaJJYJl/ivn2tE+E8J9UpfENBwj11Jl/Tyczo3SpvfwpMxYEy99Kk83XywEtvniA 6A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36hjhqvygb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 20:19:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AKEjpk025623;
        Wed, 10 Feb 2021 20:19:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 36j4vt9rb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 20:19:07 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11AKJ6rr005492;
        Wed, 10 Feb 2021 20:19:06 GMT
Received: from kadam (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 10 Feb 2021 12:19:00 -0800
USER-AGENT: Mutt/1.9.4 (2018-02-28)
MIME-Version: 1.0
Message-ID: <20210210201849.GA2696@kadam>
Date:   Wed, 10 Feb 2021 20:18:49 +0000 (UTC)
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        luk@wybcz.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: cleanup macros within
 include/rtw_debug.h
References: <20210210170003.100880-1-phil@philpotter.co.uk>
 <20210210184027.GZ2696@kadam> <20210210185544.GA1786@kernelvm>
In-Reply-To: <20210210185544.GA1786@kernelvm>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100180
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 06:55:44PM +0000, Phillip Potter wrote:
> > > diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
> > > index c90adfb87261..d06ac9540cf7 100644
> > > --- a/drivers/staging/rtl8723bs/include/rtw_debug.h
> > > +++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
> > > @@ -201,19 +201,16 @@
> > >  #ifdef DEBUG
> > >  #if	defined(_dbgdump)
> > >  	#undef DBG_871X
> > > -	#define DBG_871X(...)     do {\
> > > -		_dbgdump(DRIVER_PREFIX __VA_ARGS__);\
> > > -	} while (0)
> > > +	#define DBG_871X(...)\
> > > +		_dbgdump(DRIVER_PREFIX __VA_ARGS__)
> > 
> > This can fit on one line:
> > 
> > 	#define DBG_871X(...) _dbgdump(DRIVER_PREFIX __VA_ARGS__)
> > 
> > It's tough with staging code to know how much to change at one time
> > because even after you change the code then it still looks rubbish.
> > This define shouldn't be indented.  The _dbgdump() macro is just
> > 
> > #define _dbgdump printk
> > 
> > so you know, no printk level.  Wow.  etc.  This code is crap.
> 
> So I'm in the process of stripping out _dbgdump entirely as per Greg
> K-H's suggestion - am I to understand raw printk is frowned upon though,
> even with the correct KERN_x level specified?

Yes.  Ideally in drivers everything would use dev_dbg() and dev_err() or
whatever.  But it's perhaps tricky to convert everything in a single
patch so changing _dbgdump() to "#define pr_debug" as an intermediate
step is probably fine.

Look at how people do pr_fmt():
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

You could do a patch that does a mass replacement of DBG_871X with
pr_debug().  Again, I haven't really looked at this code so you'll have
to double check and consider what is the best way to break up the
patches.

> One query I have is that individual patches I'm working on for this file are
> generating an awful lot of checkpatch warnings themselves due to the
> nature of the existing violations on the relevant lines. Is it
> considered acceptable for me to still submit these, providing I do so in
> a series which cleans up the other violations in separate patches?

It's tricky to know how to break up patches.  Probably the simplest
advice is to only clean up a single type of checkpatch warning at a
time.  But fix all the instances of that warning in a file.  Don't
change anything else even if it is tempting.  Do that in the next patch.

The actuall rules are slightly more complicated and nuanced than that,
but if you just fix one type at a time then that's okay.

One thing is that your patches should not introduce new checkpatch
warnings.  So if you have two statements in an if statement and you
delete one, then that means you have to delete he curly braces as well.

regards,
dan carpenter

