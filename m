Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECAE33E7B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCQDgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhCQDgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:36:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 20:36:07 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x29so23965925pgk.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 20:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=W8H72798it9OolNWp4JLWdlboyq7CodcHmCStG5d+3I=;
        b=sDlO2kksnw7mXcOE//Cv43BSuy2P0zSuKgFBddBhhf2tC6IkJ7W8BGkCRbwRJ7nIUo
         GqgCZLicz29lrk2L/QY+ycBUwQ54L+COiFtCVbAyhfPue9O9HLmE+3MXXZWSfPwiSYPY
         Juh3VAVgr/ox9Y3wvQyITyQch8YaTdycI/X0HFkTlRZOFgXr66N5OfEamn59CD52L4xV
         546oJYhNFVDOsMVGi5ukeBqmCKNsBQLxV5HgVceq72qCEt+B0/CgEZ0RenvKSykQrKNB
         Ou5cUqZ8xgftMk0+KbL/8zGMZmKpbssPZAtAAI9o03G+MT6TrF1jGGLVuoHrqGxEwbzU
         nQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=W8H72798it9OolNWp4JLWdlboyq7CodcHmCStG5d+3I=;
        b=Ig1PJGf50tCGEoH60GNAWJE2F0jE+8CZTn7DGwuLJoxpzlwPsTh6tgNmyI8p5YnuVR
         oyIEgimzNhxnVf6D+FxY3cJRyuw/uHtz37oxPWeKY2txvusLa+VPaBTKs9TS03C1JTg6
         EPnPkMHfo5SVheA/IJvp3dMwkj/NuWYAW4mSwF3FpQWEwscnC2QqRUIFNVJEm9IgNc7t
         8UDb03r6Rtt590iwVLYbcgSgaCGWiCLhm7VteKRUIs8GFaqIhZdm3qpIcx+teFYI0hI2
         RSg8mapNJQlTdUJ1cEMaWcPWyEqowUZ2KptnT/Fu6sCPBt41RzQHmwvZWNVwZXSq/J/Y
         asog==
X-Gm-Message-State: AOAM530Jk+k7vgrH7+lsa57VNXX/uTNkOhKQHzvFSyBHk/xJpdreLDxU
        Y0U8FHwfSSjosbX7ZWrddMyreA==
X-Google-Smtp-Source: ABdhPJwl5btd1ncxM6rY0CAXQzLiRZjgQVJn8fY2NbH9I7FpzCjOQ2Za5LRVxptThmI9urwNGwsHQw==
X-Received: by 2002:a63:6dca:: with SMTP id i193mr837247pgc.81.1615952166796;
        Tue, 16 Mar 2021 20:36:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s22sm724266pjs.42.2021.03.16.20.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 20:36:05 -0700 (PDT)
Date:   Tue, 16 Mar 2021 20:36:05 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Mar 2021 20:33:16 PDT (-0700)
Subject:     Re: [PATCH 1/4] irqchip: riscv: Using CPUHP_AP_ONLINE_DYN
In-Reply-To: <1614608902-85038-1-git-send-email-guoren@kernel.org>
CC:     guoren@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, guoren@linux.alibaba.com,
        peterz@infradead.org, tglx@linutronix.de,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-94d75abc-8624-469c-ac51-0d9c82eabb07@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2021 06:28:19 PST (-0800), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Remove RISC-V irqchip custom definitions in hotplug.h:
>  - CPUHP_AP_IRQ_RISCV_STARTING
>  - CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING
>
> For coding convention.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Tested-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Link: https://lore.kernel.org/lkml/CAHk-=wjM+kCsKqNdb=c0hKsv=J7-3Q1zmM15vp6_=8S5XfGMtA@mail.gmail.com/
> ---
>  drivers/irqchip/irq-riscv-intc.c  | 2 +-
>  drivers/irqchip/irq-sifive-plic.c | 2 +-
>  include/linux/cpuhotplug.h        | 2 --
>  3 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> index 8017f6d..2c37f3a 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -125,7 +125,7 @@ static int __init riscv_intc_init(struct device_node *node,
>  		return rc;
>  	}
>
> -	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>  			  "irqchip/riscv/intc:starting",
>  			  riscv_intc_cpu_starting,
>  			  riscv_intc_cpu_dying);
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 6f432d2..f499f1b 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -375,7 +375,7 @@ static int __init plic_init(struct device_node *node,
>  	 */
>  	handler = this_cpu_ptr(&plic_handlers);
>  	if (handler->present && !plic_cpuhp_setup_done) {
> -		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
> +		cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>  				  "irqchip/sifive/plic:starting",
>  				  plic_starting_cpu, plic_dying_cpu);
>  		plic_cpuhp_setup_done = true;
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index f14adb8..14f49fd 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -103,8 +103,6 @@ enum cpuhp_state {
>  	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
>  	CPUHP_AP_IRQ_BCM2836_STARTING,
>  	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
> -	CPUHP_AP_IRQ_RISCV_STARTING,
> -	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
>  	CPUHP_AP_ARM_MVEBU_COHERENCY,
>  	CPUHP_AP_MICROCODE_LOADER,
>  	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

I'm going to assume this is going in through an irqchip tree, but LMK if you
want me to take it via mine.  This isn't really my sort of thing, so I'd prefer
at least an Ack.

Thanks!
