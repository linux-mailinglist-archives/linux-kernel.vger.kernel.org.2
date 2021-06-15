Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8186D3A7BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhFOKen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:34:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40626 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhFOKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:34:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15FAV50d136911;
        Tue, 15 Jun 2021 10:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=YqA7deJno7CPO0cosA3BNyUNopRBc/bCcLt6020Hge0=;
 b=R+1dSmNuj4rpFizddZeZk4iZDaih6fdKwDb1s4M1v4UQ/DslCj8Iq71yV/5XWUYGn2R6
 ykrrEmAJ/ELF1rUQE8Z4xTCX8jqPbVOgE1ds35F/rvfx2++KgKTJSKaty2CsqdX6IXSk
 NpB9/WzwU1QxOqMTkJXb3/bmTxAeNWcK0zElM4365fh0vTYPqop/qFe7kRdMrVFe6flx
 WrzFwTqOXSLkFvxBv9xLRb3hTNFt36VCdYcI0+9qQDQY69bfv0AVFAfb6d2yxTbW6dAj
 4QJWe0SfjaKdRbbtZAH3fp/0rsfbNM54MDJQph2pMJl6LKjj6805Z8alkISTyZUphMl5 BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 394mbsdung-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 10:32:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15FAVDur072219;
        Tue, 15 Jun 2021 10:32:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3959ckj09m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 10:32:24 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15FAWNdd074621;
        Tue, 15 Jun 2021 10:32:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3959ckj09a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 10:32:23 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15FAWK6K028912;
        Tue, 15 Jun 2021 10:32:22 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Jun 2021 03:32:20 -0700
Date:   Tue, 15 Jun 2021 13:32:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 03/28] staging: rtl8188eu: remove all DBG_88E calls from
 core/rtw_mlme_ext.c
Message-ID: <20210615103213.GA1861@kadam>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
 <20210615001507.1171-4-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615001507.1171-4-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: 5Fw1oaoIQUzojGY7jftn-vFwGZD3GOly
X-Proofpoint-GUID: 5Fw1oaoIQUzojGY7jftn-vFwGZD3GOly
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10015 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106150066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 01:14:42AM +0100, Phillip Potter wrote:
> @@ -4510,8 +4311,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
>  	rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_CONNECT, 0);
>  
>  exit_mlmeext_joinbss_event_callback:
> -
> -	DBG_88E("=>%s\n", __func__);
> +	return;
>  }

You'll have to delete the return and the exit_mlmeext_joinbss_event_callback
label in a follow on patch because it introduces a checkpatch warning.

(I'm not concerned about introducing checkpatch warnings in this patch
too much because fixing them in one got makes the patch a little more
complicated to review.  So it's not necessarily even a wrong thing to
introduce a checkpatch warning.  Just remember to remove it later.  Or
don't remember because eventually someone else will take care of it).

regards,
dan carpenter

>  
>  void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *psta)
 
