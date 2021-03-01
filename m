Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520373277A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 07:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhCAGeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 01:34:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39688 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhCAGeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:34:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1216VLjk088564;
        Mon, 1 Mar 2021 06:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=oGUQGQucCVr3PpyvCjAJH5vBRTzDzIsYDKRZnRf5e/s=;
 b=fPEKrd5WaxBjPB1UIhydLYCPDeKi/jqwiWdDUIGDxDq4N1ynpQ4ZEy3izJ0xSPEKmdDa
 B7qrMPH9SZRvqVGtrzlHxqfjn/TsqHdQqEICqyHAILoHGdpFx9zw3Sk3kPMHKU9nEB6E
 yFbpmId6vmJt9v8cuiFfjlNrdJvjkGu5vTl6kHgIBD58vVkZdbRYQkuobCHF0+mbZ7M5
 /bu/ZMjcLPeUknoga3PhjaboxkumEuQMEHINx5EQKHH0VPXZDyV71gw73YZVMQKu4B3O
 di68BJu77vLFJw/V4fwAsZS58WfRvUCrJMdmWhQu9HFGDlS/RpaHuHJCMBUlFOKeJdnO FA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36ye1m2mxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 06:33:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1216Uqr1070905;
        Mon, 1 Mar 2021 06:33:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 37000v3kqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Mar 2021 06:33:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1216XJvV005416;
        Mon, 1 Mar 2021 06:33:19 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Mar 2021 06:33:19 +0000
Date:   Mon, 1 Mar 2021 09:33:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Darryl T. Agostinelli" <dagostinelli@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u avoid flex array of flex array
Message-ID: <20210301063312.GK2087@kadam>
References: <20210228010614.162998-1-dagostinelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210228010614.162998-1-dagostinelli@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9909 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010052
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9909 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 07:06:14PM -0600, Darryl T. Agostinelli wrote:
> Undo the flex array in struct ieee80211_info_element.  It is used as the flex
> array type in other structs (creating a flex array of flex arrays) making
> sparse unhappy.  This change maintains the intent of the code and satisfies
> sparse.
> 
> Signed-off-by: Darryl T. Agostinelli <dagostinelli@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> index 39f4ddd86796..43bb7aeb35e3 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> @@ -951,7 +951,7 @@ struct rtl_80211_hdr_4addrqos {
>  struct ieee80211_info_element {
>  	u8 id;
>  	u8 len;
> -	u8 data[];
> +	u8 data[0];

Nah...  Just ignore Sparse on this.

regards,
dan carpenter

