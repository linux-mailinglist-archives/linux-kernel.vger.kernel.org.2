Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259683210C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 07:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhBVGRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 01:17:18 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49008 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhBVGRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 01:17:14 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11M68uO5049303;
        Mon, 22 Feb 2021 06:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vSX/DZCL9K0FwrrmnQEn8Cygh8IZE8Dww0cgcojZH8M=;
 b=GCde95boaXzrVgM0kR7wp2CLdpzDJg98Q5w1MNmsUFUzOV7br5jmSwn8oGa6XDPljm4F
 8Qpa3hpwJ0c7Rc68Lz+j68i/qe8lf6G79LVBVfnLYZ5BRuzqy8IVmWa0XCpTj7slsjru
 nNdarUClyQhfrHFlhF7ZcitKHVtqrBCDXILQJ9XSop+n3nI/+s56WGR+9redFHZiV1gR
 R2mFCzkEIlvGIJAd+Jt4M4d107NRyf+18Evw+VaCjyQRIke11SgKhwNbaggys7rxznf8
 q/3ayx/FtF1/sQQD+J058BHNCbamerbmdGVx77inO7pBsZ4Vo2HaOvdkui5gOUHGO0xu KQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36tqxbajsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 06:16:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11M6ATO8005822;
        Mon, 22 Feb 2021 06:16:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 36ucawmc8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 06:16:15 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11M6G82C013789;
        Mon, 22 Feb 2021 06:16:09 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 21 Feb 2021 22:16:07 -0800
Date:   Mon, 22 Feb 2021 09:15:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amrit Khera <amritkhera98@gmail.com>
Cc:     gregkh@linuxfoundation.org, lee.jones@linaro.org, arnd@arndb.de,
        johannes@sipsolutions.net, kuba@kernel.org, mail@anirudhrb.com,
        memxor@gmail.com, rdunlap@infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wimax: Fix block comment style issue in
 stack.c
Message-ID: <20210222061559.GK2087@kadam>
References: <20210221163758.2996-1-amritkhera98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210221163758.2996-1-amritkhera98@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220056
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 10:07:59PM +0530, Amrit Khera wrote:
> diff --git a/drivers/staging/wimax/stack.c b/drivers/staging/wimax/stack.c
> index ace24a6dfd2d..345a022810ef 100644
> --- a/drivers/staging/wimax/stack.c
> +++ b/drivers/staging/wimax/stack.c
> @@ -57,17 +57,7 @@ MODULE_PARM_DESC(debug,
>  
>  /*
>   * Authoritative source for the RE_STATE_CHANGE attribute policy

Delete the whole comment.  This sentence doesn't make any sense by
itself once we have removed the rest.

> - *
> - * We don't really use it here, but /me likes to keep the definition
> - * close to where the data is generated.
>   */
> -/*
> -static const struct nla_policy wimax_gnl_re_status_change[WIMAX_GNL_ATTR_MAX + 1] = {
> -	[WIMAX_GNL_STCH_STATE_OLD] = { .type = NLA_U8 },
> -	[WIMAX_GNL_STCH_STATE_NEW] = { .type = NLA_U8 },
> -};

regards,
dan carpenter

