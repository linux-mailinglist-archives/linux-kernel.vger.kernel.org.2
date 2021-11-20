Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87A6457B01
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbhKTEDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbhKTEDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:03:41 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCB2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:00:39 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso9000339wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zl6Pig05elwyO5r1ax9J/GdJ0w+BvbTSAW2OuBArtBQ=;
        b=2aPdlcfFN+wF7dwAdKi8GVrae1mCaS5eqDbMwpsFS5WCYmbY+OilREe4TvvxFrICW1
         0YxbMIvP0/DH5rsPlJP1cl7ZGUzrLOSRDqpZLf7f44Njlr3mdNSBajj6w8B91VSwKGpM
         +m3XRWtCd6BVxSTqTBpejvqOgz+qh+7XdeivN+YNp5k4TYiXsNRxM/gohVfyehH9bs1H
         mLl/ml9XTXWPeHzlAUY0nLi3YKYwSDNIfyAfX6hIZyjLgsO4FC0aiWiB0PgZr7XcW8qJ
         Qcbnqx9g8X6YokUrohHsOX+iihPKCW4E8FfCCrX2ACkCjuK+aumzcw3oIaFZGj1xcMVS
         f7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zl6Pig05elwyO5r1ax9J/GdJ0w+BvbTSAW2OuBArtBQ=;
        b=vsj0rzzgU8mzF4EGsg2KkwZmRDwoRKrpzBZbbAk2LevahUKA25/SKRWUKfnSg2u8jc
         bdHcR3ZkbJbvO565QI5+msAhMS4XpEs0T6odRrvoUvCNDYGpofuHtaDscgg5k/3YaSUs
         FEYjS7GP3UVn8mBAnHn7s8ZlhMgGuhhJnjAZM7f8zBQXAstfPQoRhtk4ejPgtwXkbS1a
         LK5aP4fI7fZ7iFdF4ecQBz2wzb4zm2zRbop9vkJGbn0YI6dXd7dSxg3C5q6PsfDcaMsI
         KJMzmxbgrvy8YBs6AjHCJfHlN57FWz+dLktgBgnU/BznlLR0YWhm9pvqBe0slZoNEYu5
         2iCQ==
X-Gm-Message-State: AOAM530flVp6NyPtpwdR4AOZIALCr6m/LcCBHhXM9GBsLMsVcYaw8p9+
        +m6xyeA8JESNWTLGflOKhNqcmoP+pPcT9Ykx+Uio1Q==
X-Google-Smtp-Source: ABdhPJySltLtO3M/kXj+giqHrhsUASVyBaIBSjpZTyiXMPz1K7pwMYq1zlVFyCbSmg1D+3FKXp8US90j+MfG10W5U20=
X-Received: by 2002:a05:600c:354f:: with SMTP id i15mr6297591wmq.59.1637380837533;
 Fri, 19 Nov 2021 20:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20211119164413.29052-1-palmer@rivosinc.com> <20211119164413.29052-7-palmer@rivosinc.com>
In-Reply-To: <20211119164413.29052-7-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 20 Nov 2021 09:30:26 +0530
Message-ID: <CAAhSdy3tez4x8L_bqQXr_76T=o+Ve_RmENTjv1ZTr3AWY2VwHA@mail.gmail.com>
Subject: Re: [PATCH 06/12] RISC-V: defconfigs: Sort CONFIG_PTP_1588_CLOCK
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Bin Meng <bin.meng@windriver.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>, axboe@kernel.dk,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:15 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> This should have no functional change, it just sorts
> CONFIG_PTP_1588_CLOCK the same way savedefconfig does.  This only
> touches the rv64 defconfig because rv32_defconfig was already sorted
> correctly.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 0f4fe5790fb5..fa9017c60b3d 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -71,9 +71,9 @@ CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y
>  CONFIG_SPI=y
>  CONFIG_SPI_SIFIVE=y
> +# CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_GPIOLIB=y
>  CONFIG_GPIO_SIFIVE=y
> -# CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_POWER_RESET=y
>  CONFIG_DRM=m
>  CONFIG_DRM_RADEON=m
> --
> 2.32.0
>
