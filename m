Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC041E56D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 02:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350706AbhJAAOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 20:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345765AbhJAAOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 20:14:50 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C9CC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 17:13:07 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 72so7596772qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 17:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNKKr9E1dVe3sE87atOo7bDCMgvAC5uMdOIVxSHldZI=;
        b=FMk2682Q3LfDJL6qfYd3sqNp4kR7efCRowAdIiyYpGqErUuRyLaLscC7UYBE/vKX50
         M0PlTaAuYt6pO7UsspmZMPRLkwJr0dVivYVpQUv02Gr1ByHo8eFKLrkv9tHEvzkLSGnA
         AmHO7uS8LMgJZScOwO+vfjZ9fNIeZVHIlq8gzBy1etaFXdLU08YhFNkKrEpQYaFvR5QP
         ty2Ms6R95h9JjFD+4KzDmtxTF1jrOVp2nYpl/NfEANs4Wp4EES+aieKHflJ/ejqpJKf7
         odr138CBqrY9sBShYQMHtyyfMWk6jjauhA3m7KvLI11Hjo/EjG8TSd11Q/bY40dV+2ty
         f1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNKKr9E1dVe3sE87atOo7bDCMgvAC5uMdOIVxSHldZI=;
        b=6pw0AIYbkEnU3F0Xn089ctpY3sZJoH1UQbx2DUskc6WjZTjzHa2GDUl/unzITGf4VX
         bwVIFMwsIiFigW47UtmHUcVA5uzX8a6TWeeLmjORTNM+LbyK+pe1Pakd6ygirK037gUz
         liWUECCu/bL8EruEnaaVUAc0BLMYP6VNtU6gs/vPer51RIHGVdC33fmbLtpUY1c0h925
         MSc+869R1G/4V/CaNIAaT+zKbmNSlID1Tu+DoXqrA/+mDAPMn/Syj36SwUUDMsyaWcSC
         fP/9UA0+DiboRguUegYllwAqmMfJK0ciNJ0wG9ViqYP5iAlKQR2HCu5TXH9PQrWgpoFe
         3G/A==
X-Gm-Message-State: AOAM533OFO+MWD2CjBO9EetPnqfyB7lBA+sa1ByxBEkb50o5kK0Ylqtl
        rJ0an7ujsm451Ncmla0n9nDe+FXpuoh1YbHWDS0L5Q==
X-Google-Smtp-Source: ABdhPJyNJfE7qMcISH4vQzi7Tu3ieEnqSZjsmlTjdanho9MUGhLMsonD73lCjAiQ9X9zJijPNz6q25+X2M9dXr2rZTg=
X-Received: by 2002:a37:a391:: with SMTP id m139mr7319292qke.186.1633047186236;
 Thu, 30 Sep 2021 17:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215300.60290-1-bjorn.andersson@linaro.org>
In-Reply-To: <20210930215300.60290-1-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 1 Oct 2021 03:12:55 +0300
Message-ID: <CAA8EJpo8+iEWdJU35mFWu6Dzpu-j_4vmHktrg_8pJhS2=8nYtw@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Disable firmware sysfs fallback
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, Robin Gong <yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2021 at 00:51, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> Part of the enablement of SDMA on the IMX platforms, '7f4e4afa140c
> ("arm64: defconfig: Enable SDMA on i.mx8mq/8mm")' also enabled
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK, to allow "firmware loaded by
> udev".
>
> Unfortunately having the fallback enabled does, due to the 60 second
> timeout, essentially requiring userspace to provide a firmware loader.
> But systemd dropped the support for this interface back in 2014 and
> because arm64 is the only architecture that has this enabled, there
> doesn't seem to be any standard solution available.

I tend to use the following 'standard' solution:

cat /lib/udev/rules.d/50-firmware.rules
# stub for immediately telling the kernel that userspace firmware loading
# failed; necessary to avoid long timeouts with CONFIG_FW_LOADER_USER_HELPER=y
SUBSYSTEM=="firmware", ACTION=="add", ATTR{loading}="-1"

> Examples of this problem can be found in e.g. the ath10k driver, which
> with a standard distro can take about 10 minutes before wlan0 appears.
>
> The alternative to this patch would be to change these drivers to use
> firmware_request_direct(), to avoid the sysfs fallback. But that would
> prevent other systems, such as Android, to rely on a userspace firmware
> loader to pick the firmware from a non-standard place, with just a
> custom defconfig.
>
> This patch therefor attempts to align the arm64 defconfig will all other
> architectures in the upstream kernel.
>
> Cc: Robin Gong <yibin.gong@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  arch/arm64/configs/defconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index da988a54bfb9..f9e0b3fdaf0b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -243,7 +243,6 @@ CONFIG_PCI_EPF_TEST=m
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_FW_LOADER_USER_HELPER=y
> -CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
>  CONFIG_HISILICON_LPC=y
>  CONFIG_SIMPLE_PM_BUS=y
>  CONFIG_FSL_MC_BUS=y
> --
> 2.29.2
>


-- 
With best wishes
Dmitry
