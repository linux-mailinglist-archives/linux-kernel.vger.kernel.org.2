Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56755382995
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhEQKOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:14:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17378 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231840AbhEQKOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:14:42 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HADDpg018783;
        Mon, 17 May 2021 10:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=f87dLmC0j6gWoUu+50r2vzkGFGGPi5tJfQ5olNEG49s=;
 b=l7I+RyQgNSZd3XMG37nqg7Rah4RXlne6Oz1c34kgq4rOKJGXywBa7+xHy652oucPhr9b
 dZr2rTI2MNrx7wsHM6H4oBVq20SVKZwfVQiZwmEI2IwsvEjofGWErgm4o6hz74h8T/1b
 FlpASzHa4Wa0+caui38tITaa8CoqR2fiZFxskxaZ8XVuI9FCyLsoffGU5fIbsXV/s+eL
 8Z17hAyGnx/HuHL93LgR4ZuRahECjTwEIbyRFBNOwYxlJ6AshNrbickuMlqpcBDrlXfH
 AKSX3sq7Q6Po18HNpfEwCT/rqGGZytajyzClrz+elEJYVANCzyZNbgbS9+F8hwxzlnD3 Kg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kfhwg4qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 10:13:13 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14HADCMA025213;
        Mon, 17 May 2021 10:13:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38j4bb1d4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 10:13:12 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14HADCLc025196;
        Mon, 17 May 2021 10:13:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 38j4bb1d4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 10:13:12 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14HADBVG008187;
        Mon, 17 May 2021 10:13:11 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 May 2021 10:13:10 +0000
Date:   Mon, 17 May 2021 13:13:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        fabioaiuto83@gmail.com, fmdefrancesco@gmail.com,
        eantoranz@gmail.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, skhan@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 7/7] Staging: rtl8723bs: fix block comment in
 HalBtc8723b1Ant.c
Message-ID: <20210517101302.GF1955@kadam>
References: <20210516122927.1132356-1-desmondcheongzx@gmail.com>
 <20210516122927.1132356-8-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516122927.1132356-8-desmondcheongzx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: esNB97Fc0mpYUVaDvyoiC-TtUK7SLMQF
X-Proofpoint-ORIG-GUID: esNB97Fc0mpYUVaDvyoiC-TtUK7SLMQF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2021 at 08:29:27AM -0400, Desmond Cheong Zhi Xi wrote:
> This commit fixes the following checkpatch.pl warning:
> 
> WARNING: Block comments use * on subsequent lines
> +		/*
> +		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x ", "Latest error condition(should be 0)", \
> 
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
> index cc7f558903ac..87156b2cd1f0 100644
> --- a/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
> +++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c
> @@ -2511,10 +2511,10 @@ void EXhalbtc8723b1ant_DisplayCoexInfo(struct btc_coexist *pBtCoexist)
>  		CL_PRINTF(cliBuf);
>  
>  		/*
> -		CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x ", "Latest error condition(should be 0)", \
> -			pCoexDm->errorCondition);
> -		CL_PRINTF(cliBuf);
> -		*/
> +		 *CL_SPRINTF(cliBuf, BT_TMP_BUF_SIZE, "\r\n %-35s = 0x%x ", "Latest error condition(should be 0)",
> +		 *	pCoexDm->errorCondition);
> +		 *CL_PRINTF(cliBuf);
> +		 */
>  	}

Always just delete dead code.  Otherwise the patchset seems good.

regards,
dan carpenter

