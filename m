Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516573098BC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhA3XDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 18:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhA3XDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:03:54 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD1EC061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 15:03:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id md11so8150470pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 15:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+zVe5wqUAoeHSpi/8FrWkSqWDUIAFS7adbUJ7KyJwOs=;
        b=U4Kw3ocFKFFv8Q9KIfoH9uocdxLx107zMK7QOauzgcRhMneSkbCa/a9+wpHjB4Tun9
         JkQmbb5RgH205vjLc79hmK6EGKTLnA6hf9vtE7hn/MV3f/1fv5QBs2ZDf5FhJmPj/Ea5
         y89gcdaSTuP/Qu3urZYWBwnFWWS84/QAC7Ch2/x3AICljUUT0S9h4TzCVLQ3nbZbRKwp
         OoOVpjWEsBQxr0hMIjyY2Eq7dcv351Us1ddQ1+wHKE5G5bBYqkaadwlj76R8WyVqkGp8
         Q2wWmKOQem1H40nleZ5lVhpBFDJuBr5i4QDjS8C1itd/Fk2Rym0pNBpyFnGo3aPVw8v0
         1AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+zVe5wqUAoeHSpi/8FrWkSqWDUIAFS7adbUJ7KyJwOs=;
        b=KDYpjRogrtQwu1M4Qd13ZrRcAbcQhnzFRkreC9rQN7ZLccYhPaaDx+pEe7GbC11BbZ
         HGEIL+3X5O9zkcNURpkjXbGMZLaufaG+KNeN1YnURP8q9y7hLssXCDpHjnNxAWunuRze
         XuSmAmir2rWLtOlhCIeQnXl8MFbxub7WCxSqVoP5q3CFn6BKj6xm4YywVuxtZKyaPh0S
         sBLXGs5WukWAWCUApE2bonMr4ksShpZ4paouqamHC44m/UQi7KLcNCRQH2xD8KXEjdG5
         yhXfiPOcdZ8ackGeLz6YMu1OGni7MrKccOlYgGimEZLIrRhMKZ4/38enLGJ63sVVRFjx
         1x4g==
X-Gm-Message-State: AOAM532U4d6BeZ0xUZtc/lPVKzjuMutPNVe5nCGfFBToVmODIo8PDaG/
        BJQ0yDhs2QxaMCnJ2o3dEVI=
X-Google-Smtp-Source: ABdhPJymKHYEMfkIJnur+rUhtefwj6MfpiCTIeIe73hTaSr4WwImKbL9BALaTAvEycTwDV0EVvc7og==
X-Received: by 2002:a17:902:854b:b029:db:c725:edcd with SMTP id d11-20020a170902854bb02900dbc725edcdmr11362398plo.64.1612047793286;
        Sat, 30 Jan 2021 15:03:13 -0800 (PST)
Received: from localhost (g54.222-224-210.ppp.wakwak.ne.jp. [222.224.210.54])
        by smtp.gmail.com with ESMTPSA id 197sm12862257pgg.43.2021.01.30.15.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:03:12 -0800 (PST)
Date:   Sun, 31 Jan 2021 08:03:10 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>,
        g@lianli.shorne-pla.net
Cc:     geert@linux-m68k.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: use device tree to determine present cpus
Message-ID: <20210130230310.GC2002709@lianli.shorne-pla.net>
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net>
 <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 12:00:10PM +0100, Jan Henrik Weinstock wrote:
> Hi Stafford, Geert,
> 
> thanks for your feedback. I have made the following changes to the patch:

Hi, Thanks for the updates.

> 1. use for_each_of_cpu_node
> 2. possible_cpus is now what is in the devicetree, up to NR_CPUS
> 3. present_cpus is now all possible cpus, up to max_cpus

This looks good, one small comment below.  Can you send the next patch as a v2?

Using 'git format-patch -v2 ...'

> Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
> ---
You can include the 'Changes since v1' in the space here after '---'.

>  arch/openrisc/kernel/smp.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
> index 29c82ef2e..83cbf43d4 100644
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
> @@ -60,22 +61,32 @@ void __init smp_prepare_boot_cpu(void)
> 
>  void __init smp_init_cpus(void)
>  {
> -	int i;
> +	struct device_node* cpu;
> +	u32 cpu_id;
> 
> -	for (i = 0; i < NR_CPUS; i++)
> -		set_cpu_possible(i, true);
> +	for_each_of_cpu_node(cpu) {
> +		if (of_property_read_u32(cpu, "reg", &cpu_id)) {
> +			pr_warn("%s missing reg property", cpu->full_name);
> +			continue;
> +		}
> +
> +		if (cpu_id < NR_CPUS)

Should we warn on the else case?

> +			set_cpu_possible(cpu_id, true);
> +	}
>  }

-Stafford
