Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F68B318600
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 09:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhBKH7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 02:59:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54590 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBKH5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 02:57:38 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B7uORR012915;
        Thu, 11 Feb 2021 07:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=kiJNzaZF4pw+YTlqD1Smavke2NjfLZS+kTOUdQog8Zg=;
 b=UuqFp5ppXhwG5ouO/SsCBkIeSrx0Vqy1J4J2jB6vVe8B5D+o9WkuPdzTVwJCNSE6hTTD
 t8r3jqs1XneKepuCxgqwAoC8DSmbRX9sEvf5Cn1hxTlPsFlCg+0o94lj5ddn5SWBCY4H
 3+D2Nf0cgDKrJYsHhI0lTlIvf/0DGUxPYIuSCxaN+RqqqxjBljehD3SRn+qV7OVAlrVF
 a15MwDAV4lO2OtYjGubWGnlHQi/bsHux64RyqWHKUJdQpvzniQRC3n/8qLbL2D+b7S/Q
 zNyVoSUVEAlJhPVvfNZa8BtclPfUQN8gc45WmIGgnr6Iqq150WkI9EGsMAAwChLEgdsN sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36m4upvynm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 07:57:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B7tVE3142935;
        Thu, 11 Feb 2021 07:57:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 36j513qeu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 07:57:24 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11B7vNID007258;
        Thu, 11 Feb 2021 07:57:23 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 23:57:23 -0800
Date:   Thu, 11 Feb 2021 10:57:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     karthik alapati <mail@karthek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove obsolete commented out code
Message-ID: <20210211075715.GD2696@kadam>
References: <YCQvsdlnbnQN4Ruf@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCQvsdlnbnQN4Ruf@karthik-strix-linux.karthek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110071
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 12:40:41AM +0530, karthik alapati wrote:
> @@ -867,10 +845,8 @@ static void PHY_HandleSwChnlAndSetBW8723B(
>  	if (bSetBandWidth)
>  		pHalData->bSetChnlBW = true;
>  
> -	if (!pHalData->bSetChnlBW && !pHalData->bSwChnl) {
> -		/* DBG_871X("<= PHY_HandleSwChnlAndSetBW8812: bSwChnl %d, bSetChnlBW %d\n", pHalData->bSwChnl, pHalData->bSetChnlBW); */
> +	if (!pHalData->bSetChnlBW && !pHalData->bSwChnl)
>  		return;
> -	}

In this case, the + line is correct.  Good job.

>  
>  
>  	if (pHalData->bSwChnl) {
> @@ -929,9 +905,7 @@ void PHY_SetSwChnlBWMode8723B(
>  	u8 Offset80
>  )
>  {
> -	/* DBG_871X("%s() ===>\n", __func__); */
>  
>  	PHY_HandleSwChnlAndSetBW8723B(Adapter, true, true, channel, Bandwidth, Offset40, Offset80, channel);
>  
> -	/* DBG_871X("<==%s()\n", __func__); */

Please delete the blank lines as well.

regards,
dan carpenter

