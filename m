Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851E0321083
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 06:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBVFld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 00:41:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60498 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhBVFl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 00:41:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11M5dUtg010427;
        Mon, 22 Feb 2021 05:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=3mzvToJRGgOWKNcCAvalKEoB1cfD+sesK/shn4rlDSQ=;
 b=gAEbJaVHuY+rYzUdLR2b4JB3o0xG7+Iz6FdyRWJKGGj0XCq48bz2GSKeKunfKnMqPGxT
 oR226o25aMoz4vb1eQN2WFYBJVH3PnGu4WSuDBB+RFDIGIPA8/9hbno0MI2XGwUfaiSg
 feK0PmIm8VoHlaBRkB0SJp/ZvH6aZoW9dYm9VlkG3BltYE7O33YYiNBL+YsfnYRp/ajM
 F8NWkiebW6cBwjaSJQYz4W1H62AnDT3gXBqZbzR0NcfpMWbR8IQXaV4j6g+qJLCnKEmv
 P7Ls042cU57Dk3CEVHzDhmhpHL8HP1LEiDeVoE3Zod3CgEXKiyEs+HlJfSEAE/AC6CXo yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36tqxbafjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 05:40:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11M5eggh192294;
        Mon, 22 Feb 2021 05:40:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 36uc0ku5cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 05:40:43 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11M5ebY6030829;
        Mon, 22 Feb 2021 05:40:37 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 21 Feb 2021 21:40:36 -0800
Date:   Mon, 22 Feb 2021 08:40:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     karthik alapati <mail@karthek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukul Mehar <mukulmehar02@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wimax: fix sparse incorrect type issue
Message-ID: <20210222054029.GF2087@kadam>
References: <YDDzqPT81QBGpTBB@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDDzqPT81QBGpTBB@karthik-strix-linux.karthek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102220051
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9902 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 05:04:00PM +0530, karthik alapati wrote:
> fix sparse warning by casting to explicit user address-space
> pointer type
> 
> Signed-off-by: karthik alapati <mail@karthek.com>
> ---
>  drivers/staging/wlan-ng/p80211netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
> index 6f9666dc0..70570e8a5 100644
> --- a/drivers/staging/wlan-ng/p80211netdev.c
> +++ b/drivers/staging/wlan-ng/p80211netdev.c
> @@ -569,7 +569,7 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
>  		goto bail;
>  	}
>  
> -	msgbuf = memdup_user(req->data, req->len);
> +	msgbuf = memdup_user((void __user *)req->data, req->len);

This doesn't fix anything it just silences the warning.  Linus Torvalds
worked very hard to create Sparse for the express purpose of printing
the warning.  People don't realize that warnings are very valuable
because they show where the bugs are.

Please look at this some more and figure out how to fix the warning.

To be honest, I'm tempted to not accept any patch which doesn't also fix
the buffer overflows when we pass:

	result = p80211req_dorequest(wlandev, msgbuf);

How do we know that "msgbuf" is large enough?

regards,
dan carpenter

