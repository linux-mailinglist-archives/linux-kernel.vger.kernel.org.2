Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D53435EEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349398AbhDNH4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:56:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38190 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhDNH4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:56:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E7nEoJ173917;
        Wed, 14 Apr 2021 07:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=1thdEyOoz4Ff74p2RvNbSPbAdDaciwMX8cdY7e71W5Q=;
 b=e7lVDEq+e+jz6QqxUfLaCcBIa8q0jMnQG+fMf0Gm0+S9QyONyZjgl25RTglbmlRBzuA3
 fRKGFmaHC/yKK89+rNBySCI61S0m9k9LviGATE2j+G+N2GBxQnicIQO+gBxprefwC9Ep
 1cCoX5/BmO1LR/54u9zQ77K1zf8ZGQ9LoPMdVDf/atosqO6lPKIVAE8kOQkC9VEJzE7y
 rUBg6rmFaGHiNYEn9aq6/UEuuOo7wHrMJpZR03uNwnYfGbZry9oO8HPnZbZJXdYKGOLU
 E5PJVX/MfU44X1MEqL9SJR9oUPH1g0/P+RfWhogXJaS65Jxre/hWwz/J/MQQqhbfA0QL pA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37u4nnhek3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 07:55:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E7tWoe050253;
        Wed, 14 Apr 2021 07:55:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 37unstjqvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 07:55:36 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13E7tXgN003494;
        Wed, 14 Apr 2021 07:55:33 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 00:55:33 -0700
Date:   Wed, 14 Apr 2021 10:55:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net, kuba@kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v2 4/5] staging: rtl8192e: rectified spelling mistake and
 replace memcmp with ether_oui_equal
Message-ID: <20210414075525.GR6021@kadam>
References: <cover.1618380932.git.mitaliborkar810@gmail.com>
 <eda8d3401f2f7ff7a61137b4935c6ccb09112e52.1618380932.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda8d3401f2f7ff7a61137b4935c6ccb09112e52.1618380932.git.mitaliborkar810@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140054
X-Proofpoint-ORIG-GUID: 705QvOa-IL_yN18Aq_CePzFssLaaW_gL
X-Proofpoint-GUID: 705QvOa-IL_yN18Aq_CePzFssLaaW_gL
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 12:26:01PM +0530, Mitali Borkar wrote:
> Added a generic function of static inline bool in
> include/linux/etherdevice.h to replace memcmp with
> ether_oui_equal throughout the execution.
> Corrected the misspelled words in this file.
> 
> Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> ---
>  
> Changes from v1:- Rectified spelling mistake and replaced memcmp with
> ether_oui_equal.
> 
>  drivers/staging/rtl8192e/rtl819x_HTProc.c | 48 +++++++++++------------
>  include/linux/etherdevice.h               |  5 +++
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is networking code and not staging code, but the netdev mailing
list isn't CC'd.

>  2 files changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> index ec6b46166e84..ce58feb2af9a 100644
> --- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> @@ -43,7 +43,7 @@ u16 MCS_DATA_RATE[2][2][77] = {
>  	 810, 720, 810, 900, 900, 990} }
>  };
>  
> -static u8 UNKNOWN_BORADCOM[3] = {0x00, 0x14, 0xbf};
> +static u8 UNKNOWN_BROADCOM[3] = {0x00, 0x14, 0xbf};

Please pull this spelling fix into its own patch.

[ snip ]

> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> index 2e5debc0373c..6a1a63168319 100644
> --- a/include/linux/etherdevice.h
> +++ b/include/linux/etherdevice.h
> @@ -87,6 +87,11 @@ static inline bool is_link_local_ether_addr(const u8 *addr)
>  #endif
>  }
>  
> +static inline bool ether_oui_equal(const u8 *addr, const u8 *oui)
> +{
> +return addr[0] == oui[0] && addr[1] == oui[1] && addr[2] == oui[2];
> +}

The indenting is messed up on this.

regards,
dan carpenter

