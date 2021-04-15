Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC25360208
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhDOFyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:54:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59760 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhDOFyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:54:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13F5nTTs090676;
        Thu, 15 Apr 2021 05:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=m+RmyZkUcYyQTut8sn7lsS+x9pyqvIN7BnQZHbt2PXE=;
 b=IzBpvef0lIV/PdKLXHED0llLKFaIz0M2QOUupEREqT/zNTdf3TBRcEHIL3SynsHEsRES
 D+pLlrYce7GuYe+z0O+tKLjzOkhMBXdaRs12Kd+1czC3kkteuJUgQsFeGpSGrB7AwTMU
 hHPfen8CCm9F9Xc885S87YAQaoz1RlqlLzBRuWviEQOkT5QPYUhnpvtPk9RH/q0+rRE4
 6v0iFmW2h4Fgzy8CHCL6Cc6hC1EL08dcfBhrbePOVzStet+VrnuFgmOSJZsud0Cs3KHA
 IPnHn9d5G/YGWXBc/kyCNwfGs2gCNyXH7K+phNmNlbKYon8I3IThIVjuBYHgn42udMBj dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37u1hbmpxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 05:53:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13F5paKa071140;
        Thu, 15 Apr 2021 05:53:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 37unsv26uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 05:53:37 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13F5rWIm006977;
        Thu, 15 Apr 2021 05:53:32 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 22:53:31 -0700
Date:   Thu, 15 Apr 2021 08:53:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 37/57] staging: rtl8188eu: os_dep: ioctl_linux: Move 2
 large data buffers into the heap
Message-ID: <20210415055325.GB6021@kadam>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150041
X-Proofpoint-GUID: 4XgdQG5-IRouO1FFQEjCpnMpLc_c4Asq
X-Proofpoint-ORIG-GUID: 4XgdQG5-IRouO1FFQEjCpnMpLc_c4Asq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9954 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I screwed up my last email and dropped Lee and Arnd from the To: headers.
Resending.

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

Arnd added this return.  I think it should be -ENOMEM, though?

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

