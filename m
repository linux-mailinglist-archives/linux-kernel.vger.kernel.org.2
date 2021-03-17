Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846E033EB80
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCQI3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:29:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1949C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:29:31 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so758907wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FszYK6XJvOqLV5aC3rDe7wSMfM1HwiAzqiaWoilNkjU=;
        b=t9hpWuZ2CcgCRCUbHLeRNb5NDl9j+FOvAu6JeWVAqK2KEq9Wf0mxjvhikSWoGuV5Gv
         tImIVqJldHUey+Jdtl8gqK8E4ofum8VPCBgGbiqtcL57ORceLo4lYi6AECRV7TKICzTr
         LBE/s4omyiHXVKxfYk0her+kDiJHxx8sMUPM9Dpx7IuwyJ5C1wQu4G8+fSFnCZ2pStNr
         8reNQ4AcHiSdczFEyxcyJ0B4olgsS4mUSUl0pfvQNYjJLkTmhco+U1vLi0rtTUfhQV81
         py142E5/HkEmMPobMJnn7huKa8qDzmHNJsxwjzuDH9HLE1O4Ca/2LhdGkqlC+c59AOgX
         oMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FszYK6XJvOqLV5aC3rDe7wSMfM1HwiAzqiaWoilNkjU=;
        b=Zbp4eXdKTvYNcM+0ESzXhAw1FLYA4CdesLIIIjYbeM2UJYunswUTtJerfv/NCMo1yf
         CixbLk2lqkyaeMke1Z1efstb+mfNpRzng+nuHzXYGneED2/8S/bY3zy3DBh9iM90IQS5
         fcQOBrX04SfmJUuKQ4cbG2TIlh9Mym4gG41QWzZSE4a+7V9W/EMEIFCqhuNXGz0Eo017
         iJZfEisqCB00e7VQJktAS8vuuPasWVhixIm51f119OACPCHyOEHPglZebpQ5rypJey8n
         DrjsiF05kC0Ek6tWYh6V9ibv0DhNrHMs00EaAGZaseiBReQ5H6Ib+ZAIqVgc1II3K6xM
         BLNw==
X-Gm-Message-State: AOAM530O4gzrox+SUmZUXQvnT2UE4n/oEdmtyDkL+UJhJB5ODYShk/56
        ppXNK5vyhLsG0MDYkWkzpvjsa/NSIVFdXg3yCAU2/Q==
X-Google-Smtp-Source: ABdhPJyODgVdBUcy6KutdnAXKlUrHshjF8dk1NiL3hZy0C6VgqD356X7b+rkzblx76EXjRPFCC2dU+tUbneuvDcA6Ow=
X-Received: by 2002:a1c:60c2:: with SMTP id u185mr1163441wmb.157.1615969770350;
 Wed, 17 Mar 2021 01:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210311164712.652608-1-anup.patel@wdc.com> <mhng-18286acf-f6b8-4793-88a1-f747b818f764@palmerdabbelt-glaptop>
In-Reply-To: <mhng-18286acf-f6b8-4793-88a1-f747b818f764@palmerdabbelt-glaptop>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 17 Mar 2021 13:59:17 +0530
Message-ID: <CAAhSdy1rY-OOgboucJjzMh7_Vh-3G9cDyt8gtRgNNFHBV6O2Eg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] IPI and remote TBL flush improvement
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:23 AM Palmer Dabbelt
<palmerdabbelt@google.com> wrote:
>
> On Thu, 11 Mar 2021 08:47:09 PST (-0800), Anup Patel wrote:
> > This series primarily does two things:
> > 1. Allows RISC-V IPI provider to specificy whether IPI operations are
> >    suitable for remote TLB flush (PATCH1)
> > 2. Improve remote TLB flush to use IPIs whenever possible (PATCH2)
> > 3. Allow irqchip drivers to handle IPIs from chained IRQ handlers (PATCH3)
>
> IIUC this last one isn't technically used in both forms, as we don't have any
> drivers that behave that way yet?  I'm OK taking it, under the assumption it
> makes keeping the out-of-tree driver for the draft interrupt controller easier,
> but I was wrong then it's probably out of order so I figured I'd check.

The last patch is for RISC-V AIA drivers I am working on.

The draft RISC-V AIA specification is available at:
http://www.jhauser.us/RISCV/riscv-interrupts-019.pdf

>
> Aside from that this generally LGTM.  We are making quite a bit of mess in
> here, but I don't really see a way around that as we need to support the old
> hardware.  We can always do a cleanup when the specifications settle down.

Not all RISC-V platforms will have a mechanism for direct IPI injection from
S-mode so to maintain backward compatibility for older platforms (where
IPI injection will be always through SBI calls) we have chosen the current
approach.

The RISC-V AIA spec is trying to solve this in a way which works for both
S-mode (or HS-mode) and VS-mode. The current RISC-V AIA plan is to
provide IPIs as software injected MSIs between HARTs and this will work
fine for Guest/VM as well.

>
> Oddly enough this did come up in IRC recently and there may be some new bits in
> the CLINT on the FU740 that allow S-mode SW interrupts to show up directly --
> there's at least a "delegate supervisor software interrupt" bit now, but the
> manual only calls out machine mode as being able to set it (though IIUC it's
> memory mapped, so not sure how that would be enforced).  Not saying we need
> that in order to take the last patch, but if it is possible it's probably worth
> giving it a shot when the boards show up.

Adding a few bits in CLINT will not be a complete solution because we also need
a mechanism where a Guest/VM can directly inject IPIs without SBI calls to the
hypervisor.

>
> > This series also a preparatory series for upcoming RISC-V advanced
> > interrupt architecture (AIA) support.
> >
> > These patches can be found in riscv_ipi_imp_v1 branch at
> > https://github.com/avpatel/linux
> >
> > Anup Patel (3):
> >   RISC-V: IPI provider should specify if we can use IPI for remote FENCE
> >   RISC-V: Use IPIs for remote TLB flush when possible
> >   RISC-V: Add handle_IPI_noregs() for irqchip drivers
> >
> >  arch/riscv/include/asm/smp.h      | 19 +++++++++-
> >  arch/riscv/kernel/sbi.c           |  2 +-
> >  arch/riscv/kernel/smp.c           | 30 +++++++++++----
> >  arch/riscv/mm/cacheflush.c        |  2 +-
> >  arch/riscv/mm/tlbflush.c          | 62 ++++++++++++++++++++++++-------
> >  drivers/clocksource/timer-clint.c |  2 +-
> >  6 files changed, 91 insertions(+), 26 deletions(-)

Regards,
Anup
