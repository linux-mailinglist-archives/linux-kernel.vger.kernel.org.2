Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC07314073
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhBHU1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:27:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42212 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbhBHTD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:03:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118Ig3VL139458;
        Mon, 8 Feb 2021 19:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Wf1goJTBSSWI4TQ+CnoSP72sPATBhea/Oy07byYA2aQ=;
 b=YiQ7qbtaQJpNs7E8LDkAGAGWx3f8c0gDQWzg5UuJpL3eX89ErwSg/ruvjtTsX9HtGoTS
 /gm4pdPPC3on+FKKrn5Ku/qjfRpKDcyV5N+8mzpBF3UZ37owN+e8PvDa74ftVH+PKwDN
 LPRSTaIQI6MruzrXQPwx1pIURr3ev9vGmQBrDF7QM+Xgl9zo3agZ3dZOdgbMSMjdbEi7
 yWvCwBN3/jMOZzLubY7N/KmrQybO+Nyqzp/m/IY/seLCkkHy9IsYfkBNJQZsGOevMUCo
 Rt1i0IOsSlmOItkydxdVVcggcUUBdqWLl6VQDXBkDPuiCuHX82iYrOMdWqozzigHPfwv 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36hkrmvypp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 19:02:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 118IfOsS124606;
        Mon, 8 Feb 2021 19:02:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 36j5107qst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Feb 2021 19:02:56 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 118J2q92015415;
        Mon, 8 Feb 2021 19:02:52 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Feb 2021 11:02:52 -0800
Date:   Mon, 8 Feb 2021 22:02:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     Youling Tang <tangyouling@loongson.cn>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: fix ignoring return value warning
Message-ID: <20210208190237.GN20820@kadam>
References: <1612689808-30985-1-git-send-email-tangyouling@loongson.cn>
 <20210208134517.GG2696@kadam>
 <20210208150618.GI8233@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208150618.GI8233@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 04:06:18PM +0100, Sascha Hauer wrote:
> Hi Dan,
> 
> On Mon, Feb 08, 2021 at 04:45:17PM +0300, Dan Carpenter wrote:
> > On Sun, Feb 07, 2021 at 05:23:28PM +0800, Youling Tang wrote:
> > > Fix the below ignoring return value warning for device_reset.
> > > 
> > > drivers/staging/mt7621-dma/mtk-hsdma.c:685:2: warning: ignoring return value
> > > of function declared with 'warn_unused_result' attribute [-Wunused-result]
> > >         device_reset(&pdev->dev);
> > >         ^~~~~~~~~~~~ ~~~~~~~~~~
> > > drivers/staging/ralink-gdma/ralink-gdma.c:836:2: warning: ignoring return value
> > > of function declared with 'warn_unused_result' attribute [-Wunused-result]
> > >         device_reset(&pdev->dev);
> > >         ^~~~~~~~~~~~ ~~~~~~~~~~
> > > 
> > 
> > We can't really do this sort of fix without the hardware to test it.
> > This could be the correct fix or perhaps switching to device_reset_optional()
> > is the correct fix.  We can't know unless we have the hardware to test.
> 
> When device_reset() is the wrong function then adding a return value
> check will turn this into a runtime error for those who have the
> hardware which will hopefully trigger them to tell us why reset_device
> is wrong for them.
> At least for a staging driver I find this procedure opportune.
> 

That seems like sort of a jerk move...  What's the rush?  Someone will
eventually be able to test this if we just wait around for a bit.
Otherwise if no one has the hardware then eventually the driver will be
deleted.

regards,
dan carpenter

