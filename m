Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997293EC094
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhHNFAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhHNFAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:00:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E17C061575
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:00:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c17so9326537plz.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=PMObwOlvSNSaU90kBCrPAwCHgfnYE5sYfv2IhA/+RWs=;
        b=kIySnCyqtQ09NVjmlCQzxIopejzYXGJbDXct1X71S2dyztjBuBNsTFb3YU6tZ6azPR
         5DXoNmqVGbS652x1gpH/f8/biDBpGV38TG7bIKHvJM3FYCca62qbcnkUbhJ3p5kFtu+U
         urf5EiPvpmgdfAaItCUnZy8sBi1v5BVeik1sh6N7FwOFJePzhBOHODwS1FllnuXLq16h
         zwlRX/7zqXCM/LzjUZ0c5iEel0d3/dV2WtfUkZX0tHxk87Ndr2CT9z+DQ5+gnCLHlQoE
         YI6nTsiBJDzIl8Wcd01iDrvMFnE2HawwLPzgiwO2KWff+H1Ox86BthbCLTrFWQcGwZlD
         fKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=PMObwOlvSNSaU90kBCrPAwCHgfnYE5sYfv2IhA/+RWs=;
        b=hX/C2/Ks2VNmYQpSuFOyqlroGT0TpgiHRMC/Dx/QzTG3VygOnz4YKcaJo4+6iHpD5H
         Zof55+DfJtqGF/wMNxB3WwDLvVfBWV3ff7MFQhzYjU7DhVswCqXxs8oY+nXBqxzT/Htc
         HhlSpxJgLcBp8MY2/vWFXpfxRnUcidxCRq+d2mijEWUNbwwWZtlAPsk2b0XQrVWkipSM
         XOLwp7L/5tM9dg9W4e5li2WG3WHF/VU/g6miV+Xaj58fDANyhjvH9BtX2iKlZSaWeDSx
         e0jZlSvEkgWnMCSxWtWDoHcuc7ekvE6MHZC0Rnbp9EBoktPZuoBSjmCObXgvb/NgU3fb
         wR2Q==
X-Gm-Message-State: AOAM531HGgAlPoOtM5HzaFrTuTIzjbcmPnHAKYVMFbO1IYYVNZbUqW8V
        vM5OKiCf/D6O32vP7VKP2LX7UQ==
X-Google-Smtp-Source: ABdhPJwyAA2J67ZBfoCBKh9dBfOoNC9vxHF65tPWQ38IEbKdxSQIFmpHor+Qado93tqoMKYkSJNVWA==
X-Received: by 2002:a65:6653:: with SMTP id z19mr5349188pgv.394.1628917221360;
        Fri, 13 Aug 2021 22:00:21 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j25sm4023098pfe.198.2021.08.13.22.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 22:00:20 -0700 (PDT)
Date:   Fri, 13 Aug 2021 22:00:20 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Aug 2021 21:53:20 PDT (-0700)
Subject:     Re: [PATCH] riscv: move the (z)install rules to arch/riscv/Makefile
In-Reply-To: <20210729142147.445593-1-masahiroy@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, masahiroy@kernel.org,
        wangkefeng.wang@huawei.com, tklauser@distanz.ch,
        vitaly.wool@konsulko.com, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     masahiroy@kernel.org
Message-ID: <mhng-fe558e10-6cee-4e55-b975-8c525c2bcb02@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2021 07:21:47 PDT (-0700), masahiroy@kernel.org wrote:
> Currently, the (z)install targets in arch/riscv/Makefile descend into
> arch/riscv/boot/Makefile to invoke the shell script, but there is no
> good reason to do so.
>
> arch/riscv/Makefile can run the shell script directly.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/riscv/Makefile      | 7 +++++--
>  arch/riscv/boot/Makefile | 8 --------
>  2 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index bc74afdbf31e..3c437fb09a07 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -126,8 +126,11 @@ $(BOOT_TARGETS): vmlinux
>  Image.%: Image
>  	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>
> -zinstall install:
> -	$(Q)$(MAKE) $(build)=$(boot) $@
> +install: install-image = Image
> +zinstall: install-image = Image.gz
> +install zinstall:
> +	$(CONFIG_SHELL) $(srctree)/$(boot)/install.sh $(KERNELRELEASE) \
> +	$(boot)/$(install-image) System.map "$(INSTALL_PATH)"
>
>  archclean:
>  	$(Q)$(MAKE) $(clean)=$(boot)
> diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> index 6bf299f70c27..becd0621071c 100644
> --- a/arch/riscv/boot/Makefile
> +++ b/arch/riscv/boot/Makefile
> @@ -58,11 +58,3 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>
>  $(obj)/loader.bin: $(obj)/loader FORCE
>  	$(call if_changed,objcopy)
> -
> -install:
> -	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
> -	$(obj)/Image System.map "$(INSTALL_PATH)"
> -
> -zinstall:
> -	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
> -	$(obj)/Image.gz System.map "$(INSTALL_PATH)"

Admittidly I don't see a reason to do it this way either, but it looks 
like the other common ports (I checked arm64 and x86) are doing things 
this way.  I don't really care that much about which way we do it, but 
it'd be better to keep everyone aligned.

Are you converting the other ports over as well?
