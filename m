Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132E0305EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhA0OxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:53:01 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57310 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbhA0OvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:51:16 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10REhiJk166078;
        Wed, 27 Jan 2021 14:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=GR3gjkFudMAhVS5F0hZMK0pjUOiBdqiv9A/SI2RyZcA=;
 b=ZfflQAxdptFiUwkg/TNONvt9EJ9+kvoTG9/aeTykFb4weA8w8RuQ9tafnq5UCv9iONHa
 naIwFogLp0LVNMurgcqikCt+lAgr53Hk+yjZBBPs7aLqQPlsoGGFhkXv/BHBlVxNqs1B
 6r29XO4Iwap0QGQqVysKqsFNSmGf1riBI3JUgK8M0HMrNnr9xk+lXg65hGw468eiK2UJ
 Rzs/2AMvxEjuWdRXnGiJ9hsa0H22+Oa8nEc3yPyoqVxk8NuEKeAEGE+KvBz5A/0tjId7
 TCpIx9PiYESfPPsXzZUZz621FXWI6/J7o8yWvjuwxiEslyGQLzLXN2sRobfOS8hbxTLD Uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 3689aaqpuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 14:50:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10REaAuv052722;
        Wed, 27 Jan 2021 14:50:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 368wqxxfq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 14:50:08 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10REnv6D009660;
        Wed, 27 Jan 2021 14:49:58 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jan 2021 06:49:56 -0800
Date:   Wed, 27 Jan 2021 17:49:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     carlis <zhangxuezhi3@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, mh12gx2825@gmail.com,
        oliver.graute@kococonnector.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, sbrivio@redhat.com,
        colin.king@canonical.com, zhangxuezhi1@yulong.com
Subject: Re: [PATCH v10] staging: fbtft: add tearing signal detect
Message-ID: <20210127144946.GF2696@kadam>
References: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
 <YBFv+12xfsoxacDb@kroah.com>
 <20210127220809.000026fb@gmail.com>
 <YBF08Xf7qaZx3YZ1@kroah.com>
 <20210127221708.00002568@gmail.com>
 <YBF30EEUkhEMY5ti@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBF30EEUkhEMY5ti@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270082
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 03:25:20PM +0100, Greg KH wrote:
> On Wed, Jan 27, 2021 at 10:17:08PM +0800, carlis wrote:
> > On Wed, 27 Jan 2021 15:13:05 +0100
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Wed, Jan 27, 2021 at 10:08:09PM +0800, carlis wrote:
> > > > On Wed, 27 Jan 2021 14:51:55 +0100
> > > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >   
> > > > > On Wed, Jan 27, 2021 at 09:42:52PM +0800, Carlis wrote:  
> > > > > > From: zhangxuezhi <zhangxuezhi1@yulong.com>
> > > > > > 
> > > > > > For st7789v ic,when we need continuous full screen refresh, it
> > > > > > is best to wait for the TE signal arrive to avoid screen tearing
> > > > > > 
> > > > > > Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>    
> > > > > 
> > > > > Please slow down and wait at least a day between patch
> > > > > submissions, there is no rush here.
> > > > > 
> > > > > And also, ALWAYS run scripts/checkpatch.pl on your submissions, so
> > > > > that you don't have a maintainer asking you about basic problems,
> > > > > like are in this current patch :(
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h  
> > > > 
> > > > hi,
> > > >   This is my first patch contribution to Linux, so some of the rules
> > > > are not very clear .In addition, I can confirm that before sending
> > > > patch, I check it with checkPatch.py every time.Thank you very much
> > > > for your help  
> > > 
> > > Please read Documentation/SubmittingPatches which has a link to the
> > > checklist and other documentation you should read.
> > > 
> > > And I doubt you are running checkpatch on your submission, as there is
> > > obvious coding style issues in it.  If so, please provide the output
> > > as it must be broken :(
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > hi, the patch v11 checkpatch.pl output is below:
> > 
> > carlis@bf-rmsz-10:~/work/linux-kernel/linux$ ./scripts/checkpatch.pl
> > 0001-staging-fbtft-add-tearing-signal-detect.patch total: 0 errors, 0
> > warnings, 0 checks, 176 lines checked
> > 
> > 0001-staging-fbtft-add-tearing-signal-detect.patch has no obvious style
> > problems and is ready for submission.
> 
> Wow, my apologies!
> 
> Andy and Joe, there's something wrong here that is missing the fact that
> a line is being indented with spaces and not tabs in the patch
> at https://lore.kernel.org/r/1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com
> 
> Any ideas what broke?
> 

    /*Tearing Effect Line On*/

Comments are the exception to the "no spaces at the start of a line"
rule.  I was expecting that the kbuild-bot would send a Smatch warning
for inconsistent indenting, but comments are not counted there either.

I'm sort of surprised that we don't have checkpatch rule about the
missing space characters.  It should be: "/* Tearing Effect Line On */".

regards,
dan carpenter

