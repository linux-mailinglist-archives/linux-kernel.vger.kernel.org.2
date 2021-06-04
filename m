Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9343B39B492
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhFDIHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:07:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49892 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhFDIHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:07:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154859fU194812;
        Fri, 4 Jun 2021 08:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jJWOOXSkYAkpt+g7vqJxwxRiAokBtYawViAkg0r5HqI=;
 b=n/BAzFw9fyHDxD6HPVZz/BaXjAfGynLNBHWiSyq4IrvuWhzCQ9UCaZwF0l3K3vLr366H
 Is5GRZFy0Bfvj0Qm2RfSIc3z0e0IiUxRFZpSoZE2LtJyr38MMZKLlBTC6pLC1s+5yf9K
 q4Pk1NZf5AMmEifo6vFGcy7wFAytdLpmYbxUyCmcuKRRZfU+m7WXw7+KhSF5UB+duHYl
 mcqvwDuiTnT/ho4/+Ea5N+ty8V+Pt0PGH/FZa4+dX2TXkowkA+04ErcgpiGH0oYykl+Y
 hd2HnBvzFLt8zdnXKi3m/dMPDVC1C8GcNbJG/er4Yv/aohNWmBqYEhfPwZdQ3e5UnFBR bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 38ub4cwa26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 08:05:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15481bXu177927;
        Fri, 4 Jun 2021 08:05:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38xyn2vufn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 08:05:14 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15484kT2008787;
        Fri, 4 Jun 2021 08:05:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 38xyn2vuer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 08:05:13 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15485B1Y010883;
        Fri, 4 Jun 2021 08:05:11 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Jun 2021 01:05:10 -0700
Date:   Fri, 4 Jun 2021 11:05:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] habanalabs/gaudi: remove redundant assignment to
 variable err
Message-ID: <20210604080503.GJ1955@kadam>
References: <20210603131210.84763-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603131210.84763-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: WviqR1NcVCWnZldX1R1r5L7NXmfRlcp-
X-Proofpoint-ORIG-GUID: WviqR1NcVCWnZldX1R1r5L7NXmfRlcp-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 02:12:10PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being assigned a value that is never read, the
> assignment is redundant and can be removed. Also remove some empty
> lines.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index 9e4a6bb3acd1..22f220859b46 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -7379,9 +7379,6 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
>  			device, ch, hbm_ecc_data->first_addr, type,
>  			hbm_ecc_data->sec_cont_cnt, hbm_ecc_data->sec_cnt,
>  			hbm_ecc_data->dec_cnt);
> -
> -		err = 1;
> -
>  		return 0;
>  	}

Not related to your patch (which seems fine), but I always feel like
there should be a rule that function which return a mix of negative
error codes and either zero or one on success should have to have
documentation explaining why.

It's impossible to tell from the context here and neither of the callers
check the return.  :P

regards,
dan carpenter

