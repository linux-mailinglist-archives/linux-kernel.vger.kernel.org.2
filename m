Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5201B36578A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhDTL1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:27:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58664 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231313AbhDTL1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:27:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KB6P3U004377;
        Tue, 20 Apr 2021 11:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=iZCrL4mGPGGd5Ok7YpbtBOxKtyA7CWgyjiC3K7ccInU=;
 b=kbi/hnY4ASq1DiO1rylxnduI6fI+RbfPSkdKQymgE7czf1tEF1DBE8s8nlQqlHyX9OF1
 nA7EIh1kCwuRXB+6r/UkMuswVEBrmXBnDAZJpR+2lSwnSbLsvyEevKiL/0h5eOMvdrlO
 tbKu4jnp3fpJLjlo7EWBXIDXL6dXOJop9MG1+bSwm4Nw4BvDlZW+TOgjmLO4rtRYpZZg
 LlJfNs3ydqciKVKSB5Upz6jB3kdHqQenuQ2ZEeNoE7/n/nNzPTOfiy5g1H7zKNaMvSQJ
 qKYafaE9ybFQakSSnwmjdPuGEARtmXOrZRCL83py/3TGjPKbPKio+kD76HOfdM8VRUpq xA== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3818ujg7nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 11:06:20 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13KB5tNu144172;
        Tue, 20 Apr 2021 11:06:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3809esenfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 11:06:19 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13KB6ISt145328;
        Tue, 20 Apr 2021 11:06:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3809esenfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 11:06:18 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13KB6Hdj006253;
        Tue, 20 Apr 2021 11:06:17 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Apr 2021 04:06:17 -0700
Date:   Tue, 20 Apr 2021 14:06:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        hello@bryanbrattlof.com, hdegoede@redhat.com,
        saurav.girepunje@google.com, john.oldman@polehill.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: remove multiple return
Message-ID: <20210420110609.GD1981@kadam>
References: <20210418173233.GA59153@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418173233.GA59153@user>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: nE7QOgO-DKcJ4ZT65I4u_lH3Vuo36yOy
X-Proofpoint-ORIG-GUID: nE7QOgO-DKcJ4ZT65I4u_lH3Vuo36yOy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 11:02:33PM +0530, Saurav Girepunje wrote:
> on sdio_intf.c rtw_sdio_suspend call we have multiple
> return which can replace by goto exit. As in all the places
> return value is 0.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@google.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index a9a9631dd23c..3e566cf97f6e 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -445,14 +445,17 @@ static int rtw_sdio_suspend(struct device *dev)
>  	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
>  
>  	if (padapter->bDriverStopped)
> -		return 0;
> +		goto exit;
>  
>  	if (pwrpriv->bInSuspend) {
>  		pdbgpriv->dbg_suspend_error_cnt++;
> -		return 0;
> +		goto exit;
>  	}
>  
> -	return rtw_suspend_common(padapter);
> +	rtw_suspend_common(padapter);

Also it's weird that your previous patch made rtw_suspend_common()
return zero unconditionally.  But now we're modifying the only caller to
not check the return.  Just make rtw_suspend_common() void and change
this to:

	rtw_suspend_common(padapter);

	return 0;

regards,
dan carpenter

