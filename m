Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF28E368332
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbhDVPSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:18:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2532 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237782AbhDVPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:18:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MF0mV9014176;
        Thu, 22 Apr 2021 15:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Rek5ib4KVkGbLgWvvgyJ8gG8LHrGGTA42+yAkTTjZB8=;
 b=Lp5D/9zDRUNAd17IvFiGGCilm6fRBIoIpwsCA32ni0624BekcnXwxd2dHIu4Du7zpRMG
 KvDjBCbqtGGBCjWJ+SPT7RrSvZf7Sa4sDg542lOAVLe5i6ZNQbzjQhCgxVbFM1jBr1wN
 POw1UT63GuorRIsuPSxZDA/T2tGPSa/+tsLclCvrh+nbz2cOyXbFrnw3As4S5h2S5ghO
 WNvz+7sX/B0RIE0dkOOwxaUsjVSKMfwxp2DixGh8x2iXO7At3T45i7E1uavMULERoAd2
 ou25zuhgPJ5fboP9RdWqgmmPsXtj8Ou/8PttD2tOVW3wgYZ2shHls0IuIzpwhL9gekls UA== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 382uth0bfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 15:17:53 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13MFHrZT192830;
        Thu, 22 Apr 2021 15:17:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3809m2ekqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 15:17:53 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13MFGMdT184396;
        Thu, 22 Apr 2021 15:17:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3809m2ekq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 15:17:52 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13MFHmuR002595;
        Thu, 22 Apr 2021 15:17:48 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Apr 2021 08:17:48 -0700
Date:   Thu, 22 Apr 2021 18:17:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: avoid bogus gcc warning
Message-ID: <20210422151740.GI1981@kadam>
References: <20210422133219.1689027-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422133219.1689027-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: Evf3bBxuuGAjpX92Ko6vLzYXNqckTjTo
X-Proofpoint-GUID: Evf3bBxuuGAjpX92Ko6vLzYXNqckTjTo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 03:32:04PM +0200, Arnd Bergmann wrote:
> @@ -762,7 +764,6 @@ static int rtw_cfg80211_ap_set_encryption(struct net_device *dev, struct ieee_pa
>  		}
>  
>  	}
> -

Since you're going to need to redo this, then please don't do this
unrelated whitespace change.

>  exit:
>  
>  	return ret;
> @@ -885,8 +886,10 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
>  					if (strcmp(param->u.crypt.alg, "TKIP") == 0 || strcmp(param->u.crypt.alg, "CCMP") == 0)
>  					{
>  						memcpy(padapter->securitypriv.dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
> +#if 1

These seems unintetional?

>  						memcpy(padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[16]), 8);
>  						memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
> +#endif
>  	                                        padapter->securitypriv.binstallGrpkey = true;
>  
>  						padapter->securitypriv.dot118021XGrpKeyid = param->u.crypt.idx;

regards,
dan carpenter

