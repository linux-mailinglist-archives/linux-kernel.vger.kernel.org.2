Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8D33B9D98
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhGBIiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:38:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46508 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230166AbhGBIiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:38:09 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1628H8O9011796;
        Fri, 2 Jul 2021 08:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=CgpHUvQWodsBQnISSb9kfIuwFVsNAghRjCPtbrBaYAg=;
 b=lsPDArnwObvu4saMlp5mO5c4MtLvbFJM1pwgc5TyMtgS7UUkmbDR/Vn1e3khj29fjsQy
 UM1+uVPUH3u+kZJbbeFk3iBL2C+43vP0cXfDC3SgiEaX2eAG4MdgOSJtzwJCnCguwHpX
 +OQ2lph8zmrygjyh8XxP3vX+NHZhlhH5iqSe+essirKSuyUwl5HUqbOjWjRNZxDNTCQQ
 4E3Lw45o5wmdVytF8gv4qqUkduoUt9r/qNurqbPfa0Qu3AtjZGO7Ye1gFJRaejxNIAh6
 aMGZn5uEfPILk19J7+OY2swhBhYcXOX4pfpe62/Juq/xQu5wr86EvlIe+4jkcbMgutOe YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gy5w3723-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 08:35:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1628Fs0i102066;
        Fri, 2 Jul 2021 08:35:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 39dsc5xm13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 08:35:32 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1628ZV2S152501;
        Fri, 2 Jul 2021 08:35:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 39dsc5xkyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 08:35:30 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1628ZTwu025022;
        Fri, 2 Jul 2021 08:35:29 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Jul 2021 01:35:28 -0700
Date:   Fri, 2 Jul 2021 11:35:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Remove an unused variable and some
 lines of code
Message-ID: <20210702083521.GV2040@kadam>
References: <20210701144707.22820-1-fmdefrancesco@gmail.com>
 <20210702074840.GT2040@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702074840.GT2040@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: G1k7SjhoYIMwPKDt3j0CyoVnoBo0j-c3
X-Proofpoint-ORIG-GUID: G1k7SjhoYIMwPKDt3j0CyoVnoBo0j-c3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 10:48:40AM +0300, Dan Carpenter wrote:
> On Thu, Jul 01, 2021 at 04:47:07PM +0200, Fabio M. De Francesco wrote:
> > Remove set but unused iw_operation_mode[]. Remove all the lines of 
> > code from the function rtw_wx_set_rate, except the "return 0;" line 
> > to not break userland code that somewhat uses this IOCTL.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 72 -------------------
> >  1 file changed, 72 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> > index b958a8d882b0..a66d8838c034 100644
> > --- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> > @@ -46,11 +46,6 @@ static u32 rtw_rates[] = {1000000, 2000000, 5500000, 11000000,
> >  	6000000, 9000000, 12000000, 18000000, 24000000, 36000000,
> >  	48000000, 54000000};
> >  
> > -static const char * const iw_operation_mode[] = {
> > -	"Auto", "Ad-Hoc", "Managed",  "Master", "Repeater",
> > -	"Secondary", "Monitor"
> > -};
> > -
> >  void indicate_wx_scan_complete_event(struct adapter *padapter)
> >  {
> >  	union iwreq_data wrqu;
> > @@ -1266,73 +1261,6 @@ static int rtw_wx_set_rate(struct net_device *dev,
> >  			   struct iw_request_info *a,
> >  			   union iwreq_data *wrqu, char *extra)
> >  {
> 
> Just delete this whole file.  It doesn't do anything now.

Sorry, I meant function, not file.  *chortle*.  :P

regards,
dan carpenter

