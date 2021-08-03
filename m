Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562323DF1DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbhHCPzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:55:20 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:20330 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237155AbhHCPzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:55:15 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173FqadE011516;
        Tue, 3 Aug 2021 15:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=Mq8tqPB6aFUXF79BN1GSn1mnIUdBT2sWOfgnjO7kqAg=;
 b=GMvznskQ1ZyDlzNrZ1n2XaOfOqOTMkHoPfoNhqi82mK4WfuIkyIXiD71mcToSyxaBpF0
 SrQ3Q7cnaCWAKAbKgdpGANLJSrquEr9YaOLp3jhRRydqgteW85j5NAgq4Ef7nX8QXhdd
 17V+vdE/7SngXYEqPm8d6neKemEJauzUiIJ0j2ICsLdCLqSzjc3oCKKgItRkgyQ4Qz/d
 +S2FpbCllLOWjoCgBYt4aSwjpmkGv6IGuljiVWm2Ok8f1AE9glxgHgyUvZPTcq+iHtYN
 HyHY689rUDh5muF/MgLh86Ho9lPPGrebXHie0x8JxD6rZU8f+u37GwRBPPENLlbX3MKd Tg== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 3a77rfgqse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 15:54:42 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id E8A6C4F;
        Tue,  3 Aug 2021 15:54:41 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.99.165.124])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id DC2D046;
        Tue,  3 Aug 2021 15:54:40 +0000 (UTC)
Date:   Tue, 3 Aug 2021 10:54:40 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Robin Holt <robinmholt@gmail.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 16/38] sgi-xpc: Replace deprecated CPU-hotplug functions.
Message-ID: <YQlmwEmM9LS+RfNj@swahl-home.5wahls.com>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <20210803141621.780504-17-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803141621.780504-17-bigeasy@linutronix.de>
X-Proofpoint-ORIG-GUID: cQfetl9DCy8nJcMmqNPDlmN6KeRH_j6I
X-Proofpoint-GUID: cQfetl9DCy8nJcMmqNPDlmN6KeRH_j6I
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_04:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

On Tue, Aug 03, 2021 at 04:15:59PM +0200, Sebastian Andrzej Siewior wrote:
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
> 
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
> 
> Cc: Robin Holt <robinmholt@gmail.com>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Mike Travis <mike.travis@hpe.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/misc/sgi-xp/xpc_uv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
> index 7791bde81a368..ba9ae0e2df0fe 100644
> --- a/drivers/misc/sgi-xp/xpc_uv.c
> +++ b/drivers/misc/sgi-xp/xpc_uv.c
> @@ -1742,7 +1742,7 @@ xpc_init_mq_node(int nid)
>  {
>  	int cpu;
>  
> -	get_online_cpus();
> +	cpus_read_lock();
>  
>  	for_each_cpu(cpu, cpumask_of_node(nid)) {
>  		xpc_activate_mq_uv =
> @@ -1753,7 +1753,7 @@ xpc_init_mq_node(int nid)
>  			break;
>  	}
>  	if (IS_ERR(xpc_activate_mq_uv)) {
> -		put_online_cpus();
> +		cpus_read_unlock();
>  		return PTR_ERR(xpc_activate_mq_uv);
>  	}
>  
> @@ -1767,11 +1767,11 @@ xpc_init_mq_node(int nid)
>  	}
>  	if (IS_ERR(xpc_notify_mq_uv)) {
>  		xpc_destroy_gru_mq_uv(xpc_activate_mq_uv);
> -		put_online_cpus();
> +		cpus_read_unlock();
>  		return PTR_ERR(xpc_notify_mq_uv);
>  	}
>  
> -	put_online_cpus();
> +	cpus_read_unlock();
>  	return 0;
>  }
>  
> -- 
> 2.32.0
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
