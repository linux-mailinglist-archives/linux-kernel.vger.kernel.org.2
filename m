Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80363316623
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhBJMKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:10:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53762 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhBJMHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:07:50 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AC0D0B159847;
        Wed, 10 Feb 2021 12:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=OEyAmudG0vxIoe+Bc5o3Lx7baiaUbNRyOQQO16YoctM=;
 b=DygSz6EPeUusXm93Ua2iU2uG4ZJw58bsWR8e2Gyxnt1cMQAjBjISf8HUOG/jZVaDLBCV
 dwzZlb7PkyOSh3cXbsshZ/2W45iVdVLKU4WYBH7Pvf4Ma5R5s0MDpUakkcU+hDefzt9c
 x+HXmktThJHC4hi57yK6Ok4QJPU+fpRtcDsF1s/y1AEmS1Db9NMdeiHiOEJp7r3fF4GA
 iJ8U6u9qXmJy2WeBaaI77jBWNdA6I2FctxxO+QGG8xeHVMcSTWnE6SB7yCAHmn96RQ2Y
 nb+MXTqTlox/zWWokFIBD4u0IoIYdr6ewhu/bYKJIK+vF7RZLIvhN6Jz4VrfiwjAKg4c JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36hgmak8b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 12:06:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AC61PZ038725;
        Wed, 10 Feb 2021 12:06:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 36j4pq2ehj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 12:06:51 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11AC6jTw031970;
        Wed, 10 Feb 2021 12:06:46 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 04:06:45 -0800
Date:   Wed, 10 Feb 2021 15:06:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     karthek <mail@karthek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix function comments to follow
 kernel-doc
Message-ID: <20210210120634.GV20820@kadam>
References: <YCL6vrGPQ0uDZUI8@karthik-strix-linux.karthek.com>
 <20210210080636.GT2696@kadam>
 <CAJ5zXr1hJ6ts7Gqi_vfaJceZ8qKPgFk479h4sA9AxFrAdB8vHw@mail.gmail.com>
 <20210210090120.GU20820@kadam>
 <CAJ5zXr1OW+RfNNuXOZDjUvm=EKz5C9=GPc243z3Wk_qc3N=6sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ5zXr1OW+RfNNuXOZDjUvm=EKz5C9=GPc243z3Wk_qc3N=6sQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100119
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 02:38:28PM +0530, karthek wrote:
> On Wed, Feb 10, 2021, 2:31 PM Dan Carpenter <dan.carpenter@oracle.com>
> wrote:
> 
> > On Wed, Feb 10, 2021 at 02:28:31PM +0530, karthek wrote:
> > > On Wed, Feb 10, 2021 at 1:37 PM Dan Carpenter <dan.carpenter@oracle.com>
> > wrote:
> > > > > @@ -789,7 +759,7 @@ static void phy_PostSetBwMode8723B(struct
> > adapter *Adapter)
> > > > >
> > > > >               PHY_SetBBReg(Adapter, rFPGA1_RFMOD, bRFMOD, 0x0);
> > > > >
> > > > > -/*                   PHY_SetBBReg(Adapter, rFPGA0_AnalogParameter2,
> > BIT10, 1); */
> > > > > +     /*PHY_SetBBReg(Adapter, rFPGA0_AnalogParameter2, BIT10, 1); */
> > > >
> > > > This format is wrong.  Anyway, just delete the commented out code.
> > > >
> > > > regards,
> > > > dan carpenter
> > > >
> > >
> > > how can i delete that, i have no idea what this driver does
> > > i'm just fixing coding style issues for eudyptula challenge.
> > > i dont think its a good idea to delete the code without knowing its
> > > purpose even though its commented out
> >
> > Commented code obviously doesn't do anything at all?
> >
> > regards,
> > dan carpenter
> >
> 
> > Ofcourse it does nothing
> 
> But why does it exist in the first place,
> 
> Why maintainer decided to comment it out without just deleting it?
> Maybe there is some reason which i don't know
> So i decided not to touch it

This is staging code because the original developers didn't do a great
job.

> 
> Anyway I'm new to this so just say what should i do now?

Just delete it.

regards,
dan carpenter

