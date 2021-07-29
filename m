Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562FC3D9CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 06:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhG2Ea3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 00:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbhG2EaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 00:30:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33840C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 21:30:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i10so5448702pla.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 21:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=r5qJLsWAEhPcHvajOIKkhTOz7l5fXoAdAbtdJ9zbKtk=;
        b=Q86TpW5I0znqVc+apP3BPb/AIu+ZMA7Y7RBJURS9q38hVOM5CB6KzIfy5NFXTmi2A2
         5OvecmcEubsVRmQJA7Qf+/gcM6S9x0MnhYuWtWkO4usV+lBskgriqJ0BEW3SQuaHH61X
         CSnYLol3lLvPAKivObS8tfJ/Gc70QVEnJqEz4wtfQrXED1yNBuDc+v5Wn5hmS2ZDyYuX
         vykBxBxLjRsFdpC4q/e4oIDDLLvqklQBHyAkV/SX71d+0Jro+i8hrU/KPZZbjX89MQdt
         w65N9mbpRg5uMPiCmAa9m46aRoMLdExB3v6VoCqHPU38QxjJ76ugMsEeaE3jhDMmHnv1
         WbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=r5qJLsWAEhPcHvajOIKkhTOz7l5fXoAdAbtdJ9zbKtk=;
        b=J55kdVxG3kk91im40q3N+aL4IhDtM3e4PAKnNaVF/sOri3vhzfC5bd3w386chGVaIQ
         ZZWjRK6kfmtQuPgBEkPF247a4Dh4AaZAVRd7E7ces2iL9bvyA8WAEcn5ASGvdepEGGJv
         Z9RpSSQPiCaT+NLG5jmTckVGUjjb/2x/YHd8bB+eeHOB0bPT8XTlzeZ7BWzVNVo56c4i
         BOc/hQQrKdPFLBNCnnwPlBb2b/i0qw+n8sKq72DLe1O7ywKsPqpkc9bM3NZnJlmnTWSz
         m6IJys0cEK56TLVsOhp1OmV1aMZaC+3z8f6yLLbJqje6T1RTvppzKVq5sUDTtD//a6Wm
         2MmA==
X-Gm-Message-State: AOAM531y7qeFyB9D5PGwy+ZEqRvwmvOmW9nxYZOGMVi50Kyaokz8LrOo
        24c2MNy31lC9nOnRdF90UOccrw==
X-Google-Smtp-Source: ABdhPJw3SvJQlvvPQ4XX9lqXTB2Eg+0Y5qeOAYr7uHk8BfoCC2cp0TE4CD8Kga1iRtVepSUFZ9yVYw==
X-Received: by 2002:a17:902:dacd:b029:12b:acab:b878 with SMTP id q13-20020a170902dacdb029012bacabb878mr2857505plx.4.1627533022446;
        Wed, 28 Jul 2021 21:30:22 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u188sm1720773pfc.115.2021.07.28.21.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 21:30:20 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:30:20 -0700 (PDT)
X-Google-Original-Date: Wed, 28 Jul 2021 20:38:34 PDT (-0700)
Subject:     Re: [RFC PATCH v2 00/11] Linux RISC-V ACLINT Support
In-Reply-To: <CAAhSdy1rA9e2iCJWeVEQwKTRfTZZaRZVcMe1o8wMnFiWOOGW3w@mail.gmail.com>
CC:     Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     anup@brainfault.org
Message-ID: <mhng-7fd3d454-cd80-4ede-baed-08003d66b3a4@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 06:01:01 PDT (-0700), anup@brainfault.org wrote:
> Hi Marc,
>
> On Mon, Jul 26, 2021 at 8:02 PM Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Mon, 26 Jul 2021 13:45:20 +0100,
>> Anup Patel <anup@brainfault.org> wrote:
>> >
>> > Hi Marc,
>> >
>> > I have taken the approach of IPI domains (like you suggested) in this series.
>> >
>> > What do you think ?
>>
>> I have commented on the irqchip driver.
>>
>> As for the RISC-V specific code, I'll let the architecture maintainers
>> look into it. I guess the elephant in the room is that this spec seems
>> to be evolving, and that there is no HW implementation (how this
>> driver maps on SF's CLINT is anybody's guess).

There's a long history of interrupt controller efforts from the RISC-V 
foundation, and we've yet to have any of them result in hardware.

> The SiFive CLINT is a more convoluted device and provides M-level
> timer functionality and M-level IPI functionality in one MMIO device.
>
> The RISC-V ACLINT specification is more modular and backward
> compatible with the SiFive CLINT. In fact, a SiFive CLINT device
> can be viewed as a ACLINT MSWI device + ACLINT MTIMER device.
> This means existing RISC-V boards having SiFive CLINT will be
> automatically compliant to the RISC-V ACLINT specification.

So is there any hardware that this new specification enables?  It seems 
to be a more convoluted way to describe the same mess we're already in.  
I'm not really inclined to take a bunch of code that just does the same 
thing via a more complicated specification.

> Here's the RISC-V ACLINT spec:
> https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
>
> The RISC-V ACLINT spec is quite stable and we are not seeing any
> further changes hence I sent out RFC PATCHes to get feedback. The
> RISC-V ACLINT spec will be frozen before 2021 end (i.e. before next
> RISC-V summit).

Have you talked to the other ISA folks about that?

As far as I can tell this new spec allows for multiple MTIME registers, 
which seems to be in direct contradiction to the single -MTIME register 
as defined in the ISA manual.  It also seems to be vaguely incompatible 
WRT the definition of SSIP, but I'm not sure that one really matters all 
that much as it's not like old software can write the new registers.

I just talked to Krste and Andrew, they say they haven't heard of any of 
this.  I don't know what's going on over there, but it's very hard to 
review anything when I can't even tell where the ISA is defined.

> The Linux NoMMU kernel (M-level) will use an ACLINT MSWI device
> for IPI support whereas the regular Linux MMU kernel (S-level) will
> use an ACLINT SSWI device for IPI support.
>
> The ACLINT SWI driver is a common IPI driver for both ACLINT
> MSWI (Linux NoMMU) and ACLINT SSWI (Linux MMU). In fact,
> the ACLINT SWI also works for IPI part (i.e. MSWI) of SiFive CLINT.
>
> Regards,
> Anup
>
>>
>>         M.
>>
>> --
>> Without deviation from the norm, progress is not possible.
