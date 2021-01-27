Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DBA305BDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbhA0Mpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbhA0M14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:27:56 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A1DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 04:27:16 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q131so1080823pfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 04:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X8Y03bu49J/8z/b5VQ/tq5hDCio2gSq+A4AEUVaOxBA=;
        b=ItSCf3HQRNHqDt++Opr117nlJknLUPYbHU0N29vC0QSnHpK2+WD4WhwcYmQamTvSx8
         fM5dSOHGwjuiqRDu1IOwrTM/cZDh35FSaHLckf5jXtqyIxVyyX6aJourxzhLuQhKgOgq
         AmWEVHIiguXyTvaGJMH3DKvsYiHnVJCK4Qk67FU1bQb/P5BgxVTWbN1ZaTC12uOTKh1Z
         Do8BAxRCsCjvZ8TuBmsEMMZh76bcRxb5iWfX/dQo7Sth5SWiYwR6IhRc3yZqdFxnTYw2
         oUDH1JCFATJv8iy4LBeMRzZP1wCKIW0ymfkxpgJ0LMWk/j9XLvEwEsfx5ha2kTJvnRQN
         Agrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X8Y03bu49J/8z/b5VQ/tq5hDCio2gSq+A4AEUVaOxBA=;
        b=eVvBF24jaZ2ibsVNXYbFBm68FW8mWI7oe087FNsg6TC/bbDYxDneLUyzPMQjbqMKet
         1SFrwMM0MT3/peYFxhlVlPjRcl2BOjZL8MT6h60YNCELSYcyiNkQ8rrfLiqJLdCOo4rF
         Swhww6KYv09YuLOJVr4n1hFvJZ7F7gpX///97FxW/Uvz23vAf9efZjFDlW2MPD1Jows1
         rfGXIDIZ7+8Aw1l5YHeboIlwDLhEesST+fDJ7KQkdBhPR7o/BRRTTC9Kxhdo7U3acX2S
         jflpJCXL9T1m/SHVjp50+R4xj64gD/dHdrQvXsF0YsMS5AdTn3jaQ5Mmzn7NKItERoMt
         cxkw==
X-Gm-Message-State: AOAM530Ofk4/YmdNYIr0oKw36fv+178tYt0Mx0VQB34WfFJEA/SKd2u8
        wTFuiUcP9HzMhZ0hq5+91O4=
X-Google-Smtp-Source: ABdhPJx7b2WJqZNWKnmQrPGC0g+Oa+Dcml8KS5cDMPqzBe77bhaijCbu0AHRvk6SSijMJuKJCDYsSw==
X-Received: by 2002:a62:2984:0:b029:1b4:72bd:f2bf with SMTP id p126-20020a6229840000b02901b472bdf2bfmr10316931pfp.59.1611750436146;
        Wed, 27 Jan 2021 04:27:16 -0800 (PST)
Received: from localhost (g54.222-224-210.ppp.wakwak.ne.jp. [222.224.210.54])
        by smtp.gmail.com with ESMTPSA id s21sm2146513pjz.13.2021.01.27.04.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 04:27:15 -0800 (PST)
Date:   Wed, 27 Jan 2021 21:27:12 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: litex: Properly depend on HAS_IOMEM
Message-ID: <20210127122712.GU2002709@lianli.shorne-pla.net>
References: <20210127033603.1519127-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127033603.1519127-1-davidgow@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 07:36:04PM -0800, David Gow wrote:
> The LiteX SOC controller driver makes use of IOMEM functions like
> devm_platform_ioremap_resource(), which are only available if
> CONFIG_HAS_IOMEM is defined.
> 
> This causes the driver not to be enable under make ARCH=um allyesconfig,
> even though it won't build.

Is this wording correct?  I suspect it causes to driver TO BE enabled.

> 
> By adding a dependency on HAS_IOMEM, the driver will not be enabled on
> architectures which don't support it.
> 
> Fixes: 22447a99c97e ("drivers/soc/litex: add LiteX SoC Controller driver")
> Signed-off-by: David Gow <davidgow@google.com>a

This looks ok to me.  I can queue it for 5.11 fixes, if you can help with the
wording above.

-Stafford

> ---
>  drivers/soc/litex/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> index 7c6b009b6f6c..7a7c38282e11 100644
> --- a/drivers/soc/litex/Kconfig
> +++ b/drivers/soc/litex/Kconfig
> @@ -8,6 +8,7 @@ config LITEX
>  config LITEX_SOC_CONTROLLER
>  	tristate "Enable LiteX SoC Controller driver"
>  	depends on OF || COMPILE_TEST
> +	depends on HAS_IOMEM
>  	select LITEX
>  	help
>  	  This option enables the SoC Controller Driver which verifies
> -- 
> 2.30.0.280.ga3ce27912f-goog
> 
