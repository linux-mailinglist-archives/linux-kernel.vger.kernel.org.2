Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A78034FDE6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhCaKRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:17:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33620 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbhCaKRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:17:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VA56Lj105206;
        Wed, 31 Mar 2021 10:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+D2v2EZQvmBA+m+2IxOAxb/tWwGoJI3TuWzKUzEcgdY=;
 b=Nfr0a2snQgrVcc6rFCtm+oAQckOYGbv/dAmXV0fRt9piLgKUM3b0MXir4NFG3vi5Hhvq
 kATo4xUeW2spDApr4+G3nznYuYjeUTYAHGx0NMQaykypacmE6kXbxxZnPeIZjNrXkNZ0
 gWdBeVNPIrPpLpfTnCgI5efBzydWX0k6k5mOajxk2TR7SFt18/1pgI/BgG6Hsl66/qXb
 qb4DOGPyF5d7hYYgO4jZDPcX/JqJDM/53tzeJ3ClYSh/aK4ao8nluujNgXufh5+1RK0Y
 UBAkw8u8SsgWeTpeUggcmwYYJqfq+f4KJu6+1ioTuEz4+RDAaPzM+zOZsQmJE3EchWxT oQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37mad9sr5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 10:17:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VA5eCc035381;
        Wed, 31 Mar 2021 10:17:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 37mabp7s0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 10:17:07 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12VAH6Jd020451;
        Wed, 31 Mar 2021 10:17:06 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Mar 2021 10:17:05 +0000
Date:   Wed, 31 Mar 2021 13:16:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/40] staging: rtl8723bs: replace RT_TRACE with public
 printk wrappers in core/rtw_xmit.c
Message-ID: <20210331101658.GK2065@kadam>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
 <75c8a2396a0cae9ad7933577b20dfbf3a7ce6816.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75c8a2396a0cae9ad7933577b20dfbf3a7ce6816.1617183374.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310073
X-Proofpoint-ORIG-GUID: kbsi59_HsHa-91GsQHOXMTPFPRY1LkZC
X-Proofpoint-GUID: kbsi59_HsHa-91GsQHOXMTPFPRY1LkZC
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry but we can't accept this patch.

> @@ -481,12 +481,13 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
>  	pattrib->mac_id = psta->mac_id;
>  
>  	if (psta->ieee8021x_blocked == true) {
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("\n psta->ieee8021x_blocked == true\n"));
> +		pr_err("%s psta->ieee8021x_blocked == true\n", DRIVER_PREFIX);

Here we have change debug code that's never printed into an error
message.

A bunch of the rest are technically "wrong" but harmless.

>  	if (!pxmitpriv->pallocated_frame_buf) {
>  		pxmitpriv->pxmit_frame_buf = NULL;
> -		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_frame fail!\n"));
> +		pr_err("%s alloc xmit_frame fail!\n", DRIVER_PREFIX);

We don't print warning messages for allocation failures.  Checkpatch
is supposed to complain.

I always encourage people to think about everything deeply and look at
the context and read the error messages.  But if you send a patch which
mindlessly deletes all these RT_TRACE() messages, then we will apply
that.

It's unfortunate that you have to re-write the first patch in a 40
patch series.  :/

regards,
dan carpenter

