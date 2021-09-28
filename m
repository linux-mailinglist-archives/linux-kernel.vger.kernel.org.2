Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E541B00D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbhI1Nbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbhI1Nbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:31:31 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0047EC061604
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:29:51 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i13so23319917ilm.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KV5AEITggXzrcUqW0Pn0JDUCXvtzQQd7nfX6VcyNvh0=;
        b=gsEil9aJ5ZOw0ASchzCW/AY/NlZwbg7FdvHHAbffANcuyVgNVj8F3r/I3y/OyqwIbk
         QkY/gO8vfPAMQp75rG6vgEG7NkfLO4ZNSWbXrGEOjX3dKqow4MOof9p7GrAO13Ckl/VP
         f8/C6WiPIW+rxE9R7UiZnONtD/dro2yaem2kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KV5AEITggXzrcUqW0Pn0JDUCXvtzQQd7nfX6VcyNvh0=;
        b=Gtb7EGliz0SoHBnAdqnQ+AyW2C43OEqZrX6d2qZQf2glB0TmcfDl6KNXZ6TYsYI7lZ
         z+j9yz92Q/txX83tB+dS0LFZ9aww/EwUqCYGWSrxgrmeWc8uge1XmCyvbxD7QN8tzPTH
         +8cHy28XRZ5vxgk1EZYwhfZviCvYAJPXK5dEWVtYvWpbtLViB5Af/WyK/MVEJdiam0/r
         P/4ZftWIrCHMHMyk9H42jfzlQlFEy0s5CyVxWWVYqMdrCoJvzjsUzvhrv9OWUXk7cGst
         cmjoYpYjsLS3mMDmc2w7+u4PzSxE1KMB6ReqfIrnFqzLd/o66ggj98Y8j+LXjVe1KuOP
         5ASg==
X-Gm-Message-State: AOAM531MfCTDqAejeEsihVXdNPfAm55z/ZFvRtr6Gp/+25KqBCdCyb63
        lfhAmBC8AdafDqiyrnc29hMhCQ==
X-Google-Smtp-Source: ABdhPJz3qmL3tZ3U3XkVDcDl9dtP+yn06EspPEdsou0GIPYBieCdKEZlaSYFieS9Yrw1uFrX87cOuw==
X-Received: by 2002:a92:c744:: with SMTP id y4mr4108077ilp.288.1632835791399;
        Tue, 28 Sep 2021 06:29:51 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id m13sm11831997ilh.45.2021.09.28.06.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 06:29:50 -0700 (PDT)
Subject: Re: [PATCH 2/2] [v2] qcom_scm: hide Kconfig symbol
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        Kalle Valo <kvalo@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joerg Roedel <joro@8bytes.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alex Elder <elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        netdev@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20210928075216.4193128-1-arnd@kernel.org>
 <20210928075216.4193128-2-arnd@kernel.org>
From:   Alex Elder <elder@ieee.org>
Message-ID: <19bbc40d-3f13-7e9d-72c0-5d206b016bb7@ieee.org>
Date:   Tue, 28 Sep 2021 08:29:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210928075216.4193128-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 2:50 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Now that SCM can be a loadable module, we have to add another
> dependency to avoid link failures when ipa or adreno-gpu are
> built-in:
> 
> aarch64-linux-ld: drivers/net/ipa/ipa_main.o: in function `ipa_probe':
> ipa_main.c:(.text+0xfc4): undefined reference to `qcom_scm_is_available'
> 
> ld.lld: error: undefined symbol: qcom_scm_is_available
>>>> referenced by adreno_gpu.c
>>>>                gpu/drm/msm/adreno/adreno_gpu.o:(adreno_zap_shader_load) in archive drivers/built-in.a
> 
> This can happen when CONFIG_ARCH_QCOM is disabled and we don't select
> QCOM_MDT_LOADER, but some other module selects QCOM_SCM. Ideally we'd
> use a similar dependency here to what we have for QCOM_RPROC_COMMON,
> but that causes dependency loops from other things selecting QCOM_SCM.
> 
> This appears to be an endless problem, so try something different this
> time:
> 
>   - CONFIG_QCOM_SCM becomes a hidden symbol that nothing 'depends on'
>     but that is simply selected by all of its users
> 
>   - All the stubs in include/linux/qcom_scm.h can go away
> 
>   - arm-smccc.h needs to provide a stub for __arm_smccc_smc() to
>     allow compile-testing QCOM_SCM on all architectures.
> 
>   - To avoid a circular dependency chain involving RESET_CONTROLLER
>     and PINCTRL_SUNXI, drop the 'select RESET_CONTROLLER' statement.
>     According to my testing this still builds fine, and the QCOM
>     platform selects this symbol already.
> 
> Acked-by: Kalle Valo <kvalo@codeaurora.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes in v2:
>    - drop the 'select RESET_CONTROLLER' line, rather than adding
>      more of the same
> ---
>   drivers/firmware/Kconfig                |  5 +-
>   drivers/gpu/drm/msm/Kconfig             |  4 +-
>   drivers/iommu/Kconfig                   |  2 +-
>   drivers/media/platform/Kconfig          |  2 +-
>   drivers/mmc/host/Kconfig                |  2 +-
>   drivers/net/ipa/Kconfig                 |  1 +

For drivers/net/ipa/Kconfig, looks good to me.
Nice simplification.

Acked-by: Alex Elder <elder@linaro.org>

>   drivers/net/wireless/ath/ath10k/Kconfig |  2 +-
>   drivers/pinctrl/qcom/Kconfig            |  3 +-
>   include/linux/arm-smccc.h               | 10 ++++
>   include/linux/qcom_scm.h                | 71 -------------------------
>   10 files changed, 20 insertions(+), 82 deletions(-)
> 

. . .
