Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFC9457B02
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhKTEEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbhKTEEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:04:41 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04758C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:01:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso11975101wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91hgkvMagzzdtA7j3uCrPomJgAj+GmZeXcVvVsWMKYI=;
        b=UrYGIdflxT+VIeXGHHEvV5dcH2b7ykOSLSK3Od9XTzDRYvIC+MT3C9WodHbjuKREye
         aQfMrgdowWnK8PIBaDFQ+PtUpTJzk5s1+TCJA3vJzPSbUd1JsUWPUwqgsc8cPeXZXd6N
         OfUnl0IVqMKN9D4adh34HLnxwH2lVUy/7uvg7d2CN/u4RoVEI/e9l6IYRqtmKLiKR9HL
         QVP2QJwNi8/7rK+7mtnW5JwvrtL8eA7tAMHzG77kZT+POhSDHfqZYYlbSUvJjw3zEybb
         3zxjpyovNJvMHC5sDeGc5rccNQ2IqKKjUF+GvmoCnWlT8Nr6WLvp/rXLUFpjO+a+kgTK
         mcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91hgkvMagzzdtA7j3uCrPomJgAj+GmZeXcVvVsWMKYI=;
        b=ixaxQVLbCgCRL52mdeFUl45To70SWt7FBPodtXYAgBODqyX7w827T61C5MrLJua+qa
         mpa6z54f0WrTWj/L8/onvK2r4r0VH+iXNQOvhCC48nO4lMZkEbzPbEd8+RMzyaucMBVi
         mlOEqq+F3a8qPQ9l/PiPB0xgedRE+ZIniWdfqHxewb9RRrHGBwhYjIptaxAFH9GMwhWG
         75Rb/bWY46Y8P6vKswjE67jCsrfRybsXbGhcvnHJE6ZuzObvI6FG6A0eKrDfFSBjS3uM
         XqqO2Bbo1Nn6Zy+vat3LunutGt3RFvzYrH7X1tA5XwdGCKLwbWYAKeTS/mKVCJlUzXl6
         4xYg==
X-Gm-Message-State: AOAM531LzZEJ7CdtHXQILUo9wZSoMMVrUuOTOsOAjt/cVoeJ5BAKIW8w
        azhI/TMYDVPMFY0dojYStm3ns3eJBfKKJywD3Oo+Dg==
X-Google-Smtp-Source: ABdhPJxlzboCwwqWNYtVsqf6BEyLRFhN4pocPFJOJwuVXg+j1922/JCIElPydy7svQZ7ez2yT2fkr0ZTEqWdzKdtFCE=
X-Received: by 2002:a1c:7201:: with SMTP id n1mr6415226wmc.176.1637380896488;
 Fri, 19 Nov 2021 20:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20211119164413.29052-1-palmer@rivosinc.com> <20211119164413.29052-8-palmer@rivosinc.com>
In-Reply-To: <20211119164413.29052-8-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 20 Nov 2021 09:31:24 +0530
Message-ID: <CAAhSdy2QR+BEWqWOsg56SYODcuq68qknh7wZ1qLAFrK8zvRmRA@mail.gmail.com>
Subject: Re: [PATCH 07/12] RISC-V: defconfigs: Sort CONFIG_MMC
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
> This should have no functional change, it just sorts CONFIG_MMC the same
> way savedefconfig does.  This only touches the rv64 defconfig because
> rv32_defconfig was already sorted correctly.
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
> index fa9017c60b3d..ec9540392df7 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -90,10 +90,10 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_UAS=y
> +CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_CADENCE=y
> -CONFIG_MMC=y
>  CONFIG_MMC_SPI=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_VIRTIO_PCI=y
> --
> 2.32.0
>
