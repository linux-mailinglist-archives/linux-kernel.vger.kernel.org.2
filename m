Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39FC359FA2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhDINOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:14:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40374 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDINOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:14:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139DEJX7021238;
        Fri, 9 Apr 2021 13:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=DuTEK6YF3Pku6GuZSj4bkggFPegvnaI7KM/CBoeLHaE=;
 b=S4EAvbBKvCnC2A4WanffzwW9+6N+8JnV2QMs1N59MXciHLR+TyJIG8dd6WUFRv8dB/G5
 zBpYxT5vCRNCbFPcVwJtHn4opKTp95GIyXhepUb9XITiQ4q6ms0/yelRB8m/j3D2lbYX
 c5U9NnLv+5y5m2i2tA0KPiiSlIHlC0CB9+5W5X08NFWyztCmH5xd1QQ4Q1LevwGtV0fZ
 U/RmfpdNWvmbduUXgX2N4qL1wiGZGTz4XS9BLUcXIbw1khnOlmGdDTiIN+pANDhN6EAA
 CqG9hVujYE5DL6MOcrE4deyvMdax2zAZjMw7Y2xwOfn60UE+D5VqsrEys7ZfvIvDxNXP lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37rvaghcek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 13:14:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139DBQLQ124685;
        Fri, 9 Apr 2021 13:14:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 37rvb6kn8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 13:14:16 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 139DECQN009487;
        Fri, 9 Apr 2021 13:14:12 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Apr 2021 06:14:12 -0700
Date:   Fri, 9 Apr 2021 16:14:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dev.dragon@bk.ru
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8192u: ieee80211: fixed a trailing
 statements coding style issue.
Message-ID: <20210409131403.GB6021@kadam>
References: <20210404051500.6644-1-dev.dragon@bk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210404051500.6644-1-dev.dragon@bk.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090097
X-Proofpoint-GUID: e6ugudPsgPfBQ_ZEtl7cSM2sm_ItqoEo
X-Proofpoint-ORIG-GUID: e6ugudPsgPfBQ_ZEtl7cSM2sm_ItqoEo
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1011 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 08:15:00AM +0300, dev.dragon@bk.ru wrote:
> From: Dmitrii Wolf <dev.dragon@bk.ru>
> 
> Signed-off-by: Dmitrii Wolf <dev.dragon@bk.ru>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> index 690b664df8fa..29a6ce20e2bd 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> @@ -2048,12 +2048,12 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
>  	/* if xmit available, just xmit it immediately, else just insert it to the wait queue */
>  	for (i = 0; i < txb->nr_frags; i++) {
>  #ifdef USB_TX_DRIVER_AGGREGATION_ENABLE
> -		if ((skb_queue_len(&ieee->skb_drv_aggQ[queue_index]) != 0) ||
> +		if ((skb_queue_len(&ieee->skb_drv_aggQ[queue_index]) != 0)
>  #else
> -		if ((skb_queue_len(&ieee->skb_waitQ[queue_index]) != 0) ||
> +		if ((skb_queue_len(&ieee->skb_waitQ[queue_index]) != 0)
>  #endif
> -		    (!ieee->check_nic_enough_desc(ieee->dev, queue_index)) || \
> -		    (ieee->queue_stop)) {
> +		 || (!ieee->check_nic_enough_desc(ieee->dev, queue_index)) \
> +		 || (ieee->queue_stop)) {

No.  The || go on the end, the way the original code had it.  I've no
idea what you were trying to fix.  Maybe the \ characters?

regards,
dan carpenter

