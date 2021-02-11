Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E867F3185D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 08:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhBKHnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 02:43:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36866 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhBKHnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 02:43:42 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B7dq32049553;
        Thu, 11 Feb 2021 07:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0EzUuzVkW0/rXj9wIPYoM+D4X4LcJcZYdNeT+Du8Nh4=;
 b=sOZXSzFAorg/KTCrgwbMqrN+FOUZs2/syZ0I4gwr9MJA+AkGfcU7qqOW0X1euHS1NO3f
 977ZhyGJ1qgshpGccLFwnbSy20kV9Pp8n9vQNJ0sfE4B3sWoqAxRAI3sx/NyUqWr1BFI
 B60Pw73K+Z47Kcb5vU9xuvIPdbVZNAGlPAzzJK0q3wCVyeyxeKdgDipTZZVdkbG5lDgK
 665VGkMIJIoVTM6xDqtv+nzS5q6qRWx9Y6pOrqMPSqbAksirFdea39jMdw6HmY7MvNcC
 OcL+SxC/qv9D9TEL78HDLQs7OSRVrGpT4c0VtfMOR7PJ7m6h8MticcBMQQMtOtLx/bI8 fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36hkrn6b0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 07:42:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B7f6EZ027805;
        Thu, 11 Feb 2021 07:42:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 36j51ymyq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 07:42:49 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11B7gj3e000398;
        Thu, 11 Feb 2021 07:42:45 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 23:42:45 -0800
Date:   Thu, 11 Feb 2021 10:42:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     karthek <mail@karthek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove obsolete commented out code
Message-ID: <20210211074238.GM20820@kadam>
References: <YCQvsdlnbnQN4Ruf@karthik-strix-linux.karthek.com>
 <YCQxwl6yfHGeDrAn@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQxwl6yfHGeDrAn@karthik-strix-linux.karthek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110069
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:49:30AM +0530, karthek wrote:
> Hey dan,
> check this out too

I have no idea what you're talking about.

Anyway, I just read my inbox in chronological order.  That means I tend
to send my replies before reading Greg's comments and before seeing the
v2 patches.  Just be patient and I will get to it.

regards,
dan carpenter
