Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303A633337A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhCJDBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhCJDB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:01:26 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074DEC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 19:01:15 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w7so4265080pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 19:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=8ZP2HVKbYi+Y10nVIbvi77JIzLBHg2GFfYw/jvz9nU4=;
        b=HWk4x7xaB1lwOzTLjTgKmtPxBB0lsvsoqwBjk1bUnU+2A7Dkm6o6Ffy2lRC28K2zQE
         PL6RiidPja1TzGHZb7Ss/QZqoOy7qlMF49EfVEJeYFphxJkCd110vBcrioL5q/LmldjE
         KvxUg5z39Ius5HG3bAxNIvIo4HepVmhJbV8f9f8nh7YBXWr/oWNAJ3M4FN9LOMEYE13I
         zZGl25rZ6kfianm9C+OKJqltA4Jgaqf9lsxohEhxCy6/pSNEdUgzcu+fBSbb5SGwwcgM
         umMZfhZYRPmGZF2WCI/4q8SbkCFscBny1+k6Ecag6bUBjXs2+oxQqvJ/whE00Fr1Y4Bq
         N6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=8ZP2HVKbYi+Y10nVIbvi77JIzLBHg2GFfYw/jvz9nU4=;
        b=A37nK6/HZ3hN1NIdLfVEj0/3CTUTVXFfTdg3wA6RnX2BWTChcla5xbqp7Ne34mBf4H
         ix2hH3GNpqrqJYW+a3g8q6Wa/38B1hWXJb6qBZuNXKiUdok2lulQggWq1LbRaj49KQ3t
         kTiUCxGUUis8rfsl9nB9GiB3wbo9gtu5NpKFkz1upsjQiXKXQ5EnJQVXvaooSpNcF5Bd
         dt+FtvhIanIvralv1lf4PZuKtHw2llb0muPyRHNP9WbOs81y5pnnGjU4Q3n2UniSDICJ
         H14yMznKuRDE/wSnFWVs6K7ptmTMFgHhKEVKyvQ+gPk3CdF7eYpVISpkSRxdgPZWz8Hl
         qOFA==
X-Gm-Message-State: AOAM530C6quyqig9JnLiflFp9Axqj69JSshL/XDYZhk2vQcAhnBytH52
        OD4LMdgq42ZIM0Xnsrr8UfCTmxRBEE3oDA==
X-Google-Smtp-Source: ABdhPJwlrFUz5y2Ushm3kzAPDAXqhmg/f+CCEg2gDMmR+lBzz/HU1JK7K9CY2eGgr7eU3dV+waoWUw==
X-Received: by 2002:a17:902:c952:b029:e4:89ad:fae2 with SMTP id i18-20020a170902c952b02900e489adfae2mr901071pla.14.1615345274537;
        Tue, 09 Mar 2021 19:01:14 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b14sm14327844pfi.74.2021.03.09.19.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 19:01:13 -0800 (PST)
