Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9095D33E894
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 05:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCQExV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 00:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhCQExF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:53:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541AFC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 21:53:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g15so272070pfq.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 21:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=d8dYAktnUBBiQrXZEcua+BNHo2fKNZhUG+0Inwx8kus=;
        b=niXuLSlZqGyMJtNFFYws30ei5jxNF1MxBhVz9FPSaYoEmbFkVgyw4ZkEQHEVf6noNd
         V9H+PU446TPYO7d32QIqeBkc8UXXUYgCry+5/ckOLtRjzilQge6EU6Yc+EzwnGrzSnpi
         rq6lNNpO5ZehsNQNUhtK4w69j6Q87T52YF/1w3kCF3tbOatws1+X/rWCDHJj7x94aktS
         Sxd/NBV4K88tIzvti9/2TH1ZxcjyIsw/WXR2jXdCnLnZqgJK4+kkXiXrPndvSGhiqM2S
         B8caEl4y8conzl1sI2o7EVNClXDwCLhSAZEIwf3B5E51KpFmjRp9wmB/xAQRwquljt01
         qpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=d8dYAktnUBBiQrXZEcua+BNHo2fKNZhUG+0Inwx8kus=;
        b=W5LzIEcXvVhOvfFagss9y5X8CX9MmxARLNxOJk9IoQ/X8auM0CzAuc4t8qSERFmcbt
         ax02eI7r3K8fubARfab49ptckW7GA3joAXz8NgHb/Bz9T45fkgXfscvEzhClNo9cXtgp
         7ObqfcNIcZqs2j7ZrUw4bJ8wrNH7adKQrh5kkyEF+IL/9D48YzRAaq6m7nvZS9AGEGmp
         zOpZBFvNnrsHfbekb3+2OCbkpTeJGp6WjM2TauZ81vnEAqeaFdzmdJ0crCubCa5ItfG/
         fMWEiUsl49LTGTiZipFIhsed/rdHrq4uzjoqW4589VyjVxiS/tVnhQiw+ooGg/Pub25I
         G5XA==
X-Gm-Message-State: AOAM532ac5DVlfjUcWHWYYPVOXt4Leg7m+FBEazmhb0zfyDBybmWxGKp
        4J4oKMcX2+ki1a1/BY9o6NhNPg==
X-Google-Smtp-Source: ABdhPJze1AWtbvlK653ib6kGnHhosP0U9QAm2Y6eHCKmfcznfiMba+6v3xcBWJcN5Rw2R9jzVTmc4Q==
X-Received: by 2002:aa7:9619:0:b029:1fa:ed79:b724 with SMTP id q25-20020aa796190000b02901faed79b724mr2509040pfg.38.1615956784475;
        Tue, 16 Mar 2021 21:53:04 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i1sm17197849pfo.160.2021.03.16.21.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 21:53:03 -0700 (PDT)
Date:   Tue, 16 Mar 2021 21:53:03 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Mar 2021 21:49:52 PDT (-0700)
Subject:     Re: [RFC PATCH v1 0/3] IPI and remote TBL flush improvement
In-Reply-To: <20210311164712.652608-1-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-18286acf-f6b8-4793-88a1-f747b818f764@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 08:47:09 PST (-0800), Anup Patel wrote:
> This series primarily does two things:
> 1. Allows RISC-V IPI provider to specificy whether IPI operations are
>    suitable for remote TLB flush (PATCH1)
> 2. Improve remote TLB flush to use IPIs whenever possible (PATCH2)
> 3. Allow irqchip drivers to handle IPIs from chained IRQ handlers (PATCH3)

IIUC this last one isn't technically used in both forms, as we don't have any
drivers that behave that way yet?  I'm OK taking it, under the assumption it
makes keeping the out-of-tree driver for the draft interrupt controller easier,
but I was wrong then it's probably out of order so I figured I'd check.

Aside from that this generally LGTM.  We are making quite a bit of mess in
here, but I don't really see a way around that as we need to support the old
hardware.  We can always do a cleanup when the specifications settle down.

Oddly enough this did come up in IRC recently and there may be some new bits in
the CLINT on the FU740 that allow S-mode SW interrupts to show up directly --
there's at least a "delegate supervisor software interrupt" bit now, but the
manual only calls out machine mode as being able to set it (though IIUC it's
memory mapped, so not sure how that would be enforced).  Not saying we need
that in order to take the last patch, but if it is possible it's probably worth
giving it a shot when the boards show up.

> This series also a preparatory series for upcoming RISC-V advanced
> interrupt architecture (AIA) support.
>
> These patches can be found in riscv_ipi_imp_v1 branch at
> https://github.com/avpatel/linux
>
> Anup Patel (3):
>   RISC-V: IPI provider should specify if we can use IPI for remote FENCE
>   RISC-V: Use IPIs for remote TLB flush when possible
>   RISC-V: Add handle_IPI_noregs() for irqchip drivers
>
>  arch/riscv/include/asm/smp.h      | 19 +++++++++-
>  arch/riscv/kernel/sbi.c           |  2 +-
>  arch/riscv/kernel/smp.c           | 30 +++++++++++----
>  arch/riscv/mm/cacheflush.c        |  2 +-
>  arch/riscv/mm/tlbflush.c          | 62 ++++++++++++++++++++++++-------
>  drivers/clocksource/timer-clint.c |  2 +-
>  6 files changed, 91 insertions(+), 26 deletions(-)
