Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9E23A4F1B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 15:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhFLNfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 09:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLNfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 09:35:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB318C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 06:33:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id w31so2305026pga.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3wRiFAQA4e7Yl+ksEnUziylD3jK+gtjCHkmYNeOuE6c=;
        b=kkOz4/i5zkzyVPTKWg39IK/HWEgMrL9zXxvikEQEVTtUod29kMfdGqcWoaDfyCMlYO
         OQQzJd/J0+23gs9/NKFipZlTk7Awviicwc2aCgNFt43XfQn/190dgYrIqE4v9IagCIOK
         AwylwXL6JLY1AEl3UQ4u0Q99u/mp6UnNG/CNKZn413JQi2HIOGBCeaH56eta+G5OswqZ
         5JGpJQ/oI3B+6RAGYxenCw1WINzPe1TCHScNqR2ORfJnSv88WyWJ7JRIB0HXnXVmJrpS
         147Dit7Bviiwba3DqlBce9NWwQ3PJEg7ZvZLOThgLuo+Y7j+yo///3L8hmCEShi06tkL
         /q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3wRiFAQA4e7Yl+ksEnUziylD3jK+gtjCHkmYNeOuE6c=;
        b=Tdae9SH1Bs3Kl5PIu8OCjOqo54+0jRNPuLVJ5GMzsanGJ3wBkMAn/SD5fZBmGtK7Xt
         q3SeUp6Nw3hQZdAW9bDJRdQCM4ugE1yKo8bqlsjtwN5PzAHV/JveSnmhuv/5yAEx1hrT
         CuLQCXEKQAek0YsZgScFbzUpuJgJGx6bLJb1MDlqrp5v4hFaPG1zfuxNIuxzowVS6QXN
         ZBFieiy4Hok5wEn87LpdBWJpVLp4PPTAHdMIlgSTZiQTe2Q1h5iR61PnJRuFXm41Of6K
         iW3/8mhzC7oH7T+PxpgTQDB9/OArWtu6TIuWfLNEtrbktvVXSRVYZ6sIR1Tku9YifHaV
         0XVQ==
X-Gm-Message-State: AOAM532u7hgwKgHe6fYY5RkYBbw89SbrvbcEjoarj6NVwmk9J9dGpVcU
        f7zJT41z2bLhW+4z+5tPMmiyYNGyVSQn3xrUa1w=
X-Google-Smtp-Source: ABdhPJzaXwq+agQL2AlHlBr3G1cfDRdHqcnICZBjnuHuO89La+HnzeFKLp339if3uODrOsoOoDvF9lUXeGMayXlPRYE=
X-Received: by 2002:a63:f815:: with SMTP id n21mr8634604pgh.2.1623504785601;
 Sat, 12 Jun 2021 06:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210612110014.GA1211@raspberrypi> <87eed7tk24.wl-maz@kernel.org>
In-Reply-To: <87eed7tk24.wl-maz@kernel.org>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Sat, 12 Jun 2021 22:32:54 +0900
Message-ID: <CADLLry7bYPYfqwQwWLtsXaAMG_deJ=TVVowAb5wtk_=AhTT64Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: vgic: declear local variable 'flags' before
 for loop starts
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=EB=85=84 6=EC=9B=94 12=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 8:10, M=
arc Zyngier <maz@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, 12 Jun 2021 12:00:14 +0100,
> Austin Kim <austindh.kim@gmail.com> wrote:
> >
> > From: Austin Kim <austin.kim@lge.com>
> >
> > Normally local variable 'flags' is defined out of for loop,
> > when 'flags' is used as the second parameter in a call to
> > spinlock_irq[save/restore] function.
> >
> > So it had better declear local variable 'flags' ahead of for loop.
>
> Why better? Reducing the scope of a variable is in general good
> practice. Do you see any material advantage in moving this variable
> out of the loop? Does the compiler generate better code?

First all of, thanks for feedback.

I checked how the compiler generate assembly code(before/after) using
objdump utility.
And then found out that compiler generates the same assembly code.

<compiler version: gcc-linaro-7.5.0-2019.12-x86_64_aarch64>

ffff80001005f5c8 <vgic_mmio_read_pending>:
ffff80001005f5c8:   d503233f    paciasp
...
ffff80001005f63c:   97ffe9af    bl  ffff800010059cf8 <vgic_get_irq>
ffff80001005f640:   aa0003f3    mov x19, x0
ffff80001005f644:   943886c3    bl  ffff800010e81150 <_raw_spin_lock_irqsav=
e>

Let me keep in mind how compiler generate assembly code with new patch,
which leads to material advantage.

BR,
Austin Kim

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
