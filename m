Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05C73480F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbhCXSw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:52:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58614 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhCXSwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:52:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OIiHrC145718;
        Wed, 24 Mar 2021 18:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=it5Jx4mfOUvPNC0feT8uQU3Wr784UnyNfdgedmnfFKg=;
 b=w1L/wZbGEqS6URcwn2AwPXHaJ9xHwh9CD3FqRgVxEnAOQvUoi4MpQfFOIy+eUgEuscPx
 ths8WRQZqjw5DGUb1RMDzdCnaFGKwPGhKMV0m4ix/EkQ2T+w/vdo5MOwkRxhG6ShYZYy
 EeoFKRq6aNtK3QWcas9Hf+9hM/XHE9rTXICMn7iBUnJxzkgLfC7KtF5nr5d5mW5lvhbH
 Jt7r/B3xE3Or01nAwpOju8bF/LRuapw4FWmxfNe7OVNvfuFnQnBNvHSe9iea53xFkrJM
 qrBXStSYm5iwHpA9eptV7AO250DZOYCZsfif4Hubcd1y8kprVkoahiqxdPYgDqYR6+Ls /g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37d6jbm068-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 18:51:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12OIpC82188179;
        Wed, 24 Mar 2021 18:51:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 37dtmr6yrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Mar 2021 18:51:16 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12OIoufO016250;
        Wed, 24 Mar 2021 18:50:59 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Mar 2021 11:50:55 -0700
Date:   Wed, 24 Mar 2021 21:50:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, colin.king@canonical.com
Subject: Re: [PATCH] ALSA: usb-audio: Fix missing return assignment
Message-ID: <20210324185047.GP1667@kadam>
References: <20210324172604.GA380592@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324172604.GA380592@LEGION>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103240135
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 10:26:04PM +0500, Muhammad Usama Anjum wrote:
> Return value of usb_driver_claim_interface should not be ignored.
> Instead it should be stored in err variable and returned from
> this function.
> 
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
>  sound/usb/quirks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index 9e5e37eff10e..dd32ceaef18a 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -427,10 +427,10 @@ static int create_autodetect_quirks(struct snd_usb_audio *chip,
>  
>  		err = create_autodetect_quirk(chip, iface, driver);
>  		if (err >= 0)

create_autodetect_quirk() never returns positive values.  Flip this
condition.  (Always do error handling, don't do success handling).

		if (err)
			continue;


> -			usb_driver_claim_interface(driver, iface, (void *)-1L);
> +			err = usb_driver_claim_interface(driver, iface, (void *)-1L);

This is in a loop so only the last return value is used.  Which seems
sort of weird and pointless that the last value would matter more than
the others.

>  	}
>  
> -	return 0;
> +	return err;

regards,
dan carpenter