Date:   Tue, 09 Mar 2021 19:01:13 -0800 (PST)
X-Google-Original-Date: Tue, 09 Mar 2021 19:00:14 PST (-0800)
Subject:     Re: [PATCH v4] RISC-V: Use SBI SRST extension when available
In-Reply-To: <20210301115833.382364-1-anup.patel@wdc.com>
Message-ID: <mhng-c42c46e0-4715-4630-9a28-02a1515dbcb0@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021 03:58:33 PST (-0800), Anup Patel wrote:
> The SBI SRST extension provides a standard way to poweroff and
> reboot the system irrespective to whether Linux RISC-V S-mode
> is running natively (HS-mode) or inside Guest/VM (VS-mode).
>
> The SBI SRST extension is available in latest SBI v0.3-draft
> specification at: https://github.com/riscv/riscv-sbi-doc.
>
> This patch extends Linux RISC-V SBI implementation to detect
> and use SBI SRST extension.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 16 ++++++++++++++
>  arch/riscv/kernel/sbi.c      | 41 +++++++++++++++++++++++++++++++++---
>  2 files changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 99895d9c3bdd..8add0209c9c7 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -27,6 +27,7 @@ enum sbi_ext_id {
>  	SBI_EXT_IPI = 0x735049,
>  	SBI_EXT_RFENCE = 0x52464E43,
>  	SBI_EXT_HSM = 0x48534D,
> +	SBI_EXT_SRST = 0x53525354,
>  };
>
>  enum sbi_ext_base_fid {
> @@ -70,6 +71,21 @@ enum sbi_hsm_hart_status {
>  	SBI_HSM_HART_STATUS_STOP_PENDING,
>  };
>
> +enum sbi_ext_srst_fid {
> +	SBI_EXT_SRST_RESET = 0,
> +};
> +
> +enum sbi_srst_reset_type {
> +	SBI_SRST_RESET_TYPE_SHUTDOWN = 0,
> +	SBI_SRST_RESET_TYPE_COLD_REBOOT,
> +	SBI_SRST_RESET_TYPE_WARM_REBOOT,
> +};
> +
> +enum sbi_srst_reset_reason {
> +	SBI_SRST_RESET_REASON_NONE = 0,
> +	SBI_SRST_RESET_REASON_SYS_FAILURE,
> +};
> +
>  #define SBI_SPEC_VERSION_DEFAULT	0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
>  #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index f4a7db3d309e..49155588e56c 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/init.h>
>  #include <linux/pm.h>
> +#include <linux/reboot.h>
>  #include <asm/sbi.h>
>  #include <asm/smp.h>
>
> @@ -501,6 +502,32 @@ int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
>  }
>  EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
>
> +static void sbi_srst_reset(unsigned long type, unsigned long reason)
> +{
> +	sbi_ecall(SBI_EXT_SRST, SBI_EXT_SRST_RESET, type, reason,
> +		  0, 0, 0, 0);
> +	pr_warn("%s: type=0x%lx reason=0x%lx failed\n",
> +		__func__, type, reason);
> +}
> +
> +static int sbi_srst_reboot(struct notifier_block *this,
> +			   unsigned long mode, void *cmd)
> +{
> +	sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
> +		       SBI_SRST_RESET_TYPE_WARM_REBOOT :
> +		       SBI_SRST_RESET_TYPE_COLD_REBOOT,
> +		       SBI_SRST_RESET_REASON_NONE);
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block sbi_srst_reboot_nb;
> +
> +static void sbi_srst_power_off(void)
> +{
> +	sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
> +		       SBI_SRST_RESET_REASON_NONE);
> +}
> +
>  /**
>   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
>   * @extid: The extension ID to be probed.
> @@ -577,22 +604,30 @@ void __init sbi_init(void)
>  			sbi_get_firmware_id(), sbi_get_firmware_version());
>  		if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
>  			__sbi_set_timer = __sbi_set_timer_v02;
> -			pr_info("SBI v0.2 TIME extension detected\n");
> +			pr_info("SBI TIME extension detected\n");
>  		} else {
>  			__sbi_set_timer = __sbi_set_timer_v01;
>  		}
>  		if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
>  			__sbi_send_ipi	= __sbi_send_ipi_v02;
> -			pr_info("SBI v0.2 IPI extension detected\n");
> +			pr_info("SBI IPI extension detected\n");

These aren't really part of the reset stuff and should be split into a separate 
patch.

>  		} else {
>  			__sbi_send_ipi	= __sbi_send_ipi_v01;
>  		}
>  		if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
>  			__sbi_rfence	= __sbi_rfence_v02;
> -			pr_info("SBI v0.2 RFENCE extension detected\n");
> +			pr_info("SBI RFENCE extension detected\n");
>  		} else {
>  			__sbi_rfence	= __sbi_rfence_v01;
>  		}
> +		if (sbi_probe_extension(SBI_EXT_SRST) > 0 &&
> +		    sbi_minor_version() >= 3) {
> +			pr_info("SBI SRST extension detected\n");
> +			pm_power_off = sbi_srst_power_off;
> +			sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
> +			sbi_srst_reboot_nb.priority = 192;
> +			register_restart_handler(&sbi_srst_reboot_nb);
> +		}
>  	} else {
>  		__sbi_set_timer = __sbi_set_timer_v01;
>  		__sbi_send_ipi	= __sbi_send_ipi_v01;

This is fine, but I don't want to take things for draft SBI versions until 
they're at least tagged.
