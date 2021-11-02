Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEB1442EFD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhKBNWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:22:51 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:50972 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhKBNWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:22:49 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A2A7R5Z011686;
        Tue, 2 Nov 2021 14:19:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Ri4yMGwrAUZiVf3L1C/w0Zj9MIgPav+yZmRTaIH3Qws=;
 b=nC99aj0m6/J7C2P12APD0T3skjuSsRU9U4YxQtgNhkS1LpiewNPoXwDdiPCdfbsmMv1A
 Uy2NdYnolyro+RqQ7UhK7XEy7WpwHUiwfBgOmVqTZ466uEYKRqCW2NWk/ZkdTVLi/azS
 dVpXqUDHmIrLl/bx3xsEeOfGhzDgzpprbJH7M5Pn1KwxgOy6VQU9ZlCVx5MrIV4Ejzha
 GGPpWQUnttOJ2Kw2pqFQC+nKjy8eTR/4OQXQ6HPSLjLsXbOY6xVps9J9Ukhxrkn0mTLk
 B6HInFH2LRe25rhCjMTs9oJzqqX2Z9+80Jo2JA3qu0A99aqbAh0g5hJ310BLfRnFnolS Fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3c2jfj583t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 14:19:07 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EC359100034;
        Tue,  2 Nov 2021 14:19:06 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E4FB5235D2A;
        Tue,  2 Nov 2021 14:19:06 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 2 Nov
 2021 14:19:06 +0100
Subject: Re: [PATCH v1 1/5] tty: rpmsg: Assign returned id to a local variable
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20211025135148.53944-1-andriy.shevchenko@linux.intel.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Message-ID: <ef2cca2f-8566-ad3c-3ab2-cf0a4439faa0@foss.st.com>
Date:   Tue, 2 Nov 2021 14:19:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211025135148.53944-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 10/25/21 3:51 PM, Andy Shevchenko wrote:
> Instead of putting garbage in the data structure, assign allocated id
> or an error code to a temporary variable. This makes code cleaner.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/rpmsg_tty.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
> index 813076341ffd..8c17ddbf371d 100644
> --- a/drivers/tty/rpmsg_tty.c
> +++ b/drivers/tty/rpmsg_tty.c
> @@ -121,15 +121,16 @@ static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
>  		return ERR_PTR(-ENOMEM);
>  
>  	mutex_lock(&idr_lock);
> -	cport->id = idr_alloc(&tty_idr, cport, 0, MAX_TTY_RPMSG, GFP_KERNEL);
> +	err = idr_alloc(&tty_idr, cport, 0, MAX_TTY_RPMSG, GFP_KERNEL);
>  	mutex_unlock(&idr_lock);
>  
> -	if (cport->id < 0) {
> -		err = cport->id;
> +	if (err < 0) {
>  		kfree(cport);
>  		return ERR_PTR(err);
>  	}
>  
> +	cport->id = err;

Set the cport->id to the err variable on success doesn't seem completely clean
to me either.
What about renaming "err" by "id" as done in [1]?

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/mps2-uart.c#L526

Regards,
Arnaud

> +
>  	return cport;
>  }
>  
> 
