Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C700308FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 23:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhA2WRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 17:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbhA2WR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:17:27 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D58AC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 14:16:47 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id h15so6093336pli.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 14:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KRdVj8aDHVVWjYR6nci89gkQtpmD5ypYkI2gm5mcuf4=;
        b=Pw7iqrICxBPTIMPeUWRHhbCw5REf5ZKOgix+DO/BQJK7JhhzhxFa5JfSMWTjcQfpGd
         QwW8D2wrNIir8wvWk80dTmyR6T/JtvzhL7EmZvg8+4WR4hUwk1HQEkigD1GyzUKvJvvJ
         KW6gZFbYAIx0JbKeR8yk7E+NcUOGmo0d3+U5sR9oZG3yoygvvN6sogM6vfSN5VJZ6HxD
         o5+dd/GVAlobFtKFqf5n5YDpqDwCdyHXteN1WmksawHnXjctR8YcLX4ws2jhS0M87TrV
         uZNQr9oCuNv6uToQElt5rmm339VizL0H7h/OD9vqTzKd/yuQwaqgMT8UALxmEeVRSv+8
         VAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KRdVj8aDHVVWjYR6nci89gkQtpmD5ypYkI2gm5mcuf4=;
        b=E8ZlRk3RcUTskzRWEGKM305/1jy3IDO86R0f8d2QdZzFauU1evTSFeLkJsXMU8DKB6
         BzcK+RpOHKM9oY4jxeW8w9AidOZHkbK0iSPHkWO7GPJJrmwqePzvX3OrOOwUD48rBind
         udck8sGR0dzt3jCiKthFi3O3kELHArkGPIxBsgSWVevRoyRMrg4lI5rNxDgPTAowf5cX
         hyPL5j4NyEsZMrS0KhNVsc/BV3p7YmgM7pNm2bLtQQPWy0TdozFjGhTATpbdcZHIKJQ0
         Cl3PcxFyDyAUOxAg3hTkhhEfGPFBzNRGAVMBJRDaZNlh/eY/K+/huVJC9XwfaJBu80bZ
         X35Q==
X-Gm-Message-State: AOAM532v4/+jAAMN0x6LK0XssnO5ettOFKBzrCN0kXWiC/TgcQsAOBj1
        /39kxPGCsmE+OSG9GWjmFGs=
X-Google-Smtp-Source: ABdhPJz91JOpUKxsFKCybaYKoGDzZ4Q6GylJHaJD3+kia44hVpbDtI3Ew7wt8R9csq+W1O1fe3CO5g==
X-Received: by 2002:a17:903:228a:b029:da:d645:ab58 with SMTP id b10-20020a170903228ab02900dad645ab58mr6516799plh.25.1611958606857;
        Fri, 29 Jan 2021 14:16:46 -0800 (PST)
Received: from localhost (g54.222-224-210.ppp.wakwak.ne.jp. [222.224.210.54])
        by smtp.gmail.com with ESMTPSA id 101sm8596927pjo.38.2021.01.29.14.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:16:46 -0800 (PST)
Date:   Sat, 30 Jan 2021 07:16:43 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
Cc:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: use device tree to determine present cpus
Message-ID: <20210129221643.GZ2002709@lianli.shorne-pla.net>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 07:29:31PM +0100, Jan Henrik Weinstock wrote:
> This patch proposes to use the device tree to determine the present cpus
> instead of assuming all CONFIG_NRCPUS are actually present in the system.
> 
> Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
> ---
>  arch/openrisc/kernel/smp.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
> index 29c82ef2e..75be7e34f 100644
> --- a/arch/openrisc/kernel/smp.c
> +++ b/arch/openrisc/kernel/smp.c
> @@ -16,6 +16,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/mm.h>
>  #include <linux/irq.h>
> +#include <linux/of.h>
>  #include <asm/cpuinfo.h>
>  #include <asm/mmu_context.h>
>  #include <asm/tlbflush.h>
> @@ -68,14 +69,25 @@ void __init smp_init_cpus(void)
> 
>  void __init smp_prepare_cpus(unsigned int max_cpus)
>  {
> -	int i;
> +	u32 cpu_id;
> +	struct device_node *cpu, *cpus;
> 
>  	/*
>  	 * Initialise the present map, which describes the set of CPUs
>  	 * actually populated at the present time.
>  	 */
> -	for (i = 0; i < max_cpus; i++)
> -		set_cpu_present(i, true);
> +	cpus = of_find_node_by_path("/cpus");
> +	for_each_child_of_node(cpus, cpu) {
> +		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
> +			pr_warn("%s missing reg property", cpu->full_name);
> +			continue;
> +		}
> +
> +		if (cpu_id >= max_cpus)
> +			continue;
> +
> +		set_cpu_present(cpu_id, true);
> +	}

Hello, I looked into what other architectures do.  Risc-V does something similar
but it does the setup in 2 parts:

 - it uses the device tree to set possible CPU's in setup_smp. Using
   for_each_of_cpu_node and set_cpu_possible.

 - Then in smp_prepare_cpus, it loops over possible cpus with
   for_each_possible_cpu.

Note, it seems risc-v does't actually check max_cpus when setting
set_cpu_present which may be a bug.

I think the two part approach is what we want to do:

 - we should do set_cpu_possible in smp_init_cpus based on device tree.
   Basically the same as your loop above but using for_each_of_cpu_node
   and NR_CPUS.
 - we can then do set_cpu_present using for_each_possible_cpu in
   smp_prepare_cpus.

What do you think?

-Stafford

>  }
> 
>  void __init smp_cpus_done(unsigned int max_cpus)
> -- 
> 2.17.1
> 


