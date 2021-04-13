Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF3235E1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbhDMOx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:53:26 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43868 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhDMOxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:53:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DEnYa3036778;
        Tue, 13 Apr 2021 14:52:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=XlmNGq/1+E4+j5kYmK7x5/m8LnmtU0Ndl1MhNnKYffw=;
 b=BAlV+9aQn2uvlp+oY1x6eG6BdK8q5jawmxxEhaRqVG0LLkcOpVQPdMnhvG89CuxK4Pjj
 X6b7oatlzJiMcak5gExyMzQH+w5GVB2cVYMr3XFPpRXMZegJRIfybGn+0eL8WMIxWLqz
 YfSt9NLfEd+AVQSWrQ4erA7sugClm7ZvG9oUdFfj7tNnITWH6TMVtcqSeY/Zg5ZZp7z1
 YCvT+YmCN6V+/zAitttIbP7CUsvxsNeQFsXFIRb0NNmM1KXYCiXpGS2sWFvE2Izw7HW7
 yrRz7PtZL90yK5+cj5bl22yBektnLW8e7t4MFmOKsIjT1Al0YGjlIrwynQrjGhB/f7x3 Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37u1hbffj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 14:52:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DEjeu8161362;
        Tue, 13 Apr 2021 14:52:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 37unwyvv2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 14:52:52 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13DEqpq6014908;
        Tue, 13 Apr 2021 14:52:51 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Apr 2021 07:52:51 -0700
Date:   Tue, 13 Apr 2021 17:52:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/19] staging: rtl8723bs: remove unnecessary bracks on
 DBG_871X removal sites
Message-ID: <20210413145245.GG6021@kadam>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
 <35f5edf0f39b717b3de3ad7861cbaa5f4ba60576.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35f5edf0f39b717b3de3ad7861cbaa5f4ba60576.1617802415.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130106
X-Proofpoint-GUID: 5WBQ4qNszvuj1d5rr6ONVqtYsYaBpGu4
X-Proofpoint-ORIG-GUID: 5WBQ4qNszvuj1d5rr6ONVqtYsYaBpGu4
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 03:49:36PM +0200, Fabio Aiuto wrote:
> @@ -2586,11 +2583,9 @@ static int rtw_dbg_port(struct net_device *dev,
>  
>  								plist = get_next(plist);
>  
> -								if (extra_arg == psta->aid) {
> -									for (j = 0; j < 16; j++) {
> +								if (extra_arg == psta->aid)
> +									for (j = 0; j < 16; j++)
>  										preorder_ctrl = &psta->recvreorder_ctrl[j];
> -									}
> -								}

I think Greg already applied this so no stress (don't bother fixing),
but you removed a bit too much on this one.  Multi-line indents normally
get curly braces for readability.  In other words:

				if (extra_arg == psta->aid) {
					for (j = 0; j < 16; j++)
						preorder_ctrl = &psta->recvreorder_ctrl[j];
				}

regards,
dan carpenter

