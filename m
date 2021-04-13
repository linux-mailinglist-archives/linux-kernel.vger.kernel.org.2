Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C802435E218
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346453AbhDMO6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:58:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54164 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbhDMO5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:57:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DEnqpS083632;
        Tue, 13 Apr 2021 14:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=JhYvFNCfR6OJZkqyPEmIIrheY8Abto4HIXOl1+WX9Yk=;
 b=nzuYWBCQULQgWpSYibSU9p+FkqZZB0da5CoRLgY/ySzFZZB9d0h+7ijCyahHVBGKS5tS
 HPSHYn/2FLPGIqfOfruWpNReP65tmCUJqI3JEs4PE13S6f8kIRiUcR7Og/kgCyROYoL2
 kdbEdZtraQENUBqsQ/gunWtyv18ET3h6H68aHg9IPYGVTB7pFt0pAoWuBEiFg5kQpxB0
 mA0H/YXxc8OSfdbL3WrJjwTDphfPlvsoRndNgAcIu1AmMuoe4EBdTp69bLLQ7XRDLzw0
 dd0bysKPiRIHoojq+ZCS4LItKlFyMPGqnvhVEH+gXuhSs7yIWVfOC/8yYn/u9nowBi40 jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37u3erfd0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 14:57:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DEkU5B172594;
        Tue, 13 Apr 2021 14:57:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 37unkpmn00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 14:57:20 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13DEvJJM031967;
        Tue, 13 Apr 2021 14:57:19 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Apr 2021 07:57:18 -0700
Date:   Tue, 13 Apr 2021 17:57:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] staging: rtl8723bs: split long lines
Message-ID: <20210413145712.GH6021@kadam>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
 <814139162ef516bb07bb50876578b032573271ac.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <814139162ef516bb07bb50876578b032573271ac.1617802415.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130106
X-Proofpoint-ORIG-GUID: JeMP_k2CRd6nUYCcSEAl50kNil_TxiON
X-Proofpoint-GUID: JeMP_k2CRd6nUYCcSEAl50kNil_TxiON
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 03:49:42PM +0200, Fabio Aiuto wrote:
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 7f998a2f8001..a1e27ba4707e 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -619,8 +619,9 @@ unsigned int OnProbeReq(struct adapter *padapter, union recv_frame *precv_frame)
>  			return _SUCCESS;
>  
>  _issue_probersp:
> -		if ((check_fwstate(pmlmepriv, _FW_LINKED)  &&
> -			pmlmepriv->cur_network.join_res) || check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
> +		if ((check_fwstate(pmlmepriv, _FW_LINKED) &&
> +		     pmlmepriv->cur_network.join_res) ||
> +		     check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))

The last line is indented one space character too much.  It should be:

		if ((check_fwstate(pmlmepriv, _FW_LINKED) &&
		     pmlmepriv->cur_network.join_res) ||
		    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))

regards,
dan carpenter

