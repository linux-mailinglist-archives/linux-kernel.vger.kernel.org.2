Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99079407A6C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 22:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhIKUtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 16:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhIKUtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 16:49:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89BEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 13:48:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d21so355783wra.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 13:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QsPkA7p7sdQdIfIkmhLdCqpGJrgD9huIKl29qhcVh0Y=;
        b=PusUPNXotSVO5VZxgbMD+ct9ebdV6cn+dK4+nC8oRqsLFg1d7DkAXNaUN/drWYvVj7
         IiUh9QA6RpgQ0I8hcRxrXbGUXHaYlW2QbfOpukeGtzZ0sUYDltrh/0C4izT0R+AyVtFL
         G/AMchyLP0Eswq9T4L4NZEhBA4PxnVCTbaiV9X04pq+0WRbfB/X8+Rn7/M1JQATbEhHE
         9yFxonpjQVDfof9D53bm8qlXNVu/3788HpIYIUeOsAzk7+0Fi5WLpZtoTgrWOauUoC+4
         f1SdlGBvV2Qmju9zbtBRLZFk3WHtWeD9LY2x5v65Zrtsy6PVIX8pUqRs2gX+Z6XNxeG7
         ZUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QsPkA7p7sdQdIfIkmhLdCqpGJrgD9huIKl29qhcVh0Y=;
        b=q2X8age6kxyoyw4E1InLgatFIxuuYDjsTbpJft/d+0A3HMbJpaiYP8voyxkHGTIJaX
         ks7jiJzwefWCX2GEpuBeUNaHzYwbmICFORVHTCY3BuUcmryfanMzLhXFlTjNJeKvHt5u
         ESwzcZDpZ+83b5ibqtWZBXoEIcUy1dmkh/eQkdO+MfVHipVCpRbwGebla8q6PxhOhRel
         t4PFUfrzf+2wYE/Vz6SvBZPFnMamC5Mn6A93krEFRthDkaL7oQkx4SOeTNkSCSJmLNW1
         x23Ni9FigUJLBkgyRPDHOXUcaW9g4CVVmCn7+CtkYHqT//rzpEVCLfibcPkvrrX0TGi0
         RRCQ==
X-Gm-Message-State: AOAM533BlUlfHb/m+kee2DNPImzfaEnn3wGdXDtydFMfFZnsQVV/lrdc
        3tjYDrOYmv3b3vqIBIO8+dcNbmoTYYdg/Q==
X-Google-Smtp-Source: ABdhPJyJcoX6bdEnaefWT9rtAe8vSP7iMY5u8prOXdoEZQN7BySCOs/IEHDta4+x1RpbzX18lntlmw==
X-Received: by 2002:a5d:54cf:: with SMTP id x15mr4671031wrv.27.1631393316113;
        Sat, 11 Sep 2021 13:48:36 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d36c:3c0c:8588:75db? ([2a01:e34:ed2f:f020:d36c:3c0c:8588:75db])
        by smtp.googlemail.com with ESMTPSA id p6sm2546982wrq.47.2021.09.11.13.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 13:48:34 -0700 (PDT)
Subject: Re: [tip: smp/urgent] thermal: Replace deprecated CPU-hotplug
 functions.
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org
References: <20210803141621.780504-20-bigeasy@linutronix.de>
 <163131391331.25758.7108415411921343282.tip-bot2@tip-bot2>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <09f4310b-b485-e332-6fe4-bf71a9024ee1@linaro.org>
Date:   Sat, 11 Sep 2021 22:48:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <163131391331.25758.7108415411921343282.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have already this patch.

  -- Daniel

On 11/09/2021 00:45, tip-bot2 for Sebastian Andrzej Siewior wrote:
> The following commit has been merged into the smp/urgent branch of tip:
> 
> Commit-ID:     c122358ea1e510d3def876abb7872f1b2b7365c9
> Gitweb:        https://git.kernel.org/tip/c122358ea1e510d3def876abb7872f1b2b7365c9
> Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> AuthorDate:    Tue, 03 Aug 2021 16:16:02 +02:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Sat, 11 Sep 2021 00:41:21 +02:00
> 
> thermal: Replace deprecated CPU-hotplug functions.
> 
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
> 
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20210803141621.780504-20-bigeasy@linutronix.de
> 
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index b0eb5ec..a5b58ea 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -528,7 +528,7 @@ static int start_power_clamp(void)
>  
>  	set_target_ratio = clamp(set_target_ratio, 0U, MAX_TARGET_RATIO - 1);
>  	/* prevent cpu hotplug */
> -	get_online_cpus();
> +	cpus_read_lock();
>  
>  	/* prefer BSP */
>  	control_cpu = 0;
> @@ -542,7 +542,7 @@ static int start_power_clamp(void)
>  	for_each_online_cpu(cpu) {
>  		start_power_clamp_worker(cpu);
>  	}
> -	put_online_cpus();
> +	cpus_read_unlock();
>  
>  	return 0;
>  }
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
