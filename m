Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7142738AE55
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhETMe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:34:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45230 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbhETMe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:34:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14KCFBNt020704;
        Thu, 20 May 2021 12:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=GskLo9CktdnihYaRJUKarN5zAIseuXaG+JLSkvUDzG0=;
 b=EJMTIwEcqXMbYjAsIheg/HoOj70VvVL/V25ybRV32CTFdn8JZK3+sSFlVLOtvo1ou6PC
 oUMbuEmdOOR55aFFkne/3byH94+5qywUfpT1VBFIWe6FX3TaLUbdN6P0e8kI6YrLbndp
 LmV1BBBfWYWYskh1wWplUiB1UGUnxJkkJbRCRkCJwMhoTPoBDpahaKDlZrt9yB58cqnv
 6X+73ieNZOlIn3NRe7VpbrmYWefqlqkJjQ+MeTsa9w4ovlGFzuoBRVQlIyLLL6VozptM
 lzdNAfxJ1e0GQWw7KoJZNgeGhUqe2SpjlasA+VOtkUnxf4ZDx0Zkt66oeFAxPJdDVJOY kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38j6xnmg23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 12:32:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14KCFVe5145210;
        Thu, 20 May 2021 12:32:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38n491qhrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 12:32:52 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14KCWp0d178635;
        Thu, 20 May 2021 12:32:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 38n491qhrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 12:32:51 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14KCWoEC007202;
        Thu, 20 May 2021 12:32:50 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 May 2021 05:32:50 -0700
Date:   Thu, 20 May 2021 15:32:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/2] staging: rtl8723bs: core: rtw_mlme_ext: 'evt_seq' is
 only used if CHECK_EVENT_SEQ is set
Message-ID: <20210520123243.GF1955@kadam>
References: <20210520122620.3470450-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520122620.3470450-1-lee.jones@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: G4QXzBaBo27AjHGhetgEUNjUcvTi-avK
X-Proofpoint-ORIG-GUID: G4QXzBaBo27AjHGhetgEUNjUcvTi-avK
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9989 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:26:19PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c: In function ‘mlme_evt_hdl’:
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:6004:5: warning: variable ‘evt_seq’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 9fc612fb736f8..80e5c29852b8a 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -6009,7 +6009,7 @@ static struct fwevent wlanevents[] = {
>  
>  u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
>  {
> -	u8 evt_code, evt_seq;
> +	u8 evt_code, __maybe_unused evt_seq;
>  	u16 evt_sz;
>  	uint	*peventbuf;
>  	void (*event_callback)(struct adapter *dev, u8 *pbuf);

#ifdef CHECK_EVENT_SEQ is dead code.  Just delete it.

regards,
dan carpenter

