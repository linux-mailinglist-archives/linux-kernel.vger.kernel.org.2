Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530243D1E03
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhGVF2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhGVF2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:28:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9FC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 23:09:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so2748320pja.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 23:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=JGZNlAbWwH8KnKtTTLQVUHCmfrYBjCcYZGAw8CpDvDY=;
        b=1evNGewArFpgG6ErFTJdQbJ3CgYm4mc2jK3DWn0rs7MMNuV61pPUXSYiijX0XfcXeO
         Te0ApunX5CtjlgRjmzUUZGDGaa4UJZMB1cvrno8V0pXCa8BLwkYiperEM0pDWx1mB3wL
         g/ar3PmfYDbuLzviAwHxbolEbwotsdsu5Ck2R0iwGhT9dtrBeuUTJApheQ+xzmWWEmBp
         aXoLLEaGEo/MX7tPz0MoAyV7di0Ph2EpTcXoc6wIdU7LgghMLNRF3B8XjfMY6TLl9seC
         RxjPXBSy9om7Rfa5/jqspLJPCCTxxg/H7Bv8NcsRV2hmGhl54PQ6OmpYbYzP9YgWVSah
         aA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=JGZNlAbWwH8KnKtTTLQVUHCmfrYBjCcYZGAw8CpDvDY=;
        b=rvNWXDcFwVL/nyjO8l+tgMUDGPCgIgx31d4nV8KYF3MOq9a8EAr8mrJI+YRQ2piGD9
         iALdI/MXVtFQ/O8aFD5bc3NxLJzDHha/30AoADrU1mFA8wO7moT/8MeOWVgmORG9XbYb
         B9Ykc06L3sz7/E+Tgox4OqcLqy6wKaZ9a/RJlzS3Xv8earmbCfXMePmT3DVGNV7dpc8b
         ONR2ruM9OFrdOj2i3u7XnPFXcwIHJ8ym5UX3DTBOXlt7RolPFUQYl6XxJJyH9YEzCfdg
         V0+caXB1a0q58hxmL2WLSZifSK3vXBYQq+tkP9YdYUsO9yPO0HACXSKdpqR6Txw9QNZN
         EL0g==
X-Gm-Message-State: AOAM533Ec2ErCLb1pMJyrD+si/tPnnqTy94UzHJoEsMCNZ6Xw06X8n2s
        xpXo3WaaqDDVvIhAAukpN972Sg==
X-Google-Smtp-Source: ABdhPJwbH8JkdIu9/4V/l6vl783ox75sPe2K7cYNoJWAhro5WSE2yrNRSmzunbrlu3M2pVUVp8RyMw==
X-Received: by 2002:a17:90a:bc84:: with SMTP id x4mr7324526pjr.236.1626934145393;
        Wed, 21 Jul 2021 23:09:05 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v69sm29927398pfc.118.2021.07.21.23.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 23:09:04 -0700 (PDT)
Date:   Wed, 21 Jul 2021 23:09:04 -0700 (PDT)
X-Google-Original-Date: Wed, 21 Jul 2021 22:58:55 PDT (-0700)
Subject:     Re: [PATCH 1/1] RISC-V: load initrd wherever it fits into memory
In-Reply-To: <20210629134018.62859-1-xypron.glpk@gmx.de>
CC:     ardb@kernel.org, schwab@linux-m68k.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, xypron.glpk@gmx.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     xypron.glpk@gmx.de
Message-ID: <mhng-34467fe7-5a31-4c88-a5ad-6dea683fcfeb@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021 06:40:18 PDT (-0700), xypron.glpk@gmx.de wrote:
> Requiring that initrd is loaded below RAM start + 256 MiB led to failure
> to boot SUSE Linux with GRUB on QEMU, cf.
> https://lists.gnu.org/archive/html/grub-devel/2021-06/msg00037.html
>
> Remove the constraint.
>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  arch/riscv/include/asm/efi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.h
> index 7542282f1141..649ab513dc99 100644
> --- a/arch/riscv/include/asm/efi.h
> +++ b/arch/riscv/include/asm/efi.h
> @@ -33,10 +33,10 @@ static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
>
>  #define ARCH_EFI_IRQ_FLAGS_MASK (SR_IE | SR_SPIE)
>
> -/* Load initrd at enough distance from DRAM start */
> +/* Load initrd anywhere in system RAM */
>  static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
>  {
> -	return image_addr + SZ_256M;
> +	return ULONG_MAX;
>  }
>
>  #define alloc_screen_info(x...)		(&screen_info)

Thanks, this is on fixes.
