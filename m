Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1352D310571
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 08:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhBEHHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 02:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhBEHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:07:17 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1F3C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 23:06:37 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i63so3726318pfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 23:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=EWF76HYflOSB1OrBYTPsvdsM7e0I+FAmlSYnAn8ZKQc=;
        b=ecmHbBQ8yqsVKLhzbA0PGceRRKqh0al5tfdBU+2k1tKH9lOppdOyxzqWfTcEJhArKu
         hxQxDBdcQP1lzPPsGZBWotsLtToKpaa8jIw+nTlJEmx430J/2gHvapfRjCZ083UzOlSy
         Nxagae9Va1XnM/S8g8s0wBQED6jpjFj+jdhC0erEolBmihf3CPsVAI5TOLeZoAow20gn
         mBXaRPd0QY1N+0stmP/HI080xU9rbkUNv1Sw2YXBR3LR94DOxowbeBzoHv+0KtFqhKwU
         nBsJyOO3UygcMB+hH0mzs2feA+kYeI0rNOizUij/1j3iPEkuj5zbDu1JqGHJLLtCjiv0
         ukqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=EWF76HYflOSB1OrBYTPsvdsM7e0I+FAmlSYnAn8ZKQc=;
        b=Q7tFySTgZz4CfZ0O2H60to5PXwa4gtzPb/a7H0lrGonDC862B1V6zaf1IGchC2plCR
         Y/V+OKevTuUXWJgkxAQnWMVwCwTqiHqmqF0mk7kYP6nfeKVC4nbTk3AOugl4VkqzM137
         STaeGRB7DUwxs1PjRTVYSCX0Mf8Zg1/BZfcXosljyxfl8omhD4t6C5Z3bYemqwAVb9QQ
         wFhCuJsSAMMJKkS9Gi3B5a72Twb/ySFAeEOj66zdtpmxSp5fgJBnaw3q2H2qgncPxoQO
         tLjqTjps7MegAy5e0sjnalCsok35ty72NZj5iwZUMDDCN7U06EFjLFcdIg7bEb3Q1DFD
         Entg==
X-Gm-Message-State: AOAM532Fc6M8r92zdHxvO0Lcy7OzhLerjUYyDWsW+z1uBwREiUNJqwpz
        Csz2G7j64AjyGWj7NZ/47EY0WJt7EckSDf4w
X-Google-Smtp-Source: ABdhPJylwFkYzxiOHze5TcoGUYtRuKQUb2qZfzxlF6Y+Unn8qBXdovj05IYLlEshzFUrFV2FuDXbiA==
X-Received: by 2002:a62:ddd1:0:b029:1b7:5651:f6ea with SMTP id w200-20020a62ddd10000b02901b75651f6eamr3231028pff.62.1612508796836;
        Thu, 04 Feb 2021 23:06:36 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l11sm4671266pjh.6.2021.02.04.23.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 23:06:35 -0800 (PST)
