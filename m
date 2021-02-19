Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EC731FDBD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 18:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBSRQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 12:16:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44360 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhBSRPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:15:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JH928T060455;
        Fri, 19 Feb 2021 17:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=mmc+9jh3DlnpvQDmKTq0Eb72B6qDkY4YnrhNxDoCtmM=;
 b=lKLeh9R1dirOQZ9cd4AqXSlAVJOX2cVONP9bE9Xg3+2sgCZnv6W5L/2G0YFk99JYze56
 oJqvkYv/9cfQEWewtklSDqG+ITbRQi6X6BU/vwFWppMKO7y3mCn6vjdjGKM9WnSX3Aoy
 cRIsZarq7qJapTyg0nJctf3jPUl1t3PVj4CKc5oFB4udb3biKzRipkzOynSB3QfPoFi0
 LwmvMbBbV4qua6odVW5TmmuqHFK0Jyrua44rj3fE+Bs0dI+g3Sa5PNCInAvvVLSuek+o
 1f1ar1TsoUf8tQvnLFDwWUEVJu3Rjj+LjdF+s6Tyhq8G6EQe7kFPRrux5eduARI0f7xH Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36p66ra8am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 17:14:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JHEXMr069451;
        Fri, 19 Feb 2021 17:14:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 36prbsbq4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 17:14:48 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11JHEis3005778;
        Fri, 19 Feb 2021 17:14:45 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Feb 2021 09:14:43 -0800
Date:   Fri, 19 Feb 2021 20:14:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kurt Manucredo <fuzzybritches@protonmail.com>
Cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        straube.linux@gmail.com, d.straghkov@ispras.ru, tiwai@suse.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix code style comparison warning
Message-ID: <20210219171432.GA2087@kadam>
References: <20210219144928.8-1-fuzzybritches@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219144928.8-1-fuzzybritches@protonmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190134
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 02:50:53PM +0000, Kurt Manucredo wrote:
> 
> 
> changes since previous version:
> - change Subject line
> - change commit message
> - change commit message position to above signed-off-by
> 

These comments need to go below the --- cut off line.

> checkpatch gives the following WARNING:
> WARNING: Comparisons should place the constant on the right side of the test
> this patch fixes the coding style warning.
> 
> Signed-off-by: Kurt Manucredo <fuzzybritches@protonmail.com>
> ---
  ^^^

This one here.

>  drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

regards,
dan carpenter

