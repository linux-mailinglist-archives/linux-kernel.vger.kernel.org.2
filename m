Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136DE3DF17B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbhHCPaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbhHCP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:29:23 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66985C061799;
        Tue,  3 Aug 2021 08:29:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u25so28561768oiv.5;
        Tue, 03 Aug 2021 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XTtoCO1t0wwTsI/1rhQp3pLLPoNLBILhcetxuNpAgJU=;
        b=noEo8t+GpaFSflIutivDoUGK7zVX8dAS6cJ1ZLu+uD2sOPCns2WPVqEpz/rOiJPYPU
         z2Mj107NejIac99ZeLmYNnKgJ4umAoF5R8Yqg6G/4hs2OUUEKArjTH3KTEJxl/ssiWZI
         NnAA9HKrblX0DsH4NSdD1k+qJuC2y0X96fYL6xS2U9QgeZPE3AiEo2FtmlJECR5EIWWv
         JHx4SquWb0BqSYwn6B6rBIevch38CjMrECXYutkrmyPPXAqsy/+rVDllNp0Z6S/dR/BS
         Ik+MxXkUr1EOIS+in89Duqfj/uU+QdHkKALtZ/7jMaDoMfwU+5H4YgXZIhKf9rfKW+l/
         c/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XTtoCO1t0wwTsI/1rhQp3pLLPoNLBILhcetxuNpAgJU=;
        b=sRPCib/eAD+KU4SvY1z69oXwYJDfrMSEJknRAZjV/60RVuaxm51Xeakz2i7c/6D/3n
         UJZ77OmcYQ9qYxlVX2YN2eF5DT9AYgrUjVYnSTxFioTa+N4QtCQFeTwJdaQWXHAl06CY
         rEd0nWzRaMxWo30xbBnR6PJkYzkMOsmcqg/5Kxgly7L/U7akHtGHMJTEvsRo7ZX9+lZr
         LKGnqxJfWifMx/aBbUYmxLBNdxYqMX2Xm5Fo6GCUuBqBlBQLv9qIKOr56Uqh154hORUG
         MQ2XOdBa+SDYGhJ6V/baxNY3+3kzRx8bMlZVrXT4ZYpfHlOBFdEyz6lMjAbHYqb3aOww
         luxA==
X-Gm-Message-State: AOAM531/Uwo3ptaEoS1vY9XWoUsX9hDi3YVmKch1t4IXUsNMr1I8p6xI
        +hChFcu5iK3waCjw114RW+naeCstmog=
X-Google-Smtp-Source: ABdhPJwFm16xn5SlS58kUOvmkvSFamtrGpOs2Sd0ng893bmaBuQoE+vQ69s6NxYTjIPAundgvbpkyg==
X-Received: by 2002:a05:6808:1d1:: with SMTP id x17mr2040847oic.128.1628004549814;
        Tue, 03 Aug 2021 08:29:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m19sm2522622otp.55.2021.08.03.08.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:29:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Aug 2021 08:29:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 13/38] hwmon: Replace deprecated CPU-hotplug functions.
Message-ID: <20210803152908.GA288186@roeck-us.net>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <20210803141621.780504-14-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803141621.780504-14-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 04:15:56PM +0200, Sebastian Andrzej Siewior wrote:
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
> 
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 4 ++--
>  drivers/hwmon/fam15h_power.c   | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index f2221ca0aa7be..c3600266e0e91 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -228,9 +228,9 @@ static int i8k_smm(struct smm_regs *regs)
>  {
>  	int ret;
>  
> -	get_online_cpus();
> +	cpus_read_lock();
>  	ret = smp_call_on_cpu(0, i8k_smm_func, regs, true);
> -	put_online_cpus();
> +	cpus_read_unlock();
>  
>  	return ret;
>  }
> diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
> index 29f5fed28c2a7..521534d5c1e5f 100644
> --- a/drivers/hwmon/fam15h_power.c
> +++ b/drivers/hwmon/fam15h_power.c
> @@ -166,7 +166,7 @@ static int read_registers(struct fam15h_power_data *data)
>  
>  	memset(data->cu_on, 0, sizeof(int) * MAX_CUS);
>  
> -	get_online_cpus();
> +	cpus_read_lock();
>  
>  	/*
>  	 * Choose the first online core of each compute unit, and then
> @@ -190,7 +190,7 @@ static int read_registers(struct fam15h_power_data *data)
>  
>  	on_each_cpu_mask(mask, do_read_registers_on_cu, data, true);
>  
> -	put_online_cpus();
> +	cpus_read_unlock();
>  	free_cpumask_var(mask);
>  
>  	return 0;