Date:   Thu, 04 Feb 2021 23:06:35 -0800 (PST)
X-Google-Original-Date: Thu, 04 Feb 2021 23:03:10 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Add a non-void return for sbi v02 functions
In-Reply-To: <20210204052643.1608586-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        wangkefeng.wang@huawei.com, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-754d5fdb-23eb-45a0-b167-6bd4f674b6b6@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Feb 2021 21:26:43 PST (-0800), Atish Patra wrote:
> SBI v0.2 functions can return an error code from SBI implementation.
> We are already processing the SBI error code and coverts it to the Linux
> error code.
>
> Propagate to the error code to the caller as well. As of now, kvm is the
> only user of these error codes.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 10 +++++-----
>  arch/riscv/kernel/sbi.c      | 32 ++++++++++++++++----------------
>  2 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 1b26ec8e6a15..3e7141a7d11f 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -116,13 +116,13 @@ int sbi_console_getchar(void);
>  void sbi_set_timer(uint64_t stime_value);
>  void sbi_shutdown(void);
>  void sbi_clear_ipi(void);
> -void sbi_send_ipi(const unsigned long *hart_mask);
> -void sbi_remote_fence_i(const unsigned long *hart_mask);
> -void sbi_remote_sfence_vma(const unsigned long *hart_mask,
> +int sbi_send_ipi(const unsigned long *hart_mask);
> +int sbi_remote_fence_i(const unsigned long *hart_mask);
> +int sbi_remote_sfence_vma(const unsigned long *hart_mask,
>  			   unsigned long start,
>  			   unsigned long size);
>
> -void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> +int sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>  				unsigned long start,
>  				unsigned long size,
>  				unsigned long asid);
> @@ -163,7 +163,7 @@ static inline unsigned long sbi_minor_version(void)
>
>  int sbi_err_map_linux_errno(int err);
>  #else /* CONFIG_RISCV_SBI */
> -static inline void sbi_remote_fence_i(const unsigned long *hart_mask) {}
> +static inline int sbi_remote_fence_i(const unsigned long *hart_mask) {}
>  static inline void sbi_init(void) {}
>  #endif /* CONFIG_RISCV_SBI */
>  #endif /* _ASM_RISCV_SBI_H */
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 8d60b2ebcad3..f904af48635d 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -352,7 +352,7 @@ static int __sbi_rfence_v02(int fid, const unsigned long *hart_mask,
>   * sbi_set_timer() - Program the timer for next timer event.
>   * @stime_value: The value after which next timer event should fire.
>   *
> - * Return: None
> + * Return: None.
>   */
>  void sbi_set_timer(uint64_t stime_value)
>  {
> @@ -363,11 +363,11 @@ void sbi_set_timer(uint64_t stime_value)
>   * sbi_send_ipi() - Send an IPI to any hart.
>   * @hart_mask: A cpu mask containing all the target harts.
>   *
> - * Return: None
> + * Return: 0 on success, appropriate linux error code otherwise.
>   */
> -void sbi_send_ipi(const unsigned long *hart_mask)
> +int sbi_send_ipi(const unsigned long *hart_mask)
>  {
> -	__sbi_send_ipi(hart_mask);
> +	return __sbi_send_ipi(hart_mask);
>  }
>  EXPORT_SYMBOL(sbi_send_ipi);
>
> @@ -375,12 +375,12 @@ EXPORT_SYMBOL(sbi_send_ipi);
>   * sbi_remote_fence_i() - Execute FENCE.I instruction on given remote harts.
>   * @hart_mask: A cpu mask containing all the target harts.
>   *
> - * Return: None
> + * Return: 0 on success, appropriate linux error code otherwise.
>   */
> -void sbi_remote_fence_i(const unsigned long *hart_mask)
> +int sbi_remote_fence_i(const unsigned long *hart_mask)
>  {
> -	__sbi_rfence(SBI_EXT_RFENCE_REMOTE_FENCE_I,
> -		     hart_mask, 0, 0, 0, 0);
> +	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_FENCE_I,
> +			    hart_mask, 0, 0, 0, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_fence_i);
>
> @@ -391,14 +391,14 @@ EXPORT_SYMBOL(sbi_remote_fence_i);
>   * @start: Start of the virtual address
>   * @size: Total size of the virtual address range.
>   *
> - * Return: None
> + * Return: 0 on success, appropriate linux error code otherwise.
>   */
> -void sbi_remote_sfence_vma(const unsigned long *hart_mask,
> +int sbi_remote_sfence_vma(const unsigned long *hart_mask,
>  			   unsigned long start,
>  			   unsigned long size)
>  {
> -	__sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
> -		     hart_mask, start, size, 0, 0);
> +	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
> +			    hart_mask, start, size, 0, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_sfence_vma);
>
> @@ -411,15 +411,15 @@ EXPORT_SYMBOL(sbi_remote_sfence_vma);
>   * @size: Total size of the virtual address range.
>   * @asid: The value of address space identifier (ASID).
>   *
> - * Return: None
> + * Return: 0 on success, appropriate linux error code otherwise.
>   */
> -void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> +int sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
>  				unsigned long start,
>  				unsigned long size,
>  				unsigned long asid)
>  {
> -	__sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
> -		     hart_mask, start, size, asid, 0);
> +	return __sbi_rfence(SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
> +			    hart_mask, start, size, asid, 0);
>  }
>  EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);

Thanks, this is on for-next.
