Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8330431623C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhBJJ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:29:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42310 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhBJJ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:27:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A7P4ks064221;
        Wed, 10 Feb 2021 07:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=PK9fMGHwpz+ti3YeKTbOGmbp7BImCWA1WUOV+d0Xy9Y=;
 b=Hs9ipYTQ5MYmDke0nl6dDslO3l4af9MnkB/htBagRlp72YNBouUAuCNgC0J9tdy0lfUO
 KqzggoOyXpO+8ocbTFGGRHOnq+st8d+fMD/oFC0/Bc3KNWi42SaP8cZfu23I5W73L9hC
 VUGA24AgieET9GsvCVjrBi1QmmQYxl/9s4p410CTUx0b135S3l6UXi8m+FUkjO2FZBDd
 0etNTwW9kp8KBRqpRlN6J5Njyos8F038/sRrgsmZkV4OXWNhLzTWwY/Dr8xc8BsLedzK
 2qQTPSfvQkV1lMADdxxTkiflLr49U1FTgRwOiH+PIvw0eCrAd2vX29DzYpB527hpvbO+ kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36hjhqt8tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 07:27:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A7PwHs025894;
        Wed, 10 Feb 2021 07:27:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 36j4ppsykd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 07:27:30 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11A7RRgG021177;
        Wed, 10 Feb 2021 07:27:28 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Feb 2021 23:27:26 -0800
Date:   Wed, 10 Feb 2021 10:27:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     karthik alapati <mail@karthek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <20210210072717.GS2696@kadam>
References: <YCLaHXD/sUKM5HZE@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCLaHXD/sUKM5HZE@karthik-strix-linux.karthek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100075
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:23:17AM +0530, karthik alapati wrote:
> fix checkpatch.pl warning for "block comments should align the * on each line"
> 
> Signed-off-by: karthik alapati <mail@karthek.com>
> ---
>  .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 204 +++++++++---------
>  1 file changed, 102 insertions(+), 102 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> index cf23414d7..003f954c2 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> @@ -20,16 +20,16 @@
>  #define MAX_DOZE_WAITING_TIMES_9x 64
>  
>  /**
> -* Function:	phy_CalculateBitShift
> -*
> -* OverView:	Get shifted position of the BitMask
> -*
> -* Input:
> -*		u32 	BitMask,
> -*
> -* Output:	none
> -* Return:		u32 	Return the shift bit bit position of the mask
> -*/
> + * Function:	phy_CalculateBitShift
> + *
> + * OverView:	Get shifted position of the BitMask
> + *
> + * Input:
> + *		u32 	BitMask,

Why is this on a different line??

> + *
> + * Output:	none
> + * Return:		u32 	Return the shift bit bit position of the mask

The "u32" is indented more than the "none".  "bit bit" is probably a
typo?

> + */
>  static	u32 phy_CalculateBitShift(u32 BitMask)
>  {
>  	u32 i;

There is a proper kernel-doc style that function comments are supposed
to use.  https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html

./scripts/kernel-doc -v -none drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c

regards,
dan carpenter

