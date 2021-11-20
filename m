Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A821457AFF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 04:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbhKTEC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhKTEC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:02:57 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA57AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 19:59:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso11974444wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 19:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KW2fH/dOJNfVmUh3I46vnrHPpkzt1L5iGQVTotVhc4=;
        b=vs6jyKbTyTloAogTFd0AecQgVlh0D9IhsDmJL7f9Pbu4b9ldCWk1LsmkdRb4+B7HFf
         /VV64azkeZr+01wtD/S09RPRyLCesZhBIcJxKBWqThbwKQ083x/yVpkJCxAyMBZnoTqS
         8p1zoZtvhWGUyFWMCLriFgv0VYGaBJKs9fCUy474Tmgu7Cx50OIUVdHeUIjBZJdMF8FK
         T21cfmqynuD+LokID/GxSg3hvMs4OUCB/ffKGIeIO0wjw0lEKNosjBw/yfccnIzsMFeM
         9PhY7oZxiqct4JuukkVx9c0CSdR3ExrWXJO+41VR0pyYba/mOQTfcjpKkwFj3s+IR80y
         eQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KW2fH/dOJNfVmUh3I46vnrHPpkzt1L5iGQVTotVhc4=;
        b=roBRcnuiS4yGSANih6F/asGDS6Wx3AWR4mxu2fstZ0PvW50VTFe04rGSaz5QbRwcLe
         CDTpJnTpU4WGmwMIcDUJ0IaBmHXRKeXY/fJxlErQ15+7Q7/KxNH0SjKVffWUYkUSTJdB
         vcBqPsXumWu/aV+2Ff7rSezVWlSP0mdfBrF8b/6f/mByqmzFtpuaJUY+c8BmLQRXHl/u
         TYm6kdJ6cSRY8n24gdPRJmO+qv5mDMZ4kWoPEIWwV8stvw6y9/fy5PdkjVg3Gu2K/9r4
         mLFs798Hji4CFo/qZpQEv/fck1SrBZZjh8b/irqaD9dFoxyLs66ZY7b4cx2i2MvWfZUP
         24lg==
X-Gm-Message-State: AOAM531VSYoDuufx73cdnHSmO8Yo56C8L/aIgsSSIcbTZpoOoRaIZpNM
        EyoErgWxzNcf7hIqSqS1hYYekXVZSKi2k0I0eUk8mg==
X-Google-Smtp-Source: ABdhPJynv+3Wgn8IeW3BkKaEsON4nak+D1rio8ktZla4HpaWEb12Bo8j8MDmmlnWwnyLFlrPd2iNHso+BQZB/bdZ8VQ=
X-Received: by 2002:a05:600c:2149:: with SMTP id v9mr6573477wml.59.1637380793206;
 Fri, 19 Nov 2021 19:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20211119164413.29052-1-palmer@rivosinc.com> <20211119164413.29052-6-palmer@rivosinc.com>
In-Reply-To: <20211119164413.29052-6-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 20 Nov 2021 09:29:41 +0530
Message-ID: <CAAhSdy0gwWOfUmqBXwZqKr-+crEXmvqO5gFC-ZQANw2nM+=MHQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] RISC-V: defconfigs: Sort CONFIG_SOC_POLARFIRE
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
> CONFIG_SOC_POLARFIRE the same way savedefconfig does.
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
> index 96c2a3615bcd..0f4fe5790fb5 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -15,9 +15,9 @@ CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
>  # CONFIG_SYSFS_SYSCALL is not set
> +CONFIG_SOC_MICROCHIP_POLARFIRE=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
> -CONFIG_SOC_MICROCHIP_POLARFIRE=y
>  CONFIG_SMP=y
>  CONFIG_HOTPLUG_CPU=y
>  CONFIG_VIRTUALIZATION=y
> --
> 2.32.0
>
