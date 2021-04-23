Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E329368B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 05:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbhDWDbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 23:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240301AbhDWDb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 23:31:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB22C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:30:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t22so24245617ply.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qaw2z6Fiz8budmcbQpSjS3rq3t98QrIaH/1JDnF8/CI=;
        b=Twjiu66cRGDiSGf+hENnGoVVrxWmSAHDo4wVWo04Sm68c0+kRHlyolVR9lSyKV9aPh
         CChttEIa3EbCHiPptC0tV/KUh+VoCql/phpfoWhQIC+ZsGvRZqxLdo9MfMpRxjdWbALM
         zhOAXIyzhNYJIT/aouIxAm8I1GeaxWI3Wh7fMhMJEg6hvhJBkHRQtLpO3JFpoKKlSgXj
         D72pUt8+obFY6SFBoSQR1GsUlHBblJ8LOaalrdD6R7aSTTg5bzUxcnIVwjrzUkYKYs46
         g/OXAdpNbA7lIyseTRzaBzdaWwTikSgKU0W9QzlPFJxsvd3FUmC6CjnqCknQa/+UZbeg
         Zm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qaw2z6Fiz8budmcbQpSjS3rq3t98QrIaH/1JDnF8/CI=;
        b=p8bjp3Ao5/zS95Q8jWgJGEYBtfCPIn9ruP9pC8kNlVgo67//btCHtRN8/MWYp9mpWn
         qu/LfApvrmxtLgxURjuPg4mBXRD1O5KlYWHWz0sxPSorbgvlMk3opp6Bfpfo5Pryfd3w
         juI+m4AF333F130Bzmm0oyC7vUFymQxKEG1WTZye/6A2QM8ytvuebEicO4UhDYSIvfY9
         1+1XAjssyQVuhoSWDm9uCnS2CrFzahTZG9d5ySY2vKQv7MXGZ5aJ7CG978SfLs3eQB3Q
         5fFXId4bCiKEu+20ZyHA/Uxjiwb0T/wuZLxIIveFlaPQT3sF41oahSHfmQJQPz/6KADP
         3KsQ==
X-Gm-Message-State: AOAM530ujtTL9Hti+u4yzO5mCJtiGRWrpajOVEliCPkoCGIM4JZ0XIox
        kOeNc5ZxEhB5X0PiRuNzTZPiXoZsiIiHjg==
X-Google-Smtp-Source: ABdhPJypdjFtPqzzjXh0/a1Ykmfvyq/pU6f4BqrwPfq6B8TYM5PC1MceOudhWdAKtt7OEr8SIDEUBw==
X-Received: by 2002:a17:902:ea89:b029:ea:c781:daad with SMTP id x9-20020a170902ea89b02900eac781daadmr2006310plb.62.1619148651234;
        Thu, 22 Apr 2021 20:30:51 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l132sm3502524pga.39.2021.04.22.20.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 20:30:50 -0700 (PDT)
Date:   Thu, 22 Apr 2021 20:30:50 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 20:30:40 PDT (-0700)
Subject:     Re: [PATCH v3 0/5] RISC-V: Add kexec/kdump support
In-Reply-To: <20210405085712.1953848-1-mick@ics.forth.gr>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, mick@ics.forth.gr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mick@ics.forth.gr
Message-ID: <mhng-4f2d27cc-6dc2-4d3d-ae61-5681b15372b7@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Apr 2021 01:57:07 PDT (-0700), mick@ics.forth.gr wrote:
> This patch series adds kexec/kdump and crash kernel
> support on RISC-V. For testing the patches a patched
> version of kexec-tools is needed (still a work in
> progress) which can be found at:
>
> https://riscv.ics.forth.gr/kexec-tools-patched.tar.xz
>
> v3:
>  * Rebase on newer kernel tree
>  * Minor cleanups
>  * Split UAPI changes to a separate patch
>  * Improve / cleanup init_resources
>  * Resolve Palmer's comments
>
> v2:
>  * Rebase on newer kernel tree
>  * Minor cleanups
>  * Properly populate the ioresources tre, so that it
>    can be used later on for implementing strict /dev/mem
>  * Use linux,usable-memory on /memory instead of a new binding
>  * USe a reserved-memory node for ELF core header
>
> Nick Kossifidis (5):
>   RISC-V: Add EM_RISCV to kexec UAPI header
>   RISC-V: Add kexec support
>   RISC-V: Improve init_resources
>   RISC-V: Add kdump support
>   RISC-V: Add crash kernel support
>
>  arch/riscv/Kconfig                  |  25 ++++
>  arch/riscv/include/asm/elf.h        |   6 +
>  arch/riscv/include/asm/kexec.h      |  54 +++++++
>  arch/riscv/kernel/Makefile          |   6 +
>  arch/riscv/kernel/crash_dump.c      |  46 ++++++
>  arch/riscv/kernel/crash_save_regs.S |  56 +++++++
>  arch/riscv/kernel/kexec_relocate.S  | 222 ++++++++++++++++++++++++++++
>  arch/riscv/kernel/machine_kexec.c   | 193 ++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c           | 113 ++++++++------
>  arch/riscv/mm/init.c                | 110 ++++++++++++++
>  include/uapi/linux/kexec.h          |   1 +
>  11 files changed, 787 insertions(+), 45 deletions(-)
>  create mode 100644 arch/riscv/include/asm/kexec.h
>  create mode 100644 arch/riscv/kernel/crash_dump.c
>  create mode 100644 arch/riscv/kernel/crash_save_regs.S
>  create mode 100644 arch/riscv/kernel/kexec_relocate.S
>  create mode 100644 arch/riscv/kernel/machine_kexec.c

Thanks.  There were some minor issues and some merge conflicts, I put 
this on for-next with some fixups.
