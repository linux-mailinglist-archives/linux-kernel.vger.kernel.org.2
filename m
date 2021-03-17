Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344C233F59D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhCQQfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:35:14 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:8206 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232544AbhCQQfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:35:06 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12HEmhcD023067;
        Wed, 17 Mar 2021 14:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=yPbmjoM0qgv8iKUll9Xu7C8bQAFVGFgpW2hdJ+GTI4w=;
 b=FnVN9efgSyScEZSCjGZT8OFaf/AzJrSQzSBuFXNHiJAoKiIttnjJFrT7Vr3VFW6L4x9/
 ytOPryJtFXjFhIo1oKBc34gzD4DZ+QO6VFB88Uhvg4OfTecqBepUA0oiyqeOgeDZN8PE
 DdNrMvnByeZzTtU8uDMIKmzICXr6Y1xNWyGecPA1p4n1g0Pwjp+fxvzbwSGzxZJLEr0j
 2OLeuc0ibJ6KTVdC+UuUtzHGhHtlnI26VYczxo34K6NEBS2OLfsBhoNDZ7lYV0k8G8Ir
 qn6pXg6CujmZ8YwxiYzzAg+ey9ce58n+PP2ZeDJfTkhb9yRQiC+zFJ4wDG0upTTdNLTb KQ== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 37b0bb0c9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Mar 2021 14:53:11 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 0C02C6E;
        Wed, 17 Mar 2021 14:53:10 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.162.101])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 32AF346;
        Wed, 17 Mar 2021 14:53:10 +0000 (UTC)
Date:   Wed, 17 Mar 2021 09:53:09 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     robinmholt@gmail.com, steve.wahl@hpe.com, mike.travis@hpe.com,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc/sgi-xp: use NULL instead of using plain integer as
 pointer
Message-ID: <20210317145309.GM1938704@swahl-home.5wahls.com>
References: <1615885041-68750-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615885041-68750-1-git-send-email-yang.lee@linux.alibaba.com>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-17_07:2021-03-17,2021-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 mlxlogscore=999 priorityscore=1501 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Steve Wahl	<steve.wahl@hpe.com>

On Tue, Mar 16, 2021 at 04:57:21PM +0800, Yang Li wrote:
> This fixes the following sparse warnings:
> drivers/misc/sgi-xp/xpc_main.c:210:23: warning: Using plain integer as
> NULL pointer
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/misc/sgi-xp/xpc_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
> index 84610bb..b2c3c22 100644
> --- a/drivers/misc/sgi-xp/xpc_main.c
> +++ b/drivers/misc/sgi-xp/xpc_main.c
> @@ -207,7 +207,7 @@
>  {
>  	xpc_arch_ops.heartbeat_init();
>  	timer_setup(&xpc_hb_timer, xpc_hb_beater, 0);
> -	xpc_hb_beater(0);
> +	xpc_hb_beater(NULL);
>  }
>  
>  static void
> -- 
> 1.8.3.1
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
