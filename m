Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2232C352A67
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 13:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhDBL4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 07:56:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45986 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 07:56:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132BtCl3039213;
        Fri, 2 Apr 2021 11:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=g8bxVMgyHVTwRpjyuvQct81PNk2EgSaODisgF70V5uk=;
 b=nWScpQakHNDSm0pmd6ZYG0mhehyVqEbCeIo3H9OrPyjuklhxjaFBpO4gXkwV8ctn8VD7
 j+icGUAjyb6jTC/baq4IF38huXm9HwG4cwKEQh2IrdnWu308i3eg9CqxZC3odCbOkD+T
 2goxAtP+JUfzFZjTeNHJJV2t0OZ/uLGoJdUoLI7DdKqBJH/zNl6SIXdrRfC2PVijxtko
 wZzNwqhFDWDCMPXifk+PP5qQKrBpZi+W8BcW78Tr/KgeywLnymGMZaDzo0wTrhPeZbeF
 OlpwQAlrXF+sZhDWQNEhJ2ss4nZMRYkeLQlivRswyn+BIEDrIQodyVNF8NLTkfDjCrsw cA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37n30sceb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 11:56:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132Bt0LE171421;
        Fri, 2 Apr 2021 11:56:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 37n2acd4b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 11:56:34 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 132BuXMY019108;
        Fri, 2 Apr 2021 11:56:33 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Apr 2021 11:56:32 +0000
Date:   Fri, 2 Apr 2021 14:56:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] staging: rtl8723bs: remove RT_TRACE logs in
 core/rtw_xmit.c
Message-ID: <20210402115626.GV2088@kadam>
References: <cover.1617356821.git.fabioaiuto83@gmail.com>
 <72ab5222629f912ca2dbe825d194108992d321e7.1617356821.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72ab5222629f912ca2dbe825d194108992d321e7.1617356821.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020088
X-Proofpoint-GUID: a8RcKCksvX6fp5PJuQ5Z1a2MmJmr7vES
X-Proofpoint-ORIG-GUID: a8RcKCksvX6fp5PJuQ5Z1a2MmJmr7vES
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 12:01:21PM +0200, Fabio Aiuto wrote:
> @@ -568,20 +561,11 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
>  	if (pattrib->encrypt > 0)
>  		memcpy(pattrib->dot118021x_UncstKey.skey, psta->dot118021x_UncstKey.skey, 16);
>  
> -	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_,
> -		("update_attrib: encrypt =%d  securitypriv.sw_encrypt =%d\n",
> -		pattrib->encrypt, padapter->securitypriv.sw_encrypt));
> -
>  	if (pattrib->encrypt &&
> -		((padapter->securitypriv.sw_encrypt == true) || (psecuritypriv->hw_decrypted == false))) {
> +		((padapter->securitypriv.sw_encrypt) || (!psecuritypriv->hw_decrypted)))

You've done too much clean up here.  Just remove the { but leave the
== true/false comparisons.

If the patch is only changing five lines or code then fixing checkpatch
warnings on the line of code you are changing is fine, but in this case
you're doing a bunch of changes and these sort of cleanups make it hard
to review.

Ease to spot that the curly brace changed:
-		((padapter->securitypriv.sw_encrypt == true) || (psecuritypriv->hw_decrypted == false))) {
+		((padapter->securitypriv.sw_encrypt == true) || (psecuritypriv->hw_decrypted == false)))

Hard to spot:
-		((padapter->securitypriv.sw_encrypt == true) || (psecuritypriv->hw_decrypted == false))) {
+		((padapter->securitypriv.sw_encrypt) || (!psecuritypriv->hw_decrypted)))

regards,
dan carpenter

