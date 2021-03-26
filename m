Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7534834A542
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhCZKE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:04:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35864 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCZKEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:04:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QA4H1q193995;
        Fri, 26 Mar 2021 10:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=AbVS8030l4bUMoP527cWYL6ykbMlzByqBuzDvNNH9ek=;
 b=SXtPGgnfrOHzfZR1XaYRfbnijFJzc1HtN/Qp1nc9B1Q6x7kHyh0nbLNcR/lQKYYH1Y2b
 dDE/1oFs83N+r2Bgfu9C18DkjHVO01eQjxF1sbH7+k/o+MaO/HsPkurlXofewPHUU4lB
 s0eSbOTCkcjZZjol41dWW87MXgyqi/CB2mSOQYNRJG+3x/lE+xKWfOMk0P+BR0/wOuQ8
 aU2I4gYiQ3yhuMbzKnR4IqpS9201KZPEmcATp83Mq+x6P/CKPgN2LXe6c4wy/saFVs0b
 0xSJkgPA9Gm0EBJKTAk7lcvznUZm3W71n0l+5msKr1wu93nj0Xj8LyFNM2jn8CDOlYVq eQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37h13e9hru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 10:04:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QA0OOV029387;
        Fri, 26 Mar 2021 10:04:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 37h14h041c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 10:04:16 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12QA4FZV012657;
        Fri, 26 Mar 2021 10:04:15 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Mar 2021 10:04:15 +0000
Date:   Fri, 26 Mar 2021 13:04:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] staging: rtl8723bs: put parentheses on macros with
 complex values in include/basic_types.h
Message-ID: <20210326100408.GE1717@kadam>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
 <2c7c198ccef194b06921bc476eda7d5102ab70dc.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c7c198ccef194b06921bc476eda7d5102ab70dc.1616748885.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260072
X-Proofpoint-ORIG-GUID: sOqb6D46lR5mAG9HgYk3x5sQVDD7SQFg
X-Proofpoint-GUID: sOqb6D46lR5mAG9HgYk3x5sQVDD7SQFg
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9934 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 10:09:11AM +0100, Fabio Aiuto wrote:
> fix the following checkpatch warnings:
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> 154: FILE: drivers/staging/rtl8723bs/include/basic_types.h:154:
> +#define SET_BITS_TO_LE_4BYTE(__pstart, __bitoffset, __bitlen, __val) \
> --
> ERROR: Macros with multiple statements should be enclosed in
> a do - while loop
> 161: FILE: drivers/staging/rtl8723bs/include/basic_types.h:161:
> +#define SET_BITS_TO_LE_2BYTE(__pstart, __bitoffset, __bitlen, __val) \
> --
> ERROR: Macros with complex values should be enclosed in parentheses
> 168: FILE: drivers/staging/rtl8723bs/include/basic_types.h:168:
> +#define SET_BITS_TO_LE_1BYTE(__pstart, __bitoffset, __bitlen, __val) \
> 
> parentheses solution preferred for all fixes and made macros more
> readables
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  .../staging/rtl8723bs/include/basic_types.h   | 30 +++++++++++--------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/basic_types.h b/drivers/staging/rtl8723bs/include/basic_types.h
> index 76304086107a..5054c2e3384c 100644
> --- a/drivers/staging/rtl8723bs/include/basic_types.h
> +++ b/drivers/staging/rtl8723bs/include/basic_types.h
> @@ -152,24 +152,30 @@
>  /* 		Set subfield of little-endian 4-byte value to specified value. */
>  /*  */
>  #define SET_BITS_TO_LE_4BYTE(__pstart, __bitoffset, __bitlen, __val) \
> -		*((u32 *)(__pstart)) =				\
> -		(						\
> -		LE_BITS_CLEARED_TO_4BYTE(__pstart, __bitoffset, __bitlen) | \
> -		((((u32)__val) & BIT_LEN_MASK_32(__bitlen)) << (__bitoffset)) \
> +		(\
> +			*((u32 *)(__pstart)) =				\
> +			(						\
> +				LE_BITS_CLEARED_TO_4BYTE(__pstart, __bitoffset, __bitlen) | \
> +				((((u32)__val) & BIT_LEN_MASK_32(__bitlen)) << (__bitoffset)) \
> +			)\
>  		)
>  

These macros are terrible and this makes it uglier.  Better to just
ignore checkpatch until we can figure out a way to re-write this
properly.

regards,
dan carpenter

