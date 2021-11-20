Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482C1457AF8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 04:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbhKTEAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbhKTEA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:00:26 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475D1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 19:57:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 137so6667997wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 19:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxYwFgP8QJkY0fxAaKGmN1e+xFo7sJTuqw6yMPGfDkU=;
        b=IK9SuPgNEEXpXn5eTloZtETIgJUVZCFMm5dY5FECGXFayp2QZE4sItiri8a9E3ZAwO
         w44k+4ShvTftu/4aHhItjEmF4SqykRKGl7KRMBTtE9mW9l3Y29TF2ZLaNrCHFjUuDWTU
         dpVb3ufS2FrPSIusaomI3+nEQX+1quVvFzdW+MswCGStMDsSD9Eg7/+XvdYNPTyvpbkS
         9pXy4UpmC+qIoBsu8dA1LHtUXwJhr49g5SLjtl7ZrEiicgWxM0fIcbAI0bXN42k/vgop
         Pea5vu4B32j+LaYtaFNdhTqwObs8SEMnmGvVceC/Lez4+Nefb/MdW6QRk0G5FXBCldUD
         yc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxYwFgP8QJkY0fxAaKGmN1e+xFo7sJTuqw6yMPGfDkU=;
        b=x1VNVNxdyK3mXrJKrapDBh5Meq950HG2i9rBK5phBB4qU/t3+gc7chVvgqqnM8tpWC
         OFL/weCl6efGQyZyxj0WIkCOQySGmhGQRgyD8OEkjURidoiiNa1nUczWGIevryWdQRc+
         1HJxX09NVsZy13NXWFY5giF94pLTrEivVKfD2OOA1vVeDYahoIJYB8l6Dhk5JUBWNGfB
         P1c7ZKmR3cx9BIiPYHQ8WcDIve0Og/qjs98p25YqnKB12pacYYdWuVlVlpVv7SNuwJhI
         TPn0huwbTgQnDO0mbIS3ESgM3uKS3KzD+1jb2sHzR/GyWpL2OfSNe96QT1Gx5d04Hnq9
         Q6Aw==
X-Gm-Message-State: AOAM5336e5piA0gJfb5vBKSOLC7ksBHbgyEaaD4jlK+F6ijFwipfRa0G
        +8wudkjCj1hCJI+UhA0y287Y6aLrwEZzcYU41I4/lg==
X-Google-Smtp-Source: ABdhPJyIb0xxDF6sP8Nm5V4J/JpeG+4+whciNZU5mV9yRjqVSK7mUHZ0qQPwxtG1jTQX1H5BGp23UGzUxdWfTn+fudI=
X-Received: by 2002:a7b:c194:: with SMTP id y20mr6680170wmi.61.1637380641708;
 Fri, 19 Nov 2021 19:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20211119164413.29052-1-palmer@rivosinc.com> <20211119164413.29052-3-palmer@rivosinc.com>
In-Reply-To: <20211119164413.29052-3-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 20 Nov 2021 09:27:09 +0530
Message-ID: <CAAhSdy1hx3Me_YCKnE=QkTaA9j-qyZjmgJDM8nT-uYCdg7vf=g@mail.gmail.com>
Subject: Re: [PATCH 02/12] RISC-V: MAXPHYSMEM_2GB doesn't depend on CMODEL_MEDLOW
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atish.patra@wdc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>, axboe@kernel.dk,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:14 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> For non-relocatable kernels we need to be able to link the kernel at
> approximately PAGE_OFFSET, thus requiring medany (as medlow requires the
> code to be linked within 2GiB of 0).  The inverse doesn't apply, though:
> since medany code can be linked anywhere it's fine to link it close to
> 0, so we can support the smaller memory config.
>
> Fixes: de5f4b8f634b ("RISC-V: Define MAXPHYSMEM_1GB only for RV32")
> Cc: stable@vger.kernel.org
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

>
> ---
>
> I found this when going through the savedefconfig diffs for the K210
> defconfigs.  I'm not entirely sure they're doing the right thing here
> (they should probably be setting CMODEL_LOW to take advantage of the
> better code generation), but I don't have any way to test those
> platforms so I don't want to change too much.
> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 821252b65f89..61f64512dcde 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -280,7 +280,7 @@ choice
>                 depends on 32BIT
>                 bool "1GiB"
>         config MAXPHYSMEM_2GB
> -               depends on 64BIT && CMODEL_MEDLOW
> +               depends on 64BIT
>                 bool "2GiB"
>         config MAXPHYSMEM_128GB
>                 depends on 64BIT && CMODEL_MEDANY
> --
> 2.32.0
>
