Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE652341821
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCSJVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:21:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51790 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCSJVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:21:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J9AeQ0159723;
        Fri, 19 Mar 2021 09:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7j8/pyNMvrFpPBqdM1y7eY9cuEFOBdhNsBd7YTd+K2g=;
 b=AMqAIDCU9Swtry+7qk76THCjkLEgmDUwl4509Qp4D+EnjRHf+15lPjvhv98A8nOqhzKZ
 L4lmuVGxdefF5ltPzRJoqb2pqy3oRtSQh2mkybDKLGBdBDOP78uf3M493D9aAjR3AW0P
 G3N3uFS3prRxJL7SRU8KtESdq5dz3kF43c498Sm9QzPZNkgxbohsJLAvsjHmHNdUG4fn
 mTCpe9aTcVIhGRo/Zj7Cy4qeYC9af1RXKcFA0mVb2fk4dvmfRoyEco9LxcsxS/VnRaO7
 ixhW/48D+uqj5SIKmsyA22YZidnDPOvEHdK9HaaISfkyWfKU6W8sg/uw8l1vRaUjECZy ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37a4ekyaxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 09:21:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12J9ADi2135473;
        Fri, 19 Mar 2021 09:21:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3797b41aav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 09:21:31 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12J9LUNg007964;
        Fri, 19 Mar 2021 09:21:31 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Mar 2021 02:21:30 -0700
Date:   Fri, 19 Mar 2021 12:21:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] staging: rtl8723bs: remove unnecessary logging in
 os_dep/ioctl_cfg80211.c
Message-ID: <20210319092122.GF2087@kadam>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
 <20210318152610.16758-13-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318152610.16758-13-fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190066
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 04:26:07PM +0100, Fabio Aiuto wrote:
> @@ -1405,7 +1398,6 @@ void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter)
>  	struct	wlan_network	*pnetwork = NULL;
>  
>  #ifdef DEBUG_CFG80211
> -	DBG_8192C("%s\n", __func__);
>  #endif

The #ifdef can go as well.

>  
>  	spin_lock_bh(&(pmlmepriv->scanned_queue.lock));

regads,
dan carpenter
