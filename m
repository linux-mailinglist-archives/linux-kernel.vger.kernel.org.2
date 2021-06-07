Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E043739D5D8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhFGHWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:22:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:32820 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhFGHWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:22:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15779kDh074430;
        Mon, 7 Jun 2021 07:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qhPAhUr5YAF0o4ASCE+IuS5a+VZymq5evsuGWrWm9XA=;
 b=ytF4eeP96vil5Jtivp6h2u78o+Q43vEcwf2Yt+iAXCMXdT+ns3n8udflMh5D8HCwsd/2
 wIQJSYgcYSUWGcdkY/h3ZLdZWyZc37lLneYYBnihAeoDL5NZgUCJZF5JEs/bXxwf5wU9
 cozAPyQCbu7Oj1OXDiBYMThEdRU6XivrAiYNRbtTG2bY4s0Fj8AG6FxahsT8i7BG6kR0
 flvuyYg8v5XHvp7Iq+o+TH8UXCLtkUv3jBC5kJDQUq6phzD1VM3wIEBvvSisy2ZGMuXb
 e5rGIjUm7f5oB7d6d/J+99bsuxK/T53XAjDeX0FFUUpdj7doWJmuX5NxUXSzDvTXAYMy zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 39017na1wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 07:20:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1577AJXY077676;
        Mon, 7 Jun 2021 07:20:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38yxctnasu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 07:20:12 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1577KBeJ099409;
        Mon, 7 Jun 2021 07:20:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 38yxctnask-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 07:20:11 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1577K7qj027060;
        Mon, 7 Jun 2021 07:20:08 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jun 2021 00:20:05 -0700
Date:   Mon, 7 Jun 2021 10:19:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] staging: rtl8188eu: remove RT_TRACE and DBG_88E
 prints from usb_ops_linux.c
Message-ID: <20210607071958.GN1955@kadam>
References: <20210605165858.3175-1-martin@kaiser.cx>
 <20210605165858.3175-6-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605165858.3175-6-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: lmfaHgLbDUepcqMFZn2Hz_0XvECWgG3F
X-Proofpoint-ORIG-GUID: lmfaHgLbDUepcqMFZn2Hz_0XvECWgG3F
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10007 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 06:58:55PM +0200, Martin Kaiser wrote:
> @@ -464,14 +403,8 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
>  			  precvbuf);/* context is precvbuf */
>  
>  	err = usb_submit_urb(purb, GFP_ATOMIC);
> -	if ((err) && (err != (-EPERM))) {
> -		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
> -			 ("cannot submit rx in-token(err=0x%.8x), URB_STATUS =0x%.8x",
> -			 err, purb->status));
> -		DBG_88E("cannot submit rx in-token(err = 0x%08x),urb_status = %d\n",
> -			err, purb->status);
> +	if ((err) && (err != (-EPERM)))
>  		ret = _FAIL;

Not related to your patch but why is -EPERM treated differently?  It's
not immediately clear that -EPERM is even something that usb_submit_urb()
returns...

> -	}
>  
>  	return ret;
>  }

regards,
dan carpenter

