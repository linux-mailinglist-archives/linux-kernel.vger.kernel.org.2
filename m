Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E63420619
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhJDHAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 03:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhJDHA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 03:00:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF3CC061746
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 23:58:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n2so10411732plk.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 23:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7NQLC0CBpzZQKLFn2CPvxGDT2PispmvfZ9mt7LCx8S8=;
        b=Q5lozMPfGyLnq8Ai11eVCshTt5a6HMdyat3eZQVrjDX9SMe9oG2EGPxgBBTgJ5qO9o
         N/j0Ilrbm2dTYwe/VB93l8dhQeeh1yxmYt4p6CtdUS1rBBQvY7Sp/9ZJ4FGwSyqmYr60
         I4373XXYJfHaEuNfgXk7JW8nsH4PBQUFN2N5UTYMv2zlJ90NHKthZe3yYDbi0nwIToVq
         Z2kAASGfcS7YxGUqo6bQkD38OpsaeujCQQJXeG33kBpWUJFjZ55o9NpAZpFlIvQ+Wa1m
         dhovIWOEwwujjSFL+gh1snubCZMVIMdmHKZqh7lsxTrK/uc1ZmIQR6jikJtVAZfzIgku
         8j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7NQLC0CBpzZQKLFn2CPvxGDT2PispmvfZ9mt7LCx8S8=;
        b=FHMEQyTU3XWnoRaz4yfN3Cm+0CuaHiO/Xvxd5gxVkSc5Je3SNESmFIz3To2dBleuvO
         a5wtLPq8KXSEOmADYWJOPcYrMGsaHFyo4B18U2tLWZxmY03G5WQXX1NobezS81i6Nf82
         Bg788n6alJzH5eqs3j8bh8UkVvJCsGFtEl8uTEDu1Rfvn/34KWPi3vGO5fKjI+5QPAMb
         N7fJGdH6LZK4TMiYHFzKnrvWZo87OHeOcQQOh7/Bc4dHpZxGSnfs/1Xo5DRAhXQ8H1zu
         bpPi0UkgshKzIH4oKihjZaUa4jEV9dAyhcUIaJJ5o036a8BLNFdToujZbkVMgH5YooRl
         uEKw==
X-Gm-Message-State: AOAM533Tm5U//QsVFm2tUUUTjQAPzs3dxZFQjSQbCwPe6Kq2u3PmeB0T
        h9InSJ6pYyZ0KbDiKYKsYeMS6g==
X-Google-Smtp-Source: ABdhPJzk9QfzO3wNBh8AzygDT3L+GhgGCcTyNWzVv0y7ygMcryg2CKHlzsdMyZ+52INja1eTFBaQfw==
X-Received: by 2002:a17:902:eccf:b0:13e:b002:d8bd with SMTP id a15-20020a170902eccf00b0013eb002d8bdmr6838260plh.48.1633330720209;
        Sun, 03 Oct 2021 23:58:40 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id t8sm8696202pgv.35.2021.10.03.23.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 23:58:39 -0700 (PDT)
Date:   Mon, 4 Oct 2021 12:28:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Han Wang <zjuwanghan@outlook.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: remove useless INIT_LIST_HEAD()
Message-ID: <20211004065837.nmymvhowjz3zuilu@vireshk-i7>
References: <MN2PR10MB40938AC3AE715AD1E6B9A008C1FC9@MN2PR10MB4093.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR10MB40938AC3AE715AD1E6B9A008C1FC9@MN2PR10MB4093.namprd10.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-08-21, 21:07, Han Wang wrote:
> list cpu_data_list has been inited staticly through LIST_HEAD,
> so there's no need to call another INIT_LIST_HEAD. Simply remove
> it from cppc_cpufreq_init.
> 
> Signed-off-by: Han Wang <zjuwanghan@outlook.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index d4c27022b..db1719626 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -741,8 +741,6 @@ static int __init cppc_cpufreq_init(void)
>  	if ((acpi_disabled) || !acpi_cpc_valid())
>  		return -ENODEV;
>  
> -	INIT_LIST_HEAD(&cpu_data_list);
> -
>  	cppc_check_hisi_workaround();
>  	cppc_freq_invariance_init();

Applied. Thanks.

-- 
viresh
