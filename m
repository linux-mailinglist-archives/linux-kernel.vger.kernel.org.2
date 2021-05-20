Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA1C38AE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbhETMjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:39:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2716 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240990AbhETMia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:38:30 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14KCUlQt022002;
        Thu, 20 May 2021 12:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=8GLrX0d0XmrHl8aiSUsOYdiKs8SYFI6qkK8/mq5o8Ws=;
 b=nS2jbQWqV1JBCy48bZxAUnPXx4QLyy/67LJzNmgLsGAKDflEGN9H+diRN3qXxkQ4ahk9
 0/QoYwYXEwrq3OD48Z6WQTEEPl4UHa8JgI8X7rO8d6XpzTpO0SfuhyuLnv5mwZ/RQu35
 Vzdz5owBU8wpGK8wnjU63ZSxdaKmvnKQyJJ28KhreNUfgVZe5cZuncmQgkT9Womkn3xP
 hz1ItX8Bgd22nMEbhN/FEV+nL6wFVaQB15pc6wUMWVWB0trg44pae/lxg0AeMdHK9gpL
 R5AnOCwrK0EQmYL9MFg0Kb0VonyKD3F0pLheWjb+P6nIvQXM1g8NlXAzPtaPHICpHkPS UA== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38m9bgh3d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 12:36:58 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14KCavxh105947;
        Thu, 20 May 2021 12:36:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38megmessx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 12:36:56 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14KCauJh105926;
        Thu, 20 May 2021 12:36:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 38megmessc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 12:36:56 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14KCatIN015477;
        Thu, 20 May 2021 12:36:55 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 May 2021 05:36:54 -0700
Date:   Thu, 20 May 2021 15:36:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Cesati <marcocesati@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>, Stanley@BB.SD3,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: rtl8723bs: hal: rtl8723b_hal_init: Remove
 unused variable and dead code
Message-ID: <20210520123647.GG1955@kadam>
References: <20210520122620.3470450-1-lee.jones@linaro.org>
 <20210520122620.3470450-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520122620.3470450-2-lee.jones@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: eVnGJGhS3kmgJqfetugCIuSxcunvGRdl
X-Proofpoint-GUID: eVnGJGhS3kmgJqfetugCIuSxcunvGRdl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:26:20PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c: In function ‘CCX_FwC2HTxRpt_8723b’:
>  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:3355:5: warning: variable ‘seq_no’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Marco Cesati <marcocesati@gmail.com>
> Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
> Cc: Stanley@BB.SD3
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> index 33942ab587720..0270724ccef03 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> @@ -3204,14 +3204,9 @@ void CCX_FwC2HTxRpt_8723b(struct adapter *padapter, u8 *pdata, u8 len)
>  
>  	if (GET_8723B_C2H_TX_RPT_RETRY_OVER(pdata) | GET_8723B_C2H_TX_RPT_LIFE_TIME_OVER(pdata)) {
>  		rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_CCX_PKT_FAIL);
> -	}
> -/*
> -	else if (seq_no != padapter->xmitpriv.seq_no) {
> -		rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_CCX_PKT_FAIL);
> -	}
> -*/
> -	else
> +	} else {
>  		rtw_ack_tx_done(&padapter->xmitpriv, RTW_SCTX_DONE_SUCCESS);
> +	}

The commit message was quite puzzling because "seq_no" doesn't exist.
Could you resend with a fixed commit message that says "Delete commented
out code" or whatever?

regards,
dan carpenter

