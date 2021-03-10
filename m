Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF01D333487
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 05:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhCJErq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 23:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhCJErd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 23:47:33 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4AFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 20:47:33 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id s21so269360pfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 20:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=SfH09lKBExpP+Z5yjQAJdcQXB/ODLLtwcv/93KvORQc=;
        b=l47JK39H9m+0KqzzGVpsKDFO0M5uLj3S8SOU6Y3kSEYsr1mfSW6hOoU7q9kD9YNqvW
         lgXU0hLk6jTKjyrRcQ9pxbyUnUn0KjxloxLGj9sxENsPGYXtIa3qKDUvpNkfw0Zo3ZyX
         tvjGKCfKywQ/VW5sy1sFGa2/C6IID9Evq5808X5J/eQ0Wc1/WP3rZ5sECmBbSquiaF7k
         GI6BHHd1FDyoifL7A9mClXvu/ScPFEFaXpHlkIGxZyIo+Ketf8C2Zv8TLO0c5eO+3Qrk
         mG52Zi6viD6ny5QYDrTkD0sq3u+UCcfjXOEPaLw6O68/ucYfBioj3GnZ02KsHWORZYk0
         ZFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=SfH09lKBExpP+Z5yjQAJdcQXB/ODLLtwcv/93KvORQc=;
        b=FG/EgV4Kt2WnH0L/JHt4RK+FQYMsMyDo7hQlRUS638hPVCUDz91zq5n4wnk9WKZ6bk
         Sw243ecIm28Pe2AXlsMIPTApYgdnX83tyeO6AN5l5iYumtvXQNkhu6e+AKe2DFVMXNDx
         Q10tcvYXr6iMv6tDxpyxxq4hfHhNZ+1kvyEo0fRZn/jWpAapzZM8Ls7AZybtw6Z6hjks
         R99iqpdQnhPSiNMBPA0TgkQEZ6TkTG3DWcJ302an+tN/AFM2E2OY8x4eJwSHfSXh9MJW
         l1jTb5VkExo5R7EOxPW7alyRhdET5ilFk+9UsgkQCy0JYQrBdP4o3k9mPt9/g8ouQ12k
         tuhg==
X-Gm-Message-State: AOAM530309w6xThGl7Y2EeOpEXvNMblpT/+uJjT3myQd+npQKC3is/wY
        sNNPHcO4M1iFpL4GCazX/Ihyng==
X-Google-Smtp-Source: ABdhPJzZqLbr5erZbKAG7BIrJUpovzgOrbFtNyVvKuJH9x1DRKGjJZCkIaQ5m97k5YqQeHB8dlSHdQ==
X-Received: by 2002:a63:5549:: with SMTP id f9mr1271715pgm.28.1615351652651;
        Tue, 09 Mar 2021 20:47:32 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t12sm4014320pga.85.2021.03.09.20.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 20:47:32 -0800 (PST)
Date:   Tue, 09 Mar 2021 20:47:32 -0800 (PST)
X-Google-Original-Date: Tue, 09 Mar 2021 20:47:20 PST (-0800)
Subject:     Re: [PATCH 0/9] riscv: misc cleanup
In-Reply-To: <20210305113332.428048-1-sunnanyong@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sunnanyong@huawei.com
Message-ID: <mhng-c2e752e9-7f90-41c1-98be-8d8b71a8ecf9@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Mar 2021 03:33:23 PST (-0800), sunnanyong@huawei.com wrote:
> Fix some compilation warnings,improve code style
>
> Nanyong Sun (9):
>   riscv: traps: Fix no prototype warnings
>   riscv: irq: Fix no prototype warning
>   riscv: sbi: Fix comment of __sbi_set_timer_v01
>   riscv: ptrace: Fix no prototype warnings
>   riscv: time: Fix no prototype for time_init
>   riscv: syscall_table: Reduce W=1 compilation warnings noise
>   riscv: process: Fix no prototype for show_regs
>   riscv: ftrace: Use ftrace_get_regs helper
>   riscv: process: Fix no prototype for arch_dup_task_struct
>
>  arch/riscv/include/asm/asm-prototypes.h | 16 ++++++++++++++++
>  arch/riscv/include/asm/irq.h            |  2 ++
>  arch/riscv/include/asm/processor.h      |  1 +
>  arch/riscv/include/asm/ptrace.h         |  5 +++++
>  arch/riscv/include/asm/timex.h          |  2 ++
>  arch/riscv/kernel/Makefile              |  1 +
>  arch/riscv/kernel/probes/ftrace.c       | 16 +++++++++-------
>  arch/riscv/kernel/process.c             |  1 +
>  arch/riscv/kernel/sbi.c                 |  2 +-
>  arch/riscv/kernel/time.c                |  1 +
>  arch/riscv/kernel/traps.c               |  1 +
>  11 files changed, 40 insertions(+), 8 deletions(-)

Thanks.  I fixed the checkpatch warning, these are all on fixes.
