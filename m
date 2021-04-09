Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7C9359BC2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhDIKQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:16:45 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53626 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDIKNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:13:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139A5FJQ186534;
        Fri, 9 Apr 2021 10:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5VMAgQY/rRrnQA1Fz/0QJp8YT1vXr4XEk59BoMFyGIE=;
 b=geHAOJCl0FodBJtPzjutS4rf+4kSK9PW0QXLczGnmdSNAzNayYSPPmgD1sxsRt5ttRPs
 tt5sbclJogGXdIEKD1NPCYqoFNm+zYCawBHQcL2QH6q2agyZnFM21BG9kJhBFR2MePUK
 6nSBr3bZOADrZPfRc4wcsSdRHXpjP82/vaFeoT0Gcz2D6mLiDV4BXINk7gbvVmphmYt0
 0TkSJowAQSkEcWBb9T19YNPi8l9/DSi99N1y2YhqPeKfdthdB2ganSRVH+1ve6whgZ3v
 Y2eJoI/O4anbRVzQS6z4fws8qSpL0/usTgD2DAYunYUL3kY3HdIhlGYbIepHE87mfUQx fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37rvaw8w11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 10:13:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139AAC5B113928;
        Fri, 9 Apr 2021 10:13:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 37rvbhegs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 10:13:01 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 139AD0SL028927;
        Fri, 9 Apr 2021 10:13:00 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Apr 2021 03:12:59 -0700
Date:   Fri, 9 Apr 2021 13:12:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] staging: rtl8723bs: remove commented out RT_TRACE
 logs in hal/ and os_dep/
Message-ID: <20210409101252.GL6048@kadam>
References: <cover.1617640221.git.fabioaiuto83@gmail.com>
 <85338f2b2cffb530efbd987064d146fc2be49c72.1617640221.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85338f2b2cffb530efbd987064d146fc2be49c72.1617640221.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090073
X-Proofpoint-ORIG-GUID: 9P1oyh_n1EBBy_-ChxvPw-pat7t0FTWX
X-Proofpoint-GUID: 9P1oyh_n1EBBy_-ChxvPw-pat7t0FTWX
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 06:49:49PM +0200, Fabio Aiuto wrote:
> diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> index 9b16265b543d..f52cc4e7a6e6 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> @@ -1785,7 +1785,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
>  	/*
>  	if (band_type == BAND_ON_5G && pwr_lmt == MAX_POWER_INDEX) {
>  		if (idx_bandwidth == 0 || idx_bandwidth == 1) {
> -			RT_TRACE(COMP_INIT, DBG_LOUD, ("No power limit table of the specified band %d, bandwidth %d, ratesection %d, rf path %d\n",
>  				 idx_band, idx_bandwidth,
>  				 idx_rate_sctn, rf_path));
>  			if (idx_rate_sctn == 2)

This won't compile.

regards,
dan carpenter


