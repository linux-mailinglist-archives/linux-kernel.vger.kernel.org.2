Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30A360191
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhDOF0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:26:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35494 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhDOF0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:26:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13F5K4wW114359;
        Thu, 15 Apr 2021 05:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=u1HGY2pdiUJpZnVn7iUNNrPvZ0VUQmj8sncbkjdtkWI=;
 b=JuHbIj78j45980ej6OquW305F61Ve91x3TL1DIfMgFv0mG6VPsffq8M7HaIQ/0eRwrAM
 aG1ZgNXuiio8pc6GGwmPKsOuCI4BW54Urro0yavfXCp8Y1oFmKY9eDpaTtaRs0gw45Fj
 yhEP/OE4CzzIvNlTTxub7gcq2IdkwuirZxhQOTfcqyzsn+ipjrWpyHUt9AIjug9wP0tl
 B7JB7+Wnn/ishOv1IJS5Ui49yz4024/LhH6GRAPWHspyW9U7DDA89rAi6PPOTMixBeli
 oUY6db/Fjpz9zVljUDg7WcmbiLpr8RHoSH/evy8lW16eRMSa3Lqq3IczpY6Uk/yxr8XD yg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37u3ermjfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 05:26:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13F5OZxu189813;
        Thu, 15 Apr 2021 05:26:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 37unks2ajd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 05:26:04 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13F5Q4Ut017954;
        Thu, 15 Apr 2021 05:26:04 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Apr 2021 05:26:03 +0000
Date:   Thu, 15 Apr 2021 08:25:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 37/57] staging: rtl8188eu: os_dep: ioctl_linux: Move 2
 large data buffers into the heap
Message-ID: <20210415052556.GZ6021@kadam>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
 <20210414181129.1628598-38-lee.jones@linaro.org>
 <20210415051835.GY6021@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415051835.GY6021@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150038
X-Proofpoint-ORIG-GUID: rDoebdlzTrhoDEkwAfrnVev4-GCD-9bq
X-Proofpoint-GUID: rDoebdlzTrhoDEkwAfrnVev4-GCD-9bq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150037
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 08:20:16AM +0300, Dan Carpenter wrote:
> On Wed, Apr 14, 2021 at 07:11:09PM +0100, Lee Jones wrote:
> > ---
> >  drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> > index c95ae4d6a3b6b..cc14f00947781 100644
> > --- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
> > @@ -224,7 +224,7 @@ static char *translate_scan(struct adapter *padapter,
> >  	/* parsing WPA/WPA2 IE */
> >  	{
> >  		u8 *buf;
> > -		u8 wpa_ie[255], rsn_ie[255];
> > +		u8 *wpa_ie, *rsn_ie;
> >  		u16 wpa_len = 0, rsn_len = 0;
> >  		u8 *p;
> >  
> > @@ -232,6 +232,14 @@ static char *translate_scan(struct adapter *padapter,
> >  		if (!buf)
> >  			return start;

Arnd, added this return...  I don't understand why we aren't returning
-ENOMEM here.

> >  
> > +		wpa_ie = kzalloc(255, GFP_ATOMIC);
> > +		if (!wpa_ie)
> > +			return start;
> 
> kfree(buf);
> 
> > +
> > +		rsn_ie = kzalloc(255, GFP_ATOMIC);
> > +		if (!rsn_ie)
> > +			return start;
> 

regards,
dan carpenter

