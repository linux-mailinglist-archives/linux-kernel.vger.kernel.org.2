Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DC6429C05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 05:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhJLDjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhJLDjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:39:43 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDDDC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:37:42 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id o4so27267128oia.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 20:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FtLkSkVAYhsPc8Rq+dauKVudCH1RLV1aHMuOFMgfWuo=;
        b=dzvPIu2mAgCzGy3tZwFp0fRu7qEpGudIjyDU5DKg0+TqPjxYWD8lh77ZDOc4OwATLH
         oz1ecpQq0qOw0V4iyLCuneDSLZ29YUmCEBVVcxK0K8Mrw98jMEQpTeu1xCSICuemPkC3
         XcOa+FDr4SDpxb6ZqB7PKRJZQjRzmcQplCdvzNbWjNDSrzmkdrRqC3sXSwR9fRrrmzDL
         xnWYZska7gaGJ/KAp0eIYI88cA8PQq8K94+g7yuAzjlUF/wo9ZyXcQ78ncuTfPhEV2Jj
         EXysmsEJf/eImb7Qa5UqT+gXBRzLetIICYFT9ZATy0Ye1fCU6/IysLrD0j7kdOPoqm3C
         X1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FtLkSkVAYhsPc8Rq+dauKVudCH1RLV1aHMuOFMgfWuo=;
        b=KCj/ZehN6urhx8gc3NFfYO4ehxNwMgM8TKaqgdVVX58P+eLVceHydeo+QTtzFbymcY
         eNuTpIviZhkkhaJD4jGJ/rdvFm44YwQgZevTRinWcYPpqnlX6EsbNDRCAfer/KnlZxIj
         pQdD3EiM2z762lT2vA0K54hbaR3ouxYtNuaq9rKcQyAZ4yRfpkY3u0rT1F4QSrQW4ltC
         vTt1UHdd6Y1ijap3I42of91KjXC4XjZ1J03h77h0WuXW7PI1SK8kjErXOUKJLw9nI1gF
         ZSkwAgsSU3xpv7goOGnZCMAO0XbxRKcthN/dPDZ+sAcSgFurw3y8l1hmcZHweDhskkBp
         7zUw==
X-Gm-Message-State: AOAM530hSYkRI9OXKb8/FMGtkaD7xIcgzn1LxuwIrWiwCLeil0mW1FIU
        CcIXFplueNiaOoEPru7FkcT7Bg==
X-Google-Smtp-Source: ABdhPJxC9DBiOjMeGyWGMjU/WJX4hSrIELrjla16tBIjWuYGxRUCWqUExaSQVo837XUDkQmgcPekJQ==
X-Received: by 2002:aca:d78b:: with SMTP id o133mr1971572oig.136.1634009861778;
        Mon, 11 Oct 2021 20:37:41 -0700 (PDT)
Received: from yoga ([2600:1700:a0:3dc8:c84c:8eff:fe1e:256f])
        by smtp.gmail.com with ESMTPSA id 21sm2133694oix.1.2021.10.11.20.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 20:37:41 -0700 (PDT)
Date:   Mon, 11 Oct 2021 22:37:38 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Amit Pundir <amit.pundir@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [RFC][PATCH] iommu: Kconfig: Fix missing config option for
 CONFIG_ARM_SMMU_QCOM
Message-ID: <YWUDAoDoPPewqcdO@yoga>
References: <20211012032633.4169364-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012032633.4169364-1-john.stultz@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 Oct 22:26 CDT 2021, John Stultz wrote:

> In commit 424953cf3c665 ("qcom_scm: hide Kconfig symbol"), some
> logic was added to make the code depend on CONFIG_ARM_SMMU_QCOM,
> however no such option exist.
> 
> This caused regressions on db845c (and I suspect other qcom
> platforms), but can be easily fixed up by adding a new option
> to re-enable the newly conditionalized code.
> 
> I set it to default to ARCH_QCOM, so folks don't have to
> discover this new option to keep things booting, but if folks
> would rather, I'm ok to drop that line.
> 

I've not looked where the discussion went, but Dmitry posted this end of
last week:

https://lore.kernel.org/linux-arm-msm/20211010023350.978638-1-dmitry.baryshkov@linaro.org/

Regards,
Bjorn

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
> Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>
> Fixes: 424953cf3c665 ("qcom_scm: hide Kconfig symbol")
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/iommu/Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c5c71b7ab7e83..e674796b1174d 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -380,6 +380,16 @@ config ARM_SMMU_V3_SVA
>  	  Say Y here if your system supports SVA extensions such as PCIe PASID
>  	  and PRI.
>  
> +config ARM_SMMU_QCOM
> +	bool "QCOM Specific ARM SMMU implementation support"
> +	depends on ARM_SMMU
> +	default ARCH_QCOM
> +	help
> +          Support for the QCOM implementation of the ARM System MMU architecture.
> +
> +          Say Y here if your SoC includes an QCOM IOMMU device implementing
> +          the ARM SMMU architecture.
> +
>  config S390_IOMMU
>  	def_bool y if S390 && PCI
>  	depends on S390 && PCI
> -- 
> 2.25.1
> 
