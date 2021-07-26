Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47963D5CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhGZObo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhGZObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:31:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99B2C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 08:12:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b9so10663215wrx.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEfxyBBsdqfeyLFZ2nbpK//+jCa1qE/9+zQ9LwwPbhQ=;
        b=H0hDtd3aCHUHBPDSloms35IgrhOF5ZtJrLGWMgoKlxm537RxzcsL1cQz8j97DDsHh9
         ba257rXMv+VCd4/qPOgFYNJLD5tuoWUBjtD6sPNOQALBupambb2XeVKk8ONsoeSfbHT8
         P0og8XIFWCRosGS0qbsF+IHvXILMCixoRzO/T9RqzuxSpCkiIkl0AQ+0BEWhxNPl9ooe
         zIyiJ1/swh7zXH7IE/GtocToTLAeZLfA2fmi2YZtTCR20VpKrQO9S4afpFoQHgp/OGXl
         zQ5uqrgZBrSXyRhgPl2HFBnkIiq1ONVTxN+RJ0GkiL6WB3NZz+wk2OG+msbmpicBJyPU
         xevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEfxyBBsdqfeyLFZ2nbpK//+jCa1qE/9+zQ9LwwPbhQ=;
        b=UMpLyFwzd3jzKWj6+1Zbb3N+qrw9/BVogeGm3FfJBrnYM2zRGb8wlxJmiajxPW18UP
         /cw6Hm3GYM5OiBozE+zjkUQHk31ZWunyfX6dt0jbaKyekrPRWQhDnY6RFJ+M748rvoHq
         Cqfmptv4aih6r/+XQqgjE8VxgH4kULWRE3WQ2GG9NLMXIms11Kd9hIQFb6x4qg/5VAO0
         dnn7f9P+hqmKjBMfLFCHDQAmVN/sA5qfDvKs2uesQpisbhJ0L3iIirOjBDQ+h8I1+L42
         EGAUCFZDVMRMhYiNoRB4/qMYUl32FJD4AFWlfQGdOOjxsGz3mYw5q86Cu1aQOxFXe4N2
         mgFg==
X-Gm-Message-State: AOAM533/z4Pm1w5VscHVwvt0+4rM+9BLXHAcdVIWru3SDh4xlpaivs+p
        ieGWvM1lwtgH5M4A2WgK6sgurjnQV77g4nCDh4Y2Ew==
X-Google-Smtp-Source: ABdhPJy2FXmilr8kKAcECuQtFjx9dz7AcFI/haY3JRbMnk74CbCDdgkdvTEDD0AbKksuMyT9HXc0AHbJKw8GCdi7V4k=
X-Received: by 2002:a5d:640f:: with SMTP id z15mr11915041wru.325.1627312330294;
 Mon, 26 Jul 2021 08:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210618123851.1344518-1-anup.patel@wdc.com> <CAAhSdy3E56j9XBfNr93AdW62mEx40F9F4-SYbNEFdkKA2BWRqA@mail.gmail.com>
 <87im0xdu2a.wl-maz@kernel.org>
In-Reply-To: <87im0xdu2a.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 26 Jul 2021 18:31:01 +0530
Message-ID: <CAAhSdy1rA9e2iCJWeVEQwKTRfTZZaRZVcMe1o8wMnFiWOOGW3w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] Linux RISC-V ACLINT Support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Jul 26, 2021 at 8:02 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 26 Jul 2021 13:45:20 +0100,
> Anup Patel <anup@brainfault.org> wrote:
> >
> > Hi Marc,
> >
> > I have taken the approach of IPI domains (like you suggested) in this series.
> >
> > What do you think ?
>
> I have commented on the irqchip driver.
>
> As for the RISC-V specific code, I'll let the architecture maintainers
> look into it. I guess the elephant in the room is that this spec seems
> to be evolving, and that there is no HW implementation (how this
> driver maps on SF's CLINT is anybody's guess).

The SiFive CLINT is a more convoluted device and provides M-level
timer functionality and M-level IPI functionality in one MMIO device.

The RISC-V ACLINT specification is more modular and backward
compatible with the SiFive CLINT. In fact, a SiFive CLINT device
can be viewed as a ACLINT MSWI device + ACLINT MTIMER device.
This means existing RISC-V boards having SiFive CLINT will be
automatically compliant to the RISC-V ACLINT specification.

Here's the RISC-V ACLINT spec:
https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc

The RISC-V ACLINT spec is quite stable and we are not seeing any
further changes hence I sent out RFC PATCHes to get feedback. The
RISC-V ACLINT spec will be frozen before 2021 end (i.e. before next
RISC-V summit).

The Linux NoMMU kernel (M-level) will use an ACLINT MSWI device
for IPI support whereas the regular Linux MMU kernel (S-level) will
use an ACLINT SSWI device for IPI support.

The ACLINT SWI driver is a common IPI driver for both ACLINT
MSWI (Linux NoMMU) and ACLINT SSWI (Linux MMU). In fact,
the ACLINT SWI also works for IPI part (i.e. MSWI) of SiFive CLINT.

Regards,
Anup

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
