Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AA23ECD62
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 05:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhHPD5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 23:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhHPD5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:57:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9CC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 20:56:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso30312548pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 20:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gvadNFsaIgiABi8nyMBbFkuOLcKZzzS4U0y+leheTts=;
        b=D3LBC/f7rLT/rYcd64sHfY2FxurZfCEchbKE1/eaOJoe56mPSZR6h4tMljq0sps0Vz
         9DVWOygVK3kYhbEKlj4wLVtfalocgqzbrBgmb4n3WTCVr86Ee2V4c02AglGaljZ7ggn4
         SfL7Dx5/oqoBaok6i5IR7r5IKmT5ReKuxJ37cJI+emvEewXNTiF+cHwXsNvjyX10USlP
         fuMZ1fVPpT6q6tzs5mOMTL3FlrTewkOLWrp+IgRofYHoYLbwTX78HKhzFk+qH+wX9Fiu
         D9fnhEAV+uJ1v1EU/3QHVBIAo2CkQuTH3nB7YEekEveQpxda77iCUd2dW+zB3pgNQcj1
         xeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gvadNFsaIgiABi8nyMBbFkuOLcKZzzS4U0y+leheTts=;
        b=lVNQERT1NfzM/LkvNqIIIXU2hA54jewWQ0TYr6W93VdO04uRVnTsD4DO5dzzFd7KQC
         nmkQEV8wW4r9HVrfdaIzX9/IozLXLgVzMhl1+uJOQqV6krHytJKmc6o5FOzNUnaN/fVU
         rrACv1Yq4aUayoW2CwsGqxWpjpzzZlXc6lM8BS6yu7Q/u/RGoPZ+X2Qsfocc8X5oAbOv
         R68Vhj4QmEmFhIjk48zTk60D1tYp2rTOrxzcEkiYHdSEW7CuxjRCMw+uNL6HlkgLTCXT
         Wlob0AnEjeBk25Vvj7dWKklThcpt2PpAM/VQtjphxx4WnRfBgfyVyk8SxgVnL/UiJIvt
         nZcA==
X-Gm-Message-State: AOAM531jF3/agUujneCSIDIXJ1kKWs+9pIm60O4/MqmVOmUnGTr4tFfP
        5uqGm+MKuKIyCTnnvBzR+2loUg==
X-Google-Smtp-Source: ABdhPJygh9jXEiS0xdOBLk5UuvT6xq7WGsOYJdmMaiIxfbP0KxCMQKNoFrdlvlUg54QU99ndALix5Q==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr12814656pgi.24.1629086207454;
        Sun, 15 Aug 2021 20:56:47 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id t18sm9400997pfg.111.2021.08.15.20.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 20:56:47 -0700 (PDT)
Date:   Mon, 16 Aug 2021 09:26:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Han Wang <zjuwanghan@outlook.com>, ionela.voinescu@arm.com
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: remove useless INIT_LIST_HEAD()
Message-ID: <20210816035644.b5y45yldxsi6nrgh@vireshk-i7>
References: <MN2PR10MB40938AC3AE715AD1E6B9A008C1FC9@MN2PR10MB4093.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR10MB40938AC3AE715AD1E6B9A008C1FC9@MN2PR10MB4093.namprd10.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Ionela who added this.

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
>  
> -- 
> 2.25.1

-- 
viresh
