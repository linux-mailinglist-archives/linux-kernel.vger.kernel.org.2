Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38EC38D910
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 07:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhEWFJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 01:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhEWFJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 01:09:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06577C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 22:07:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso9291464pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 22:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=/qQb/S90UvV48ljwdF8CQVkKM31YJ8ZeoSQFCFOdl1E=;
        b=xP1BfJ+e3CzmSr2vcUbbyXe9+W51bcA+tK4/3BOZeqmwK/UAZCCHyLoW6pVENv5roY
         Tr5nMJnzEcFbfo3N6VUFOgxzKID/JdrYmrROZdtKkQurXDDtGPV9kzQdkZ1uZicfcWSu
         yq3/NCvA4i1bvCINw6pV0v/U42ciJc3prkFWf+H26AJDWt+cnM7ZlOuWAhLLebRnR+FH
         e6h9BmqUmuADtHeZdW+IVGWVdAxQRb0c2EC/61iHx+p+x4MuRf1XcxNu/hJynjrycYW2
         5NUdMDLdIonN8K/gxLMAZbArscJRjDkPkBvKHFZ5yCqpTpEp687vPB1EMt6UxOKOJRT4
         HHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/qQb/S90UvV48ljwdF8CQVkKM31YJ8ZeoSQFCFOdl1E=;
        b=ETIKtZ+ceRiZekjy3IbgvzqPluSyfye2PiWEHuuLWow3SXWzKkq7ODU+5qWoDalb3m
         alcBuV9b7cFcPi7UheV7xghqnIu+lE8xzL81HLMGFWgR9sUX0DfjslQGXP0mKFAVyKPN
         2FhruaSH/y0+fthPIe0/Duyo6tLXm0o+olWtP2S8orZvwhlUrcx8UCaoBtHHSUR+yKuB
         3n4xrL4iDUr5cbcnysEJLBc+bOMOr+xmA1Mgxn7PQx0fGZgqD+MRrOD/+q5B7jXPzRaJ
         7I6SPwB3Rta72tvgH/adUpNIlOt6mpKGrBo6CUfk9uiDGpVXPzu6z77riXmAXLJ92FSp
         5gPQ==
X-Gm-Message-State: AOAM532nG6nqwDeyn+i/Ji2HU561QkZJFN+CC5yXOiPgcwNqfeNKQjbj
        wy8VKW5Mc4ScJ5wXHFNXSoFJfA==
X-Google-Smtp-Source: ABdhPJz+l01Gd3b4YWhwwE8NeWEK5m1FbOTtB9an0SIO4Hfo/rEryj2K8uMHFhPBGJGHU0W8pnEsyQ==
X-Received: by 2002:a17:90a:f98c:: with SMTP id cq12mr18755231pjb.235.1621746452821;
        Sat, 22 May 2021 22:07:32 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 4sm8365995pgn.31.2021.05.22.22.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 22:07:32 -0700 (PDT)
Date:   Sat, 22 May 2021 22:07:32 -0700 (PDT)
X-Google-Original-Date: Sat, 22 May 2021 22:05:04 PDT (-0700)
Subject:     Re: [PATCH] riscv: kprobes: Fix build error when MMU=n
In-Reply-To: <20210508234347.0b40b94a@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-6c70b6b6-7828-403a-93f9-5814edb3e201@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 May 2021 08:43:47 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> lkp reported a randconfig failure:
>
> arch/riscv/kernel/probes/kprobes.c:90:22: error: use of undeclared identifier 'PAGE_KERNEL_READ_EXEC'
>
> We implemented the alloc_insn_page() to allocate PAGE_KERNEL_READ_EXEC
> page for kprobes insn page for STRICT_MODULE_RWX. But if MMU=n, we
> should fall back to the generic weak alloc_insn_page() by generic
> kprobe subsystem.
>
> Fixes: cdd1b2bd358f ("riscv: kprobes: Implement alloc_insn_page()")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  arch/riscv/kernel/probes/kprobes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index 10b965c34536..15cc65ac7ca6 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -84,6 +84,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	return 0;
>  }
>
> +#ifdef CONFIG_MMU
>  void *alloc_insn_page(void)
>  {
>  	return  __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> @@ -91,6 +92,7 @@ void *alloc_insn_page(void)
>  				     VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
>  				     __builtin_return_address(0));
>  }
> +#endif
>
>  /* install breakpoint in text */
>  void __kprobes arch_arm_kprobe(struct kprobe *p)

Thanks, this is on fixes.
